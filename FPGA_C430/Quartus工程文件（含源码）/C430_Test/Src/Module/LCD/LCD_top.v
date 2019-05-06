//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================

 
  


//====================================================================================



`timescale 1ns / 1ps


module LCD_top(
	       rstn,	
               clk, 
               dispinit,
               dispdat,
               disprdy,
               displast,
                         
               lcd_rst,        
               lcd_cs,
               lcd_rs,
               lcd_rd,
               lcd_wr,
               lcd_dat,
               dispdrq,
               test                 		  		  
	      );     
			  
			  
			  
input rstn;	
input clk;
input dispinit;
input [15:0]dispdat;
input disprdy;
input displast;
 
output lcd_rst;
output lcd_cs;
output lcd_rs;
output lcd_rd;
output lcd_wr;
output [7:0]lcd_dat;

output dispdrq;
output test;



//====================================================

reg lcd_rst;
reg lcd_cs;
reg lcd_rs;
reg lcd_rd;
reg lcd_wr;
reg [7:0]lcd_dat;


//====================================================


reg [16:0]dlycnt;
reg [6:0]dly1ms;
reg [2:0]dlyback;
reg parstart;
reg dispstart;


reg [3:0]ctrl;

parameter  LCD_IDLE    = 4'd0;
parameter  LCD_INIT    = 4'd1;
parameter  SET_RST     = 4'd2;
parameter  SET_PAR     = 4'd3;
parameter  WT_PAR      = 4'd4;
parameter  WRT_PIX     = 4'd5;
parameter  WT_PIX      = 4'd6;
parameter  DE_LAY      = 4'd7;
parameter  DE_LAY1     = 4'd8;





reg [3:0]wctrl;

parameter W_IDLE     = 4'd0;
parameter W_INIT     = 4'd1;
parameter W_SETNCS   = 4'd2;
parameter W_SETWR    = 4'd3;
parameter W_SETWR1   = 4'd4;
parameter W_SETWR2   = 4'd5;
parameter W_SETWR3   = 4'd6;
parameter W_END1     = 4'd7;
parameter W_END2     = 4'd8;
parameter W_END3     = 4'd9;
parameter W_END4     = 4'd10;
parameter W_WTPIX    = 4'd11;

reg [2:0]wdly;
reg wpixfst;
reg wdone;

reg [15:0]wdata;
reg [1:0]pdlysty;


reg [3:0]pctrl;

parameter PAR_IDLE     = 4'd0;
parameter PAR_WINIT    = 4'd1;
parameter PAR_WAIT     = 4'd2;
parameter PAR_NXT      = 4'd3;
parameter PAR_DLY      = 4'd4;
parameter PAR_DLY1     = 4'd5;
parameter PAR_8MS      = 4'd6;
parameter PAR_END      = 4'd7;

reg [6:0]wparacnt;
reg wstart;
reg [1:0]wstyle;

reg [20:0]pdlycnt;
reg [3:0]pdlycnt1;
reg paradone;


reg [2:0]dctrl;

parameter DISP_IDLE  = 3'd0;
parameter DISP_FRMI  = 3'd1;
parameter DISP_FRMW0 = 3'd2;
parameter DISP_FRMW1 = 3'd3;


reg [8:0]disprown;
reg [7:0]dispcoln;
reg dispwrti;
reg wlast;

reg [15:0]wpixdata;

reg time1ms;
reg [16:0]timecnt;
reg time40ms;
reg [5:0]tmscnt;
reg dispfrmi;


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




//=========================== CONTROL FSM =================================================


always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
     	       lcd_rst <= 1'b1;
     	       
     	       dlycnt <= 17'd0;
     	       dly1ms <= 7'd0;
     	       dlyback <= 3'd0;
     	       
     	       parstart <= 1'b0;
     	       dispstart <= 1'b0;
     	  
               ctrl  <= LCD_IDLE;
     	  end
     else 
          begin
               case(ctrl)
                   LCD_IDLE:
                        begin
                             lcd_rst <= 1'b1;
                             
                             ctrl <= LCD_INIT;       //-- �ⲿ��λ�����Ƚ���LCD��ʼ��������
                        end
                        
                   LCD_INIT:
                        begin                             
                             lcd_rst <= 1'b0;    //-- Һ������λ�ź�, ����Ч��keep 100ms;   
                             dlyback <= 3'd0;  
                             dlycnt <= 18'd0;  
                             dly1ms <= 7'd100;
                                                         
                             ctrl <= DE_LAY;      //-- ��ʱ�󷵻�SET_RST;
                        end
                        
                   SET_RST:
                        begin
                             lcd_rst <= 1'b1;
                             
                             dlyback <= 3'd1;
                             dlycnt <= 18'd0;
                             dly1ms <= 7'd100;
                             
                             ctrl <= DE_LAY;      //-- ��ʱ���غ�ʼ����������� SET_PAR;
                        end
                        
                   SET_PAR:
                        begin
                             parstart <= 1'b1;
                             ctrl <= WT_PAR;
                        end
                   
                   WT_PAR:
                        begin
                             parstart <= 1'b0;   //-- keep 1clk;
                             
                             if(paradone==1'b1)   //-- ˵����һ������������ϣ�
                                begin
                                     ctrl <= WRT_PIX;    //-- ��ʼ����Power�йز�����
                                end
                        end                                               
                        
                   WRT_PIX:
                        begin
                             dispstart <= 1'b1;
                             ctrl <= WT_PIX;
                        end
                        
                   WT_PIX:
                        begin
                             dispstart <= 1'b0;
                        end
                        
                        
                        
                   DE_LAY:
                        begin
                             dlycnt <= dlycnt + 1'b1;
                             if(dlycnt==17'h186a0)      //-- delay 1ms;
                                begin
                                     ctrl <= DE_LAY1;
                                end
                        end   
                        
                   DE_LAY1:
                        begin
                             dly1ms <= dly1ms - 1'b1;
                             if(dly1ms==7'd0)      
                                begin
                                     case(dlyback[2:0])
                                        3'd0:  begin  ctrl <= SET_RST; end
                                        3'd1:  begin  ctrl <= SET_PAR; end
                                     endcase
                                end
                             else
                                begin
                                     dlycnt <= 17'd0;
                                     ctrl <= DE_LAY;
                                end
                        end                            
                                                                    
               endcase
          end
end



//==================== LCD 8BIT WRT CMD ======================================================

reg [3:0]wpixcnt;


always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               lcd_cs <= 1'b1;
               lcd_rs <= 1'b1;
               lcd_rd <= 1'b1;
               lcd_wr <= 1'b1;
               lcd_dat <= 8'd0;
               
               wdly <= 3'd0;
               wpixfst <= 1'b0;
               wdone <= 1'b0;
               
               wpixcnt <= 4'd0;
               
               wctrl <= W_IDLE;
     	  end
     else 
          begin
               case(wctrl)
                   W_IDLE:
                        begin
                             lcd_rs <= 1'b1;
                             lcd_rd <= 1'b1;
                             lcd_wr <= 1'b1; 
                                                    
                             if(wstart==1'b1)
                                begin
                                     lcd_cs <= 1'b0;
                                     wctrl <= W_INIT;
                                end
                             else
                                begin
                                     lcd_cs <= 1'b1;
                                end
                        end
                       
                   W_INIT:
                        begin
                             case(wstyle[1:0])
                                2'd0:                           //-- write index register;
                                     begin
                                          lcd_rs <= 1'b0;
                                     end
                                2'd1:                           //-- write data to register;
                                     begin
                                          lcd_rs <= 1'b1;
                                     end
                                2'd2:                           //-- write pixel data(write GRAM);
                                     begin
                                          lcd_rs <= 1'b0;       //-- ����д��0022h�� register; ��register������д��������ΪдGRAM���ݵ���ʼ���֣�
                                          wpixfst <= 1'b1;
                                          wpixcnt <= 4'd0;
                                     end
                             endcase  
                             
                             wdly <= 3'd4;
                             wctrl <= W_SETWR;      
                        end
                        
                        
                   W_SETWR:
                        begin                            
                             if(wstyle==2'd2)                     //-- д��ʾ���ݣ�
                                begin
                                     if(wpixfst==1'b1)
                                        begin
                                             case(wpixcnt[3:0])
                                                4'd0:  lcd_dat <= 8'h00;
                                                4'd1:  lcd_dat <= 8'h00;
                                                4'd2:  lcd_dat <= 8'h00;
                                                4'd3:  lcd_dat <= 8'h00;
                                                
                                                4'd4:  lcd_dat <= 8'h00;
                                                4'd5:  lcd_dat <= 8'h00;
                                                4'd6:  lcd_dat <= 8'h00;
                                                4'd7:  lcd_dat <= 8'h01;
                                                4'd8:  lcd_dat <= 8'h00;
                                             endcase
                                             //--lcd_dat <= 8'h00;   //-- д��ʾ����ʱ, ����д "0022h" index register; ÿһ����ʾ����ǰֻ��Ҫдһ�Ρ�0022h�� register���ɣ�
                                        end
                                     else
                                        begin
                                            //-- lcd_dat <= wpixdata[15:8];
                                             lcd_dat <= dispdat[15:8];
                                        end
                                end
                             else
                                begin
                                     lcd_dat <= wdata[15:8];     //-- 16bit�ֳ�����д����д��8λ��
                                end
                                
                             if(wdly==3'd3)
                                begin
                                     lcd_wr <= 1'b0;    //-- lcd_wr�ı仯Ҫ����lcd_RS 10ns���ϣ�
                                end
                             
                             if(wdly==3'd0)                    //-- lcd_wrά�ֵ͵�ƽ����50ns���ϣ��˴�����Ϊ8clk=64ns��
                                begin
                                     wdly <= 3'd4;
                                     wctrl <= W_SETWR1;
                                end 
                             else
                                begin
                                     wdly <= wdly - 1'b1;
                                end                                                             
                        end

                   W_SETWR1:
                        begin
                             lcd_wr <= 1'b1;                 //-- lcd_wrά�ָߵ�ƽ����50ns����
                             
                             if(wdly==3'd0)    
                                begin
                                     wdly <= 3'd4;
                                     wctrl <= W_SETWR2;
                                end 
                             else
                                begin
                                     wdly <= wdly - 1'b1;
                                end
                        end   
                        
                   W_SETWR2:
                        begin
                             if(wdly==3'd3)
                                begin
                                     lcd_wr <= 1'b0; 
                                end  
                             
                             
                             if(wstyle==2'd2)    //-- дGRAM(pix data);
                                begin
                                     if(wpixfst==1'b1)
                                        begin
                                             case(wpixcnt[3:0])
                                                4'd0:  lcd_dat <= 8'h50;
                                                4'd1:  lcd_dat <= 8'h00;
                                                4'd2:  lcd_dat <= 8'h51;
                                                4'd3:  lcd_dat <= 8'hef;
                                                
                                                4'd4:  lcd_dat <= 8'h52;
                                                4'd5:  lcd_dat <= 8'h00;
                                                4'd6:  lcd_dat <= 8'h53;
                                                4'd7:  lcd_dat <= 8'h3f;
                                                4'd8:  lcd_dat <= 8'h22;
                                             endcase                                        
                                        
                                            //-- lcd_dat <= 8'h22;   //-- д��ʾ����ʱ, ����д "0022h" index register; ÿһ����ʾ����ǰֻ��Ҫдһ�Ρ�0022h�� register���ɣ�
                                        end
                                     else
                                        begin
                                             lcd_dat <= dispdat[7:0];
                                        end                                     
                                     
                                end
                             else
                                begin
                                     lcd_dat <= wdata[7:0];     //-- 16bit�ֳ�����д����д��8λ��
                                end                             
                             
                             if(wdly==3'd0)    
                                begin
                                     wdly <= 3'd4;
                                     wpixcnt <= wpixcnt + 1'b1;
                                     wctrl <= W_SETWR3;
                                end 
                             else
                                begin
                                     wdly <= wdly - 1'b1;
                                end
                        end 
                        
                   W_SETWR3:
                        begin
                             lcd_wr <= 1'b1;   
                             
                             if(wdly==3'd0)    
                                begin
                                     wdly <= 3'd4;                                    
                                     wctrl <= W_END1;
                                end 
                             else
                                begin
                                     wdly <= wdly - 1'b1;
                                end
                        end     
                        
                   W_END1:
                        begin                               
                             if(wstyle!=2'd2)     //-- ÿ��ֻдһ�� 16bit���ݣ�
                                begin
                                     wdone <= 1'b1;       //-- д����ɣ�keep 1clk;
                                     wctrl <= W_END2;
                                end
                             else            //-- д��ʾ���ݣ�
                                begin
                                     //--wpixfst <= 1'b0;     //-- ֻдһ�Ρ�0022h�� index register;
                                     if(wpixfst==1'b1)
                                        begin
                                             //--lcd_rs <= 1'b1;
                                             if(wpixcnt==4'd9)
                                                begin
                                                    lcd_rs <= 1'b1;
                                                    wpixfst <= 1'b0;
                                                end
                                             else
                                                begin
                                                     if(wpixcnt[0]==1'b0)
                                                        begin
                                                             lcd_rs <= 1'b0;
                                                        end
                                                     else
                                                        begin
                                                             lcd_rs <= 1'b1;
                                                        end
                                                end
                                             wctrl <= W_SETWR;   //--������ʼд��������ʾ���ݵĵ�һ������16bitΪ��λ����
                                        end
                                     else
                                        begin
                                             wdone <= 1'b1;  
                                             wctrl <= W_END3;
                                        end
                                end
                        end                                            
                                                 
                   W_END2:
                        begin
                             wdone <= 1'b0;
                             
                             wctrl <= W_IDLE;
                        end  
                        
                   W_END3:
                        begin   
                             wdone <= 1'b0;
                             
                             if(displast==1'b1)     //-- ˵����ǰд���Ϊ���һ����ʾ���ݣ�
                                begin
                                     wctrl <= W_IDLE;
                                end                 
                             else
                                begin
                                    lcd_rs <= 1'b1;
                                    wctrl <= W_END4; 
                
                                end                                         
                        end
                        
                   W_END4:
                        begin 
                               wdly <= 3'd4;
                               
                               if(disprdy==1'b1)
                                  begin
                                       wctrl <= W_SETWR;    //-- ����д��ʾ���ݣ�
                                  end
                               else
                                  begin
                                       wctrl <= W_WTPIX;
                                  end                        
                        end                    
                        
                    W_WTPIX:
                        begin
                             if(disprdy==1'b1)
                                 begin
                                      wctrl <= W_SETWR;    //-- ����д��ʾ���ݣ�
                                 end
                        end                                                                     
                        
               endcase
          end
end



//============================= index reg and data write ===========================================================

always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
     	       wparacnt <= 7'd0;     	       
     	       wstart <= 1'b0;
     	       wstyle <= 2'd0;
     	       
     	       pdlycnt <= 21'd0;
     	       pdlycnt1 <= 4'd0;
     	       
     	       paradone <= 1'b0;
     	  
               pctrl <= PAR_IDLE;               
     	  end
     else 
          begin
               case(pctrl)
                   PAR_IDLE:
                         begin
                               wstyle <= 2'd2;           //--Ĭ�������Ϊ������ʾ���ݣ�
                               wstart <= dispwrti;       //--��ʾ����д�뿪ʼ,keep 1clk��    
                               if(parstart==1'b1)
                                 begin
                                      wparacnt <= 7'd0;
                                      pctrl <= PAR_WINIT;
                                 end
                         end
                         
                   PAR_WINIT:
                         begin
                               
                               if(wparacnt[0]==1'b0)
                                  begin
                                       wstyle <= 2'd0;     //-- wrt index register;
                                  end
                               else
                                  begin
                                       wstyle <= 2'd1;     //-- wrt reg data;
                                  end
                               
                               if(wparacnt==7'd112)
                                  begin
                                       paradone <= 1'b1;    //-- keep 1clk; ����������ϣ�
                                       pctrl <= PAR_END;   
                                  end
                               else
                                  begin  
                                       wstart <= 1'b1;      //-- ����д������ÿ��дһ�����ݣ�16bit��;
                                       pctrl <= PAR_WAIT;
                                  end
                         end
                         
                    PAR_WAIT:
                         begin
                               wstart <= 1'b0;    //-- keep 1clk;
                               if(wdone==1'b1)    //-- �ȴ�����д����ϣ�
                                  begin
                                       pctrl <= PAR_NXT;
                                  end
                         end
                         
                    PAR_NXT:
                         begin
                              if(pdlysty!=2'd0)           //-- ��Щ����д����Ϻ���Ҫ�ӳ�һ��ʱ����д����������
                                  begin
                                       pctrl <= PAR_DLY;
                                  end
                              else
                                  begin
                                       wparacnt <= wparacnt + 1'b1;
                                       pctrl <= PAR_WINIT;
                                  end
                         end
                         
                    PAR_DLY:
                         begin                                                           
                              case(pdlysty[1:0])
                                 2'd2:  begin pdlycnt1 <= 4'd5; end
                                 2'd3:  begin pdlycnt1 <= 4'd15; end
                              endcase
                              
                              pdlycnt <= 21'd0;
                              pctrl <= PAR_8MS;
                         end
                         
                         
                    PAR_8MS:
                         begin
                              pdlycnt <= pdlycnt + 1'b1;
                              if(pdlycnt[20]==1'b1)        
                                 begin
                                      pctrl <= PAR_DLY1;
                                 end                   
                         end
                         
                    PAR_DLY1:
                         begin
                              pdlycnt <= 21'd0;
                              pdlycnt1 <= pdlycnt1 - 1'b1;
                              
                              if(pdlycnt1==4'd0)
                                 begin
                                      wparacnt <= wparacnt + 1'b1;
                                      pctrl <= PAR_WINIT;
                                 end
                              else
                                 begin
                                      pctrl <= PAR_8MS;
                                 end                              
                         end                         
                         
                    PAR_END:
                         begin
                              paradone <= 1'b0;
                              pctrl <= PAR_IDLE;
                         end
               endcase                                                                           
          end
end




always @(posedge clk or negedge rstn) 
begin
    if(!rstn)
    	  begin
               wdata <= 16'd0;
               pdlysty <= 2'd0;
    	  end
    else 
         begin
              case(wparacnt[6:0])    //-- wdata��ʾ��д���index reg����reg data�� pdlysty��ʾ�ò���д����Ƿ���Ҫ�����ӳ��ٽ�������д�룻
                  7'd0:   begin  wdata <= 16'h00e3;  pdlysty <= 2'd0;       end  
                  7'd1:   begin  wdata <= 16'h3008;  pdlysty <= 2'd0;       end 
                  7'd2:   begin  wdata <= 16'h00e7;  pdlysty <= 2'd0;       end 
                  7'd3:   begin  wdata <= 16'h0012;  pdlysty <= 2'd0;       end                   
                  7'd4:   begin  wdata <= 16'h00ef;  pdlysty <= 2'd0;       end  
                  7'd5:   begin  wdata <= 16'h1231;  pdlysty <= 2'd0;       end 
                  7'd6:   begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end 
                  7'd7:   begin  wdata <= 16'h0001;  pdlysty <= 2'd0;       end                   
                  7'd8:   begin  wdata <= 16'h0001;  pdlysty <= 2'd0;       end 
                  7'd9:   begin  wdata <= 16'h0100;  pdlysty <= 2'd0;       end                  
                  7'd10:  begin  wdata <= 16'h0002;  pdlysty <= 2'd0;       end  
                  7'd11:  begin  wdata <= 16'h0700;  pdlysty <= 2'd0;       end 
                  7'd12:  begin  wdata <= 16'h0003;  pdlysty <= 2'd0;       end 
                  7'd13:  begin  wdata <= 16'h1028;  pdlysty <= 2'd0;       end                                                      
                  7'd14:  begin  wdata <= 16'h0004;  pdlysty <= 2'd0;       end  
                  7'd15:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end 

                  7'd16:  begin  wdata <= 16'h0008;  pdlysty <= 2'd0;       end 
                  7'd17:  begin  wdata <= 16'h0808;  pdlysty <= 2'd0;       end                     
                  7'd18:  begin  wdata <= 16'h0009;  pdlysty <= 2'd0;       end  
                  7'd19:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end 
                  7'd20:  begin  wdata <= 16'h000a;  pdlysty <= 2'd0;       end 
                  7'd21:  begin  wdata <= 16'h0008;  pdlysty <= 2'd0;       end                                      
                  7'd22:  begin  wdata <= 16'h000c;  pdlysty <= 2'd0;       end  
                  7'd23:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end 
                  7'd24:  begin  wdata <= 16'h000d;  pdlysty <= 2'd0;       end 
                  7'd25:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                   
                  7'd26:  begin  wdata <= 16'h000f;  pdlysty <= 2'd0;       end  
                  7'd27:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end 
                  7'd28:  begin  wdata <= 16'h0010;  pdlysty <= 2'd0;       end     //-- power on sequence
                  7'd29:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                                                         
                  7'd30:  begin  wdata <= 16'h0011;  pdlysty <= 2'd0;       end  
                  7'd31:  begin  wdata <= 16'h0007;  pdlysty <= 2'd0;       end 
                  
                  7'd32:  begin  wdata <= 16'h0012;  pdlysty <= 2'd0;       end 
                  7'd33:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                          
                  7'd34:  begin  wdata <= 16'h0013;  pdlysty <= 2'd0;       end 
                  7'd35:  begin  wdata <= 16'h0000;  pdlysty <= 2'd3;       end     //-- delay 200ms;  Discharge capacitor power voltage                 
                  7'd36:  begin  wdata <= 16'h0010;  pdlysty <= 2'd0;       end  
                  7'd37:  begin  wdata <= 16'h1190;  pdlysty <= 2'd0;       end     //-- SAP
                  7'd38:  begin  wdata <= 16'h0011;  pdlysty <= 2'd0;       end     
                  7'd39:  begin  wdata <= 16'h0227;  pdlysty <= 2'd2;       end     //-- delay 50ms;                                                        
                  7'd40:  begin  wdata <= 16'h0012;  pdlysty <= 2'd0;       end  
                  7'd41:  begin  wdata <= 16'h001d;  pdlysty <= 2'd2;       end     //-- delay 50ms;
                  7'd42:  begin  wdata <= 16'h0013;  pdlysty <= 2'd0;       end 
                  7'd43:  begin  wdata <= 16'h1a00;  pdlysty <= 2'd0;       end                       
                  7'd44:  begin  wdata <= 16'h0029;  pdlysty <= 2'd0;       end 
                  7'd45:  begin  wdata <= 16'h0035;  pdlysty <= 2'd0;       end                   
                  7'd46:  begin  wdata <= 16'h002b;  pdlysty <= 2'd0;       end  
                  7'd47:  begin  wdata <= 16'h000d;  pdlysty <= 2'd2;       end      //-- delay 50ms;
                   
                  7'd48:  begin  wdata <= 16'h0020;  pdlysty <= 2'd0;       end     
                  7'd49:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end      //-- GRAM horizontal Address                   
                  7'd50:  begin  wdata <= 16'h0021;  pdlysty <= 2'd0;       end      //-- GRAM Vertical Address
                  7'd51:  begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end     
                  7'd52:  begin  wdata <= 16'h0030;  pdlysty <= 2'd0;       end      //-- Adjust the Gamma Curve
                  7'd53:  begin  wdata <= 16'h0001;  pdlysty <= 2'd0;       end     
                  7'd54:  begin  wdata <= 16'h0031;  pdlysty <= 2'd0;       end 
                  7'd55:  begin  wdata <= 16'h0507;  pdlysty <= 2'd0;       end     
                  7'd56:  begin  wdata <= 16'h0032;  pdlysty <= 2'd0;       end  
                  7'd57:  begin  wdata <= 16'h0305;  pdlysty <= 2'd0;       end     
                  7'd58:  begin  wdata <= 16'h0035;  pdlysty <= 2'd0;       end     
                  7'd59:  begin  wdata <= 16'h0103;  pdlysty <= 2'd0;       end     
                  7'd60:  begin  wdata <= 16'h0036;  pdlysty <= 2'd0;       end  
                  7'd61:  begin  wdata <= 16'h1c0c;  pdlysty <= 2'd0;       end     
                  7'd62:  begin  wdata <= 16'h0037;  pdlysty <= 2'd0;       end 
                  7'd63:  begin  wdata <= 16'h0103;  pdlysty <= 2'd0;       end                       
                  
                   7'd64: begin  wdata <= 16'h0038;  pdlysty <= 2'd0;       end 
                   7'd65: begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                       
                   7'd66: begin  wdata <= 16'h0039;  pdlysty <= 2'd0;       end  
                   7'd67: begin  wdata <= 16'h0707;  pdlysty <= 2'd0;       end     
                   7'd68: begin  wdata <= 16'h003c;  pdlysty <= 2'd0;       end     
                   7'd69: begin  wdata <= 16'h0301;  pdlysty <= 2'd0;       end     
                   7'd70: begin  wdata <= 16'h003d;  pdlysty <= 2'd0;       end  
                   7'd71: begin  wdata <= 16'h1b09;  pdlysty <= 2'd0;       end     
                   7'd72: begin  wdata <= 16'h0050;  pdlysty <= 2'd0;       end   //-- Set GRAM area;  Horizontal GRAM Start Address
                   7'd73: begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                       
                   7'd74: begin  wdata <= 16'h0051;  pdlysty <= 2'd0;       end 
                   7'd75: begin  wdata <= 16'h00ef;  pdlysty <= 2'd0;       end   //-- Horizontal GRAM End Address  240
                   7'd76: begin  wdata <= 16'h0052;  pdlysty <= 2'd0;       end  
                   7'd77: begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end   //-- Vertical GRAM Start Address  
                   7'd78: begin  wdata <= 16'h0053;  pdlysty <= 2'd0;       end     
                   7'd79: begin  wdata <= 16'h013f;  pdlysty <= 2'd0;       end   //-- Vertical GRAM Start Address  320  
                  
                    7'd80:begin  wdata <= 16'h0060;  pdlysty <= 2'd0;       end  
                    7'd81:begin  wdata <= 16'ha700;  pdlysty <= 2'd0;       end   //-- Gate Scan Line  
                    7'd82:begin  wdata <= 16'h0061;  pdlysty <= 2'd0;       end     
                    7'd83:begin  wdata <= 16'h0001;  pdlysty <= 2'd0;       end   //-- NDL,VLE  
                    7'd84:begin  wdata <= 16'h006a;  pdlysty <= 2'd0;       end 
                    7'd85:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end   //-- set scrolling line  
                    7'd86:begin  wdata <= 16'h0080;  pdlysty <= 2'd0;       end  
                    7'd87:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end     
                    7'd88:begin  wdata <= 16'h0081;  pdlysty <= 2'd0;       end     
                    7'd89:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end     
                    7'd90:begin  wdata <= 16'h0082;  pdlysty <= 2'd0;       end  
                    7'd91:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end     
                    7'd92:begin  wdata <= 16'h0083;  pdlysty <= 2'd0;       end 
                    7'd93:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                       
                    7'd94:begin  wdata <= 16'h0084;  pdlysty <= 2'd0;       end 
                    7'd95:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                      
                   
                    7'd96: begin  wdata <= 16'h0085;  pdlysty <= 2'd0;       end  
                    7'd97: begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end
                    7'd98: begin  wdata <= 16'h0090;  pdlysty <= 2'd0;       end  
                    7'd99: begin  wdata <= 16'h0010;  pdlysty <= 2'd0;       end    
                    7'd100:begin  wdata <= 16'h0092;  pdlysty <= 2'd0;       end 
                    7'd101:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                                      
                    7'd102:begin  wdata <= 16'h0093;  pdlysty <= 2'd0;       end  
                    7'd103:begin  wdata <= 16'h0003;  pdlysty <= 2'd0;       end 
                    7'd104:begin  wdata <= 16'h0095;  pdlysty <= 2'd0;       end 
                    7'd105:begin  wdata <= 16'h0110;  pdlysty <= 2'd0;       end                   
                    7'd106:begin  wdata <= 16'h0097;  pdlysty <= 2'd0;       end  
                    7'd107:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end 
                    7'd108:begin  wdata <= 16'h0098;  pdlysty <= 2'd0;       end     
                    7'd109:begin  wdata <= 16'h0000;  pdlysty <= 2'd0;       end                                                                             
                    7'd110:begin  wdata <= 16'h0007;  pdlysty <= 2'd0;       end  
                    7'd111:begin  wdata <= 16'h0133;  pdlysty <= 2'd0;       end                                                                                                                                                                                                                                                                                                     
              endcase
         end
end


//==================== display data write ===============================================

assign dispdrq = (wstyle==2'd2 && wdone==1'b1)? 1'b1 : 1'b0;

always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               dctrl <= DISP_IDLE;     

               disprown <= 9'd0;
               dispcoln <= 8'd0;
               dispwrti <= 1'b0;     
               wlast <= 1'b0;        
     	  end
     else 
          begin
               case(dctrl)
                   DISP_IDLE:
                         begin
                              if(dispstart==1'b1)            //-- ��ʾ���ݿ��Կ�ʼд�룻
                                 begin
                                      dctrl <= DISP_FRMI;
                                 end
                         end
                         
                   DISP_FRMI:
                         begin
                              if(dispinit==1'b1)             //-- ��ʾ��֡Ϊ��λ��һ֡����һ�Σ�
                                 begin
                                      dctrl <= DISP_FRMW0;
                                 end
                         end
                         
                   DISP_FRMW0:
                         begin
                              disprown <= 9'd0;
                              dispcoln <= 8'd0;
                              dispwrti <= 1'b1;     //-- keep 1clk;
                              wlast <= 1'b0;
                              dctrl <= DISP_FRMW1;
                         end
                         
                   DISP_FRMW1:
                         begin
                              dispwrti <= 1'b0;     //-- keep 1clk;
                              
                              if(wdone==1'b1)
                                 begin
                                      if(displast==1'b1)
                                         begin
                                              dctrl <= DISP_FRMI;
                                         end
                                 end
                              
                         end                       
                         
               endcase
          end
end



reg [4:0]pixdat;
reg pixadd;
always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               pixdat <= 5'd0;
               pixadd <= 1'b1;
     	  end
     else 
          begin
               if(dispfrmi==1'b1)
                  begin
                       if(pixdat==5'd1)
                          begin
                              pixadd <= 1'b1;
                          end
                       else
                          begin
                              if(pixdat==5'd30)
                                 begin
                                      pixadd <= 1'b0;
                                 end
                          end
                       
                       if(pixadd==1'b1)
                          begin  
                               pixdat <= pixdat + 1'b1;
                          end
                       else
                          begin
                               pixdat <= pixdat - 1'b1;
                          end
                  end
          end
end                         

always @(posedge clk or negedge rstn) 
begin
     if(!rstn)
     	  begin
               wpixdata <= 16'h0000;                  //-- ��ʾ���ݣ�
     	  end
     else 
          begin
               if(disprown[8]==1'b1)               //-- ����ɫ��ʾ��
                  begin
                      //-- wpixdata <= 16'h001f;
                       wpixdata <= {11'd0,pixdat[4:0]};
                  end
               else
                  begin
                       if(disprown[7]==1'b1)
                          begin
                              //-- wpixdata <= 16'h07e0;
                               wpixdata <= {5'd0,1'b0,pixdat[4:0],5'd0};
                          end
                       else
                          begin
                              //-- wpixdata <= 16'hf800;
                               wpixdata <= {pixdat[4:0],11'd0};
                          end
                  end
          end
end



assign test = dispfrmi;

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
                   
                dispfrmi <= time40ms;           //-- 25fps;  ��ʾ֡Ƶ�趨Ϊ25fps��
          end
end

//==========================================================================================
	
endmodule