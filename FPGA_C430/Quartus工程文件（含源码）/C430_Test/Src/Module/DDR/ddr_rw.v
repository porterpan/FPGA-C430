
//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================
  



//---------------------------------------------- 


`timescale 1ns / 1ps
module ddr_rw(
                rstn,	
                clkddr,
                drinitok,
                drrdy,	
                vinwi,
                vinwfi,  
                viewrdfi,
                viewrdrq, 
                vinrdo,        
		
                					  		                           
                loc_wreq,
                loc_rreq,
                loc_rshrq,
                loc_addr,
                loc_wdata,
                vinra,   
                test		  
	        );     
			  
			  
			  
input rstn;
input clkddr;           //-- DDR 主时钟；
input drinitok;         //-- DDR完成初始化；
input drrdy;            //-- DDR忙活闲的状态； 为1时说明可以对DDR进行操作；      
input vinwi;            //-- 视频数据写启动信号；每一次写一批数据； 
input vinwfi;           //-- 为1说明当批次写入的视频数据为一帧视频数据的起始数据；
input viewrdfi;         //-- 为1说明当批次读取的数据为LCD显示数据帧的起始信号； 
input viewrdrq;         //-- LCD显示数据读取要求信号；
input [31:0]vinrdo;     //-- 写入到DDR的视频数据；


output loc_wreq;        //-- 对DDR进行写数据的要求信号；loc_wreq为1的时钟长度表明了写入DDR的数据个数（32bit为单位计数）
output loc_rreq;        //-- 对DDR进行读取数据的要求信号；loc_rreq为1的时钟长度表明了读取DDR的数据个数（32bit为单位计数）
output loc_rshrq;       //-- 为1表明对DDR开始进行刷新的命令； 刷新的次数由ddr_ctrl部分决定；
output [23:0]loc_addr;   //-- 读写DDR的地址；包括了BANK/行/列 的地址信息；
output [31:0]loc_wdata;  //-- 写入DDR的数据；
output [5:0]vinra;       //-- 读取视频数据的地址（该数据将写入到DDR中）；

output test;            //-- 测试信号；


reg loc_wreq;
reg loc_rreq;
reg loc_rshrq;

wire [23:0]loc_addr;
reg [31:0]loc_wdata;
reg [5:0]vinra;

reg test;

//-------------------------------------------

reg [3:0]CTRL;

parameter IDLE          = 4'd0;
parameter DRWRT1        = 4'd1;
parameter DRWRT2        = 4'd2;
parameter DRWAIT        = 4'd3;
parameter DRWRT         = 4'd4;
parameter DRREAD        = 4'd5;
parameter DRRFRSH       = 4'd6;


reg viewfrmfst;
reg [23:0]wrtaddr;
reg [23:0]rdaddr;

reg rfrshrq;
reg wrtrq;
reg readrq;

reg [10:0]wrtcnt32;
reg [10:0]rdcnt32;

reg wrtfst;
reg [7:0]wcnt;
reg [7:0]rcnt;
reg [5:0]drwnum;
reg [7:0]drrnum;
reg rdfst;
reg rdviewdone;
reg addrwflg;

reg vinwfrmi;
reg vinwrqi;
reg vinwrt3;

reg vinwrt1;
reg vinwrt2; 

reg wtdrwtran;
reg wtdrwfrmf;
reg loc_wreq1;

reg [6:0]wfrmcnt;
reg [6:0]rfrmcnt;


//------------------------------------------



always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin 
            vinwfrmi <= 1'b0;
            vinwrqi <= 1'b0;
            vinwrt3 <= 1'b0;
            
            vinwrt1 <= 1'b0;
            vinwrt2 <= 1'b0;
            
            wfrmcnt <= 7'd0;
           
       end
    else
       begin
            vinwrt1 <= vinwi;
            if(vinwi==1'b1&&vinwrt1==1'b1)    //-- 跨时钟采样；
               begin
                   vinwrt2 <= 1'b1;            
               end 
            else
               begin
                   vinwrt2 <= 1'b0;
               end               
                 
            vinwrt3 <= vinwrt2;
            
            
            if(vinwrt2==1'b1&&vinwrt3==1'b0)    //-- 跨时钟采样；
               begin
                   vinwrqi <= 1'b1;            
               end 
            else
               begin
                   vinwrqi <= 1'b0;
               end        
                       
            vinwfrmi <=  vinwfi;   
            
            if(vinwrqi==1'b1&&vinwfrmi==1'b1)
               begin
                    wfrmcnt <= wfrmcnt + 1'b1;
               end                                                                                                                                                                                                          		            	                     
       end
end




always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            wtdrwtran <= 1'b0;
            wtdrwfrmf <= 1'b0;
            loc_wreq1 <= 1'b0;
       end
    else
       begin           
            loc_wreq1 <= loc_wreq;   
            if(vinwrqi==1'b1)
               begin
                    wtdrwtran <= 1'b1;
                    if(vinwfrmi==1'b1)          //-- 视频帧的起始；
                       begin
                           wtdrwfrmf <= 1'b1;
                       end
                    else
                       begin
                           wtdrwfrmf <= 1'b0;
                       end
               end                    
            else
               begin
                    if(wrtreq0==1'b1)
                       begin
                            wtdrwtran <= 1'b0;
                       end
               end                                         
       end
end
                

always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            vinra <= 6'd0;
       end
    else
       begin              
            if(vinwrqi==1'b1&&vinwfrmi==1'b1)   
               begin
                    vinra <= 6'd0;
               end                    
            else
               begin
                    if(loc_wreq==1'b1)
                       begin
                            vinra <= vinra + 1'b1;   //-- 一帧视频数据除了帧开始地址需要清0外，其余按顺序递增循环，一直到一帧结束；
                       end
               end                                         
       end
end



//-------------------------------------------------


assign loc_addr = (addrwflg==1'b1)? wrtaddr : rdaddr;      //-- 读写DDR地址选择；



always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            wrtaddr <= 24'd0;
       end
    else
       begin              
            wrtaddr[23:21] <= {1'b0,wfrmcnt[6:5]};            //-- DDR BANK 选择；
          
            wrtaddr[20:8]  <= {wfrmcnt[4:0],wrtcnt32[10:3]};   //-- DDR 行地址；
                          
            wrtaddr[7:5] <= wrtcnt32[2:0];              //-- 列地址；                                          
            wrtaddr[4:0] <= wcnt[4:0];                  //-- 列地址； 该地址是按照32bit为单位的，而DDR是以16bit为单位（1CLK上升沿和下降沿均写16bit,共32bit)，地址需要进行扩展；                                                        
       end
end



always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            loc_wdata <= 31'd0;
       end
    else
       begin   
            if(loc_wreq1==1'b1)
               begin          
                   loc_wdata <= vinrdo[31:0];     //-- 写入DDR的数据；每个时钟写32bit；
               end                                                                         
       end
end


//--------------------------------------------


always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            rdaddr <= 24'd0;           
                
       end
    else
       begin                                                          
            if(readrq==1'b1)
                begin
                     rdaddr[23:21] <= {1'b0,rfrmcnt[6:5]};           //-- DDR bank；
                     rdaddr[20:8] <= {rfrmcnt[4:0],rdcnt32[10:3]};   //-- DDR 行地址；
                end     
   
            rdaddr[7:0] <= {rdcnt32[2:0],rcnt[4:0]};      //-- 读DDR的列地址；以32bit为单位； 每个时钟读取32bit；DDR的列是以16bit为单位，需要扩展；
            
                                       
       end
end

//---------------------------------------






//-------------------------------------

reg [10:0]timer;
reg timer50_1;

reg timewrt;
reg timerd;
reg timefrsh;


always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            timer <= 11'd0;
       end
    else
       begin
            if(timer==11'd200)
               begin
                    timer <= 11'd0;
               end
            else
               begin 
                    timer <= timer + 1'b1;
               end       
       end
end



always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            timer50_1 <= 1'b0;
            timewrt <= 1'b0;
            timerd <= 1'b0;
            timefrsh <= 1'b0;
       end
    else
       begin 
            if(timer[5:0]==6'd1)
               begin
                    timer50_1 <= 1'b1;
               end      
            else
               begin
                    timer50_1 <= 1'b0;
               end
               
            if(timer50_1==1'b1)                 //-- timer 0~200 循环； 在这201个clk里，分时间段分别对DDR进行写入/读取/刷新 三个不同的命令；
               begin
                    if(timer[10:6]==5'd0)
                       begin
                            timewrt <= 1'b1;
                       end
                       
                    if(timer[10:6]==5'd1)
                       begin
                            timerd <= 1'b1;
                       end       
                       
                    if(timer[10:6]==5'd2)
                       begin
                            timefrsh <= 1'b1;
                       end                                          
               end
            else
               begin
                    timewrt <= 1'b0;
                    timerd <= 1'b0;
                    timefrsh <= 1'b0;
               end
       end
end






//-------------------------------------

reg wrtreq0;
reg wrtreq1;

always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            rfrshrq <= 1'b0;
            wrtrq <= 1'b0;
            readrq <= 1'b0;
            
            wrtreq0 <= 1'b0;
            wrtreq1 <= 1'b0;
            
            wrtcnt32 <= 11'd0;
            rdcnt32 <= 11'd0;
            viewfrmfst <= 1'b0;
            
            rfrmcnt <= 7'd0;
       end
    else
       begin 
            wrtreq1 <= wrtreq0;
            wrtrq <= wrtreq1;           
                        

            if(timewrt==1'b1&&wtdrwtran==1'b1)
               begin
                   wrtreq0 <= 1'b1;                //-- 写启动信号，维持1clk； 在分配的写DDR时间段里，是否真正需要写入还要配合其他参数；
                   if(wtdrwfrmf==1'b1)
                      begin
                           wrtcnt32 <= 11'd0;
                      end
                   else
                      begin
                           wrtcnt32 <= wrtcnt32 + 1'b1;
                      end
               end
            else
               begin
                   wrtreq0 <= 1'b0;
               end
                                               
            if(timerd==1'b1&&viewrdrq==1'b1)          //-- 在分配的读取DDR的时间段内，是否要读取根据viewrdrq而定；
               begin
                    readrq <= 1'b1;
                    if(viewfrmfst==1'b1)
                       begin 
                           rdcnt32 <= 11'd0;
                       end
                    else
                       begin
                           rdcnt32 <= rdcnt32 + 1'b1;
                       end
               end
            else
               begin
                    readrq <= 1'b0;
               end 
               
            if(viewrdfi==1'b1)
                begin
                     viewfrmfst <= 1'b1;
                     rfrmcnt <= wfrmcnt[6:0]-2'd2;      //-- 写入和读取DDR中的视频帧相差2帧时间； 即一边不断的往DDR中写入采集的视频数据；另外不断的读取DDR中的视频
                end                                     //-- 数据送到LCD中进行实时显示；二者相差2帧的时间；
            else
                begin
                     if(rdviewdone==1'b1)
                        begin
                            viewfrmfst <= 1'b0;
                        end
                end                                     
            

            rfrshrq <= timefrsh;                                       
       end
end





always @(posedge clkddr or negedge rstn)
begin
	if (!rstn)
		begin
  		     CTRL<= IDLE;
  		     loc_wreq<=0;
  		     loc_rreq<=0;
  		     loc_rshrq <= 1'b0;
  		     wrtfst <= 1'b0;
  		     wcnt <= 8'd0;
  		     drwnum <= 6'd0; 
  		     drrnum <= 8'd0;
  		     rdfst <= 1'b0;
  		     rdviewdone <= 1'b0;
  		     rcnt <= 8'd0;
  		     addrwflg <= 1'b0;			     
		end
	else
		begin		
			case (CTRL)
				IDLE: 
					begin
					     if(drinitok==1'b1)        //--初始化完成后进入等待读写命令；
					          begin
						       CTRL<= DRWAIT;
						  end
					end 
		       
				
				DRWAIT:
					begin	
					        rdviewdone <= 1'b0;				        					        
					        if(wrtrq==1'b1)                 //-- 写DDR要求；
					             begin
					                  loc_wreq<=1'b1;
					                  addrwflg <= 1'b1;
					                  wrtfst <= 1'b1;
					                  wcnt <= 8'd0;					                  
					                  drwnum <= 6'd31;  
					                  CTRL <= DRWRT;					                  					                  
					             end
					        else
					             begin
					                  if(readrq==1'b1)         //-- 读DDR要求；
					                      begin
					                           begin
					                                loc_rreq<=1'b1;
					                                rdfst <= 1'b1;
					                                rcnt <= 8'd0;
					                                addrwflg <= 1'b0;
					                                   
					                                drrnum <= 8'd31;
					                                CTRL <= DRREAD;				                                       					                                
					                           end
					                      end
					                  else
					                      begin
					                           if(rfrshrq==1'b1)         //-- DDR 刷新要求；
					                               begin
					                                    loc_rshrq <= 1'b1;
					                                    CTRL <= DRRFRSH;
					                               end
					                      end
					             end
					end


					
				DRWRT:
				        begin	
				             wrtfst <= 1'b0;
				             
				             if(wrtfst==1'b1) 
				                begin
				                     loc_wreq <= 1'b0;   //-- 第一个loc_wreq发出后，要间隔几个clk后再发出第二个loc_wreq；
				                end                      //-- 主要因为ddr_ctrl模块中根据loc_wreq来启动active命令，而active到wrt需要一段时间间隔；
				             else
				                begin
				                     if(drrdy==1'b1)
				                         begin
				                              wcnt <= wcnt + 1'b1;
				                              if(wcnt[5:0]==drwnum)
				                                 begin
				                                      loc_wreq <= 1'b0;      //-- loc_wreq为1的时钟个数(包括第一个loc_wreq)刚好等于需要写入的数据个数；				                                      
				                                      CTRL <= DRWRT1;       
				                                 end
				                              else
				                                 begin
				                                      loc_wreq <= 1'b1;
				                                 end
				                         end
				                end				             				             																																																
				        end
				        
				DRWRT1: 
				        begin				             				             
				             CTRL <= DRWRT2;     				             				             
				        end

				DRWRT2: 
				        begin		             				             
				             CTRL <= DRWAIT;
				        end
				        				        				        			        				        
				        
				DRREAD:
					begin
					     rdfst <= 1'b0;
					     
					     if(rdfst==1'b1)
					         begin
					             loc_rreq <= 1'b0;   //-- 第一个loc_rreq发出后，要间隔几个clk后再发出第二个loc_rreq；根据该信号启动active;
					         end
					     else
					         begin
					             if(drrdy==1'b1)
					                 begin
					                      rcnt <= rcnt+1'b1;
							      if(rcnt==drrnum)          
							      	   begin
							      		loc_rreq<=1'b0;   //-- loc_rreq为1的时钟个数刚好等于需要读取的数据个数；
							      		rdviewdone <= 1'b1;
							      		CTRL <= DRWAIT;
							      	   end
							      else
							      	begin
							      		loc_rreq<=1'b1;
							      	end					                      
					                 end
					         end
					     
					end									
					
			        DRRFRSH: 
			                begin
			                     loc_rshrq <= 1'b0;     //-- 刷新命令只要维持1clk即可，至于每次刷新的次数则有ddr_ctrl模块来定；
			                     CTRL <= DRWAIT;
			                end					
			endcase
		end
end		
				

	
endmodule