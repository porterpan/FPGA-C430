# Copyright (C) 1991-2012 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II 32-bit Version 12.0 Build 178 05/31/2012 SJ Full Version
# File: G:\C430_Test.tcl
# Generated on: Mon Apr 07 15:39:58 2014

package require ::quartus::project

set_location_assignment PIN_Y22 -to net_intn
set_location_assignment PIN_W21 -to net_woln
set_location_assignment PIN_W22 -to net_so
set_location_assignment PIN_V21 -to net_si
set_location_assignment PIN_V22 -to net_sck
set_location_assignment PIN_U21 -to net_csn
set_location_assignment PIN_U22 -to net_rstn
set_location_assignment PIN_Y21 -to ps2_clk
set_location_assignment PIN_AA21 -to ps2_dat
set_location_assignment PIN_H17 -to usb_intn
set_location_assignment PIN_T18 -to usb_sdo
set_location_assignment PIN_U20 -to usb_sdi
set_location_assignment PIN_U19 -to usb_sck
set_location_assignment PIN_W20 -to usb_scs
set_location_assignment PIN_T22 -to clk_50M
set_location_assignment PIN_R21 -to rs_txd
set_location_assignment PIN_R22 -to rs_rxd
set_location_assignment PIN_Y1 -to vga_vs
set_location_assignment PIN_Y2 -to vga_hs
set_location_assignment PIN_F20 -to saa_sda
set_location_assignment PIN_F22 -to saa_scl
set_location_assignment PIN_G22 -to saa_llc
set_location_assignment PIN_F21 -to saa_vpo[7]
set_location_assignment PIN_E22 -to saa_vpo[6]
set_location_assignment PIN_E21 -to saa_vpo[5]
set_location_assignment PIN_D22 -to saa_vpo[4]
set_location_assignment PIN_D21 -to saa_vpo[3]
set_location_assignment PIN_C22 -to saa_vpo[2]
set_location_assignment PIN_C21 -to saa_vpo[1]
set_location_assignment PIN_B22 -to saa_vpo[0]
set_location_assignment PIN_P22 -to aud_bclk
set_location_assignment PIN_R20 -to aud_dacdat
set_location_assignment PIN_M21 -to aud_daclrc
set_location_assignment PIN_H21 -to aud_adcdat
set_location_assignment PIN_P21 -to aud_adclrc
set_location_assignment PIN_H22 -to aud_sdin
set_location_assignment PIN_M22 -to aud_sclk
set_location_assignment PIN_A10 -to sdr_addr[4]
set_location_assignment PIN_B10 -to sdr_addr[5]
set_location_assignment PIN_D10 -to sdr_addr[6]
set_location_assignment PIN_B13 -to sdr_addr[7]
set_location_assignment PIN_A13 -to sdr_addr[8]
set_location_assignment PIN_B14 -to sdr_addr[9]
set_location_assignment PIN_A14 -to sdr_addr[11]
set_location_assignment PIN_B15 -to sdr_addr[12]
set_location_assignment PIN_A15 -to sdr_cke
set_location_assignment PIN_B16 -to sdr_clk
set_location_assignment PIN_A16 -to sdr_udm
set_location_assignment PIN_B17 -to sdr_dq[8]
set_location_assignment PIN_A17 -to sdr_dq[9]
set_location_assignment PIN_A18 -to sdr_dq[10]
set_location_assignment PIN_B18 -to sdr_dq[11]
set_location_assignment PIN_A19 -to sdr_dq[12]
set_location_assignment PIN_B19 -to sdr_dq[13]
set_location_assignment PIN_A20 -to sdr_dq[14]
set_location_assignment PIN_B20 -to sdr_dq[15]
set_location_assignment PIN_B3 -to sdr_addr[3]
set_location_assignment PIN_A3 -to sdr_addr[2]
set_location_assignment PIN_B4 -to sdr_addr[1]
set_location_assignment PIN_C3 -to sdr_addr[0]
set_location_assignment PIN_C4 -to sdr_addr[10]
set_location_assignment PIN_C6 -to sdr_ba[1]
set_location_assignment PIN_C7 -to sdr_ba[0]
set_location_assignment PIN_D6 -to sdr_csn
set_location_assignment PIN_A4 -to sdr_rasn
set_location_assignment PIN_B5 -to sdr_casn
set_location_assignment PIN_A5 -to sdr_wen
set_location_assignment PIN_B6 -to sdr_ldm
set_location_assignment PIN_A6 -to sdr_dq[7]
set_location_assignment PIN_B7 -to sdr_dq[6]
set_location_assignment PIN_A7 -to sdr_dq[5]
set_location_assignment PIN_B8 -to sdr_dq[4]
set_location_assignment PIN_A8 -to sdr_dq[3]
set_location_assignment PIN_B9 -to sdr_dq[2]
set_location_assignment PIN_A9 -to sdr_dq[1]
set_location_assignment PIN_C10 -to sdr_dq[0]
set_location_assignment PIN_V13 -to lcd_cs
set_location_assignment PIN_H5 -to rtc_rstn
set_location_assignment PIN_G5 -to rtc_dat
set_location_assignment PIN_G3 -to rtc_clk
set_location_assignment PIN_T2 -to rstn
set_location_assignment PIN_M4 -to sw_1
set_location_assignment PIN_K7 -to sw_2
set_location_assignment PIN_K8 -to sw_3
set_location_assignment PIN_J8 -to sw_4
set_location_assignment PIN_N7 -to btn_lft
set_location_assignment PIN_T1 -to btn_rgt
set_location_assignment PIN_T5 -to led_01
set_location_assignment PIN_R6 -to led_02
set_location_assignment PIN_R5 -to led_03
set_location_assignment PIN_P6 -to led_04
set_location_assignment PIN_V3 -to ext_io[0]
set_location_assignment PIN_V4 -to ext_io[1]
set_location_assignment PIN_AA1 -to ext_io[2]
set_location_assignment PIN_E7 -to ext_io[3]
set_location_assignment PIN_D7 -to ext_io[4]
set_location_assignment PIN_G8 -to ext_io[5]
set_location_assignment PIN_G9 -to ext_io[6]
set_location_assignment PIN_F9 -to ext_io[7]
set_location_assignment PIN_G10 -to ext_io[8]
set_location_assignment PIN_G11 -to ext_io[9]
set_location_assignment PIN_E11 -to ext_io[10]
set_location_assignment PIN_F11 -to ext_io[11]
set_location_assignment PIN_C13 -to ext_io[12]
set_location_assignment PIN_D13 -to ext_io[13]
set_location_assignment PIN_F13 -to ext_io[14]
set_location_assignment PIN_E13 -to ext_io[15]
set_location_assignment PIN_G14 -to ext_io[16]
set_location_assignment PIN_F14 -to ext_io[17]
set_location_assignment PIN_F15 -to ext_io[18]
set_location_assignment PIN_G15 -to ext_io[19]
set_location_assignment PIN_D17 -to ext_io[20]
set_location_assignment PIN_E16 -to ext_io[21]
set_location_assignment PIN_D19 -to ext_io[22]
set_location_assignment PIN_C19 -to ext_io[23]
set_location_assignment PIN_D20 -to ext_io[24]
set_location_assignment PIN_C20 -to ext_io[25]
set_location_assignment PIN_F19 -to ext_io[26]
set_location_assignment PIN_C17 -to ext_io[27]
set_location_assignment PIN_H18 -to ext_io[28]
set_location_assignment PIN_G17 -to ext_io[29]
set_location_assignment PIN_J22 -to ext_io[30]
set_location_assignment PIN_H20 -to ext_io[31]
set_location_assignment PIN_N6 -to btn_ent
set_location_assignment PIN_J17 -to seg7_leda
set_location_assignment PIN_K18 -to seg7_ledf
set_location_assignment PIN_K17 -to seg7_ledb
set_location_assignment PIN_K19 -to seg7_ledg
set_location_assignment PIN_N20 -to seg7_ledc
set_location_assignment PIN_N18 -to seg7_ledh
set_location_assignment PIN_N17 -to seg7_ledd
set_location_assignment PIN_P20 -to seg7_lede
set_location_assignment PIN_P17 -to seg7_sel3
set_location_assignment PIN_T17 -to seg7_sel2
set_location_assignment PIN_R18 -to seg7_sel1
set_location_assignment PIN_R19 -to seg7_sel0
set_location_assignment PIN_AA20 -to lcd_rst
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_rst
set_location_assignment PIN_AB20 -to lcd_dat[7]
set_location_assignment PIN_AA19 -to lcd_dat[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[6]
set_location_assignment PIN_AB19 -to lcd_dat[5]
set_location_assignment PIN_AB18 -to lcd_dat[4]
set_location_assignment PIN_Y17 -to lcd_dat[3]
set_location_assignment PIN_T15 -to lcd_dat[2]
set_location_assignment PIN_T14 -to lcd_dat[1]
set_location_assignment PIN_W15 -to lcd_dat[0]
set_location_assignment PIN_T13 -to lcd_rd
set_location_assignment PIN_V15 -to lcd_wr
set_location_assignment PIN_V14 -to lcd_rs
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_cs
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_dat[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_rd
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_rs
set_instance_assignment -name IO_STANDARD "2.5 V" -to lcd_wr
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[12]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[11]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[10]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[9]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[8]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[7]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[6]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[5]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[4]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[3]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[2]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_addr[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_ba[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_ba[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_casn
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_cke
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_clkn
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_clkp
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_csn
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[15]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[14]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[13]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[12]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[11]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[10]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[9]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[8]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[7]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[6]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[5]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[4]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[3]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[2]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_dq[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_ldm
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_ldqs
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_rasn
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_udm
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_udqs
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS II" -to ddr_wen
set_location_assignment PIN_AA16 -to ddr_addr[4]
set_location_assignment PIN_AA15 -to ddr_addr[5]
set_location_assignment PIN_AB16 -to ddr_addr[6]
set_location_assignment PIN_AB15 -to ddr_addr[7]
set_location_assignment PIN_AA14 -to ddr_addr[8]
set_location_assignment PIN_AB14 -to ddr_addr[9]
set_location_assignment PIN_Y6 -to ddr_addr[10]
set_location_assignment PIN_Y13 -to ddr_addr[11]
set_location_assignment PIN_AB13 -to ddr_addr[12]
set_location_assignment PIN_AA17 -to ddr_clkp
set_location_assignment PIN_AB17 -to ddr_clkn
set_location_assignment PIN_AA7 -to ddr_udm
set_location_assignment PIN_AB9 -to ddr_udqs
set_location_assignment PIN_AB7 -to ddr_dq[8]
set_location_assignment PIN_AB8 -to ddr_dq[9]
set_location_assignment PIN_AA8 -to ddr_dq[10]
set_location_assignment PIN_AA9 -to ddr_dq[11]
set_location_assignment PIN_Y10 -to ddr_dq[12]
set_location_assignment PIN_W10 -to ddr_dq[13]
set_location_assignment PIN_U10 -to ddr_dq[14]
set_location_assignment PIN_V11 -to ddr_dq[15]
set_location_assignment PIN_V8 -to ddr_dq[0]
set_location_assignment PIN_W6 -to ddr_dq[1]
set_location_assignment PIN_U9 -to ddr_dq[2]
set_location_assignment PIN_W7 -to ddr_dq[3]
set_location_assignment PIN_W8 -to ddr_dq[4]
set_location_assignment PIN_AA5 -to ddr_dq[5]
set_location_assignment PIN_AA4 -to ddr_dq[6]
set_location_assignment PIN_V5 -to ddr_dq[7]
set_location_assignment PIN_V10 -to ddr_ldqs
set_location_assignment PIN_Y3 -to ddr_ldm
set_location_assignment PIN_T8 -to ddr_wen
set_location_assignment PIN_U8 -to ddr_casn
set_location_assignment PIN_AA10 -to ddr_rasn
set_location_assignment PIN_AB10 -to ddr_csn
set_location_assignment PIN_Y8 -to ddr_ba[0]
set_location_assignment PIN_Y7 -to ddr_ba[1]
set_location_assignment PIN_V7 -to ddr_addr[0]
set_location_assignment PIN_AB5 -to ddr_addr[1]
set_location_assignment PIN_AA3 -to ddr_addr[2]
set_location_assignment PIN_AB3 -to ddr_addr[3]
set_location_assignment PIN_AA13 -to ddr_cke
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[12]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[11]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[10]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[9]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[8]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[7]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[6]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[5]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[4]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[3]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[2]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[1]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_addr[0]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_ba[1]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_ba[0]
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_casn
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_cke
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_clkn
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_clkp
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_csn
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_ldm
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_ldqs
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_rasn
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_udm
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_udqs
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to ddr_wen
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[8]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[9]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[10]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[11]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[12]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[13]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[14]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[15]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[0]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[1]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[2]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[3]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[4]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[5]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[6]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_dq[7]
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_ldm
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_ldqs
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_udm
set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to ddr_udqs
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[8]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[9]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[10]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[11]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[12]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[13]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[14]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[15]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[0]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[1]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[2]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[3]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[4]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[5]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[6]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_dq[7]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_ldm
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_ldqs
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_udm
set_instance_assignment -name FAST_INPUT_REGISTER ON -to ddr_udqs
set_location_assignment PIN_P7 -to ir_din
set_location_assignment PIN_G1 -to clk_40M
set_location_assignment PIN_D1 -to epcs_asdo
set_location_assignment PIN_K1 -to epcs_data0
set_location_assignment PIN_K2 -to epcs_dclk
set_location_assignment PIN_E2 -to epcs_ncso
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[12]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[11]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[10]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[9]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[8]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[7]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[6]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[5]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[4]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[3]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[2]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[1]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_addr[0]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_ba[1]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_ba[0]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_casn
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_cke
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_clkn
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_clkp
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_csn
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[15]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[14]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[13]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[12]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[11]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[10]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[9]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[8]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[7]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[6]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[5]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[4]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[3]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[2]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[1]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_dq[0]
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_ldm
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_ldqs
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_rasn
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_udm
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_udqs
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 25 OHM" -to ddr_wen
set_location_assignment PIN_R2 -to vga_r[7]
set_location_assignment PIN_R1 -to vga_r[6]
set_location_assignment PIN_U2 -to vga_r[5]
set_location_assignment PIN_U1 -to vga_r[4]
set_location_assignment PIN_V2 -to vga_r[3]
set_location_assignment PIN_V1 -to vga_r[2]
set_location_assignment PIN_W2 -to vga_r[1]
set_location_assignment PIN_W1 -to vga_r[0]
set_location_assignment PIN_P1 -to vga_g[0]
set_location_assignment PIN_P2 -to vga_g[1]
set_location_assignment PIN_N1 -to vga_g[2]
set_location_assignment PIN_N2 -to vga_g[3]
set_location_assignment PIN_M1 -to vga_g[4]
set_location_assignment PIN_M2 -to vga_g[5]
set_location_assignment PIN_J1 -to vga_g[6]
set_location_assignment PIN_J2 -to vga_g[7]
set_location_assignment PIN_H1 -to vga_blk
set_location_assignment PIN_H2 -to vga_syn
set_location_assignment PIN_F1 -to vga_b[0]
set_location_assignment PIN_F2 -to vga_b[1]
set_location_assignment PIN_E1 -to vga_b[2]
set_location_assignment PIN_G4 -to vga_b[3]
set_location_assignment PIN_D2 -to vga_b[4]
set_location_assignment PIN_C1 -to vga_b[5]
set_location_assignment PIN_C2 -to vga_b[6]
set_location_assignment PIN_B1 -to vga_b[7]
set_location_assignment PIN_B2 -to vga_clk
set_location_assignment PIN_B21 -to ext_io[32]
set_location_assignment PIN_J21 -to ext_io[33]
set_location_assignment PIN_M20 -to ext_io[35]
set_location_assignment PIN_H19 -to ext_io[34]
