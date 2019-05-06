// megafunction wizard: %ALTDDIO_BIDIR%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTDDIO_BIDIR 

// ============================================================
// File Name: mybidir.v
// Megafunction Name(s):
// 			ALTDDIO_BIDIR
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 12.0 Build 178 05/31/2012 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2012 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module mybidir (
	datain_h,
	datain_l,
	inclock,
	oe,
	outclock,
	dataout_h,
	dataout_l,
	padio);

	input	[0:0]  datain_h;
	input	[0:0]  datain_l;
	input	  inclock;
	input	  oe;
	input	  outclock;
	output	[0:0]  dataout_h;
	output	[0:0]  dataout_l;
	inout	[0:0]  padio;

	wire [0:0] sub_wire0;
	wire [0:0] sub_wire1;
	wire [0:0] dataout_h = sub_wire0[0:0];
	wire [0:0] dataout_l = sub_wire1[0:0];

	altddio_bidir	ALTDDIO_BIDIR_component (
				.padio (padio),
				.datain_h (datain_h),
				.datain_l (datain_l),
				.oe (oe),
				.outclock (outclock),
				.inclock (inclock),
				.dataout_h (sub_wire0),
				.dataout_l (sub_wire1),
				.aclr (1'b0),
				.aset (1'b0),
				.combout (),
				.dqsundelayedout (),
				.inclocken (1'b1),
				.oe_out (),
				.outclocken (1'b1),
				.sclr (1'b0),
				.sset (1'b0));
	defparam
		ALTDDIO_BIDIR_component.extend_oe_disable = "OFF",
		ALTDDIO_BIDIR_component.implement_input_in_lcell = "OFF",
		ALTDDIO_BIDIR_component.intended_device_family = "Cyclone IV E",
		ALTDDIO_BIDIR_component.invert_output = "OFF",
		ALTDDIO_BIDIR_component.lpm_hint = "UNUSED",
		ALTDDIO_BIDIR_component.lpm_type = "altddio_bidir",
		ALTDDIO_BIDIR_component.oe_reg = "UNREGISTERED",
		ALTDDIO_BIDIR_component.power_up_high = "OFF",
		ALTDDIO_BIDIR_component.width = 1;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: EXTEND_OE_DISABLE STRING "OFF"
// Retrieval info: CONSTANT: IMPLEMENT_INPUT_IN_LCELL STRING "OFF"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: INVERT_OUTPUT STRING "OFF"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altddio_bidir"
// Retrieval info: CONSTANT: OE_REG STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_HIGH STRING "OFF"
// Retrieval info: CONSTANT: WIDTH NUMERIC "1"
// Retrieval info: USED_PORT: datain_h 0 0 1 0 INPUT NODEFVAL "datain_h[0..0]"
// Retrieval info: CONNECT: @datain_h 0 0 1 0 datain_h 0 0 1 0
// Retrieval info: USED_PORT: datain_l 0 0 1 0 INPUT NODEFVAL "datain_l[0..0]"
// Retrieval info: CONNECT: @datain_l 0 0 1 0 datain_l 0 0 1 0
// Retrieval info: USED_PORT: dataout_h 0 0 1 0 OUTPUT NODEFVAL "dataout_h[0..0]"
// Retrieval info: CONNECT: dataout_h 0 0 1 0 @dataout_h 0 0 1 0
// Retrieval info: USED_PORT: dataout_l 0 0 1 0 OUTPUT NODEFVAL "dataout_l[0..0]"
// Retrieval info: CONNECT: dataout_l 0 0 1 0 @dataout_l 0 0 1 0
// Retrieval info: USED_PORT: inclock 0 0 0 0 INPUT_CLK_EXT NODEFVAL "inclock"
// Retrieval info: CONNECT: @inclock 0 0 0 0 inclock 0 0 0 0
// Retrieval info: USED_PORT: oe 0 0 0 0 INPUT NODEFVAL "oe"
// Retrieval info: CONNECT: @oe 0 0 0 0 oe 0 0 0 0
// Retrieval info: USED_PORT: outclock 0 0 0 0 INPUT_CLK_EXT NODEFVAL "outclock"
// Retrieval info: CONNECT: @outclock 0 0 0 0 outclock 0 0 0 0
// Retrieval info: USED_PORT: padio 0 0 1 0 BIDIR NODEFVAL "padio[0..0]"
// Retrieval info: CONNECT: padio 0 0 1 0 @padio 0 0 1 0
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir.inc TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir.cmp TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL mybidir.ppf TRUE FALSE
// Retrieval info: LIB_FILE: altera_mf
