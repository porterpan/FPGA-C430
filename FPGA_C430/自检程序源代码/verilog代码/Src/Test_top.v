

//====================================================================================

  //  Author           :     hevc265
  //  Data             :     2013-03-10
  //  Rev              :     1.0
  //  HomePage         :     hevc265.taobao.com       
   
//====================================================================================


  //--  NOTE:
  
  //--  1.  开发板测试程序顶层模块；
  
  //--  2.  该测试程序涵盖了开发板所有外围器件的测试；
 
  //--  3.  列出了开发板所有需要分配及可用的IO管脚； 所有IO管脚均不复用；
  
  //--  4.  除了32个扩展IO管脚的输入输出定义根据实际需要外，其余管脚的输入输出基本固定； 

  //--  5.  每个外围器件均以独立模块编程

//====================================================================================



`timescale 1ns / 1ps


module  Test_top(
                  rstn,           //-- 复位信号:   对应开发板 Reset 按键  
		  clk_50M,        //-- 时钟源1 :   对应开发板 X1
		  clk_40M,        //-- 时钟源2 :   对应开发板 X2
		  
		  epcs_data0,
		  epcs_dclk,
		  epcs_asdo,
		  epcs_ncso,
		  
		  ddr_csn,        //-- DDR:        H5DU2562GTR-E3C
		  ddr_cke,
		  ddr_addr,  
		  ddr_ba,    
		  ddr_rasn, 
		  ddr_casn, 
		  ddr_wen,  
		  ddr_clkp,   
		  ddr_clkn, 
		  ddr_dq,    
		  ddr_udqs,   
		  ddr_ldqs, 
		  ddr_udm, 
		  ddr_ldm,      			  

		  sdr_csn,        //-- SDRAM:      H57V2562GTR-60C
		  sdr_cke,
		  sdr_addr,  
		  sdr_ba,    
		  sdr_rasn, 
		  sdr_casn, 
		  sdr_wen,  
		  sdr_clk,   
		  sdr_dq,     
		  sdr_udm, 
		  sdr_ldm, 		  
		  
                  lcd_rst,        //-- LCD:   2.8 TFT 8BIT data mode;
                  lcd_cs,
                  lcd_rs,
                  lcd_rd,
                  lcd_wr,
                  lcd_dat,		                    

                  saa_scl,        //-- Video in:   SAA7113H
                  saa_sda,
                  saa_llc,
                  saa_vpo,                                   

                  aud_sclk,        //-- Audio Codec:   WM8731
                  aud_sdin,
                  aud_bclk,
                  aud_adclrc,
                  aud_daclrc,
                  aud_adcdat,
                  aud_dacdat,
                  
                  usb_intn,       //-- USB+SD:    CH376T              
                  usb_scs,     
                  usb_sck,
                  usb_sdi,
                  usb_sdo,                  
                  
                  net_intn,       //-- NET:     ENC28J60
                  net_woln,                 
                  net_so,
                  net_si,
                  net_sck,
                  net_csn,
                  net_rstn,     
                  
                  rs_rxd,         //-- 串口RS-232:           
                  rs_txd, 
                  
                  vga_r,          //-- VGA output
                  vga_g,
                  vga_b,                 
                  vga_hs,
                  vga_vs, 
                  vga_blk,
                  vga_syn,
                  vga_clk,	                  
                  
                  ps2_dat,        //-- PS2 keyboard
                  ps2_clk,                                      

                  rtc_rstn,       //-- RTC:  DS1302Z
                  rtc_clk,
                  rtc_dat,
                  
                  ir_din,

                  seg7_leda,      //-- 4位七段数码管
                  seg7_ledb,
                  seg7_ledc,
                  seg7_ledd,
                  seg7_lede,
                  seg7_ledf,
                  seg7_ledg,
                  seg7_ledh,                  
                  seg7_sel0,
                  seg7_sel1,
                  seg7_sel2,
                  seg7_sel3,

	          sw_1,            //-- 4位拨码开关
	          sw_2,
	          sw_3,
	          sw_4,
	               
                  btn_rgt,         //-- 按键
                  btn_lft,
                  btn_ent,
	                            
                  led_01,           //-- 发光二极管
                  led_02,
                  led_03,
                  led_04, 
                  
                  ext_io            //-- 32位扩展IO                                       	             
                  
	             	            	             	             																			
		    );   
			   

			   
			   
//===============================================================================================================================

input rstn;			   
input clk_50M;           
input clk_40M;   


//====== EPCS16 ========================================================
input  epcs_data0;
output epcs_dclk;
output epcs_asdo;
output epcs_ncso;       

//===== DDR:  hynix H5DU2562GTR-E3C(256Mbit 16M*16bit)======================
                
output ddr_csn;
output ddr_cke;
output ddr_rasn;
output ddr_casn;
output ddr_wen;
output ddr_clkp;
output ddr_clkn;
output [12:0]ddr_addr;
output [1:0]ddr_ba;

inout  [15:0]ddr_dq;     
inout  ddr_udqs;     
inout  ddr_ldqs;
inout  ddr_udm;
inout  ddr_ldm;


//===== SDRAM: hynix  H57V2562GTR-60C (256Mbit 16M×16bit)=====================

output sdr_csn;
output sdr_cke;
output sdr_rasn;
output sdr_casn;
output sdr_wen;
output sdr_clk;
output [12:0]sdr_addr;
output [1:0]sdr_ba;

inout  [15:0]sdr_dq;     
inout  sdr_udm;
inout  sdr_ldm;


//====== SPI FLASH:  winbond W25Q64BV (64Mbit) ================================

//--output flsh_csn;          //-- not support quad SPI;
//--output flsh_di;
//--input  flsh_do;
//--output flsh_clk;



//===== LCD:  2.8" TFT  240×320  ILI9325 8bit mode ===========================

output lcd_rst;
output lcd_cs;
output lcd_rs;
output lcd_rd;
output lcd_wr;

output [7:0]lcd_dat;


//===== Video In:  SAA7113H  =================================================


output saa_scl;
inout  saa_sda;

input  saa_llc;
input  [7:0]saa_vpo;



//===== Audio:   WM8731  SSOP28 ==========================================


output aud_sclk;
output aud_sdin;

input aud_bclk;     
input aud_adclrc;  
input aud_daclrc;   
input  aud_adcdat;
output aud_dacdat;



//===== USB+SD:  CH376T (SPI mode)========================================

input  usb_intn;

output usb_scs;     
output usb_sck;
output usb_sdi;
input  usb_sdo;


//===== Net:  ENC28J60  SSOP28 ===========================================

input  net_intn;
input  net_woln;

input  net_so;
output net_si;
output net_sck;
output net_csn;
output net_rstn;


//===== UART 串口： RS-232  MAX3232 ======================================

input  rs_rxd;
output rs_txd;


//===== VGA:   OUT =======================================================

output [7:0]vga_r;
output [7:0]vga_g;
output [7:0]vga_b;
output  vga_blk;
output  vga_syn;
output  vga_clk;

output vga_hs;
output vga_vs;


//====== PS2: 键盘 ========================================================

input  ps2_dat;
input  ps2_clk; 





//====== RTC:  DS1302Z ===================================================== 

output rtc_rstn;
output rtc_clk;
inout  rtc_dat;

//====== IR: ===============================================================

input ir_din;


//====== 7seg 数码管 ==========================================================

output seg7_leda;
output seg7_ledb;
output seg7_ledc;
output seg7_ledd;
output seg7_lede;
output seg7_ledf;
output seg7_ledg;
output seg7_ledh;

output seg7_sel0;
output seg7_sel1;
output seg7_sel2;
output seg7_sel3;


//===== 拨码开关  4位 ==========================================================

input  sw_1;
input  sw_2;
input  sw_3;
input  sw_4;


//===== 按键  ==================================================================

input  btn_rgt;
input  btn_lft;
input  btn_ent;



//===== 发光二极管 =============================================================

output led_01;     
output led_02;
output led_03;
output led_04;


//===== 扩展IO: 32 =============================================================

output [35:0]ext_io;     //-- 输入输出定义根据实际需要而定；



//================================================= IO Define END =============



//================================================================================

//-- PLL1

wire clk_sdr;
wire clk_100M;
wire clk_65M;
wire clk_25M;
wire pllok1;

wire clk_ddr;
wire clk_dqs;
wire clk_drrd;
wire pllok2;

wire clk_30M;
wire pllok3;



//--

wire dispinit;
wire [15:0]dispdat;
wire disprdy;
wire displast;
wire [1:0]disptype;
wire dispext;
wire vfiforrq;
wire adcdisprq;
wire adcen;

wire disptest;

wire dispdrq;

wire [15:0]vfifordo;
wire vfiforemp;
wire [10:0]vfiforuse;
wire vfifowf;
wire [9:0]vfifowuse;

wire saatest;

wire [31:0]rgbdo;
wire rgbwe;
wire [5:0]rgbwa;


wire [31:0]drrdata;
wire drrvld;

wire [31:0]vinrdo;
wire [5:0]vinra;

wire vdatawi;
wire vdatawf;


wire adcdispwsel;
wire [7:0]adcdispdi;
wire [9:0]adcdispra;
wire [9:0]adcdispwa;
wire [7:0]adcdispdo;
wire adcdispwe;

wire [31:0]ir_data;
wire ir_vld;
wire irtest;

wire [23:0]rtc_time;

wire [7:0]uart_recdi;
wire [15:0]ps2_recdi;
wire ps2_vld;

wire adda_en;
wire aud_en;
wire vga_en;
wire [15:0]flsh_rdo;

wire [3:0]seg7_type;
wire [15:0]seg7_adda;
wire [15:0]seg7_dusbsd;

wire net_en;
wire usbsd_en;
wire usbsd_sel;
wire extio_en;
wire net_testdo;
wire [15:0]usbsd_rdo;
wire usbsd_rvld;

//================================================ PLL =======================================================================


PLL1 PLL1(
	  .inclk0(clk_50M),    //-- PLL input clk;	
	  .c0(clk_sdr),	
	  .c1(clk_100M),	
	  .c2(clk_65M),	
	  .c3(clk_25M),	
	  .c4(),	
	  .locked(pllok1)	
	  );

PLL2 PLL2(
	  .inclk0(clk_40M),    //-- PLL input clk;	
	  .c0(clk_ddr),	
	  .c1(clk_dqs),	
	  .c2(clk_drrd),		
	  .locked(pllok2)	
	  ); 
	  

PLL3 PLL3(
	  .inclk0(clk_25M),    //-- PLL input clk;	
	  .c0(clk_30M),	
	  .c1(),			
	  .locked(pllok3)	
	  ); 	  


//================================================ RAM =======================================================

wire vfifowclr;
wire [31:0]vfifowdi;
wire vfifowe;
wire vfifofrmi;



DISP_FIFO dispfifo (
                    .wrclk(clk_ddr),
	            .aclr(vfifoclr),
	            .data({vfifowdi[15:0],vfifowdi[31:16]}),	            
	            .wrreq(vfifowe),
	            .wrfull(vfifowf),
	            .wrusedw(vfifowuse),
	            	            	            
	            .rdclk(clk_100M),
	            .rdreq(vfiforrq),
	            .q(vfifordo),
	            .rdempty(vfiforemp),
	            .rdusedw(vfiforuse)
	            );


dpram_64w32_64r32 saaout_ram (
                               .wrclock(saa_llc),
	                       .data(rgbdo[31:0]),
	                       .wraddress(rgbwa[5:0]),	              
	                       .wren(rgbwe),
	                       
	                       .rdclock(clk_ddr),	              
	                       .rdaddress(vinra[5:0]),	          
	                       .q(vinrdo[31:0])
	                       );   
	                       
	                       
//--dpram_1024w8_1024r8 adcdisp_ram (
//--                               .wrclock(adc_clk),
//--	                       .data(adcdispdo[7:0]),
//--	                       .wraddress(adcdispwa[9:0]),	              
//--	                       .wren(adcdispwe),
//--	                       
//--	                       .rdclock(clk_100M),	              
//--	                       .rdaddress(adcdispra[9:0]),	          
//--	                       .q(adcdispdi[7:0])
//--	                       );   	                       

//============================================================================================================


always @(posedge clk_100M or negedge rstn)
begin
    if (!rstn)
       begin
	        
  	                  	     	    
       end
    else
       begin
	                                       
       end
end


//================================ NIOS II TOP ==============================

assign sdr_clk = clk_sdr;

  NIOSTOP NIOSTOP_inst
    (
      .clk                         (clk_100M),
      .reset_n                     (rstn),
      
      .out_port_from_the_pio_led   (),      
      .in_port_to_the_NET_EN        (net_en),
      .in_port_to_the_USBSD_SEL     (usbsd_sel),
      .in_port_to_the_USB_EN        (usbsd_en),
      .out_port_from_the_NET_TESTDO (net_testdo),    
      .out_port_from_the_USBSD_RDO  (usbsd_rdo),  
      .out_port_from_the_USBSD_RVLD (usbsd_rvld),                  
   
      .MISO_to_the_LAN             (net_so),
      .MOSI_from_the_LAN           (net_si),
      .SCLK_from_the_LAN           (net_sck),
      .SS_n_from_the_LAN           (),   
      .in_port_to_the_LAN_nINT     (~net_intn),   //--tmp;
      .out_port_from_the_LAN_CS    (net_csn),  
      .out_port_from_the_LAN_RSTN  (net_rstn),  

      .in_port_to_the_USB_INT_I    (usb_intn),
      .in_port_to_the_USB_SDO_I    (usb_sdo),      
      .out_port_from_the_USB_SCS_O (usb_scs),
      .out_port_from_the_USB_SCK_O (usb_sck),
      .out_port_from_the_USB_SDI_O (usb_sdi),       
      
      .data0_to_the_epcs           (epcs_data0),
      .dclk_from_the_epcs          (epcs_dclk),      
      .sce_from_the_epcs           (epcs_ncso),
      .sdo_from_the_epcs           (epcs_asdo),
      
      .zs_addr_from_the_sdram      (sdr_addr),
      .zs_ba_from_the_sdram        (sdr_ba),
      .zs_cas_n_from_the_sdram     (sdr_casn),
      .zs_cke_from_the_sdram       (sdr_cke),
      .zs_cs_n_from_the_sdram      (sdr_csn),
      .zs_dq_to_and_from_the_sdram (sdr_dq),
      .zs_dqm_from_the_sdram       ({sdr_udm,sdr_ldm}),
      .zs_ras_n_from_the_sdram     (sdr_rasn),
      .zs_we_n_from_the_sdram      (sdr_wen)
    );




//=========================== Other ============================================

dispctrl dispctrl(
	          .rstn(rstn),	
                  .clk(clk_100M),                   
                  .dispdrq(dispdrq),
                  .disptype(disptype),
                  .dispext(dispext),
                  .dispexti(vfifofrmi),
                  .vfifordo(vfifordo),
                  .vfiforemp(vfiforemp),
                  .vfiforuse(vfiforuse),
                  .adcdispdi(adcdispdi),
                  .adcdispwsel(adcdispwsel),
                  
                  .dispinit(dispinit),
                  .dispdat(dispdat),
                  .disprdy(disprdy),
                  .displast(displast), 
                  .vfiforrq(vfiforrq),
                  .adcdisprq(adcdisprq),
                  .adcdispra(adcdispra),
                  .test(disptest)                     		  		  
	          );     


//================================= LED + SW(四位拨码开关) ===================================

LED_SW  LED_SW(
	      .rstn(rstn),	
              .clk30M(clk_30M),  
              .clk100M(clk_100M),
              .sw_1(sw_1),          //-- 对应四位拨码开关的 '1'；   拨至'ON'时 SW_1 = 0; 否则为1；
              .sw_2(sw_2),          //-- 对应四位拨码开关的 '2'；   拨至'ON'时 SW_2 = 0; 否则为1；
              .sw_3(sw_3),          //-- 对应四位拨码开关的 '3'；   拨至'ON'时 SW_3 = 0; 否则为1；
              .sw_4(sw_4),          //-- 对应四位拨码开关的 '4'；   拨至'ON'时 SW_4 = 0; 否则为1；                       
              .btn_rgt(btn_rgt),   //-- 按键
              .btn_lft(btn_lft),
              .btn_ent(btn_ent),   
              .ir_vld(ir_vld), 
              .net_testdo(net_testdo),  
              .usbsd_rdo(usbsd_rdo),
              .usbsd_rvld(usbsd_rvld),        
 
              .led_01(led_01),
              .led_02(led_02),
              .led_03(led_03),
              .led_04(led_04),
              .seg7_type(seg7_type),
              .seg7_adda(seg7_adda),
              .seg7_dusbsd(seg7_dusbsd),
              .disptype(disptype),
              .dispext(dispext),
              .adda_en(adda_en), 
              .aud_en(aud_en),             
              .vga_en(vga_en),
              .net_en(net_en),
              .usbsd_en(usbsd_en),
              .usbsd_sel(usbsd_sel),
              .extio_en(extio_en)                                                                                               		  		  	      
	      );  		


//================================= 2.8" TFT LCD ==============================

LCD_top  LCDt(
	      .rstn(rstn),	
              .clk(clk_100M), 
              .dispinit(dispinit),
              .dispdat(dispdat),
              .disprdy(disprdy),
              .displast(displast),               
              
              .lcd_rst(lcd_rst),        
              .lcd_cs(lcd_cs),
              .lcd_rs(lcd_rs),
              .lcd_rd(lcd_rd),
              .lcd_wr(lcd_wr),
              .lcd_dat(lcd_dat),
              .dispdrq(dispdrq),              
              .test(lcdtest)                                                                                             		  		  	      
	      ); 



//================================= Video SAA7113H ============================

video_saa video_saa(
		    .rstn(rstn),	
                    .clk100M(clk_100M),
                    .pllok(pllok1),                 
                    .saa_sclk(saa_scl),
                    .saa_sdat(saa_sda),
                    .saa_llc(saa_llc),
                    .saa_vpo(saa_vpo),
                    
                    .rgbdo(rgbdo),
                    .rgbwe(rgbwe),
                    .rgbwa(rgbwa),                 
                    .vdatawi(vdatawi),
                    .vdatawf(vdatawf),                                                                   
                    .test(saatest)		  		  
		    ); 
		    
		    
//=================================  Audio WM8731 ==============================

audio_wm audio_wm(
		 .rstn(rstn),	
                 .clk100M(clk_100M),
                 .aud_en(aud_en),                 
                 .aud_sclk(aud_sclk),
                 .aud_sdin(aud_sdin),
                 .aud_adcdat(aud_adcdat),

                 .aud_bclk(aud_bclk),                 
                 .aud_adclrc(aud_adclrc),
                 .aud_daclrc(aud_daclrc),
                 .aud_dacdat(aud_dacdat),                                                               
                 .test()		  		  
		); 	
		
		

	      
	      
//=============================== IR =========================================

IR_TOP IR_TOP
	(
	.rstn(rstn),
	.clk100M(clk_100M),	
	.ir_din(ir_din),

	.ir_data(ir_data),
	.ir_vld(ir_vld),
	.test(irtest)
	);	 
	
	
//============================ RTC DS1302Z ==================================


DS1302Z_TOP  RTCt                        
	          (  
	          .rstn(rstn), 	                            	
	          .clk50M(clk_50M),                            
	          .rtc_clk(rtc_clk),             
	          .rtc_rstn(rtc_rstn),             
	          .rtc_dat(rtc_dat),                 
	          .rtc_time(rtc_time)           
	          );      
	          
	          
	          
//============================ VGA ==========================================


vga_top VGAt(                              //-- 1024*768 @60hz;
	     .clk65M(clk_65M),                
	     .rstn(rstn),          
	     .vga_en(vga_en),       
             
	     .vga_hs(vga_hs),                
	     .vga_vs(vga_vs),                
	     .vga_r(vga_r),                 
	     .vga_g(vga_g),                 
	     .vga_b(vga_b),
             .vga_blk(vga_blk),
             .vga_syn(vga_syn),
             .vga_clk(vga_clk)	                       
	     );	          
	     

//=========================== UART RS232 COM =================================


UART_TOP UARTt
	     (
		.SYSCLK(clk_50M),
		.RST_B(rstn),

		.UART_RX_I(rs_rxd),
		.UART_TX_O(rs_txd),
		
		.uart_recdi(uart_recdi)	
	     );	 


//=========================== PS2 Keyboard =====================================
	     
PS2_TOP PS2t
	(
	 .SYSCLK(clk_50M),
	 .RST_B(rstn),
	
	 .PS2_CLK(ps2_clk),
	 .PS2_DATA(ps2_dat),
	 .DATA_REC(ps2_recdi),
	 .DATA_VLD(ps2_vld)
	);   
		 
	      	
	      	
	      	
//================================ seg7 LED ===================================

seg7_led seg7_led(
	       .rstn(rstn),	
               .clk(clk_100M), 
               .seg7_type(seg7_type), 
               .seg7_adda(seg7_adda),
               .seg7_irdi({ir_data[8],ir_data[9],ir_data[10],ir_data[11],ir_data[12],ir_data[13],ir_data[14],ir_data[15]}),
               .seg7_dsdi(rtc_time[15:0]),  
               .seg7_uartdi(uart_recdi[7:0]), 
               .seg7_ps2di(ps2_recdi[15:0]),  
               .seg7_flshrdo(flsh_rdo[15:0]),
               .seg7_dusbsd(seg7_dusbsd[15:0]),         

               .seg7_leda(seg7_leda),      
               .seg7_ledb(seg7_ledb),
               .seg7_ledc(seg7_ledc),
               .seg7_ledd(seg7_ledd),
               .seg7_lede(seg7_lede),
               .seg7_ledf(seg7_ledf),
               .seg7_ledg(seg7_ledg),
               .seg7_ledh(seg7_ledh),                  
               .seg7_sel0(seg7_sel0),
               .seg7_sel1(seg7_sel1),
               .seg7_sel2(seg7_sel2),
               .seg7_sel3(seg7_sel3)                                  		  		  
	      );   	        		    
		    


//================================ EXT IO ======================================

EXT_IO EXT_IO(   
              .rstn(rstn),
	      .clk40M(clk_40M),
	      .extio_en(extio_en),
              
	      .ext_io(ext_io)
	      );		    


	      
	   
//================================= DDR =========================================



ddr_top ddrtop(
		 .rstn(rstn),	
                 .clkddr(clk_ddr),
                 .clkdrdqs(clk_dqs),
                 .clkdrrd(clk_drrd),    
                 .vinwi(vdatawi),
                 .vinwfi(vdatawf),              
                 .viewrdfi(),
                 .viewrdrq(),
                 .vinrdo(vinrdo),                 
	         .vfifowf(vfifowf),
	         .vfifowuse(vfifowuse),                                         
                                           
                 
		 .mem_cs_n(ddr_csn),
		 .mem_cke(ddr_cke),
		 .mem_addr(ddr_addr),  
		 .mem_ba(ddr_ba),    
		 .mem_ras_n(ddr_rasn), 
		 .mem_cas_n(ddr_casn), 
		 .mem_we_n(ddr_wen),  
		 .mem_clk(ddr_clkp),   
		 .mem_clk_n(ddr_clkn), 
		 .mem_dq(ddr_dq),    
	         .mem_udqs(ddr_udqs),
	         .mem_ldqs(ddr_ldqs),   
	         .mem_udm(ddr_udm),
	         .mem_ldm(ddr_ldm),	         
                 .pllok(pllok2),	               
                 .loc_done(),
                 .loc_rdy(),  
                 .drrdata(drrdata),
                 .drrvld(drrvld),	                                                                                                                                                  
                 .vinra(vinra),
	         .vfifoclr(vfifoclr),
	         .vfifowdi(vfifowdi),	            
	         .vfifowe(vfifowe),
	         .vfifofrmi(vfifofrmi),
                                                                   
                 .test()		  		  
		);
		
		
		


//===============================================================================	

endmodule