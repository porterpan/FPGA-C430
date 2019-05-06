
//==============================================================================
// ��ģ��ΪUART �� TX ģ����Ʋ�Ӳ����������

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
input		SYSCLK;		//ϵͳʱ��50MHz
input		RST_B;		//ȫ�ָ�λ�ź�

input		START;		//�����ز㷢�����������͵�����
input	[7:0]	UART_TX_DATA;	//���ز㴫������Ҫ���͵�����
output		UART_TX_O;	//���ڵĴ�����������ߣ�TX

output		TX_BUSY;	//���Ʋ㷵�ظ����ز��"æ�ź�"��1 ��ʾ���ڷ�����

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
reg	[8:0]	TIME_CNT;	//ϵͳʱ�Ӽ����������ݲ����ʼ���ÿһλ��ʱ��
reg	[8:0]	TIME_CNT_N;	//TIME_CNT ����һ��״̬

reg	[3:0]	BIT_CNT;	//λ����������״̬������������ÿ��״̬ͣ����ʱ��
reg	[3:0]	BIT_CNT_N;	//BIT_CNT ����һ��״̬

reg	[10:0]	SHIFT_DATA;	//�����λ�Ĵ�����������ʼ��У�顢ֹͣλ��11λ
reg	[10:0]	SHIFT_DATA_N;	//SHIFT_DATA ����һ��״̬

reg	[2:0]	UART_TX_CS;	//����״̬���ĵ�ǰ״̬
reg	[2:0]	UART_TX_NS;	//����״̬������һ��״̬

reg		UART_TX_O_N;	//UART_TX_O ����һ��״̬

reg		TX_BUSY_N;	//TX_BUSY ����һ��״̬
reg	[1:0]	START_REG;	//��¼��������ı��ر仯

reg		PARITY_CNT;
reg		PARITY_CNT_N;
//------------------------------------------------------------------------------

parameter	IDLE		= 3'h0;	//״̬������״̬
parameter	SEND_START	= 3'h1;	//״̬�����Ϳ�ʼ���״̬
parameter	SEND_DATA	= 3'h2;	//״̬������8λ���ݵ�״̬
parameter	SEND_PARITY	= 3'h3;	//״̬������У��λ��״̬
parameter	SEND_STOP	= 3'h4;	//״̬������ֹͣλ��״̬
parameter	FINISH		= 3'h5;	//״̬���Ľ���״̬

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

// ��żУ��λ�Ĳ�����PARITY_CNT Ϊ1 ʱ��������1�ĸ���Ϊ��������λ���ڷ���У��λʱ
// ���ͳ�ȥ����������Ƕ����ģ����ڲ��е���ˮ�߼ܹ���

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

//BUSY �ź�Ϊæʱ����״̬����Ϊ IDLE ������״̬
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

// ��������Ϊ115200 ,ÿһλ��������8.68us, ����ֵΪ��9'h1b2
// ���������ΧΪ 0 ~ 9'h1b1
always @ (*)
begin
 if(TIME_CNT == 9'h1B1)
  TIME_CNT_N = 9'h0;
//��ΪIDLEʱ�Żᷢ���ݣ�Ҳ����Ҫ����������
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
//�ڷ�����״̬�ĵ�һʱ�̰�Ҫ���͵�11λ�����ȼ��ؽ�����
 if((TIME_CNT == 9'h0) && (UART_TX_CS == SEND_START))
  SHIFT_DATA_N = {1'b1,1'b1,UART_TX_DATA[7:0],1'b0};
//TIME_CNT ÿһ��Ϊ0ʱ������Ҫ�Ƴ�һλ���ݵ�TX����
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
 //ÿ��״̬��״̬�����仯ʱ��������������0��Ϊ��һ�δ�0��ʼ������׼��
 if(UART_TX_CS != UART_TX_NS)
  BIT_CNT_N = 4'h0;
 //BIT_CNT �Ƕ�TIME_CNT�ļ������ڽ��м���
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

//TX�ź��ڷ��͹�����ʼ�յ�����λ�Ĵ�����0λ��TX�ǵ�λ�ȷ�������״̬ʱ���ָߵ�ƽ
//�ڷ��͵�����λ��״̬ʱ����TX�л���У��λ�ϡ�
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
// �������̿��Ƶĺ���״̬��
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
  //����״̬���뱣�������ļ������ڣ�ÿһλ��ʱ���ϸ�֤
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

