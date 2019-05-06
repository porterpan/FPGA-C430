
//==============================================================================
// �������ز㣬�Ӵ��ڴ�ӡ�� " hello world !"
// �Ӵ��ڳ����ն˴��ڽ����ַ�����ʾ���������
`define UD #1

module UART_TOP
		(
		SYSCLK,
		RST_B,

		UART_RX_I,
		UART_TX_O,
		
		uart_recdi	
		);
//==============================================================================
//	Input and output declaration
//==============================================================================
input		SYSCLK;		//ϵͳȫ��ʱ��
input		RST_B;		//ϵͳȫ�ָ�λ

input		UART_RX_I;
output		UART_TX_O;	//���͵��ⲿ����������

output	[7: 0]	uart_recdi;	

//==============================================================================
//	Wire and reg declaration
//==============================================================================
wire		SYSCLK;
wire		RST_B;

wire		UART_RX_I;
wire		UART_TX_O;

wire	[7: 0]	TUBE_SEL;
wire	[7: 0]	TUBE_DATA;

//==============================================================================
//	Wire and reg in the module
//==============================================================================
reg		START;		//����Ϊ����TXģ�鷢�͵Ŀ�ʼ����
reg		START_N;	//START ����һ��״̬

reg	[1:0]	TIME_CNT;	//TIME_CNT ���������ڼ���ÿλ������
wire	[1:0]	TIME_CNT_N;	//TIME_CNT ����һ��״̬

reg	[4:0]	BYTE_CNT;	//���ڼ���Ҫ���͵��ַ���
reg	[4:0]	BYTE_CNT_N;	//BYTE_CNT ����һ��״̬

reg	[7:0]	UART_TX_DATA;	//Ҫ���͵����ݷ�������
reg	[7:0]	UART_TX_DATA_N;	//UART_TX_DATA����һ��״̬

wire		TX_BUSY;	//��������UART_TX.v������״̬�ź�

wire	[7:0]	UART_RX_DATA;	//���յ��Ĵ���������ɵ�һ�������ֽ�

reg		RST_B_SYNC;

//------------------------------------------------------------------------------

assign uart_recdi[7:0] = UART_RX_DATA[7:0];



always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  RST_B_SYNC <= `UD 1'h0;
 else
  RST_B_SYNC <= `UD 1'h1;
end


always @ (posedge SYSCLK or negedge RST_B_SYNC)
begin
 if(!RST_B_SYNC)
  START <= `UD 1'h0;
 else
  START <= `UD START_N;
end

// ��� UART_TX ��æ��������ʼ���������
always @ (*)
begin
 if((!TX_BUSY) && (BYTE_CNT != 5'hf))
  START_N = 1'h1;
 else
  START_N = 1'h0;
end

//------------------------------------------------------------------------------

always @ (posedge SYSCLK or negedge RST_B_SYNC)
begin
 if(!RST_B_SYNC)
  BYTE_CNT <= `UD 5'h1F;
 else
  BYTE_CNT <= `UD BYTE_CNT_N;
end

// BYTE �������ü���Ҫ���͵����ݸ���
always @ (*)
begin
 if(BYTE_CNT == 5'hf)
  BYTE_CNT_N = BYTE_CNT;
 else if((!START) && (START_N))
  BYTE_CNT_N = BYTE_CNT + 5'h1;
 else
  BYTE_CNT_N = BYTE_CNT;
end

//==============================================================================
//	Logic
//==============================================================================
//����ʱҪ���ص��ַ���ASCII
always @ (posedge SYSCLK or negedge RST_B_SYNC)
begin
 if(!RST_B_SYNC)
  UART_TX_DATA <= `UD 8'hff;
 else
  UART_TX_DATA <= `UD UART_TX_DATA_N;
end

//���淢�͵��˿�: "hello world !", ͨ�������ն˿��Կ��õ�
always @ (*)
begin
 case (BYTE_CNT) 
  5'h0 : UART_TX_DATA_N = 8'h20;	//space
  
  5'h1 : UART_TX_DATA_N = 8'h68;	//h
  5'h2 : UART_TX_DATA_N = 8'h65;	//e
  5'h3 : UART_TX_DATA_N = 8'h6c;	//l  
  5'h4 : UART_TX_DATA_N = 8'h6c;	//l
  5'h5 : UART_TX_DATA_N = 8'h6f;	//o  
  
  5'h6 : UART_TX_DATA_N = 8'h20;	//space
  
  5'h7 : UART_TX_DATA_N = 8'h77;	//w  
  5'h8 : UART_TX_DATA_N = 8'h6f; 	//o 
  5'h9 : UART_TX_DATA_N = 8'h72; 	//r
  5'ha : UART_TX_DATA_N = 8'h6c;	//l
  5'hb : UART_TX_DATA_N = 8'h64;	//d

  5'hc : UART_TX_DATA_N = 8'h20;	//space  
  5'hd : UART_TX_DATA_N = 8'h21;	//!  
  
  5'he : UART_TX_DATA_N = 8'hd;		//LF 
  5'hf : UART_TX_DATA_N = 8'ha;		//CR  
  default :  UART_TX_DATA_N = UART_TX_DATA;
 endcase
end

//Instance DUT
//�������ڷ���ģ��
UART_TX	I_UART_TX
	(
        .SYSCLK		(SYSCLK		),
        .RST_B		(RST_B_SYNC		),		

        .START		(START		),
        .UART_TX_DATA	(UART_TX_DATA	),
	.UART_TX_O	(UART_TX_O	),
	.TX_BUSY	(TX_BUSY	)
	);

//�������ڽ���ģ��,�����͵��ź���ֱ�����뵽 UART_RX_I ��
//��ɽ���
UART_RX	I_UART_RX
	(
        .SYSCLK		(SYSCLK		),
        .RST_B		(RST_B_SYNC		),		

//������һ����ʹ��Modelsim����ʱ�ɽ�TX�����ݽӵ�RX�У������漤���źŵĲ���	
        //.UART_RX_I	(UART_TX_O	),
        
        .UART_RX_I	(UART_RX_I	),
        
        .UART_RX_DATA	(UART_RX_DATA	)
	);	





endmodule

//==============================================================================
//	End of file
//==============================================================================

