
`timescale 1ns / 1ps

module DS1302_CTL
		(
		rstn,
		clk50M,

		OP_RTC_START,
		OP_WR,			
		OP_ADDR,
	    	           
		rtc_rstn,             
		rtc_clk,  
		rtc_dat,

		DATA_W,              
		DATA_R,

		RTC_BUSY
		);
//==============================================================================
//	Input and output declaration
//==============================================================================
input		rstn;		//主复位信号，低有效
input		clk50M;		//系统时钟，50MHz

input		OP_RTC_START;	//主控器发来的启动脉冲，单脉冲启动
input		OP_WR;		//主控器发来的读/写指示信号，电平有效
input	[7:0]	OP_ADDR;	//主控器发来的读或写寄存器对应的操作地址
      	           
output		rtc_rstn;	//DS1302Z SPI总线的RST信号            
output		rtc_clk;	//DS1302Z SPI总线的CLK信号 
inout		rtc_dat;		//DS1302Z SPI总线的IO信号,双向三态信号

input	[7:0]	DATA_W;		//主控器传来的要写到DS1302的数据
output	[7:0]	DATA_R;		//主控器从这里读回从DS1302返回的数据

output		RTC_BUSY;	//返回给主控器的握手信号，低表示状态"忙"
                                                
//==============================================================================
//	Wire and reg declaration
//==============================================================================
wire		rstn;
wire		clk50M;

wire		OP_RTC_START;	
wire		OP_WR;		
wire	[7:0]	OP_ADDR;	 
     	           
wire		rtc_rstn;             
reg		rtc_clk; 
wire		rtc_dat;

wire	[7:0]	DATA_W;
reg	[7:0]	DATA_R;

reg		RTC_BUSY;

//==============================================================================
//	Wire and reg in the module
//==============================================================================
          
reg		RTC_CLK_N;	//DS1302Z SPI总线的CLK信号的下一个状态

reg	[6:0]	TIME_CNT;	//模块中用到的计数器TIME_CNT
reg	[6:0]	TIME_CNT_N;	//模块中用到的计数器TIME_CNT的下一个状态

reg	[3:0]	BIT_CNT;	//模块中用到的位计数器BIT_CNT
reg	[3:0]	BIT_CNT_N;	//模块中用到的位计数器BIT_CNT的下一个状态

reg	[2:0]	SM_RTC_CS;	//模块中用的的状态机的当前状态
reg	[2:0]	SM_RTC_NS;	//模块中用的的状态机的下一个状态

reg	[7:0]	SHIFT_REG_W;	//写入DS1302Z对应的写移位寄存器
reg	[7:0]	SHIFT_REG_R;	//从DS1302Z读数据对应的读移位寄存器       

reg	[7:0]	SHIFT_REG_W_N;	//SHIFT_REG_W的下一个状态
reg	[7:0]	SHIFT_REG_R_N;	//SHIFT_REG_R的下一个状态

reg		RTC_BUSY_N;	//RTC_BUSY的下一个状态

reg	[7:0]	DATA_R_N;	//DATA_R的下一个状态	
//==============================================================================
//	Macro definition
//==============================================================================

parameter	IDLE		= 3'h0;	//状态机的空闲状态
parameter	SEND_ADDR	= 3'h1;	//状态机的发地址状态
parameter	SEND_DATA	= 3'h2;	//状态机的发数据状态
parameter	READ_DATA	= 3'h3;	//状态机的读数据状态
parameter	FINISHED 	= 3'h4;	//状态机操作完成状态
//==============================================================================
//	Logic
//==============================================================================
//RTC_IO是一个双向三态信号，
//在状态机处于读数据状态时，RTC_IO 为高阻态，此时IO由
//DS1302Z来驱动，数据传输方向 : DS1302Z --> FPGA
//状态机处于其它状态时，RTC_IO 为输出状态，数据传输方向 : FPGA --> DS1302Z
assign rtc_dat	=  ( SM_RTC_CS == READ_DATA) ? 1'bz : SHIFT_REG_W[0];

//除 IDLE 或者 FINISHED 状态时，RST信号才为有效状态，高有效，请看芯片手册
assign rtc_rstn	= ~((SM_RTC_CS == IDLE) || (SM_RTC_CS == FINISHED));

//==============================================================================
always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  DATA_R <= `UD 8'h0;
 else
  DATA_R <= `UD DATA_R_N;
end

always @ (*)
begin
 if(SM_RTC_CS == FINISHED)//当状态为 FINISHED 时，此时就可以从移位寄存器读数据了。
  DATA_R_N = SHIFT_REG_R;
 else
  DATA_R_N = DATA_R;
end

//==============================================================================

always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  RTC_BUSY <= `UD 1'h1;
 else
  RTC_BUSY <= `UD RTC_BUSY_N;
end

always @ (*)
begin
  RTC_BUSY_N = (SM_RTC_CS == IDLE);//当状态为 IDLE，告诉主控器可以开始下一次操作
end

//------------------------------------------------------------------------------
always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  SHIFT_REG_W <= `UD 8'h0;
 else
  SHIFT_REG_W <= `UD SHIFT_REG_W_N;
end

always @ (*)
begin
 if((SM_RTC_CS == IDLE) && (OP_WR))	 //为读数据提前载入对应的地址，最后一位为1
  SHIFT_REG_W_N = {OP_ADDR[7:1],1'b1};
 else if((SM_RTC_CS == IDLE) && (!OP_WR))//为写数据提前载入对应的地址，最后一位为0
  SHIFT_REG_W_N = {OP_ADDR[7:1],1'b0};
 //如果是向DS1302写数据，这里就要载入要写入的数据，最后写到OP_ADDR的地址中
 else if((SM_RTC_CS == SEND_ADDR) && (SM_RTC_NS == SEND_DATA))
  SHIFT_REG_W_N = DATA_W;		
 //配合RTC_CLK的下降沿把数据逐位移出到DS1302的IO上 
 else if(rtc_clk && (!RTC_CLK_N))	
  SHIFT_REG_W_N = {1'b0,SHIFT_REG_W[7:1]};
 //保持
 else
  SHIFT_REG_W_N = SHIFT_REG_W;
end

always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  SHIFT_REG_R <= `UD 8'h0;
 else
  SHIFT_REG_R <= `UD SHIFT_REG_R_N;
end

always @ (*)
begin
 //在读模式下，在RTC_CLK的每一个上升沿把DS1302 IO上的数据逐位移入到SHIFT_REG_R
 if((SM_RTC_CS == READ_DATA) && (!rtc_clk) && (RTC_CLK_N))
  SHIFT_REG_R_N = {rtc_dat,SHIFT_REG_R[7:1]};
 else
  SHIFT_REG_R_N = SHIFT_REG_R;
end
//------------------------------------------------------------------------------
always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  TIME_CNT <= `UD 7'h0;
 else
  TIME_CNT <= `UD TIME_CNT_N;
end

always @ (*)
begin
 //由于DS1302Z 的操作速度与对应的电压有关系，5V供电时才能达到2MHz的速度，2V供电时
 //最高为0.5MHz, 我们这里是按0.5MHz来计算的，如果你要达到2MHz, 只需改一下TIME_CNT
 //的计数值
 if(SM_RTC_CS == IDLE)
  TIME_CNT_N = 7'h0; 
 else if(TIME_CNT == 7'h64)//(50MHz / 100) = 0.5MHz 
  TIME_CNT_N = 7'h0;
 else
  TIME_CNT_N = TIME_CNT + 7'h1;
end
//------------------------------------------------------------------------------
always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  BIT_CNT <= `UD 4'h0;
 else
  BIT_CNT <= `UD BIT_CNT_N;
end

always @ (*)
begin
 if(SM_RTC_CS == IDLE)
  BIT_CNT_N = 4'h0;
 //状态机的每一次状态发生变化，此计数器就重新清0，目的是为了可以控制在每个状态里
 //停留的时间
 else if(SM_RTC_CS != SM_RTC_NS)
  BIT_CNT_N = 4'h0;
 else if(TIME_CNT == 7'h64)
  BIT_CNT_N = BIT_CNT + 4'h1;
 else
  BIT_CNT_N = BIT_CNT;
end

//------------------------------------------------------------------------------
always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  rtc_clk <= `UD 1'h0;
 else
  rtc_clk <= `UD RTC_CLK_N;
end

//RTC_CLK的频率是在TIME_CNT计数周期内完成一次翻转
always @ (*)
begin
 if(TIME_CNT == 7'h32)
  RTC_CLK_N = 1'h1;
 else if(TIME_CNT == 7'h64)
  RTC_CLK_N = 1'h0;
 else
  RTC_CLK_N = rtc_clk;
end

//------------------------------------------------------------------------------
always @ (posedge clk50M or negedge rstn)
begin
 if(!rstn)
  SM_RTC_CS <= `UD IDLE;
 else
  SM_RTC_CS <= `UD SM_RTC_NS;
end

always @ (*)
begin
 case(SM_RTC_CS)
 IDLE :
	if(OP_RTC_START)//等待主控器的启动脉冲来启动DS1302的读写
 	 SM_RTC_NS = SEND_ADDR;
	else
 	 SM_RTC_NS = SM_RTC_CS;

 SEND_ADDR:
 	if((BIT_CNT == 4'h7) && (!OP_WR) && (TIME_CNT == 7'h64))
 	 SM_RTC_NS = SEND_DATA;
 	else if((BIT_CNT == 4'h7) && (OP_WR) && (TIME_CNT == 7'h64)) 	
 	 SM_RTC_NS = READ_DATA;
 	else
 	 SM_RTC_NS = SM_RTC_CS;

 SEND_DATA:
 	if((BIT_CNT == 4'h7) && (TIME_CNT == 7'h64))
 	 SM_RTC_NS = FINISHED;
 	else
 	 SM_RTC_NS = SM_RTC_CS; 	 

 READ_DATA:
 	if((BIT_CNT == 4'h7) && (TIME_CNT == 7'h64))
 	 SM_RTC_NS = FINISHED;
 	else
 	 SM_RTC_NS = SM_RTC_CS;

 FINISHED:
	 if((BIT_CNT == 4'h2) && (TIME_CNT == 7'h64))
	  SM_RTC_NS = IDLE;
	 else
 	  SM_RTC_NS = SM_RTC_CS;
	 
 default : 
	 SM_RTC_NS = IDLE;
 endcase
end
//------------------------------------------------------------------------------
endmodule

//==============================================================================
//	End of file
//==============================================================================


