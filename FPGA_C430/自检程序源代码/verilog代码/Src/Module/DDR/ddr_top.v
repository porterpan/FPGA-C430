//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================
  




`timescale 1ns / 1ps



module ddr_top(
		 rstn,	
                 clkddr,
                 clkdrdqs,
                 clkdrrd,    
                 vinwi,
                 vinwfi,              
                 viewrdfi,
                 viewrdrq,
                 vinrdo,    
	         vfifowf,
	         vfifowuse,                               
                                        
                                           
                 
		 mem_cs_n,
		 mem_cke,
		 mem_addr,  
		 mem_ba,    
		 mem_ras_n, 
		 mem_cas_n, 
		 mem_we_n,  
		 mem_clk,   
		 mem_clk_n, 
		 mem_dq,    
		 mem_udqs,
		 mem_ldqs,  
		 mem_udm,
		 mem_ldm, 
                 pllok,	               
                 loc_done,
                 loc_rdy,  
                 drrdata,
                 drrvld,	                                                                                                                                                  
                 vinra,            
	         vfifoclr,
	         vfifowdi,	            
	         vfifowe,
	         vfifofrmi,                                                        
                 test		  		  
		);     
			  
			  
			  
input rstn;	

input clkddr;
input clkdrdqs;
input clkdrrd;

input vinwi;
input vinwfi;              
input viewrdfi;
input viewrdrq;
input [31:0]vinrdo;  
input vfifowf;
input [9:0]vfifowuse;

output mem_cs_n;
output mem_cke;
output [12:0]mem_addr;
output [1:0]mem_ba;
output mem_ras_n;
output mem_cas_n;
output mem_we_n;
output mem_clk;
output mem_clk_n;
inout  [15:0]mem_dq;
inout  mem_udqs;
inout  mem_ldqs;
inout  mem_udm;
inout  mem_ldm;

input  pllok;
output loc_done;
output loc_rdy;
output [31:0]drrdata;
output drrvld;

output [5:0]vinra; 

output vfifoclr;
output [31:0]vfifowdi;	            
output vfifowe;
output vfifofrmi;  
         
output test;


wire [5:0]vinra;

reg vfifoclr;
reg [31:0]vfifowdi;	            
reg vfifowe;
reg vfifofrmi;  
//--------------------------------------


wire [31:0]rgbdo;
wire rgbwe;
wire [8:0]rgbwa;


wire  loc_wreq;
wire  loc_rreq;
wire  loc_rshrq;
wire  [23:0]loc_addr;

wire [31:0]drrdata;
wire drrvld;


wire  [31:0]loc_wdata;
                   
reg vfifowrq;                                                                                                                                    		
			
//-----------------------------------------------------  

assign mem_udm = 1'b0;
assign mem_ldm = 1'b0;	        
	        
ddr_rw ddr_rw(
                .rstn(rstn),	
                .clkddr(clkddr),              
                .drinitok(loc_done),
                .drrdy(loc_rdy),
                .vinwi(vinwi),
                .vinwfi(vinwfi),              
                .viewrdfi(vfifofrmi),
                .viewrdrq(vfifowrq),
                .vinrdo(vinrdo),                               
                              		  
			  		                           
                .loc_wreq(loc_wreq),
                .loc_rreq(loc_rreq),
                .loc_rshrq(loc_rshrq),
                .loc_addr(loc_addr), 
                .loc_wdata(loc_wdata),            
                .vinra(vinra),    
                .test()			  
	        );  	        
	        
	        
	        

ddr_ctrl ddrctrl(
	      .rstn(rstn),
              .clkddr(clkddr),
              .clkdrdqs(clkdrdqs),  
              .clkdrrd(clkdrrd),                   
              .pllok(pllok),
              .drrdata(drrdata),
              .drrvld(drrvld),
              			  			  
	      .mem_cs_n(mem_cs_n),
	      .mem_cke(mem_cke),
	      .mem_addr(mem_addr),  
	      .mem_ba(mem_ba),    
	      .mem_ras_n(mem_ras_n), 
	      .mem_cas_n(mem_cas_n), 
	      .mem_we_n(mem_we_n),  
	      .mem_dm(),    
	      .mem_clk(mem_clk),   
	      .mem_clk_n(mem_clk_n), 
	      .mem_dq(mem_dq),    
	      .mem_udqs(mem_udqs),
	      .mem_ldqs(mem_ldqs),
	        			  
              .loc_wreq(loc_wreq),
              .loc_rreq(loc_rreq),
              .loc_rshrq(loc_rshrq),
              .loc_wdata(loc_wdata),
              .loc_addr(loc_addr),
              .loc_done(loc_done),
              .loc_rdy(loc_rdy),
              
              .test()
              			  			  
	      ); 
	      
	      
	      


//-----------------------------------------------

reg time1ms;
reg [16:0]timecnt;
reg time40ms;
reg [5:0]tmscnt;
reg dispfrmi;

reg [1:0]frmidly;


always @(posedge clkddr or negedge rstn) 
begin
     if(!rstn)
     	  begin
               vfifofrmi <= 1'b0;
               vfifoclr <= 1'b0;
               vfifowe <= 1'b0;
               vfifowdi <= 32'd0;
               
               vfifowrq <= 1'b0;
               frmidly <= 2'd0;
     	  end
     else 
          begin
               if(dispfrmi==1'b1)
                  begin
                       vfifofrmi <= 1'b1;
                       vfifoclr <= 1'b1;
                       frmidly <= 2'd3;
                  end
               else
                  begin
                       if(frmidly==2'd0)
                          begin
                               vfifofrmi <= 1'b0;      //-- vfifofrmi维持4clk，以便于其他模块跨时钟采样；
                               vfifoclr <= 1'b0;
                          end     
                       else
                          begin
                               frmidly <= frmidly - 1'b1;
                          end             
                  end
                  
               //-- vfifowdi <= 32'hf800f800;
               
                vfifowe <= drrvld;
                vfifowdi <= drrdata;
                  
                if(vfifowuse[9]==1'b0)
                   begin
                        vfifowrq <= 1'b1;
                   end
                else
                   begin
                        vfifowrq <= 1'b0;
                   end
          end
end

	      
always @(posedge clkddr or negedge rstn) 
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
               if(timecnt==17'h1e847)       //-- when clk=125Mhz
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
	      


//-------------------------
	
endmodule