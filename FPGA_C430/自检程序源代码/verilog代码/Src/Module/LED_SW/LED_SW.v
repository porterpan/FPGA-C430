//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================



//====================================================================================



`timescale 1ns / 1ps


module LED_SW(
	       rstn,	
               clk30M,
               clk100M, 
               sw_1,
               sw_2,
               sw_3,
               sw_4,       
               btn_rgt,
               btn_lft,
               btn_ent, 
               ir_vld,  
               net_testdo, 
               usbsd_rdo,
               usbsd_rvld,          
               
               led_01,
               led_02,
               led_03,
               led_04,
               seg7_type,
               seg7_adda,
               seg7_dusbsd,
               disptype,
               dispext,
               adda_en,
               aud_en,
               vga_en,
               net_en,
               usbsd_en,
               usbsd_sel,
               extio_en
                           
              		  		  
	      );     
			  
			  
			  
input rstn;	
input clk30M;
input clk100M;
input sw_1;
input sw_2;
input sw_3;
input sw_4;
input btn_rgt;
input btn_lft;
input btn_ent;
input ir_vld;
input net_testdo;
input [15:0]usbsd_rdo;
input usbsd_rvld;

 
output led_01;
output led_02;
output led_03;
output led_04;
output [3:0]seg7_type;
output [15:0]seg7_adda;
output [15:0]seg7_dusbsd;
output [1:0]disptype;
output dispext;
output adda_en;
output aud_en;
output vga_en;

output net_en;
output usbsd_en;
output usbsd_sel;
output extio_en;


reg led_01;
reg led_02;
reg led_03;
reg led_04;
reg [3:0]seg7_type;
reg [15:0]seg7_adda;
reg [15:0]seg7_dusbsd;
reg [1:0]disptype;
reg dispext;
reg adda_en;
reg aud_en;
reg vga_en;


reg net_en;
reg usbsd_en;
reg usbsd_sel;
reg extio_en;



//====================================================






//====================================================

reg [17:0]rspcnt1;
reg [17:0]rspcnt2;
reg [17:0]rspcnt3;
reg [17:0]rspcnt4;

reg sw1rsp;
reg sw2rsp;
reg sw3rsp;
reg sw4rsp;

reg sw1rsp0;
reg sw2rsp0;
reg sw3rsp0;
reg sw4rsp0;

reg sw1_on;
reg sw2_on;
reg sw3_on;
reg sw4_on;


reg [25:0]timecnt;
reg ledtmp1;
reg ledtmp2;
reg ledtmp3;
reg ledtmp4;

reg btn1rsp;
reg btn2rsp;
reg btn3rsp;
reg btn4rsp;   
reg btn5rsp;
reg btn6rsp;
                
                
reg btn1rsp0;
reg btn2rsp0;
reg btn3rsp0;
reg btn4rsp0;    
reg btn5rsp0;
reg btn6rsp0;                              
                
reg [15:0]brspcnt1;
reg [15:0]brspcnt2;
reg [15:0]brspcnt3;
reg [15:0]brspcnt4;   
reg [15:0]brspcnt5;
reg [15:0]brspcnt6;                  
                
reg btn1;
reg btn2;
reg btn3;
reg btn4;     
reg btn5;
reg btn6;  
                
reg btn_ok; 
reg ir_led;

//=====================================================

always @(posedge clk30M or negedge rstn) 
begin
     if(!rstn)
        begin
            led_01 <= 1'b0;
            led_02 <= 1'b0;
            led_03 <= 1'b0;
            led_04 <= 1'b0;             
        end
     else
        begin
            case({sw1_on,sw2_on,sw3_on,sw4_on})
                4'b0000:
                        begin
                             led_01 <= ledtmp1|btn_ok;    //-- 任何一个按键按下时，LED全亮；
                             led_02 <= ledtmp2|btn_ok;
                             led_03 <= ledtmp3|btn_ok;
                             led_04 <= ledtmp4|btn_ok;
                        end

                4'b0001:
                        begin
                             led_01 <= 1'b0;    
                             led_02 <= 1'b0;
                             led_03 <= 1'b0;
                             led_04 <= 1'b0;
                        end  
                        
                4'b0011:
                        begin
                             led_01 <= ir_led;    
                             led_02 <= 1'b0;
                             led_03 <= 1'b0;
                             led_04 <= 1'b0;
                        end
                        
                4'b1101:
                        begin
                             led_01 <= net_testdo;    
                             led_02 <= 1'b0;
                             led_03 <= 1'b0;
                             led_04 <= 1'b0;
                        end   
                        
                4'b1010,
                4'b1011:
                        begin
                             led_01 <= usbsd_rvld;    
                             led_02 <= 1'b0;
                             led_03 <= 1'b0;
                             led_04 <= 1'b0;
                        end                                                                                             
                        
                        
                default:
                        begin
                              led_01 <= 1'b1;
                              led_02 <= 1'b1;
                              led_03 <= 1'b1;
                              led_04 <= 1'b1;                        
                        end
            endcase
        end

end


always @(posedge clk30M or negedge rstn) 
begin
     if(!rstn)
        begin
             seg7_type <= 4'd0;          
        end
     else
        begin
            case({sw1_on,sw2_on,sw3_on,sw4_on})
                4'b0000:                           //-- 数码管显示 DS1302Z 时钟输出，显示  “ 分：秒 ”
                        begin
                             seg7_type <= 4'd2;
                        end
                        
                4'b0001:                           //-- 数码管显示 SPI FLASH 读出数据；
                        begin
                             seg7_type <= 4'd5;
                        end

                4'b0011:                           //-- 显示红外遥控按键数据；
                        begin
                             seg7_type <= 4'd1;
                        end
                        
                4'b0111:                           //-- 轮流显示 “9280”  “9708”；  表示AD/DA的型号；
                        begin
                             seg7_type <= 4'd6;
                        end  
                        
                4'b1111:                           //-- 显示 “8731”;  表示音频 WM8731；
                        begin
                             seg7_type <= 4'd7;
                        end 
                        
                4'b1110:                           //-- 显示 “7113”;  表示视频SAA7113H；
                        begin
                             seg7_type <= 4'd8;
                        end         
                        
                4'b1100:                           //-- 显示串口输入数据；
                        begin
                             seg7_type <= 4'd3;
                        end   
                        
                4'b1000:                           //-- 显示键盘输入值，按键ASIIC码将在数码管头两位显示，如果是字母上方的数字0～9输入，则后两位显示该数字值；
                        begin
                             seg7_type <= 4'd4;
                        end  
                        
                4'b1101:                           //-- 测试网络接口； 显示 2860，表示ENC28J60
                        begin
                             seg7_type <= 4'd9;
                        end    
                        
                4'b1010:                           //-- 测试USB HOST接口；初始8888，插入USB设备后依次显示读取USB设备指定文件中的数据，显示头4个字节内容（十六进制值）；
                        begin
                             seg7_type <= 4'd10;
                        end    
                        
                4'b1011:                           //-- 测试SD/MMC接口； 初始为6666， 插卡后依次显示读取SD/MMC卡指定文件中的数据，显示头4个字节内容（十六进制值）；
                        begin
                             seg7_type <= 4'd11;
                        end 
                        
                4'b1001:                           //-- 测试扩展IO口； 显示0034， 表明34帧扩展口；
                        begin
                             seg7_type <= 4'd12;
                        end                                                                                                                                                                                                                               
                                                
                default:
                        begin
                             seg7_type <= 4'd0;
                        
                        end
            endcase        
        end
end


//=============================================


always @(posedge clk100M or negedge rstn)
begin
    if (!rstn)
       begin
            vga_en <= 1'b0;
       end
    else
       begin      
            if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b0001)
                begin
                     vga_en <= 1'b1;           //-- SPI FLASH 测试开始；
                end
            else
                begin
                     vga_en <= 1'b0;
                end            
       end
end


//==========================================


always @(posedge clk100M or negedge rstn)
begin
    if (!rstn)
       begin
            ir_led <= 1'b0;
       end
    else
       begin  
            if(ir_vld==1'b1)
               begin
                    ir_led <= ~ir_led; 
               end
       end
end


//==================================================

always @(posedge clk100M or negedge rstn)
begin
    if (!rstn)
       begin
            disptype <= 2'd0;
            dispext <= 1'b0;
       end
    else
       begin  
            if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b1110)
               begin
                    disptype <= 2'd3;       //-- 液晶屏显示SAA7113H输出视频内容；
                    dispext <= 1'b1;       
               end
            else
               begin
                    if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b0111)  //-- 液晶屏显示AD 9280输出数据；
                        begin
                             disptype <= 2'd1;
                             dispext <= 1'b0;       //-- 帧频启动信号选择，dispext=0时有模块内部产生帧频信号；
                        end
                    else
                        begin
                             disptype <= 2'd0;      //-- 默认显示内容；
                             dispext <= 1'b0;
                        end
               end
       end
end


//==================================================

always @(posedge clk100M or negedge rstn)
begin
    if (!rstn)
       begin
            net_en <= 1'b0;
            usbsd_en <= 1'b0;
            usbsd_sel <= 1'b0;
       end
    else
       begin  
            if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b1101)
               begin
                    net_en <= 1'b1;       //-- 网络测试启动；
               end
            else
               begin
                    net_en <= 1'b0;
               end
               
            if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b1010 || {sw1_on,sw2_on,sw3_on,sw4_on}==4'b1011)
               begin
                    usbsd_en <= 1'b1;     //-- USB/SD卡启动
               end
            else
               begin
                    usbsd_en <= 1'b0;     
               end 
               
            if(sw4_on==1'b0)
               begin
                    usbsd_sel <= 1'b1;    //-- 测试USB设备
               end
            else
               begin
                    usbsd_sel <= 1'b0;    //-- 测试SD卡
               end
        end
end



always @(posedge clk100M or negedge rstn)
begin
    if (!rstn)
       begin
            seg7_dusbsd <= 16'd0;
       end
    else
       begin
            if(seg7_type==4'd10)    //--USB
               begin
                    if(usbsd_rvld==1'b1)
                       begin
                            seg7_dusbsd <= usbsd_rdo[15:0];     //-- 显示USB设备指定文件的头两个字节内容；
                       end
                    else
                       begin
                            seg7_dusbsd <= 16'h8888;            //-- 未插入USB设备或者未读到USB设备指定文件时，默认显示值；
                       end
               end
            else                    //--SD
               begin
                    if(usbsd_rvld==1'b1)
                       begin
                            seg7_dusbsd <= usbsd_rdo[15:0];    //-- 显示SD卡指定文件的头两个字节内容；
                       end
                    else
                       begin
                            seg7_dusbsd <= 16'h6666;            //-- 未插入SD/MMC卡或者未读到指定文件时，默认显示值；
                       end               
               end
       end
end
               
               
                           

//===================================================


always @(posedge clk30M or negedge rstn) 
begin
     if(!rstn)
     	  begin
                sw1rsp <= 1'b1;
                sw2rsp <= 1'b1;
                sw3rsp <= 1'b1;
                sw4rsp <= 1'b1;
                
                sw1rsp0 <= 1'b0;
                sw2rsp0 <= 1'b0;
                sw3rsp0 <= 1'b0;
                sw4rsp0 <= 1'b0;                
                
                rspcnt1 <= 18'd0;
                rspcnt2 <= 18'd0;
                rspcnt3 <= 18'd0;
                rspcnt4 <= 18'd0;   
                
                sw1_on <= 1'b0;
                sw2_on <= 1'b0;
                sw3_on <= 1'b0;
                sw4_on <= 1'b0;                             
     	  end
     else 
          begin
               sw1rsp0 <= sw_1;
               if(sw_1==sw1rsp0)
                  begin
                      if(rspcnt1==18'h3ffff)           //-- 去抖动，延迟几ms；
                         begin
                              sw1rsp <= sw1rsp0;
                         end
                      else
                         begin
                              rspcnt1 <= rspcnt1 + 1'b1;
                         end
                  end
               else
                  begin
                      rspcnt1 <= 18'd0;
                  end
                  
               sw2rsp0 <= sw_2;
               if(sw_2==sw2rsp0)
                  begin
                      if(rspcnt2==18'h3ffff)           //-- 去抖动，延迟几ms；
                         begin
                              sw2rsp <= sw2rsp0;
                         end
                      else
                         begin
                              rspcnt2 <= rspcnt2 + 1'b1;
                         end
                  end
               else
                  begin
                      rspcnt2 <= 18'd0;
                  end                  

               sw3rsp0 <= sw_3;
               if(sw_3==sw3rsp0)
                  begin
                      if(rspcnt3==18'h3ffff)           //-- 去抖动，延迟几ms；
                         begin
                              sw3rsp <= sw3rsp0;
                         end
                      else
                         begin
                              rspcnt3 <= rspcnt3 + 1'b1;
                         end
                  end
               else
                  begin
                      rspcnt3 <= 18'd0;
                  end  
                  
               sw4rsp0 <= sw_4;
               if(sw_4==sw4rsp0)
                  begin
                      if(rspcnt4==18'h3ffff)           //-- 去抖动，延迟几ms；
                         begin
                              sw4rsp <= sw4rsp0;
                         end
                      else
                         begin
                              rspcnt4 <= rspcnt4 + 1'b1;
                         end
                  end
               else
                  begin
                      rspcnt4 <= 18'd0;
                  end                                    
                  
               sw1_on <= ~sw1rsp;         //-- sw1_on=1 表示拨码开关的1拨至“ON“；注意，为'ON'时开发板输入为低电平，因此此处取反；
               sw2_on <= ~sw2rsp;         //-- sw1rsp/sw2rsp/sw3rsp/sw4rsp 复位值为1，即默认拨码开关均处于off位置；
               sw3_on <= ~sw3rsp; 
               sw4_on <= ~sw4rsp;                                     
          
          end
end








always @(posedge clk30M or negedge rstn) 
begin
     if(!rstn)
     	  begin
                btn1rsp <= 1'b0;
                btn2rsp <= 1'b0;
                btn3rsp <= 1'b0;
                btn4rsp <= 1'b0;   
                btn5rsp <= 1'b0;
                btn6rsp <= 1'b0;
                
                
                btn1rsp0 <= 1'b0;
                btn2rsp0 <= 1'b0;
                btn3rsp0 <= 1'b0;
                btn4rsp0 <= 1'b0;    
                btn5rsp0 <= 1'b0;
                btn6rsp0 <= 1'b0;                              
                
                brspcnt1 <= 16'd0;
                brspcnt2 <= 16'd0;
                brspcnt3 <= 16'd0;
                brspcnt4 <= 16'd0;   
                brspcnt5 <= 16'd0;
                brspcnt6 <= 16'd0;                  
                
                btn1 <= 1'b0;
                btn2 <= 1'b0;
                btn3 <= 1'b0;
                btn4 <= 1'b0;     
                btn5 <= 1'b0;
                btn6 <= 1'b0;  
                
                btn_ok <= 1'b0;                                       
     	  end
     else 
          begin
                  

               btn2rsp0 <= btn_rgt;
               if(btn_rgt==btn2rsp0)
                  begin
                      if(brspcnt2==16'hffff)           //-- 去抖动，延迟几ms；
                         begin
                              btn2rsp <= btn2rsp0;
                         end
                      else
                         begin
                              brspcnt2 <= brspcnt2 + 1'b1;
                         end
                  end
               else
                  begin
                      brspcnt2 <= 16'd0;
                  end   
                  
               btn3rsp0 <= btn_lft;
               if(btn_lft==btn3rsp0)
                  begin
                      if(brspcnt3==16'hffff)           //-- 去抖动，延迟几ms；
                         begin
                              btn3rsp <= btn3rsp0;
                         end
                      else
                         begin
                              brspcnt3 <= brspcnt3 + 1'b1;
                         end
                  end
               else
                  begin
                      brspcnt3 <= 16'd0;
                  end    
                  
                                                

               btn6rsp0 <= btn_ent;
               if(btn_ent==btn6rsp0)
                  begin
                      if(brspcnt6==16'hffff)           //-- 去抖动，延迟几ms；
                         begin
                              btn6rsp <= btn6rsp0;
                         end
                      else
                         begin
                              brspcnt6 <= brspcnt6 + 1'b1;
                         end
                  end
               else
                  begin
                      brspcnt6 <= 16'd0;
                  end   
                  
               btn1 <=  ~btn1rsp;     //-- 按键按下时为低电平，此处取反，btn=1表明按键按下；  
               btn2 <=  ~btn2rsp;
               btn3 <=  ~btn3rsp;
               btn4 <=  ~btn4rsp;
               btn5 <=  ~btn5rsp;
               btn6 <=  ~btn6rsp;
                                                     
               btn_ok <=  btn2 | btn3 | btn6;     
          end
end



//-- 


always @(posedge clk30M or negedge rstn) 
begin
     if(!rstn)
     	  begin
               ledtmp1 <= 1'b0;
               ledtmp2 <= 1'b0;
               ledtmp3 <= 1'b0;
               ledtmp4 <= 1'b0;
               
               timecnt <= 26'd0;
     	  end
     else 
          begin
               ledtmp1 <= timecnt[25];
               ledtmp2 <= timecnt[24];
               ledtmp3 <= timecnt[23];
               ledtmp4 <= timecnt[22];
               
               
               timecnt <= timecnt + 1'b1;               
          end
end



always @(posedge clk30M or negedge rstn) 
begin
     if(!rstn)
     	  begin
               seg7_adda <= 16'd0;
               adda_en <= 1'b0;
               aud_en <= 1'b0;
               extio_en <= 1'b0;
     	  end
     else 
          begin
               if(timecnt[25]==1'b1)
                  begin
                       seg7_adda <= 16'h9280;
                  end
               else
                  begin
                       seg7_adda <= 16'h9708;
                  end
                  
               if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b0111)   //-- 拨码开关拨至指定位置时，AD9280才开始工作；
                  begin
                       adda_en <= 1'b1;
                  end
               else
                  begin
                       adda_en <= 1'b0;
                  end
                  
               if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b1111)   //-- 拨码开关拨至指定位置时，WM8731才开始工作；
                  begin
                       aud_en <= 1'b1;
                  end
               else
                  begin
                       aud_en <= 1'b0;
                  end 
                  
               if({sw1_on,sw2_on,sw3_on,sw4_on}==4'b1001)   //-- 拨码开关拨至指定位置时，扩展IO口输出方波信号供测试；
                  begin
                       extio_en <= 1'b1;
                  end
               else
                  begin
                       extio_en <= 1'b0;
                  end                                    
                  
          end
end         






	
endmodule