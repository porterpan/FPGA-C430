//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================

 //-- extio_en=1， 32个扩展IO口（另外两个扩展口为电源和地）将输出方波信号，有几个不同频率值；
 
 

//====================================================================================
  

`timescale 1ns / 1ps


module EXT_IO(   
              rstn,
	      clk40M,
	      extio_en,
              
	      ext_io
	      );
	


input	clk40M;
input	rstn;
input   extio_en;

output [35:0]ext_io;


wire [35:0]ext_io;


//===========================================================================



reg [15:0]ncnt;

always @(posedge clk40M or negedge rstn)
begin
    if (!rstn)
       begin
            ncnt <= 16'd0;
       end
    else
       begin 
            if(extio_en==1'b1)
               begin
                    ncnt <= ncnt + 1'b1;     
               end
            else
               begin
                    ncnt <= 16'd0;
               end                
       end
end

assign ext_io[35] = ncnt[15];	
assign ext_io[34] = ncnt[14];
assign ext_io[33] = ncnt[13];
assign ext_io[32] = ncnt[12];	

assign ext_io[31] = ncnt[15];	
assign ext_io[30] = ncnt[14];
assign ext_io[29] = ncnt[13];
assign ext_io[28] = ncnt[12];

assign ext_io[27] = ncnt[15];	
assign ext_io[26] = ncnt[14];
assign ext_io[25] = ncnt[13];
assign ext_io[24] = ncnt[12];


assign ext_io[23] = ncnt[15];	
assign ext_io[22] = ncnt[14];
assign ext_io[21] = ncnt[13];
assign ext_io[20] = ncnt[12];

assign ext_io[19] = ncnt[15];	
assign ext_io[18] = ncnt[14];
assign ext_io[17] = ncnt[13];
assign ext_io[16] = ncnt[12];

assign ext_io[15] = ncnt[15];	
assign ext_io[14] = ncnt[14];
assign ext_io[13] = ncnt[13];
assign ext_io[12] = ncnt[12];

assign ext_io[11] = ncnt[15];	
assign ext_io[10] = ncnt[14];
assign ext_io[9] = ncnt[13];
assign ext_io[8] = ncnt[12];

assign ext_io[7] = ncnt[15];	
assign ext_io[6] = ncnt[14];
assign ext_io[5] = ncnt[13];
assign ext_io[4] = ncnt[12];

assign ext_io[3] = ncnt[15];	
assign ext_io[2] = ncnt[14];
assign ext_io[1] = ncnt[13];
assign ext_io[0] = ncnt[12];
//===========================================================================



endmodule

 