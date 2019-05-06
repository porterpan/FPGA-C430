
//==============================================================================
// 此模块为UART 的 RX 模块控制层硬件描述代码

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
input		SYSCLK;		//系统时钟50MHz
input		RST_B;		//全局复位信号

input		UART_RX_I;	//串口的 RX 数据线，从这里接收外部的串行数据流
output	[7:0]	UART_RX_DATA;	//从 RX 数据线中解析完后的数据。

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

reg	[1:0]	START_REG;	//记录 RX 的开始脉冲,即第一个下降沿
reg	[1:0]	START_REG_N;	//START_REG 的下一个状态

reg	[12:0]	TIME_CNT;	//用于计数一帧完整的数据所用时间的计数器
reg	[12:0]	TIME_CNT_N;	//TIME_CNT 的下一下状态

reg	[7:0]	UART_RX_DATA_N;	//UART_RX_DATA 的下一个状态

reg	[7:0]	UART_RX_SHIFT_REG;	//接收串行数据流中用到的移位寄存器
reg	[7:0]	UART_RX_SHIFT_REG_N;	//UART_RX_SHIFT_REG 的下一个状态

//==============================================================================
//	Logic
//==============================================================================
// 一个完整数据帧计数器,8.68us X 11bit / 时钟周期20ns = 12a6 (H)
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
//这里记录第一个开始脉冲后保持，一帧完整数据时间后恢复为高电平，等待下一次启动
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
//每一个采样时间点开始启动移位寄存器记录数据。
always @ (posedge SYSCLK or negedge RST_B)
begin
 if(!RST_B)
  UART_RX_SHIFT_REG <= `UD 8'h0;
 else
  UART_RX_SHIFT_REG <= `UD UART_RX_SHIFT_REG_N;
end

always @ (*)
begin
 if((TIME_CNT == 16'h28A) || /*1.5 X 1B2*/ /*1.5 倍是因为要跳过第一个起始位*/
    (TIME_CNT == 16'h43C) || /*2.5 X 1B2*/
    (TIME_CNT == 16'h5EE) || /*3.5 X 1B2*/
    (TIME_CNT == 16'h7A0) || /*4.5 X 1B2*/
    (TIME_CNT == 16'h952) || /*5.5 X 1B2*/
    (TIME_CNT == 16'hB04) || /*6.5 X 1B2*/
    (TIME_CNT == 16'hCB6) || /*7.5 X 1B2*/
    (TIME_CNT == 16'hE68))   /*8.5 X 1B2*/
  UART_RX_SHIFT_REG_N = {UART_RX_I,UART_RX_SHIFT_REG[7:1]};//低位先收
 else
  UART_RX_SHIFT_REG_N = UART_RX_SHIFT_REG;   
end

//------------------------------------------------------------------------------
//一帧完整的数据记录时间到后即为稳定的数据。
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

