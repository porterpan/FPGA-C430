
//==============================================================================
// 此模块为UART 的 TX 模块控制层硬件描述代码

`define UD #1

module UART_TX
		(
		SYSCLK,
		RST_B,

		START,
		UART_TX_DATA,
		UART_TX_O,

		TX_BUSY
		);
//==============================================================================
//	Input and output declaration
//==============================================================================
input		SYSCLK;		//系统时钟50MHz
input		RST_B;		//全局复位信号

input		START;		//由主控层发来的启动发送的脉冲
input	[7:0]	UART_TX_DATA;	//主控层传来的需要发送的数据
output		UART_TX_O;	//串口的串行输出数据线，TX

output		TX_BUSY;	//控制层返回给主控层的"忙信号"，1 表示正在发送中

//==============================================================================
//	Wire and reg declaration
//==============================================================================
wire		SYSCLK;
wire		RST_B;

wire		START;
wire	[7:0]	UART_TX_DATA;
reg		UART_TX_O;

reg		TX_BUSY;

//==============================================================================
//	Wire and reg in the module
//==============================================================================
reg	[8:0]	TIME_CNT;	//系统时钟计数器，根据波特率计算每一位的时间
reg	[8:0]	TIME_CNT_N;	//TIME_CNT 的下一个状态

reg	[3:0]	BIT_CNT;	//位计数器，在状态机中用来控制每个状态停留的时间
reg	[3:0]	BIT_CNT_N;	//BIT_CNT 的下一个状态

reg	[10:0]	SHIFT_DATA;	//输出移位寄存器，加上起始、校验、停止位共11位
reg	[10:0]	SHIFT_DATA_N;	//SHIFT_DATA 的下一个状态

reg	[2:0]	UART_TX_CS;	//发送状态机的当前状态
reg	[2:0]	UART_TX_NS;	//发送状态机的下一下状态

reg		UART_TX_O_N;	//UART_TX_O 的下一个状态

reg		TX_BUSY_N;	//TX_BUSY 的下一个状态
reg	[1:0]	START_REG;	//记录发送脉冲的边沿变化

reg		PARITY_CNT;
reg		PARITY_CNT_N;
//------------------------------------------------------------------------------

parameter	IDLE		= 3'h0;	//状态机空闲状态
parameter	SEND_START	= 3'h1;	//状态机发送开始码的状态
parameter	SEND_DATA	= 3'h2;	//状态机发送8位数据的状态
parameter	SEND_PARITY	= 3'h3;	//状态机发送校验位的状态
parameter	SEND_STOP	= 3'h4;	//状态机发送停止位的状态
parameter	FINISH		= 3'h5;	//状态机的结束状态

//==============================================================================
//	Logic
//==============================================================================

always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  PARITY_CNT <= `UD 1'h0;
 else
  PARITY_CNT <= `UD PARITY_CNT_N;
end

// 奇偶校验位的产生，PARITY_CNT 为1 时，数据中1的个数为奇数，该位将在发送校验位时
// 发送出去。计算过程是独立的，属于并行的流水线架构。

always @ (*)
begin
  if(UART_TX_CS == IDLE)
   PARITY_CNT_N = 1'h0;
  else if((TIME_CNT == 9'h0) && (UART_TX_CS == SEND_DATA))
   PARITY_CNT_N = PARITY_CNT + SHIFT_DATA[0];
  else
   PARITY_CNT_N = PARITY_CNT;
end

//------------------------------------------------------------------------------
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  START_REG <= `UD 2'h0;
 else
  START_REG <= `UD {START_REG[0],START};
end

//------------------------------------------------------------------------------
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  TX_BUSY <= `UD 1'h0;//0 -> IDLE ,1->BUSY
 else
  TX_BUSY <= `UD TX_BUSY_N;
end

//BUSY 信号为忙时，是状态机不为 IDLE 的所有状态
always @ (*)
begin
 if(UART_TX_CS == IDLE)
  TX_BUSY_N = 1'h0;
 else
  TX_BUSY_N = 1'h1;
end

//------------------------------------------------------------------------------

always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  TIME_CNT <= `UD 9'h0;
 else
  TIME_CNT <= `UD TIME_CNT_N;
end

// 波特率率为115200 ,每一位的周期是8.68us, 计数值为，9'h1b2
// 这里计数范围为 0 ~ 9'h1b1
always @ (*)
begin
 if(TIME_CNT == 9'h1B1)
  TIME_CNT_N = 9'h0;
//不为IDLE时才会发数据，也才需要计数器计数
 else if(UART_TX_CS != IDLE)
  TIME_CNT_N = TIME_CNT + 9'h1;
 else
  TIME_CNT_N = TIME_CNT;
end
//------------------------------------------------------------------------------
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  SHIFT_DATA <= `UD 11'h0;
 else
  SHIFT_DATA <= `UD SHIFT_DATA_N;
end

always @ (*)
begin
//在发数据状态的第一时刻把要发送的11位数据先加载进来。
 if((TIME_CNT == 9'h0) && (UART_TX_CS == SEND_START))
  SHIFT_DATA_N = {1'b1,1'b1,UART_TX_DATA[7:0],1'b0};
//TIME_CNT 每一次为0时，就需要移出一位数据到TX线上
 else if(TIME_CNT == 9'h0)
  SHIFT_DATA_N = {1'b1,SHIFT_DATA[10:1]};
 else
  SHIFT_DATA_N = SHIFT_DATA;
end

//------------------------------------------------------------------------------
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  BIT_CNT <= `UD 4'h0;
 else
  BIT_CNT <= `UD BIT_CNT_N;
end

always @ (*)
begin
 //每次状态机状态发生变化时，计数器重新清0，为下一次从0开始计数做准备
 if(UART_TX_CS != UART_TX_NS)
  BIT_CNT_N = 4'h0;
 //BIT_CNT 是对TIME_CNT的计数周期进行计数
 else if(TIME_CNT == 9'h1B1)
  BIT_CNT_N = BIT_CNT + 4'h1;
 else
  BIT_CNT_N = BIT_CNT;
end
//------------------------------------------------------------------------------
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  UART_TX_O = 1'b1;
 else
  UART_TX_O = UART_TX_O_N;
end

//TX信号在发送过程中始终等于移位寄存器的0位，TX是低位先发，其它状态时保持高电平
//在发送到检验位的状态时，把TX切换到校验位上。
always @ (*)
begin
 if((UART_TX_CS == IDLE) || (UART_TX_CS == FINISH))
  UART_TX_O_N = 1'b1;
 else if(UART_TX_CS == SEND_PARITY)
  UART_TX_O_N = PARITY_CNT;
 else
  UART_TX_O_N = SHIFT_DATA[0];
end

//------------------------------------------------------------------------------
// 发送流程控制的核心状态机
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  UART_TX_CS <= `UD IDLE;
 else
  UART_TX_CS <= `UD UART_TX_NS;
end

always @ (*)
begin
 case(UART_TX_CS)

 IDLE		:
  if(START_REG)
   UART_TX_NS = SEND_START;
  else
   UART_TX_NS = UART_TX_CS;

 SEND_START	:
  //发送状态必须保持完整的计数周期，每一位的时间严格保证
  if((BIT_CNT == 4'h0) && (TIME_CNT == 9'h1B1))
   UART_TX_NS = SEND_DATA;
  else
   UART_TX_NS = UART_TX_CS;   
   
 SEND_DATA	:
  if((BIT_CNT == 4'h7) && (TIME_CNT == 9'h1B1))
   UART_TX_NS = SEND_PARITY;
  else
   UART_TX_NS = UART_TX_CS;

 SEND_PARITY	:
  if((BIT_CNT == 4'h0) && (TIME_CNT == 9'h1B1))
   UART_TX_NS = SEND_STOP;
  else
   UART_TX_NS = UART_TX_CS;

 SEND_STOP	:
  if((BIT_CNT == 4'h0) && (TIME_CNT == 9'h1B1))
   UART_TX_NS = FINISH;
  else
   UART_TX_NS = UART_TX_CS;

 FINISH		: 
  if((BIT_CNT == 4'h0) && (TIME_CNT == 9'h1B1))
   UART_TX_NS = IDLE;
  else
   UART_TX_NS = UART_TX_CS;

 default	:	
   UART_TX_NS = IDLE;
 	
 endcase
 
end


endmodule

//==============================================================================
//	End of file
//==============================================================================

