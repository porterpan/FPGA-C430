
//==============================================================================
// 串口主控层，从串口打印出 " hello world !"
// 从串口超级终端窗口接收字符并显示在数码管上
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
input		SYSCLK;		//系统全局时钟
input		RST_B;		//系统全局复位

input		UART_RX_I;
output		UART_TX_O;	//发送到外部的数据总线

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
reg		START;		//定义为启动TX模块发送的开始脉冲
reg		START_N;	//START 的下一个状态

reg	[1:0]	TIME_CNT;	//TIME_CNT 计数器用于计数每位的周期
wire	[1:0]	TIME_CNT_N;	//TIME_CNT 的下一下状态

reg	[4:0]	BYTE_CNT;	//用于计数要发送的字符数
reg	[4:0]	BYTE_CNT_N;	//BYTE_CNT 的下一个状态

reg	[7:0]	UART_TX_DATA;	//要发送的数据放在这里
reg	[7:0]	UART_TX_DATA_N;	//UART_TX_DATA的下一个状态

wire		TX_BUSY;	//接收来自UART_TX.v的握手状态信号

wire	[7:0]	UART_RX_DATA;	//接收到的串行数据组成的一个完整字节

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

// 如果 UART_TX 不忙就启动开始命令发送数据
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

// BYTE 计数器用计数要发送的数据个数
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
//发送时要加载的字符的ASCII
always @ (posedge SYSCLK or negedge RST_B_SYNC)
begin
 if(!RST_B_SYNC)
  UART_TX_DATA <= `UD 8'hff;
 else
  UART_TX_DATA <= `UD UART_TX_DATA_N;
end

//下面发送到端口: "hello world !", 通过超级终端可以看得到
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
//例化串口发送模块
UART_TX	I_UART_TX
	(
        .SYSCLK		(SYSCLK		),
        .RST_B		(RST_B_SYNC		),		

        .START		(START		),
        .UART_TX_DATA	(UART_TX_DATA	),
	.UART_TX_O	(UART_TX_O	),
	.TX_BUSY	(TX_BUSY	)
	);

//例化串口接收模块,将发送的信号线直接引入到 UART_RX_I 来
//完成解析
UART_RX	I_UART_RX
	(
        .SYSCLK		(SYSCLK		),
        .RST_B		(RST_B_SYNC		),		

//下面这一句在使用Modelsim仿真时可将TX的数据接到RX中，来代替激励信号的产生	
        //.UART_RX_I	(UART_TX_O	),
        
        .UART_RX_I	(UART_RX_I	),
        
        .UART_RX_DATA	(UART_RX_DATA	)
	);	





endmodule

//==============================================================================
//	End of file
//==============================================================================

