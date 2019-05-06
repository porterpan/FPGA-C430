//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================



`timescale 1ns / 1ps
module audio_wm(
		 rstn,	
                 clk100M,
                 aud_en,  
                 aud_bclk,               
                 aud_sclk,
                 aud_sdin,
                 aud_adcdat,                                  
                 aud_adclrc,
                 aud_daclrc,
                 
                 aud_dacdat,                                                               
                 test		  		  
		);     			  
			  
input rstn;	
input clk100M;
input aud_en;

output aud_sclk;
output aud_sdin;
input  aud_bclk;
input  aud_adcdat;
input aud_adclrc;
input aud_daclrc;

output aud_dacdat;

output test;

reg aud_dacdat;
wire test;


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
 
//--assign aud_sdin = (i2c_oe==1'b1)? i2c_sdat : 1'bz;   
assign aud_sdin = i2c_sdat;
assign aud_sclk = i2c_sclk;

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
        seti0 <= aud_en;
        seti1 <= seti0;
        
        if(seti1==1'b0&&seti0==1'b1&&aud_en==1'b1)
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
                                7'd0:   begin  i2c_waddr <= {7'h00,1'b0};  i2c_wdata <= 8'h4b;  end
                                7'd1:   begin  i2c_waddr <= {7'h01,1'b0};  i2c_wdata <= 8'h4b;  end
                                7'd2:   begin  i2c_waddr <= {7'h02,1'b0};  i2c_wdata <= 8'h79;  end   
                                7'd3:   begin  i2c_waddr <= {7'h03,1'b0};  i2c_wdata <= 8'h79;  end  
                                7'd4:   begin  i2c_waddr <= {7'h04,1'b0};  i2c_wdata <= 8'h08;  end  
                                7'd5:   begin  i2c_waddr <= {7'h05,1'b0};  i2c_wdata <= 8'h06;  end  
                                7'd6:   begin  i2c_waddr <= {7'h06,1'b0};  i2c_wdata <= 8'h00;  end  
                                7'd7:   begin  i2c_waddr <= {7'h07,1'b0};  i2c_wdata <= 8'h4a;  end     
                                
                                7'd8:   begin  i2c_waddr <= {7'h08,1'b0};  i2c_wdata <= 8'h00;  end
                                7'd9:   begin  i2c_waddr <= {7'h09,1'b0};  i2c_wdata <= 8'h01;  end                                                                                                                                                                                                                                                                                                                    
                                
                            endcase
                            
                            i2c_ctrl <=  I2C_END;
                       end
                       
                   I2C_END:
                       begin
                            i2crwi <= 1'b0;
                            i2ctcnt <= i2ctcnt + 1'b1;
                               
                            if(i2ctcnt[7:0]==8'd160)
                               begin
                                    if(i2cwcnt==7'd10)    
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
      if(i2c_cnt[7]==1'b1)             //-- write;
         begin
             if(i2c_cnt[0]==1'b1)
                begin
                     case(i2c_cnt[6:1])
                        6'd0:  i2c_sdat <= 1'b0;    //-- start;
                        
                        6'd1:  i2c_sdat <= 1'b0;    //-- slave addr;  4A
                        6'd2:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd3:  i2c_sdat <= 1'b1;    //-- slave addr;
                        6'd4:  i2c_sdat <= 1'b1;    //-- slave addr;
                        6'd5:  i2c_sdat <= 1'b0;    //-- slave addr;
                        6'd6:  i2c_sdat <= 1'b1;    //-- slave addr;
                        6'd7:  i2c_sdat <= 1'b0;    //-- slave addr;        
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
       
       
       if(i2c_cnt[7]==1'b1)
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
                    6'd33: i2c_rdata[7]<= aud_sdin;
                    6'd34: i2c_rdata[6]<= aud_sdin;
                    6'd35: i2c_rdata[5]<= aud_sdin;
                    6'd36: i2c_rdata[4]<= aud_sdin;
                    6'd37: i2c_rdata[3]<= aud_sdin;
                    6'd38: i2c_rdata[2]<= aud_sdin;
                    6'd39: i2c_rdata[1]<= aud_sdin;
                    6'd40: i2c_rdata[0]<= aud_sdin;
                endcase
           end                       
   end
end



  
//==================== audio Line in =========================  


reg [23:0]linrsp; 
reg linvld0;
reg linvld;
reg [23:0]lindat;

reg adclrc1;
reg lrsptime;
reg [4:0]lrspcnt;

always @(posedge aud_bclk or negedge rstn) 
begin
if(!rstn)
   begin
        adclrc1 <= 1'b0;
        lrsptime <= 1'b0;
        lrspcnt <= 5'd0;
        
        linrsp <= 24'd0;
        linvld0 <= 1'b0;
        linvld <= 1'b0;
        lindat <= 24'd0;
   end
else
   begin                                   //--ADC IN:    Master, I2S , fs=48khz, 24bit;
        adclrc1 <= aud_adclrc; 
        
        if(aud_adclrc==1'b0 && adclrc1==1'b1)
           begin
                lrsptime <= 1'b1;
                lrspcnt <= 5'd0;
           end
        else
           begin
                if(lrsptime==1'b1)
                   begin
                        if(lrspcnt==5'd23)
                           begin
                                lrsptime <= 1'b0;
                           end
                        else
                           begin
                                lrspcnt <= lrspcnt + 1'b1;
                           end
                   end
           end
           
        if(lrsptime==1'b1)
           begin
                case(lrspcnt[4:0])
                    5'd0:   linrsp[23] <= aud_adcdat;
                    5'd1:   linrsp[22] <= aud_adcdat;
                    5'd2:   linrsp[21] <= aud_adcdat;
                    5'd3:   linrsp[20] <= aud_adcdat;
                            
                    5'd4:   linrsp[19] <= aud_adcdat;
                    5'd5:   linrsp[18] <= aud_adcdat;
                    5'd6:   linrsp[17] <= aud_adcdat;
                    5'd7:   linrsp[16] <= aud_adcdat;
                            
                    5'd8:   linrsp[15] <= aud_adcdat;
                    5'd9:   linrsp[14] <= aud_adcdat;
                    5'd10:  linrsp[13] <= aud_adcdat;
                    5'd11:  linrsp[12] <= aud_adcdat;
                    
                    5'd12:  linrsp[11] <= aud_adcdat;
                    5'd13:  linrsp[10] <= aud_adcdat;
                    5'd14:  linrsp[9] <= aud_adcdat;
                    5'd15:  linrsp[8] <= aud_adcdat;                    

                    5'd16:  linrsp[7] <= aud_adcdat;
                    5'd17:  linrsp[6] <= aud_adcdat;
                    5'd18:  linrsp[5] <= aud_adcdat;
                    5'd19:  linrsp[4] <= aud_adcdat;
                    
                    5'd20:  linrsp[3] <= aud_adcdat;
                    5'd21:  linrsp[2] <= aud_adcdat;
                    5'd22:  linrsp[1] <= aud_adcdat;
                    5'd23:  linrsp[0] <= aud_adcdat;
                endcase                    
           end
           
         if(lrsptime==1'b1)
           begin
                if(lrspcnt==5'd23)
                   begin
                        linvld0 <= 1'b1;   //-- keep 1clk; 表明新的输入音频采样数据有效；
                   end
                else
                   begin
                        linvld0 <= 1'b0;
                   end
           end   
         else
           begin
                linvld0 <= 1'b0;
           end
           
         linvld <= linvld0;
         if(linvld0==1'b1)
            begin
                 lindat <= linrsp;      
            end
   end
end   




reg [23:0]rinrsp; 
reg rinvld0;
reg rinvld;
reg [23:0]rindat;

reg rrsptime;
reg [4:0]rrspcnt;

always @(posedge aud_bclk or negedge rstn) 
begin
if(!rstn)
   begin
        rrsptime <= 1'b0;
        rrspcnt <= 5'd0;
        
        rinrsp <= 24'd0;
        rinvld0 <= 1'b0;
        rinvld <= 1'b0;
        rindat <= 24'd0;
   end
else
   begin                                   //--ADC IN:    Master, I2S , fs=48khz, 24bit;        
        if(aud_adclrc==1'b1 && adclrc1==1'b0)
           begin
                rrsptime <= 1'b1;
                rrspcnt <= 5'd0;
           end
        else
           begin
                if(rrsptime==1'b1)
                   begin
                        if(rrspcnt==5'd23)
                           begin
                                rrsptime <= 1'b0;
                           end
                        else
                           begin
                                rrspcnt <= rrspcnt + 1'b1;
                           end
                   end
           end
           
        if(rrsptime==1'b1)
           begin
                case(rrspcnt[4:0])
                    5'd0:   rinrsp[23] <= aud_adcdat;
                    5'd1:   rinrsp[22] <= aud_adcdat;
                    5'd2:   rinrsp[21] <= aud_adcdat;
                    5'd3:   rinrsp[20] <= aud_adcdat;
                            
                    5'd4:   rinrsp[19] <= aud_adcdat;
                    5'd5:   rinrsp[18] <= aud_adcdat;
                    5'd6:   rinrsp[17] <= aud_adcdat;
                    5'd7:   rinrsp[16] <= aud_adcdat;
                            
                    5'd8:   rinrsp[15] <= aud_adcdat;
                    5'd9:   rinrsp[14] <= aud_adcdat;
                    5'd10:  rinrsp[13] <= aud_adcdat;
                    5'd11:  rinrsp[12] <= aud_adcdat;
                    
                    5'd12:  rinrsp[11] <= aud_adcdat;
                    5'd13:  rinrsp[10] <= aud_adcdat;
                    5'd14:  rinrsp[9] <= aud_adcdat;
                    5'd15:  rinrsp[8] <= aud_adcdat;                    

                    5'd16:  rinrsp[7] <= aud_adcdat;
                    5'd17:  rinrsp[6] <= aud_adcdat;
                    5'd18:  rinrsp[5] <= aud_adcdat;
                    5'd19:  rinrsp[4] <= aud_adcdat;
                    
                    5'd20:  rinrsp[3] <= aud_adcdat;
                    5'd21:  rinrsp[2] <= aud_adcdat;
                    5'd22:  rinrsp[1] <= aud_adcdat;
                    5'd23:  rinrsp[0] <= aud_adcdat;
                endcase                    
           end
           
         if(rrsptime==1'b1)
           begin
                if(rrspcnt==5'd23)
                   begin
                        rinvld0 <= 1'b1;   //-- keep 1clk; 表明新的输入音频采样数据有效；
                   end
                else
                   begin
                        rinvld0 <= 1'b0;
                   end
           end   
         else
           begin
                rinvld0 <= 1'b0;
           end
           
         rinvld <= rinvld0;
         if(rinvld0==1'b1)
            begin
                 rindat <= rinrsp;
            end
   end
end   


//==================== audio line out ==============================


reg [23:0]ldodat;
reg ldotime;
reg [4:0]ldocnt;
reg daclrc1;

always @(posedge aud_bclk or negedge rstn) 
begin
if(!rstn)
   begin
        ldodat <= 24'd0;
        ldotime <= 1'b0;
        ldocnt <= 5'd0;
        
        daclrc1 <= 1'b0;
   end
else
   begin
        
        daclrc1 <= aud_daclrc;
        
        if(daclrc1==1'b1&&aud_daclrc==1'b0)     //--DAC OUT:    Master, I2S , fs=48khz, 24bit; 
           begin
                ldotime <= 1'b1;
                ldocnt <= 5'd0;
                ldodat[23:0] <= lindat[23:0];              //-- 把LINE IN的音频信号通过LINE OUT 输出；
           end
        else
           begin
                if(ldotime==1'b1)
                   begin
                        if(ldocnt==5'd23)
                           begin
                                ldotime <= 1'b0;
                           end
                        else
                           begin
                                ldocnt <= ldocnt + 1'b1;
                           end                        
                   end
           end
        
   end
end





reg [23:0]rdodat;
reg rdotime;
reg [4:0]rdocnt;

always @(posedge aud_bclk or negedge rstn) 
begin
if(!rstn)
   begin
        rdodat <= 24'd0;
        rdotime <= 1'b0;
        rdocnt <= 5'd0;
        
   end
else
   begin
        
        if(daclrc1==1'b0&&aud_daclrc==1'b1)     //--DAC OUT:    Master, I2S , fs=48khz, 24bit; 
           begin
                rdotime <= 1'b1;
                rdocnt <= 5'd0;
                rdodat[23:0] <= rindat[23:0];              //-- 把LINE IN的音频信号通过LINE OUT 输出；
           end
        else
           begin
                if(rdotime==1'b1)
                   begin
                        if(rdocnt==5'd23)
                           begin
                                rdotime <= 1'b0;
                           end
                        else
                           begin
                                rdocnt <= rdocnt + 1'b1;
                           end                        
                   end
           end
        
   end
end




always @(negedge aud_bclk or negedge rstn)         //-- 下降沿输出
begin
if(!rstn)
   begin
        aud_dacdat <= 1'b0;
   end
else
   begin
        if(ldotime==1'b1)
           begin
                case(ldocnt[4:0])
                    5'd0:   aud_dacdat <= ldodat[23];
                    5'd1:   aud_dacdat <= ldodat[22];
                    5'd2:   aud_dacdat <= ldodat[21];
                    5'd3:   aud_dacdat <= ldodat[20];
                           
                    5'd4:   aud_dacdat <= ldodat[19];
                    5'd5:   aud_dacdat <= ldodat[18];
                    5'd6:   aud_dacdat <= ldodat[17];
                    5'd7:   aud_dacdat <= ldodat[16];
                            
                    5'd8:   aud_dacdat <= ldodat[15];
                    5'd9:   aud_dacdat <= ldodat[14];
                    5'd10:  aud_dacdat <= ldodat[13];
                    5'd11:  aud_dacdat <= ldodat[12];
                          
                    5'd12:  aud_dacdat <= ldodat[11];
                    5'd13:  aud_dacdat <= ldodat[10];
                    5'd14:  aud_dacdat <= ldodat[9];
                    5'd15:  aud_dacdat <= ldodat[8];                    
                          
                    5'd16:  aud_dacdat <= ldodat[7];
                    5'd17:  aud_dacdat <= ldodat[6];
                    5'd18:  aud_dacdat <= ldodat[5];
                    5'd19:  aud_dacdat <= ldodat[4];
                            
                    5'd20:  aud_dacdat <= ldodat[3];
                    5'd21:  aud_dacdat <= ldodat[2];
                    5'd22:  aud_dacdat <= ldodat[1];
                    5'd23:  aud_dacdat <= ldodat[0];
                endcase                    
           end  
        else
           begin
                if(rdotime==1'b1)
                   begin
                        case(rdocnt[4:0])
                            5'd0:   aud_dacdat <= rdodat[23];
                            5'd1:   aud_dacdat <= rdodat[22];
                            5'd2:   aud_dacdat <= rdodat[21];
                            5'd3:   aud_dacdat <= rdodat[20];
                                   
                            5'd4:   aud_dacdat <= rdodat[19];
                            5'd5:   aud_dacdat <= rdodat[18];
                            5'd6:   aud_dacdat <= rdodat[17];
                            5'd7:   aud_dacdat <= rdodat[16];
                                    
                            5'd8:   aud_dacdat <= rdodat[15];
                            5'd9:   aud_dacdat <= rdodat[14];
                            5'd10:  aud_dacdat <= rdodat[13];
                            5'd11:  aud_dacdat <= rdodat[12];
                                  
                            5'd12:  aud_dacdat <= rdodat[11];
                            5'd13:  aud_dacdat <= rdodat[10];
                            5'd14:  aud_dacdat <= rdodat[9];
                            5'd15:  aud_dacdat <= rdodat[8];                    
                                  
                            5'd16:  aud_dacdat <= rdodat[7];
                            5'd17:  aud_dacdat <= rdodat[6];
                            5'd18:  aud_dacdat <= rdodat[5];
                            5'd19:  aud_dacdat <= rdodat[4];
                                    
                            5'd20:  aud_dacdat <= rdodat[3];
                            5'd21:  aud_dacdat <= rdodat[2];
                            5'd22:  aud_dacdat <= rdodat[1];
                            5'd23:  aud_dacdat <= rdodat[0];
                        endcase                    
                   end
           
           end 
   end
end


//==================================================================


	
endmodule