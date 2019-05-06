//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================
  

`timescale 1ns / 1ps


module IR_TOP
	(
	clk100M,
	rstn,
	ir_din,

	ir_data,
	ir_vld,
	test
	);
	


input	clk100M;
input	rstn;
input	ir_din;

output	[31:0]ir_data;
output	ir_vld;
output  test;



reg   [31:0]ir_data;
reg   ir_vld;

wire  test;


//===========================================================================

//===========================================================================


reg [2:0]ctrl;

parameter  IR_IDLE    = 3'h0;
parameter  IR_BIN     = 3'h1;
parameter  IR_END     = 3'h2;
parameter  IR_REPEAT  = 3'h3;



reg ir_reg;
reg ir_reg1;

reg [20:0]ltimecnt;
reg [20:0]ltimelast;

reg [20:0]htimecnt;
reg [20:0]htimelast;

reg highend;
reg highend1;
reg highend2;

reg low_9ms;
reg high_45ms;

reg low_56ms;
reg high_56ms;
reg high_17ms;
reg high_225ms;

reg headflg;
reg bin_0;
reg bin_1;
reg headrpt;

reg irdin1;
reg irdin2;
reg irdin3;


assign test = (highend==1'b1&&bincnt==7'd31) ? 1'b1: 1'b0;

always @ (posedge clk100M or negedge rstn)
begin
  if(!rstn)
     begin
          ir_reg <= 1'b0;
          ir_reg1 <= 1'b0;
          
          irdin1 <= 1'b0;
          irdin2 <= 1'b0;
          irdin3 <= 1'b0;
          
          ltimecnt <= 21'd0;
          ltimelast <= 21'd0;
          
          htimecnt <= 21'd0;
          htimelast <= 21'd0;   
          
          highend <= 1'b0;  
          highend1 <= 1'b0;
          highend2 <= 1'b0;
          
          low_9ms <= 1'b0;
          high_45ms <= 1'b0;   
          
          low_56ms <= 1'b0;
          high_56ms <= 1'b0;
          high_17ms <= 1'b0;  
          high_225ms <= 1'b0;
          
          headflg <= 1'b0;
          headrpt <= 1'b0;
          bin_0 <= 1'b0;
          bin_1 <= 1'b0;          
     end
  else
     begin
          
          irdin1 <= ir_din;
          irdin2 <= irdin1;
          
          if(irdin2==1'b0&&irdin1==1'b0&&ir_din==1'b0)   //-- 跨时钟采样
             begin
                  irdin3 <= 1'b0;
             end
          else
             begin
                  irdin3 <= 1'b1;
             end
     
          ir_reg <= irdin3;
          ir_reg1 <= ir_reg;
          
          if(ir_reg1==1'b1 && ir_reg==1'b0)
             begin
                  ltimecnt <= 21'd0;          //-- 低电平脉冲宽度计时开始；
             end
          else
             begin
                  if(ir_reg==1'b0)
                     begin
                         ltimecnt <= ltimecnt + 1'b1;
                     end
                     
                  if(ir_reg==1'b1&&ir_reg1==1'b0)   //-- 低电平结束；
                     begin
                         ltimelast <= ltimecnt;     //--  由ltimelast可计算出低电平的宽度
                     end
             end
             

          if(ir_reg1==1'b0 && ir_reg==1'b1)   //-- 高电平脉冲开始
             begin
                  htimecnt <= 21'd0;          //-- 高电平脉冲宽度计时开始；
             end
          else
             begin
                  if(ir_reg==1'b1)
                     begin
                         htimecnt <= htimecnt + 1'b1;
                     end
                     
                  if(ir_reg==1'b0&&ir_reg1==1'b1)   //-- 高电平结束；
                     begin
                         htimelast <= htimecnt;     //--  由htimelast可计算出高电平的宽度
                     end
             end 
           
          highend1 <= highend;
          highend2 <= highend1;  
          if(ir_reg==1'b0&&ir_reg1==1'b1)
             begin
                  highend <= 1'b1;           //-- keep 1clk;
             end         
          else
             begin
                  highend <= 1'b0;
             end
             
          if(ltimelast[20:15]== 6'b011011)   //-- 允许一定的误差范围
             begin
                  low_9ms <= 1'b1;           //-- 9ms
             end  
          else
             begin
                  low_9ms <= 1'b0;
             end

          if(htimelast[20:15]== 6'b001101)   //-- 允许一定的误差范围
             begin
                  high_45ms <= 1'b1;        //-- 4.5ms
             end  
          else
             begin
                  high_45ms <= 1'b0;
             end
             
             
          if(ltimelast[20:14]== 7'b0000011)   //-- 允许一定的误差范围
             begin
                  low_56ms <= 1'b1;           //-- 0.56ms
             end  
          else
             begin
                  low_56ms <= 1'b0;
             end             
             

          if(htimelast[20:16]== 5'b00000)   //-- 只用来做0/1判断，0～6.9ms都认为是逻辑0，否则为1；
             begin
                  high_56ms <= 1'b1;        //-- < 0.56ms
             end  
          else
             begin
                  high_56ms <= 1'b0;
             end             

          if(htimelast[20:15]== 6'b000101)   //-- 允许一定的误差范围
             begin
                  high_17ms <= 1'b1;        //-- 1.7ms
             end  
          else
             begin
                  high_17ms <= 1'b0;
             end              

          if(htimelast[20:16]== 5'b00011)   //-- 允许一定的误差范围
             begin
                  high_225ms <= 1'b1;        //-- 2.25ms
             end  
          else
             begin
                  high_225ms <= 1'b0;
             end               
             
          if(highend1==1'b1&&low_9ms==1'b1&&high_45ms==1'b1)
             begin
                  headflg <= 1'b1;     //-- 引导码标志； keep 1clk;
             end             
          else
             begin
                  headflg <= 1'b0;
             end
             
          if(highend1==1'b1&&low_9ms==1'b1&&high_225ms==1'b1)
             begin
                  headrpt <= 1'b1;     //-- 连发码； keep 1clk;
             end             
          else
             begin
                  headrpt <= 1'b0;
             end             

          if(highend1==1'b1)
             begin
                 //-- if(low_56ms==1'b1&&high_56ms==1'b1)
                  if(high_56ms==1'b1)  

                     begin
                         bin_0 <= 1'b1;  
                     end
                  else
                     begin
                         bin_0 <= 1'b0; 
                     end  
             end             

          if(highend1==1'b1)
             begin
                  if(low_56ms==1'b1&&high_17ms==1'b1)
                     begin
                         bin_1 <= 1'b1;  
                     end
                  else
                     begin
                         bin_1 <= 1'b0; 
                     end  
             end             
          
     end
end




reg [6:0]bincnt;
reg bintime;



always @ (posedge clk100M or negedge rstn)
begin
  if(!rstn)
     begin
          ctrl	<= IR_IDLE;
          
          bincnt <= 7'd0;
          bintime <= 1'b0;
     end
  else
     begin
          case(ctrl)
            IR_IDLE:
                 begin
                     if(headflg==1'b1)             //--引导码后进入数据接收
                        begin
                             bincnt <= 7'd0;
                             bintime <= 1'b1;
            	             ctrl <= IR_BIN;
            	        end
            	     else 
            	        begin
            	            if(headrpt==1'b1)
            	               begin
            	                   ctrl <= IR_REPEAT;
            	               end
            	        end 
            	 end
            		
            IR_BIN: 
                 begin
                      if(highend==1'b1)
                         begin
                              bincnt <= bincnt + 1'b1;
                         end
                         
                      if(bincnt==7'd32)
                         begin
                              bintime <= 1'b0;
                              ctrl <= IR_END;
                         end
                      else
                         begin
                              if(headrpt==1'b1 || headflg==1'b1)   //-- 接收32bit数据过程中如果出现重复码/引导码/重复引导码，则重新开始接收
                                  begin
                                       bintime <= 1'b0;
                                       ctrl <= IR_IDLE;
                                  end
                         end                                           
                 end 
            		 
            IR_END:   
                 begin
                      ctrl <= IR_IDLE;
                 end
            
            IR_REPEAT: 
                 begin
            	       if(headrpt==1'b1 || headflg==1'b1 || bin_0==1'b1 || bin_1==1'b1)
            	          begin
            	               ctrl <= IR_IDLE;
            	          end
                 end           	
          endcase  
     end
end




reg [31:0]bin_dat;
reg bin32_vld;
reg bintime1;
reg bintime2;

always @ (posedge clk100M or negedge rstn)
begin
  if(!rstn)
     begin
          bin_dat <= 32'd0;
          bin32_vld <= 1'b0;
          
          bintime1 <= 1'b0;
          bintime2 <= 1'b0;
          
          ir_data <= 32'd0;
          ir_vld <= 1'b0;
     end
  else
     begin
          if(bin32_vld==1'b1)
             begin
                 ir_data <= bin_dat;
                //-- ir_data <= 32'h12343456;
             end

          ir_vld <= bin32_vld;
     
          bintime1 <= bintime;
          bintime2 <= bintime1;
          if(bintime2==1'b1)
             begin
                  if(highend2==1'b1)        //-- highend2 和 bin_0/bin_1同步；
                     begin
                          case(bincnt[5:0])
                             6'd1:  bin_dat[31] <= ~bin_0;
                             6'd2:  bin_dat[30] <= ~bin_0;
                             6'd3:  bin_dat[29] <= ~bin_0;
                             6'd4:  bin_dat[28] <= ~bin_0;
                             6'd5:  bin_dat[27] <= ~bin_0;
                             6'd6:  bin_dat[26] <= ~bin_0;
                             6'd7:  bin_dat[25] <= ~bin_0;
                             6'd8:  bin_dat[24] <= ~bin_0;
                             
                             6'd9:  bin_dat[23] <= ~bin_0;
                             6'd10: bin_dat[22] <= ~bin_0;
                             6'd11: bin_dat[21] <= ~bin_0;
                             6'd12: bin_dat[20] <= ~bin_0;
                             6'd13: bin_dat[19] <= ~bin_0;
                             6'd14: bin_dat[18] <= ~bin_0;
                             6'd15: bin_dat[17] <= ~bin_0;
                             6'd16: bin_dat[16] <= ~bin_0;                             

                             6'd17: bin_dat[15] <= ~bin_0;
                             6'd18: bin_dat[14] <= ~bin_0;
                             6'd19: bin_dat[13] <= ~bin_0;
                             6'd20: bin_dat[12] <= ~bin_0;
                             6'd21: bin_dat[11] <= ~bin_0;
                             6'd22: bin_dat[10] <= ~bin_0;
                             6'd23: bin_dat[9]  <= ~bin_0;
                             6'd24: bin_dat[8]  <= ~bin_0;                              


                             6'd25: bin_dat[7] <= ~bin_0;
                             6'd26: bin_dat[6] <= ~bin_0;
                             6'd27: bin_dat[5] <= ~bin_0;
                             6'd28: bin_dat[4] <= ~bin_0;
                             6'd29: bin_dat[3] <= ~bin_0;
                             6'd30: bin_dat[2] <= ~bin_0;
                             6'd31: bin_dat[1] <= ~bin_0;
                             6'd32: bin_dat[0] <= ~bin_0; 
                         endcase 
                         
                         if(bincnt[5:0]==6'd32)
                            begin
                                 bin32_vld <= 1'b1;
                            end                  
                         else
                            begin
                                 bin32_vld <= 1'b0;
                            end          
                     end
                  else
                     begin
                          bin32_vld <= 1'b0;
                     end                   
             end
          else
             begin
                  bin32_vld <= 1'b0;
             end
     end     
end






endmodule

 