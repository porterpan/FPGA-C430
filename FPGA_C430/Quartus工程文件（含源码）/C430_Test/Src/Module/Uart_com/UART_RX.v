
//==============================================================================
// ��ģ��ΪUART �� RX ģ����Ʋ�Ӳ����������

`define UD #1

module UART_RX
		(
		SYSCLK,
		RST_B,

		UART_RX_I,
		UART_RX_DATA
		);
//==============================================================================
//	Input and output declaration
//==============================================================================
input		SYSCLK;		//ϵͳʱ��50MHz
input		RST_B;		//ȫ�ָ�λ�ź�

input		UART_RX_I;	//���ڵ� RX �����ߣ�����������ⲿ�Ĵ���������
output	[7:0]	UART_RX_DATA;	//�� RX �������н����������ݡ�

//==============================================================================
//	Wire and reg declaration
//==============================================================================
wire		SYSCLK;
wire		RST_B;

wire		UART_RX_I;
reg	[7:0]	UART_RX_DATA;

//==============================================================================
//	Wire and reg in the module
//==============================================================================

reg	[1:0]	START_REG;	//��¼ RX �Ŀ�ʼ����,����һ���½���
reg	[1:0]	START_REG_N;	//START_REG ����һ��״̬

reg	[12:0]	TIME_CNT;	//���ڼ���һ֡��������������ʱ��ļ�����
reg	[12:0]	TIME_CNT_N;	//TIME_CNT ����һ��״̬

reg	[7:0]	UART_RX_DATA_N;	//UART_RX_DATA ����һ��״̬

reg	[7:0]	UART_RX_SHIFT_REG;	//���մ������������õ�����λ�Ĵ���
reg	[7:0]	UART_RX_SHIFT_REG_N;	//UART_RX_SHIFT_REG ����һ��״̬

//==============================================================================
//	Logic
//==============================================================================
// һ����������֡������,8.68us X 11bit / ʱ������20ns = 12a6 (H)
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  TIME_CNT <= `UD 13'h0;
 else
  TIME_CNT <= `UD TIME_CNT_N;
end

always @ (*)
begin
 if(TIME_CNT == 13'h12a5) 
  TIME_CNT_N = 13'h0;
 else if(START_REG == 2'h2)
  TIME_CNT_N = TIME_CNT + 13'h1;
 else
  TIME_CNT_N = TIME_CNT;  
end
//------------------------------------------------------------------------------
//�����¼��һ����ʼ����󱣳֣�һ֡��������ʱ���ָ�Ϊ�ߵ�ƽ���ȴ���һ������
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  START_REG <= `UD 2'h3;
 else
  START_REG <= `UD START_REG_N;
end

always @ (*)
begin
 if(TIME_CNT == 13'h12a5)
  START_REG_N = 2'h3; 
 else if(START_REG == 2'h2)
  START_REG_N = START_REG;
 else  
  START_REG_N = {START_REG[0],UART_RX_I};
end
//------------------------------------------------------------------------------
//ÿһ������ʱ��㿪ʼ������λ�Ĵ�����¼���ݡ�
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  UART_RX_SHIFT_REG <= `UD 8'h0;
 else
  UART_RX_SHIFT_REG <= `UD UART_RX_SHIFT_REG_N;
end

always @ (*)
begin
 if((TIME_CNT == 16'h28A) || /*1.5 X 1B2*/ /*1.5 ������ΪҪ������һ����ʼλ*/
    (TIME_CNT == 16'h43C) || /*2.5 X 1B2*/
    (TIME_CNT == 16'h5EE) || /*3.5 X 1B2*/
    (TIME_CNT == 16'h7A0) || /*4.5 X 1B2*/
    (TIME_CNT == 16'h952) || /*5.5 X 1B2*/
    (TIME_CNT == 16'hB04) || /*6.5 X 1B2*/
    (TIME_CNT == 16'hCB6) || /*7.5 X 1B2*/
    (TIME_CNT == 16'hE68))   /*8.5 X 1B2*/
  UART_RX_SHIFT_REG_N = {UART_RX_I,UART_RX_SHIFT_REG[7:1]};//��λ����
 else
  UART_RX_SHIFT_REG_N = UART_RX_SHIFT_REG;   
end

//------------------------------------------------------------------------------
//һ֡���������ݼ�¼ʱ�䵽��Ϊ�ȶ������ݡ�
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  UART_RX_DATA <= `UD 8'h0;
 else
  UART_RX_DATA <= `UD UART_RX_DATA_N;
end

always @ (*)
begin
 if(TIME_CNT == 13'h12a5)
  UART_RX_DATA_N = UART_RX_SHIFT_REG;
 else
  UART_RX_DATA_N = UART_RX_DATA;
end

endmodule

//==============================================================================
//	End of file
//==============================================================================

