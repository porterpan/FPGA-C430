//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================

   //-- 液晶显示内容选择等相关内容

//====================================================================================



`timescale 1ns / 1ps


module dispctrl(
	       rstn,	
               clk,                
               dispdrq,
               disptype,
               dispext,
               dispexti,
               vfifordo,
               vfiforemp,
               vfiforuse, 
               adcdispdi,   
               adcdispwsel,           

               dispinit,
               dispdat,
               disprdy,
               displast, 
               vfiforrq,
               adcdisprq,
               adcdispra,
               test                     		  		  
	      );     
			  
			  
			  
input rstn;	
input clk;
input [1:0]disptype;
input dispdrq;
input dispext;
input dispexti;
input [15:0]vfifordo;
input vfiforemp;
input [10:0]vfiforuse;
input [7:0]adcdispdi;
input adcdispwsel;
 
output dispinit;
output [15:0]dispdat;
output disprdy;
output displast; 
output vfiforrq;
output adcdisprq;
output [9:0]adcdispra;
output test;  

reg dispinit;
reg [15:0]dispdat;
reg disprdy;
reg displast; 
wire vfiforrq;
reg adcdisprq;
wire [9:0]adcdispra;
wire test;

//====================================================

reg time1ms;
reg [16:0]timecnt;
reg time40ms;
reg [5:0]tmscnt;
reg dispfrmi;

reg [15:0]adwavedo;
reg [15:0]tmpdata;

reg dispinit0;


//====================================================


always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin

     	  end
     else 
          begin
              
          end
end

reg [8:0]dispcol;
reg [7:0]disprow;
reg [4:0]frmcnt;

reg extfrmi0;
reg extfrmi1;
reg extfrmi2;
reg extfrmi;

always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               extfrmi0 <= 1'b0;
               extfrmi1 <= 1'b0;
               extfrmi2 <= 1'b0;
               extfrmi <= 1'b0;
     	  end
     else 
          begin
               extfrmi0 <= dispexti;
               
               if(extfrmi0==1'b1&&dispexti==1'b1)           //-- 跨时钟处理
                  begin
                       extfrmi1 <= 1'b1;  
                  end
               else
                  begin
                       extfrmi1 <= 1'b0;
                  end
               
               extfrmi2 <= extfrmi1;
               
               if(extfrmi2==1'b1 && extfrmi1==1'b0)
                  begin
                       extfrmi <= 1'b1;
                  end
               else
                  begin
                       extfrmi <= 1'b0;
                  end
          end
end




assign vfiforrq = dispdrq;



always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               dispinit <= 1'b0;
               dispinit0 <= 1'b0;
               disprdy <= 1'b0;
               displast <= 1'b0;
               dispdat <= 16'd0;
               
               dispcol <= 9'd0;
               disprow <= 8'd0;
               
               frmcnt <= 5'd0;
     	  end
     else 
          begin
               dispinit <= dispinit0;
               if(dispext==1'b1)
                  begin
                       dispinit0 <= extfrmi;
                  end
               else
                  begin
                       dispinit0 <= dispfrmi;
                  end
                  
               
              //-- dispdat <= {11'd0,frmcnt[4:0]};
               if(dispinit0==1'b1)
                  begin
                       frmcnt <= frmcnt + 1'b1;
                  end
               
               case(disptype[1:0])
                  //--2'd1:   dispdat <= adwavedo[15:0];           //-- 液晶屏显示AD/DA数据；
                  2'd3:   dispdat <= vfifordo[15:0];           //-- 液晶屏显示输入视频内容；SAA7113H输出；
                  default:dispdat <= tmpdata[15:0];            //-- 默认显示数据； 红 绿 蓝 三色条；
               endcase
                  
                 
               if(disptype==2'd0)
                  begin
                      if(vfiforemp==1'b0)
                       begin
                            disprdy <= 1'b1;
                       end
                      else
                       begin
                            disprdy <= 1'b0;
                       end               
                  end
               else
                  begin
                       disprdy <= 1'b1;
                  end 

               
               if(dispinit0==1'b1)
                  begin
                       dispcol <= 9'd0;
                       disprow <= 8'd0;
                       displast <= 1'b0;
                  end
               else
                  begin
                       if(dispdrq==1'b1)
                          begin
                               if(dispcol==9'd319)
                                  begin
                                       dispcol <= 9'd0;
                                       disprow <= disprow + 1'b1;
                                  end
                               else
                                  begin
                                       dispcol <= dispcol + 1'b1;
                                  end
                          end
                        
                       if(dispcol==9'd319 && disprow==8'd239)
                          begin
                               displast <= 1'b1;
                          end                           
                  end
          end
end


reg [7:0]adcdind;
reg [7:0]disprows64;

reg [7:0]adcdly;
reg adcrsel;

assign adcdispra[9:0] = {adcrsel,dispcol[8:0]};
always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               adwavedo <= 16'd0;
               adcdind <= 8'd0;
               
               disprows64 <= 8'd0;
               adcdisprq <= 1'b0;
               adcdly <= 8'd0;
               adcrsel <= 1'b0;
     	  end
     else 
          begin
               adcdind <= adcdispdi;
               
               if(dispinit0==1'b1) 
                  begin
                       adcdisprq <= 1'b1;
                       adcdly <= 8'd0;
                       adcrsel <= adcdispwsel;
                  end
               else
                  begin
                       if(adcdly[7]==1'b1)
                          begin
                               adcdisprq <= 1'b0;        //-- keep some clk; 
                          end
                       else
                          begin
                               adcdly <= adcdly + 1'b1;
                          end
                  end
               
               disprows64 <= disprow[7:0]-8'd68;
          
               if(disprow[7:6]==2'b00)
                  begin
                       adwavedo <= {11'd0,5'h1f};                        
                  end
               else
                  begin
                       if(disprow[7:6]==2'b01||disprow[7:6]==2'b10)
                          begin
                                if(adcdind[6:0]== disprows64[6:0])
                                   begin
                                        adwavedo <= 16'hffff;
                                   end
                                else
                                   begin
                                        adwavedo <= {5'd0,6'd0,5'd0};
                                   end 
                          end
                       else
                          begin
                                adwavedo <= {5'h1f,11'd0}; 
                          end
                  end
          end
end


always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               tmpdata <= 16'd0;
     	  end
     else 
          begin
               case(disprow[7:4])                       
                   4'd5,
                   4'd6,
                   4'd7,
                   4'd8,
                   4'd9:  
                        begin
                             tmpdata <= {5'd0,6'h3f,5'd0};  
                        end 

                   4'd10,
                   4'd11,
                   4'd12,
                   4'd13,
                   4'd14:  
                        begin
                             tmpdata <= {5'h1f,6'd0,5'd0};  
                        end 
                        
                   default:
                        begin
                             tmpdata <= {5'd0,6'd0,5'h1f};
                        end
              endcase                                                       
          end
end

always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               timecnt <= 17'd0;
               time1ms <= 1'b0;
               tmscnt <= 6'd0;
               time40ms <= 1'b0;
               
               dispfrmi <= 1'b0;
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
                        if(tmscnt==6'd39)
                            begin
                                 time40ms <= 1'b1;    //-- 40ms; keep 1clk;
                                 tmscnt <= 6'd0;
                            end
                        else
                            begin
                                 tmscnt <= tmscnt + 1'b1;
                            end
                   end
                else
                   begin
                        time40ms <= 1'b0;
                   end
                   
                dispfrmi <= time40ms;           //-- 25fps;  显示帧频设定为25fps；
          end
end


	
endmodule