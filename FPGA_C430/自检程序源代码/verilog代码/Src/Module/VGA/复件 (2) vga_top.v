
//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================
  

//-- output:   1024*768 @60hz


//===================================================================================

`timescale 1ns / 1ps

module vga_top(  
  		clk65M,
  		rstn,

  		vga_hs,
  		vga_vs,
  		vga_r,
  		vga_g,
  		vga_b,
                vga_blk,
                vga_syn,
                vga_clk
  		  
		);
			

//===========================================================================			

  input        	clk65M;             
  input        	rstn;              
  

  output    	vga_hs;           
  output    	vga_vs;           
  output 	[7:0]vga_r;    
  output 	[7:0]vga_g;    
  output 	[7:0]vga_b;    
  output        vga_blk;
  output        vga_syn;
  output        vga_clk;


  reg    	vga_hs;
  reg    	vga_vs;
  reg[7:0] 		vga_r;
  reg[7:0] 		vga_g;
  reg[7:0]		vga_b;

  wire        vga_blk;
  wire        vga_syn;
  wire        vga_clk;

//===========================================================================

reg [10:0]hcnt;
reg [9:0]vcnt;

reg vgahs1;

reg hdisply;
reg vdisply;

assign vga_clk = clk65M;

assign vga_syn = 1'b0;
//--assign vga_blk = vga_vs&vga_hs;
assign vga_blk = vdisply&hdisply;

always @(posedge clk65M or negedge rstn)
begin
     if(!rstn)
        begin
             hcnt <= 11'd0;
             vcnt <= 10'd0;   
             
             vga_hs <= 1'b1;   
             vga_vs <= 1'b1;
             vgahs1 <= 1'b0;
             
             hdisply <= 1'b0; 
             vdisply <= 1'b0;
             
//--             vga_blk <= 1'b1;  
//--             vga_syn <= 1'b0;  
//--             vga_clk <= 1'b0; 
             
        end
     else
        begin 
        
//--             vga_blk <= hcnt[7];
//--             vga_syn <= hcnt[8];
//--             vga_clk <= hcnt[10];    
             
                 
        
             if(hcnt==11'd1343)                 //-- 1344pix；有效显示宽度为1024pix;
                begin
                     hcnt <= 11'd0;
                end
             else
                begin
                     hcnt <= hcnt + 1'b1;
                end
                
             if(hcnt[10:8]==3'd0&&(hcnt[7]==1'b0||hcnt[7:4]==4'd0))  //-- 0~135
                begin
                     vga_hs <= 1'b0;    //-- 产生hs行同步脉冲，宽度136pix；
                end
             else
                begin
                     vga_hs <= 1'b1;
                end
                
             if((hcnt[10:0]>295)&&(hcnt[10:0]<1320))
                begin
                     hdisply <= 1'b1;
                end
             else
                begin
                     hdisply <= 1'b0;
                end
                
             if((vcnt[9:0]>28)&&(vcnt<797))
                begin
                     vdisply <= 1'b1;
                end
             else
                begin
                     vdisply <= 1'b0;
                end
                
                
             vgahs1 <= vga_hs;   
             if(vga_hs==1'b0&&vgahs1==1'b1)   //-- vgahs脉冲捕获；
                begin
                     if(vcnt==10'd805)
                        begin
                             vcnt <= 10'd0;
                        end
                     else
                        begin
                             vcnt <= vcnt + 1'b1;
                        end
                end
                
             if(vcnt[9:3]==7'd0&&vcnt[2:1]!=2'b11)  //-- 0~5
                begin
                     vga_vs <= 1'b0;           //-- 产生vs场同步脉冲, 宽度 6个vgahs宽度； 
                end                
             else
                begin
                     vga_vs <= 1'b1;
                end
                                                   
        end
end
        


reg [9:0]hpixcnt;

always @(posedge clk65M or negedge rstn)
begin
     if(!rstn)
        begin
  	     vga_r <= 8'd0;
  	     vga_g <= 8'd0;
  	     vga_b <= 8'd0;   
  	     hpixcnt <= 10'd0;
        end
     else
        begin            
                
             if(hdisply==1'b1)
                begin
                    hpixcnt <= hpixcnt + 1'b1;
                end
             else
                begin
                    hpixcnt <= 10'd0;
                end
                
             //--vga_r <= 8'd0;
             //--vga_g <= 8'd0;
             //--vga_b <= 8'd250;
        

             case(hpixcnt[9:8])           //-- 显示4个竖条，分别是  红 绿  蓝  黄；
                2'd0:
                     begin
   	                  vga_r <= 8'd250;
  	                  vga_g <= 8'd0;
  	                  vga_b <= 8'd0;                                 
                     end
                     
                2'd1:
                     begin
   	                  vga_r <= 8'd0;
  	                  vga_g <= 8'd250;  
  	                  vga_b <= 8'd0;                                  
                     end
                     
                2'd2:
                     begin
   	                  vga_r <= 8'd0; 
  	                  vga_g <= 8'd0;   
  	                  vga_b <= 8'd250;                                 
                     end
                     
                2'd3:
                     begin
   	                  vga_r <= 8'd250; 
  	                  vga_g <= 8'd250;  
  	                  vga_b <= 8'd250;                                  
                     end
              
             endcase                                                                                    
        end

end






endmodule
