//---------------REV1.0------------------------

//--------芯视清视频开发工作室------------------

//---------hevc265.taobao.com-------------------



`timescale 1ns / 1ps
module video_saa(
		 rstn,	
                 clk100M,
                 pllok,                 
                 saa_sclk,
                 saa_sdat,
                 saa_llc,
                 saa_vpo,
                 
                 rgbdo,
                 rgbwe,
                 rgbwa,                 
                 vdatawi,
                 vdatawf,                                                                   
                 test		  		  
		);     
			  
			  
			  
input rstn;	
input clk100M;
input pllok;

output saa_sclk;
inout  saa_sdat;
input  saa_llc;
input  [7:0]saa_vpo;


output [31:0]rgbdo;
output rgbwe;
output [5:0]rgbwa;


output vdatawi;
output vdatawf;

output test;




//--------------------
wire test;


reg vdatawi;
reg vdatawf;

reg [7:0]vin01_wdi;
reg [9:0]vin01_wa;
reg vin01_we;


//--------------------

reg i2cseti;

reg i2c_sclk;
reg clk200k;

reg [22:0]twcnt1;
reg [8:0]clkcnt;

reg i2c_init;
reg i2c_init1;
reg [7:0]i2c_cnt;

reg [7:0]i2c_rdata;

reg i2c_sdat;
reg i2c_oe;



//----------------------

reg [7:0]vin0d1;
reg [7:0]vin0d2;
reg [7:0]vin0d3;
reg [7:0]vin0d4;

reg [7:0]vin1d1;
reg [7:0]vin1d2;
reg [7:0]vin1d3;
reg [7:0]vin1d4;

reg vin_syni;
reg vin_sav;
reg vin_odd;
reg vin_fldi;

reg ch1_syni;
reg ch1_sav;
reg ch1_odd;
reg ch1_fldi;

reg [7:0]vin0_wdi0;
reg vin_vld;
reg [7:0]vin0_wa00;
reg [7:0]vin0_wa0;
reg [5:0]vin0_cwa0;
reg vin_yflg;
reg vin_uflg;
reg [10:0]rowrspcnt;
reg rowtime;
reg [6:0]vin0_wcnt;
reg vin0_wtfrmf;
reg vin0_wtrowf;
reg vin0_fstd;


						
//------------------------------

assign test = vin_fldi;

reg i2crwi;
reg [7:0]i2c_waddr;
reg [7:0]i2c_wdata;
reg i2cwflg;

reg twinit;
reg [6:0]i2cwcnt;
reg [7:0]i2ctcnt;

reg [2:0]i2c_ctrl;

parameter I2C_IDLE   = 3'd0;
parameter I2C_SET    = 3'd1;
parameter I2C_END    = 3'd2;
 
assign saa_sdat = (i2c_oe==1'b1)? i2c_sdat : 1'bz;    
assign saa_sclk = i2c_sclk;

always @(posedge clk100M or negedge rstn) 
begin
if(!rstn)
   begin
        clkcnt <= 9'd0;
        clk200k <= 1'b0;
   end
else
   begin          
        clkcnt <= clkcnt + 1'b1;
        clk200k <= clkcnt[8];      
   end
end


reg seti0;
reg seti1;

always @(posedge clk200k or negedge rstn) 
begin
if(!rstn)
   begin
        i2cseti <= 1'b0;
        
        seti0 <= 1'b0;
        seti1 <= 1'b0;
   end
else
   begin          
        seti0 <= pllok;
        seti1 <= seti0;
        
        if(seti1==1'b0&&seti0==1'b1&&pllok==1'b1)
            begin
                 i2cseti <= 1'b1;
            end
        else
            begin
                 i2cseti <= 1'b0;
            end
   end
end

always @(posedge clk200k or negedge rstn) 
begin
     if(!rstn)
     	  begin
               i2crwi <= 1'b0;
               i2c_waddr <= 8'd0;
               i2c_wdata <= 8'd0;
               i2cwflg <= 1'b0;
               i2ctcnt <= 8'd0;
               i2cwcnt <= 7'd0;

               
               i2c_ctrl <= I2C_IDLE;
     	  end
     else 
          begin
               case(i2c_ctrl)
                   I2C_IDLE:
                       begin
                            i2ctcnt <= 8'd0;
      
                            if(i2cseti==1'b1)
                               begin
                                    i2c_ctrl <= I2C_SET;
                                    i2cwcnt <=7'd0;
                               end
                       end
                   
                   I2C_SET:
                       begin
                            i2cwcnt <= i2cwcnt + 1'b1;
                            
                            i2crwi <= 1'b1;
                            i2cwflg <= 1'b1;
                            i2ctcnt <= 8'd0;
                            case(i2cwcnt)
                                7'd0:   begin  i2c_waddr <= 8'h01;  i2c_wdata <= 8'h08;  end
                                7'd1:   begin  i2c_waddr <= 8'h02;  i2c_wdata <= 8'hd0;  end
                                7'd2:   begin  i2c_waddr <= 8'h03;  i2c_wdata <= 8'h30;  end   
                                7'd3:   begin  i2c_waddr <= 8'h04;  i2c_wdata <= 8'h00;  end  
                                7'd4:   begin  i2c_waddr <= 8'h05;  i2c_wdata <= 8'h00;  end  
                                7'd5:   begin  i2c_waddr <= 8'h06;  i2c_wdata <= 8'he9;  end  
                                7'd6:   begin  i2c_waddr <= 8'h07;  i2c_wdata <= 8'h0d;  end  
                                7'd7:   begin  i2c_waddr <= 8'h08;  i2c_wdata <= 8'hb8;  end     
                                
                                7'd8:   begin  i2c_waddr <= 8'h09;  i2c_wdata <= 8'h00;  end
                                7'd9:   begin  i2c_waddr <= 8'h0a;  i2c_wdata <= 8'h80;  end
                                7'd10:  begin  i2c_waddr <= 8'h0b;  i2c_wdata <= 8'h47;  end   
                                7'd11:  begin  i2c_waddr <= 8'h0c;  i2c_wdata <= 8'h40;  end  
                                7'd12:  begin  i2c_waddr <= 8'h0d;  i2c_wdata <= 8'h00;  end  
                                7'd13:  begin  i2c_waddr <= 8'h0e;  i2c_wdata <= 8'h01;  end  
                                7'd14:  begin  i2c_waddr <= 8'h0f;  i2c_wdata <= 8'h2a;  end  
                                7'd15:  begin  i2c_waddr <= 8'h10;  i2c_wdata <= 8'h00;  end    
                                
                                7'd16:   begin  i2c_waddr <=8'h11;  i2c_wdata <= 8'h0c;  end
                                7'd17:   begin  i2c_waddr <=8'h12;  i2c_wdata <= 8'h8a;  end
                                7'd18:   begin  i2c_waddr <=8'h13;  i2c_wdata <= 8'h00;  end   
                                7'd19:   begin  i2c_waddr <=8'h14;  i2c_wdata <= 8'h00;  end  
                                7'd20:   begin  i2c_waddr <=8'h15;  i2c_wdata <= 8'h15;  end  
                                7'd21:   begin  i2c_waddr <=8'h16;  i2c_wdata <= 8'h1a;  end  
                                7'd22:   begin  i2c_waddr <=8'h17;  i2c_wdata <= 8'h02;  end  
                                7'd23:   begin  i2c_waddr <=8'h18;  i2c_wdata <= 8'h00;  end     
                                
                                7'd24:   begin  i2c_waddr <=8'h19;  i2c_wdata <= 8'h00;  end
                                7'd25:   begin  i2c_waddr <=8'h1a;  i2c_wdata <= 8'h00;  end
                                7'd26:   begin  i2c_waddr <=8'h1b;  i2c_wdata <= 8'h00;  end   
                                7'd27:   begin  i2c_waddr <=8'h1c;  i2c_wdata <= 8'h00;  end  
                                7'd28:   begin  i2c_waddr <=8'h1d;  i2c_wdata <= 8'h00;  end  
                                7'd29:   begin  i2c_waddr <=8'h1e;  i2c_wdata <= 8'h00;  end  
                                7'd30:   begin  i2c_waddr <=8'h40;  i2c_wdata <= 8'h02;  end  
                                7'd31:   begin  i2c_waddr <=8'h41;  i2c_wdata <= 8'hff;  end    
                                
                                7'd32:   begin  i2c_waddr <=8'h42;  i2c_wdata <= 8'hff;  end 
                                7'd33:   begin  i2c_waddr <=8'h43;  i2c_wdata <= 8'hff;  end 
                                7'd34:   begin  i2c_waddr <=8'h44;  i2c_wdata <= 8'hff;  end 
                                7'd35:   begin  i2c_waddr <=8'h45;  i2c_wdata <= 8'hff;  end 
                                7'd36:   begin  i2c_waddr <=8'h46;  i2c_wdata <= 8'hff;  end 
                                7'd37:   begin  i2c_waddr <=8'h47;  i2c_wdata <= 8'hff;  end 
                                7'd38:   begin  i2c_waddr <=8'h48;  i2c_wdata <= 8'hff;  end 
                                7'd39:   begin  i2c_waddr <=8'h49;  i2c_wdata <= 8'hff;  end 
                                
                                7'd40:   begin  i2c_waddr <=8'h4a;  i2c_wdata <= 8'hff;  end 
                                7'd41:   begin  i2c_waddr <=8'h4b;  i2c_wdata <= 8'hff;  end 
                                7'd42:   begin  i2c_waddr <=8'h4c;  i2c_wdata <= 8'hff;  end   
                                7'd43:   begin  i2c_waddr <=8'h4d;  i2c_wdata <= 8'hff;  end  
                                7'd44:   begin  i2c_waddr <=8'h4e;  i2c_wdata <= 8'hff;  end  
                                7'd45:   begin  i2c_waddr <=8'h4f;  i2c_wdata <= 8'hff;  end  
                                7'd46:   begin  i2c_waddr <=8'h50;  i2c_wdata <= 8'hff;  end  
                                7'd47:   begin  i2c_waddr <=8'h51;  i2c_wdata <= 8'hff;  end     
                                
                                7'd48:   begin  i2c_waddr <=8'h52;  i2c_wdata <= 8'hff;  end 
                                7'd49:   begin  i2c_waddr <=8'h53;  i2c_wdata <= 8'hff;  end 
                                7'd50:   begin  i2c_waddr <=8'h54;  i2c_wdata <= 8'hff;  end   
                                7'd51:   begin  i2c_waddr <=8'h55;  i2c_wdata <= 8'hff;  end  
                                7'd52:   begin  i2c_waddr <=8'h56;  i2c_wdata <= 8'hff;  end  
                                7'd53:   begin  i2c_waddr <=8'h57;  i2c_wdata <= 8'hff;  end  
                                7'd54:   begin  i2c_waddr <=8'h58;  i2c_wdata <= 8'h40;  end  
                                7'd55:   begin  i2c_waddr <=8'h59;  i2c_wdata <= 8'h54;  end     
                                
                                7'd56:   begin  i2c_waddr <=8'h5a;  i2c_wdata <= 8'h07;  end 
                                7'd57:   begin  i2c_waddr <=8'h5b;  i2c_wdata <= 8'h83;  end 
                                7'd58:   begin  i2c_waddr <=8'h5c;  i2c_wdata <= 8'h00;  end   
                                7'd59:   begin  i2c_waddr <=8'h5d;  i2c_wdata <= 8'h00;  end  
                                7'd60:   begin  i2c_waddr <=8'h5e;  i2c_wdata <= 8'h00;  end  
                                7'd61:   begin  i2c_waddr <=8'h5f;  i2c_wdata <= 8'h00;  end                                                                                                                                                                                                                                                   
                                
                            endcase
                            
                            i2c_ctrl <=  I2C_END;
                       end
                       
                   I2C_END:
                       begin
                            i2crwi <= 1'b0;
                            i2ctcnt <= i2ctcnt + 1'b1;
                               
                            if(i2ctcnt[7:0]==8'd160)
                               begin
                                    if(i2cwcnt==7'd62)    
                                       begin
                                            i2c_ctrl <= I2C_IDLE;
                                       end
                                    else
                                       begin
                                            i2c_ctrl <= I2C_SET;
                                       end
                               end
                       end
              endcase                       
          end
end





always @(posedge clk200k or negedge rstn)          
begin
    if(!rstn)
       begin
            i2c_cnt <= 8'd0;
       end
    else
       begin
            if(i2crwi==1'b1)   
               begin
                    if(i2cwflg==1'b1)
                       begin
                           i2c_cnt[7] <= 1'b1;
                       end
                    else
                       begin
                           i2c_cnt[7] <= 1'b0;
                       end
                    i2c_cnt[6:0] <= 7'd1;
               end
            else
               begin
                    if(i2c_cnt[6:0]!=7'd0)
                       begin
                            i2c_cnt <= i2c_cnt + 1'b1;
                       end
               end       
       end
end


always @(posedge clk200k or negedge rstn)            //-- I2C PART
begin
if(!rstn)
   begin
        i2c_sclk <= 1'b1;
        
        i2c_init <= 1'b0;
        i2c_init1 <= 1'b0;
   end
else
   begin        
        if(i2c_cnt[7]==1'b0)
           begin   
               if(i2c_cnt[6]==1'b0 || (i2c_cnt[5]==1'b0&&(i2c_cnt[4]==0||(i2c_cnt[3:2]==2'b00||i2c_cnt[3:0]==4'b0100))))
                  begin
                      if(i2c_cnt[6:0]==6'd0)
                         begin
                              i2c_sclk <= 1'b1;
                         end
                      else
                         begin
                              if(i2c_cnt[6:3]==4'b0101 && i2c_cnt[2:1]!=2'b00)  //-- 42~47
                                 begin
                                      i2c_sclk <= 1'b1;
                                 end
                              else
                                 begin
                                      i2c_sclk <= i2c_cnt[0];
                                 end
                         end
                  end
               else
                  begin
                       i2c_sclk <= 1'b1;
                  end
           end
        else
           begin
                if(i2c_cnt[6]==1'b0)
                   begin
                      if(i2c_cnt[5:0]==5'd0)
                         begin
                              i2c_sclk <= 1'b1;
                         end
                      else
                         begin
                              if(i2c_cnt[5:2]==4'b1111)
                                 begin
                                      i2c_sclk <= 1'b1;
                                 end
                              else
                             begin
                                  i2c_sclk <= i2c_cnt[0];
                             end
                         end                   
                   end
                else
                   begin
                       i2c_sclk <= 1'b1;  
                   end 
           end
                                     
   end
end  




always @(negedge clk200k or negedge rstn)        
begin
if(!rstn)
   begin
        i2c_sdat <= 1'b1;
        i2c_oe <= 1'b1;
   end
else
   begin
      if(i2c_cnt[7]==1'b0)                     //-- read
          begin
             if(i2c_cnt[0]==1'b1)
                begin
                     case(i2c_cnt[6:1])
                        6'd0:  i2c_sdat <= 1'b0;    //-- start;
                        
                        6'd1:  i2c_sdat <= 1'b0;    //-- slave addr;  4A
                        6'd2:  i2c_sdat <= 1'b1;    //-- slave addr;
                        6'd3:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd4:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd5:  i2c_sdat <= 1'b1;    //-- slave addr;
                        6'd6:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd7:  i2c_sdat <= 1'b1;    //-- slave addr;        
                        6'd8:  i2c_sdat <= 1'b0;    //-- write;            //-- read=1 ; write=0;
                        
                        6'd9:  i2c_sdat <= 1'b0;
                        
                        6'd10: i2c_sdat <= 1'b1;    //-- sub addr;
                        6'd11: i2c_sdat <= 1'b1;
                        6'd12: i2c_sdat <= 1'b1;
                        6'd13: i2c_sdat <= 1'b1;
                        6'd14: i2c_sdat <= 1'b1;
                        6'd15: i2c_sdat <= 1'b0;
                        6'd16: i2c_sdat <= 1'b1;
                        6'd17: i2c_sdat <= 1'b0;
                        
                        6'd18: i2c_sdat <= 1'b0;
                        6'd19: i2c_sdat <= 1'b0;
                        6'd20: i2c_sdat <= 1'b1;   //-- stop;
                        6'd21: i2c_sdat <= 1'b1;   //-- start;
                        6'd22: i2c_sdat <= 1'b0;
                                          
                        6'd23: i2c_sdat <= 1'b0;   //-- slave addr; 4B
                        6'd24: i2c_sdat <= 1'b1;
                        6'd25: i2c_sdat <= 1'b0;
                        6'd26: i2c_sdat <= 1'b0;
                        6'd27: i2c_sdat <= 1'b1;
                        6'd28: i2c_sdat <= 1'b0;
                        6'd29: i2c_sdat <= 1'b1;
                        6'd30: i2c_sdat <= 1'b1;   //-- read; 
                        
                        6'd31,
                        6'd32,
                        6'd33,
                        6'd34,
                        6'd35,
                        6'd36,
                        6'd37,
                        6'd38,
                        6'd39,
                        6'd40,
                        6'd41,
                        6'd42,
                        6'd43:   i2c_sdat <= 1'b0;                                      
                        default: i2c_sdat <= 1'b1;  //-- 5'd20-->5'd21  0-->1 stop;
                     endcase                    
                end  
             else
                begin
                     if(i2c_cnt[6:1]==5'd0)
                        begin
                             i2c_sdat <= 1'b1;
                        end
                end
         end
      else                                    //-- write;
         begin
             if(i2c_cnt[0]==1'b1)
                begin
                     case(i2c_cnt[6:1])
                        6'd0:  i2c_sdat <= 1'b0;    //-- start;
                        
                        6'd1:  i2c_sdat <= 1'b0;    //-- slave addr;  4A
                        6'd2:  i2c_sdat <= 1'b1;    //-- slave addr;
                        6'd3:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd4:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd5:  i2c_sdat <= 1'b1;    //-- slave addr;
                        6'd6:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd7:  i2c_sdat <= 1'b1;    //-- slave addr;        
                        6'd8:  i2c_sdat <= 1'b0;    //-- write;           
                        
                        6'd9:  i2c_sdat <= 1'b0;    //-- ack time;
                         

                        6'd10: i2c_sdat <= i2c_waddr[7];    //-- sub addr;
                        6'd11: i2c_sdat <= i2c_waddr[6];
                        6'd12: i2c_sdat <= i2c_waddr[5];
                        6'd13: i2c_sdat <= i2c_waddr[4];
                        6'd14: i2c_sdat <= i2c_waddr[3];
                        6'd15: i2c_sdat <= i2c_waddr[2];
                        6'd16: i2c_sdat <= i2c_waddr[1];
                        6'd17: i2c_sdat <= i2c_waddr[0];  
                        
                        6'd18: i2c_sdat <= 1'b0;    //-- ack time;
                        
                        
                        
                        6'd19: i2c_sdat <= i2c_wdata[7];    //-- wrt data;
                        6'd20: i2c_sdat <= i2c_wdata[6];    //-- wrt data;
                        6'd21: i2c_sdat <= i2c_wdata[5];    //-- wrt data;  
                        6'd22: i2c_sdat <= i2c_wdata[4];    //-- wrt data;
                        6'd23: i2c_sdat <= i2c_wdata[3];    //-- wrt data;
                        6'd24: i2c_sdat <= i2c_wdata[2];    //-- wrt data;
                        6'd25: i2c_sdat <= i2c_wdata[1];    //-- wrt data;
                        6'd26: i2c_sdat <= i2c_wdata[0];    //-- wrt data;                           
                        
                        6'd27,
                        6'd28,
                        6'd29,
                        6'd30: i2c_sdat <= 1'b0;                                      
                        default: i2c_sdat <= 1'b1;  
                     endcase 
                end
             else
                begin
                     if(i2c_cnt[6:1]==5'd0)
                        begin
                             i2c_sdat <= 1'b1;
                        end
                end                                                 
         end
       
       
       if(i2c_cnt[7]==1'b0)
          begin    
               if(i2c_cnt[0]==1'b1)
                  begin
                       if(i2c_cnt[6]==1'b0)
                          begin
                               if(i2c_cnt[5:1]==5'b01001 || i2c_cnt[5:1]==5'b10010 || i2c_cnt[5:1]==5'b11111)
                                  begin
                                       i2c_oe <= 1'b0;
                                  end
                               else
                                  begin
                                       i2c_oe <= 1'b1;
                                  end
                          end
                       else
                          begin
                              if(i2c_cnt[5:1]==5'b01000 || i2c_cnt[5:4]==2'b00)
                                  begin
                                       i2c_oe <= 1'b0;
                                  end
                               else
                                  begin
                                       i2c_oe <= 1'b1;
                                  end
                          end
                  end
               else
                  begin
                       if(i2c_cnt[6:1]==6'd0)
                          begin
                               i2c_oe <= 1'b1;
                          end
                  end
          end
       else
          begin
               if(i2c_cnt[0]==1'b1)
                  begin              
                      if(i2c_cnt[6:1]==6'd9 || i2c_cnt[6:1]==6'd18 || i2c_cnt[6:1]==6'd27)
                         begin
                             i2c_oe <= 1'b0;
                         end
                      else
                         begin
                             i2c_oe <= 1'b1;
                         end
                  end
               else
                  begin
                      if(i2c_cnt[6:1]==6'd0)
                         begin
                             i2c_oe <= 1'b1; 
                         end
                  end
          end
           

       
   end
end



always @(negedge clk200k or negedge rstn)           
begin
if(!rstn)
   begin       
        i2c_rdata <= 8'd0;
   end
else
   begin           
        if(i2c_cnt[0]==1'b0&&i2c_cnt[7]==1'b0)
           begin
                case(i2c_cnt[6:1])
                    6'd33: i2c_rdata[7]<= saa_sdat;
                    6'd34: i2c_rdata[6]<= saa_sdat;
                    6'd35: i2c_rdata[5]<= saa_sdat;
                    6'd36: i2c_rdata[4]<= saa_sdat;
                    6'd37: i2c_rdata[3]<= saa_sdat;
                    6'd38: i2c_rdata[2]<= saa_sdat;
                    6'd39: i2c_rdata[1]<= saa_sdat;
                    6'd40: i2c_rdata[0]<= saa_sdat;
                endcase
           end                       
   end
end



  
   
//------------ITU656 decoder-------------- 
   

always @(posedge saa_llc or negedge rstn) 
begin
if(!rstn)
   begin
   
        vin0d1 <= 8'd0;
        vin0d2 <= 8'd0;
        vin0d3 <= 8'd0;
        vin0d4 <= 8'd0;
        
        vin1d1 <= 8'd0;
        vin1d2 <= 8'd0;
        vin1d3 <= 8'd0;
        vin1d4 <= 8'd0;        
        
        vin_syni <= 1'b0;
        vin_sav <= 1'b0;
        vin_odd <= 1'b0;
        vin_fldi <= 1'b0;  
        
        ch1_syni <= 1'b0;
        ch1_sav <= 1'b0;
        ch1_odd <= 1'b0;
        ch1_fldi <= 1'b0;         
                     
   end
else
   begin
                vin0d1 <= saa_vpo[7:0];   
                vin0d2 <= vin0d1;
                vin0d3 <= vin0d2;
                vin0d4 <= vin0d3;

                if(vin0d4==8'hff && vin0d3==8'h00 && vin0d2==8'h00)
                   begin
                        vin_syni <= 1'b1;      
                   end
                else
                   begin
                        vin_syni <= 1'b0;
                   end           
           
                if(vin_syni==1'b1)
                   begin                  
                        if(vin0d2[7:4]==4'h8)      //-- 1st field;  active video;  SAV;
                           begin
                                vin_odd <= 1'b1;
                                if(vin_odd==1'b0)    
                                   begin
                                        vin_fldi <= 1'b1;  //-- 场有效视频信号的起始信号，keep 1clk;  
                                   end
                                else
                                   begin
                                        vin_fldi <= 1'b0;
                                   end                                
                           end
                        else
                           begin
                                if(vin0d2[7:4]==4'hc)      //-- 2st field;  active video;  SAV;
                                   begin
                                        vin_odd <= 1'b0;
                                        if(vin_odd==1'b1)    
                                           begin
                                                vin_fldi <= 1'b1;    //-- 场有效视频信号的起始信号，keep 1clk;  
                                           end
                                        else
                                           begin
                                                vin_fldi <= 1'b0;
                                           end                                        
                                        
                                   end
                                else
                                   begin
                                        vin_fldi <= 1'b0;
                                   end
                           end                                     
                   end 
                 else     
                   begin
                       vin_fldi <= 1'b0;
                   end                


           

                if(vin_syni==1'b1)
                   begin
                        if(vin0d2[7:4]==4'hc || vin0d2[7:4]==4'h8)       
                           begin
                                vin_sav <= 1'b1;       //-- 行有效视频数据的起始信号； keep 1clk; 
                           end
                        else
                           begin
                                vin_sav <= 1'b0;
                           end                                  
                   end
                else
                   begin
                        vin_sav <= 1'b0;
                   end                                       
            
   end
end


reg [8:0]vidrow;
reg rowvld;

always @(posedge saa_llc or negedge rstn) 
begin
if(!rstn)
   begin
   
        vin01_wdi <= 8'd0;
        vin01_wa <= 10'd0;
        vin01_we <= 1'b0;
        
        vin0_wdi0 <= 8'd0;
        vin_vld <= 1'b0;  
        vin0_wa00 <= 8'd0;  
        vin0_wa0 <= 8'd0; 
        vin0_cwa0 <= 6'd0;    
        vin_yflg <= 1'b0;
        vin_uflg <= 1'b0;                
        rowrspcnt <= 11'd0;
        rowtime <= 1'b0;        
        vin0_wcnt <= 7'd0;       
        vin0_wtfrmf <= 1'b0;
        vin0_wtrowf <= 1'b0;
        vin0_fstd <= 1'b0;
        
        vdatawi <= 1'b0;
        vdatawf <= 1'b0; 
        vidrow <= 9'd0;
        rowvld <= 1'b0;
   end
else
   begin                          
                if(vin_sav==1'b1)
                   begin
                        rowrspcnt <= 11'd0;
                        rowtime <= rowvld;
                   end   
                else
                   begin
                        if(rowrspcnt==11'd1279)        //--每一行共采样1280个数据，格式为YUV 4:2:2; 相当于采样 640 个像素点；
                           begin
                                rowtime <= 1'b0;
                           end
                        else
                           begin
                                rowrspcnt <= rowrspcnt + 1'b1;
                           end
                   end
                   
                if(vin_fldi==1'b1)
                   begin
                       vidrow  <= 9'd0;
                       rowvld <= 1'b0;
                   end   
                else
                   begin
                       if(vin_sav==1'b1)
                          begin
                               vidrow <= vidrow + 1'b1;
                          end
                               
                       if(vidrow[8:5]!=4'd0||vidrow[4:3]==2'b11)    //-- 去掉一场视频信号的开始几行，取240行数据；
                           begin
                                rowvld <= 1'b1;
                           end
                        else
                           begin
                                rowvld <= 1'b0;
                           end
                   end
                   
                   
                              
                if(rowtime==1'b1)                   
                   begin
                        if(rowrspcnt[0]==1'b1)     //-- Y data;
                           begin
                                vin_yflg <= 1'b1;
                               //-- vin0_wdi0[7:0]<= rowrspcnt[7:0];
                                vin0_wdi0[7:0]<= vin0d3[7:0];
                                vin_vld <= 1'b1;
                                vin0_wa0 <= vin0_wa00;
                                vin0_wa00 <= vin0_wa00 + 1'b1;
                                if(rowrspcnt[2:1]==2'b11)   
                                   begin
                                        vin0_cwa0 <= vin0_cwa0 + 1'b1;
                                   end                                
                           end
                        else                  //-- U/V data;
                           begin
                                vin_yflg <= 1'b0;
                                
                                if(rowrspcnt[1]==1'b0)
                                   begin
                                        vin_uflg <= 1'b1;   //-- U data;
                                   end
                                else
                                   begin
                                        vin_uflg <= 1'b0;   //-- V data;
                                   end 
                                   
                                //--vin0_wdi0[7:0]<= rowrspcnt[7:0];
                                vin0_wdi0[7:0]<= vin0d3[7:0];
                                vin_vld <= 1'b1;                                   
                           end                           
                   end
                else
                   begin
                        vin_vld <= 1'b0;

                        if(vin_fldi==1'b1)
                           begin
                                vin0_wa00 <= 8'd0;   
                                vin0_cwa0 <= 6'd0; 
                           end
                   end
                   
                if(vin_fldi==1'b1)              
                   begin
                        vin0_wcnt <= 7'd0;
                        vdatawi <= 1'b0;
                        vdatawf <= 1'b0;    
                        vin0_wtfrmf <= 1'b1;
                        vin0_wtrowf <= 1'b1;
                        vin01_we <= 1'b0;
                        vin01_wa <= 10'd0;
                   end   
                else
                   begin
                       if(vin_vld==1'b1)
                          begin
                              vin01_we <= 1'b1;
                              
                              vin01_wdi[7:0]<= vin0_wdi0;         
                             
                              vin01_wa[9] <= 1'b0;          
                              if(vin_yflg==1'b1)
                                 begin
                                      vin01_wa[8] <= 1'b0;             
                                      vin01_wa[7:0] <= vin0_wa0[7:0];
                                 end
                              else
                                 begin
                                      vin01_wa[8] <= 1'b1;
                                      vin01_wa[7] <= 1'b0;   
                                      if(vin_uflg==1'b0)      
                                         begin
                                              vin01_wa[0] <= 1'b1;  
                                         end
                                      else
                                         begin
                                              vin01_wa[0] <= 1'b0;    
                                         end
                                      
                                      vin01_wa[6:1] <= vin0_cwa0[5:0];     
                                 end
                              
                              if(vin_yflg==1'b1)
                                 begin
                                      vin0_wcnt <= vin0_wcnt + 1'b1;
                                      if(vin0_wcnt[6:0]===7'd127)     
                                         begin                                               
                                              vin0_wtfrmf <= 1'b0;
                                              vin0_wtrowf <= 1'b0;
                                              if(vin0_wtfrmf==1'b1)
                                                 begin   
                                                      vdatawf <= 1'b1;  //-- 表明该批次数据为一场视频的起始数据；
                                                 end
                                              else
                                                 begin
                                                     vdatawf <= 1'b0;
                                                 end
                                              
                                             //-- vdatawi <= 1'b1;   
                                              vdatawi <=  vin_odd; ;     //-- keep 1clk; =1说明已经获取一批视频数据，可作为写入外部DDR的启动信号；                                             
                                         end                             //-- 此例中只输出奇偶场中的一场
                                      else
                                         begin
                                              vdatawi <= 1'b0;
                                         end                                                 
                                 end
                              else
                                 begin
                                      vdatawi <= 1'b0;
                                 end
                                                                                
                          end
                       else
                          begin
                               vdatawi <= 1'b0;
                               vin01_we <= 1'b0;
                          end
                   end        
   end
end




//----------- YUV-->RGB -------------

reg [31:0]rgbdo;
reg rgbwe;
reg [5:0]rgbwa;

reg [7:0]ydata;
reg [7:0]udata;
reg [7:0]vdata;

reg [7:0]ydtmp;
reg [7:0]udtmp;
reg [7:0]vdtmp;

reg yuvvld;
reg [6:0]yuvwa;



reg [8:0]signy;
reg [7:0]signu;
reg [7:0]signv;
reg [8:0]signy1;
reg [7:0]signu1;
reg [7:0]signv1;
reg [8:0]signy2;
reg [7:0]signu2;
reg [7:0]signv2;
reg [8:0]signy3;

reg [14:0]vd96;
reg [10:0]vd7;
reg [14:0]vd103;
reg [8:0]rdoff;
reg [9:0]rdata0;
reg [7:0]rdata;

reg [14:0]ud80;
reg [14:0]ud88;
reg [15:0]vd184;
reg [8:0]gdoff;
reg [9:0]gdata0;
reg [7:0]gdata;

reg [15:0]ud192;
reg [10:0]ud6;
reg [15:0]ud198;
reg [8:0]bdoff;

reg [9:0]bdata0;
reg [7:0]bdata;


reg yuvvld1;
reg yuvvld2;
reg yuvvld3;
reg yuvvld4;
reg yuvvld5;

reg [6:0]yuvwa1;
reg [6:0]yuvwa2;
reg [6:0]yuvwa3;
reg [6:0]yuvwa4;
reg [6:0]yuvwa5;

always @(posedge saa_llc or negedge rstn) 
begin
if(!rstn)
   begin
        ydata <= 8'd0;
        udata <= 8'd0;
        vdata <= 8'd0;     
        ydtmp <= 8'd0;
        udtmp <= 8'd0;
        vdtmp <= 8'd0;   
        
        yuvvld <= 1'b0;  
        yuvwa <= 7'd0;                 
   end
else
   begin
        if(vin01_we==1'b1)
            begin
                 if(vin01_wa[8]==1'b0)
                    begin
                         if(vin01_wa[0]==1'b1)   //-- 输入YUV422采样顺序为U/Y0/V/Y1，此例取U/Y0/Y1作为RGB变换的输入，得到一个RGB像素值；一行共输出320像素值；
                            begin
                                 ydata <= ydtmp;
                                 udata <= udtmp;
                                 vdata <= vdtmp;
                                 yuvvld <= 1'b1;
                                 yuvwa <= vin01_wa[7:1];
                            end
                         else
                            begin
                                 ydtmp <= vin01_wdi[7:0];
                                 yuvvld <= 1'b0;
                            end
                    end
                 else
                    begin
                         yuvvld <= 1'b0;
                         if(vin01_wa[0]==1'b0)
                            begin
                                 udtmp <= vin01_wdi[7:0];
                            end
                         else
                            begin
                                 vdtmp <= vin01_wdi[7:0];
                            end
                    end
            end
        else
            begin
                 yuvvld <= 1'b0;
            end   
   end
end



always @(posedge saa_llc or negedge rstn) 
begin
     if(!rstn)
        begin
             signy <= 9'd0;
             signu <= 8'd0;
             signv <= 8'd0; 
             signy1 <= 9'd0;  
             signu1 <= 8'd0;
             signv1 <= 8'd0;
             signy2 <= 9'd0; 
             signu2 <= 8'd0;
             signv2 <= 8'd0;
             signy3 <= 9'd0; 
             
             yuvvld1 <= 1'b0;
             yuvvld2 <= 1'b0;
             yuvvld3 <= 1'b0;
             yuvvld4 <= 1'b0;
             yuvvld5 <= 1'b0;          
             
             yuvwa1 <= 7'b0;
             yuvwa2 <= 7'b0;
             yuvwa3 <= 7'b0;
             yuvwa4 <= 7'b0;
             yuvwa5 <= 7'b0;                                                  
             
             vd96 <= 15'd0;
             vd7 <= 11'd0;      
             vd103 <= 15'd0;               
             rdoff <= 9'd0;
             
             ud80 <= 15'd0;
             ud88 <= 15'd0;
             vd184 <= 16'd0;
             gdoff <= 9'd0;
             
             ud192 <= 16'd0;
             ud6 <= 11'd0;
             ud198 <= 16'd0;
             bdoff <= 9'd0;
             
             rdata0 <= 10'd0;
             rdata <= 8'd0;
             
             gdata0 <= 10'd0;
             gdata <= 8'd0;    
             
             bdata0 <= 10'd0;
             bdata <= 8'd0;                         
        end
     else
        begin                
             yuvvld1 <= yuvvld;
             yuvvld2 <= yuvvld1;
             yuvvld3 <= yuvvld2;
             yuvvld4 <= yuvvld3;
             yuvvld5 <= yuvvld4;                 
             
             yuvwa1 <= yuvwa;
             yuvwa2 <= yuvwa1;
             yuvwa3 <= yuvwa2;
             yuvwa4 <= yuvwa3;
             yuvwa5 <= yuvwa4;                 
             
             signy <= {1'b0,ydata[7:0]};
             signu <= udata[7:0] - 8'd128;
             signv <= vdata[7:0] - 8'd128;
             
             signy1 <= signy;
             signu1 <= signu;
             signu2 <= signu1;
             
             signy2 <= signy1;
             signv1 <= signv;
             signv2 <= signv1;  
             
             signy3 <= signy2;                   
             
             vd96[14:0] <= {signv[7],signv[7:0],6'd0} + {signv[7],signv[7],signv[7:0],5'd0};
             vd7[10:0] <= {signv[7:0],3'b000}-{signv[7],signv[7],signv[7],signv[7:0]};
             vd103[14:0] <= vd96[14:0] + {vd7[10],vd7[10],vd7[10],vd7[10],vd7[10:0]};
             
             rdoff[8:0] <= {signv2[7],signv2[7:0]} + {vd103[14],vd103[14],vd103[14:8]};
             rdata0[9:0] <= {signy3[8],signy3[8:0]}+{rdoff[8],rdoff[8:0]};
             
             
             
             ud80[14:0] <= {signu[7],signu[7:0],6'd0} + {signu[7],signu[7],signu[7],signu[7:0],4'd0};
             ud88[14:0] <= ud80[14:0] + {signu1[7],signu1[7],signu1[7],signu1[7],signu1[7],signu1[7],signu1[7],signu1[7:0]};
             vd184[15:0] <= {vd96[14:0],1'b0}-{vd7[10],vd7[10],vd7[10],vd7[10],vd7[10],vd7[10:0]};
             
             gdoff[8:0] <= {vd184[15],vd184[15:8]} + {ud88[14],ud88[14],ud88[14:8]};
             gdata0[9:0] <= {signy3[8],signy3[8:0]}-{gdoff[8],gdoff[8:0]};
             
             
             ud192[15:0] <= {signu[7],signu[7:0],7'd0} + {signu[7],signu[7],signu[7:0],6'd0};
             ud6[10:0] <= {signu[7],signu[7:0],2'd0} + {signu[7],signu[7],signu[7:0],1'd0};
             ud198[15:0] <= ud192[15:0] + {ud6[10],ud6[10],ud6[10],ud6[10],ud6[10],ud6[10:0]};
             
             bdoff[8:0] <= {signu2[7],signu2[7:0]} + {ud198[15],ud198[15:8]};
             bdata0[9:0] <= {signy3[8],signy3[8:0]}+{bdoff[8],bdoff[8:0]};                     
             
             if(rdata0[9]==1'b0)
                begin
                     if(rdata0[8]==1'b1)
                        begin
                             rdata <= 8'd255;
                        end
                     else
                        begin
                             rdata <= rdata0[7:0];
                        end
                end
             else
                begin
                     rdata[7:0] <= 8'd0;
                end
                
                
             if(gdata0[9]==1'b0)
                begin
                     if(gdata0[8]==1'b1)
                        begin
                             gdata <= 8'd255;
                        end
                     else
                        begin
                             gdata <= gdata0[7:0];
                        end
                end
             else
                begin
                     gdata[7:0] <= 8'd0;
                end                        
                
             if(bdata0[9]==1'b0)
                begin
                     if(bdata0[8]==1'b1)
                        begin
                             bdata <= 8'd255;
                        end
                     else
                        begin
                             bdata <= bdata0[7:0];
                        end
                end
             else
                begin
                     bdata[7:0] <= 8'd0;
                end                         
             
        end                                       
end


reg [15:0]rgbtmp;

always @(posedge saa_llc or negedge rstn) 
begin
     if(!rstn)
        begin
             rgbdo <= 32'd0;
             rgbwe <= 1'b0;
             rgbwa <= 6'd0; 
             
             rgbtmp <= 16'd0;                   
        end
     else
        begin      
             if(yuvvld5==1'b1)
                begin
                     if(yuvwa5[0]==1'b0)
                        begin
                             rgbtmp <= {rdata[7:3],gdata[7:2],bdata[7:3]};   //-- RGB 565 格式；
                             rgbwe <= 1'b0;
                        end
                     else
                        begin
                             rgbwe <= 1'b1;
                             rgbdo <= {rgbtmp[15:0],rdata[7:3],gdata[7:2],bdata[7:3]};    //-- 两个像素点的RGB565值；                         
                             rgbwa[5:0] <= yuvwa5[6:1];
                        end
                end
             else
                begin
                     rgbwe <= 1'b0;
                end
        end
end



//------------------TW2864 END--------------------------


	
endmodule