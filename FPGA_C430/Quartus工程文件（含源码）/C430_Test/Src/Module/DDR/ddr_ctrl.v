//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================
  




`timescale 1ns / 1ps
module ddr_ctrl(
		rstn,	
                clkddr,
                clkdrdqs,
                clkdrrd,
                pllok,
                drrdata,
                drrvld,		  
				  
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
		
                loc_wreq,
                loc_rreq,
                loc_rshrq,
                loc_wdata,
                loc_addr,
                loc_done,
                loc_rdy,
                
                test			  

		);     
			  
			  
			  
input rstn;
input clkddr;
input clkdrdqs;        //-- 该时钟专门用来生成 DQS信号
input clkdrrd;         //-- 该时钟专门用来读取DDR数据；
input pllok;           //-- PLL输出时钟锁定信号；锁定后才进行DDR的初始化；
output [31:0]drrdata;    //-- 从DDR读取的数据；
output drrvld;           //-- 从DDR读取的数据有效信号；

   
output 		mem_cs_n;    //-- DDR接口信号
output 		mem_cke;
output [12:0]	mem_addr;
output [1:0]	mem_ba;
output 		mem_ras_n;
output 		mem_cas_n;
output 		mem_we_n;
output 		mem_clk;               
output 		mem_clk_n;
inout [15:0]	mem_dq;
inout 		mem_udqs;
inout           mem_ldqs;    //-- DDR接口信号

input loc_wreq;              //-- 为1说明将开始写DDR；
input loc_rreq;              //-- 为1说明将开始读DDR;
input loc_rshrq;             //-- 为1说明将对DDR进行刷新；
input [31:0]loc_wdata;       //-- 写入DDR的数据；
input [23:0]loc_addr;        //-- 读写DDR的地址信号；
output loc_done;             //-- 为1说明对DDR的初始化完成；
output loc_rdy;              //-- 表明DDR忙或闲的状态；为1时才可以进行新的读写等命令；
output test;                 //-- 测试输出；

//-------------------

reg loc_done;
reg loc_rdy;

reg test;

						
reg mem_cs_n;
reg mem_cke;
reg [12:0]mem_addr;
reg [1:0]mem_ba;
reg  mem_ras_n;
reg  mem_cas_n;
reg  mem_we_n;
wire mem_clk;
wire mem_clk_n;
wire[15:0]mem_dq;
reg [31:0]drrdata;
reg drrvld;

reg [7:0]n;
reg [7:0]m;
reg [2:0]cnt;
reg [3:0]cmd;

reg [12:0]addr;
reg [2:0]ba;

reg initdone;

reg dqrflg;
reg dqrflg1;
reg dqrflg2;
reg dqrflg3;
reg dqrflg4;
reg dqrflg5;
reg dqrflg6;

reg dqs_oe;
reg [15:0]drwdo64h;
reg [15:0]drwdo64l;
reg [31:0]wdata;
reg drwflg;
reg dqwflg;



parameter nop      = 4'b0111;
parameter active   = 4'b0011;
parameter refresh  = 4'b0001;
parameter load     = 4'b0000;
parameter read     = 4'b0101;
parameter write    = 4'b0100;
parameter prechg   = 4'b0010;


reg [4:0]ictrl;

parameter  INIT_IDLE    = 5'd0;
parameter  DRINIT0      = 5'd1;
parameter  DRINIT1      = 5'd2;
parameter  INIT_PCH1    = 5'd3;
parameter  LOAD_EMRS    = 5'd4;
parameter  LOAD_MRS     = 5'd5;
parameter  LOAD_EMR     = 5'd6;
parameter  LOAD_MRDLL1  = 5'd7;
parameter  INIT_PCH2    = 5'd8;
parameter  INIT_RFRSH1  = 5'd9;
parameter  RFRSH_WT     = 5'd30;
parameter  LOAD_MRSDLL  = 5'd10;
parameter  LOAD_EMROCT1 = 5'd11;
parameter  LOAD_EMROCT2 = 5'd12; 
parameter  INIT_END     = 5'd29;

parameter  WAIT_OP      = 5'd13; 
parameter  ACTIVES      = 5'd14; 
parameter  WACT_NOP     = 5'd24;
parameter  WRITES       = 5'd15; 
parameter  WRT_NOP      = 5'd16; 
parameter  WPCH_PRE     = 5'd17; 
parameter  WRT_PCH      = 5'd18; 
parameter  WPCH_NOP     = 5'd25;
parameter  RACTIVE      = 5'd19;
parameter  RACT_NOP     = 5'd26; 
parameter  READS        = 5'd20; 
parameter  RD_NOP       = 5'd21; 
parameter  RPCH_PRE     = 5'd22; 
parameter  RD_PCH       = 5'd23; 
parameter  RPCH_NOP     = 5'd27;
parameter  RW_RFRSH     = 5'd28;
parameter  RFRSH_WT1    = 5'd31;


//----
wire mem_cs_nx;
reg  mem_ckex;
wire [12:0] mem_addrx;
wire [2:0]  mem_bax;
wire 	    mem_ras_nx;
wire 	    mem_cas_nx;
wire 	    mem_we_nx;


//------------------------------------------
	


wire [31:0]drrdin;

reg dqswflg;
reg dqs_l;
reg dqs_h;

always @(posedge clkdrdqs or negedge rstn)
begin
    if (!rstn)
       begin
            dqswflg <= 1'b0;
            dqs_h <= 1'b0;
            dqs_l <= 1'b0;
       end
    else
       begin
            dqswflg <= drwflg;
            dqs_l <= 1'b0;
            if(dqs_oe==1'b1)
               begin
                   dqs_h <= 1'b1;
               end
            else
               begin
                   dqs_h <= 1'b0;
               end
       end
end

mybidir mybidir0(
	          .datain_h(dqs_l),
	          .datain_l(dqs_h),
	          .inclock(),
	          .oe(dqswflg),
	          .outclock(clkdrdqs),   
	          .dataout_h(),
	          .dataout_l(),
	          .padio(mem_udqs)           //-- 用来生成写DDR时的 DQS 信号； 写DDR时，对DQS和DQ的相位关系有明确的要求，参照DDR datasheet;
	          );


mybidir mybidir1(
	          .datain_h(dqs_l),
	          .datain_l(dqs_h),
	          .inclock(),
	          .oe(dqswflg),
	          .outclock(clkdrdqs),
	          .dataout_h(),
	          .dataout_l(),
	          .padio(mem_ldqs)       //-- 用来生成写DDR时的 DQS 信号； 写DDR时，对DQS和DQ的相位关系有明确的要求，参照DDR datasheet;
	          );                     
	          
	          
	            	          	          	   	   	                    	           

mydq mydq0(
	   .datain_h(drwdo64h[15:8]),    //-- 写数据；clkddr上升沿写入DDR的数据；
	   .datain_l(drwdo64l[15:8]),    //-- 写数据；clkddr下降沿写入DDR的数据；
	   .inclock(clkdrrd),            //-- 读DDR时，根据该时钟的上升沿和下降沿分别得到数据；
	   .oe(drwflg),
	   .outclock(clkddr),            //-- 写DDR时，根据该时钟的上升沿和下降沿分别打出数据；
	   .dataout_h(drrdin[31:24]),    //-- 读到的数据； clkdrrd上升沿采样的数据；
	   .dataout_l(drrdin[15:8]),     //-- 读到的数据； clkdrrd下降沿采样的数据；
	   .padio(mem_dq[15:8])          //-- DDR接口上呈现的数据；
	   ); 
	   

mydq mydq1(
	   .datain_h(drwdo64h[7:0]),     //-- 写数据；clkddr上升沿写入DDR的数据；              
	   .datain_l(drwdo64l[7:0]),     //-- 写数据；clkddr下降沿写入DDR的数据；                 
	   .inclock(clkdrrd),            //-- 读DDR时，根据该时钟的上升沿和下降沿分别得到数据；
	   .oe(drwflg),                                                                           
	   .outclock(clkddr),            //-- 写DDR时，根据该时钟的上升沿和下降沿分别打出数据； 
	   .dataout_h(drrdin[23:16]),    //-- 读到的数据； clkdrrd上升沿采样的数据；            
	   .dataout_l(drrdin[7:0]),      //-- 读到的数据； clkdrrd下降沿采样的数据；            
	   .padio(mem_dq[7:0])           //-- DDR接口上呈现的数据；                               
	   );		
	
		

	             



always@(posedge clkddr or negedge rstn)        
begin
   if(!rstn)
      begin
           drrdata <= 32'd0;
           drrvld <= 1'b0;        
      end
   else
      begin     
           drrdata <= drrdin[31:0];       //-- 读DDR得到的数据；
           drrvld <= dqrflg5;             //-- 读数据有效信号；
                                                        
      end
end




always@(negedge rstn or posedge clkddr)
begin
   if(!rstn)
      begin
          mem_cke <= 1'b0;
          mem_cs_n <= 1'b0;          
          mem_ras_n <= 1'b1;
          mem_ras_n <= 1'b1;
          mem_we_n <= 1'b1;
          mem_ba <= 2'd0;
          mem_addr <= 13'd0;
      end
   else
      begin
          mem_cke <= mem_ckex;
          mem_cs_n <= mem_cs_nx;          
          mem_ras_n <= mem_ras_nx;
          mem_cas_n <= mem_cas_nx;
          mem_we_n <= mem_we_nx;
          mem_ba <= mem_bax[1:0];
          mem_addr <= mem_addrx;                                               
      end
end



ckoutp  ck_pout(
                .datain_h(1'b0),
                .datain_l(1'b1),
                .outclock(clkddr),
                
                .dataout(mem_clk)       //-- DDR 接口时钟信号；
                );

ckoutp  ck_nout(
                .datain_h(1'b1),
                .datain_l(1'b0),
                .outclock(clkddr),
                
                .dataout(mem_clk_n)     //-- DDR 接口时钟信号；
                );



		


assign mem_cs_nx  = cmd[3];         //-- cmd表示对DDR进行操作的命令；最终通过DDR的接口信号如 mem_cs_n/mem_ras_n等来体现；
assign mem_ras_nx = cmd[2];
assign mem_cas_nx = cmd[1];
assign mem_we_nx  = cmd[0];

assign mem_addrx = addr;           //-- DDR行或列的地址信号；
assign mem_bax = ba;               //-- DDR BANK信号；



always @(posedge clkddr or negedge rstn)     
begin
    if (!rstn)
       begin
            dqs_oe <= 1'b0;
       end
    else
       begin 
           dqs_oe <= dqwflg;          
       end
end


reg [31:0]wdreg64;



always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            wdreg64 <= 32'd0;
       end
    else
       begin           
             wdreg64[31:0] <= loc_wdata[31:0];  //-- 外部输入的写DDR数据，为32bit，需要配合其他信号时序，最终转化为DDR的接口数据；
       end
end


always @(negedge clkddr or negedge rstn)     //-- negedge clkddr
begin
    if (!rstn)
       begin
            drwdo64l <= 16'd0;
       end
    else
       begin
            drwdo64l <= wdreg64[15:0];
       end
end

always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            drwdo64h <= 16'd0;
       end
    else
       begin
            drwdo64h <= wdreg64[31:16];                                 
       end
end


//----------------
always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            dqrflg1 <= 1'b0;
            dqrflg2 <= 1'b0;
            dqrflg3 <= 1'b0;
            dqrflg4 <= 1'b0;
            dqrflg5 <= 1'b0;
            dqrflg6 <= 1'b0;             
       end
    else
       begin
            dqrflg1 <= dqrflg;        //-- 读命令发出到最终得到读数据有几个clk的延迟；
            dqrflg2 <= dqrflg1;
            dqrflg3 <= dqrflg2;
            dqrflg4 <= dqrflg3;
            dqrflg5 <= dqrflg4;
            dqrflg6 <= dqrflg5;                                                                                
       end
end





//---------------------------------------


always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            cmd <= nop;
       end
    else
       begin
            case(ictrl)                  //-- 状态机的不同状态对应不同的DDR命令；有的命令的发出还需要和cnt结合，即和状态不一定同步；
                LOAD_EMRS,
                LOAD_MRS,
                LOAD_EMR,
                LOAD_MRDLL1,
                LOAD_MRSDLL,
                LOAD_EMROCT1,
                LOAD_EMROCT2:                  
                             begin                                  
                                 if(cnt==3'd0)                                    
                                     cmd <= load;
                                 else
                                     cmd <= nop;   
                             end
            
                INIT_PCH1,
                INIT_PCH2,
                WRT_PCH:
                             begin
                                     cmd <= prechg;
                             end                
                RD_PCH:  
                             begin
                                  if(cnt==3'd1)
                                     cmd <= prechg;
                                  else
                                     cmd <= nop;
                             end
                ACTIVES,
                RACTIVE:     
                             begin  cmd <= active; end
                WRITES:   
                             begin  cmd <= write;  end

                READS:    
                            begin
                                    cmd <= read;    
                            end

                INIT_RFRSH1,
                RW_RFRSH:
                             begin  cmd <= refresh;end
                default:
                             begin  cmd <= nop;    end
            endcase                
       end
end




always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            mem_ckex <= 1'b0;
            m <= 8'd0;
            n <= 8'd0;
            cnt <= 3'd0;      
            addr <= 13'd0;
            ba <= 3'd0;
            
            initdone <= 1'b0; 
            drwflg <= 1'b0;
            dqwflg <= 1'b0;    
            dqrflg <= 1'b0;
            
              
            ictrl <= INIT_IDLE;
            loc_done <= 1'b0;
            loc_rdy <= 1'b0;
            
            test <= 1'b0;
       end
    else
       begin
            case(ictrl)
                INIT_IDLE:
                     begin
                          if(pllok==1'b1 && initdone==1'b0)      //-- PLL的输出时钟OK后才开始进行DDR初始化；该PLL产生的时钟用于DDR的相关时钟；
                              begin
                                   ictrl <= DRINIT0;              //-- 首先进行一系列的初始化过程，参见DDR datasheet相关介绍；
                              end
                     end
                     
                DRINIT0:                 //-- cke=0; 200us init;
                     begin
                          n <= n + 1'b1;
                          if(n==8'd255)
                              begin
                                   m <= m + 1'b1;
                              end
                          
                          if(m==8'd255)
                              begin
                                   ictrl <= DRINIT1;
                              end
                     end
                     
                DRINIT1:                //-- nop;  400ns;
                     begin
                          mem_ckex <= 1'b1;
                          n <= n + 1'b1;
                          
                          if(n==8'd128)
                              begin
                                   ictrl <= INIT_PCH1;
                              end                         
                     end
                     
                INIT_PCH1:            //-- precharge;  Trpa = 17.5ns
                     begin
                          addr[10] <= 1'b1;   //-- A10=1'b1;      all bank precharge
                          if(cnt==3'b010)     //-- 3clk;
                             begin
                                  cnt <= 3'd0;
                                  ictrl <= LOAD_EMRS;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end
                     end
                     
                LOAD_EMRS:
                     begin
                          ba[2] <= 1'b0;      //-- must be 0;
                          ba[1:0] <= 2'b01;   //-- EMRS;
                          addr[12:0] <= 13'b0_0000_0000_0000;   //-- DLL ENABLE
                          if(cnt==3'b011)     //-- clk;
                             begin
                                  cnt <= 3'd0;
                                  ictrl <= LOAD_MRS;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                                             
                     
                     end
                     
                LOAD_MRS:
                     begin
                          ba[2] <= 1'b0;      
                          ba[1:0] <= 2'b00;                      //-- MRS;
                          addr[12:0] <= 13'b0_0001_0011_0001;    //-- A[2:0]:  001--> burst length:2 ; CAS Latency: 3
                          if(cnt==3'b101)                        //-- 2clk;
                             begin
                                  cnt <= 3'd0;
                                  ictrl <= INIT_PCH2;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                                                                 
                     end                     
                
 
                     
                INIT_PCH2:
                     begin
                          ba <= 3'd0;         
                          addr[12:0] <= 13'b0_0100_0000_0000;    //-- A10=1'b0;        single bank precharge;
                          
                          n <= 8'd0;
                          if(cnt==3'b011)     //--
                             begin
                                  cnt <= 3'd0;
                                  ictrl <= INIT_RFRSH1;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                          
                     end    
                     
                INIT_RFRSH1:         
                     begin
                          n <= 8'd0;
                          ictrl <= RFRSH_WT;                 
                     end
                     
                RFRSH_WT:
                     begin
                          n <= n + 1'b1;
                          
                          if(n[6]==1'b1)           //-- issue 2 or more refresh cmd;
                             begin
                                 if(cnt[0]==1'b1)
                                     begin
                                         cnt[0] <= 1'b0;
                                         ictrl <= LOAD_MRSDLL;
                                     end
                                 else
                                     begin
                                         cnt[0] <= 1'b1;
                                         ictrl <= INIT_RFRSH1;
                                     end
                             end                      
                     end        
                     
                LOAD_MRSDLL:
                     begin
                          ba[2] <= 1'b0;      
                          ba[1:0] <= 2'b00;   //-- MRS;            
                          addr[12:0] <= 13'b0_0000_0011_0001;    //-- A[2:0]:  001--> burst length:2  
                          
                          n <= 8'd0;
                          if(cnt==3'b011)     //-- 2clk;
                             begin
                                  cnt <= 3'd0;
                                  ictrl <= INIT_END;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                                                 
                     end  
                     
                                              
                INIT_END:
                     begin
                          n <= n + 1'b1;
                          if(n[7:6]==2'b11)   
                             begin
                                  loc_done <= 1'b1;
                                  loc_rdy <= 1'b1;
                                  ictrl <= WAIT_OP;          //-- 初始化完成；此后才可以对DDR进行读写等操作；
                             end                                       
                     end
                     
             //---------------------------------------------------------             
                     
                WAIT_OP:
                     begin 
                          n <= 8'd0;                            
                          initdone <= 1'b1; 
                                                                                                                            
                          
                          if(loc_wreq==1'b1||loc_rreq==1'b1)  //-- 对DDR的读写通过loc_wreq/loc_rreq来进行；
                             begin
                                  if(loc_wreq==1'b1)
                                     begin 
                                          loc_rdy <= 1'b0;                          
                                          ictrl <= ACTIVES;
                                     end
                                   else
                                     begin
                                          loc_rdy <= 1'b0;   
                                          ictrl <= RACTIVE; 
                                     end                     
                             end
                          else
                             begin
                                  if(loc_rshrq==1'b1)         //-- 对DDR的刷新也通过外部信号loc_rshrq来进行（这样的好处是可以精确控制对DDR读写的时间段）        
                                    begin                                         
                                         loc_rdy <= 1'b0;          
                                         ictrl <= RW_RFRSH;
                                    end
                                  else
                                    begin
                                         loc_rdy <= 1'b1;
                                    end                          
                             end                                                                                                                                                                      
                     end
                     
                ACTIVES:                                 //-- 写DDR 启动； 首先要avtive DDR中的特定一行； DDR每次连续写最多只能写一行，不能跨行；
                     begin
                          ba[2:0] <= loc_addr[23:21];       //-- DDR BANK 选择；
                          addr[12:0] <= loc_addr[20:8];     //-- DDR 行选择；                         
                          
                          n <= 8'd0;
                          cnt <= 3'd0;
                          drwflg <= 1'b1;          
                          
                          loc_rdy <= 1'b1;                  //-- 外部通过该信号来确定是否可以发出新的命令；DDR不同命令需要持续的时间有所不同，通过该信号可以进行长短控制；
                           
                          ictrl <= WACT_NOP;                            
                     end
                     
                WACT_NOP:
                     begin                         
                          if(cnt==3'b000)
                             begin
                                  cnt <= 3'd0;                                  
                                  ictrl <= WRITES;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                                           
                     end
                     
                WRITES:
                     begin
                          dqwflg <= 1'b1;
                          
                          addr[9:0] <= {1'b0,loc_addr[7:0],1'b0};     //-- 选择DDR的列地址； 外部写入为32bit，实际对应DDR的两个地址； 外部输入loc_addr[7:0]按32bit为单位；                 
                          addr[10] <= 1'b0;                     //-- A10=0; disable auto precharge;
                          addr[12:11] <= 2'd0;
                          if(loc_wreq==1'b0)                   //-- 外部通过loc_wreq的长短来控制写入的数据个数；
                              begin
                                  loc_rdy <= 1'b0;
                                  ictrl <= WPCH_PRE;
                              end
                     end
                                          
                WPCH_PRE:                        //--  写完后进行precharge命令；
                     begin
                          dqwflg <= 1'b0;            
                      
                          if(cnt==3'd2)            
                             begin
                                  cnt <= 3'd0;
                                  
                                  ictrl <= WRT_PCH;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                     
                     end
                
                WRT_PCH:
                     begin
                          ba <= 3'd0;
                          addr[10]<=1'b1;     
                          cnt <= 3'd0;
                          loc_rdy <= 1'b1;    
                          ictrl <= WPCH_NOP;
                     end
                     
                WPCH_NOP:
                     begin
                       //--   cnt <= 3'd0;                        
                          drwflg <= 1'b0;    
                          if(cnt==3'd1)        //-- precharge到下一个可以进行avtive或其他命令有一定时间间隔；        
                             begin
                                  cnt <= 3'd0;
                                  
                                  ictrl <= WAIT_OP;             
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                               
                                              
                     end 
                     
                RW_RFRSH:          //-- trfc: 75ns;     刷新命令； 该DDR要求在每64ms内要完成 8192次的refresh命令；此处该命令由外部模块来控制；
                     begin                         //-- 只要在64ms时间内完成8192次refresh命令即可，该8192次可以连续进行或者分开进行；
                          n <= 8'd0;                          
                          ictrl <= RFRSH_WT1;                  
                     end  
                     
                RFRSH_WT1:
                     begin
                          n <= n + 1'b1;                         
                          if(n[4:0]==5'd8)          
                             begin
                                  loc_rdy <= 1'b1;
                                  ictrl <= WAIT_OP;
                             end 
                     end       
                                                                          
             //-----------------------------------------------------------        
                RACTIVE:                                      //-- 读取DDR； 和写DDR的过程类似；
                     begin                                   
                          ba[2:0] <= loc_addr[23:21];
                          addr[12:0] <= loc_addr[20:8];                                            
                          n <= 8'd0;
                          cnt <= 3'd0; 
                          loc_rdy <= 1'b1;    
                          ictrl <= RACT_NOP;                  
                     end
                     
                RACT_NOP:
                     begin 
                         if(cnt==3'b000)
                             begin
                                  cnt <= 3'd0;                                                              
                                  ictrl <= READS;
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                       
                     end 
                     
                READS:
                     begin                                                  
                          addr[9:0] <= {1'b0,loc_addr[7:0],1'b0}; 
                          addr[10] <= 1'b0;            //-- A10=0; disable auto precharge;
                          addr[12:11]<= 2'd0;
                          dqrflg <= 1'b1;  
                          
                          cnt <= 3'd0;
                                                                                                                                                            
                          if(loc_rreq==1'b0)            //-- 读取DDR的数据个数通过外部的loc_rreq进行控制；
                             begin
                                  loc_rdy <= 1'b0;       
                                  ictrl <= RD_PCH;      
                             end                  
                     end                                             
                
                RD_PCH:             
                     begin              
                           ba <= 3'd0;
                           addr[10]<=1'b1;       
                           dqrflg <= 1'b0;  
                           loc_rdy <= 1'b1;                                    
                           if(cnt==3'd1)
                              begin
                                   cnt <= 3'd0;
                                   ictrl <= WAIT_OP;
                              end
                           else
                              begin
                                   cnt <= cnt + 1'b1;
                              end
                                                      
                     end 
                     
                RPCH_NOP:
                     begin                           
                         if(cnt==3'b000)  
                             begin
                                    begin 
                                         cnt <= 3'd0;                                                                  
                                         loc_rdy <= 1'b1;
                                         test <= 1'b1;
                                         ictrl <= WAIT_OP; 
                                    end
                             end
                          else
                             begin
                                  cnt <= cnt + 1'b1;
                             end                      
                     end
                     
                 default:
                     begin
                          ictrl <= WAIT_OP;      //-- 读DDR完毕；
                     end                    
                                        
            endcase                                                                               
       end
end






	
endmodule