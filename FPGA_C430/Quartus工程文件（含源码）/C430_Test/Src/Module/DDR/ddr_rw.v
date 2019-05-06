
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
input clkddr;           //-- DDR ��ʱ�ӣ�
input drinitok;         //-- DDR��ɳ�ʼ����
input drrdy;            //-- DDRæ���е�״̬�� Ϊ1ʱ˵�����Զ�DDR���в�����      
input vinwi;            //-- ��Ƶ����д�����źţ�ÿһ��дһ�����ݣ� 
input vinwfi;           //-- Ϊ1˵��������д�����Ƶ����Ϊһ֡��Ƶ���ݵ���ʼ���ݣ�
input viewrdfi;         //-- Ϊ1˵�������ζ�ȡ������ΪLCD��ʾ����֡����ʼ�źţ� 
input viewrdrq;         //-- LCD��ʾ���ݶ�ȡҪ���źţ�
input [31:0]vinrdo;     //-- д�뵽DDR����Ƶ���ݣ�


output loc_wreq;        //-- ��DDR����д���ݵ�Ҫ���źţ�loc_wreqΪ1��ʱ�ӳ��ȱ�����д��DDR�����ݸ�����32bitΪ��λ������
output loc_rreq;        //-- ��DDR���ж�ȡ���ݵ�Ҫ���źţ�loc_rreqΪ1��ʱ�ӳ��ȱ����˶�ȡDDR�����ݸ�����32bitΪ��λ������
output loc_rshrq;       //-- Ϊ1������DDR��ʼ����ˢ�µ���� ˢ�µĴ�����ddr_ctrl���־�����
output [23:0]loc_addr;   //-- ��дDDR�ĵ�ַ��������BANK/��/�� �ĵ�ַ��Ϣ��
output [31:0]loc_wdata;  //-- д��DDR�����ݣ�
output [5:0]vinra;       //-- ��ȡ��Ƶ���ݵĵ�ַ�������ݽ�д�뵽DDR�У���

output test;            //-- �����źţ�


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
            if(vinwi==1'b1&&vinwrt1==1'b1)    //-- ��ʱ�Ӳ�����
               begin
                   vinwrt2 <= 1'b1;            
               end 
            else
               begin
                   vinwrt2 <= 1'b0;
               end               
                 
            vinwrt3 <= vinwrt2;
            
            
            if(vinwrt2==1'b1&&vinwrt3==1'b0)    //-- ��ʱ�Ӳ�����
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
                    if(vinwfrmi==1'b1)          //-- ��Ƶ֡����ʼ��
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
                            vinra <= vinra + 1'b1;   //-- һ֡��Ƶ���ݳ���֡��ʼ��ַ��Ҫ��0�⣬���ఴ˳�����ѭ����һֱ��һ֡������
                       end
               end                                         
       end
end



//-------------------------------------------------


assign loc_addr = (addrwflg==1'b1)? wrtaddr : rdaddr;      //-- ��дDDR��ַѡ��



always @(posedge clkddr or negedge rstn)
begin
    if (!rstn)
       begin
            wrtaddr <= 24'd0;
       end
    else
       begin              
            wrtaddr[23:21] <= {1'b0,wfrmcnt[6:5]};            //-- DDR BANK ѡ��
          
            wrtaddr[20:8]  <= {wfrmcnt[4:0],wrtcnt32[10:3]};   //-- DDR �е�ַ��
                          
            wrtaddr[7:5] <= wrtcnt32[2:0];              //-- �е�ַ��                                          
            wrtaddr[4:0] <= wcnt[4:0];                  //-- �е�ַ�� �õ�ַ�ǰ���32bitΪ��λ�ģ���DDR����16bitΪ��λ��1CLK�����غ��½��ؾ�д16bit,��32bit)����ַ��Ҫ������չ��                                                        
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
                   loc_wdata <= vinrdo[31:0];     //-- д��DDR�����ݣ�ÿ��ʱ��д32bit��
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
                     rdaddr[23:21] <= {1'b0,rfrmcnt[6:5]};           //-- DDR bank��
                     rdaddr[20:8] <= {rfrmcnt[4:0],rdcnt32[10:3]};   //-- DDR �е�ַ��
                end     
   
            rdaddr[7:0] <= {rdcnt32[2:0],rcnt[4:0]};      //-- ��DDR���е�ַ����32bitΪ��λ�� ÿ��ʱ�Ӷ�ȡ32bit��DDR��������16bitΪ��λ����Ҫ��չ��
            
                                       
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
               
            if(timer50_1==1'b1)                 //-- timer 0~200 ѭ���� ����201��clk���ʱ��ηֱ��DDR����д��/��ȡ/ˢ�� ������ͬ�����
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
                   wrtreq0 <= 1'b1;                //-- д�����źţ�ά��1clk�� �ڷ����дDDRʱ�����Ƿ�������Ҫд�뻹Ҫ�������������
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
                                               
            if(timerd==1'b1&&viewrdrq==1'b1)          //-- �ڷ���Ķ�ȡDDR��ʱ����ڣ��Ƿ�Ҫ��ȡ����viewrdrq������
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
                     rfrmcnt <= wfrmcnt[6:0]-2'd2;      //-- д��Ͷ�ȡDDR�е���Ƶ֡���2֡ʱ�䣻 ��һ�߲��ϵ���DDR��д��ɼ�����Ƶ���ݣ����ⲻ�ϵĶ�ȡDDR�е���Ƶ
                end                                     //-- �����͵�LCD�н���ʵʱ��ʾ���������2֡��ʱ�䣻
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
					     if(drinitok==1'b1)        //--��ʼ����ɺ����ȴ���д���
					          begin
						       CTRL<= DRWAIT;
						  end
					end 
		       
				
				DRWAIT:
					begin	
					        rdviewdone <= 1'b0;				        					        
					        if(wrtrq==1'b1)                 //-- дDDRҪ��
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
					                  if(readrq==1'b1)         //-- ��DDRҪ��
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
					                           if(rfrshrq==1'b1)         //-- DDR ˢ��Ҫ��
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
				                     loc_wreq <= 1'b0;   //-- ��һ��loc_wreq������Ҫ�������clk���ٷ����ڶ���loc_wreq��
				                end                      //-- ��Ҫ��Ϊddr_ctrlģ���и���loc_wreq������active�����active��wrt��Ҫһ��ʱ������
				             else
				                begin
				                     if(drrdy==1'b1)
				                         begin
				                              wcnt <= wcnt + 1'b1;
				                              if(wcnt[5:0]==drwnum)
				                                 begin
				                                      loc_wreq <= 1'b0;      //-- loc_wreqΪ1��ʱ�Ӹ���(������һ��loc_wreq)�պõ�����Ҫд������ݸ�����				                                      
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
					             loc_rreq <= 1'b0;   //-- ��һ��loc_rreq������Ҫ�������clk���ٷ����ڶ���loc_rreq�����ݸ��ź�����active;
					         end
					     else
					         begin
					             if(drrdy==1'b1)
					                 begin
					                      rcnt <= rcnt+1'b1;
							      if(rcnt==drrnum)          
							      	   begin
							      		loc_rreq<=1'b0;   //-- loc_rreqΪ1��ʱ�Ӹ����պõ�����Ҫ��ȡ�����ݸ�����
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
			                     loc_rshrq <= 1'b0;     //-- ˢ������ֻҪά��1clk���ɣ�����ÿ��ˢ�µĴ�������ddr_ctrlģ��������
			                     CTRL <= DRWAIT;
			                end					
			endcase
		end
end		
				

	
endmodule