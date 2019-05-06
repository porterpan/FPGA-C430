
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
input		rstn;		//����λ�źţ�����Ч
input		clk50M;		//ϵͳʱ�ӣ�50MHz

input		OP_RTC_START;	//�������������������壬����������
input		OP_WR;		//�����������Ķ�/дָʾ�źţ���ƽ��Ч
input	[7:0]	OP_ADDR;	//�����������Ķ���д�Ĵ�����Ӧ�Ĳ�����ַ
      	           
output		rtc_rstn;	//DS1302Z SPI���ߵ�RST�ź�            
output		rtc_clk;	//DS1302Z SPI���ߵ�CLK�ź� 
inout		rtc_dat;		//DS1302Z SPI���ߵ�IO�ź�,˫����̬�ź�

input	[7:0]	DATA_W;		//������������Ҫд��DS1302������
output	[7:0]	DATA_R;		//��������������ش�DS1302���ص�����

output		RTC_BUSY;	//���ظ��������������źţ��ͱ�ʾ״̬"æ"
                                                
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
          
reg		RTC_CLK_N;	//DS1302Z SPI���ߵ�CLK�źŵ���һ��״̬

reg	[6:0]	TIME_CNT;	//ģ�����õ��ļ�����TIME_CNT
reg	[6:0]	TIME_CNT_N;	//ģ�����õ��ļ�����TIME_CNT����һ��״̬

reg	[3:0]	BIT_CNT;	//ģ�����õ���λ������BIT_CNT
reg	[3:0]	BIT_CNT_N;	//ģ�����õ���λ������BIT_CNT����һ��״̬

reg	[2:0]	SM_RTC_CS;	//ģ�����õĵ�״̬���ĵ�ǰ״̬
reg	[2:0]	SM_RTC_NS;	//ģ�����õĵ�״̬������һ��״̬

reg	[7:0]	SHIFT_REG_W;	//д��DS1302Z��Ӧ��д��λ�Ĵ���
reg	[7:0]	SHIFT_REG_R;	//��DS1302Z�����ݶ�Ӧ�Ķ���λ�Ĵ���       

reg	[7:0]	SHIFT_REG_W_N;	//SHIFT_REG_W����һ��״̬
reg	[7:0]	SHIFT_REG_R_N;	//SHIFT_REG_R����һ��״̬

reg		RTC_BUSY_N;	//RTC_BUSY����һ��״̬

reg	[7:0]	DATA_R_N;	//DATA_R����һ��״̬	
//==============================================================================
//	Macro definition
//==============================================================================

parameter	IDLE		= 3'h0;	//״̬���Ŀ���״̬
parameter	SEND_ADDR	= 3'h1;	//״̬���ķ���ַ״̬
parameter	SEND_DATA	= 3'h2;	//״̬���ķ�����״̬
parameter	READ_DATA	= 3'h3;	//״̬���Ķ�����״̬
parameter	FINISHED 	= 3'h4;	//״̬���������״̬
//==============================================================================
//	Logic
//==============================================================================
//RTC_IO��һ��˫����̬�źţ�
//��״̬�����ڶ�����״̬ʱ��RTC_IO Ϊ����̬����ʱIO��
//DS1302Z�����������ݴ��䷽�� : DS1302Z --> FPGA
//״̬����������״̬ʱ��RTC_IO Ϊ���״̬�����ݴ��䷽�� : FPGA --> DS1302Z
assign rtc_dat	=  ( SM_RTC_CS == READ_DATA) ? 1'bz : SHIFT_REG_W[0];

//�� IDLE ���� FINISHED ״̬ʱ��RST�źŲ�Ϊ��Ч״̬������Ч���뿴оƬ�ֲ�
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
 if(SM_RTC_CS == FINISHED)//��״̬Ϊ FINISHED ʱ����ʱ�Ϳ��Դ���λ�Ĵ����������ˡ�
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
  RTC_BUSY_N = (SM_RTC_CS == IDLE);//��״̬Ϊ IDLE���������������Կ�ʼ��һ�β���
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
 if((SM_RTC_CS == IDLE) && (OP_WR))	 //Ϊ��������ǰ�����Ӧ�ĵ�ַ�����һλΪ1
  SHIFT_REG_W_N = {OP_ADDR[7:1],1'b1};
 else if((SM_RTC_CS == IDLE) && (!OP_WR))//Ϊд������ǰ�����Ӧ�ĵ�ַ�����һλΪ0
  SHIFT_REG_W_N = {OP_ADDR[7:1],1'b0};
 //�������DS1302д���ݣ������Ҫ����Ҫд������ݣ����д��OP_ADDR�ĵ�ַ��
 else if((SM_RTC_CS == SEND_ADDR) && (SM_RTC_NS == SEND_DATA))
  SHIFT_REG_W_N = DATA_W;		
 //���RTC_CLK���½��ذ�������λ�Ƴ���DS1302��IO�� 
 else if(rtc_clk && (!RTC_CLK_N))	
  SHIFT_REG_W_N = {1'b0,SHIFT_REG_W[7:1]};
 //����
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
 //�ڶ�ģʽ�£���RTC_CLK��ÿһ�������ذ�DS1302 IO�ϵ�������λ���뵽SHIFT_REG_R
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
 //����DS1302Z �Ĳ����ٶ����Ӧ�ĵ�ѹ�й�ϵ��5V����ʱ���ܴﵽ2MHz���ٶȣ�2V����ʱ
 //���Ϊ0.5MHz, ���������ǰ�0.5MHz������ģ������Ҫ�ﵽ2MHz, ֻ���һ��TIME_CNT
 //�ļ���ֵ
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
 //״̬����ÿһ��״̬�����仯���˼�������������0��Ŀ����Ϊ�˿��Կ�����ÿ��״̬��
 //ͣ����ʱ��
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

//RTC_CLK��Ƶ������TIME_CNT�������������һ�η�ת
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
	if(OP_RTC_START)//�ȴ�����������������������DS1302�Ķ�д
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


