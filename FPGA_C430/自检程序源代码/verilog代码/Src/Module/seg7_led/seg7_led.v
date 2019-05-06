//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================
  


//====================================================================================



`timescale 1ns / 1ps


module seg7_led(
	       rstn,	
               clk,
               seg7_type, 
               seg7_adda,
               seg7_irdi,
               seg7_dsdi,
               seg7_uartdi,
               seg7_ps2di,
               seg7_flshrdo,
               seg7_dusbsd,

               seg7_leda,      
               seg7_ledb,
               seg7_ledc,
               seg7_ledd,
               seg7_lede,
               seg7_ledf,
               seg7_ledg,
               seg7_ledh,                  
               seg7_sel0,
               seg7_sel1,
               seg7_sel2,
               seg7_sel3                                  		  		  
	      );     
			  
			  
			  
input rstn;	
input clk;
input [3:0]seg7_type;
input [15:0]seg7_adda;
input [7:0]seg7_irdi;
input [15:0]seg7_dsdi;
input [7:0]seg7_uartdi;
input [15:0]seg7_ps2di;
input [15:0]seg7_flshrdo;
input [15:0]seg7_dusbsd;

output seg7_leda;      
output seg7_ledb;
output seg7_ledc;
output seg7_ledd;
output seg7_lede;
output seg7_ledf;
output seg7_ledg;
output seg7_ledh;                  
output seg7_sel0;
output seg7_sel1;
output seg7_sel2;
output seg7_sel3;


wire seg7_leda;      
wire seg7_ledb;
wire seg7_ledc;
wire seg7_ledd;
wire seg7_lede;
wire seg7_ledf;
wire seg7_ledg;
wire seg7_ledh;                  
wire seg7_sel0;
wire seg7_sel1;
wire seg7_sel2;
wire seg7_sel3;

//====================================================

reg time1ms;
reg [16:0]timecnt;
reg [5:0]tmscnt;


reg [1:0]ledsel;

reg [3:0]seg7_sel;
reg [7:0]seg7_dat;

reg [3:0]led_data0;
reg [3:0]led_data1;
reg [3:0]led_data2;
reg [3:0]led_data3;

reg [7:0]seg7_dat0;
reg [7:0]seg7_dat1;
reg [7:0]seg7_dat2;
reg [7:0]seg7_dat3;

//--assign seg7_leda = seg7_dat[0];      
//--assign seg7_ledb = seg7_dat[1];
//--assign seg7_ledc = seg7_dat[2];
//--assign seg7_ledd = seg7_dat[3];
//--assign seg7_lede = seg7_dat[4];
//--assign seg7_ledf = seg7_dat[5];
//--assign seg7_ledg = seg7_dat[6];
//--assign seg7_ledh = seg7_dat[7]; 

assign seg7_leda = seg7_dat[7];      
assign seg7_ledb = seg7_dat[6];
assign seg7_ledc = seg7_dat[5];
assign seg7_ledd = seg7_dat[4];
assign seg7_lede = seg7_dat[3];
assign seg7_ledf = seg7_dat[2];
assign seg7_ledg = seg7_dat[1];
assign seg7_ledh = seg7_dat[0]; 
                 
assign seg7_sel0 = seg7_sel[0];       //-- 对应四位数码管的左边第一位
assign seg7_sel1 = seg7_sel[1];
assign seg7_sel2 = seg7_sel[2];
assign seg7_sel3 = seg7_sel[3];       //-- 对应四位数码管的最右边一位


always @(posedge clk or negedge rstn)  
begin
     if(!rstn)
     	  begin
               timecnt <= 17'd0;
               time1ms <= 1'b0;
               tmscnt <= 6'd0;
               
               ledsel <= 2'd0;
     	  end
     else 
          begin
               if(timecnt==17'h1869f)       //-- when clk=100Mhz
                   begin
                        timecnt <= 17'd0;
                        time1ms <= 1'b1;    //-- 1ms; keep 1clk;
                   end
               else
                   begin
                        time1ms <= 1'b0;
                        timecnt <= timecnt + 1'b1;
                   end
        
          
               if(time1ms==1'b1)
                  begin
                       ledsel[1:0] <= ledsel[1:0] + 1'b1;
                  end
             
          end
end



always @ (ledsel[1:0])
begin
  case(ledsel[1:0])
    2'd0:     seg7_sel = 4'b1110;
    2'd1:     seg7_sel = 4'b1101;
    2'd2:     seg7_sel = 4'b1011;
    default:  seg7_sel = 4'b0111;
  endcase
end


always @ (ledsel[1:0] or seg7_dat0 or seg7_dat1 or seg7_dat2 or seg7_dat3)
begin
  case(ledsel[1:0])
    2'd0:     seg7_dat = seg7_dat0;       //-- 共阳数码管； =0时亮；
    2'd1:     seg7_dat = seg7_dat1; 
    2'd2:     seg7_dat = seg7_dat2; 
    default:  seg7_dat = seg7_dat3; 
  endcase
end


//================================


always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
                led_data0 <= 4'd0;
                led_data1 <= 4'd0;
                led_data2 <= 4'd0;
                led_data3 <= 4'd0;
     	  end
     else
          begin
               case(seg7_type[3:0])
                  4'd0:                         //-- 内部测试显示
                       begin
                           led_data0 <= 4'h1;
                           led_data1 <= 4'h2;
                           led_data2 <= 4'h3;
                           led_data3 <= 4'h4;                       
                       end

                  4'd1:                         //-- 红外遥控数字显示
                       begin
                           led_data0 <= 4'h0;
                           led_data1 <= 4'h0;
                           led_data2 <= seg7_irdi[7:4];
                           led_data3 <= seg7_irdi[3:0];                       
                       end

                  4'd2:                         //-- DS1302 RTC时钟显示
                       begin
                           led_data0 <= seg7_dsdi[15:12];
                           led_data1 <= seg7_dsdi[11:8];
                           led_data2 <= seg7_dsdi[7:4];
                           led_data3 <= seg7_dsdi[3:0];                       
                       end

                  4'd3:                             //-- 串口输入数据显示；              
                       begin
                           led_data0 <= 4'h0;
                           led_data1 <= 4'h0;
                           led_data2 <= seg7_uartdi[7:4];
                           led_data3 <= seg7_uartdi[3:0];                       
                       end 

                  4'd6:                        
                       begin
                           led_data0 <= seg7_ps2di[15:12];
                           led_data1 <= seg7_ps2di[11:8];
                           led_data2 <= seg7_ps2di[7:4];
                           led_data3 <= seg7_ps2di[3:0];                       
                       end

                  4'd5:                         
                       begin
                           led_data0 <= 4'h7;
                           led_data1 <= 4'h1;
                           led_data2 <= 4'h2;
                           led_data3 <= 4'h3;                       
                       end 
                                           

                  4'd7:                                 //-- 音频测试； WM8731
                       begin
                           led_data0 <= 4'h8;
                           led_data1 <= 4'h7;
                           led_data2 <= 4'h3;
                           led_data3 <= 4'h1;                       
                       end
                       
                  4'd8:                                //-- 视频测试： SAA7113H
                       begin
                           led_data0 <= 4'h7;
                           led_data1 <= 4'h1;
                           led_data2 <= 4'h1;
                           led_data3 <= 4'h3;                       
                       end     
                       
                  4'd9:                               //-- 网络测试： ENC28J60                    
                       begin
                           led_data0 <= 4'h2;
                           led_data1 <= 4'h8;
                           led_data2 <= 4'h6;
                           led_data3 <= 4'h0;                       
                       end  
                       
                  4'd10:                               //-- USB HOST测试：                  
                       begin                                //-- 未插入USB设备或者未成功读取指定文件时，显示 8888， 否则显示读取文件的头两个字节内容；
                           led_data0 <= seg7_dusbsd[15:12];   
                           led_data1 <= seg7_dusbsd[11:8];
                           led_data2 <= seg7_dusbsd[7:4];
                           led_data3 <= seg7_dusbsd[4:0];                       
                       end    
                       
                  4'd11:                               //-- SD测试：                  
                       begin                                    //-- 未插入SD卡或者未成功读取指定文件时，显示 6666， 否则显示读取文件的头两个字节内容；
                           led_data0 <= seg7_dusbsd[15:12];     
                           led_data1 <= seg7_dusbsd[11:8];      
                           led_data2 <= seg7_dusbsd[7:4];       
                           led_data3 <= seg7_dusbsd[4:0];                            
                       end                                                                                  

                  4'd12:                               //-- 扩展口测试： 0034 表示 34帧扩展口；用示波器测试IO口将可以看到扩展口输出的方波信号                  
                       begin
                           led_data0 <= 4'h0;
                           led_data1 <= 4'h0;
                           led_data2 <= 4'h4;
                           led_data3 <= 4'h0;                       
                       end  
                  
                  default:
                       begin
                           begin
                               led_data0 <= 4'h1;
                               led_data1 <= 4'h2;
                               led_data2 <= 4'h3;
                               led_data3 <= 4'h4;                       
                           end                       
                       end     
                      
                endcase
          
          end 
end





always @(led_data0[3:0])
begin
  case(led_data0[3:0])
    4'h0:     seg7_dat0 = 8'h03;
    4'h1:     seg7_dat0 = 8'h9f;       //-- 共阳数码管； =0时亮；
    4'h2:     seg7_dat0 = 8'h25; 
    4'h3:     seg7_dat0 = 8'h0d; 
    4'h4:     seg7_dat0 = 8'h99; 
    4'h5:     seg7_dat0 = 8'h49;
    4'h6:     seg7_dat0 = 8'h41;
    4'h7:     seg7_dat0 = 8'h1f;
    
    4'h8:      seg7_dat0 = 8'h01;   
    4'h9:      seg7_dat0 = 8'h09;
    4'ha:      seg7_dat0 = 8'h11;
    4'hb:      seg7_dat0 = 8'h01;
    4'hc:      seg7_dat0 = 8'h63;
    4'hd:      seg7_dat0 = 8'h03;
    4'he:      seg7_dat0 = 8'h21;
    4'hf:      seg7_dat0 = 8'h71;
  endcase
end



always @(led_data1[3:0])
begin
  case(led_data1[3:0])
    4'h0:     seg7_dat1 = 8'h03;
    4'h1:     seg7_dat1 = 8'h9f;       //-- 共阳数码管； =0时亮；
    4'h2:     seg7_dat1 = 8'h25; 
    4'h3:     seg7_dat1 = 8'h0d; 
    4'h4:     seg7_dat1 = 8'h99; 
    4'h5:     seg7_dat1 = 8'h49;
    4'h6:     seg7_dat1 = 8'h41;
    4'h7:     seg7_dat1 = 8'h1f;
    
    4'h8:     seg7_dat1 = 8'h01;   
    4'h9:     seg7_dat1 = 8'h09;
    4'ha:     seg7_dat1 = 8'h11;
    4'hb:     seg7_dat1 = 8'h01;
    4'hc:     seg7_dat1 = 8'h63;
    4'hd:     seg7_dat1 = 8'h03;
    4'he:     seg7_dat1 = 8'h61;
    4'hf:     seg7_dat1 = 8'h71;
  endcase
end 

always @(led_data2[3:0])
begin
  case(led_data2[3:0])
    4'h0:     seg7_dat2 = 8'h03;
    4'h1:     seg7_dat2 = 8'h9f;      //-- 共阳数码管； =0时亮；
    4'h2:     seg7_dat2 = 8'h25;
    4'h3:     seg7_dat2 = 8'h0d;
    4'h4:     seg7_dat2 = 8'h99; 
    4'h5:     seg7_dat2 = 8'h49;
    4'h6:     seg7_dat2 = 8'h41;
    4'h7:     seg7_dat2 = 8'h1f;
    
    4'h8:     seg7_dat2 = 8'h01;   
    4'h9:     seg7_dat2 = 8'h09;
    4'ha:     seg7_dat2 = 8'h11;
    4'hb:     seg7_dat2 = 8'h01;
    4'hc:     seg7_dat2 = 8'h63;
    4'hd:     seg7_dat2 = 8'h03;
    4'he:     seg7_dat2 = 8'h61;
    4'hf:     seg7_dat2 = 8'h71;
  endcase
end

always @(led_data3[3:0])
begin
  case(led_data3[3:0])
    4'h0:     seg7_dat3 = 8'h03;
    4'h1:     seg7_dat3 = 8'h9f;       //-- 共阳数码管； =0时亮；
    4'h2:     seg7_dat3 = 8'h25; 
    4'h3:     seg7_dat3 = 8'h0d; 
    4'h4:     seg7_dat3 = 8'h99; 
    4'h5:     seg7_dat3 = 8'h49;
    4'h6:     seg7_dat3 = 8'h41;
    4'h7:     seg7_dat3 = 8'h1f;
    
    4'h8:     seg7_dat3 = 8'h01;   
    4'h9:     seg7_dat3 = 8'h09;
    4'ha:     seg7_dat3 = 8'h11;
    4'hb:     seg7_dat3 = 8'h01;
    4'hc:     seg7_dat3 = 8'h63;
    4'hd:     seg7_dat3 = 8'h03;
    4'he:     seg7_dat3 = 8'h61;
    4'hf:     seg7_dat3 = 8'h71;
  endcase
end

	
endmodule

















