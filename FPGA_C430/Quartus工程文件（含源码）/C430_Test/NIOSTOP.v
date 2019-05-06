//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2013 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module LAN_spi_control_port_arbitrator (
                                         // inputs:
                                          LAN_spi_control_port_dataavailable,
                                          LAN_spi_control_port_endofpacket,
                                          LAN_spi_control_port_irq,
                                          LAN_spi_control_port_readdata,
                                          LAN_spi_control_port_readyfordata,
                                          clk,
                                          cpu_data_master_address_to_slave,
                                          cpu_data_master_read,
                                          cpu_data_master_write,
                                          cpu_data_master_writedata,
                                          reset_n,

                                         // outputs:
                                          LAN_spi_control_port_address,
                                          LAN_spi_control_port_chipselect,
                                          LAN_spi_control_port_dataavailable_from_sa,
                                          LAN_spi_control_port_endofpacket_from_sa,
                                          LAN_spi_control_port_irq_from_sa,
                                          LAN_spi_control_port_read_n,
                                          LAN_spi_control_port_readdata_from_sa,
                                          LAN_spi_control_port_readyfordata_from_sa,
                                          LAN_spi_control_port_reset_n,
                                          LAN_spi_control_port_write_n,
                                          LAN_spi_control_port_writedata,
                                          cpu_data_master_granted_LAN_spi_control_port,
                                          cpu_data_master_qualified_request_LAN_spi_control_port,
                                          cpu_data_master_read_data_valid_LAN_spi_control_port,
                                          cpu_data_master_requests_LAN_spi_control_port,
                                          d1_LAN_spi_control_port_end_xfer
                                       )
;

  output  [  2: 0] LAN_spi_control_port_address;
  output           LAN_spi_control_port_chipselect;
  output           LAN_spi_control_port_dataavailable_from_sa;
  output           LAN_spi_control_port_endofpacket_from_sa;
  output           LAN_spi_control_port_irq_from_sa;
  output           LAN_spi_control_port_read_n;
  output  [ 15: 0] LAN_spi_control_port_readdata_from_sa;
  output           LAN_spi_control_port_readyfordata_from_sa;
  output           LAN_spi_control_port_reset_n;
  output           LAN_spi_control_port_write_n;
  output  [ 15: 0] LAN_spi_control_port_writedata;
  output           cpu_data_master_granted_LAN_spi_control_port;
  output           cpu_data_master_qualified_request_LAN_spi_control_port;
  output           cpu_data_master_read_data_valid_LAN_spi_control_port;
  output           cpu_data_master_requests_LAN_spi_control_port;
  output           d1_LAN_spi_control_port_end_xfer;
  input            LAN_spi_control_port_dataavailable;
  input            LAN_spi_control_port_endofpacket;
  input            LAN_spi_control_port_irq;
  input   [ 15: 0] LAN_spi_control_port_readdata;
  input            LAN_spi_control_port_readyfordata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  2: 0] LAN_spi_control_port_address;
  wire             LAN_spi_control_port_allgrants;
  wire             LAN_spi_control_port_allow_new_arb_cycle;
  wire             LAN_spi_control_port_any_bursting_master_saved_grant;
  wire             LAN_spi_control_port_any_continuerequest;
  wire             LAN_spi_control_port_arb_counter_enable;
  reg     [  1: 0] LAN_spi_control_port_arb_share_counter;
  wire    [  1: 0] LAN_spi_control_port_arb_share_counter_next_value;
  wire    [  1: 0] LAN_spi_control_port_arb_share_set_values;
  wire             LAN_spi_control_port_beginbursttransfer_internal;
  wire             LAN_spi_control_port_begins_xfer;
  wire             LAN_spi_control_port_chipselect;
  wire             LAN_spi_control_port_dataavailable_from_sa;
  wire             LAN_spi_control_port_end_xfer;
  wire             LAN_spi_control_port_endofpacket_from_sa;
  wire             LAN_spi_control_port_firsttransfer;
  wire             LAN_spi_control_port_grant_vector;
  wire             LAN_spi_control_port_in_a_read_cycle;
  wire             LAN_spi_control_port_in_a_write_cycle;
  wire             LAN_spi_control_port_irq_from_sa;
  wire             LAN_spi_control_port_master_qreq_vector;
  wire             LAN_spi_control_port_non_bursting_master_requests;
  wire             LAN_spi_control_port_read_n;
  wire    [ 15: 0] LAN_spi_control_port_readdata_from_sa;
  wire             LAN_spi_control_port_readyfordata_from_sa;
  reg              LAN_spi_control_port_reg_firsttransfer;
  wire             LAN_spi_control_port_reset_n;
  reg              LAN_spi_control_port_slavearbiterlockenable;
  wire             LAN_spi_control_port_slavearbiterlockenable2;
  wire             LAN_spi_control_port_unreg_firsttransfer;
  wire             LAN_spi_control_port_waits_for_read;
  wire             LAN_spi_control_port_waits_for_write;
  wire             LAN_spi_control_port_write_n;
  wire    [ 15: 0] LAN_spi_control_port_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_LAN_spi_control_port;
  wire             cpu_data_master_qualified_request_LAN_spi_control_port;
  wire             cpu_data_master_read_data_valid_LAN_spi_control_port;
  wire             cpu_data_master_requests_LAN_spi_control_port;
  wire             cpu_data_master_saved_grant_LAN_spi_control_port;
  reg              d1_LAN_spi_control_port_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_LAN_spi_control_port;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_LAN_spi_control_port_from_cpu_data_master;
  wire             wait_for_LAN_spi_control_port_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~LAN_spi_control_port_end_xfer;
    end


  assign LAN_spi_control_port_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_LAN_spi_control_port));
  //assign LAN_spi_control_port_readdata_from_sa = LAN_spi_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_spi_control_port_readdata_from_sa = LAN_spi_control_port_readdata;

  assign cpu_data_master_requests_LAN_spi_control_port = ({cpu_data_master_address_to_slave[26 : 5] , 5'b0} == 27'h1800) & (cpu_data_master_read | cpu_data_master_write);
  //assign LAN_spi_control_port_dataavailable_from_sa = LAN_spi_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_spi_control_port_dataavailable_from_sa = LAN_spi_control_port_dataavailable;

  //assign LAN_spi_control_port_readyfordata_from_sa = LAN_spi_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_spi_control_port_readyfordata_from_sa = LAN_spi_control_port_readyfordata;

  //LAN_spi_control_port_arb_share_counter set values, which is an e_mux
  assign LAN_spi_control_port_arb_share_set_values = 1;

  //LAN_spi_control_port_non_bursting_master_requests mux, which is an e_mux
  assign LAN_spi_control_port_non_bursting_master_requests = cpu_data_master_requests_LAN_spi_control_port;

  //LAN_spi_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  assign LAN_spi_control_port_any_bursting_master_saved_grant = 0;

  //LAN_spi_control_port_arb_share_counter_next_value assignment, which is an e_assign
  assign LAN_spi_control_port_arb_share_counter_next_value = LAN_spi_control_port_firsttransfer ? (LAN_spi_control_port_arb_share_set_values - 1) : |LAN_spi_control_port_arb_share_counter ? (LAN_spi_control_port_arb_share_counter - 1) : 0;

  //LAN_spi_control_port_allgrants all slave grants, which is an e_mux
  assign LAN_spi_control_port_allgrants = |LAN_spi_control_port_grant_vector;

  //LAN_spi_control_port_end_xfer assignment, which is an e_assign
  assign LAN_spi_control_port_end_xfer = ~(LAN_spi_control_port_waits_for_read | LAN_spi_control_port_waits_for_write);

  //end_xfer_arb_share_counter_term_LAN_spi_control_port arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_LAN_spi_control_port = LAN_spi_control_port_end_xfer & (~LAN_spi_control_port_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //LAN_spi_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  assign LAN_spi_control_port_arb_counter_enable = (end_xfer_arb_share_counter_term_LAN_spi_control_port & LAN_spi_control_port_allgrants) | (end_xfer_arb_share_counter_term_LAN_spi_control_port & ~LAN_spi_control_port_non_bursting_master_requests);

  //LAN_spi_control_port_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_spi_control_port_arb_share_counter <= 0;
      else if (LAN_spi_control_port_arb_counter_enable)
          LAN_spi_control_port_arb_share_counter <= LAN_spi_control_port_arb_share_counter_next_value;
    end


  //LAN_spi_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_spi_control_port_slavearbiterlockenable <= 0;
      else if ((|LAN_spi_control_port_master_qreq_vector & end_xfer_arb_share_counter_term_LAN_spi_control_port) | (end_xfer_arb_share_counter_term_LAN_spi_control_port & ~LAN_spi_control_port_non_bursting_master_requests))
          LAN_spi_control_port_slavearbiterlockenable <= |LAN_spi_control_port_arb_share_counter_next_value;
    end


  //cpu/data_master LAN/spi_control_port arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = LAN_spi_control_port_slavearbiterlockenable & cpu_data_master_continuerequest;

  //LAN_spi_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign LAN_spi_control_port_slavearbiterlockenable2 = |LAN_spi_control_port_arb_share_counter_next_value;

  //cpu/data_master LAN/spi_control_port arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = LAN_spi_control_port_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //LAN_spi_control_port_any_continuerequest at least one master continues requesting, which is an e_assign
  assign LAN_spi_control_port_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_LAN_spi_control_port = cpu_data_master_requests_LAN_spi_control_port;
  //LAN_spi_control_port_writedata mux, which is an e_mux
  assign LAN_spi_control_port_writedata = cpu_data_master_writedata;

  //assign LAN_spi_control_port_endofpacket_from_sa = LAN_spi_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_spi_control_port_endofpacket_from_sa = LAN_spi_control_port_endofpacket;

  //master is always granted when requested
  assign cpu_data_master_granted_LAN_spi_control_port = cpu_data_master_qualified_request_LAN_spi_control_port;

  //cpu/data_master saved-grant LAN/spi_control_port, which is an e_assign
  assign cpu_data_master_saved_grant_LAN_spi_control_port = cpu_data_master_requests_LAN_spi_control_port;

  //allow new arb cycle for LAN/spi_control_port, which is an e_assign
  assign LAN_spi_control_port_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign LAN_spi_control_port_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign LAN_spi_control_port_master_qreq_vector = 1;

  //LAN_spi_control_port_reset_n assignment, which is an e_assign
  assign LAN_spi_control_port_reset_n = reset_n;

  assign LAN_spi_control_port_chipselect = cpu_data_master_granted_LAN_spi_control_port;
  //LAN_spi_control_port_firsttransfer first transaction, which is an e_assign
  assign LAN_spi_control_port_firsttransfer = LAN_spi_control_port_begins_xfer ? LAN_spi_control_port_unreg_firsttransfer : LAN_spi_control_port_reg_firsttransfer;

  //LAN_spi_control_port_unreg_firsttransfer first transaction, which is an e_assign
  assign LAN_spi_control_port_unreg_firsttransfer = ~(LAN_spi_control_port_slavearbiterlockenable & LAN_spi_control_port_any_continuerequest);

  //LAN_spi_control_port_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_spi_control_port_reg_firsttransfer <= 1'b1;
      else if (LAN_spi_control_port_begins_xfer)
          LAN_spi_control_port_reg_firsttransfer <= LAN_spi_control_port_unreg_firsttransfer;
    end


  //LAN_spi_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign LAN_spi_control_port_beginbursttransfer_internal = LAN_spi_control_port_begins_xfer;

  //~LAN_spi_control_port_read_n assignment, which is an e_mux
  assign LAN_spi_control_port_read_n = ~(cpu_data_master_granted_LAN_spi_control_port & cpu_data_master_read);

  //~LAN_spi_control_port_write_n assignment, which is an e_mux
  assign LAN_spi_control_port_write_n = ~(cpu_data_master_granted_LAN_spi_control_port & cpu_data_master_write);

  assign shifted_address_to_LAN_spi_control_port_from_cpu_data_master = cpu_data_master_address_to_slave;
  //LAN_spi_control_port_address mux, which is an e_mux
  assign LAN_spi_control_port_address = shifted_address_to_LAN_spi_control_port_from_cpu_data_master >> 2;

  //d1_LAN_spi_control_port_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_LAN_spi_control_port_end_xfer <= 1;
      else 
        d1_LAN_spi_control_port_end_xfer <= LAN_spi_control_port_end_xfer;
    end


  //LAN_spi_control_port_waits_for_read in a cycle, which is an e_mux
  assign LAN_spi_control_port_waits_for_read = LAN_spi_control_port_in_a_read_cycle & LAN_spi_control_port_begins_xfer;

  //LAN_spi_control_port_in_a_read_cycle assignment, which is an e_assign
  assign LAN_spi_control_port_in_a_read_cycle = cpu_data_master_granted_LAN_spi_control_port & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = LAN_spi_control_port_in_a_read_cycle;

  //LAN_spi_control_port_waits_for_write in a cycle, which is an e_mux
  assign LAN_spi_control_port_waits_for_write = LAN_spi_control_port_in_a_write_cycle & LAN_spi_control_port_begins_xfer;

  //LAN_spi_control_port_in_a_write_cycle assignment, which is an e_assign
  assign LAN_spi_control_port_in_a_write_cycle = cpu_data_master_granted_LAN_spi_control_port & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = LAN_spi_control_port_in_a_write_cycle;

  assign wait_for_LAN_spi_control_port_counter = 0;
  //assign LAN_spi_control_port_irq_from_sa = LAN_spi_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_spi_control_port_irq_from_sa = LAN_spi_control_port_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //LAN/spi_control_port enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module LAN_CS_s1_arbitrator (
                              // inputs:
                               LAN_CS_s1_readdata,
                               clk,
                               cpu_data_master_address_to_slave,
                               cpu_data_master_read,
                               cpu_data_master_waitrequest,
                               cpu_data_master_write,
                               cpu_data_master_writedata,
                               reset_n,

                              // outputs:
                               LAN_CS_s1_address,
                               LAN_CS_s1_chipselect,
                               LAN_CS_s1_readdata_from_sa,
                               LAN_CS_s1_reset_n,
                               LAN_CS_s1_write_n,
                               LAN_CS_s1_writedata,
                               cpu_data_master_granted_LAN_CS_s1,
                               cpu_data_master_qualified_request_LAN_CS_s1,
                               cpu_data_master_read_data_valid_LAN_CS_s1,
                               cpu_data_master_requests_LAN_CS_s1,
                               d1_LAN_CS_s1_end_xfer
                            )
;

  output  [  1: 0] LAN_CS_s1_address;
  output           LAN_CS_s1_chipselect;
  output  [ 31: 0] LAN_CS_s1_readdata_from_sa;
  output           LAN_CS_s1_reset_n;
  output           LAN_CS_s1_write_n;
  output  [ 31: 0] LAN_CS_s1_writedata;
  output           cpu_data_master_granted_LAN_CS_s1;
  output           cpu_data_master_qualified_request_LAN_CS_s1;
  output           cpu_data_master_read_data_valid_LAN_CS_s1;
  output           cpu_data_master_requests_LAN_CS_s1;
  output           d1_LAN_CS_s1_end_xfer;
  input   [ 31: 0] LAN_CS_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] LAN_CS_s1_address;
  wire             LAN_CS_s1_allgrants;
  wire             LAN_CS_s1_allow_new_arb_cycle;
  wire             LAN_CS_s1_any_bursting_master_saved_grant;
  wire             LAN_CS_s1_any_continuerequest;
  wire             LAN_CS_s1_arb_counter_enable;
  reg     [  1: 0] LAN_CS_s1_arb_share_counter;
  wire    [  1: 0] LAN_CS_s1_arb_share_counter_next_value;
  wire    [  1: 0] LAN_CS_s1_arb_share_set_values;
  wire             LAN_CS_s1_beginbursttransfer_internal;
  wire             LAN_CS_s1_begins_xfer;
  wire             LAN_CS_s1_chipselect;
  wire             LAN_CS_s1_end_xfer;
  wire             LAN_CS_s1_firsttransfer;
  wire             LAN_CS_s1_grant_vector;
  wire             LAN_CS_s1_in_a_read_cycle;
  wire             LAN_CS_s1_in_a_write_cycle;
  wire             LAN_CS_s1_master_qreq_vector;
  wire             LAN_CS_s1_non_bursting_master_requests;
  wire    [ 31: 0] LAN_CS_s1_readdata_from_sa;
  reg              LAN_CS_s1_reg_firsttransfer;
  wire             LAN_CS_s1_reset_n;
  reg              LAN_CS_s1_slavearbiterlockenable;
  wire             LAN_CS_s1_slavearbiterlockenable2;
  wire             LAN_CS_s1_unreg_firsttransfer;
  wire             LAN_CS_s1_waits_for_read;
  wire             LAN_CS_s1_waits_for_write;
  wire             LAN_CS_s1_write_n;
  wire    [ 31: 0] LAN_CS_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_LAN_CS_s1;
  wire             cpu_data_master_qualified_request_LAN_CS_s1;
  wire             cpu_data_master_read_data_valid_LAN_CS_s1;
  wire             cpu_data_master_requests_LAN_CS_s1;
  wire             cpu_data_master_saved_grant_LAN_CS_s1;
  reg              d1_LAN_CS_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_LAN_CS_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_LAN_CS_s1_from_cpu_data_master;
  wire             wait_for_LAN_CS_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~LAN_CS_s1_end_xfer;
    end


  assign LAN_CS_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_LAN_CS_s1));
  //assign LAN_CS_s1_readdata_from_sa = LAN_CS_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_CS_s1_readdata_from_sa = LAN_CS_s1_readdata;

  assign cpu_data_master_requests_LAN_CS_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1830) & (cpu_data_master_read | cpu_data_master_write);
  //LAN_CS_s1_arb_share_counter set values, which is an e_mux
  assign LAN_CS_s1_arb_share_set_values = 1;

  //LAN_CS_s1_non_bursting_master_requests mux, which is an e_mux
  assign LAN_CS_s1_non_bursting_master_requests = cpu_data_master_requests_LAN_CS_s1;

  //LAN_CS_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign LAN_CS_s1_any_bursting_master_saved_grant = 0;

  //LAN_CS_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign LAN_CS_s1_arb_share_counter_next_value = LAN_CS_s1_firsttransfer ? (LAN_CS_s1_arb_share_set_values - 1) : |LAN_CS_s1_arb_share_counter ? (LAN_CS_s1_arb_share_counter - 1) : 0;

  //LAN_CS_s1_allgrants all slave grants, which is an e_mux
  assign LAN_CS_s1_allgrants = |LAN_CS_s1_grant_vector;

  //LAN_CS_s1_end_xfer assignment, which is an e_assign
  assign LAN_CS_s1_end_xfer = ~(LAN_CS_s1_waits_for_read | LAN_CS_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_LAN_CS_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_LAN_CS_s1 = LAN_CS_s1_end_xfer & (~LAN_CS_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //LAN_CS_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign LAN_CS_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_LAN_CS_s1 & LAN_CS_s1_allgrants) | (end_xfer_arb_share_counter_term_LAN_CS_s1 & ~LAN_CS_s1_non_bursting_master_requests);

  //LAN_CS_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_CS_s1_arb_share_counter <= 0;
      else if (LAN_CS_s1_arb_counter_enable)
          LAN_CS_s1_arb_share_counter <= LAN_CS_s1_arb_share_counter_next_value;
    end


  //LAN_CS_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_CS_s1_slavearbiterlockenable <= 0;
      else if ((|LAN_CS_s1_master_qreq_vector & end_xfer_arb_share_counter_term_LAN_CS_s1) | (end_xfer_arb_share_counter_term_LAN_CS_s1 & ~LAN_CS_s1_non_bursting_master_requests))
          LAN_CS_s1_slavearbiterlockenable <= |LAN_CS_s1_arb_share_counter_next_value;
    end


  //cpu/data_master LAN_CS/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = LAN_CS_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //LAN_CS_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign LAN_CS_s1_slavearbiterlockenable2 = |LAN_CS_s1_arb_share_counter_next_value;

  //cpu/data_master LAN_CS/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = LAN_CS_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //LAN_CS_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign LAN_CS_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_LAN_CS_s1 = cpu_data_master_requests_LAN_CS_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //LAN_CS_s1_writedata mux, which is an e_mux
  assign LAN_CS_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_LAN_CS_s1 = cpu_data_master_qualified_request_LAN_CS_s1;

  //cpu/data_master saved-grant LAN_CS/s1, which is an e_assign
  assign cpu_data_master_saved_grant_LAN_CS_s1 = cpu_data_master_requests_LAN_CS_s1;

  //allow new arb cycle for LAN_CS/s1, which is an e_assign
  assign LAN_CS_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign LAN_CS_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign LAN_CS_s1_master_qreq_vector = 1;

  //LAN_CS_s1_reset_n assignment, which is an e_assign
  assign LAN_CS_s1_reset_n = reset_n;

  assign LAN_CS_s1_chipselect = cpu_data_master_granted_LAN_CS_s1;
  //LAN_CS_s1_firsttransfer first transaction, which is an e_assign
  assign LAN_CS_s1_firsttransfer = LAN_CS_s1_begins_xfer ? LAN_CS_s1_unreg_firsttransfer : LAN_CS_s1_reg_firsttransfer;

  //LAN_CS_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign LAN_CS_s1_unreg_firsttransfer = ~(LAN_CS_s1_slavearbiterlockenable & LAN_CS_s1_any_continuerequest);

  //LAN_CS_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_CS_s1_reg_firsttransfer <= 1'b1;
      else if (LAN_CS_s1_begins_xfer)
          LAN_CS_s1_reg_firsttransfer <= LAN_CS_s1_unreg_firsttransfer;
    end


  //LAN_CS_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign LAN_CS_s1_beginbursttransfer_internal = LAN_CS_s1_begins_xfer;

  //~LAN_CS_s1_write_n assignment, which is an e_mux
  assign LAN_CS_s1_write_n = ~(cpu_data_master_granted_LAN_CS_s1 & cpu_data_master_write);

  assign shifted_address_to_LAN_CS_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //LAN_CS_s1_address mux, which is an e_mux
  assign LAN_CS_s1_address = shifted_address_to_LAN_CS_s1_from_cpu_data_master >> 2;

  //d1_LAN_CS_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_LAN_CS_s1_end_xfer <= 1;
      else 
        d1_LAN_CS_s1_end_xfer <= LAN_CS_s1_end_xfer;
    end


  //LAN_CS_s1_waits_for_read in a cycle, which is an e_mux
  assign LAN_CS_s1_waits_for_read = LAN_CS_s1_in_a_read_cycle & LAN_CS_s1_begins_xfer;

  //LAN_CS_s1_in_a_read_cycle assignment, which is an e_assign
  assign LAN_CS_s1_in_a_read_cycle = cpu_data_master_granted_LAN_CS_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = LAN_CS_s1_in_a_read_cycle;

  //LAN_CS_s1_waits_for_write in a cycle, which is an e_mux
  assign LAN_CS_s1_waits_for_write = LAN_CS_s1_in_a_write_cycle & 0;

  //LAN_CS_s1_in_a_write_cycle assignment, which is an e_assign
  assign LAN_CS_s1_in_a_write_cycle = cpu_data_master_granted_LAN_CS_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = LAN_CS_s1_in_a_write_cycle;

  assign wait_for_LAN_CS_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //LAN_CS/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module LAN_RSTN_s1_arbitrator (
                                // inputs:
                                 LAN_RSTN_s1_readdata,
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_read,
                                 cpu_data_master_waitrequest,
                                 cpu_data_master_write,
                                 cpu_data_master_writedata,
                                 reset_n,

                                // outputs:
                                 LAN_RSTN_s1_address,
                                 LAN_RSTN_s1_chipselect,
                                 LAN_RSTN_s1_readdata_from_sa,
                                 LAN_RSTN_s1_reset_n,
                                 LAN_RSTN_s1_write_n,
                                 LAN_RSTN_s1_writedata,
                                 cpu_data_master_granted_LAN_RSTN_s1,
                                 cpu_data_master_qualified_request_LAN_RSTN_s1,
                                 cpu_data_master_read_data_valid_LAN_RSTN_s1,
                                 cpu_data_master_requests_LAN_RSTN_s1,
                                 d1_LAN_RSTN_s1_end_xfer
                              )
;

  output  [  1: 0] LAN_RSTN_s1_address;
  output           LAN_RSTN_s1_chipselect;
  output  [ 31: 0] LAN_RSTN_s1_readdata_from_sa;
  output           LAN_RSTN_s1_reset_n;
  output           LAN_RSTN_s1_write_n;
  output  [ 31: 0] LAN_RSTN_s1_writedata;
  output           cpu_data_master_granted_LAN_RSTN_s1;
  output           cpu_data_master_qualified_request_LAN_RSTN_s1;
  output           cpu_data_master_read_data_valid_LAN_RSTN_s1;
  output           cpu_data_master_requests_LAN_RSTN_s1;
  output           d1_LAN_RSTN_s1_end_xfer;
  input   [ 31: 0] LAN_RSTN_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] LAN_RSTN_s1_address;
  wire             LAN_RSTN_s1_allgrants;
  wire             LAN_RSTN_s1_allow_new_arb_cycle;
  wire             LAN_RSTN_s1_any_bursting_master_saved_grant;
  wire             LAN_RSTN_s1_any_continuerequest;
  wire             LAN_RSTN_s1_arb_counter_enable;
  reg     [  1: 0] LAN_RSTN_s1_arb_share_counter;
  wire    [  1: 0] LAN_RSTN_s1_arb_share_counter_next_value;
  wire    [  1: 0] LAN_RSTN_s1_arb_share_set_values;
  wire             LAN_RSTN_s1_beginbursttransfer_internal;
  wire             LAN_RSTN_s1_begins_xfer;
  wire             LAN_RSTN_s1_chipselect;
  wire             LAN_RSTN_s1_end_xfer;
  wire             LAN_RSTN_s1_firsttransfer;
  wire             LAN_RSTN_s1_grant_vector;
  wire             LAN_RSTN_s1_in_a_read_cycle;
  wire             LAN_RSTN_s1_in_a_write_cycle;
  wire             LAN_RSTN_s1_master_qreq_vector;
  wire             LAN_RSTN_s1_non_bursting_master_requests;
  wire    [ 31: 0] LAN_RSTN_s1_readdata_from_sa;
  reg              LAN_RSTN_s1_reg_firsttransfer;
  wire             LAN_RSTN_s1_reset_n;
  reg              LAN_RSTN_s1_slavearbiterlockenable;
  wire             LAN_RSTN_s1_slavearbiterlockenable2;
  wire             LAN_RSTN_s1_unreg_firsttransfer;
  wire             LAN_RSTN_s1_waits_for_read;
  wire             LAN_RSTN_s1_waits_for_write;
  wire             LAN_RSTN_s1_write_n;
  wire    [ 31: 0] LAN_RSTN_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_LAN_RSTN_s1;
  wire             cpu_data_master_qualified_request_LAN_RSTN_s1;
  wire             cpu_data_master_read_data_valid_LAN_RSTN_s1;
  wire             cpu_data_master_requests_LAN_RSTN_s1;
  wire             cpu_data_master_saved_grant_LAN_RSTN_s1;
  reg              d1_LAN_RSTN_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_LAN_RSTN_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_LAN_RSTN_s1_from_cpu_data_master;
  wire             wait_for_LAN_RSTN_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~LAN_RSTN_s1_end_xfer;
    end


  assign LAN_RSTN_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_LAN_RSTN_s1));
  //assign LAN_RSTN_s1_readdata_from_sa = LAN_RSTN_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_RSTN_s1_readdata_from_sa = LAN_RSTN_s1_readdata;

  assign cpu_data_master_requests_LAN_RSTN_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1850) & (cpu_data_master_read | cpu_data_master_write);
  //LAN_RSTN_s1_arb_share_counter set values, which is an e_mux
  assign LAN_RSTN_s1_arb_share_set_values = 1;

  //LAN_RSTN_s1_non_bursting_master_requests mux, which is an e_mux
  assign LAN_RSTN_s1_non_bursting_master_requests = cpu_data_master_requests_LAN_RSTN_s1;

  //LAN_RSTN_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign LAN_RSTN_s1_any_bursting_master_saved_grant = 0;

  //LAN_RSTN_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign LAN_RSTN_s1_arb_share_counter_next_value = LAN_RSTN_s1_firsttransfer ? (LAN_RSTN_s1_arb_share_set_values - 1) : |LAN_RSTN_s1_arb_share_counter ? (LAN_RSTN_s1_arb_share_counter - 1) : 0;

  //LAN_RSTN_s1_allgrants all slave grants, which is an e_mux
  assign LAN_RSTN_s1_allgrants = |LAN_RSTN_s1_grant_vector;

  //LAN_RSTN_s1_end_xfer assignment, which is an e_assign
  assign LAN_RSTN_s1_end_xfer = ~(LAN_RSTN_s1_waits_for_read | LAN_RSTN_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_LAN_RSTN_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_LAN_RSTN_s1 = LAN_RSTN_s1_end_xfer & (~LAN_RSTN_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //LAN_RSTN_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign LAN_RSTN_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_LAN_RSTN_s1 & LAN_RSTN_s1_allgrants) | (end_xfer_arb_share_counter_term_LAN_RSTN_s1 & ~LAN_RSTN_s1_non_bursting_master_requests);

  //LAN_RSTN_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_RSTN_s1_arb_share_counter <= 0;
      else if (LAN_RSTN_s1_arb_counter_enable)
          LAN_RSTN_s1_arb_share_counter <= LAN_RSTN_s1_arb_share_counter_next_value;
    end


  //LAN_RSTN_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_RSTN_s1_slavearbiterlockenable <= 0;
      else if ((|LAN_RSTN_s1_master_qreq_vector & end_xfer_arb_share_counter_term_LAN_RSTN_s1) | (end_xfer_arb_share_counter_term_LAN_RSTN_s1 & ~LAN_RSTN_s1_non_bursting_master_requests))
          LAN_RSTN_s1_slavearbiterlockenable <= |LAN_RSTN_s1_arb_share_counter_next_value;
    end


  //cpu/data_master LAN_RSTN/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = LAN_RSTN_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //LAN_RSTN_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign LAN_RSTN_s1_slavearbiterlockenable2 = |LAN_RSTN_s1_arb_share_counter_next_value;

  //cpu/data_master LAN_RSTN/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = LAN_RSTN_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //LAN_RSTN_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign LAN_RSTN_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_LAN_RSTN_s1 = cpu_data_master_requests_LAN_RSTN_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //LAN_RSTN_s1_writedata mux, which is an e_mux
  assign LAN_RSTN_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_LAN_RSTN_s1 = cpu_data_master_qualified_request_LAN_RSTN_s1;

  //cpu/data_master saved-grant LAN_RSTN/s1, which is an e_assign
  assign cpu_data_master_saved_grant_LAN_RSTN_s1 = cpu_data_master_requests_LAN_RSTN_s1;

  //allow new arb cycle for LAN_RSTN/s1, which is an e_assign
  assign LAN_RSTN_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign LAN_RSTN_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign LAN_RSTN_s1_master_qreq_vector = 1;

  //LAN_RSTN_s1_reset_n assignment, which is an e_assign
  assign LAN_RSTN_s1_reset_n = reset_n;

  assign LAN_RSTN_s1_chipselect = cpu_data_master_granted_LAN_RSTN_s1;
  //LAN_RSTN_s1_firsttransfer first transaction, which is an e_assign
  assign LAN_RSTN_s1_firsttransfer = LAN_RSTN_s1_begins_xfer ? LAN_RSTN_s1_unreg_firsttransfer : LAN_RSTN_s1_reg_firsttransfer;

  //LAN_RSTN_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign LAN_RSTN_s1_unreg_firsttransfer = ~(LAN_RSTN_s1_slavearbiterlockenable & LAN_RSTN_s1_any_continuerequest);

  //LAN_RSTN_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_RSTN_s1_reg_firsttransfer <= 1'b1;
      else if (LAN_RSTN_s1_begins_xfer)
          LAN_RSTN_s1_reg_firsttransfer <= LAN_RSTN_s1_unreg_firsttransfer;
    end


  //LAN_RSTN_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign LAN_RSTN_s1_beginbursttransfer_internal = LAN_RSTN_s1_begins_xfer;

  //~LAN_RSTN_s1_write_n assignment, which is an e_mux
  assign LAN_RSTN_s1_write_n = ~(cpu_data_master_granted_LAN_RSTN_s1 & cpu_data_master_write);

  assign shifted_address_to_LAN_RSTN_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //LAN_RSTN_s1_address mux, which is an e_mux
  assign LAN_RSTN_s1_address = shifted_address_to_LAN_RSTN_s1_from_cpu_data_master >> 2;

  //d1_LAN_RSTN_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_LAN_RSTN_s1_end_xfer <= 1;
      else 
        d1_LAN_RSTN_s1_end_xfer <= LAN_RSTN_s1_end_xfer;
    end


  //LAN_RSTN_s1_waits_for_read in a cycle, which is an e_mux
  assign LAN_RSTN_s1_waits_for_read = LAN_RSTN_s1_in_a_read_cycle & LAN_RSTN_s1_begins_xfer;

  //LAN_RSTN_s1_in_a_read_cycle assignment, which is an e_assign
  assign LAN_RSTN_s1_in_a_read_cycle = cpu_data_master_granted_LAN_RSTN_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = LAN_RSTN_s1_in_a_read_cycle;

  //LAN_RSTN_s1_waits_for_write in a cycle, which is an e_mux
  assign LAN_RSTN_s1_waits_for_write = LAN_RSTN_s1_in_a_write_cycle & 0;

  //LAN_RSTN_s1_in_a_write_cycle assignment, which is an e_assign
  assign LAN_RSTN_s1_in_a_write_cycle = cpu_data_master_granted_LAN_RSTN_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = LAN_RSTN_s1_in_a_write_cycle;

  assign wait_for_LAN_RSTN_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //LAN_RSTN/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module LAN_nINT_s1_arbitrator (
                                // inputs:
                                 LAN_nINT_s1_readdata,
                                 clk,
                                 cpu_data_master_address_to_slave,
                                 cpu_data_master_read,
                                 cpu_data_master_waitrequest,
                                 cpu_data_master_write,
                                 cpu_data_master_writedata,
                                 reset_n,

                                // outputs:
                                 LAN_nINT_s1_address,
                                 LAN_nINT_s1_chipselect,
                                 LAN_nINT_s1_readdata_from_sa,
                                 LAN_nINT_s1_reset_n,
                                 LAN_nINT_s1_write_n,
                                 LAN_nINT_s1_writedata,
                                 cpu_data_master_granted_LAN_nINT_s1,
                                 cpu_data_master_qualified_request_LAN_nINT_s1,
                                 cpu_data_master_read_data_valid_LAN_nINT_s1,
                                 cpu_data_master_requests_LAN_nINT_s1,
                                 d1_LAN_nINT_s1_end_xfer
                              )
;

  output  [  1: 0] LAN_nINT_s1_address;
  output           LAN_nINT_s1_chipselect;
  output  [ 31: 0] LAN_nINT_s1_readdata_from_sa;
  output           LAN_nINT_s1_reset_n;
  output           LAN_nINT_s1_write_n;
  output  [ 31: 0] LAN_nINT_s1_writedata;
  output           cpu_data_master_granted_LAN_nINT_s1;
  output           cpu_data_master_qualified_request_LAN_nINT_s1;
  output           cpu_data_master_read_data_valid_LAN_nINT_s1;
  output           cpu_data_master_requests_LAN_nINT_s1;
  output           d1_LAN_nINT_s1_end_xfer;
  input   [ 31: 0] LAN_nINT_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] LAN_nINT_s1_address;
  wire             LAN_nINT_s1_allgrants;
  wire             LAN_nINT_s1_allow_new_arb_cycle;
  wire             LAN_nINT_s1_any_bursting_master_saved_grant;
  wire             LAN_nINT_s1_any_continuerequest;
  wire             LAN_nINT_s1_arb_counter_enable;
  reg     [  1: 0] LAN_nINT_s1_arb_share_counter;
  wire    [  1: 0] LAN_nINT_s1_arb_share_counter_next_value;
  wire    [  1: 0] LAN_nINT_s1_arb_share_set_values;
  wire             LAN_nINT_s1_beginbursttransfer_internal;
  wire             LAN_nINT_s1_begins_xfer;
  wire             LAN_nINT_s1_chipselect;
  wire             LAN_nINT_s1_end_xfer;
  wire             LAN_nINT_s1_firsttransfer;
  wire             LAN_nINT_s1_grant_vector;
  wire             LAN_nINT_s1_in_a_read_cycle;
  wire             LAN_nINT_s1_in_a_write_cycle;
  wire             LAN_nINT_s1_master_qreq_vector;
  wire             LAN_nINT_s1_non_bursting_master_requests;
  wire    [ 31: 0] LAN_nINT_s1_readdata_from_sa;
  reg              LAN_nINT_s1_reg_firsttransfer;
  wire             LAN_nINT_s1_reset_n;
  reg              LAN_nINT_s1_slavearbiterlockenable;
  wire             LAN_nINT_s1_slavearbiterlockenable2;
  wire             LAN_nINT_s1_unreg_firsttransfer;
  wire             LAN_nINT_s1_waits_for_read;
  wire             LAN_nINT_s1_waits_for_write;
  wire             LAN_nINT_s1_write_n;
  wire    [ 31: 0] LAN_nINT_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_LAN_nINT_s1;
  wire             cpu_data_master_qualified_request_LAN_nINT_s1;
  wire             cpu_data_master_read_data_valid_LAN_nINT_s1;
  wire             cpu_data_master_requests_LAN_nINT_s1;
  wire             cpu_data_master_saved_grant_LAN_nINT_s1;
  reg              d1_LAN_nINT_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_LAN_nINT_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_LAN_nINT_s1_from_cpu_data_master;
  wire             wait_for_LAN_nINT_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~LAN_nINT_s1_end_xfer;
    end


  assign LAN_nINT_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_LAN_nINT_s1));
  //assign LAN_nINT_s1_readdata_from_sa = LAN_nINT_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign LAN_nINT_s1_readdata_from_sa = LAN_nINT_s1_readdata;

  assign cpu_data_master_requests_LAN_nINT_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1840) & (cpu_data_master_read | cpu_data_master_write);
  //LAN_nINT_s1_arb_share_counter set values, which is an e_mux
  assign LAN_nINT_s1_arb_share_set_values = 1;

  //LAN_nINT_s1_non_bursting_master_requests mux, which is an e_mux
  assign LAN_nINT_s1_non_bursting_master_requests = cpu_data_master_requests_LAN_nINT_s1;

  //LAN_nINT_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign LAN_nINT_s1_any_bursting_master_saved_grant = 0;

  //LAN_nINT_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign LAN_nINT_s1_arb_share_counter_next_value = LAN_nINT_s1_firsttransfer ? (LAN_nINT_s1_arb_share_set_values - 1) : |LAN_nINT_s1_arb_share_counter ? (LAN_nINT_s1_arb_share_counter - 1) : 0;

  //LAN_nINT_s1_allgrants all slave grants, which is an e_mux
  assign LAN_nINT_s1_allgrants = |LAN_nINT_s1_grant_vector;

  //LAN_nINT_s1_end_xfer assignment, which is an e_assign
  assign LAN_nINT_s1_end_xfer = ~(LAN_nINT_s1_waits_for_read | LAN_nINT_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_LAN_nINT_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_LAN_nINT_s1 = LAN_nINT_s1_end_xfer & (~LAN_nINT_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //LAN_nINT_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign LAN_nINT_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_LAN_nINT_s1 & LAN_nINT_s1_allgrants) | (end_xfer_arb_share_counter_term_LAN_nINT_s1 & ~LAN_nINT_s1_non_bursting_master_requests);

  //LAN_nINT_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_nINT_s1_arb_share_counter <= 0;
      else if (LAN_nINT_s1_arb_counter_enable)
          LAN_nINT_s1_arb_share_counter <= LAN_nINT_s1_arb_share_counter_next_value;
    end


  //LAN_nINT_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_nINT_s1_slavearbiterlockenable <= 0;
      else if ((|LAN_nINT_s1_master_qreq_vector & end_xfer_arb_share_counter_term_LAN_nINT_s1) | (end_xfer_arb_share_counter_term_LAN_nINT_s1 & ~LAN_nINT_s1_non_bursting_master_requests))
          LAN_nINT_s1_slavearbiterlockenable <= |LAN_nINT_s1_arb_share_counter_next_value;
    end


  //cpu/data_master LAN_nINT/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = LAN_nINT_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //LAN_nINT_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign LAN_nINT_s1_slavearbiterlockenable2 = |LAN_nINT_s1_arb_share_counter_next_value;

  //cpu/data_master LAN_nINT/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = LAN_nINT_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //LAN_nINT_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign LAN_nINT_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_LAN_nINT_s1 = cpu_data_master_requests_LAN_nINT_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //LAN_nINT_s1_writedata mux, which is an e_mux
  assign LAN_nINT_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_LAN_nINT_s1 = cpu_data_master_qualified_request_LAN_nINT_s1;

  //cpu/data_master saved-grant LAN_nINT/s1, which is an e_assign
  assign cpu_data_master_saved_grant_LAN_nINT_s1 = cpu_data_master_requests_LAN_nINT_s1;

  //allow new arb cycle for LAN_nINT/s1, which is an e_assign
  assign LAN_nINT_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign LAN_nINT_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign LAN_nINT_s1_master_qreq_vector = 1;

  //LAN_nINT_s1_reset_n assignment, which is an e_assign
  assign LAN_nINT_s1_reset_n = reset_n;

  assign LAN_nINT_s1_chipselect = cpu_data_master_granted_LAN_nINT_s1;
  //LAN_nINT_s1_firsttransfer first transaction, which is an e_assign
  assign LAN_nINT_s1_firsttransfer = LAN_nINT_s1_begins_xfer ? LAN_nINT_s1_unreg_firsttransfer : LAN_nINT_s1_reg_firsttransfer;

  //LAN_nINT_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign LAN_nINT_s1_unreg_firsttransfer = ~(LAN_nINT_s1_slavearbiterlockenable & LAN_nINT_s1_any_continuerequest);

  //LAN_nINT_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          LAN_nINT_s1_reg_firsttransfer <= 1'b1;
      else if (LAN_nINT_s1_begins_xfer)
          LAN_nINT_s1_reg_firsttransfer <= LAN_nINT_s1_unreg_firsttransfer;
    end


  //LAN_nINT_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign LAN_nINT_s1_beginbursttransfer_internal = LAN_nINT_s1_begins_xfer;

  //~LAN_nINT_s1_write_n assignment, which is an e_mux
  assign LAN_nINT_s1_write_n = ~(cpu_data_master_granted_LAN_nINT_s1 & cpu_data_master_write);

  assign shifted_address_to_LAN_nINT_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //LAN_nINT_s1_address mux, which is an e_mux
  assign LAN_nINT_s1_address = shifted_address_to_LAN_nINT_s1_from_cpu_data_master >> 2;

  //d1_LAN_nINT_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_LAN_nINT_s1_end_xfer <= 1;
      else 
        d1_LAN_nINT_s1_end_xfer <= LAN_nINT_s1_end_xfer;
    end


  //LAN_nINT_s1_waits_for_read in a cycle, which is an e_mux
  assign LAN_nINT_s1_waits_for_read = LAN_nINT_s1_in_a_read_cycle & LAN_nINT_s1_begins_xfer;

  //LAN_nINT_s1_in_a_read_cycle assignment, which is an e_assign
  assign LAN_nINT_s1_in_a_read_cycle = cpu_data_master_granted_LAN_nINT_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = LAN_nINT_s1_in_a_read_cycle;

  //LAN_nINT_s1_waits_for_write in a cycle, which is an e_mux
  assign LAN_nINT_s1_waits_for_write = LAN_nINT_s1_in_a_write_cycle & 0;

  //LAN_nINT_s1_in_a_write_cycle assignment, which is an e_assign
  assign LAN_nINT_s1_in_a_write_cycle = cpu_data_master_granted_LAN_nINT_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = LAN_nINT_s1_in_a_write_cycle;

  assign wait_for_LAN_nINT_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //LAN_nINT/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module NET_EN_s1_arbitrator (
                              // inputs:
                               NET_EN_s1_readdata,
                               clk,
                               cpu_data_master_address_to_slave,
                               cpu_data_master_read,
                               cpu_data_master_write,
                               reset_n,

                              // outputs:
                               NET_EN_s1_address,
                               NET_EN_s1_readdata_from_sa,
                               NET_EN_s1_reset_n,
                               cpu_data_master_granted_NET_EN_s1,
                               cpu_data_master_qualified_request_NET_EN_s1,
                               cpu_data_master_read_data_valid_NET_EN_s1,
                               cpu_data_master_requests_NET_EN_s1,
                               d1_NET_EN_s1_end_xfer
                            )
;

  output  [  1: 0] NET_EN_s1_address;
  output  [ 31: 0] NET_EN_s1_readdata_from_sa;
  output           NET_EN_s1_reset_n;
  output           cpu_data_master_granted_NET_EN_s1;
  output           cpu_data_master_qualified_request_NET_EN_s1;
  output           cpu_data_master_read_data_valid_NET_EN_s1;
  output           cpu_data_master_requests_NET_EN_s1;
  output           d1_NET_EN_s1_end_xfer;
  input   [ 31: 0] NET_EN_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input            reset_n;

  wire    [  1: 0] NET_EN_s1_address;
  wire             NET_EN_s1_allgrants;
  wire             NET_EN_s1_allow_new_arb_cycle;
  wire             NET_EN_s1_any_bursting_master_saved_grant;
  wire             NET_EN_s1_any_continuerequest;
  wire             NET_EN_s1_arb_counter_enable;
  reg     [  1: 0] NET_EN_s1_arb_share_counter;
  wire    [  1: 0] NET_EN_s1_arb_share_counter_next_value;
  wire    [  1: 0] NET_EN_s1_arb_share_set_values;
  wire             NET_EN_s1_beginbursttransfer_internal;
  wire             NET_EN_s1_begins_xfer;
  wire             NET_EN_s1_end_xfer;
  wire             NET_EN_s1_firsttransfer;
  wire             NET_EN_s1_grant_vector;
  wire             NET_EN_s1_in_a_read_cycle;
  wire             NET_EN_s1_in_a_write_cycle;
  wire             NET_EN_s1_master_qreq_vector;
  wire             NET_EN_s1_non_bursting_master_requests;
  wire    [ 31: 0] NET_EN_s1_readdata_from_sa;
  reg              NET_EN_s1_reg_firsttransfer;
  wire             NET_EN_s1_reset_n;
  reg              NET_EN_s1_slavearbiterlockenable;
  wire             NET_EN_s1_slavearbiterlockenable2;
  wire             NET_EN_s1_unreg_firsttransfer;
  wire             NET_EN_s1_waits_for_read;
  wire             NET_EN_s1_waits_for_write;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_NET_EN_s1;
  wire             cpu_data_master_qualified_request_NET_EN_s1;
  wire             cpu_data_master_read_data_valid_NET_EN_s1;
  wire             cpu_data_master_requests_NET_EN_s1;
  wire             cpu_data_master_saved_grant_NET_EN_s1;
  reg              d1_NET_EN_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_NET_EN_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_NET_EN_s1_from_cpu_data_master;
  wire             wait_for_NET_EN_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~NET_EN_s1_end_xfer;
    end


  assign NET_EN_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_NET_EN_s1));
  //assign NET_EN_s1_readdata_from_sa = NET_EN_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign NET_EN_s1_readdata_from_sa = NET_EN_s1_readdata;

  assign cpu_data_master_requests_NET_EN_s1 = (({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18c0) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //NET_EN_s1_arb_share_counter set values, which is an e_mux
  assign NET_EN_s1_arb_share_set_values = 1;

  //NET_EN_s1_non_bursting_master_requests mux, which is an e_mux
  assign NET_EN_s1_non_bursting_master_requests = cpu_data_master_requests_NET_EN_s1;

  //NET_EN_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign NET_EN_s1_any_bursting_master_saved_grant = 0;

  //NET_EN_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign NET_EN_s1_arb_share_counter_next_value = NET_EN_s1_firsttransfer ? (NET_EN_s1_arb_share_set_values - 1) : |NET_EN_s1_arb_share_counter ? (NET_EN_s1_arb_share_counter - 1) : 0;

  //NET_EN_s1_allgrants all slave grants, which is an e_mux
  assign NET_EN_s1_allgrants = |NET_EN_s1_grant_vector;

  //NET_EN_s1_end_xfer assignment, which is an e_assign
  assign NET_EN_s1_end_xfer = ~(NET_EN_s1_waits_for_read | NET_EN_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_NET_EN_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_NET_EN_s1 = NET_EN_s1_end_xfer & (~NET_EN_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //NET_EN_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign NET_EN_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_NET_EN_s1 & NET_EN_s1_allgrants) | (end_xfer_arb_share_counter_term_NET_EN_s1 & ~NET_EN_s1_non_bursting_master_requests);

  //NET_EN_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          NET_EN_s1_arb_share_counter <= 0;
      else if (NET_EN_s1_arb_counter_enable)
          NET_EN_s1_arb_share_counter <= NET_EN_s1_arb_share_counter_next_value;
    end


  //NET_EN_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          NET_EN_s1_slavearbiterlockenable <= 0;
      else if ((|NET_EN_s1_master_qreq_vector & end_xfer_arb_share_counter_term_NET_EN_s1) | (end_xfer_arb_share_counter_term_NET_EN_s1 & ~NET_EN_s1_non_bursting_master_requests))
          NET_EN_s1_slavearbiterlockenable <= |NET_EN_s1_arb_share_counter_next_value;
    end


  //cpu/data_master NET_EN/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = NET_EN_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //NET_EN_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign NET_EN_s1_slavearbiterlockenable2 = |NET_EN_s1_arb_share_counter_next_value;

  //cpu/data_master NET_EN/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = NET_EN_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //NET_EN_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign NET_EN_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_NET_EN_s1 = cpu_data_master_requests_NET_EN_s1;
  //master is always granted when requested
  assign cpu_data_master_granted_NET_EN_s1 = cpu_data_master_qualified_request_NET_EN_s1;

  //cpu/data_master saved-grant NET_EN/s1, which is an e_assign
  assign cpu_data_master_saved_grant_NET_EN_s1 = cpu_data_master_requests_NET_EN_s1;

  //allow new arb cycle for NET_EN/s1, which is an e_assign
  assign NET_EN_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign NET_EN_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign NET_EN_s1_master_qreq_vector = 1;

  //NET_EN_s1_reset_n assignment, which is an e_assign
  assign NET_EN_s1_reset_n = reset_n;

  //NET_EN_s1_firsttransfer first transaction, which is an e_assign
  assign NET_EN_s1_firsttransfer = NET_EN_s1_begins_xfer ? NET_EN_s1_unreg_firsttransfer : NET_EN_s1_reg_firsttransfer;

  //NET_EN_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign NET_EN_s1_unreg_firsttransfer = ~(NET_EN_s1_slavearbiterlockenable & NET_EN_s1_any_continuerequest);

  //NET_EN_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          NET_EN_s1_reg_firsttransfer <= 1'b1;
      else if (NET_EN_s1_begins_xfer)
          NET_EN_s1_reg_firsttransfer <= NET_EN_s1_unreg_firsttransfer;
    end


  //NET_EN_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign NET_EN_s1_beginbursttransfer_internal = NET_EN_s1_begins_xfer;

  assign shifted_address_to_NET_EN_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //NET_EN_s1_address mux, which is an e_mux
  assign NET_EN_s1_address = shifted_address_to_NET_EN_s1_from_cpu_data_master >> 2;

  //d1_NET_EN_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_NET_EN_s1_end_xfer <= 1;
      else 
        d1_NET_EN_s1_end_xfer <= NET_EN_s1_end_xfer;
    end


  //NET_EN_s1_waits_for_read in a cycle, which is an e_mux
  assign NET_EN_s1_waits_for_read = NET_EN_s1_in_a_read_cycle & NET_EN_s1_begins_xfer;

  //NET_EN_s1_in_a_read_cycle assignment, which is an e_assign
  assign NET_EN_s1_in_a_read_cycle = cpu_data_master_granted_NET_EN_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = NET_EN_s1_in_a_read_cycle;

  //NET_EN_s1_waits_for_write in a cycle, which is an e_mux
  assign NET_EN_s1_waits_for_write = NET_EN_s1_in_a_write_cycle & 0;

  //NET_EN_s1_in_a_write_cycle assignment, which is an e_assign
  assign NET_EN_s1_in_a_write_cycle = cpu_data_master_granted_NET_EN_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = NET_EN_s1_in_a_write_cycle;

  assign wait_for_NET_EN_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //NET_EN/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module NET_TESTDO_s1_arbitrator (
                                  // inputs:
                                   NET_TESTDO_s1_readdata,
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_read,
                                   cpu_data_master_waitrequest,
                                   cpu_data_master_write,
                                   cpu_data_master_writedata,
                                   reset_n,

                                  // outputs:
                                   NET_TESTDO_s1_address,
                                   NET_TESTDO_s1_chipselect,
                                   NET_TESTDO_s1_readdata_from_sa,
                                   NET_TESTDO_s1_reset_n,
                                   NET_TESTDO_s1_write_n,
                                   NET_TESTDO_s1_writedata,
                                   cpu_data_master_granted_NET_TESTDO_s1,
                                   cpu_data_master_qualified_request_NET_TESTDO_s1,
                                   cpu_data_master_read_data_valid_NET_TESTDO_s1,
                                   cpu_data_master_requests_NET_TESTDO_s1,
                                   d1_NET_TESTDO_s1_end_xfer
                                )
;

  output  [  1: 0] NET_TESTDO_s1_address;
  output           NET_TESTDO_s1_chipselect;
  output  [ 31: 0] NET_TESTDO_s1_readdata_from_sa;
  output           NET_TESTDO_s1_reset_n;
  output           NET_TESTDO_s1_write_n;
  output  [ 31: 0] NET_TESTDO_s1_writedata;
  output           cpu_data_master_granted_NET_TESTDO_s1;
  output           cpu_data_master_qualified_request_NET_TESTDO_s1;
  output           cpu_data_master_read_data_valid_NET_TESTDO_s1;
  output           cpu_data_master_requests_NET_TESTDO_s1;
  output           d1_NET_TESTDO_s1_end_xfer;
  input   [ 31: 0] NET_TESTDO_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] NET_TESTDO_s1_address;
  wire             NET_TESTDO_s1_allgrants;
  wire             NET_TESTDO_s1_allow_new_arb_cycle;
  wire             NET_TESTDO_s1_any_bursting_master_saved_grant;
  wire             NET_TESTDO_s1_any_continuerequest;
  wire             NET_TESTDO_s1_arb_counter_enable;
  reg     [  1: 0] NET_TESTDO_s1_arb_share_counter;
  wire    [  1: 0] NET_TESTDO_s1_arb_share_counter_next_value;
  wire    [  1: 0] NET_TESTDO_s1_arb_share_set_values;
  wire             NET_TESTDO_s1_beginbursttransfer_internal;
  wire             NET_TESTDO_s1_begins_xfer;
  wire             NET_TESTDO_s1_chipselect;
  wire             NET_TESTDO_s1_end_xfer;
  wire             NET_TESTDO_s1_firsttransfer;
  wire             NET_TESTDO_s1_grant_vector;
  wire             NET_TESTDO_s1_in_a_read_cycle;
  wire             NET_TESTDO_s1_in_a_write_cycle;
  wire             NET_TESTDO_s1_master_qreq_vector;
  wire             NET_TESTDO_s1_non_bursting_master_requests;
  wire    [ 31: 0] NET_TESTDO_s1_readdata_from_sa;
  reg              NET_TESTDO_s1_reg_firsttransfer;
  wire             NET_TESTDO_s1_reset_n;
  reg              NET_TESTDO_s1_slavearbiterlockenable;
  wire             NET_TESTDO_s1_slavearbiterlockenable2;
  wire             NET_TESTDO_s1_unreg_firsttransfer;
  wire             NET_TESTDO_s1_waits_for_read;
  wire             NET_TESTDO_s1_waits_for_write;
  wire             NET_TESTDO_s1_write_n;
  wire    [ 31: 0] NET_TESTDO_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_NET_TESTDO_s1;
  wire             cpu_data_master_qualified_request_NET_TESTDO_s1;
  wire             cpu_data_master_read_data_valid_NET_TESTDO_s1;
  wire             cpu_data_master_requests_NET_TESTDO_s1;
  wire             cpu_data_master_saved_grant_NET_TESTDO_s1;
  reg              d1_NET_TESTDO_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_NET_TESTDO_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_NET_TESTDO_s1_from_cpu_data_master;
  wire             wait_for_NET_TESTDO_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~NET_TESTDO_s1_end_xfer;
    end


  assign NET_TESTDO_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_NET_TESTDO_s1));
  //assign NET_TESTDO_s1_readdata_from_sa = NET_TESTDO_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign NET_TESTDO_s1_readdata_from_sa = NET_TESTDO_s1_readdata;

  assign cpu_data_master_requests_NET_TESTDO_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18b0) & (cpu_data_master_read | cpu_data_master_write);
  //NET_TESTDO_s1_arb_share_counter set values, which is an e_mux
  assign NET_TESTDO_s1_arb_share_set_values = 1;

  //NET_TESTDO_s1_non_bursting_master_requests mux, which is an e_mux
  assign NET_TESTDO_s1_non_bursting_master_requests = cpu_data_master_requests_NET_TESTDO_s1;

  //NET_TESTDO_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign NET_TESTDO_s1_any_bursting_master_saved_grant = 0;

  //NET_TESTDO_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign NET_TESTDO_s1_arb_share_counter_next_value = NET_TESTDO_s1_firsttransfer ? (NET_TESTDO_s1_arb_share_set_values - 1) : |NET_TESTDO_s1_arb_share_counter ? (NET_TESTDO_s1_arb_share_counter - 1) : 0;

  //NET_TESTDO_s1_allgrants all slave grants, which is an e_mux
  assign NET_TESTDO_s1_allgrants = |NET_TESTDO_s1_grant_vector;

  //NET_TESTDO_s1_end_xfer assignment, which is an e_assign
  assign NET_TESTDO_s1_end_xfer = ~(NET_TESTDO_s1_waits_for_read | NET_TESTDO_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_NET_TESTDO_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_NET_TESTDO_s1 = NET_TESTDO_s1_end_xfer & (~NET_TESTDO_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //NET_TESTDO_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign NET_TESTDO_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_NET_TESTDO_s1 & NET_TESTDO_s1_allgrants) | (end_xfer_arb_share_counter_term_NET_TESTDO_s1 & ~NET_TESTDO_s1_non_bursting_master_requests);

  //NET_TESTDO_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          NET_TESTDO_s1_arb_share_counter <= 0;
      else if (NET_TESTDO_s1_arb_counter_enable)
          NET_TESTDO_s1_arb_share_counter <= NET_TESTDO_s1_arb_share_counter_next_value;
    end


  //NET_TESTDO_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          NET_TESTDO_s1_slavearbiterlockenable <= 0;
      else if ((|NET_TESTDO_s1_master_qreq_vector & end_xfer_arb_share_counter_term_NET_TESTDO_s1) | (end_xfer_arb_share_counter_term_NET_TESTDO_s1 & ~NET_TESTDO_s1_non_bursting_master_requests))
          NET_TESTDO_s1_slavearbiterlockenable <= |NET_TESTDO_s1_arb_share_counter_next_value;
    end


  //cpu/data_master NET_TESTDO/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = NET_TESTDO_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //NET_TESTDO_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign NET_TESTDO_s1_slavearbiterlockenable2 = |NET_TESTDO_s1_arb_share_counter_next_value;

  //cpu/data_master NET_TESTDO/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = NET_TESTDO_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //NET_TESTDO_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign NET_TESTDO_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_NET_TESTDO_s1 = cpu_data_master_requests_NET_TESTDO_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //NET_TESTDO_s1_writedata mux, which is an e_mux
  assign NET_TESTDO_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_NET_TESTDO_s1 = cpu_data_master_qualified_request_NET_TESTDO_s1;

  //cpu/data_master saved-grant NET_TESTDO/s1, which is an e_assign
  assign cpu_data_master_saved_grant_NET_TESTDO_s1 = cpu_data_master_requests_NET_TESTDO_s1;

  //allow new arb cycle for NET_TESTDO/s1, which is an e_assign
  assign NET_TESTDO_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign NET_TESTDO_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign NET_TESTDO_s1_master_qreq_vector = 1;

  //NET_TESTDO_s1_reset_n assignment, which is an e_assign
  assign NET_TESTDO_s1_reset_n = reset_n;

  assign NET_TESTDO_s1_chipselect = cpu_data_master_granted_NET_TESTDO_s1;
  //NET_TESTDO_s1_firsttransfer first transaction, which is an e_assign
  assign NET_TESTDO_s1_firsttransfer = NET_TESTDO_s1_begins_xfer ? NET_TESTDO_s1_unreg_firsttransfer : NET_TESTDO_s1_reg_firsttransfer;

  //NET_TESTDO_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign NET_TESTDO_s1_unreg_firsttransfer = ~(NET_TESTDO_s1_slavearbiterlockenable & NET_TESTDO_s1_any_continuerequest);

  //NET_TESTDO_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          NET_TESTDO_s1_reg_firsttransfer <= 1'b1;
      else if (NET_TESTDO_s1_begins_xfer)
          NET_TESTDO_s1_reg_firsttransfer <= NET_TESTDO_s1_unreg_firsttransfer;
    end


  //NET_TESTDO_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign NET_TESTDO_s1_beginbursttransfer_internal = NET_TESTDO_s1_begins_xfer;

  //~NET_TESTDO_s1_write_n assignment, which is an e_mux
  assign NET_TESTDO_s1_write_n = ~(cpu_data_master_granted_NET_TESTDO_s1 & cpu_data_master_write);

  assign shifted_address_to_NET_TESTDO_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //NET_TESTDO_s1_address mux, which is an e_mux
  assign NET_TESTDO_s1_address = shifted_address_to_NET_TESTDO_s1_from_cpu_data_master >> 2;

  //d1_NET_TESTDO_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_NET_TESTDO_s1_end_xfer <= 1;
      else 
        d1_NET_TESTDO_s1_end_xfer <= NET_TESTDO_s1_end_xfer;
    end


  //NET_TESTDO_s1_waits_for_read in a cycle, which is an e_mux
  assign NET_TESTDO_s1_waits_for_read = NET_TESTDO_s1_in_a_read_cycle & NET_TESTDO_s1_begins_xfer;

  //NET_TESTDO_s1_in_a_read_cycle assignment, which is an e_assign
  assign NET_TESTDO_s1_in_a_read_cycle = cpu_data_master_granted_NET_TESTDO_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = NET_TESTDO_s1_in_a_read_cycle;

  //NET_TESTDO_s1_waits_for_write in a cycle, which is an e_mux
  assign NET_TESTDO_s1_waits_for_write = NET_TESTDO_s1_in_a_write_cycle & 0;

  //NET_TESTDO_s1_in_a_write_cycle assignment, which is an e_assign
  assign NET_TESTDO_s1_in_a_write_cycle = cpu_data_master_granted_NET_TESTDO_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = NET_TESTDO_s1_in_a_write_cycle;

  assign wait_for_NET_TESTDO_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //NET_TESTDO/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USBSD_RDO_s1_arbitrator (
                                 // inputs:
                                  USBSD_RDO_s1_readdata,
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_waitrequest,
                                  cpu_data_master_write,
                                  cpu_data_master_writedata,
                                  reset_n,

                                 // outputs:
                                  USBSD_RDO_s1_address,
                                  USBSD_RDO_s1_chipselect,
                                  USBSD_RDO_s1_readdata_from_sa,
                                  USBSD_RDO_s1_reset_n,
                                  USBSD_RDO_s1_write_n,
                                  USBSD_RDO_s1_writedata,
                                  cpu_data_master_granted_USBSD_RDO_s1,
                                  cpu_data_master_qualified_request_USBSD_RDO_s1,
                                  cpu_data_master_read_data_valid_USBSD_RDO_s1,
                                  cpu_data_master_requests_USBSD_RDO_s1,
                                  d1_USBSD_RDO_s1_end_xfer
                               )
;

  output  [  1: 0] USBSD_RDO_s1_address;
  output           USBSD_RDO_s1_chipselect;
  output  [ 31: 0] USBSD_RDO_s1_readdata_from_sa;
  output           USBSD_RDO_s1_reset_n;
  output           USBSD_RDO_s1_write_n;
  output  [ 31: 0] USBSD_RDO_s1_writedata;
  output           cpu_data_master_granted_USBSD_RDO_s1;
  output           cpu_data_master_qualified_request_USBSD_RDO_s1;
  output           cpu_data_master_read_data_valid_USBSD_RDO_s1;
  output           cpu_data_master_requests_USBSD_RDO_s1;
  output           d1_USBSD_RDO_s1_end_xfer;
  input   [ 31: 0] USBSD_RDO_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] USBSD_RDO_s1_address;
  wire             USBSD_RDO_s1_allgrants;
  wire             USBSD_RDO_s1_allow_new_arb_cycle;
  wire             USBSD_RDO_s1_any_bursting_master_saved_grant;
  wire             USBSD_RDO_s1_any_continuerequest;
  wire             USBSD_RDO_s1_arb_counter_enable;
  reg     [  1: 0] USBSD_RDO_s1_arb_share_counter;
  wire    [  1: 0] USBSD_RDO_s1_arb_share_counter_next_value;
  wire    [  1: 0] USBSD_RDO_s1_arb_share_set_values;
  wire             USBSD_RDO_s1_beginbursttransfer_internal;
  wire             USBSD_RDO_s1_begins_xfer;
  wire             USBSD_RDO_s1_chipselect;
  wire             USBSD_RDO_s1_end_xfer;
  wire             USBSD_RDO_s1_firsttransfer;
  wire             USBSD_RDO_s1_grant_vector;
  wire             USBSD_RDO_s1_in_a_read_cycle;
  wire             USBSD_RDO_s1_in_a_write_cycle;
  wire             USBSD_RDO_s1_master_qreq_vector;
  wire             USBSD_RDO_s1_non_bursting_master_requests;
  wire    [ 31: 0] USBSD_RDO_s1_readdata_from_sa;
  reg              USBSD_RDO_s1_reg_firsttransfer;
  wire             USBSD_RDO_s1_reset_n;
  reg              USBSD_RDO_s1_slavearbiterlockenable;
  wire             USBSD_RDO_s1_slavearbiterlockenable2;
  wire             USBSD_RDO_s1_unreg_firsttransfer;
  wire             USBSD_RDO_s1_waits_for_read;
  wire             USBSD_RDO_s1_waits_for_write;
  wire             USBSD_RDO_s1_write_n;
  wire    [ 31: 0] USBSD_RDO_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USBSD_RDO_s1;
  wire             cpu_data_master_qualified_request_USBSD_RDO_s1;
  wire             cpu_data_master_read_data_valid_USBSD_RDO_s1;
  wire             cpu_data_master_requests_USBSD_RDO_s1;
  wire             cpu_data_master_saved_grant_USBSD_RDO_s1;
  reg              d1_USBSD_RDO_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USBSD_RDO_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USBSD_RDO_s1_from_cpu_data_master;
  wire             wait_for_USBSD_RDO_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USBSD_RDO_s1_end_xfer;
    end


  assign USBSD_RDO_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USBSD_RDO_s1));
  //assign USBSD_RDO_s1_readdata_from_sa = USBSD_RDO_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USBSD_RDO_s1_readdata_from_sa = USBSD_RDO_s1_readdata;

  assign cpu_data_master_requests_USBSD_RDO_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18f0) & (cpu_data_master_read | cpu_data_master_write);
  //USBSD_RDO_s1_arb_share_counter set values, which is an e_mux
  assign USBSD_RDO_s1_arb_share_set_values = 1;

  //USBSD_RDO_s1_non_bursting_master_requests mux, which is an e_mux
  assign USBSD_RDO_s1_non_bursting_master_requests = cpu_data_master_requests_USBSD_RDO_s1;

  //USBSD_RDO_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USBSD_RDO_s1_any_bursting_master_saved_grant = 0;

  //USBSD_RDO_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USBSD_RDO_s1_arb_share_counter_next_value = USBSD_RDO_s1_firsttransfer ? (USBSD_RDO_s1_arb_share_set_values - 1) : |USBSD_RDO_s1_arb_share_counter ? (USBSD_RDO_s1_arb_share_counter - 1) : 0;

  //USBSD_RDO_s1_allgrants all slave grants, which is an e_mux
  assign USBSD_RDO_s1_allgrants = |USBSD_RDO_s1_grant_vector;

  //USBSD_RDO_s1_end_xfer assignment, which is an e_assign
  assign USBSD_RDO_s1_end_xfer = ~(USBSD_RDO_s1_waits_for_read | USBSD_RDO_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USBSD_RDO_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USBSD_RDO_s1 = USBSD_RDO_s1_end_xfer & (~USBSD_RDO_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USBSD_RDO_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USBSD_RDO_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USBSD_RDO_s1 & USBSD_RDO_s1_allgrants) | (end_xfer_arb_share_counter_term_USBSD_RDO_s1 & ~USBSD_RDO_s1_non_bursting_master_requests);

  //USBSD_RDO_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_RDO_s1_arb_share_counter <= 0;
      else if (USBSD_RDO_s1_arb_counter_enable)
          USBSD_RDO_s1_arb_share_counter <= USBSD_RDO_s1_arb_share_counter_next_value;
    end


  //USBSD_RDO_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_RDO_s1_slavearbiterlockenable <= 0;
      else if ((|USBSD_RDO_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USBSD_RDO_s1) | (end_xfer_arb_share_counter_term_USBSD_RDO_s1 & ~USBSD_RDO_s1_non_bursting_master_requests))
          USBSD_RDO_s1_slavearbiterlockenable <= |USBSD_RDO_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USBSD_RDO/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USBSD_RDO_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USBSD_RDO_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USBSD_RDO_s1_slavearbiterlockenable2 = |USBSD_RDO_s1_arb_share_counter_next_value;

  //cpu/data_master USBSD_RDO/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USBSD_RDO_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USBSD_RDO_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USBSD_RDO_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USBSD_RDO_s1 = cpu_data_master_requests_USBSD_RDO_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //USBSD_RDO_s1_writedata mux, which is an e_mux
  assign USBSD_RDO_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_USBSD_RDO_s1 = cpu_data_master_qualified_request_USBSD_RDO_s1;

  //cpu/data_master saved-grant USBSD_RDO/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USBSD_RDO_s1 = cpu_data_master_requests_USBSD_RDO_s1;

  //allow new arb cycle for USBSD_RDO/s1, which is an e_assign
  assign USBSD_RDO_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USBSD_RDO_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USBSD_RDO_s1_master_qreq_vector = 1;

  //USBSD_RDO_s1_reset_n assignment, which is an e_assign
  assign USBSD_RDO_s1_reset_n = reset_n;

  assign USBSD_RDO_s1_chipselect = cpu_data_master_granted_USBSD_RDO_s1;
  //USBSD_RDO_s1_firsttransfer first transaction, which is an e_assign
  assign USBSD_RDO_s1_firsttransfer = USBSD_RDO_s1_begins_xfer ? USBSD_RDO_s1_unreg_firsttransfer : USBSD_RDO_s1_reg_firsttransfer;

  //USBSD_RDO_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USBSD_RDO_s1_unreg_firsttransfer = ~(USBSD_RDO_s1_slavearbiterlockenable & USBSD_RDO_s1_any_continuerequest);

  //USBSD_RDO_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_RDO_s1_reg_firsttransfer <= 1'b1;
      else if (USBSD_RDO_s1_begins_xfer)
          USBSD_RDO_s1_reg_firsttransfer <= USBSD_RDO_s1_unreg_firsttransfer;
    end


  //USBSD_RDO_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USBSD_RDO_s1_beginbursttransfer_internal = USBSD_RDO_s1_begins_xfer;

  //~USBSD_RDO_s1_write_n assignment, which is an e_mux
  assign USBSD_RDO_s1_write_n = ~(cpu_data_master_granted_USBSD_RDO_s1 & cpu_data_master_write);

  assign shifted_address_to_USBSD_RDO_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USBSD_RDO_s1_address mux, which is an e_mux
  assign USBSD_RDO_s1_address = shifted_address_to_USBSD_RDO_s1_from_cpu_data_master >> 2;

  //d1_USBSD_RDO_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USBSD_RDO_s1_end_xfer <= 1;
      else 
        d1_USBSD_RDO_s1_end_xfer <= USBSD_RDO_s1_end_xfer;
    end


  //USBSD_RDO_s1_waits_for_read in a cycle, which is an e_mux
  assign USBSD_RDO_s1_waits_for_read = USBSD_RDO_s1_in_a_read_cycle & USBSD_RDO_s1_begins_xfer;

  //USBSD_RDO_s1_in_a_read_cycle assignment, which is an e_assign
  assign USBSD_RDO_s1_in_a_read_cycle = cpu_data_master_granted_USBSD_RDO_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USBSD_RDO_s1_in_a_read_cycle;

  //USBSD_RDO_s1_waits_for_write in a cycle, which is an e_mux
  assign USBSD_RDO_s1_waits_for_write = USBSD_RDO_s1_in_a_write_cycle & 0;

  //USBSD_RDO_s1_in_a_write_cycle assignment, which is an e_assign
  assign USBSD_RDO_s1_in_a_write_cycle = cpu_data_master_granted_USBSD_RDO_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USBSD_RDO_s1_in_a_write_cycle;

  assign wait_for_USBSD_RDO_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USBSD_RDO/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USBSD_RVLD_s1_arbitrator (
                                  // inputs:
                                   USBSD_RVLD_s1_readdata,
                                   clk,
                                   cpu_data_master_address_to_slave,
                                   cpu_data_master_read,
                                   cpu_data_master_waitrequest,
                                   cpu_data_master_write,
                                   cpu_data_master_writedata,
                                   reset_n,

                                  // outputs:
                                   USBSD_RVLD_s1_address,
                                   USBSD_RVLD_s1_chipselect,
                                   USBSD_RVLD_s1_readdata_from_sa,
                                   USBSD_RVLD_s1_reset_n,
                                   USBSD_RVLD_s1_write_n,
                                   USBSD_RVLD_s1_writedata,
                                   cpu_data_master_granted_USBSD_RVLD_s1,
                                   cpu_data_master_qualified_request_USBSD_RVLD_s1,
                                   cpu_data_master_read_data_valid_USBSD_RVLD_s1,
                                   cpu_data_master_requests_USBSD_RVLD_s1,
                                   d1_USBSD_RVLD_s1_end_xfer
                                )
;

  output  [  1: 0] USBSD_RVLD_s1_address;
  output           USBSD_RVLD_s1_chipselect;
  output  [ 31: 0] USBSD_RVLD_s1_readdata_from_sa;
  output           USBSD_RVLD_s1_reset_n;
  output           USBSD_RVLD_s1_write_n;
  output  [ 31: 0] USBSD_RVLD_s1_writedata;
  output           cpu_data_master_granted_USBSD_RVLD_s1;
  output           cpu_data_master_qualified_request_USBSD_RVLD_s1;
  output           cpu_data_master_read_data_valid_USBSD_RVLD_s1;
  output           cpu_data_master_requests_USBSD_RVLD_s1;
  output           d1_USBSD_RVLD_s1_end_xfer;
  input   [ 31: 0] USBSD_RVLD_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] USBSD_RVLD_s1_address;
  wire             USBSD_RVLD_s1_allgrants;
  wire             USBSD_RVLD_s1_allow_new_arb_cycle;
  wire             USBSD_RVLD_s1_any_bursting_master_saved_grant;
  wire             USBSD_RVLD_s1_any_continuerequest;
  wire             USBSD_RVLD_s1_arb_counter_enable;
  reg     [  1: 0] USBSD_RVLD_s1_arb_share_counter;
  wire    [  1: 0] USBSD_RVLD_s1_arb_share_counter_next_value;
  wire    [  1: 0] USBSD_RVLD_s1_arb_share_set_values;
  wire             USBSD_RVLD_s1_beginbursttransfer_internal;
  wire             USBSD_RVLD_s1_begins_xfer;
  wire             USBSD_RVLD_s1_chipselect;
  wire             USBSD_RVLD_s1_end_xfer;
  wire             USBSD_RVLD_s1_firsttransfer;
  wire             USBSD_RVLD_s1_grant_vector;
  wire             USBSD_RVLD_s1_in_a_read_cycle;
  wire             USBSD_RVLD_s1_in_a_write_cycle;
  wire             USBSD_RVLD_s1_master_qreq_vector;
  wire             USBSD_RVLD_s1_non_bursting_master_requests;
  wire    [ 31: 0] USBSD_RVLD_s1_readdata_from_sa;
  reg              USBSD_RVLD_s1_reg_firsttransfer;
  wire             USBSD_RVLD_s1_reset_n;
  reg              USBSD_RVLD_s1_slavearbiterlockenable;
  wire             USBSD_RVLD_s1_slavearbiterlockenable2;
  wire             USBSD_RVLD_s1_unreg_firsttransfer;
  wire             USBSD_RVLD_s1_waits_for_read;
  wire             USBSD_RVLD_s1_waits_for_write;
  wire             USBSD_RVLD_s1_write_n;
  wire    [ 31: 0] USBSD_RVLD_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USBSD_RVLD_s1;
  wire             cpu_data_master_qualified_request_USBSD_RVLD_s1;
  wire             cpu_data_master_read_data_valid_USBSD_RVLD_s1;
  wire             cpu_data_master_requests_USBSD_RVLD_s1;
  wire             cpu_data_master_saved_grant_USBSD_RVLD_s1;
  reg              d1_USBSD_RVLD_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USBSD_RVLD_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USBSD_RVLD_s1_from_cpu_data_master;
  wire             wait_for_USBSD_RVLD_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USBSD_RVLD_s1_end_xfer;
    end


  assign USBSD_RVLD_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USBSD_RVLD_s1));
  //assign USBSD_RVLD_s1_readdata_from_sa = USBSD_RVLD_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USBSD_RVLD_s1_readdata_from_sa = USBSD_RVLD_s1_readdata;

  assign cpu_data_master_requests_USBSD_RVLD_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1900) & (cpu_data_master_read | cpu_data_master_write);
  //USBSD_RVLD_s1_arb_share_counter set values, which is an e_mux
  assign USBSD_RVLD_s1_arb_share_set_values = 1;

  //USBSD_RVLD_s1_non_bursting_master_requests mux, which is an e_mux
  assign USBSD_RVLD_s1_non_bursting_master_requests = cpu_data_master_requests_USBSD_RVLD_s1;

  //USBSD_RVLD_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USBSD_RVLD_s1_any_bursting_master_saved_grant = 0;

  //USBSD_RVLD_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USBSD_RVLD_s1_arb_share_counter_next_value = USBSD_RVLD_s1_firsttransfer ? (USBSD_RVLD_s1_arb_share_set_values - 1) : |USBSD_RVLD_s1_arb_share_counter ? (USBSD_RVLD_s1_arb_share_counter - 1) : 0;

  //USBSD_RVLD_s1_allgrants all slave grants, which is an e_mux
  assign USBSD_RVLD_s1_allgrants = |USBSD_RVLD_s1_grant_vector;

  //USBSD_RVLD_s1_end_xfer assignment, which is an e_assign
  assign USBSD_RVLD_s1_end_xfer = ~(USBSD_RVLD_s1_waits_for_read | USBSD_RVLD_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USBSD_RVLD_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USBSD_RVLD_s1 = USBSD_RVLD_s1_end_xfer & (~USBSD_RVLD_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USBSD_RVLD_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USBSD_RVLD_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USBSD_RVLD_s1 & USBSD_RVLD_s1_allgrants) | (end_xfer_arb_share_counter_term_USBSD_RVLD_s1 & ~USBSD_RVLD_s1_non_bursting_master_requests);

  //USBSD_RVLD_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_RVLD_s1_arb_share_counter <= 0;
      else if (USBSD_RVLD_s1_arb_counter_enable)
          USBSD_RVLD_s1_arb_share_counter <= USBSD_RVLD_s1_arb_share_counter_next_value;
    end


  //USBSD_RVLD_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_RVLD_s1_slavearbiterlockenable <= 0;
      else if ((|USBSD_RVLD_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USBSD_RVLD_s1) | (end_xfer_arb_share_counter_term_USBSD_RVLD_s1 & ~USBSD_RVLD_s1_non_bursting_master_requests))
          USBSD_RVLD_s1_slavearbiterlockenable <= |USBSD_RVLD_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USBSD_RVLD/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USBSD_RVLD_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USBSD_RVLD_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USBSD_RVLD_s1_slavearbiterlockenable2 = |USBSD_RVLD_s1_arb_share_counter_next_value;

  //cpu/data_master USBSD_RVLD/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USBSD_RVLD_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USBSD_RVLD_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USBSD_RVLD_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USBSD_RVLD_s1 = cpu_data_master_requests_USBSD_RVLD_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //USBSD_RVLD_s1_writedata mux, which is an e_mux
  assign USBSD_RVLD_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_USBSD_RVLD_s1 = cpu_data_master_qualified_request_USBSD_RVLD_s1;

  //cpu/data_master saved-grant USBSD_RVLD/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USBSD_RVLD_s1 = cpu_data_master_requests_USBSD_RVLD_s1;

  //allow new arb cycle for USBSD_RVLD/s1, which is an e_assign
  assign USBSD_RVLD_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USBSD_RVLD_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USBSD_RVLD_s1_master_qreq_vector = 1;

  //USBSD_RVLD_s1_reset_n assignment, which is an e_assign
  assign USBSD_RVLD_s1_reset_n = reset_n;

  assign USBSD_RVLD_s1_chipselect = cpu_data_master_granted_USBSD_RVLD_s1;
  //USBSD_RVLD_s1_firsttransfer first transaction, which is an e_assign
  assign USBSD_RVLD_s1_firsttransfer = USBSD_RVLD_s1_begins_xfer ? USBSD_RVLD_s1_unreg_firsttransfer : USBSD_RVLD_s1_reg_firsttransfer;

  //USBSD_RVLD_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USBSD_RVLD_s1_unreg_firsttransfer = ~(USBSD_RVLD_s1_slavearbiterlockenable & USBSD_RVLD_s1_any_continuerequest);

  //USBSD_RVLD_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_RVLD_s1_reg_firsttransfer <= 1'b1;
      else if (USBSD_RVLD_s1_begins_xfer)
          USBSD_RVLD_s1_reg_firsttransfer <= USBSD_RVLD_s1_unreg_firsttransfer;
    end


  //USBSD_RVLD_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USBSD_RVLD_s1_beginbursttransfer_internal = USBSD_RVLD_s1_begins_xfer;

  //~USBSD_RVLD_s1_write_n assignment, which is an e_mux
  assign USBSD_RVLD_s1_write_n = ~(cpu_data_master_granted_USBSD_RVLD_s1 & cpu_data_master_write);

  assign shifted_address_to_USBSD_RVLD_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USBSD_RVLD_s1_address mux, which is an e_mux
  assign USBSD_RVLD_s1_address = shifted_address_to_USBSD_RVLD_s1_from_cpu_data_master >> 2;

  //d1_USBSD_RVLD_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USBSD_RVLD_s1_end_xfer <= 1;
      else 
        d1_USBSD_RVLD_s1_end_xfer <= USBSD_RVLD_s1_end_xfer;
    end


  //USBSD_RVLD_s1_waits_for_read in a cycle, which is an e_mux
  assign USBSD_RVLD_s1_waits_for_read = USBSD_RVLD_s1_in_a_read_cycle & USBSD_RVLD_s1_begins_xfer;

  //USBSD_RVLD_s1_in_a_read_cycle assignment, which is an e_assign
  assign USBSD_RVLD_s1_in_a_read_cycle = cpu_data_master_granted_USBSD_RVLD_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USBSD_RVLD_s1_in_a_read_cycle;

  //USBSD_RVLD_s1_waits_for_write in a cycle, which is an e_mux
  assign USBSD_RVLD_s1_waits_for_write = USBSD_RVLD_s1_in_a_write_cycle & 0;

  //USBSD_RVLD_s1_in_a_write_cycle assignment, which is an e_assign
  assign USBSD_RVLD_s1_in_a_write_cycle = cpu_data_master_granted_USBSD_RVLD_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USBSD_RVLD_s1_in_a_write_cycle;

  assign wait_for_USBSD_RVLD_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USBSD_RVLD/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USBSD_SEL_s1_arbitrator (
                                 // inputs:
                                  USBSD_SEL_s1_readdata,
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_write,
                                  reset_n,

                                 // outputs:
                                  USBSD_SEL_s1_address,
                                  USBSD_SEL_s1_readdata_from_sa,
                                  USBSD_SEL_s1_reset_n,
                                  cpu_data_master_granted_USBSD_SEL_s1,
                                  cpu_data_master_qualified_request_USBSD_SEL_s1,
                                  cpu_data_master_read_data_valid_USBSD_SEL_s1,
                                  cpu_data_master_requests_USBSD_SEL_s1,
                                  d1_USBSD_SEL_s1_end_xfer
                               )
;

  output  [  1: 0] USBSD_SEL_s1_address;
  output  [ 31: 0] USBSD_SEL_s1_readdata_from_sa;
  output           USBSD_SEL_s1_reset_n;
  output           cpu_data_master_granted_USBSD_SEL_s1;
  output           cpu_data_master_qualified_request_USBSD_SEL_s1;
  output           cpu_data_master_read_data_valid_USBSD_SEL_s1;
  output           cpu_data_master_requests_USBSD_SEL_s1;
  output           d1_USBSD_SEL_s1_end_xfer;
  input   [ 31: 0] USBSD_SEL_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input            reset_n;

  wire    [  1: 0] USBSD_SEL_s1_address;
  wire             USBSD_SEL_s1_allgrants;
  wire             USBSD_SEL_s1_allow_new_arb_cycle;
  wire             USBSD_SEL_s1_any_bursting_master_saved_grant;
  wire             USBSD_SEL_s1_any_continuerequest;
  wire             USBSD_SEL_s1_arb_counter_enable;
  reg     [  1: 0] USBSD_SEL_s1_arb_share_counter;
  wire    [  1: 0] USBSD_SEL_s1_arb_share_counter_next_value;
  wire    [  1: 0] USBSD_SEL_s1_arb_share_set_values;
  wire             USBSD_SEL_s1_beginbursttransfer_internal;
  wire             USBSD_SEL_s1_begins_xfer;
  wire             USBSD_SEL_s1_end_xfer;
  wire             USBSD_SEL_s1_firsttransfer;
  wire             USBSD_SEL_s1_grant_vector;
  wire             USBSD_SEL_s1_in_a_read_cycle;
  wire             USBSD_SEL_s1_in_a_write_cycle;
  wire             USBSD_SEL_s1_master_qreq_vector;
  wire             USBSD_SEL_s1_non_bursting_master_requests;
  wire    [ 31: 0] USBSD_SEL_s1_readdata_from_sa;
  reg              USBSD_SEL_s1_reg_firsttransfer;
  wire             USBSD_SEL_s1_reset_n;
  reg              USBSD_SEL_s1_slavearbiterlockenable;
  wire             USBSD_SEL_s1_slavearbiterlockenable2;
  wire             USBSD_SEL_s1_unreg_firsttransfer;
  wire             USBSD_SEL_s1_waits_for_read;
  wire             USBSD_SEL_s1_waits_for_write;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USBSD_SEL_s1;
  wire             cpu_data_master_qualified_request_USBSD_SEL_s1;
  wire             cpu_data_master_read_data_valid_USBSD_SEL_s1;
  wire             cpu_data_master_requests_USBSD_SEL_s1;
  wire             cpu_data_master_saved_grant_USBSD_SEL_s1;
  reg              d1_USBSD_SEL_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USBSD_SEL_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USBSD_SEL_s1_from_cpu_data_master;
  wire             wait_for_USBSD_SEL_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USBSD_SEL_s1_end_xfer;
    end


  assign USBSD_SEL_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USBSD_SEL_s1));
  //assign USBSD_SEL_s1_readdata_from_sa = USBSD_SEL_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USBSD_SEL_s1_readdata_from_sa = USBSD_SEL_s1_readdata;

  assign cpu_data_master_requests_USBSD_SEL_s1 = (({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18e0) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //USBSD_SEL_s1_arb_share_counter set values, which is an e_mux
  assign USBSD_SEL_s1_arb_share_set_values = 1;

  //USBSD_SEL_s1_non_bursting_master_requests mux, which is an e_mux
  assign USBSD_SEL_s1_non_bursting_master_requests = cpu_data_master_requests_USBSD_SEL_s1;

  //USBSD_SEL_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USBSD_SEL_s1_any_bursting_master_saved_grant = 0;

  //USBSD_SEL_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USBSD_SEL_s1_arb_share_counter_next_value = USBSD_SEL_s1_firsttransfer ? (USBSD_SEL_s1_arb_share_set_values - 1) : |USBSD_SEL_s1_arb_share_counter ? (USBSD_SEL_s1_arb_share_counter - 1) : 0;

  //USBSD_SEL_s1_allgrants all slave grants, which is an e_mux
  assign USBSD_SEL_s1_allgrants = |USBSD_SEL_s1_grant_vector;

  //USBSD_SEL_s1_end_xfer assignment, which is an e_assign
  assign USBSD_SEL_s1_end_xfer = ~(USBSD_SEL_s1_waits_for_read | USBSD_SEL_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USBSD_SEL_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USBSD_SEL_s1 = USBSD_SEL_s1_end_xfer & (~USBSD_SEL_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USBSD_SEL_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USBSD_SEL_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USBSD_SEL_s1 & USBSD_SEL_s1_allgrants) | (end_xfer_arb_share_counter_term_USBSD_SEL_s1 & ~USBSD_SEL_s1_non_bursting_master_requests);

  //USBSD_SEL_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_SEL_s1_arb_share_counter <= 0;
      else if (USBSD_SEL_s1_arb_counter_enable)
          USBSD_SEL_s1_arb_share_counter <= USBSD_SEL_s1_arb_share_counter_next_value;
    end


  //USBSD_SEL_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_SEL_s1_slavearbiterlockenable <= 0;
      else if ((|USBSD_SEL_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USBSD_SEL_s1) | (end_xfer_arb_share_counter_term_USBSD_SEL_s1 & ~USBSD_SEL_s1_non_bursting_master_requests))
          USBSD_SEL_s1_slavearbiterlockenable <= |USBSD_SEL_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USBSD_SEL/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USBSD_SEL_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USBSD_SEL_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USBSD_SEL_s1_slavearbiterlockenable2 = |USBSD_SEL_s1_arb_share_counter_next_value;

  //cpu/data_master USBSD_SEL/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USBSD_SEL_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USBSD_SEL_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USBSD_SEL_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USBSD_SEL_s1 = cpu_data_master_requests_USBSD_SEL_s1;
  //master is always granted when requested
  assign cpu_data_master_granted_USBSD_SEL_s1 = cpu_data_master_qualified_request_USBSD_SEL_s1;

  //cpu/data_master saved-grant USBSD_SEL/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USBSD_SEL_s1 = cpu_data_master_requests_USBSD_SEL_s1;

  //allow new arb cycle for USBSD_SEL/s1, which is an e_assign
  assign USBSD_SEL_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USBSD_SEL_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USBSD_SEL_s1_master_qreq_vector = 1;

  //USBSD_SEL_s1_reset_n assignment, which is an e_assign
  assign USBSD_SEL_s1_reset_n = reset_n;

  //USBSD_SEL_s1_firsttransfer first transaction, which is an e_assign
  assign USBSD_SEL_s1_firsttransfer = USBSD_SEL_s1_begins_xfer ? USBSD_SEL_s1_unreg_firsttransfer : USBSD_SEL_s1_reg_firsttransfer;

  //USBSD_SEL_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USBSD_SEL_s1_unreg_firsttransfer = ~(USBSD_SEL_s1_slavearbiterlockenable & USBSD_SEL_s1_any_continuerequest);

  //USBSD_SEL_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USBSD_SEL_s1_reg_firsttransfer <= 1'b1;
      else if (USBSD_SEL_s1_begins_xfer)
          USBSD_SEL_s1_reg_firsttransfer <= USBSD_SEL_s1_unreg_firsttransfer;
    end


  //USBSD_SEL_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USBSD_SEL_s1_beginbursttransfer_internal = USBSD_SEL_s1_begins_xfer;

  assign shifted_address_to_USBSD_SEL_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USBSD_SEL_s1_address mux, which is an e_mux
  assign USBSD_SEL_s1_address = shifted_address_to_USBSD_SEL_s1_from_cpu_data_master >> 2;

  //d1_USBSD_SEL_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USBSD_SEL_s1_end_xfer <= 1;
      else 
        d1_USBSD_SEL_s1_end_xfer <= USBSD_SEL_s1_end_xfer;
    end


  //USBSD_SEL_s1_waits_for_read in a cycle, which is an e_mux
  assign USBSD_SEL_s1_waits_for_read = USBSD_SEL_s1_in_a_read_cycle & USBSD_SEL_s1_begins_xfer;

  //USBSD_SEL_s1_in_a_read_cycle assignment, which is an e_assign
  assign USBSD_SEL_s1_in_a_read_cycle = cpu_data_master_granted_USBSD_SEL_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USBSD_SEL_s1_in_a_read_cycle;

  //USBSD_SEL_s1_waits_for_write in a cycle, which is an e_mux
  assign USBSD_SEL_s1_waits_for_write = USBSD_SEL_s1_in_a_write_cycle & 0;

  //USBSD_SEL_s1_in_a_write_cycle assignment, which is an e_assign
  assign USBSD_SEL_s1_in_a_write_cycle = cpu_data_master_granted_USBSD_SEL_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USBSD_SEL_s1_in_a_write_cycle;

  assign wait_for_USBSD_SEL_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USBSD_SEL/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USB_EN_s1_arbitrator (
                              // inputs:
                               USB_EN_s1_readdata,
                               clk,
                               cpu_data_master_address_to_slave,
                               cpu_data_master_read,
                               cpu_data_master_write,
                               reset_n,

                              // outputs:
                               USB_EN_s1_address,
                               USB_EN_s1_readdata_from_sa,
                               USB_EN_s1_reset_n,
                               cpu_data_master_granted_USB_EN_s1,
                               cpu_data_master_qualified_request_USB_EN_s1,
                               cpu_data_master_read_data_valid_USB_EN_s1,
                               cpu_data_master_requests_USB_EN_s1,
                               d1_USB_EN_s1_end_xfer
                            )
;

  output  [  1: 0] USB_EN_s1_address;
  output  [ 31: 0] USB_EN_s1_readdata_from_sa;
  output           USB_EN_s1_reset_n;
  output           cpu_data_master_granted_USB_EN_s1;
  output           cpu_data_master_qualified_request_USB_EN_s1;
  output           cpu_data_master_read_data_valid_USB_EN_s1;
  output           cpu_data_master_requests_USB_EN_s1;
  output           d1_USB_EN_s1_end_xfer;
  input   [ 31: 0] USB_EN_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input            reset_n;

  wire    [  1: 0] USB_EN_s1_address;
  wire             USB_EN_s1_allgrants;
  wire             USB_EN_s1_allow_new_arb_cycle;
  wire             USB_EN_s1_any_bursting_master_saved_grant;
  wire             USB_EN_s1_any_continuerequest;
  wire             USB_EN_s1_arb_counter_enable;
  reg     [  1: 0] USB_EN_s1_arb_share_counter;
  wire    [  1: 0] USB_EN_s1_arb_share_counter_next_value;
  wire    [  1: 0] USB_EN_s1_arb_share_set_values;
  wire             USB_EN_s1_beginbursttransfer_internal;
  wire             USB_EN_s1_begins_xfer;
  wire             USB_EN_s1_end_xfer;
  wire             USB_EN_s1_firsttransfer;
  wire             USB_EN_s1_grant_vector;
  wire             USB_EN_s1_in_a_read_cycle;
  wire             USB_EN_s1_in_a_write_cycle;
  wire             USB_EN_s1_master_qreq_vector;
  wire             USB_EN_s1_non_bursting_master_requests;
  wire    [ 31: 0] USB_EN_s1_readdata_from_sa;
  reg              USB_EN_s1_reg_firsttransfer;
  wire             USB_EN_s1_reset_n;
  reg              USB_EN_s1_slavearbiterlockenable;
  wire             USB_EN_s1_slavearbiterlockenable2;
  wire             USB_EN_s1_unreg_firsttransfer;
  wire             USB_EN_s1_waits_for_read;
  wire             USB_EN_s1_waits_for_write;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USB_EN_s1;
  wire             cpu_data_master_qualified_request_USB_EN_s1;
  wire             cpu_data_master_read_data_valid_USB_EN_s1;
  wire             cpu_data_master_requests_USB_EN_s1;
  wire             cpu_data_master_saved_grant_USB_EN_s1;
  reg              d1_USB_EN_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USB_EN_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USB_EN_s1_from_cpu_data_master;
  wire             wait_for_USB_EN_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USB_EN_s1_end_xfer;
    end


  assign USB_EN_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USB_EN_s1));
  //assign USB_EN_s1_readdata_from_sa = USB_EN_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USB_EN_s1_readdata_from_sa = USB_EN_s1_readdata;

  assign cpu_data_master_requests_USB_EN_s1 = (({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18d0) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //USB_EN_s1_arb_share_counter set values, which is an e_mux
  assign USB_EN_s1_arb_share_set_values = 1;

  //USB_EN_s1_non_bursting_master_requests mux, which is an e_mux
  assign USB_EN_s1_non_bursting_master_requests = cpu_data_master_requests_USB_EN_s1;

  //USB_EN_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USB_EN_s1_any_bursting_master_saved_grant = 0;

  //USB_EN_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USB_EN_s1_arb_share_counter_next_value = USB_EN_s1_firsttransfer ? (USB_EN_s1_arb_share_set_values - 1) : |USB_EN_s1_arb_share_counter ? (USB_EN_s1_arb_share_counter - 1) : 0;

  //USB_EN_s1_allgrants all slave grants, which is an e_mux
  assign USB_EN_s1_allgrants = |USB_EN_s1_grant_vector;

  //USB_EN_s1_end_xfer assignment, which is an e_assign
  assign USB_EN_s1_end_xfer = ~(USB_EN_s1_waits_for_read | USB_EN_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USB_EN_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USB_EN_s1 = USB_EN_s1_end_xfer & (~USB_EN_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USB_EN_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USB_EN_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USB_EN_s1 & USB_EN_s1_allgrants) | (end_xfer_arb_share_counter_term_USB_EN_s1 & ~USB_EN_s1_non_bursting_master_requests);

  //USB_EN_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_EN_s1_arb_share_counter <= 0;
      else if (USB_EN_s1_arb_counter_enable)
          USB_EN_s1_arb_share_counter <= USB_EN_s1_arb_share_counter_next_value;
    end


  //USB_EN_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_EN_s1_slavearbiterlockenable <= 0;
      else if ((|USB_EN_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USB_EN_s1) | (end_xfer_arb_share_counter_term_USB_EN_s1 & ~USB_EN_s1_non_bursting_master_requests))
          USB_EN_s1_slavearbiterlockenable <= |USB_EN_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USB_EN/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USB_EN_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USB_EN_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USB_EN_s1_slavearbiterlockenable2 = |USB_EN_s1_arb_share_counter_next_value;

  //cpu/data_master USB_EN/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USB_EN_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USB_EN_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USB_EN_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USB_EN_s1 = cpu_data_master_requests_USB_EN_s1;
  //master is always granted when requested
  assign cpu_data_master_granted_USB_EN_s1 = cpu_data_master_qualified_request_USB_EN_s1;

  //cpu/data_master saved-grant USB_EN/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USB_EN_s1 = cpu_data_master_requests_USB_EN_s1;

  //allow new arb cycle for USB_EN/s1, which is an e_assign
  assign USB_EN_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USB_EN_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USB_EN_s1_master_qreq_vector = 1;

  //USB_EN_s1_reset_n assignment, which is an e_assign
  assign USB_EN_s1_reset_n = reset_n;

  //USB_EN_s1_firsttransfer first transaction, which is an e_assign
  assign USB_EN_s1_firsttransfer = USB_EN_s1_begins_xfer ? USB_EN_s1_unreg_firsttransfer : USB_EN_s1_reg_firsttransfer;

  //USB_EN_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USB_EN_s1_unreg_firsttransfer = ~(USB_EN_s1_slavearbiterlockenable & USB_EN_s1_any_continuerequest);

  //USB_EN_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_EN_s1_reg_firsttransfer <= 1'b1;
      else if (USB_EN_s1_begins_xfer)
          USB_EN_s1_reg_firsttransfer <= USB_EN_s1_unreg_firsttransfer;
    end


  //USB_EN_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USB_EN_s1_beginbursttransfer_internal = USB_EN_s1_begins_xfer;

  assign shifted_address_to_USB_EN_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USB_EN_s1_address mux, which is an e_mux
  assign USB_EN_s1_address = shifted_address_to_USB_EN_s1_from_cpu_data_master >> 2;

  //d1_USB_EN_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USB_EN_s1_end_xfer <= 1;
      else 
        d1_USB_EN_s1_end_xfer <= USB_EN_s1_end_xfer;
    end


  //USB_EN_s1_waits_for_read in a cycle, which is an e_mux
  assign USB_EN_s1_waits_for_read = USB_EN_s1_in_a_read_cycle & USB_EN_s1_begins_xfer;

  //USB_EN_s1_in_a_read_cycle assignment, which is an e_assign
  assign USB_EN_s1_in_a_read_cycle = cpu_data_master_granted_USB_EN_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USB_EN_s1_in_a_read_cycle;

  //USB_EN_s1_waits_for_write in a cycle, which is an e_mux
  assign USB_EN_s1_waits_for_write = USB_EN_s1_in_a_write_cycle & 0;

  //USB_EN_s1_in_a_write_cycle assignment, which is an e_assign
  assign USB_EN_s1_in_a_write_cycle = cpu_data_master_granted_USB_EN_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USB_EN_s1_in_a_write_cycle;

  assign wait_for_USB_EN_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USB_EN/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USB_INT_I_s1_arbitrator (
                                 // inputs:
                                  USB_INT_I_s1_readdata,
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_write,
                                  reset_n,

                                 // outputs:
                                  USB_INT_I_s1_address,
                                  USB_INT_I_s1_readdata_from_sa,
                                  USB_INT_I_s1_reset_n,
                                  cpu_data_master_granted_USB_INT_I_s1,
                                  cpu_data_master_qualified_request_USB_INT_I_s1,
                                  cpu_data_master_read_data_valid_USB_INT_I_s1,
                                  cpu_data_master_requests_USB_INT_I_s1,
                                  d1_USB_INT_I_s1_end_xfer
                               )
;

  output  [  1: 0] USB_INT_I_s1_address;
  output  [ 31: 0] USB_INT_I_s1_readdata_from_sa;
  output           USB_INT_I_s1_reset_n;
  output           cpu_data_master_granted_USB_INT_I_s1;
  output           cpu_data_master_qualified_request_USB_INT_I_s1;
  output           cpu_data_master_read_data_valid_USB_INT_I_s1;
  output           cpu_data_master_requests_USB_INT_I_s1;
  output           d1_USB_INT_I_s1_end_xfer;
  input   [ 31: 0] USB_INT_I_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input            reset_n;

  wire    [  1: 0] USB_INT_I_s1_address;
  wire             USB_INT_I_s1_allgrants;
  wire             USB_INT_I_s1_allow_new_arb_cycle;
  wire             USB_INT_I_s1_any_bursting_master_saved_grant;
  wire             USB_INT_I_s1_any_continuerequest;
  wire             USB_INT_I_s1_arb_counter_enable;
  reg     [  1: 0] USB_INT_I_s1_arb_share_counter;
  wire    [  1: 0] USB_INT_I_s1_arb_share_counter_next_value;
  wire    [  1: 0] USB_INT_I_s1_arb_share_set_values;
  wire             USB_INT_I_s1_beginbursttransfer_internal;
  wire             USB_INT_I_s1_begins_xfer;
  wire             USB_INT_I_s1_end_xfer;
  wire             USB_INT_I_s1_firsttransfer;
  wire             USB_INT_I_s1_grant_vector;
  wire             USB_INT_I_s1_in_a_read_cycle;
  wire             USB_INT_I_s1_in_a_write_cycle;
  wire             USB_INT_I_s1_master_qreq_vector;
  wire             USB_INT_I_s1_non_bursting_master_requests;
  wire    [ 31: 0] USB_INT_I_s1_readdata_from_sa;
  reg              USB_INT_I_s1_reg_firsttransfer;
  wire             USB_INT_I_s1_reset_n;
  reg              USB_INT_I_s1_slavearbiterlockenable;
  wire             USB_INT_I_s1_slavearbiterlockenable2;
  wire             USB_INT_I_s1_unreg_firsttransfer;
  wire             USB_INT_I_s1_waits_for_read;
  wire             USB_INT_I_s1_waits_for_write;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USB_INT_I_s1;
  wire             cpu_data_master_qualified_request_USB_INT_I_s1;
  wire             cpu_data_master_read_data_valid_USB_INT_I_s1;
  wire             cpu_data_master_requests_USB_INT_I_s1;
  wire             cpu_data_master_saved_grant_USB_INT_I_s1;
  reg              d1_USB_INT_I_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USB_INT_I_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USB_INT_I_s1_from_cpu_data_master;
  wire             wait_for_USB_INT_I_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USB_INT_I_s1_end_xfer;
    end


  assign USB_INT_I_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USB_INT_I_s1));
  //assign USB_INT_I_s1_readdata_from_sa = USB_INT_I_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USB_INT_I_s1_readdata_from_sa = USB_INT_I_s1_readdata;

  assign cpu_data_master_requests_USB_INT_I_s1 = (({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h18a0) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //USB_INT_I_s1_arb_share_counter set values, which is an e_mux
  assign USB_INT_I_s1_arb_share_set_values = 1;

  //USB_INT_I_s1_non_bursting_master_requests mux, which is an e_mux
  assign USB_INT_I_s1_non_bursting_master_requests = cpu_data_master_requests_USB_INT_I_s1;

  //USB_INT_I_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USB_INT_I_s1_any_bursting_master_saved_grant = 0;

  //USB_INT_I_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USB_INT_I_s1_arb_share_counter_next_value = USB_INT_I_s1_firsttransfer ? (USB_INT_I_s1_arb_share_set_values - 1) : |USB_INT_I_s1_arb_share_counter ? (USB_INT_I_s1_arb_share_counter - 1) : 0;

  //USB_INT_I_s1_allgrants all slave grants, which is an e_mux
  assign USB_INT_I_s1_allgrants = |USB_INT_I_s1_grant_vector;

  //USB_INT_I_s1_end_xfer assignment, which is an e_assign
  assign USB_INT_I_s1_end_xfer = ~(USB_INT_I_s1_waits_for_read | USB_INT_I_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USB_INT_I_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USB_INT_I_s1 = USB_INT_I_s1_end_xfer & (~USB_INT_I_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USB_INT_I_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USB_INT_I_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USB_INT_I_s1 & USB_INT_I_s1_allgrants) | (end_xfer_arb_share_counter_term_USB_INT_I_s1 & ~USB_INT_I_s1_non_bursting_master_requests);

  //USB_INT_I_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_INT_I_s1_arb_share_counter <= 0;
      else if (USB_INT_I_s1_arb_counter_enable)
          USB_INT_I_s1_arb_share_counter <= USB_INT_I_s1_arb_share_counter_next_value;
    end


  //USB_INT_I_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_INT_I_s1_slavearbiterlockenable <= 0;
      else if ((|USB_INT_I_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USB_INT_I_s1) | (end_xfer_arb_share_counter_term_USB_INT_I_s1 & ~USB_INT_I_s1_non_bursting_master_requests))
          USB_INT_I_s1_slavearbiterlockenable <= |USB_INT_I_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USB_INT_I/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USB_INT_I_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USB_INT_I_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USB_INT_I_s1_slavearbiterlockenable2 = |USB_INT_I_s1_arb_share_counter_next_value;

  //cpu/data_master USB_INT_I/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USB_INT_I_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USB_INT_I_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USB_INT_I_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USB_INT_I_s1 = cpu_data_master_requests_USB_INT_I_s1;
  //master is always granted when requested
  assign cpu_data_master_granted_USB_INT_I_s1 = cpu_data_master_qualified_request_USB_INT_I_s1;

  //cpu/data_master saved-grant USB_INT_I/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USB_INT_I_s1 = cpu_data_master_requests_USB_INT_I_s1;

  //allow new arb cycle for USB_INT_I/s1, which is an e_assign
  assign USB_INT_I_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USB_INT_I_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USB_INT_I_s1_master_qreq_vector = 1;

  //USB_INT_I_s1_reset_n assignment, which is an e_assign
  assign USB_INT_I_s1_reset_n = reset_n;

  //USB_INT_I_s1_firsttransfer first transaction, which is an e_assign
  assign USB_INT_I_s1_firsttransfer = USB_INT_I_s1_begins_xfer ? USB_INT_I_s1_unreg_firsttransfer : USB_INT_I_s1_reg_firsttransfer;

  //USB_INT_I_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USB_INT_I_s1_unreg_firsttransfer = ~(USB_INT_I_s1_slavearbiterlockenable & USB_INT_I_s1_any_continuerequest);

  //USB_INT_I_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_INT_I_s1_reg_firsttransfer <= 1'b1;
      else if (USB_INT_I_s1_begins_xfer)
          USB_INT_I_s1_reg_firsttransfer <= USB_INT_I_s1_unreg_firsttransfer;
    end


  //USB_INT_I_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USB_INT_I_s1_beginbursttransfer_internal = USB_INT_I_s1_begins_xfer;

  assign shifted_address_to_USB_INT_I_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USB_INT_I_s1_address mux, which is an e_mux
  assign USB_INT_I_s1_address = shifted_address_to_USB_INT_I_s1_from_cpu_data_master >> 2;

  //d1_USB_INT_I_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USB_INT_I_s1_end_xfer <= 1;
      else 
        d1_USB_INT_I_s1_end_xfer <= USB_INT_I_s1_end_xfer;
    end


  //USB_INT_I_s1_waits_for_read in a cycle, which is an e_mux
  assign USB_INT_I_s1_waits_for_read = USB_INT_I_s1_in_a_read_cycle & USB_INT_I_s1_begins_xfer;

  //USB_INT_I_s1_in_a_read_cycle assignment, which is an e_assign
  assign USB_INT_I_s1_in_a_read_cycle = cpu_data_master_granted_USB_INT_I_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USB_INT_I_s1_in_a_read_cycle;

  //USB_INT_I_s1_waits_for_write in a cycle, which is an e_mux
  assign USB_INT_I_s1_waits_for_write = USB_INT_I_s1_in_a_write_cycle & 0;

  //USB_INT_I_s1_in_a_write_cycle assignment, which is an e_assign
  assign USB_INT_I_s1_in_a_write_cycle = cpu_data_master_granted_USB_INT_I_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USB_INT_I_s1_in_a_write_cycle;

  assign wait_for_USB_INT_I_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USB_INT_I/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USB_SCK_O_s1_arbitrator (
                                 // inputs:
                                  USB_SCK_O_s1_readdata,
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_waitrequest,
                                  cpu_data_master_write,
                                  cpu_data_master_writedata,
                                  reset_n,

                                 // outputs:
                                  USB_SCK_O_s1_address,
                                  USB_SCK_O_s1_chipselect,
                                  USB_SCK_O_s1_readdata_from_sa,
                                  USB_SCK_O_s1_reset_n,
                                  USB_SCK_O_s1_write_n,
                                  USB_SCK_O_s1_writedata,
                                  cpu_data_master_granted_USB_SCK_O_s1,
                                  cpu_data_master_qualified_request_USB_SCK_O_s1,
                                  cpu_data_master_read_data_valid_USB_SCK_O_s1,
                                  cpu_data_master_requests_USB_SCK_O_s1,
                                  d1_USB_SCK_O_s1_end_xfer
                               )
;

  output  [  1: 0] USB_SCK_O_s1_address;
  output           USB_SCK_O_s1_chipselect;
  output  [ 31: 0] USB_SCK_O_s1_readdata_from_sa;
  output           USB_SCK_O_s1_reset_n;
  output           USB_SCK_O_s1_write_n;
  output  [ 31: 0] USB_SCK_O_s1_writedata;
  output           cpu_data_master_granted_USB_SCK_O_s1;
  output           cpu_data_master_qualified_request_USB_SCK_O_s1;
  output           cpu_data_master_read_data_valid_USB_SCK_O_s1;
  output           cpu_data_master_requests_USB_SCK_O_s1;
  output           d1_USB_SCK_O_s1_end_xfer;
  input   [ 31: 0] USB_SCK_O_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] USB_SCK_O_s1_address;
  wire             USB_SCK_O_s1_allgrants;
  wire             USB_SCK_O_s1_allow_new_arb_cycle;
  wire             USB_SCK_O_s1_any_bursting_master_saved_grant;
  wire             USB_SCK_O_s1_any_continuerequest;
  wire             USB_SCK_O_s1_arb_counter_enable;
  reg     [  1: 0] USB_SCK_O_s1_arb_share_counter;
  wire    [  1: 0] USB_SCK_O_s1_arb_share_counter_next_value;
  wire    [  1: 0] USB_SCK_O_s1_arb_share_set_values;
  wire             USB_SCK_O_s1_beginbursttransfer_internal;
  wire             USB_SCK_O_s1_begins_xfer;
  wire             USB_SCK_O_s1_chipselect;
  wire             USB_SCK_O_s1_end_xfer;
  wire             USB_SCK_O_s1_firsttransfer;
  wire             USB_SCK_O_s1_grant_vector;
  wire             USB_SCK_O_s1_in_a_read_cycle;
  wire             USB_SCK_O_s1_in_a_write_cycle;
  wire             USB_SCK_O_s1_master_qreq_vector;
  wire             USB_SCK_O_s1_non_bursting_master_requests;
  wire    [ 31: 0] USB_SCK_O_s1_readdata_from_sa;
  reg              USB_SCK_O_s1_reg_firsttransfer;
  wire             USB_SCK_O_s1_reset_n;
  reg              USB_SCK_O_s1_slavearbiterlockenable;
  wire             USB_SCK_O_s1_slavearbiterlockenable2;
  wire             USB_SCK_O_s1_unreg_firsttransfer;
  wire             USB_SCK_O_s1_waits_for_read;
  wire             USB_SCK_O_s1_waits_for_write;
  wire             USB_SCK_O_s1_write_n;
  wire    [ 31: 0] USB_SCK_O_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USB_SCK_O_s1;
  wire             cpu_data_master_qualified_request_USB_SCK_O_s1;
  wire             cpu_data_master_read_data_valid_USB_SCK_O_s1;
  wire             cpu_data_master_requests_USB_SCK_O_s1;
  wire             cpu_data_master_saved_grant_USB_SCK_O_s1;
  reg              d1_USB_SCK_O_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USB_SCK_O_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USB_SCK_O_s1_from_cpu_data_master;
  wire             wait_for_USB_SCK_O_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USB_SCK_O_s1_end_xfer;
    end


  assign USB_SCK_O_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USB_SCK_O_s1));
  //assign USB_SCK_O_s1_readdata_from_sa = USB_SCK_O_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USB_SCK_O_s1_readdata_from_sa = USB_SCK_O_s1_readdata;

  assign cpu_data_master_requests_USB_SCK_O_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1890) & (cpu_data_master_read | cpu_data_master_write);
  //USB_SCK_O_s1_arb_share_counter set values, which is an e_mux
  assign USB_SCK_O_s1_arb_share_set_values = 1;

  //USB_SCK_O_s1_non_bursting_master_requests mux, which is an e_mux
  assign USB_SCK_O_s1_non_bursting_master_requests = cpu_data_master_requests_USB_SCK_O_s1;

  //USB_SCK_O_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USB_SCK_O_s1_any_bursting_master_saved_grant = 0;

  //USB_SCK_O_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USB_SCK_O_s1_arb_share_counter_next_value = USB_SCK_O_s1_firsttransfer ? (USB_SCK_O_s1_arb_share_set_values - 1) : |USB_SCK_O_s1_arb_share_counter ? (USB_SCK_O_s1_arb_share_counter - 1) : 0;

  //USB_SCK_O_s1_allgrants all slave grants, which is an e_mux
  assign USB_SCK_O_s1_allgrants = |USB_SCK_O_s1_grant_vector;

  //USB_SCK_O_s1_end_xfer assignment, which is an e_assign
  assign USB_SCK_O_s1_end_xfer = ~(USB_SCK_O_s1_waits_for_read | USB_SCK_O_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USB_SCK_O_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USB_SCK_O_s1 = USB_SCK_O_s1_end_xfer & (~USB_SCK_O_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USB_SCK_O_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USB_SCK_O_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USB_SCK_O_s1 & USB_SCK_O_s1_allgrants) | (end_xfer_arb_share_counter_term_USB_SCK_O_s1 & ~USB_SCK_O_s1_non_bursting_master_requests);

  //USB_SCK_O_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SCK_O_s1_arb_share_counter <= 0;
      else if (USB_SCK_O_s1_arb_counter_enable)
          USB_SCK_O_s1_arb_share_counter <= USB_SCK_O_s1_arb_share_counter_next_value;
    end


  //USB_SCK_O_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SCK_O_s1_slavearbiterlockenable <= 0;
      else if ((|USB_SCK_O_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USB_SCK_O_s1) | (end_xfer_arb_share_counter_term_USB_SCK_O_s1 & ~USB_SCK_O_s1_non_bursting_master_requests))
          USB_SCK_O_s1_slavearbiterlockenable <= |USB_SCK_O_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USB_SCK_O/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USB_SCK_O_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USB_SCK_O_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USB_SCK_O_s1_slavearbiterlockenable2 = |USB_SCK_O_s1_arb_share_counter_next_value;

  //cpu/data_master USB_SCK_O/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USB_SCK_O_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USB_SCK_O_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USB_SCK_O_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USB_SCK_O_s1 = cpu_data_master_requests_USB_SCK_O_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //USB_SCK_O_s1_writedata mux, which is an e_mux
  assign USB_SCK_O_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_USB_SCK_O_s1 = cpu_data_master_qualified_request_USB_SCK_O_s1;

  //cpu/data_master saved-grant USB_SCK_O/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USB_SCK_O_s1 = cpu_data_master_requests_USB_SCK_O_s1;

  //allow new arb cycle for USB_SCK_O/s1, which is an e_assign
  assign USB_SCK_O_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USB_SCK_O_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USB_SCK_O_s1_master_qreq_vector = 1;

  //USB_SCK_O_s1_reset_n assignment, which is an e_assign
  assign USB_SCK_O_s1_reset_n = reset_n;

  assign USB_SCK_O_s1_chipselect = cpu_data_master_granted_USB_SCK_O_s1;
  //USB_SCK_O_s1_firsttransfer first transaction, which is an e_assign
  assign USB_SCK_O_s1_firsttransfer = USB_SCK_O_s1_begins_xfer ? USB_SCK_O_s1_unreg_firsttransfer : USB_SCK_O_s1_reg_firsttransfer;

  //USB_SCK_O_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USB_SCK_O_s1_unreg_firsttransfer = ~(USB_SCK_O_s1_slavearbiterlockenable & USB_SCK_O_s1_any_continuerequest);

  //USB_SCK_O_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SCK_O_s1_reg_firsttransfer <= 1'b1;
      else if (USB_SCK_O_s1_begins_xfer)
          USB_SCK_O_s1_reg_firsttransfer <= USB_SCK_O_s1_unreg_firsttransfer;
    end


  //USB_SCK_O_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USB_SCK_O_s1_beginbursttransfer_internal = USB_SCK_O_s1_begins_xfer;

  //~USB_SCK_O_s1_write_n assignment, which is an e_mux
  assign USB_SCK_O_s1_write_n = ~(cpu_data_master_granted_USB_SCK_O_s1 & cpu_data_master_write);

  assign shifted_address_to_USB_SCK_O_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USB_SCK_O_s1_address mux, which is an e_mux
  assign USB_SCK_O_s1_address = shifted_address_to_USB_SCK_O_s1_from_cpu_data_master >> 2;

  //d1_USB_SCK_O_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USB_SCK_O_s1_end_xfer <= 1;
      else 
        d1_USB_SCK_O_s1_end_xfer <= USB_SCK_O_s1_end_xfer;
    end


  //USB_SCK_O_s1_waits_for_read in a cycle, which is an e_mux
  assign USB_SCK_O_s1_waits_for_read = USB_SCK_O_s1_in_a_read_cycle & USB_SCK_O_s1_begins_xfer;

  //USB_SCK_O_s1_in_a_read_cycle assignment, which is an e_assign
  assign USB_SCK_O_s1_in_a_read_cycle = cpu_data_master_granted_USB_SCK_O_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USB_SCK_O_s1_in_a_read_cycle;

  //USB_SCK_O_s1_waits_for_write in a cycle, which is an e_mux
  assign USB_SCK_O_s1_waits_for_write = USB_SCK_O_s1_in_a_write_cycle & 0;

  //USB_SCK_O_s1_in_a_write_cycle assignment, which is an e_assign
  assign USB_SCK_O_s1_in_a_write_cycle = cpu_data_master_granted_USB_SCK_O_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USB_SCK_O_s1_in_a_write_cycle;

  assign wait_for_USB_SCK_O_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USB_SCK_O/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USB_SCS_O_s1_arbitrator (
                                 // inputs:
                                  USB_SCS_O_s1_readdata,
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_waitrequest,
                                  cpu_data_master_write,
                                  cpu_data_master_writedata,
                                  reset_n,

                                 // outputs:
                                  USB_SCS_O_s1_address,
                                  USB_SCS_O_s1_chipselect,
                                  USB_SCS_O_s1_readdata_from_sa,
                                  USB_SCS_O_s1_reset_n,
                                  USB_SCS_O_s1_write_n,
                                  USB_SCS_O_s1_writedata,
                                  cpu_data_master_granted_USB_SCS_O_s1,
                                  cpu_data_master_qualified_request_USB_SCS_O_s1,
                                  cpu_data_master_read_data_valid_USB_SCS_O_s1,
                                  cpu_data_master_requests_USB_SCS_O_s1,
                                  d1_USB_SCS_O_s1_end_xfer
                               )
;

  output  [  1: 0] USB_SCS_O_s1_address;
  output           USB_SCS_O_s1_chipselect;
  output  [ 31: 0] USB_SCS_O_s1_readdata_from_sa;
  output           USB_SCS_O_s1_reset_n;
  output           USB_SCS_O_s1_write_n;
  output  [ 31: 0] USB_SCS_O_s1_writedata;
  output           cpu_data_master_granted_USB_SCS_O_s1;
  output           cpu_data_master_qualified_request_USB_SCS_O_s1;
  output           cpu_data_master_read_data_valid_USB_SCS_O_s1;
  output           cpu_data_master_requests_USB_SCS_O_s1;
  output           d1_USB_SCS_O_s1_end_xfer;
  input   [ 31: 0] USB_SCS_O_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] USB_SCS_O_s1_address;
  wire             USB_SCS_O_s1_allgrants;
  wire             USB_SCS_O_s1_allow_new_arb_cycle;
  wire             USB_SCS_O_s1_any_bursting_master_saved_grant;
  wire             USB_SCS_O_s1_any_continuerequest;
  wire             USB_SCS_O_s1_arb_counter_enable;
  reg     [  1: 0] USB_SCS_O_s1_arb_share_counter;
  wire    [  1: 0] USB_SCS_O_s1_arb_share_counter_next_value;
  wire    [  1: 0] USB_SCS_O_s1_arb_share_set_values;
  wire             USB_SCS_O_s1_beginbursttransfer_internal;
  wire             USB_SCS_O_s1_begins_xfer;
  wire             USB_SCS_O_s1_chipselect;
  wire             USB_SCS_O_s1_end_xfer;
  wire             USB_SCS_O_s1_firsttransfer;
  wire             USB_SCS_O_s1_grant_vector;
  wire             USB_SCS_O_s1_in_a_read_cycle;
  wire             USB_SCS_O_s1_in_a_write_cycle;
  wire             USB_SCS_O_s1_master_qreq_vector;
  wire             USB_SCS_O_s1_non_bursting_master_requests;
  wire    [ 31: 0] USB_SCS_O_s1_readdata_from_sa;
  reg              USB_SCS_O_s1_reg_firsttransfer;
  wire             USB_SCS_O_s1_reset_n;
  reg              USB_SCS_O_s1_slavearbiterlockenable;
  wire             USB_SCS_O_s1_slavearbiterlockenable2;
  wire             USB_SCS_O_s1_unreg_firsttransfer;
  wire             USB_SCS_O_s1_waits_for_read;
  wire             USB_SCS_O_s1_waits_for_write;
  wire             USB_SCS_O_s1_write_n;
  wire    [ 31: 0] USB_SCS_O_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USB_SCS_O_s1;
  wire             cpu_data_master_qualified_request_USB_SCS_O_s1;
  wire             cpu_data_master_read_data_valid_USB_SCS_O_s1;
  wire             cpu_data_master_requests_USB_SCS_O_s1;
  wire             cpu_data_master_saved_grant_USB_SCS_O_s1;
  reg              d1_USB_SCS_O_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USB_SCS_O_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USB_SCS_O_s1_from_cpu_data_master;
  wire             wait_for_USB_SCS_O_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USB_SCS_O_s1_end_xfer;
    end


  assign USB_SCS_O_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USB_SCS_O_s1));
  //assign USB_SCS_O_s1_readdata_from_sa = USB_SCS_O_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USB_SCS_O_s1_readdata_from_sa = USB_SCS_O_s1_readdata;

  assign cpu_data_master_requests_USB_SCS_O_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1860) & (cpu_data_master_read | cpu_data_master_write);
  //USB_SCS_O_s1_arb_share_counter set values, which is an e_mux
  assign USB_SCS_O_s1_arb_share_set_values = 1;

  //USB_SCS_O_s1_non_bursting_master_requests mux, which is an e_mux
  assign USB_SCS_O_s1_non_bursting_master_requests = cpu_data_master_requests_USB_SCS_O_s1;

  //USB_SCS_O_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USB_SCS_O_s1_any_bursting_master_saved_grant = 0;

  //USB_SCS_O_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USB_SCS_O_s1_arb_share_counter_next_value = USB_SCS_O_s1_firsttransfer ? (USB_SCS_O_s1_arb_share_set_values - 1) : |USB_SCS_O_s1_arb_share_counter ? (USB_SCS_O_s1_arb_share_counter - 1) : 0;

  //USB_SCS_O_s1_allgrants all slave grants, which is an e_mux
  assign USB_SCS_O_s1_allgrants = |USB_SCS_O_s1_grant_vector;

  //USB_SCS_O_s1_end_xfer assignment, which is an e_assign
  assign USB_SCS_O_s1_end_xfer = ~(USB_SCS_O_s1_waits_for_read | USB_SCS_O_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USB_SCS_O_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USB_SCS_O_s1 = USB_SCS_O_s1_end_xfer & (~USB_SCS_O_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USB_SCS_O_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USB_SCS_O_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USB_SCS_O_s1 & USB_SCS_O_s1_allgrants) | (end_xfer_arb_share_counter_term_USB_SCS_O_s1 & ~USB_SCS_O_s1_non_bursting_master_requests);

  //USB_SCS_O_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SCS_O_s1_arb_share_counter <= 0;
      else if (USB_SCS_O_s1_arb_counter_enable)
          USB_SCS_O_s1_arb_share_counter <= USB_SCS_O_s1_arb_share_counter_next_value;
    end


  //USB_SCS_O_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SCS_O_s1_slavearbiterlockenable <= 0;
      else if ((|USB_SCS_O_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USB_SCS_O_s1) | (end_xfer_arb_share_counter_term_USB_SCS_O_s1 & ~USB_SCS_O_s1_non_bursting_master_requests))
          USB_SCS_O_s1_slavearbiterlockenable <= |USB_SCS_O_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USB_SCS_O/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USB_SCS_O_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USB_SCS_O_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USB_SCS_O_s1_slavearbiterlockenable2 = |USB_SCS_O_s1_arb_share_counter_next_value;

  //cpu/data_master USB_SCS_O/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USB_SCS_O_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USB_SCS_O_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USB_SCS_O_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USB_SCS_O_s1 = cpu_data_master_requests_USB_SCS_O_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //USB_SCS_O_s1_writedata mux, which is an e_mux
  assign USB_SCS_O_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_USB_SCS_O_s1 = cpu_data_master_qualified_request_USB_SCS_O_s1;

  //cpu/data_master saved-grant USB_SCS_O/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USB_SCS_O_s1 = cpu_data_master_requests_USB_SCS_O_s1;

  //allow new arb cycle for USB_SCS_O/s1, which is an e_assign
  assign USB_SCS_O_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USB_SCS_O_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USB_SCS_O_s1_master_qreq_vector = 1;

  //USB_SCS_O_s1_reset_n assignment, which is an e_assign
  assign USB_SCS_O_s1_reset_n = reset_n;

  assign USB_SCS_O_s1_chipselect = cpu_data_master_granted_USB_SCS_O_s1;
  //USB_SCS_O_s1_firsttransfer first transaction, which is an e_assign
  assign USB_SCS_O_s1_firsttransfer = USB_SCS_O_s1_begins_xfer ? USB_SCS_O_s1_unreg_firsttransfer : USB_SCS_O_s1_reg_firsttransfer;

  //USB_SCS_O_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USB_SCS_O_s1_unreg_firsttransfer = ~(USB_SCS_O_s1_slavearbiterlockenable & USB_SCS_O_s1_any_continuerequest);

  //USB_SCS_O_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SCS_O_s1_reg_firsttransfer <= 1'b1;
      else if (USB_SCS_O_s1_begins_xfer)
          USB_SCS_O_s1_reg_firsttransfer <= USB_SCS_O_s1_unreg_firsttransfer;
    end


  //USB_SCS_O_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USB_SCS_O_s1_beginbursttransfer_internal = USB_SCS_O_s1_begins_xfer;

  //~USB_SCS_O_s1_write_n assignment, which is an e_mux
  assign USB_SCS_O_s1_write_n = ~(cpu_data_master_granted_USB_SCS_O_s1 & cpu_data_master_write);

  assign shifted_address_to_USB_SCS_O_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USB_SCS_O_s1_address mux, which is an e_mux
  assign USB_SCS_O_s1_address = shifted_address_to_USB_SCS_O_s1_from_cpu_data_master >> 2;

  //d1_USB_SCS_O_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USB_SCS_O_s1_end_xfer <= 1;
      else 
        d1_USB_SCS_O_s1_end_xfer <= USB_SCS_O_s1_end_xfer;
    end


  //USB_SCS_O_s1_waits_for_read in a cycle, which is an e_mux
  assign USB_SCS_O_s1_waits_for_read = USB_SCS_O_s1_in_a_read_cycle & USB_SCS_O_s1_begins_xfer;

  //USB_SCS_O_s1_in_a_read_cycle assignment, which is an e_assign
  assign USB_SCS_O_s1_in_a_read_cycle = cpu_data_master_granted_USB_SCS_O_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USB_SCS_O_s1_in_a_read_cycle;

  //USB_SCS_O_s1_waits_for_write in a cycle, which is an e_mux
  assign USB_SCS_O_s1_waits_for_write = USB_SCS_O_s1_in_a_write_cycle & 0;

  //USB_SCS_O_s1_in_a_write_cycle assignment, which is an e_assign
  assign USB_SCS_O_s1_in_a_write_cycle = cpu_data_master_granted_USB_SCS_O_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USB_SCS_O_s1_in_a_write_cycle;

  assign wait_for_USB_SCS_O_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USB_SCS_O/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USB_SDI_O_s1_arbitrator (
                                 // inputs:
                                  USB_SDI_O_s1_readdata,
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_waitrequest,
                                  cpu_data_master_write,
                                  cpu_data_master_writedata,
                                  reset_n,

                                 // outputs:
                                  USB_SDI_O_s1_address,
                                  USB_SDI_O_s1_chipselect,
                                  USB_SDI_O_s1_readdata_from_sa,
                                  USB_SDI_O_s1_reset_n,
                                  USB_SDI_O_s1_write_n,
                                  USB_SDI_O_s1_writedata,
                                  cpu_data_master_granted_USB_SDI_O_s1,
                                  cpu_data_master_qualified_request_USB_SDI_O_s1,
                                  cpu_data_master_read_data_valid_USB_SDI_O_s1,
                                  cpu_data_master_requests_USB_SDI_O_s1,
                                  d1_USB_SDI_O_s1_end_xfer
                               )
;

  output  [  1: 0] USB_SDI_O_s1_address;
  output           USB_SDI_O_s1_chipselect;
  output  [ 31: 0] USB_SDI_O_s1_readdata_from_sa;
  output           USB_SDI_O_s1_reset_n;
  output           USB_SDI_O_s1_write_n;
  output  [ 31: 0] USB_SDI_O_s1_writedata;
  output           cpu_data_master_granted_USB_SDI_O_s1;
  output           cpu_data_master_qualified_request_USB_SDI_O_s1;
  output           cpu_data_master_read_data_valid_USB_SDI_O_s1;
  output           cpu_data_master_requests_USB_SDI_O_s1;
  output           d1_USB_SDI_O_s1_end_xfer;
  input   [ 31: 0] USB_SDI_O_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            reset_n;

  wire    [  1: 0] USB_SDI_O_s1_address;
  wire             USB_SDI_O_s1_allgrants;
  wire             USB_SDI_O_s1_allow_new_arb_cycle;
  wire             USB_SDI_O_s1_any_bursting_master_saved_grant;
  wire             USB_SDI_O_s1_any_continuerequest;
  wire             USB_SDI_O_s1_arb_counter_enable;
  reg     [  1: 0] USB_SDI_O_s1_arb_share_counter;
  wire    [  1: 0] USB_SDI_O_s1_arb_share_counter_next_value;
  wire    [  1: 0] USB_SDI_O_s1_arb_share_set_values;
  wire             USB_SDI_O_s1_beginbursttransfer_internal;
  wire             USB_SDI_O_s1_begins_xfer;
  wire             USB_SDI_O_s1_chipselect;
  wire             USB_SDI_O_s1_end_xfer;
  wire             USB_SDI_O_s1_firsttransfer;
  wire             USB_SDI_O_s1_grant_vector;
  wire             USB_SDI_O_s1_in_a_read_cycle;
  wire             USB_SDI_O_s1_in_a_write_cycle;
  wire             USB_SDI_O_s1_master_qreq_vector;
  wire             USB_SDI_O_s1_non_bursting_master_requests;
  wire    [ 31: 0] USB_SDI_O_s1_readdata_from_sa;
  reg              USB_SDI_O_s1_reg_firsttransfer;
  wire             USB_SDI_O_s1_reset_n;
  reg              USB_SDI_O_s1_slavearbiterlockenable;
  wire             USB_SDI_O_s1_slavearbiterlockenable2;
  wire             USB_SDI_O_s1_unreg_firsttransfer;
  wire             USB_SDI_O_s1_waits_for_read;
  wire             USB_SDI_O_s1_waits_for_write;
  wire             USB_SDI_O_s1_write_n;
  wire    [ 31: 0] USB_SDI_O_s1_writedata;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USB_SDI_O_s1;
  wire             cpu_data_master_qualified_request_USB_SDI_O_s1;
  wire             cpu_data_master_read_data_valid_USB_SDI_O_s1;
  wire             cpu_data_master_requests_USB_SDI_O_s1;
  wire             cpu_data_master_saved_grant_USB_SDI_O_s1;
  reg              d1_USB_SDI_O_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USB_SDI_O_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USB_SDI_O_s1_from_cpu_data_master;
  wire             wait_for_USB_SDI_O_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USB_SDI_O_s1_end_xfer;
    end


  assign USB_SDI_O_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USB_SDI_O_s1));
  //assign USB_SDI_O_s1_readdata_from_sa = USB_SDI_O_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USB_SDI_O_s1_readdata_from_sa = USB_SDI_O_s1_readdata;

  assign cpu_data_master_requests_USB_SDI_O_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1880) & (cpu_data_master_read | cpu_data_master_write);
  //USB_SDI_O_s1_arb_share_counter set values, which is an e_mux
  assign USB_SDI_O_s1_arb_share_set_values = 1;

  //USB_SDI_O_s1_non_bursting_master_requests mux, which is an e_mux
  assign USB_SDI_O_s1_non_bursting_master_requests = cpu_data_master_requests_USB_SDI_O_s1;

  //USB_SDI_O_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USB_SDI_O_s1_any_bursting_master_saved_grant = 0;

  //USB_SDI_O_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USB_SDI_O_s1_arb_share_counter_next_value = USB_SDI_O_s1_firsttransfer ? (USB_SDI_O_s1_arb_share_set_values - 1) : |USB_SDI_O_s1_arb_share_counter ? (USB_SDI_O_s1_arb_share_counter - 1) : 0;

  //USB_SDI_O_s1_allgrants all slave grants, which is an e_mux
  assign USB_SDI_O_s1_allgrants = |USB_SDI_O_s1_grant_vector;

  //USB_SDI_O_s1_end_xfer assignment, which is an e_assign
  assign USB_SDI_O_s1_end_xfer = ~(USB_SDI_O_s1_waits_for_read | USB_SDI_O_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USB_SDI_O_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USB_SDI_O_s1 = USB_SDI_O_s1_end_xfer & (~USB_SDI_O_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USB_SDI_O_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USB_SDI_O_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USB_SDI_O_s1 & USB_SDI_O_s1_allgrants) | (end_xfer_arb_share_counter_term_USB_SDI_O_s1 & ~USB_SDI_O_s1_non_bursting_master_requests);

  //USB_SDI_O_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SDI_O_s1_arb_share_counter <= 0;
      else if (USB_SDI_O_s1_arb_counter_enable)
          USB_SDI_O_s1_arb_share_counter <= USB_SDI_O_s1_arb_share_counter_next_value;
    end


  //USB_SDI_O_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SDI_O_s1_slavearbiterlockenable <= 0;
      else if ((|USB_SDI_O_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USB_SDI_O_s1) | (end_xfer_arb_share_counter_term_USB_SDI_O_s1 & ~USB_SDI_O_s1_non_bursting_master_requests))
          USB_SDI_O_s1_slavearbiterlockenable <= |USB_SDI_O_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USB_SDI_O/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USB_SDI_O_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USB_SDI_O_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USB_SDI_O_s1_slavearbiterlockenable2 = |USB_SDI_O_s1_arb_share_counter_next_value;

  //cpu/data_master USB_SDI_O/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USB_SDI_O_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USB_SDI_O_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USB_SDI_O_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USB_SDI_O_s1 = cpu_data_master_requests_USB_SDI_O_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //USB_SDI_O_s1_writedata mux, which is an e_mux
  assign USB_SDI_O_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_USB_SDI_O_s1 = cpu_data_master_qualified_request_USB_SDI_O_s1;

  //cpu/data_master saved-grant USB_SDI_O/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USB_SDI_O_s1 = cpu_data_master_requests_USB_SDI_O_s1;

  //allow new arb cycle for USB_SDI_O/s1, which is an e_assign
  assign USB_SDI_O_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USB_SDI_O_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USB_SDI_O_s1_master_qreq_vector = 1;

  //USB_SDI_O_s1_reset_n assignment, which is an e_assign
  assign USB_SDI_O_s1_reset_n = reset_n;

  assign USB_SDI_O_s1_chipselect = cpu_data_master_granted_USB_SDI_O_s1;
  //USB_SDI_O_s1_firsttransfer first transaction, which is an e_assign
  assign USB_SDI_O_s1_firsttransfer = USB_SDI_O_s1_begins_xfer ? USB_SDI_O_s1_unreg_firsttransfer : USB_SDI_O_s1_reg_firsttransfer;

  //USB_SDI_O_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USB_SDI_O_s1_unreg_firsttransfer = ~(USB_SDI_O_s1_slavearbiterlockenable & USB_SDI_O_s1_any_continuerequest);

  //USB_SDI_O_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SDI_O_s1_reg_firsttransfer <= 1'b1;
      else if (USB_SDI_O_s1_begins_xfer)
          USB_SDI_O_s1_reg_firsttransfer <= USB_SDI_O_s1_unreg_firsttransfer;
    end


  //USB_SDI_O_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USB_SDI_O_s1_beginbursttransfer_internal = USB_SDI_O_s1_begins_xfer;

  //~USB_SDI_O_s1_write_n assignment, which is an e_mux
  assign USB_SDI_O_s1_write_n = ~(cpu_data_master_granted_USB_SDI_O_s1 & cpu_data_master_write);

  assign shifted_address_to_USB_SDI_O_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USB_SDI_O_s1_address mux, which is an e_mux
  assign USB_SDI_O_s1_address = shifted_address_to_USB_SDI_O_s1_from_cpu_data_master >> 2;

  //d1_USB_SDI_O_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USB_SDI_O_s1_end_xfer <= 1;
      else 
        d1_USB_SDI_O_s1_end_xfer <= USB_SDI_O_s1_end_xfer;
    end


  //USB_SDI_O_s1_waits_for_read in a cycle, which is an e_mux
  assign USB_SDI_O_s1_waits_for_read = USB_SDI_O_s1_in_a_read_cycle & USB_SDI_O_s1_begins_xfer;

  //USB_SDI_O_s1_in_a_read_cycle assignment, which is an e_assign
  assign USB_SDI_O_s1_in_a_read_cycle = cpu_data_master_granted_USB_SDI_O_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USB_SDI_O_s1_in_a_read_cycle;

  //USB_SDI_O_s1_waits_for_write in a cycle, which is an e_mux
  assign USB_SDI_O_s1_waits_for_write = USB_SDI_O_s1_in_a_write_cycle & 0;

  //USB_SDI_O_s1_in_a_write_cycle assignment, which is an e_assign
  assign USB_SDI_O_s1_in_a_write_cycle = cpu_data_master_granted_USB_SDI_O_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USB_SDI_O_s1_in_a_write_cycle;

  assign wait_for_USB_SDI_O_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USB_SDI_O/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module USB_SDO_I_s1_arbitrator (
                                 // inputs:
                                  USB_SDO_I_s1_readdata,
                                  clk,
                                  cpu_data_master_address_to_slave,
                                  cpu_data_master_read,
                                  cpu_data_master_write,
                                  reset_n,

                                 // outputs:
                                  USB_SDO_I_s1_address,
                                  USB_SDO_I_s1_readdata_from_sa,
                                  USB_SDO_I_s1_reset_n,
                                  cpu_data_master_granted_USB_SDO_I_s1,
                                  cpu_data_master_qualified_request_USB_SDO_I_s1,
                                  cpu_data_master_read_data_valid_USB_SDO_I_s1,
                                  cpu_data_master_requests_USB_SDO_I_s1,
                                  d1_USB_SDO_I_s1_end_xfer
                               )
;

  output  [  1: 0] USB_SDO_I_s1_address;
  output  [ 31: 0] USB_SDO_I_s1_readdata_from_sa;
  output           USB_SDO_I_s1_reset_n;
  output           cpu_data_master_granted_USB_SDO_I_s1;
  output           cpu_data_master_qualified_request_USB_SDO_I_s1;
  output           cpu_data_master_read_data_valid_USB_SDO_I_s1;
  output           cpu_data_master_requests_USB_SDO_I_s1;
  output           d1_USB_SDO_I_s1_end_xfer;
  input   [ 31: 0] USB_SDO_I_s1_readdata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input            reset_n;

  wire    [  1: 0] USB_SDO_I_s1_address;
  wire             USB_SDO_I_s1_allgrants;
  wire             USB_SDO_I_s1_allow_new_arb_cycle;
  wire             USB_SDO_I_s1_any_bursting_master_saved_grant;
  wire             USB_SDO_I_s1_any_continuerequest;
  wire             USB_SDO_I_s1_arb_counter_enable;
  reg     [  1: 0] USB_SDO_I_s1_arb_share_counter;
  wire    [  1: 0] USB_SDO_I_s1_arb_share_counter_next_value;
  wire    [  1: 0] USB_SDO_I_s1_arb_share_set_values;
  wire             USB_SDO_I_s1_beginbursttransfer_internal;
  wire             USB_SDO_I_s1_begins_xfer;
  wire             USB_SDO_I_s1_end_xfer;
  wire             USB_SDO_I_s1_firsttransfer;
  wire             USB_SDO_I_s1_grant_vector;
  wire             USB_SDO_I_s1_in_a_read_cycle;
  wire             USB_SDO_I_s1_in_a_write_cycle;
  wire             USB_SDO_I_s1_master_qreq_vector;
  wire             USB_SDO_I_s1_non_bursting_master_requests;
  wire    [ 31: 0] USB_SDO_I_s1_readdata_from_sa;
  reg              USB_SDO_I_s1_reg_firsttransfer;
  wire             USB_SDO_I_s1_reset_n;
  reg              USB_SDO_I_s1_slavearbiterlockenable;
  wire             USB_SDO_I_s1_slavearbiterlockenable2;
  wire             USB_SDO_I_s1_unreg_firsttransfer;
  wire             USB_SDO_I_s1_waits_for_read;
  wire             USB_SDO_I_s1_waits_for_write;
  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_USB_SDO_I_s1;
  wire             cpu_data_master_qualified_request_USB_SDO_I_s1;
  wire             cpu_data_master_read_data_valid_USB_SDO_I_s1;
  wire             cpu_data_master_requests_USB_SDO_I_s1;
  wire             cpu_data_master_saved_grant_USB_SDO_I_s1;
  reg              d1_USB_SDO_I_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_USB_SDO_I_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_USB_SDO_I_s1_from_cpu_data_master;
  wire             wait_for_USB_SDO_I_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~USB_SDO_I_s1_end_xfer;
    end


  assign USB_SDO_I_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_USB_SDO_I_s1));
  //assign USB_SDO_I_s1_readdata_from_sa = USB_SDO_I_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign USB_SDO_I_s1_readdata_from_sa = USB_SDO_I_s1_readdata;

  assign cpu_data_master_requests_USB_SDO_I_s1 = (({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1870) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //USB_SDO_I_s1_arb_share_counter set values, which is an e_mux
  assign USB_SDO_I_s1_arb_share_set_values = 1;

  //USB_SDO_I_s1_non_bursting_master_requests mux, which is an e_mux
  assign USB_SDO_I_s1_non_bursting_master_requests = cpu_data_master_requests_USB_SDO_I_s1;

  //USB_SDO_I_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign USB_SDO_I_s1_any_bursting_master_saved_grant = 0;

  //USB_SDO_I_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign USB_SDO_I_s1_arb_share_counter_next_value = USB_SDO_I_s1_firsttransfer ? (USB_SDO_I_s1_arb_share_set_values - 1) : |USB_SDO_I_s1_arb_share_counter ? (USB_SDO_I_s1_arb_share_counter - 1) : 0;

  //USB_SDO_I_s1_allgrants all slave grants, which is an e_mux
  assign USB_SDO_I_s1_allgrants = |USB_SDO_I_s1_grant_vector;

  //USB_SDO_I_s1_end_xfer assignment, which is an e_assign
  assign USB_SDO_I_s1_end_xfer = ~(USB_SDO_I_s1_waits_for_read | USB_SDO_I_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_USB_SDO_I_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_USB_SDO_I_s1 = USB_SDO_I_s1_end_xfer & (~USB_SDO_I_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //USB_SDO_I_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign USB_SDO_I_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_USB_SDO_I_s1 & USB_SDO_I_s1_allgrants) | (end_xfer_arb_share_counter_term_USB_SDO_I_s1 & ~USB_SDO_I_s1_non_bursting_master_requests);

  //USB_SDO_I_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SDO_I_s1_arb_share_counter <= 0;
      else if (USB_SDO_I_s1_arb_counter_enable)
          USB_SDO_I_s1_arb_share_counter <= USB_SDO_I_s1_arb_share_counter_next_value;
    end


  //USB_SDO_I_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SDO_I_s1_slavearbiterlockenable <= 0;
      else if ((|USB_SDO_I_s1_master_qreq_vector & end_xfer_arb_share_counter_term_USB_SDO_I_s1) | (end_xfer_arb_share_counter_term_USB_SDO_I_s1 & ~USB_SDO_I_s1_non_bursting_master_requests))
          USB_SDO_I_s1_slavearbiterlockenable <= |USB_SDO_I_s1_arb_share_counter_next_value;
    end


  //cpu/data_master USB_SDO_I/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = USB_SDO_I_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //USB_SDO_I_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign USB_SDO_I_s1_slavearbiterlockenable2 = |USB_SDO_I_s1_arb_share_counter_next_value;

  //cpu/data_master USB_SDO_I/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = USB_SDO_I_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //USB_SDO_I_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign USB_SDO_I_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_USB_SDO_I_s1 = cpu_data_master_requests_USB_SDO_I_s1;
  //master is always granted when requested
  assign cpu_data_master_granted_USB_SDO_I_s1 = cpu_data_master_qualified_request_USB_SDO_I_s1;

  //cpu/data_master saved-grant USB_SDO_I/s1, which is an e_assign
  assign cpu_data_master_saved_grant_USB_SDO_I_s1 = cpu_data_master_requests_USB_SDO_I_s1;

  //allow new arb cycle for USB_SDO_I/s1, which is an e_assign
  assign USB_SDO_I_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign USB_SDO_I_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign USB_SDO_I_s1_master_qreq_vector = 1;

  //USB_SDO_I_s1_reset_n assignment, which is an e_assign
  assign USB_SDO_I_s1_reset_n = reset_n;

  //USB_SDO_I_s1_firsttransfer first transaction, which is an e_assign
  assign USB_SDO_I_s1_firsttransfer = USB_SDO_I_s1_begins_xfer ? USB_SDO_I_s1_unreg_firsttransfer : USB_SDO_I_s1_reg_firsttransfer;

  //USB_SDO_I_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign USB_SDO_I_s1_unreg_firsttransfer = ~(USB_SDO_I_s1_slavearbiterlockenable & USB_SDO_I_s1_any_continuerequest);

  //USB_SDO_I_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          USB_SDO_I_s1_reg_firsttransfer <= 1'b1;
      else if (USB_SDO_I_s1_begins_xfer)
          USB_SDO_I_s1_reg_firsttransfer <= USB_SDO_I_s1_unreg_firsttransfer;
    end


  //USB_SDO_I_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign USB_SDO_I_s1_beginbursttransfer_internal = USB_SDO_I_s1_begins_xfer;

  assign shifted_address_to_USB_SDO_I_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //USB_SDO_I_s1_address mux, which is an e_mux
  assign USB_SDO_I_s1_address = shifted_address_to_USB_SDO_I_s1_from_cpu_data_master >> 2;

  //d1_USB_SDO_I_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_USB_SDO_I_s1_end_xfer <= 1;
      else 
        d1_USB_SDO_I_s1_end_xfer <= USB_SDO_I_s1_end_xfer;
    end


  //USB_SDO_I_s1_waits_for_read in a cycle, which is an e_mux
  assign USB_SDO_I_s1_waits_for_read = USB_SDO_I_s1_in_a_read_cycle & USB_SDO_I_s1_begins_xfer;

  //USB_SDO_I_s1_in_a_read_cycle assignment, which is an e_assign
  assign USB_SDO_I_s1_in_a_read_cycle = cpu_data_master_granted_USB_SDO_I_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = USB_SDO_I_s1_in_a_read_cycle;

  //USB_SDO_I_s1_waits_for_write in a cycle, which is an e_mux
  assign USB_SDO_I_s1_waits_for_write = USB_SDO_I_s1_in_a_write_cycle & 0;

  //USB_SDO_I_s1_in_a_write_cycle assignment, which is an e_assign
  assign USB_SDO_I_s1_in_a_write_cycle = cpu_data_master_granted_USB_SDO_I_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = USB_SDO_I_s1_in_a_write_cycle;

  assign wait_for_USB_SDO_I_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //USB_SDO_I/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_jtag_debug_module_arbitrator (
                                          // inputs:
                                           clk,
                                           cpu_data_master_address_to_slave,
                                           cpu_data_master_byteenable,
                                           cpu_data_master_debugaccess,
                                           cpu_data_master_read,
                                           cpu_data_master_waitrequest,
                                           cpu_data_master_write,
                                           cpu_data_master_writedata,
                                           cpu_instruction_master_address_to_slave,
                                           cpu_instruction_master_latency_counter,
                                           cpu_instruction_master_read,
                                           cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                           cpu_jtag_debug_module_readdata,
                                           cpu_jtag_debug_module_resetrequest,
                                           reset_n,

                                          // outputs:
                                           cpu_data_master_granted_cpu_jtag_debug_module,
                                           cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_data_master_requests_cpu_jtag_debug_module,
                                           cpu_instruction_master_granted_cpu_jtag_debug_module,
                                           cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                           cpu_instruction_master_requests_cpu_jtag_debug_module,
                                           cpu_jtag_debug_module_address,
                                           cpu_jtag_debug_module_begintransfer,
                                           cpu_jtag_debug_module_byteenable,
                                           cpu_jtag_debug_module_chipselect,
                                           cpu_jtag_debug_module_debugaccess,
                                           cpu_jtag_debug_module_readdata_from_sa,
                                           cpu_jtag_debug_module_reset_n,
                                           cpu_jtag_debug_module_resetrequest_from_sa,
                                           cpu_jtag_debug_module_write,
                                           cpu_jtag_debug_module_writedata,
                                           d1_cpu_jtag_debug_module_end_xfer
                                        )
;

  output           cpu_data_master_granted_cpu_jtag_debug_module;
  output           cpu_data_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_data_master_requests_cpu_jtag_debug_module;
  output           cpu_instruction_master_granted_cpu_jtag_debug_module;
  output           cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  output           cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  output           cpu_instruction_master_requests_cpu_jtag_debug_module;
  output  [  8: 0] cpu_jtag_debug_module_address;
  output           cpu_jtag_debug_module_begintransfer;
  output  [  3: 0] cpu_jtag_debug_module_byteenable;
  output           cpu_jtag_debug_module_chipselect;
  output           cpu_jtag_debug_module_debugaccess;
  output  [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  output           cpu_jtag_debug_module_reset_n;
  output           cpu_jtag_debug_module_resetrequest_from_sa;
  output           cpu_jtag_debug_module_write;
  output  [ 31: 0] cpu_jtag_debug_module_writedata;
  output           d1_cpu_jtag_debug_module_end_xfer;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input            cpu_data_master_debugaccess;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input   [ 31: 0] cpu_jtag_debug_module_readdata;
  input            cpu_jtag_debug_module_resetrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_saved_grant_cpu_jtag_debug_module;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_saved_grant_cpu_jtag_debug_module;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_allgrants;
  wire             cpu_jtag_debug_module_allow_new_arb_cycle;
  wire             cpu_jtag_debug_module_any_bursting_master_saved_grant;
  wire             cpu_jtag_debug_module_any_continuerequest;
  reg     [  1: 0] cpu_jtag_debug_module_arb_addend;
  wire             cpu_jtag_debug_module_arb_counter_enable;
  reg     [  1: 0] cpu_jtag_debug_module_arb_share_counter;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_counter_next_value;
  wire    [  1: 0] cpu_jtag_debug_module_arb_share_set_values;
  wire    [  1: 0] cpu_jtag_debug_module_arb_winner;
  wire             cpu_jtag_debug_module_arbitration_holdoff_internal;
  wire             cpu_jtag_debug_module_beginbursttransfer_internal;
  wire             cpu_jtag_debug_module_begins_xfer;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire    [  3: 0] cpu_jtag_debug_module_chosen_master_double_vector;
  wire    [  1: 0] cpu_jtag_debug_module_chosen_master_rot_left;
  wire             cpu_jtag_debug_module_debugaccess;
  wire             cpu_jtag_debug_module_end_xfer;
  wire             cpu_jtag_debug_module_firsttransfer;
  wire    [  1: 0] cpu_jtag_debug_module_grant_vector;
  wire             cpu_jtag_debug_module_in_a_read_cycle;
  wire             cpu_jtag_debug_module_in_a_write_cycle;
  wire    [  1: 0] cpu_jtag_debug_module_master_qreq_vector;
  wire             cpu_jtag_debug_module_non_bursting_master_requests;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  reg              cpu_jtag_debug_module_reg_firsttransfer;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  reg     [  1: 0] cpu_jtag_debug_module_saved_chosen_master_vector;
  reg              cpu_jtag_debug_module_slavearbiterlockenable;
  wire             cpu_jtag_debug_module_slavearbiterlockenable2;
  wire             cpu_jtag_debug_module_unreg_firsttransfer;
  wire             cpu_jtag_debug_module_waits_for_read;
  wire             cpu_jtag_debug_module_waits_for_write;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  reg              d1_cpu_jtag_debug_module_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_cpu_jtag_debug_module;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
  reg              last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
  wire    [ 26: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master;
  wire             wait_for_cpu_jtag_debug_module_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~cpu_jtag_debug_module_end_xfer;
    end


  assign cpu_jtag_debug_module_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_cpu_jtag_debug_module | cpu_instruction_master_qualified_request_cpu_jtag_debug_module));
  //assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_readdata_from_sa = cpu_jtag_debug_module_readdata;

  assign cpu_data_master_requests_cpu_jtag_debug_module = ({cpu_data_master_address_to_slave[26 : 11] , 11'b0} == 27'h1000) & (cpu_data_master_read | cpu_data_master_write);
  //cpu_jtag_debug_module_arb_share_counter set values, which is an e_mux
  assign cpu_jtag_debug_module_arb_share_set_values = 1;

  //cpu_jtag_debug_module_non_bursting_master_requests mux, which is an e_mux
  assign cpu_jtag_debug_module_non_bursting_master_requests = cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module |
    cpu_data_master_requests_cpu_jtag_debug_module |
    cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_bursting_master_saved_grant mux, which is an e_mux
  assign cpu_jtag_debug_module_any_bursting_master_saved_grant = 0;

  //cpu_jtag_debug_module_arb_share_counter_next_value assignment, which is an e_assign
  assign cpu_jtag_debug_module_arb_share_counter_next_value = cpu_jtag_debug_module_firsttransfer ? (cpu_jtag_debug_module_arb_share_set_values - 1) : |cpu_jtag_debug_module_arb_share_counter ? (cpu_jtag_debug_module_arb_share_counter - 1) : 0;

  //cpu_jtag_debug_module_allgrants all slave grants, which is an e_mux
  assign cpu_jtag_debug_module_allgrants = (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector) |
    (|cpu_jtag_debug_module_grant_vector);

  //cpu_jtag_debug_module_end_xfer assignment, which is an e_assign
  assign cpu_jtag_debug_module_end_xfer = ~(cpu_jtag_debug_module_waits_for_read | cpu_jtag_debug_module_waits_for_write);

  //end_xfer_arb_share_counter_term_cpu_jtag_debug_module arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_cpu_jtag_debug_module = cpu_jtag_debug_module_end_xfer & (~cpu_jtag_debug_module_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //cpu_jtag_debug_module_arb_share_counter arbitration counter enable, which is an e_assign
  assign cpu_jtag_debug_module_arb_counter_enable = (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & cpu_jtag_debug_module_allgrants) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests);

  //cpu_jtag_debug_module_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_share_counter <= 0;
      else if (cpu_jtag_debug_module_arb_counter_enable)
          cpu_jtag_debug_module_arb_share_counter <= cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu_jtag_debug_module_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_slavearbiterlockenable <= 0;
      else if ((|cpu_jtag_debug_module_master_qreq_vector & end_xfer_arb_share_counter_term_cpu_jtag_debug_module) | (end_xfer_arb_share_counter_term_cpu_jtag_debug_module & ~cpu_jtag_debug_module_non_bursting_master_requests))
          cpu_jtag_debug_module_slavearbiterlockenable <= |cpu_jtag_debug_module_arb_share_counter_next_value;
    end


  //cpu/data_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_data_master_continuerequest;

  //cpu_jtag_debug_module_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign cpu_jtag_debug_module_slavearbiterlockenable2 = |cpu_jtag_debug_module_arb_share_counter_next_value;

  //cpu/data_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = cpu_jtag_debug_module_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master cpu/jtag_debug_module arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = cpu_jtag_debug_module_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module <= cpu_instruction_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_instruction_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_cpu_jtag_debug_module & cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu_jtag_debug_module_any_continuerequest at least one master continues requesting, which is an e_mux
  assign cpu_jtag_debug_module_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_cpu_jtag_debug_module = cpu_data_master_requests_cpu_jtag_debug_module & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //cpu_jtag_debug_module_writedata mux, which is an e_mux
  assign cpu_jtag_debug_module_writedata = cpu_data_master_writedata;

  assign cpu_instruction_master_requests_cpu_jtag_debug_module = (({cpu_instruction_master_address_to_slave[26 : 11] , 11'b0} == 27'h1000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted cpu/jtag_debug_module last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module <= cpu_data_master_saved_grant_cpu_jtag_debug_module ? 1 : (cpu_jtag_debug_module_arbitration_holdoff_internal | ~cpu_data_master_requests_cpu_jtag_debug_module) ? 0 : last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_cpu_jtag_debug_module & cpu_data_master_requests_cpu_jtag_debug_module;

  assign cpu_instruction_master_qualified_request_cpu_jtag_debug_module = cpu_instruction_master_requests_cpu_jtag_debug_module & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (|cpu_instruction_master_read_data_valid_sdram_s1_shift_register))) | cpu_data_master_arbiterlock);
  //local readdatavalid cpu_instruction_master_read_data_valid_cpu_jtag_debug_module, which is an e_mux
  assign cpu_instruction_master_read_data_valid_cpu_jtag_debug_module = cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read & ~cpu_jtag_debug_module_waits_for_read;

  //allow new arb cycle for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[0] = cpu_instruction_master_qualified_request_cpu_jtag_debug_module;

  //cpu/instruction_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[0];

  //cpu/instruction_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_instruction_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[0] && cpu_instruction_master_requests_cpu_jtag_debug_module;

  //cpu/data_master assignment into master qualified-requests vector for cpu/jtag_debug_module, which is an e_assign
  assign cpu_jtag_debug_module_master_qreq_vector[1] = cpu_data_master_qualified_request_cpu_jtag_debug_module;

  //cpu/data_master grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_granted_cpu_jtag_debug_module = cpu_jtag_debug_module_grant_vector[1];

  //cpu/data_master saved-grant cpu/jtag_debug_module, which is an e_assign
  assign cpu_data_master_saved_grant_cpu_jtag_debug_module = cpu_jtag_debug_module_arb_winner[1] && cpu_data_master_requests_cpu_jtag_debug_module;

  //cpu/jtag_debug_module chosen-master double-vector, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_double_vector = {cpu_jtag_debug_module_master_qreq_vector, cpu_jtag_debug_module_master_qreq_vector} & ({~cpu_jtag_debug_module_master_qreq_vector, ~cpu_jtag_debug_module_master_qreq_vector} + cpu_jtag_debug_module_arb_addend);

  //stable onehot encoding of arb winner
  assign cpu_jtag_debug_module_arb_winner = (cpu_jtag_debug_module_allow_new_arb_cycle & | cpu_jtag_debug_module_grant_vector) ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;

  //saved cpu_jtag_debug_module_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_saved_chosen_master_vector <= 0;
      else if (cpu_jtag_debug_module_allow_new_arb_cycle)
          cpu_jtag_debug_module_saved_chosen_master_vector <= |cpu_jtag_debug_module_grant_vector ? cpu_jtag_debug_module_grant_vector : cpu_jtag_debug_module_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign cpu_jtag_debug_module_grant_vector = {(cpu_jtag_debug_module_chosen_master_double_vector[1] | cpu_jtag_debug_module_chosen_master_double_vector[3]),
    (cpu_jtag_debug_module_chosen_master_double_vector[0] | cpu_jtag_debug_module_chosen_master_double_vector[2])};

  //cpu/jtag_debug_module chosen master rotated left, which is an e_assign
  assign cpu_jtag_debug_module_chosen_master_rot_left = (cpu_jtag_debug_module_arb_winner << 1) ? (cpu_jtag_debug_module_arb_winner << 1) : 1;

  //cpu/jtag_debug_module's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_arb_addend <= 1;
      else if (|cpu_jtag_debug_module_grant_vector)
          cpu_jtag_debug_module_arb_addend <= cpu_jtag_debug_module_end_xfer? cpu_jtag_debug_module_chosen_master_rot_left : cpu_jtag_debug_module_grant_vector;
    end


  assign cpu_jtag_debug_module_begintransfer = cpu_jtag_debug_module_begins_xfer;
  //cpu_jtag_debug_module_reset_n assignment, which is an e_assign
  assign cpu_jtag_debug_module_reset_n = reset_n;

  //assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign cpu_jtag_debug_module_resetrequest_from_sa = cpu_jtag_debug_module_resetrequest;

  assign cpu_jtag_debug_module_chipselect = cpu_data_master_granted_cpu_jtag_debug_module | cpu_instruction_master_granted_cpu_jtag_debug_module;
  //cpu_jtag_debug_module_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_firsttransfer = cpu_jtag_debug_module_begins_xfer ? cpu_jtag_debug_module_unreg_firsttransfer : cpu_jtag_debug_module_reg_firsttransfer;

  //cpu_jtag_debug_module_unreg_firsttransfer first transaction, which is an e_assign
  assign cpu_jtag_debug_module_unreg_firsttransfer = ~(cpu_jtag_debug_module_slavearbiterlockenable & cpu_jtag_debug_module_any_continuerequest);

  //cpu_jtag_debug_module_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_jtag_debug_module_reg_firsttransfer <= 1'b1;
      else if (cpu_jtag_debug_module_begins_xfer)
          cpu_jtag_debug_module_reg_firsttransfer <= cpu_jtag_debug_module_unreg_firsttransfer;
    end


  //cpu_jtag_debug_module_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign cpu_jtag_debug_module_beginbursttransfer_internal = cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign cpu_jtag_debug_module_arbitration_holdoff_internal = cpu_jtag_debug_module_begins_xfer & cpu_jtag_debug_module_firsttransfer;

  //cpu_jtag_debug_module_write assignment, which is an e_mux
  assign cpu_jtag_debug_module_write = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master = cpu_data_master_address_to_slave;
  //cpu_jtag_debug_module_address mux, which is an e_mux
  assign cpu_jtag_debug_module_address = (cpu_data_master_granted_cpu_jtag_debug_module)? (shifted_address_to_cpu_jtag_debug_module_from_cpu_data_master >> 2) :
    (shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master >> 2);

  assign shifted_address_to_cpu_jtag_debug_module_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_cpu_jtag_debug_module_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_cpu_jtag_debug_module_end_xfer <= 1;
      else 
        d1_cpu_jtag_debug_module_end_xfer <= cpu_jtag_debug_module_end_xfer;
    end


  //cpu_jtag_debug_module_waits_for_read in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_read = cpu_jtag_debug_module_in_a_read_cycle & cpu_jtag_debug_module_begins_xfer;

  //cpu_jtag_debug_module_in_a_read_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_read_cycle = (cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_read) | (cpu_instruction_master_granted_cpu_jtag_debug_module & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = cpu_jtag_debug_module_in_a_read_cycle;

  //cpu_jtag_debug_module_waits_for_write in a cycle, which is an e_mux
  assign cpu_jtag_debug_module_waits_for_write = cpu_jtag_debug_module_in_a_write_cycle & 0;

  //cpu_jtag_debug_module_in_a_write_cycle assignment, which is an e_assign
  assign cpu_jtag_debug_module_in_a_write_cycle = cpu_data_master_granted_cpu_jtag_debug_module & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = cpu_jtag_debug_module_in_a_write_cycle;

  assign wait_for_cpu_jtag_debug_module_counter = 0;
  //cpu_jtag_debug_module_byteenable byte enable port mux, which is an e_mux
  assign cpu_jtag_debug_module_byteenable = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_byteenable :
    -1;

  //debugaccess mux, which is an e_mux
  assign cpu_jtag_debug_module_debugaccess = (cpu_data_master_granted_cpu_jtag_debug_module)? cpu_data_master_debugaccess :
    0;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu/jtag_debug_module enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_cpu_jtag_debug_module + cpu_instruction_master_granted_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_cpu_jtag_debug_module + cpu_instruction_master_saved_grant_cpu_jtag_debug_module > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_data_master_arbitrator (
                                    // inputs:
                                     LAN_CS_s1_readdata_from_sa,
                                     LAN_RSTN_s1_readdata_from_sa,
                                     LAN_nINT_s1_readdata_from_sa,
                                     LAN_spi_control_port_irq_from_sa,
                                     LAN_spi_control_port_readdata_from_sa,
                                     NET_EN_s1_readdata_from_sa,
                                     NET_TESTDO_s1_readdata_from_sa,
                                     USBSD_RDO_s1_readdata_from_sa,
                                     USBSD_RVLD_s1_readdata_from_sa,
                                     USBSD_SEL_s1_readdata_from_sa,
                                     USB_EN_s1_readdata_from_sa,
                                     USB_INT_I_s1_readdata_from_sa,
                                     USB_SCK_O_s1_readdata_from_sa,
                                     USB_SCS_O_s1_readdata_from_sa,
                                     USB_SDI_O_s1_readdata_from_sa,
                                     USB_SDO_I_s1_readdata_from_sa,
                                     clk,
                                     cpu_data_master_address,
                                     cpu_data_master_byteenable_sdram_s1,
                                     cpu_data_master_granted_LAN_CS_s1,
                                     cpu_data_master_granted_LAN_RSTN_s1,
                                     cpu_data_master_granted_LAN_nINT_s1,
                                     cpu_data_master_granted_LAN_spi_control_port,
                                     cpu_data_master_granted_NET_EN_s1,
                                     cpu_data_master_granted_NET_TESTDO_s1,
                                     cpu_data_master_granted_USBSD_RDO_s1,
                                     cpu_data_master_granted_USBSD_RVLD_s1,
                                     cpu_data_master_granted_USBSD_SEL_s1,
                                     cpu_data_master_granted_USB_EN_s1,
                                     cpu_data_master_granted_USB_INT_I_s1,
                                     cpu_data_master_granted_USB_SCK_O_s1,
                                     cpu_data_master_granted_USB_SCS_O_s1,
                                     cpu_data_master_granted_USB_SDI_O_s1,
                                     cpu_data_master_granted_USB_SDO_I_s1,
                                     cpu_data_master_granted_cpu_jtag_debug_module,
                                     cpu_data_master_granted_epcs_epcs_control_port,
                                     cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_granted_pio_led_s1,
                                     cpu_data_master_granted_sdram_s1,
                                     cpu_data_master_granted_sysid_control_slave,
                                     cpu_data_master_qualified_request_LAN_CS_s1,
                                     cpu_data_master_qualified_request_LAN_RSTN_s1,
                                     cpu_data_master_qualified_request_LAN_nINT_s1,
                                     cpu_data_master_qualified_request_LAN_spi_control_port,
                                     cpu_data_master_qualified_request_NET_EN_s1,
                                     cpu_data_master_qualified_request_NET_TESTDO_s1,
                                     cpu_data_master_qualified_request_USBSD_RDO_s1,
                                     cpu_data_master_qualified_request_USBSD_RVLD_s1,
                                     cpu_data_master_qualified_request_USBSD_SEL_s1,
                                     cpu_data_master_qualified_request_USB_EN_s1,
                                     cpu_data_master_qualified_request_USB_INT_I_s1,
                                     cpu_data_master_qualified_request_USB_SCK_O_s1,
                                     cpu_data_master_qualified_request_USB_SCS_O_s1,
                                     cpu_data_master_qualified_request_USB_SDI_O_s1,
                                     cpu_data_master_qualified_request_USB_SDO_I_s1,
                                     cpu_data_master_qualified_request_cpu_jtag_debug_module,
                                     cpu_data_master_qualified_request_epcs_epcs_control_port,
                                     cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_qualified_request_pio_led_s1,
                                     cpu_data_master_qualified_request_sdram_s1,
                                     cpu_data_master_qualified_request_sysid_control_slave,
                                     cpu_data_master_read,
                                     cpu_data_master_read_data_valid_LAN_CS_s1,
                                     cpu_data_master_read_data_valid_LAN_RSTN_s1,
                                     cpu_data_master_read_data_valid_LAN_nINT_s1,
                                     cpu_data_master_read_data_valid_LAN_spi_control_port,
                                     cpu_data_master_read_data_valid_NET_EN_s1,
                                     cpu_data_master_read_data_valid_NET_TESTDO_s1,
                                     cpu_data_master_read_data_valid_USBSD_RDO_s1,
                                     cpu_data_master_read_data_valid_USBSD_RVLD_s1,
                                     cpu_data_master_read_data_valid_USBSD_SEL_s1,
                                     cpu_data_master_read_data_valid_USB_EN_s1,
                                     cpu_data_master_read_data_valid_USB_INT_I_s1,
                                     cpu_data_master_read_data_valid_USB_SCK_O_s1,
                                     cpu_data_master_read_data_valid_USB_SCS_O_s1,
                                     cpu_data_master_read_data_valid_USB_SDI_O_s1,
                                     cpu_data_master_read_data_valid_USB_SDO_I_s1,
                                     cpu_data_master_read_data_valid_cpu_jtag_debug_module,
                                     cpu_data_master_read_data_valid_epcs_epcs_control_port,
                                     cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_read_data_valid_pio_led_s1,
                                     cpu_data_master_read_data_valid_sdram_s1,
                                     cpu_data_master_read_data_valid_sdram_s1_shift_register,
                                     cpu_data_master_read_data_valid_sysid_control_slave,
                                     cpu_data_master_requests_LAN_CS_s1,
                                     cpu_data_master_requests_LAN_RSTN_s1,
                                     cpu_data_master_requests_LAN_nINT_s1,
                                     cpu_data_master_requests_LAN_spi_control_port,
                                     cpu_data_master_requests_NET_EN_s1,
                                     cpu_data_master_requests_NET_TESTDO_s1,
                                     cpu_data_master_requests_USBSD_RDO_s1,
                                     cpu_data_master_requests_USBSD_RVLD_s1,
                                     cpu_data_master_requests_USBSD_SEL_s1,
                                     cpu_data_master_requests_USB_EN_s1,
                                     cpu_data_master_requests_USB_INT_I_s1,
                                     cpu_data_master_requests_USB_SCK_O_s1,
                                     cpu_data_master_requests_USB_SCS_O_s1,
                                     cpu_data_master_requests_USB_SDI_O_s1,
                                     cpu_data_master_requests_USB_SDO_I_s1,
                                     cpu_data_master_requests_cpu_jtag_debug_module,
                                     cpu_data_master_requests_epcs_epcs_control_port,
                                     cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                     cpu_data_master_requests_pio_led_s1,
                                     cpu_data_master_requests_sdram_s1,
                                     cpu_data_master_requests_sysid_control_slave,
                                     cpu_data_master_write,
                                     cpu_data_master_writedata,
                                     cpu_jtag_debug_module_readdata_from_sa,
                                     d1_LAN_CS_s1_end_xfer,
                                     d1_LAN_RSTN_s1_end_xfer,
                                     d1_LAN_nINT_s1_end_xfer,
                                     d1_LAN_spi_control_port_end_xfer,
                                     d1_NET_EN_s1_end_xfer,
                                     d1_NET_TESTDO_s1_end_xfer,
                                     d1_USBSD_RDO_s1_end_xfer,
                                     d1_USBSD_RVLD_s1_end_xfer,
                                     d1_USBSD_SEL_s1_end_xfer,
                                     d1_USB_EN_s1_end_xfer,
                                     d1_USB_INT_I_s1_end_xfer,
                                     d1_USB_SCK_O_s1_end_xfer,
                                     d1_USB_SCS_O_s1_end_xfer,
                                     d1_USB_SDI_O_s1_end_xfer,
                                     d1_USB_SDO_I_s1_end_xfer,
                                     d1_cpu_jtag_debug_module_end_xfer,
                                     d1_epcs_epcs_control_port_end_xfer,
                                     d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                     d1_pio_led_s1_end_xfer,
                                     d1_sdram_s1_end_xfer,
                                     d1_sysid_control_slave_end_xfer,
                                     epcs_epcs_control_port_irq_from_sa,
                                     epcs_epcs_control_port_readdata_from_sa,
                                     jtag_uart_avalon_jtag_slave_irq_from_sa,
                                     jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                     jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                     pio_led_s1_readdata_from_sa,
                                     reset_n,
                                     sdram_s1_readdata_from_sa,
                                     sdram_s1_waitrequest_from_sa,
                                     sysid_control_slave_readdata_from_sa,

                                    // outputs:
                                     cpu_data_master_address_to_slave,
                                     cpu_data_master_dbs_address,
                                     cpu_data_master_dbs_write_16,
                                     cpu_data_master_irq,
                                     cpu_data_master_no_byte_enables_and_last_term,
                                     cpu_data_master_readdata,
                                     cpu_data_master_waitrequest
                                  )
;

  output  [ 26: 0] cpu_data_master_address_to_slave;
  output  [  1: 0] cpu_data_master_dbs_address;
  output  [ 15: 0] cpu_data_master_dbs_write_16;
  output  [ 31: 0] cpu_data_master_irq;
  output           cpu_data_master_no_byte_enables_and_last_term;
  output  [ 31: 0] cpu_data_master_readdata;
  output           cpu_data_master_waitrequest;
  input   [ 31: 0] LAN_CS_s1_readdata_from_sa;
  input   [ 31: 0] LAN_RSTN_s1_readdata_from_sa;
  input   [ 31: 0] LAN_nINT_s1_readdata_from_sa;
  input            LAN_spi_control_port_irq_from_sa;
  input   [ 15: 0] LAN_spi_control_port_readdata_from_sa;
  input   [ 31: 0] NET_EN_s1_readdata_from_sa;
  input   [ 31: 0] NET_TESTDO_s1_readdata_from_sa;
  input   [ 31: 0] USBSD_RDO_s1_readdata_from_sa;
  input   [ 31: 0] USBSD_RVLD_s1_readdata_from_sa;
  input   [ 31: 0] USBSD_SEL_s1_readdata_from_sa;
  input   [ 31: 0] USB_EN_s1_readdata_from_sa;
  input   [ 31: 0] USB_INT_I_s1_readdata_from_sa;
  input   [ 31: 0] USB_SCK_O_s1_readdata_from_sa;
  input   [ 31: 0] USB_SCS_O_s1_readdata_from_sa;
  input   [ 31: 0] USB_SDI_O_s1_readdata_from_sa;
  input   [ 31: 0] USB_SDO_I_s1_readdata_from_sa;
  input            clk;
  input   [ 26: 0] cpu_data_master_address;
  input   [  1: 0] cpu_data_master_byteenable_sdram_s1;
  input            cpu_data_master_granted_LAN_CS_s1;
  input            cpu_data_master_granted_LAN_RSTN_s1;
  input            cpu_data_master_granted_LAN_nINT_s1;
  input            cpu_data_master_granted_LAN_spi_control_port;
  input            cpu_data_master_granted_NET_EN_s1;
  input            cpu_data_master_granted_NET_TESTDO_s1;
  input            cpu_data_master_granted_USBSD_RDO_s1;
  input            cpu_data_master_granted_USBSD_RVLD_s1;
  input            cpu_data_master_granted_USBSD_SEL_s1;
  input            cpu_data_master_granted_USB_EN_s1;
  input            cpu_data_master_granted_USB_INT_I_s1;
  input            cpu_data_master_granted_USB_SCK_O_s1;
  input            cpu_data_master_granted_USB_SCS_O_s1;
  input            cpu_data_master_granted_USB_SDI_O_s1;
  input            cpu_data_master_granted_USB_SDO_I_s1;
  input            cpu_data_master_granted_cpu_jtag_debug_module;
  input            cpu_data_master_granted_epcs_epcs_control_port;
  input            cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_granted_pio_led_s1;
  input            cpu_data_master_granted_sdram_s1;
  input            cpu_data_master_granted_sysid_control_slave;
  input            cpu_data_master_qualified_request_LAN_CS_s1;
  input            cpu_data_master_qualified_request_LAN_RSTN_s1;
  input            cpu_data_master_qualified_request_LAN_nINT_s1;
  input            cpu_data_master_qualified_request_LAN_spi_control_port;
  input            cpu_data_master_qualified_request_NET_EN_s1;
  input            cpu_data_master_qualified_request_NET_TESTDO_s1;
  input            cpu_data_master_qualified_request_USBSD_RDO_s1;
  input            cpu_data_master_qualified_request_USBSD_RVLD_s1;
  input            cpu_data_master_qualified_request_USBSD_SEL_s1;
  input            cpu_data_master_qualified_request_USB_EN_s1;
  input            cpu_data_master_qualified_request_USB_INT_I_s1;
  input            cpu_data_master_qualified_request_USB_SCK_O_s1;
  input            cpu_data_master_qualified_request_USB_SCS_O_s1;
  input            cpu_data_master_qualified_request_USB_SDI_O_s1;
  input            cpu_data_master_qualified_request_USB_SDO_I_s1;
  input            cpu_data_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_data_master_qualified_request_epcs_epcs_control_port;
  input            cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_qualified_request_pio_led_s1;
  input            cpu_data_master_qualified_request_sdram_s1;
  input            cpu_data_master_qualified_request_sysid_control_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_read_data_valid_LAN_CS_s1;
  input            cpu_data_master_read_data_valid_LAN_RSTN_s1;
  input            cpu_data_master_read_data_valid_LAN_nINT_s1;
  input            cpu_data_master_read_data_valid_LAN_spi_control_port;
  input            cpu_data_master_read_data_valid_NET_EN_s1;
  input            cpu_data_master_read_data_valid_NET_TESTDO_s1;
  input            cpu_data_master_read_data_valid_USBSD_RDO_s1;
  input            cpu_data_master_read_data_valid_USBSD_RVLD_s1;
  input            cpu_data_master_read_data_valid_USBSD_SEL_s1;
  input            cpu_data_master_read_data_valid_USB_EN_s1;
  input            cpu_data_master_read_data_valid_USB_INT_I_s1;
  input            cpu_data_master_read_data_valid_USB_SCK_O_s1;
  input            cpu_data_master_read_data_valid_USB_SCS_O_s1;
  input            cpu_data_master_read_data_valid_USB_SDI_O_s1;
  input            cpu_data_master_read_data_valid_USB_SDO_I_s1;
  input            cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_data_master_read_data_valid_epcs_epcs_control_port;
  input            cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_read_data_valid_pio_led_s1;
  input            cpu_data_master_read_data_valid_sdram_s1;
  input            cpu_data_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_data_master_read_data_valid_sysid_control_slave;
  input            cpu_data_master_requests_LAN_CS_s1;
  input            cpu_data_master_requests_LAN_RSTN_s1;
  input            cpu_data_master_requests_LAN_nINT_s1;
  input            cpu_data_master_requests_LAN_spi_control_port;
  input            cpu_data_master_requests_NET_EN_s1;
  input            cpu_data_master_requests_NET_TESTDO_s1;
  input            cpu_data_master_requests_USBSD_RDO_s1;
  input            cpu_data_master_requests_USBSD_RVLD_s1;
  input            cpu_data_master_requests_USBSD_SEL_s1;
  input            cpu_data_master_requests_USB_EN_s1;
  input            cpu_data_master_requests_USB_INT_I_s1;
  input            cpu_data_master_requests_USB_SCK_O_s1;
  input            cpu_data_master_requests_USB_SCS_O_s1;
  input            cpu_data_master_requests_USB_SDI_O_s1;
  input            cpu_data_master_requests_USB_SDO_I_s1;
  input            cpu_data_master_requests_cpu_jtag_debug_module;
  input            cpu_data_master_requests_epcs_epcs_control_port;
  input            cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  input            cpu_data_master_requests_pio_led_s1;
  input            cpu_data_master_requests_sdram_s1;
  input            cpu_data_master_requests_sysid_control_slave;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_LAN_CS_s1_end_xfer;
  input            d1_LAN_RSTN_s1_end_xfer;
  input            d1_LAN_nINT_s1_end_xfer;
  input            d1_LAN_spi_control_port_end_xfer;
  input            d1_NET_EN_s1_end_xfer;
  input            d1_NET_TESTDO_s1_end_xfer;
  input            d1_USBSD_RDO_s1_end_xfer;
  input            d1_USBSD_RVLD_s1_end_xfer;
  input            d1_USBSD_SEL_s1_end_xfer;
  input            d1_USB_EN_s1_end_xfer;
  input            d1_USB_INT_I_s1_end_xfer;
  input            d1_USB_SCK_O_s1_end_xfer;
  input            d1_USB_SCS_O_s1_end_xfer;
  input            d1_USB_SDI_O_s1_end_xfer;
  input            d1_USB_SDO_I_s1_end_xfer;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_epcs_epcs_control_port_end_xfer;
  input            d1_jtag_uart_avalon_jtag_slave_end_xfer;
  input            d1_pio_led_s1_end_xfer;
  input            d1_sdram_s1_end_xfer;
  input            d1_sysid_control_slave_end_xfer;
  input            epcs_epcs_control_port_irq_from_sa;
  input   [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  input            jtag_uart_avalon_jtag_slave_irq_from_sa;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  input            jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  input   [ 31: 0] pio_led_s1_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata_from_sa;
  input            sdram_s1_waitrequest_from_sa;
  input   [ 31: 0] sysid_control_slave_readdata_from_sa;

  wire    [ 26: 0] cpu_data_master_address_to_slave;
  reg     [  1: 0] cpu_data_master_dbs_address;
  wire    [  1: 0] cpu_data_master_dbs_increment;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire    [ 31: 0] cpu_data_master_irq;
  reg              cpu_data_master_no_byte_enables_and_last_term;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_run;
  reg              cpu_data_master_waitrequest;
  reg     [ 15: 0] dbs_16_reg_segment_0;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  wire             last_dbs_term_and_run;
  wire    [  1: 0] next_dbs_address;
  wire    [ 15: 0] p1_dbs_16_reg_segment_0;
  wire    [ 31: 0] p1_registered_cpu_data_master_readdata;
  wire             pre_dbs_count_enable;
  wire             r_0;
  wire             r_1;
  wire             r_2;
  wire             r_3;
  reg     [ 31: 0] registered_cpu_data_master_readdata;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & ((~cpu_data_master_qualified_request_LAN_spi_control_port | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_LAN_spi_control_port | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_LAN_CS_s1 | ~cpu_data_master_requests_LAN_CS_s1) & ((~cpu_data_master_qualified_request_LAN_CS_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_LAN_CS_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_LAN_RSTN_s1 | ~cpu_data_master_requests_LAN_RSTN_s1) & ((~cpu_data_master_qualified_request_LAN_RSTN_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_LAN_RSTN_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_LAN_nINT_s1 | ~cpu_data_master_requests_LAN_nINT_s1) & ((~cpu_data_master_qualified_request_LAN_nINT_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_LAN_nINT_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_NET_EN_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_NET_EN_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_NET_TESTDO_s1 | ~cpu_data_master_requests_NET_TESTDO_s1);

  //cascaded wait assignment, which is an e_assign
  assign cpu_data_master_run = r_0 & r_1 & r_2 & r_3;

  //r_1 master_run cascaded wait assignment, which is an e_assign
  assign r_1 = ((~cpu_data_master_qualified_request_NET_TESTDO_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_NET_TESTDO_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_USBSD_RDO_s1 | ~cpu_data_master_requests_USBSD_RDO_s1) & ((~cpu_data_master_qualified_request_USBSD_RDO_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USBSD_RDO_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_USBSD_RVLD_s1 | ~cpu_data_master_requests_USBSD_RVLD_s1) & ((~cpu_data_master_qualified_request_USBSD_RVLD_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USBSD_RVLD_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_USBSD_SEL_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USBSD_SEL_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_USB_EN_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USB_EN_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_USB_INT_I_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USB_INT_I_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1;

  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = (cpu_data_master_qualified_request_USB_SCK_O_s1 | ~cpu_data_master_requests_USB_SCK_O_s1) & ((~cpu_data_master_qualified_request_USB_SCK_O_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USB_SCK_O_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_USB_SCS_O_s1 | ~cpu_data_master_requests_USB_SCS_O_s1) & ((~cpu_data_master_qualified_request_USB_SCS_O_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USB_SCS_O_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_USB_SDI_O_s1 | ~cpu_data_master_requests_USB_SDI_O_s1) & ((~cpu_data_master_qualified_request_USB_SDI_O_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USB_SDI_O_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_USB_SDO_I_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_USB_SDO_I_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_requests_cpu_jtag_debug_module) & (cpu_data_master_granted_cpu_jtag_debug_module | ~cpu_data_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_cpu_jtag_debug_module | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1;

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = (cpu_data_master_qualified_request_epcs_epcs_control_port | ~cpu_data_master_requests_epcs_epcs_control_port) & (cpu_data_master_granted_epcs_epcs_control_port | ~cpu_data_master_qualified_request_epcs_epcs_control_port) & ((~cpu_data_master_qualified_request_epcs_epcs_control_port | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_epcs_epcs_control_port | ~(cpu_data_master_read | cpu_data_master_write) | (1 & 1 & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~cpu_data_master_requests_jtag_uart_avalon_jtag_slave) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & ((~cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave | ~(cpu_data_master_read | cpu_data_master_write) | (1 & ~jtag_uart_avalon_jtag_slave_waitrequest_from_sa & (cpu_data_master_read | cpu_data_master_write)))) & 1 & (cpu_data_master_qualified_request_pio_led_s1 | ~cpu_data_master_requests_pio_led_s1) & ((~cpu_data_master_qualified_request_pio_led_s1 | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_pio_led_s1 | ~cpu_data_master_write | (1 & cpu_data_master_write))) & 1 & (cpu_data_master_qualified_request_sdram_s1 | (cpu_data_master_read_data_valid_sdram_s1 & cpu_data_master_dbs_address[1]) | (cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1 & cpu_data_master_dbs_address[1]) | ~cpu_data_master_requests_sdram_s1) & (cpu_data_master_granted_sdram_s1 | ~cpu_data_master_qualified_request_sdram_s1) & ((~cpu_data_master_qualified_request_sdram_s1 | ~cpu_data_master_read | (cpu_data_master_read_data_valid_sdram_s1 & (cpu_data_master_dbs_address[1]) & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sdram_s1 | ~cpu_data_master_write | (1 & ~sdram_s1_waitrequest_from_sa & (cpu_data_master_dbs_address[1]) & cpu_data_master_write))) & 1 & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_read | (1 & 1 & cpu_data_master_read))) & ((~cpu_data_master_qualified_request_sysid_control_slave | ~cpu_data_master_write | (1 & cpu_data_master_write)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_data_master_address_to_slave = {cpu_data_master_address[26],
    1'b0,
    cpu_data_master_address[24 : 0]};

  //cpu/data_master readdata mux, which is an e_mux
  assign cpu_data_master_readdata = ({32 {~cpu_data_master_requests_LAN_spi_control_port}} | LAN_spi_control_port_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_LAN_CS_s1}} | LAN_CS_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_LAN_RSTN_s1}} | LAN_RSTN_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_LAN_nINT_s1}} | LAN_nINT_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_NET_EN_s1}} | NET_EN_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_NET_TESTDO_s1}} | NET_TESTDO_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USBSD_RDO_s1}} | USBSD_RDO_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USBSD_RVLD_s1}} | USBSD_RVLD_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USBSD_SEL_s1}} | USBSD_SEL_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USB_EN_s1}} | USB_EN_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USB_INT_I_s1}} | USB_INT_I_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USB_SCK_O_s1}} | USB_SCK_O_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USB_SCS_O_s1}} | USB_SCS_O_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USB_SDI_O_s1}} | USB_SDI_O_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_USB_SDO_I_s1}} | USB_SDO_I_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_cpu_jtag_debug_module}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_epcs_epcs_control_port}} | epcs_epcs_control_port_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_jtag_uart_avalon_jtag_slave}} | registered_cpu_data_master_readdata) &
    ({32 {~cpu_data_master_requests_pio_led_s1}} | pio_led_s1_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_sdram_s1}} | registered_cpu_data_master_readdata) &
    ({32 {~cpu_data_master_requests_sysid_control_slave}} | sysid_control_slave_readdata_from_sa);

  //actual waitrequest port, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_waitrequest <= ~0;
      else 
        cpu_data_master_waitrequest <= ~((~(cpu_data_master_read | cpu_data_master_write))? 0: (cpu_data_master_run & cpu_data_master_waitrequest));
    end


  //irq assign, which is an e_assign
  assign cpu_data_master_irq = {1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    1'b0,
    LAN_spi_control_port_irq_from_sa,
    jtag_uart_avalon_jtag_slave_irq_from_sa,
    epcs_epcs_control_port_irq_from_sa};

  //unpredictable registered wait state incoming data, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          registered_cpu_data_master_readdata <= 0;
      else 
        registered_cpu_data_master_readdata <= p1_registered_cpu_data_master_readdata;
    end


  //registered readdata mux, which is an e_mux
  assign p1_registered_cpu_data_master_readdata = ({32 {~cpu_data_master_requests_jtag_uart_avalon_jtag_slave}} | jtag_uart_avalon_jtag_slave_readdata_from_sa) &
    ({32 {~cpu_data_master_requests_sdram_s1}} | {sdram_s1_readdata_from_sa[15 : 0],
    dbs_16_reg_segment_0});

  //no_byte_enables_and_last_term, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_no_byte_enables_and_last_term <= 0;
      else 
        cpu_data_master_no_byte_enables_and_last_term <= last_dbs_term_and_run;
    end


  //compute the last dbs term, which is an e_mux
  assign last_dbs_term_and_run = (cpu_data_master_dbs_address == 2'b10) & cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1;

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = (((~cpu_data_master_no_byte_enables_and_last_term) & cpu_data_master_requests_sdram_s1 & cpu_data_master_write & !cpu_data_master_byteenable_sdram_s1)) |
    cpu_data_master_read_data_valid_sdram_s1 |
    (cpu_data_master_granted_sdram_s1 & cpu_data_master_write & 1 & 1 & ~sdram_s1_waitrequest_from_sa);

  //input to dbs-16 stored 0, which is an e_mux
  assign p1_dbs_16_reg_segment_0 = sdram_s1_readdata_from_sa;

  //dbs register for dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_16_reg_segment_0 <= 0;
      else if (dbs_count_enable & ((cpu_data_master_dbs_address[1]) == 0))
          dbs_16_reg_segment_0 <= p1_dbs_16_reg_segment_0;
    end


  //mux write dbs 1, which is an e_mux
  assign cpu_data_master_dbs_write_16 = (cpu_data_master_dbs_address[1])? cpu_data_master_writedata[31 : 16] :
    cpu_data_master_writedata[15 : 0];

  //dbs count increment, which is an e_mux
  assign cpu_data_master_dbs_increment = (cpu_data_master_requests_sdram_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_data_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_data_master_dbs_address + cpu_data_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable &
    (~(cpu_data_master_requests_sdram_s1 & ~cpu_data_master_waitrequest));

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_data_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_data_master_dbs_address <= next_dbs_address;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cpu_instruction_master_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_instruction_master_address,
                                            cpu_instruction_master_granted_cpu_jtag_debug_module,
                                            cpu_instruction_master_granted_epcs_epcs_control_port,
                                            cpu_instruction_master_granted_sdram_s1,
                                            cpu_instruction_master_qualified_request_cpu_jtag_debug_module,
                                            cpu_instruction_master_qualified_request_epcs_epcs_control_port,
                                            cpu_instruction_master_qualified_request_sdram_s1,
                                            cpu_instruction_master_read,
                                            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module,
                                            cpu_instruction_master_read_data_valid_epcs_epcs_control_port,
                                            cpu_instruction_master_read_data_valid_sdram_s1,
                                            cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                            cpu_instruction_master_requests_cpu_jtag_debug_module,
                                            cpu_instruction_master_requests_epcs_epcs_control_port,
                                            cpu_instruction_master_requests_sdram_s1,
                                            cpu_jtag_debug_module_readdata_from_sa,
                                            d1_cpu_jtag_debug_module_end_xfer,
                                            d1_epcs_epcs_control_port_end_xfer,
                                            d1_sdram_s1_end_xfer,
                                            epcs_epcs_control_port_readdata_from_sa,
                                            reset_n,
                                            sdram_s1_readdata_from_sa,
                                            sdram_s1_waitrequest_from_sa,

                                           // outputs:
                                            cpu_instruction_master_address_to_slave,
                                            cpu_instruction_master_dbs_address,
                                            cpu_instruction_master_latency_counter,
                                            cpu_instruction_master_readdata,
                                            cpu_instruction_master_readdatavalid,
                                            cpu_instruction_master_waitrequest
                                         )
;

  output  [ 26: 0] cpu_instruction_master_address_to_slave;
  output  [  1: 0] cpu_instruction_master_dbs_address;
  output           cpu_instruction_master_latency_counter;
  output  [ 31: 0] cpu_instruction_master_readdata;
  output           cpu_instruction_master_readdatavalid;
  output           cpu_instruction_master_waitrequest;
  input            clk;
  input   [ 26: 0] cpu_instruction_master_address;
  input            cpu_instruction_master_granted_cpu_jtag_debug_module;
  input            cpu_instruction_master_granted_epcs_epcs_control_port;
  input            cpu_instruction_master_granted_sdram_s1;
  input            cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  input            cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  input            cpu_instruction_master_qualified_request_sdram_s1;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  input            cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  input            cpu_instruction_master_read_data_valid_sdram_s1;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input            cpu_instruction_master_requests_cpu_jtag_debug_module;
  input            cpu_instruction_master_requests_epcs_epcs_control_port;
  input            cpu_instruction_master_requests_sdram_s1;
  input   [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  input            d1_cpu_jtag_debug_module_end_xfer;
  input            d1_epcs_epcs_control_port_end_xfer;
  input            d1_sdram_s1_end_xfer;
  input   [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata_from_sa;
  input            sdram_s1_waitrequest_from_sa;

  reg              active_and_waiting_last_time;
  reg     [ 26: 0] cpu_instruction_master_address_last_time;
  wire    [ 26: 0] cpu_instruction_master_address_to_slave;
  reg     [  1: 0] cpu_instruction_master_dbs_address;
  wire    [  1: 0] cpu_instruction_master_dbs_increment;
  reg     [  1: 0] cpu_instruction_master_dbs_rdv_counter;
  wire    [  1: 0] cpu_instruction_master_dbs_rdv_counter_inc;
  wire             cpu_instruction_master_is_granted_some_slave;
  reg              cpu_instruction_master_latency_counter;
  wire    [  1: 0] cpu_instruction_master_next_dbs_rdv_counter;
  reg              cpu_instruction_master_read_but_no_slave_selected;
  reg              cpu_instruction_master_read_last_time;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_run;
  wire             cpu_instruction_master_waitrequest;
  wire             dbs_count_enable;
  wire             dbs_counter_overflow;
  reg     [ 15: 0] dbs_latent_16_reg_segment_0;
  wire             dbs_rdv_count_enable;
  wire             dbs_rdv_counter_overflow;
  wire             latency_load_value;
  wire    [  1: 0] next_dbs_address;
  wire             p1_cpu_instruction_master_latency_counter;
  wire    [ 15: 0] p1_dbs_latent_16_reg_segment_0;
  wire             pre_dbs_count_enable;
  wire             pre_flush_cpu_instruction_master_readdatavalid;
  wire             r_2;
  wire             r_3;
  //r_2 master_run cascaded wait assignment, which is an e_assign
  assign r_2 = 1 & (cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_requests_cpu_jtag_debug_module) & (cpu_instruction_master_granted_cpu_jtag_debug_module | ~cpu_instruction_master_qualified_request_cpu_jtag_debug_module) & ((~cpu_instruction_master_qualified_request_cpu_jtag_debug_module | ~cpu_instruction_master_read | (1 & ~d1_cpu_jtag_debug_module_end_xfer & cpu_instruction_master_read)));

  //cascaded wait assignment, which is an e_assign
  assign cpu_instruction_master_run = r_2 & r_3;

  //r_3 master_run cascaded wait assignment, which is an e_assign
  assign r_3 = 1 & (cpu_instruction_master_qualified_request_epcs_epcs_control_port | ~cpu_instruction_master_requests_epcs_epcs_control_port) & (cpu_instruction_master_granted_epcs_epcs_control_port | ~cpu_instruction_master_qualified_request_epcs_epcs_control_port) & ((~cpu_instruction_master_qualified_request_epcs_epcs_control_port | ~(cpu_instruction_master_read) | (1 & ~d1_epcs_epcs_control_port_end_xfer & (cpu_instruction_master_read)))) & 1 & (cpu_instruction_master_qualified_request_sdram_s1 | ~cpu_instruction_master_requests_sdram_s1) & (cpu_instruction_master_granted_sdram_s1 | ~cpu_instruction_master_qualified_request_sdram_s1) & ((~cpu_instruction_master_qualified_request_sdram_s1 | ~cpu_instruction_master_read | (1 & ~sdram_s1_waitrequest_from_sa & (cpu_instruction_master_dbs_address[1]) & cpu_instruction_master_read)));

  //optimize select-logic by passing only those address bits which matter.
  assign cpu_instruction_master_address_to_slave = {cpu_instruction_master_address[26],
    1'b0,
    cpu_instruction_master_address[24 : 0]};

  //cpu_instruction_master_read_but_no_slave_selected assignment, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_but_no_slave_selected <= 0;
      else 
        cpu_instruction_master_read_but_no_slave_selected <= cpu_instruction_master_read & cpu_instruction_master_run & ~cpu_instruction_master_is_granted_some_slave;
    end


  //some slave is getting selected, which is an e_mux
  assign cpu_instruction_master_is_granted_some_slave = cpu_instruction_master_granted_cpu_jtag_debug_module |
    cpu_instruction_master_granted_epcs_epcs_control_port |
    cpu_instruction_master_granted_sdram_s1;

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_cpu_instruction_master_readdatavalid = cpu_instruction_master_read_data_valid_sdram_s1 & dbs_rdv_counter_overflow;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign cpu_instruction_master_readdatavalid = cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_data_valid_cpu_jtag_debug_module |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid |
    cpu_instruction_master_read_data_valid_epcs_epcs_control_port |
    cpu_instruction_master_read_but_no_slave_selected |
    pre_flush_cpu_instruction_master_readdatavalid;

  //cpu/instruction_master readdata mux, which is an e_mux
  assign cpu_instruction_master_readdata = ({32 {~(cpu_instruction_master_qualified_request_cpu_jtag_debug_module & cpu_instruction_master_read)}} | cpu_jtag_debug_module_readdata_from_sa) &
    ({32 {~(cpu_instruction_master_qualified_request_epcs_epcs_control_port & cpu_instruction_master_read)}} | epcs_epcs_control_port_readdata_from_sa) &
    ({32 {~cpu_instruction_master_read_data_valid_sdram_s1}} | {sdram_s1_readdata_from_sa[15 : 0],
    dbs_latent_16_reg_segment_0});

  //actual waitrequest port, which is an e_assign
  assign cpu_instruction_master_waitrequest = ~cpu_instruction_master_run;

  //latent max counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_latency_counter <= 0;
      else 
        cpu_instruction_master_latency_counter <= p1_cpu_instruction_master_latency_counter;
    end


  //latency counter load mux, which is an e_mux
  assign p1_cpu_instruction_master_latency_counter = ((cpu_instruction_master_run & cpu_instruction_master_read))? latency_load_value :
    (cpu_instruction_master_latency_counter)? cpu_instruction_master_latency_counter - 1 :
    0;

  //read latency load values, which is an e_mux
  assign latency_load_value = 0;

  //input to latent dbs-16 stored 0, which is an e_mux
  assign p1_dbs_latent_16_reg_segment_0 = sdram_s1_readdata_from_sa;

  //dbs register for latent dbs-16 segment 0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          dbs_latent_16_reg_segment_0 <= 0;
      else if (dbs_rdv_count_enable & ((cpu_instruction_master_dbs_rdv_counter[1]) == 0))
          dbs_latent_16_reg_segment_0 <= p1_dbs_latent_16_reg_segment_0;
    end


  //dbs count increment, which is an e_mux
  assign cpu_instruction_master_dbs_increment = (cpu_instruction_master_requests_sdram_s1)? 2 :
    0;

  //dbs counter overflow, which is an e_assign
  assign dbs_counter_overflow = cpu_instruction_master_dbs_address[1] & !(next_dbs_address[1]);

  //next master address, which is an e_assign
  assign next_dbs_address = cpu_instruction_master_dbs_address + cpu_instruction_master_dbs_increment;

  //dbs count enable, which is an e_mux
  assign dbs_count_enable = pre_dbs_count_enable;

  //dbs counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_address <= 0;
      else if (dbs_count_enable)
          cpu_instruction_master_dbs_address <= next_dbs_address;
    end


  //p1 dbs rdv counter, which is an e_assign
  assign cpu_instruction_master_next_dbs_rdv_counter = cpu_instruction_master_dbs_rdv_counter + cpu_instruction_master_dbs_rdv_counter_inc;

  //cpu_instruction_master_rdv_inc_mux, which is an e_mux
  assign cpu_instruction_master_dbs_rdv_counter_inc = 2;

  //master any slave rdv, which is an e_mux
  assign dbs_rdv_count_enable = cpu_instruction_master_read_data_valid_sdram_s1;

  //dbs rdv counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_dbs_rdv_counter <= 0;
      else if (dbs_rdv_count_enable)
          cpu_instruction_master_dbs_rdv_counter <= cpu_instruction_master_next_dbs_rdv_counter;
    end


  //dbs rdv counter overflow, which is an e_assign
  assign dbs_rdv_counter_overflow = cpu_instruction_master_dbs_rdv_counter[1] & ~cpu_instruction_master_next_dbs_rdv_counter[1];

  //pre dbs count enable, which is an e_mux
  assign pre_dbs_count_enable = cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read & 1 & 1 & ~sdram_s1_waitrequest_from_sa;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //cpu_instruction_master_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_address_last_time <= 0;
      else 
        cpu_instruction_master_address_last_time <= cpu_instruction_master_address;
    end


  //cpu/instruction_master waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= cpu_instruction_master_waitrequest & (cpu_instruction_master_read);
    end


  //cpu_instruction_master_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_address != cpu_instruction_master_address_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //cpu_instruction_master_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          cpu_instruction_master_read_last_time <= 0;
      else 
        cpu_instruction_master_read_last_time <= cpu_instruction_master_read;
    end


  //cpu_instruction_master_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (cpu_instruction_master_read != cpu_instruction_master_read_last_time))
        begin
          $write("%0d ns: cpu_instruction_master_read did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module epcs_epcs_control_port_arbitrator (
                                           // inputs:
                                            clk,
                                            cpu_data_master_address_to_slave,
                                            cpu_data_master_read,
                                            cpu_data_master_write,
                                            cpu_data_master_writedata,
                                            cpu_instruction_master_address_to_slave,
                                            cpu_instruction_master_latency_counter,
                                            cpu_instruction_master_read,
                                            cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                                            epcs_epcs_control_port_dataavailable,
                                            epcs_epcs_control_port_endofpacket,
                                            epcs_epcs_control_port_irq,
                                            epcs_epcs_control_port_readdata,
                                            epcs_epcs_control_port_readyfordata,
                                            reset_n,

                                           // outputs:
                                            cpu_data_master_granted_epcs_epcs_control_port,
                                            cpu_data_master_qualified_request_epcs_epcs_control_port,
                                            cpu_data_master_read_data_valid_epcs_epcs_control_port,
                                            cpu_data_master_requests_epcs_epcs_control_port,
                                            cpu_instruction_master_granted_epcs_epcs_control_port,
                                            cpu_instruction_master_qualified_request_epcs_epcs_control_port,
                                            cpu_instruction_master_read_data_valid_epcs_epcs_control_port,
                                            cpu_instruction_master_requests_epcs_epcs_control_port,
                                            d1_epcs_epcs_control_port_end_xfer,
                                            epcs_epcs_control_port_address,
                                            epcs_epcs_control_port_chipselect,
                                            epcs_epcs_control_port_dataavailable_from_sa,
                                            epcs_epcs_control_port_endofpacket_from_sa,
                                            epcs_epcs_control_port_irq_from_sa,
                                            epcs_epcs_control_port_read_n,
                                            epcs_epcs_control_port_readdata_from_sa,
                                            epcs_epcs_control_port_readyfordata_from_sa,
                                            epcs_epcs_control_port_reset_n,
                                            epcs_epcs_control_port_write_n,
                                            epcs_epcs_control_port_writedata
                                         )
;

  output           cpu_data_master_granted_epcs_epcs_control_port;
  output           cpu_data_master_qualified_request_epcs_epcs_control_port;
  output           cpu_data_master_read_data_valid_epcs_epcs_control_port;
  output           cpu_data_master_requests_epcs_epcs_control_port;
  output           cpu_instruction_master_granted_epcs_epcs_control_port;
  output           cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  output           cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  output           cpu_instruction_master_requests_epcs_epcs_control_port;
  output           d1_epcs_epcs_control_port_end_xfer;
  output  [  8: 0] epcs_epcs_control_port_address;
  output           epcs_epcs_control_port_chipselect;
  output           epcs_epcs_control_port_dataavailable_from_sa;
  output           epcs_epcs_control_port_endofpacket_from_sa;
  output           epcs_epcs_control_port_irq_from_sa;
  output           epcs_epcs_control_port_read_n;
  output  [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  output           epcs_epcs_control_port_readyfordata_from_sa;
  output           epcs_epcs_control_port_reset_n;
  output           epcs_epcs_control_port_write_n;
  output  [ 31: 0] epcs_epcs_control_port_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  input            epcs_epcs_control_port_dataavailable;
  input            epcs_epcs_control_port_endofpacket;
  input            epcs_epcs_control_port_irq;
  input   [ 31: 0] epcs_epcs_control_port_readdata;
  input            epcs_epcs_control_port_readyfordata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_epcs_epcs_control_port;
  wire             cpu_data_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_data_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_data_master_requests_epcs_epcs_control_port;
  wire             cpu_data_master_saved_grant_epcs_epcs_control_port;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_epcs_epcs_control_port;
  wire             cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_instruction_master_requests_epcs_epcs_control_port;
  wire             cpu_instruction_master_saved_grant_epcs_epcs_control_port;
  reg              d1_epcs_epcs_control_port_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_epcs_epcs_control_port;
  wire    [  8: 0] epcs_epcs_control_port_address;
  wire             epcs_epcs_control_port_allgrants;
  wire             epcs_epcs_control_port_allow_new_arb_cycle;
  wire             epcs_epcs_control_port_any_bursting_master_saved_grant;
  wire             epcs_epcs_control_port_any_continuerequest;
  reg     [  1: 0] epcs_epcs_control_port_arb_addend;
  wire             epcs_epcs_control_port_arb_counter_enable;
  reg     [  1: 0] epcs_epcs_control_port_arb_share_counter;
  wire    [  1: 0] epcs_epcs_control_port_arb_share_counter_next_value;
  wire    [  1: 0] epcs_epcs_control_port_arb_share_set_values;
  wire    [  1: 0] epcs_epcs_control_port_arb_winner;
  wire             epcs_epcs_control_port_arbitration_holdoff_internal;
  wire             epcs_epcs_control_port_beginbursttransfer_internal;
  wire             epcs_epcs_control_port_begins_xfer;
  wire             epcs_epcs_control_port_chipselect;
  wire    [  3: 0] epcs_epcs_control_port_chosen_master_double_vector;
  wire    [  1: 0] epcs_epcs_control_port_chosen_master_rot_left;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_end_xfer;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_firsttransfer;
  wire    [  1: 0] epcs_epcs_control_port_grant_vector;
  wire             epcs_epcs_control_port_in_a_read_cycle;
  wire             epcs_epcs_control_port_in_a_write_cycle;
  wire             epcs_epcs_control_port_irq_from_sa;
  wire    [  1: 0] epcs_epcs_control_port_master_qreq_vector;
  wire             epcs_epcs_control_port_non_bursting_master_requests;
  wire             epcs_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  reg              epcs_epcs_control_port_reg_firsttransfer;
  wire             epcs_epcs_control_port_reset_n;
  reg     [  1: 0] epcs_epcs_control_port_saved_chosen_master_vector;
  reg              epcs_epcs_control_port_slavearbiterlockenable;
  wire             epcs_epcs_control_port_slavearbiterlockenable2;
  wire             epcs_epcs_control_port_unreg_firsttransfer;
  wire             epcs_epcs_control_port_waits_for_read;
  wire             epcs_epcs_control_port_waits_for_write;
  wire             epcs_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_epcs_control_port_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port;
  reg              last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port;
  wire    [ 26: 0] shifted_address_to_epcs_epcs_control_port_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_epcs_epcs_control_port_from_cpu_instruction_master;
  wire             wait_for_epcs_epcs_control_port_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~epcs_epcs_control_port_end_xfer;
    end


  assign epcs_epcs_control_port_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_epcs_epcs_control_port | cpu_instruction_master_qualified_request_epcs_epcs_control_port));
  //assign epcs_epcs_control_port_readdata_from_sa = epcs_epcs_control_port_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_readdata_from_sa = epcs_epcs_control_port_readdata;

  assign cpu_data_master_requests_epcs_epcs_control_port = ({cpu_data_master_address_to_slave[26 : 11] , 11'b0} == 27'h0) & (cpu_data_master_read | cpu_data_master_write);
  //assign epcs_epcs_control_port_dataavailable_from_sa = epcs_epcs_control_port_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_dataavailable_from_sa = epcs_epcs_control_port_dataavailable;

  //assign epcs_epcs_control_port_readyfordata_from_sa = epcs_epcs_control_port_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_readyfordata_from_sa = epcs_epcs_control_port_readyfordata;

  //epcs_epcs_control_port_arb_share_counter set values, which is an e_mux
  assign epcs_epcs_control_port_arb_share_set_values = 1;

  //epcs_epcs_control_port_non_bursting_master_requests mux, which is an e_mux
  assign epcs_epcs_control_port_non_bursting_master_requests = cpu_data_master_requests_epcs_epcs_control_port |
    cpu_instruction_master_requests_epcs_epcs_control_port |
    cpu_data_master_requests_epcs_epcs_control_port |
    cpu_instruction_master_requests_epcs_epcs_control_port;

  //epcs_epcs_control_port_any_bursting_master_saved_grant mux, which is an e_mux
  assign epcs_epcs_control_port_any_bursting_master_saved_grant = 0;

  //epcs_epcs_control_port_arb_share_counter_next_value assignment, which is an e_assign
  assign epcs_epcs_control_port_arb_share_counter_next_value = epcs_epcs_control_port_firsttransfer ? (epcs_epcs_control_port_arb_share_set_values - 1) : |epcs_epcs_control_port_arb_share_counter ? (epcs_epcs_control_port_arb_share_counter - 1) : 0;

  //epcs_epcs_control_port_allgrants all slave grants, which is an e_mux
  assign epcs_epcs_control_port_allgrants = (|epcs_epcs_control_port_grant_vector) |
    (|epcs_epcs_control_port_grant_vector) |
    (|epcs_epcs_control_port_grant_vector) |
    (|epcs_epcs_control_port_grant_vector);

  //epcs_epcs_control_port_end_xfer assignment, which is an e_assign
  assign epcs_epcs_control_port_end_xfer = ~(epcs_epcs_control_port_waits_for_read | epcs_epcs_control_port_waits_for_write);

  //end_xfer_arb_share_counter_term_epcs_epcs_control_port arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_epcs_epcs_control_port = epcs_epcs_control_port_end_xfer & (~epcs_epcs_control_port_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //epcs_epcs_control_port_arb_share_counter arbitration counter enable, which is an e_assign
  assign epcs_epcs_control_port_arb_counter_enable = (end_xfer_arb_share_counter_term_epcs_epcs_control_port & epcs_epcs_control_port_allgrants) | (end_xfer_arb_share_counter_term_epcs_epcs_control_port & ~epcs_epcs_control_port_non_bursting_master_requests);

  //epcs_epcs_control_port_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_arb_share_counter <= 0;
      else if (epcs_epcs_control_port_arb_counter_enable)
          epcs_epcs_control_port_arb_share_counter <= epcs_epcs_control_port_arb_share_counter_next_value;
    end


  //epcs_epcs_control_port_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_slavearbiterlockenable <= 0;
      else if ((|epcs_epcs_control_port_master_qreq_vector & end_xfer_arb_share_counter_term_epcs_epcs_control_port) | (end_xfer_arb_share_counter_term_epcs_epcs_control_port & ~epcs_epcs_control_port_non_bursting_master_requests))
          epcs_epcs_control_port_slavearbiterlockenable <= |epcs_epcs_control_port_arb_share_counter_next_value;
    end


  //cpu/data_master epcs/epcs_control_port arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = epcs_epcs_control_port_slavearbiterlockenable & cpu_data_master_continuerequest;

  //epcs_epcs_control_port_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign epcs_epcs_control_port_slavearbiterlockenable2 = |epcs_epcs_control_port_arb_share_counter_next_value;

  //cpu/data_master epcs/epcs_control_port arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = epcs_epcs_control_port_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master epcs/epcs_control_port arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = epcs_epcs_control_port_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master epcs/epcs_control_port arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = epcs_epcs_control_port_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted epcs/epcs_control_port last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port <= cpu_instruction_master_saved_grant_epcs_epcs_control_port ? 1 : (epcs_epcs_control_port_arbitration_holdoff_internal | ~cpu_instruction_master_requests_epcs_epcs_control_port) ? 0 : last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_epcs_epcs_control_port & cpu_instruction_master_requests_epcs_epcs_control_port;

  //epcs_epcs_control_port_any_continuerequest at least one master continues requesting, which is an e_mux
  assign epcs_epcs_control_port_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_epcs_epcs_control_port = cpu_data_master_requests_epcs_epcs_control_port & ~(cpu_instruction_master_arbiterlock);
  //epcs_epcs_control_port_writedata mux, which is an e_mux
  assign epcs_epcs_control_port_writedata = cpu_data_master_writedata;

  //assign epcs_epcs_control_port_endofpacket_from_sa = epcs_epcs_control_port_endofpacket so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_endofpacket_from_sa = epcs_epcs_control_port_endofpacket;

  assign cpu_instruction_master_requests_epcs_epcs_control_port = (({cpu_instruction_master_address_to_slave[26 : 11] , 11'b0} == 27'h0) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted epcs/epcs_control_port last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port <= cpu_data_master_saved_grant_epcs_epcs_control_port ? 1 : (epcs_epcs_control_port_arbitration_holdoff_internal | ~cpu_data_master_requests_epcs_epcs_control_port) ? 0 : last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_epcs_epcs_control_port & cpu_data_master_requests_epcs_epcs_control_port;

  assign cpu_instruction_master_qualified_request_epcs_epcs_control_port = cpu_instruction_master_requests_epcs_epcs_control_port & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (|cpu_instruction_master_read_data_valid_sdram_s1_shift_register))) | cpu_data_master_arbiterlock);
  //local readdatavalid cpu_instruction_master_read_data_valid_epcs_epcs_control_port, which is an e_mux
  assign cpu_instruction_master_read_data_valid_epcs_epcs_control_port = cpu_instruction_master_granted_epcs_epcs_control_port & cpu_instruction_master_read & ~epcs_epcs_control_port_waits_for_read;

  //allow new arb cycle for epcs/epcs_control_port, which is an e_assign
  assign epcs_epcs_control_port_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for epcs/epcs_control_port, which is an e_assign
  assign epcs_epcs_control_port_master_qreq_vector[0] = cpu_instruction_master_qualified_request_epcs_epcs_control_port;

  //cpu/instruction_master grant epcs/epcs_control_port, which is an e_assign
  assign cpu_instruction_master_granted_epcs_epcs_control_port = epcs_epcs_control_port_grant_vector[0];

  //cpu/instruction_master saved-grant epcs/epcs_control_port, which is an e_assign
  assign cpu_instruction_master_saved_grant_epcs_epcs_control_port = epcs_epcs_control_port_arb_winner[0] && cpu_instruction_master_requests_epcs_epcs_control_port;

  //cpu/data_master assignment into master qualified-requests vector for epcs/epcs_control_port, which is an e_assign
  assign epcs_epcs_control_port_master_qreq_vector[1] = cpu_data_master_qualified_request_epcs_epcs_control_port;

  //cpu/data_master grant epcs/epcs_control_port, which is an e_assign
  assign cpu_data_master_granted_epcs_epcs_control_port = epcs_epcs_control_port_grant_vector[1];

  //cpu/data_master saved-grant epcs/epcs_control_port, which is an e_assign
  assign cpu_data_master_saved_grant_epcs_epcs_control_port = epcs_epcs_control_port_arb_winner[1] && cpu_data_master_requests_epcs_epcs_control_port;

  //epcs/epcs_control_port chosen-master double-vector, which is an e_assign
  assign epcs_epcs_control_port_chosen_master_double_vector = {epcs_epcs_control_port_master_qreq_vector, epcs_epcs_control_port_master_qreq_vector} & ({~epcs_epcs_control_port_master_qreq_vector, ~epcs_epcs_control_port_master_qreq_vector} + epcs_epcs_control_port_arb_addend);

  //stable onehot encoding of arb winner
  assign epcs_epcs_control_port_arb_winner = (epcs_epcs_control_port_allow_new_arb_cycle & | epcs_epcs_control_port_grant_vector) ? epcs_epcs_control_port_grant_vector : epcs_epcs_control_port_saved_chosen_master_vector;

  //saved epcs_epcs_control_port_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_saved_chosen_master_vector <= 0;
      else if (epcs_epcs_control_port_allow_new_arb_cycle)
          epcs_epcs_control_port_saved_chosen_master_vector <= |epcs_epcs_control_port_grant_vector ? epcs_epcs_control_port_grant_vector : epcs_epcs_control_port_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign epcs_epcs_control_port_grant_vector = {(epcs_epcs_control_port_chosen_master_double_vector[1] | epcs_epcs_control_port_chosen_master_double_vector[3]),
    (epcs_epcs_control_port_chosen_master_double_vector[0] | epcs_epcs_control_port_chosen_master_double_vector[2])};

  //epcs/epcs_control_port chosen master rotated left, which is an e_assign
  assign epcs_epcs_control_port_chosen_master_rot_left = (epcs_epcs_control_port_arb_winner << 1) ? (epcs_epcs_control_port_arb_winner << 1) : 1;

  //epcs/epcs_control_port's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_arb_addend <= 1;
      else if (|epcs_epcs_control_port_grant_vector)
          epcs_epcs_control_port_arb_addend <= epcs_epcs_control_port_end_xfer? epcs_epcs_control_port_chosen_master_rot_left : epcs_epcs_control_port_grant_vector;
    end


  //epcs_epcs_control_port_reset_n assignment, which is an e_assign
  assign epcs_epcs_control_port_reset_n = reset_n;

  assign epcs_epcs_control_port_chipselect = cpu_data_master_granted_epcs_epcs_control_port | cpu_instruction_master_granted_epcs_epcs_control_port;
  //epcs_epcs_control_port_firsttransfer first transaction, which is an e_assign
  assign epcs_epcs_control_port_firsttransfer = epcs_epcs_control_port_begins_xfer ? epcs_epcs_control_port_unreg_firsttransfer : epcs_epcs_control_port_reg_firsttransfer;

  //epcs_epcs_control_port_unreg_firsttransfer first transaction, which is an e_assign
  assign epcs_epcs_control_port_unreg_firsttransfer = ~(epcs_epcs_control_port_slavearbiterlockenable & epcs_epcs_control_port_any_continuerequest);

  //epcs_epcs_control_port_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          epcs_epcs_control_port_reg_firsttransfer <= 1'b1;
      else if (epcs_epcs_control_port_begins_xfer)
          epcs_epcs_control_port_reg_firsttransfer <= epcs_epcs_control_port_unreg_firsttransfer;
    end


  //epcs_epcs_control_port_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign epcs_epcs_control_port_beginbursttransfer_internal = epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign epcs_epcs_control_port_arbitration_holdoff_internal = epcs_epcs_control_port_begins_xfer & epcs_epcs_control_port_firsttransfer;

  //~epcs_epcs_control_port_read_n assignment, which is an e_mux
  assign epcs_epcs_control_port_read_n = ~((cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_read) | (cpu_instruction_master_granted_epcs_epcs_control_port & cpu_instruction_master_read));

  //~epcs_epcs_control_port_write_n assignment, which is an e_mux
  assign epcs_epcs_control_port_write_n = ~(cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_write);

  assign shifted_address_to_epcs_epcs_control_port_from_cpu_data_master = cpu_data_master_address_to_slave;
  //epcs_epcs_control_port_address mux, which is an e_mux
  assign epcs_epcs_control_port_address = (cpu_data_master_granted_epcs_epcs_control_port)? (shifted_address_to_epcs_epcs_control_port_from_cpu_data_master >> 2) :
    (shifted_address_to_epcs_epcs_control_port_from_cpu_instruction_master >> 2);

  assign shifted_address_to_epcs_epcs_control_port_from_cpu_instruction_master = cpu_instruction_master_address_to_slave;
  //d1_epcs_epcs_control_port_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_epcs_epcs_control_port_end_xfer <= 1;
      else 
        d1_epcs_epcs_control_port_end_xfer <= epcs_epcs_control_port_end_xfer;
    end


  //epcs_epcs_control_port_waits_for_read in a cycle, which is an e_mux
  assign epcs_epcs_control_port_waits_for_read = epcs_epcs_control_port_in_a_read_cycle & epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_in_a_read_cycle assignment, which is an e_assign
  assign epcs_epcs_control_port_in_a_read_cycle = (cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_read) | (cpu_instruction_master_granted_epcs_epcs_control_port & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = epcs_epcs_control_port_in_a_read_cycle;

  //epcs_epcs_control_port_waits_for_write in a cycle, which is an e_mux
  assign epcs_epcs_control_port_waits_for_write = epcs_epcs_control_port_in_a_write_cycle & epcs_epcs_control_port_begins_xfer;

  //epcs_epcs_control_port_in_a_write_cycle assignment, which is an e_assign
  assign epcs_epcs_control_port_in_a_write_cycle = cpu_data_master_granted_epcs_epcs_control_port & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = epcs_epcs_control_port_in_a_write_cycle;

  assign wait_for_epcs_epcs_control_port_counter = 0;
  //assign epcs_epcs_control_port_irq_from_sa = epcs_epcs_control_port_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign epcs_epcs_control_port_irq_from_sa = epcs_epcs_control_port_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //epcs/epcs_control_port enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_epcs_epcs_control_port + cpu_instruction_master_granted_epcs_epcs_control_port > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_epcs_epcs_control_port + cpu_instruction_master_saved_grant_epcs_epcs_control_port > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module jtag_uart_avalon_jtag_slave_arbitrator (
                                                // inputs:
                                                 clk,
                                                 cpu_data_master_address_to_slave,
                                                 cpu_data_master_read,
                                                 cpu_data_master_waitrequest,
                                                 cpu_data_master_write,
                                                 cpu_data_master_writedata,
                                                 jtag_uart_avalon_jtag_slave_dataavailable,
                                                 jtag_uart_avalon_jtag_slave_irq,
                                                 jtag_uart_avalon_jtag_slave_readdata,
                                                 jtag_uart_avalon_jtag_slave_readyfordata,
                                                 jtag_uart_avalon_jtag_slave_waitrequest,
                                                 reset_n,

                                                // outputs:
                                                 cpu_data_master_granted_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave,
                                                 cpu_data_master_requests_jtag_uart_avalon_jtag_slave,
                                                 d1_jtag_uart_avalon_jtag_slave_end_xfer,
                                                 jtag_uart_avalon_jtag_slave_address,
                                                 jtag_uart_avalon_jtag_slave_chipselect,
                                                 jtag_uart_avalon_jtag_slave_dataavailable_from_sa,
                                                 jtag_uart_avalon_jtag_slave_irq_from_sa,
                                                 jtag_uart_avalon_jtag_slave_read_n,
                                                 jtag_uart_avalon_jtag_slave_readdata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_readyfordata_from_sa,
                                                 jtag_uart_avalon_jtag_slave_reset_n,
                                                 jtag_uart_avalon_jtag_slave_waitrequest_from_sa,
                                                 jtag_uart_avalon_jtag_slave_write_n,
                                                 jtag_uart_avalon_jtag_slave_writedata
                                              )
;

  output           cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  output           cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  output           d1_jtag_uart_avalon_jtag_slave_end_xfer;
  output           jtag_uart_avalon_jtag_slave_address;
  output           jtag_uart_avalon_jtag_slave_chipselect;
  output           jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  output           jtag_uart_avalon_jtag_slave_irq_from_sa;
  output           jtag_uart_avalon_jtag_slave_read_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  output           jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  output           jtag_uart_avalon_jtag_slave_reset_n;
  output           jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  output           jtag_uart_avalon_jtag_slave_write_n;
  output  [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input            jtag_uart_avalon_jtag_slave_dataavailable;
  input            jtag_uart_avalon_jtag_slave_irq;
  input   [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  input            jtag_uart_avalon_jtag_slave_readyfordata;
  input            jtag_uart_avalon_jtag_slave_waitrequest;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave;
  reg              d1_jtag_uart_avalon_jtag_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_allgrants;
  wire             jtag_uart_avalon_jtag_slave_allow_new_arb_cycle;
  wire             jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant;
  wire             jtag_uart_avalon_jtag_slave_any_continuerequest;
  wire             jtag_uart_avalon_jtag_slave_arb_counter_enable;
  reg     [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
  wire    [  1: 0] jtag_uart_avalon_jtag_slave_arb_share_set_values;
  wire             jtag_uart_avalon_jtag_slave_beginbursttransfer_internal;
  wire             jtag_uart_avalon_jtag_slave_begins_xfer;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_end_xfer;
  wire             jtag_uart_avalon_jtag_slave_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_grant_vector;
  wire             jtag_uart_avalon_jtag_slave_in_a_read_cycle;
  wire             jtag_uart_avalon_jtag_slave_in_a_write_cycle;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_master_qreq_vector;
  wire             jtag_uart_avalon_jtag_slave_non_bursting_master_requests;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  reg              jtag_uart_avalon_jtag_slave_reg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  reg              jtag_uart_avalon_jtag_slave_slavearbiterlockenable;
  wire             jtag_uart_avalon_jtag_slave_slavearbiterlockenable2;
  wire             jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_waits_for_read;
  wire             jtag_uart_avalon_jtag_slave_waits_for_write;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire    [ 26: 0] shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master;
  wire             wait_for_jtag_uart_avalon_jtag_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~jtag_uart_avalon_jtag_slave_end_xfer;
    end


  assign jtag_uart_avalon_jtag_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave));
  //assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readdata_from_sa = jtag_uart_avalon_jtag_slave_readdata;

  assign cpu_data_master_requests_jtag_uart_avalon_jtag_slave = ({cpu_data_master_address_to_slave[26 : 3] , 3'b0} == 27'h1918) & (cpu_data_master_read | cpu_data_master_write);
  //assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_dataavailable_from_sa = jtag_uart_avalon_jtag_slave_dataavailable;

  //assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_readyfordata_from_sa = jtag_uart_avalon_jtag_slave_readyfordata;

  //assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_waitrequest_from_sa = jtag_uart_avalon_jtag_slave_waitrequest;

  //jtag_uart_avalon_jtag_slave_arb_share_counter set values, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_arb_share_set_values = 1;

  //jtag_uart_avalon_jtag_slave_non_bursting_master_requests mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_non_bursting_master_requests = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant = 0;

  //jtag_uart_avalon_jtag_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_share_counter_next_value = jtag_uart_avalon_jtag_slave_firsttransfer ? (jtag_uart_avalon_jtag_slave_arb_share_set_values - 1) : |jtag_uart_avalon_jtag_slave_arb_share_counter ? (jtag_uart_avalon_jtag_slave_arb_share_counter - 1) : 0;

  //jtag_uart_avalon_jtag_slave_allgrants all slave grants, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_allgrants = |jtag_uart_avalon_jtag_slave_grant_vector;

  //jtag_uart_avalon_jtag_slave_end_xfer assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_end_xfer = ~(jtag_uart_avalon_jtag_slave_waits_for_read | jtag_uart_avalon_jtag_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave = jtag_uart_avalon_jtag_slave_end_xfer & (~jtag_uart_avalon_jtag_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //jtag_uart_avalon_jtag_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & jtag_uart_avalon_jtag_slave_allgrants) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests);

  //jtag_uart_avalon_jtag_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= 0;
      else if (jtag_uart_avalon_jtag_slave_arb_counter_enable)
          jtag_uart_avalon_jtag_slave_arb_share_counter <= jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= 0;
      else if ((|jtag_uart_avalon_jtag_slave_master_qreq_vector & end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave) | (end_xfer_arb_share_counter_term_jtag_uart_avalon_jtag_slave & ~jtag_uart_avalon_jtag_slave_non_bursting_master_requests))
          jtag_uart_avalon_jtag_slave_slavearbiterlockenable <= |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;
    end


  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = jtag_uart_avalon_jtag_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 = |jtag_uart_avalon_jtag_slave_arb_share_counter_next_value;

  //cpu/data_master jtag_uart/avalon_jtag_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = jtag_uart_avalon_jtag_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //jtag_uart_avalon_jtag_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave & ~((cpu_data_master_read & (~cpu_data_master_waitrequest)) | ((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //jtag_uart_avalon_jtag_slave_writedata mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_jtag_uart_avalon_jtag_slave = cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;

  //cpu/data_master saved-grant jtag_uart/avalon_jtag_slave, which is an e_assign
  assign cpu_data_master_saved_grant_jtag_uart_avalon_jtag_slave = cpu_data_master_requests_jtag_uart_avalon_jtag_slave;

  //allow new arb cycle for jtag_uart/avalon_jtag_slave, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign jtag_uart_avalon_jtag_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign jtag_uart_avalon_jtag_slave_master_qreq_vector = 1;

  //jtag_uart_avalon_jtag_slave_reset_n assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_reset_n = reset_n;

  assign jtag_uart_avalon_jtag_slave_chipselect = cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  //jtag_uart_avalon_jtag_slave_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_firsttransfer = jtag_uart_avalon_jtag_slave_begins_xfer ? jtag_uart_avalon_jtag_slave_unreg_firsttransfer : jtag_uart_avalon_jtag_slave_reg_firsttransfer;

  //jtag_uart_avalon_jtag_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_unreg_firsttransfer = ~(jtag_uart_avalon_jtag_slave_slavearbiterlockenable & jtag_uart_avalon_jtag_slave_any_continuerequest);

  //jtag_uart_avalon_jtag_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= 1'b1;
      else if (jtag_uart_avalon_jtag_slave_begins_xfer)
          jtag_uart_avalon_jtag_slave_reg_firsttransfer <= jtag_uart_avalon_jtag_slave_unreg_firsttransfer;
    end


  //jtag_uart_avalon_jtag_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_beginbursttransfer_internal = jtag_uart_avalon_jtag_slave_begins_xfer;

  //~jtag_uart_avalon_jtag_slave_read_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_read_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read);

  //~jtag_uart_avalon_jtag_slave_write_n assignment, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_write_n = ~(cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write);

  assign shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //jtag_uart_avalon_jtag_slave_address mux, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_address = shifted_address_to_jtag_uart_avalon_jtag_slave_from_cpu_data_master >> 2;

  //d1_jtag_uart_avalon_jtag_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_jtag_uart_avalon_jtag_slave_end_xfer <= 1;
      else 
        d1_jtag_uart_avalon_jtag_slave_end_xfer <= jtag_uart_avalon_jtag_slave_end_xfer;
    end


  //jtag_uart_avalon_jtag_slave_waits_for_read in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_read = jtag_uart_avalon_jtag_slave_in_a_read_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_read_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_read_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = jtag_uart_avalon_jtag_slave_in_a_read_cycle;

  //jtag_uart_avalon_jtag_slave_waits_for_write in a cycle, which is an e_mux
  assign jtag_uart_avalon_jtag_slave_waits_for_write = jtag_uart_avalon_jtag_slave_in_a_write_cycle & jtag_uart_avalon_jtag_slave_waitrequest_from_sa;

  //jtag_uart_avalon_jtag_slave_in_a_write_cycle assignment, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_in_a_write_cycle = cpu_data_master_granted_jtag_uart_avalon_jtag_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = jtag_uart_avalon_jtag_slave_in_a_write_cycle;

  assign wait_for_jtag_uart_avalon_jtag_slave_counter = 0;
  //assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign jtag_uart_avalon_jtag_slave_irq_from_sa = jtag_uart_avalon_jtag_slave_irq;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //jtag_uart/avalon_jtag_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module pio_led_s1_arbitrator (
                               // inputs:
                                clk,
                                cpu_data_master_address_to_slave,
                                cpu_data_master_read,
                                cpu_data_master_waitrequest,
                                cpu_data_master_write,
                                cpu_data_master_writedata,
                                pio_led_s1_readdata,
                                reset_n,

                               // outputs:
                                cpu_data_master_granted_pio_led_s1,
                                cpu_data_master_qualified_request_pio_led_s1,
                                cpu_data_master_read_data_valid_pio_led_s1,
                                cpu_data_master_requests_pio_led_s1,
                                d1_pio_led_s1_end_xfer,
                                pio_led_s1_address,
                                pio_led_s1_chipselect,
                                pio_led_s1_readdata_from_sa,
                                pio_led_s1_reset_n,
                                pio_led_s1_write_n,
                                pio_led_s1_writedata
                             )
;

  output           cpu_data_master_granted_pio_led_s1;
  output           cpu_data_master_qualified_request_pio_led_s1;
  output           cpu_data_master_read_data_valid_pio_led_s1;
  output           cpu_data_master_requests_pio_led_s1;
  output           d1_pio_led_s1_end_xfer;
  output  [  1: 0] pio_led_s1_address;
  output           pio_led_s1_chipselect;
  output  [ 31: 0] pio_led_s1_readdata_from_sa;
  output           pio_led_s1_reset_n;
  output           pio_led_s1_write_n;
  output  [ 31: 0] pio_led_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 31: 0] cpu_data_master_writedata;
  input   [ 31: 0] pio_led_s1_readdata;
  input            reset_n;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_pio_led_s1;
  wire             cpu_data_master_qualified_request_pio_led_s1;
  wire             cpu_data_master_read_data_valid_pio_led_s1;
  wire             cpu_data_master_requests_pio_led_s1;
  wire             cpu_data_master_saved_grant_pio_led_s1;
  reg              d1_pio_led_s1_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_pio_led_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [  1: 0] pio_led_s1_address;
  wire             pio_led_s1_allgrants;
  wire             pio_led_s1_allow_new_arb_cycle;
  wire             pio_led_s1_any_bursting_master_saved_grant;
  wire             pio_led_s1_any_continuerequest;
  wire             pio_led_s1_arb_counter_enable;
  reg     [  1: 0] pio_led_s1_arb_share_counter;
  wire    [  1: 0] pio_led_s1_arb_share_counter_next_value;
  wire    [  1: 0] pio_led_s1_arb_share_set_values;
  wire             pio_led_s1_beginbursttransfer_internal;
  wire             pio_led_s1_begins_xfer;
  wire             pio_led_s1_chipselect;
  wire             pio_led_s1_end_xfer;
  wire             pio_led_s1_firsttransfer;
  wire             pio_led_s1_grant_vector;
  wire             pio_led_s1_in_a_read_cycle;
  wire             pio_led_s1_in_a_write_cycle;
  wire             pio_led_s1_master_qreq_vector;
  wire             pio_led_s1_non_bursting_master_requests;
  wire    [ 31: 0] pio_led_s1_readdata_from_sa;
  reg              pio_led_s1_reg_firsttransfer;
  wire             pio_led_s1_reset_n;
  reg              pio_led_s1_slavearbiterlockenable;
  wire             pio_led_s1_slavearbiterlockenable2;
  wire             pio_led_s1_unreg_firsttransfer;
  wire             pio_led_s1_waits_for_read;
  wire             pio_led_s1_waits_for_write;
  wire             pio_led_s1_write_n;
  wire    [ 31: 0] pio_led_s1_writedata;
  wire    [ 26: 0] shifted_address_to_pio_led_s1_from_cpu_data_master;
  wire             wait_for_pio_led_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~pio_led_s1_end_xfer;
    end


  assign pio_led_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_pio_led_s1));
  //assign pio_led_s1_readdata_from_sa = pio_led_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign pio_led_s1_readdata_from_sa = pio_led_s1_readdata;

  assign cpu_data_master_requests_pio_led_s1 = ({cpu_data_master_address_to_slave[26 : 4] , 4'b0} == 27'h1820) & (cpu_data_master_read | cpu_data_master_write);
  //pio_led_s1_arb_share_counter set values, which is an e_mux
  assign pio_led_s1_arb_share_set_values = 1;

  //pio_led_s1_non_bursting_master_requests mux, which is an e_mux
  assign pio_led_s1_non_bursting_master_requests = cpu_data_master_requests_pio_led_s1;

  //pio_led_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign pio_led_s1_any_bursting_master_saved_grant = 0;

  //pio_led_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign pio_led_s1_arb_share_counter_next_value = pio_led_s1_firsttransfer ? (pio_led_s1_arb_share_set_values - 1) : |pio_led_s1_arb_share_counter ? (pio_led_s1_arb_share_counter - 1) : 0;

  //pio_led_s1_allgrants all slave grants, which is an e_mux
  assign pio_led_s1_allgrants = |pio_led_s1_grant_vector;

  //pio_led_s1_end_xfer assignment, which is an e_assign
  assign pio_led_s1_end_xfer = ~(pio_led_s1_waits_for_read | pio_led_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_pio_led_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_pio_led_s1 = pio_led_s1_end_xfer & (~pio_led_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //pio_led_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign pio_led_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_pio_led_s1 & pio_led_s1_allgrants) | (end_xfer_arb_share_counter_term_pio_led_s1 & ~pio_led_s1_non_bursting_master_requests);

  //pio_led_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_led_s1_arb_share_counter <= 0;
      else if (pio_led_s1_arb_counter_enable)
          pio_led_s1_arb_share_counter <= pio_led_s1_arb_share_counter_next_value;
    end


  //pio_led_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_led_s1_slavearbiterlockenable <= 0;
      else if ((|pio_led_s1_master_qreq_vector & end_xfer_arb_share_counter_term_pio_led_s1) | (end_xfer_arb_share_counter_term_pio_led_s1 & ~pio_led_s1_non_bursting_master_requests))
          pio_led_s1_slavearbiterlockenable <= |pio_led_s1_arb_share_counter_next_value;
    end


  //cpu/data_master pio_led/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = pio_led_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //pio_led_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign pio_led_s1_slavearbiterlockenable2 = |pio_led_s1_arb_share_counter_next_value;

  //cpu/data_master pio_led/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = pio_led_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //pio_led_s1_any_continuerequest at least one master continues requesting, which is an e_assign
  assign pio_led_s1_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_pio_led_s1 = cpu_data_master_requests_pio_led_s1 & ~(((~cpu_data_master_waitrequest) & cpu_data_master_write));
  //pio_led_s1_writedata mux, which is an e_mux
  assign pio_led_s1_writedata = cpu_data_master_writedata;

  //master is always granted when requested
  assign cpu_data_master_granted_pio_led_s1 = cpu_data_master_qualified_request_pio_led_s1;

  //cpu/data_master saved-grant pio_led/s1, which is an e_assign
  assign cpu_data_master_saved_grant_pio_led_s1 = cpu_data_master_requests_pio_led_s1;

  //allow new arb cycle for pio_led/s1, which is an e_assign
  assign pio_led_s1_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign pio_led_s1_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign pio_led_s1_master_qreq_vector = 1;

  //pio_led_s1_reset_n assignment, which is an e_assign
  assign pio_led_s1_reset_n = reset_n;

  assign pio_led_s1_chipselect = cpu_data_master_granted_pio_led_s1;
  //pio_led_s1_firsttransfer first transaction, which is an e_assign
  assign pio_led_s1_firsttransfer = pio_led_s1_begins_xfer ? pio_led_s1_unreg_firsttransfer : pio_led_s1_reg_firsttransfer;

  //pio_led_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign pio_led_s1_unreg_firsttransfer = ~(pio_led_s1_slavearbiterlockenable & pio_led_s1_any_continuerequest);

  //pio_led_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pio_led_s1_reg_firsttransfer <= 1'b1;
      else if (pio_led_s1_begins_xfer)
          pio_led_s1_reg_firsttransfer <= pio_led_s1_unreg_firsttransfer;
    end


  //pio_led_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign pio_led_s1_beginbursttransfer_internal = pio_led_s1_begins_xfer;

  //~pio_led_s1_write_n assignment, which is an e_mux
  assign pio_led_s1_write_n = ~(cpu_data_master_granted_pio_led_s1 & cpu_data_master_write);

  assign shifted_address_to_pio_led_s1_from_cpu_data_master = cpu_data_master_address_to_slave;
  //pio_led_s1_address mux, which is an e_mux
  assign pio_led_s1_address = shifted_address_to_pio_led_s1_from_cpu_data_master >> 2;

  //d1_pio_led_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_pio_led_s1_end_xfer <= 1;
      else 
        d1_pio_led_s1_end_xfer <= pio_led_s1_end_xfer;
    end


  //pio_led_s1_waits_for_read in a cycle, which is an e_mux
  assign pio_led_s1_waits_for_read = pio_led_s1_in_a_read_cycle & pio_led_s1_begins_xfer;

  //pio_led_s1_in_a_read_cycle assignment, which is an e_assign
  assign pio_led_s1_in_a_read_cycle = cpu_data_master_granted_pio_led_s1 & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = pio_led_s1_in_a_read_cycle;

  //pio_led_s1_waits_for_write in a cycle, which is an e_mux
  assign pio_led_s1_waits_for_write = pio_led_s1_in_a_write_cycle & 0;

  //pio_led_s1_in_a_write_cycle assignment, which is an e_assign
  assign pio_led_s1_in_a_write_cycle = cpu_data_master_granted_pio_led_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = pio_led_s1_in_a_write_cycle;

  assign wait_for_pio_led_s1_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //pio_led/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_data_master_to_sdram_s1_module (
                                                         // inputs:
                                                          clear_fifo,
                                                          clk,
                                                          data_in,
                                                          read,
                                                          reset_n,
                                                          sync_reset,
                                                          write,

                                                         // outputs:
                                                          data_out,
                                                          empty,
                                                          fifo_contains_ones_n,
                                                          full
                                                       )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module (
                                                                // inputs:
                                                                 clear_fifo,
                                                                 clk,
                                                                 data_in,
                                                                 read,
                                                                 reset_n,
                                                                 sync_reset,
                                                                 write,

                                                                // outputs:
                                                                 data_out,
                                                                 empty,
                                                                 fifo_contains_ones_n,
                                                                 full
                                                              )
;

  output           data_out;
  output           empty;
  output           fifo_contains_ones_n;
  output           full;
  input            clear_fifo;
  input            clk;
  input            data_in;
  input            read;
  input            reset_n;
  input            sync_reset;
  input            write;

  wire             data_out;
  wire             empty;
  reg              fifo_contains_ones_n;
  wire             full;
  reg              full_0;
  reg              full_1;
  reg              full_2;
  reg              full_3;
  reg              full_4;
  reg              full_5;
  reg              full_6;
  wire             full_7;
  reg     [  3: 0] how_many_ones;
  wire    [  3: 0] one_count_minus_one;
  wire    [  3: 0] one_count_plus_one;
  wire             p0_full_0;
  wire             p0_stage_0;
  wire             p1_full_1;
  wire             p1_stage_1;
  wire             p2_full_2;
  wire             p2_stage_2;
  wire             p3_full_3;
  wire             p3_stage_3;
  wire             p4_full_4;
  wire             p4_stage_4;
  wire             p5_full_5;
  wire             p5_stage_5;
  wire             p6_full_6;
  wire             p6_stage_6;
  reg              stage_0;
  reg              stage_1;
  reg              stage_2;
  reg              stage_3;
  reg              stage_4;
  reg              stage_5;
  reg              stage_6;
  wire    [  3: 0] updated_one_count;
  assign data_out = stage_0;
  assign full = full_6;
  assign empty = !full_0;
  assign full_7 = 0;
  //data_6, which is an e_mux
  assign p6_stage_6 = ((full_7 & ~clear_fifo) == 0)? data_in :
    data_in;

  //data_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_6 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_6))
          if (sync_reset & full_6 & !((full_7 == 0) & read & write))
              stage_6 <= 0;
          else 
            stage_6 <= p6_stage_6;
    end


  //control_6, which is an e_mux
  assign p6_full_6 = ((read & !write) == 0)? full_5 :
    0;

  //control_reg_6, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_6 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_6 <= 0;
          else 
            full_6 <= p6_full_6;
    end


  //data_5, which is an e_mux
  assign p5_stage_5 = ((full_6 & ~clear_fifo) == 0)? data_in :
    stage_6;

  //data_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_5 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_5))
          if (sync_reset & full_5 & !((full_6 == 0) & read & write))
              stage_5 <= 0;
          else 
            stage_5 <= p5_stage_5;
    end


  //control_5, which is an e_mux
  assign p5_full_5 = ((read & !write) == 0)? full_4 :
    full_6;

  //control_reg_5, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_5 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_5 <= 0;
          else 
            full_5 <= p5_full_5;
    end


  //data_4, which is an e_mux
  assign p4_stage_4 = ((full_5 & ~clear_fifo) == 0)? data_in :
    stage_5;

  //data_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_4 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_4))
          if (sync_reset & full_4 & !((full_5 == 0) & read & write))
              stage_4 <= 0;
          else 
            stage_4 <= p4_stage_4;
    end


  //control_4, which is an e_mux
  assign p4_full_4 = ((read & !write) == 0)? full_3 :
    full_5;

  //control_reg_4, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_4 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_4 <= 0;
          else 
            full_4 <= p4_full_4;
    end


  //data_3, which is an e_mux
  assign p3_stage_3 = ((full_4 & ~clear_fifo) == 0)? data_in :
    stage_4;

  //data_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_3 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_3))
          if (sync_reset & full_3 & !((full_4 == 0) & read & write))
              stage_3 <= 0;
          else 
            stage_3 <= p3_stage_3;
    end


  //control_3, which is an e_mux
  assign p3_full_3 = ((read & !write) == 0)? full_2 :
    full_4;

  //control_reg_3, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_3 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_3 <= 0;
          else 
            full_3 <= p3_full_3;
    end


  //data_2, which is an e_mux
  assign p2_stage_2 = ((full_3 & ~clear_fifo) == 0)? data_in :
    stage_3;

  //data_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_2 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_2))
          if (sync_reset & full_2 & !((full_3 == 0) & read & write))
              stage_2 <= 0;
          else 
            stage_2 <= p2_stage_2;
    end


  //control_2, which is an e_mux
  assign p2_full_2 = ((read & !write) == 0)? full_1 :
    full_3;

  //control_reg_2, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_2 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_2 <= 0;
          else 
            full_2 <= p2_full_2;
    end


  //data_1, which is an e_mux
  assign p1_stage_1 = ((full_2 & ~clear_fifo) == 0)? data_in :
    stage_2;

  //data_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_1 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_1))
          if (sync_reset & full_1 & !((full_2 == 0) & read & write))
              stage_1 <= 0;
          else 
            stage_1 <= p1_stage_1;
    end


  //control_1, which is an e_mux
  assign p1_full_1 = ((read & !write) == 0)? full_0 :
    full_2;

  //control_reg_1, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_1 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo)
              full_1 <= 0;
          else 
            full_1 <= p1_full_1;
    end


  //data_0, which is an e_mux
  assign p0_stage_0 = ((full_1 & ~clear_fifo) == 0)? data_in :
    stage_1;

  //data_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          stage_0 <= 0;
      else if (clear_fifo | sync_reset | read | (write & !full_0))
          if (sync_reset & full_0 & !((full_1 == 0) & read & write))
              stage_0 <= 0;
          else 
            stage_0 <= p0_stage_0;
    end


  //control_0, which is an e_mux
  assign p0_full_0 = ((read & !write) == 0)? 1 :
    full_1;

  //control_reg_0, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          full_0 <= 0;
      else if (clear_fifo | (read ^ write) | (write & !full_0))
          if (clear_fifo & ~write)
              full_0 <= 0;
          else 
            full_0 <= p0_full_0;
    end


  assign one_count_plus_one = how_many_ones + 1;
  assign one_count_minus_one = how_many_ones - 1;
  //updated_one_count, which is an e_mux
  assign updated_one_count = ((((clear_fifo | sync_reset) & !write)))? 0 :
    ((((clear_fifo | sync_reset) & write)))? |data_in :
    ((read & (|data_in) & write & (|stage_0)))? how_many_ones :
    ((write & (|data_in)))? one_count_plus_one :
    ((read & (|stage_0)))? one_count_minus_one :
    how_many_ones;

  //counts how many ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          how_many_ones <= 0;
      else if (clear_fifo | sync_reset | read | write)
          how_many_ones <= updated_one_count;
    end


  //this fifo contains ones in the data pipeline, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          fifo_contains_ones_n <= 1;
      else if (clear_fifo | sync_reset | read | write)
          fifo_contains_ones_n <= ~(|updated_one_count);
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sdram_s1_arbitrator (
                             // inputs:
                              clk,
                              cpu_data_master_address_to_slave,
                              cpu_data_master_byteenable,
                              cpu_data_master_dbs_address,
                              cpu_data_master_dbs_write_16,
                              cpu_data_master_no_byte_enables_and_last_term,
                              cpu_data_master_read,
                              cpu_data_master_waitrequest,
                              cpu_data_master_write,
                              cpu_instruction_master_address_to_slave,
                              cpu_instruction_master_dbs_address,
                              cpu_instruction_master_latency_counter,
                              cpu_instruction_master_read,
                              reset_n,
                              sdram_s1_readdata,
                              sdram_s1_readdatavalid,
                              sdram_s1_waitrequest,

                             // outputs:
                              cpu_data_master_byteenable_sdram_s1,
                              cpu_data_master_granted_sdram_s1,
                              cpu_data_master_qualified_request_sdram_s1,
                              cpu_data_master_read_data_valid_sdram_s1,
                              cpu_data_master_read_data_valid_sdram_s1_shift_register,
                              cpu_data_master_requests_sdram_s1,
                              cpu_instruction_master_granted_sdram_s1,
                              cpu_instruction_master_qualified_request_sdram_s1,
                              cpu_instruction_master_read_data_valid_sdram_s1,
                              cpu_instruction_master_read_data_valid_sdram_s1_shift_register,
                              cpu_instruction_master_requests_sdram_s1,
                              d1_sdram_s1_end_xfer,
                              sdram_s1_address,
                              sdram_s1_byteenable_n,
                              sdram_s1_chipselect,
                              sdram_s1_read_n,
                              sdram_s1_readdata_from_sa,
                              sdram_s1_reset_n,
                              sdram_s1_waitrequest_from_sa,
                              sdram_s1_write_n,
                              sdram_s1_writedata
                           )
;

  output  [  1: 0] cpu_data_master_byteenable_sdram_s1;
  output           cpu_data_master_granted_sdram_s1;
  output           cpu_data_master_qualified_request_sdram_s1;
  output           cpu_data_master_read_data_valid_sdram_s1;
  output           cpu_data_master_read_data_valid_sdram_s1_shift_register;
  output           cpu_data_master_requests_sdram_s1;
  output           cpu_instruction_master_granted_sdram_s1;
  output           cpu_instruction_master_qualified_request_sdram_s1;
  output           cpu_instruction_master_read_data_valid_sdram_s1;
  output           cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  output           cpu_instruction_master_requests_sdram_s1;
  output           d1_sdram_s1_end_xfer;
  output  [ 23: 0] sdram_s1_address;
  output  [  1: 0] sdram_s1_byteenable_n;
  output           sdram_s1_chipselect;
  output           sdram_s1_read_n;
  output  [ 15: 0] sdram_s1_readdata_from_sa;
  output           sdram_s1_reset_n;
  output           sdram_s1_waitrequest_from_sa;
  output           sdram_s1_write_n;
  output  [ 15: 0] sdram_s1_writedata;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input   [  3: 0] cpu_data_master_byteenable;
  input   [  1: 0] cpu_data_master_dbs_address;
  input   [ 15: 0] cpu_data_master_dbs_write_16;
  input            cpu_data_master_no_byte_enables_and_last_term;
  input            cpu_data_master_read;
  input            cpu_data_master_waitrequest;
  input            cpu_data_master_write;
  input   [ 26: 0] cpu_instruction_master_address_to_slave;
  input   [  1: 0] cpu_instruction_master_dbs_address;
  input            cpu_instruction_master_latency_counter;
  input            cpu_instruction_master_read;
  input            reset_n;
  input   [ 15: 0] sdram_s1_readdata;
  input            sdram_s1_readdatavalid;
  input            sdram_s1_waitrequest;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1_segment_0;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1_segment_1;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sdram_s1;
  wire             cpu_data_master_qualified_request_sdram_s1;
  wire             cpu_data_master_rdv_fifo_empty_sdram_s1;
  wire             cpu_data_master_rdv_fifo_output_from_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_data_master_requests_sdram_s1;
  wire             cpu_data_master_saved_grant_sdram_s1;
  wire             cpu_instruction_master_arbiterlock;
  wire             cpu_instruction_master_arbiterlock2;
  wire             cpu_instruction_master_continuerequest;
  wire             cpu_instruction_master_granted_sdram_s1;
  wire             cpu_instruction_master_qualified_request_sdram_s1;
  wire             cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  wire             cpu_instruction_master_rdv_fifo_output_from_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_instruction_master_requests_sdram_s1;
  wire             cpu_instruction_master_saved_grant_sdram_s1;
  reg              d1_reasons_to_wait;
  reg              d1_sdram_s1_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sdram_s1;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  reg              last_cycle_cpu_data_master_granted_slave_sdram_s1;
  reg              last_cycle_cpu_instruction_master_granted_slave_sdram_s1;
  wire    [ 23: 0] sdram_s1_address;
  wire             sdram_s1_allgrants;
  wire             sdram_s1_allow_new_arb_cycle;
  wire             sdram_s1_any_bursting_master_saved_grant;
  wire             sdram_s1_any_continuerequest;
  reg     [  1: 0] sdram_s1_arb_addend;
  wire             sdram_s1_arb_counter_enable;
  reg     [  1: 0] sdram_s1_arb_share_counter;
  wire    [  1: 0] sdram_s1_arb_share_counter_next_value;
  wire    [  1: 0] sdram_s1_arb_share_set_values;
  wire    [  1: 0] sdram_s1_arb_winner;
  wire             sdram_s1_arbitration_holdoff_internal;
  wire             sdram_s1_beginbursttransfer_internal;
  wire             sdram_s1_begins_xfer;
  wire    [  1: 0] sdram_s1_byteenable_n;
  wire             sdram_s1_chipselect;
  wire    [  3: 0] sdram_s1_chosen_master_double_vector;
  wire    [  1: 0] sdram_s1_chosen_master_rot_left;
  wire             sdram_s1_end_xfer;
  wire             sdram_s1_firsttransfer;
  wire    [  1: 0] sdram_s1_grant_vector;
  wire             sdram_s1_in_a_read_cycle;
  wire             sdram_s1_in_a_write_cycle;
  wire    [  1: 0] sdram_s1_master_qreq_vector;
  wire             sdram_s1_move_on_to_next_transaction;
  wire             sdram_s1_non_bursting_master_requests;
  wire             sdram_s1_read_n;
  wire    [ 15: 0] sdram_s1_readdata_from_sa;
  wire             sdram_s1_readdatavalid_from_sa;
  reg              sdram_s1_reg_firsttransfer;
  wire             sdram_s1_reset_n;
  reg     [  1: 0] sdram_s1_saved_chosen_master_vector;
  reg              sdram_s1_slavearbiterlockenable;
  wire             sdram_s1_slavearbiterlockenable2;
  wire             sdram_s1_unreg_firsttransfer;
  wire             sdram_s1_waitrequest_from_sa;
  wire             sdram_s1_waits_for_read;
  wire             sdram_s1_waits_for_write;
  wire             sdram_s1_write_n;
  wire    [ 15: 0] sdram_s1_writedata;
  wire    [ 26: 0] shifted_address_to_sdram_s1_from_cpu_data_master;
  wire    [ 26: 0] shifted_address_to_sdram_s1_from_cpu_instruction_master;
  wire             wait_for_sdram_s1_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sdram_s1_end_xfer;
    end


  assign sdram_s1_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sdram_s1 | cpu_instruction_master_qualified_request_sdram_s1));
  //assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_readdatavalid_from_sa = sdram_s1_readdatavalid;

  //assign sdram_s1_readdata_from_sa = sdram_s1_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_readdata_from_sa = sdram_s1_readdata;

  assign cpu_data_master_requests_sdram_s1 = ({cpu_data_master_address_to_slave[26 : 25] , 25'b0} == 27'h4000000) & (cpu_data_master_read | cpu_data_master_write);
  //assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sdram_s1_waitrequest_from_sa = sdram_s1_waitrequest;

  //sdram_s1_arb_share_counter set values, which is an e_mux
  assign sdram_s1_arb_share_set_values = (cpu_data_master_granted_sdram_s1)? 2 :
    (cpu_instruction_master_granted_sdram_s1)? 2 :
    (cpu_data_master_granted_sdram_s1)? 2 :
    (cpu_instruction_master_granted_sdram_s1)? 2 :
    1;

  //sdram_s1_non_bursting_master_requests mux, which is an e_mux
  assign sdram_s1_non_bursting_master_requests = cpu_data_master_requests_sdram_s1 |
    cpu_instruction_master_requests_sdram_s1 |
    cpu_data_master_requests_sdram_s1 |
    cpu_instruction_master_requests_sdram_s1;

  //sdram_s1_any_bursting_master_saved_grant mux, which is an e_mux
  assign sdram_s1_any_bursting_master_saved_grant = 0;

  //sdram_s1_arb_share_counter_next_value assignment, which is an e_assign
  assign sdram_s1_arb_share_counter_next_value = sdram_s1_firsttransfer ? (sdram_s1_arb_share_set_values - 1) : |sdram_s1_arb_share_counter ? (sdram_s1_arb_share_counter - 1) : 0;

  //sdram_s1_allgrants all slave grants, which is an e_mux
  assign sdram_s1_allgrants = (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector) |
    (|sdram_s1_grant_vector);

  //sdram_s1_end_xfer assignment, which is an e_assign
  assign sdram_s1_end_xfer = ~(sdram_s1_waits_for_read | sdram_s1_waits_for_write);

  //end_xfer_arb_share_counter_term_sdram_s1 arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sdram_s1 = sdram_s1_end_xfer & (~sdram_s1_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sdram_s1_arb_share_counter arbitration counter enable, which is an e_assign
  assign sdram_s1_arb_counter_enable = (end_xfer_arb_share_counter_term_sdram_s1 & sdram_s1_allgrants) | (end_xfer_arb_share_counter_term_sdram_s1 & ~sdram_s1_non_bursting_master_requests);

  //sdram_s1_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_arb_share_counter <= 0;
      else if (sdram_s1_arb_counter_enable)
          sdram_s1_arb_share_counter <= sdram_s1_arb_share_counter_next_value;
    end


  //sdram_s1_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_slavearbiterlockenable <= 0;
      else if ((|sdram_s1_master_qreq_vector & end_xfer_arb_share_counter_term_sdram_s1) | (end_xfer_arb_share_counter_term_sdram_s1 & ~sdram_s1_non_bursting_master_requests))
          sdram_s1_slavearbiterlockenable <= |sdram_s1_arb_share_counter_next_value;
    end


  //cpu/data_master sdram/s1 arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sdram_s1_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sdram_s1_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sdram_s1_slavearbiterlockenable2 = |sdram_s1_arb_share_counter_next_value;

  //cpu/data_master sdram/s1 arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sdram_s1_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //cpu/instruction_master sdram/s1 arbiterlock, which is an e_assign
  assign cpu_instruction_master_arbiterlock = sdram_s1_slavearbiterlockenable & cpu_instruction_master_continuerequest;

  //cpu/instruction_master sdram/s1 arbiterlock2, which is an e_assign
  assign cpu_instruction_master_arbiterlock2 = sdram_s1_slavearbiterlockenable2 & cpu_instruction_master_continuerequest;

  //cpu/instruction_master granted sdram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= 0;
      else 
        last_cycle_cpu_instruction_master_granted_slave_sdram_s1 <= cpu_instruction_master_saved_grant_sdram_s1 ? 1 : (sdram_s1_arbitration_holdoff_internal | ~cpu_instruction_master_requests_sdram_s1) ? 0 : last_cycle_cpu_instruction_master_granted_slave_sdram_s1;
    end


  //cpu_instruction_master_continuerequest continued request, which is an e_mux
  assign cpu_instruction_master_continuerequest = last_cycle_cpu_instruction_master_granted_slave_sdram_s1 & cpu_instruction_master_requests_sdram_s1;

  //sdram_s1_any_continuerequest at least one master continues requesting, which is an e_mux
  assign sdram_s1_any_continuerequest = cpu_instruction_master_continuerequest |
    cpu_data_master_continuerequest;

  assign cpu_data_master_qualified_request_sdram_s1 = cpu_data_master_requests_sdram_s1 & ~((cpu_data_master_read & (~cpu_data_master_waitrequest | (|cpu_data_master_read_data_valid_sdram_s1_shift_register))) | ((~cpu_data_master_waitrequest | cpu_data_master_no_byte_enables_and_last_term | !cpu_data_master_byteenable_sdram_s1) & cpu_data_master_write) | cpu_instruction_master_arbiterlock);
  //unique name for sdram_s1_move_on_to_next_transaction, which is an e_assign
  assign sdram_s1_move_on_to_next_transaction = sdram_s1_readdatavalid_from_sa;

  //rdv_fifo_for_cpu_data_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_data_master_to_sdram_s1_module rdv_fifo_for_cpu_data_master_to_sdram_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_data_master_granted_sdram_s1),
      .data_out             (cpu_data_master_rdv_fifo_output_from_sdram_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_data_master_rdv_fifo_empty_sdram_s1),
      .full                 (),
      .read                 (sdram_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_s1_waits_for_read)
    );

  assign cpu_data_master_read_data_valid_sdram_s1_shift_register = ~cpu_data_master_rdv_fifo_empty_sdram_s1;
  //local readdatavalid cpu_data_master_read_data_valid_sdram_s1, which is an e_mux
  assign cpu_data_master_read_data_valid_sdram_s1 = (sdram_s1_readdatavalid_from_sa & cpu_data_master_rdv_fifo_output_from_sdram_s1) & ~ cpu_data_master_rdv_fifo_empty_sdram_s1;

  //sdram_s1_writedata mux, which is an e_mux
  assign sdram_s1_writedata = cpu_data_master_dbs_write_16;

  assign cpu_instruction_master_requests_sdram_s1 = (({cpu_instruction_master_address_to_slave[26 : 25] , 25'b0} == 27'h4000000) & (cpu_instruction_master_read)) & cpu_instruction_master_read;
  //cpu/data_master granted sdram/s1 last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          last_cycle_cpu_data_master_granted_slave_sdram_s1 <= 0;
      else 
        last_cycle_cpu_data_master_granted_slave_sdram_s1 <= cpu_data_master_saved_grant_sdram_s1 ? 1 : (sdram_s1_arbitration_holdoff_internal | ~cpu_data_master_requests_sdram_s1) ? 0 : last_cycle_cpu_data_master_granted_slave_sdram_s1;
    end


  //cpu_data_master_continuerequest continued request, which is an e_mux
  assign cpu_data_master_continuerequest = last_cycle_cpu_data_master_granted_slave_sdram_s1 & cpu_data_master_requests_sdram_s1;

  assign cpu_instruction_master_qualified_request_sdram_s1 = cpu_instruction_master_requests_sdram_s1 & ~((cpu_instruction_master_read & ((cpu_instruction_master_latency_counter != 0) | (1 < cpu_instruction_master_latency_counter))) | cpu_data_master_arbiterlock);
  //rdv_fifo_for_cpu_instruction_master_to_sdram_s1, which is an e_fifo_with_registered_outputs
  rdv_fifo_for_cpu_instruction_master_to_sdram_s1_module rdv_fifo_for_cpu_instruction_master_to_sdram_s1
    (
      .clear_fifo           (1'b0),
      .clk                  (clk),
      .data_in              (cpu_instruction_master_granted_sdram_s1),
      .data_out             (cpu_instruction_master_rdv_fifo_output_from_sdram_s1),
      .empty                (),
      .fifo_contains_ones_n (cpu_instruction_master_rdv_fifo_empty_sdram_s1),
      .full                 (),
      .read                 (sdram_s1_move_on_to_next_transaction),
      .reset_n              (reset_n),
      .sync_reset           (1'b0),
      .write                (in_a_read_cycle & ~sdram_s1_waits_for_read)
    );

  assign cpu_instruction_master_read_data_valid_sdram_s1_shift_register = ~cpu_instruction_master_rdv_fifo_empty_sdram_s1;
  //local readdatavalid cpu_instruction_master_read_data_valid_sdram_s1, which is an e_mux
  assign cpu_instruction_master_read_data_valid_sdram_s1 = (sdram_s1_readdatavalid_from_sa & cpu_instruction_master_rdv_fifo_output_from_sdram_s1) & ~ cpu_instruction_master_rdv_fifo_empty_sdram_s1;

  //allow new arb cycle for sdram/s1, which is an e_assign
  assign sdram_s1_allow_new_arb_cycle = ~cpu_data_master_arbiterlock & ~cpu_instruction_master_arbiterlock;

  //cpu/instruction_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  assign sdram_s1_master_qreq_vector[0] = cpu_instruction_master_qualified_request_sdram_s1;

  //cpu/instruction_master grant sdram/s1, which is an e_assign
  assign cpu_instruction_master_granted_sdram_s1 = sdram_s1_grant_vector[0];

  //cpu/instruction_master saved-grant sdram/s1, which is an e_assign
  assign cpu_instruction_master_saved_grant_sdram_s1 = sdram_s1_arb_winner[0] && cpu_instruction_master_requests_sdram_s1;

  //cpu/data_master assignment into master qualified-requests vector for sdram/s1, which is an e_assign
  assign sdram_s1_master_qreq_vector[1] = cpu_data_master_qualified_request_sdram_s1;

  //cpu/data_master grant sdram/s1, which is an e_assign
  assign cpu_data_master_granted_sdram_s1 = sdram_s1_grant_vector[1];

  //cpu/data_master saved-grant sdram/s1, which is an e_assign
  assign cpu_data_master_saved_grant_sdram_s1 = sdram_s1_arb_winner[1] && cpu_data_master_requests_sdram_s1;

  //sdram/s1 chosen-master double-vector, which is an e_assign
  assign sdram_s1_chosen_master_double_vector = {sdram_s1_master_qreq_vector, sdram_s1_master_qreq_vector} & ({~sdram_s1_master_qreq_vector, ~sdram_s1_master_qreq_vector} + sdram_s1_arb_addend);

  //stable onehot encoding of arb winner
  assign sdram_s1_arb_winner = (sdram_s1_allow_new_arb_cycle & | sdram_s1_grant_vector) ? sdram_s1_grant_vector : sdram_s1_saved_chosen_master_vector;

  //saved sdram_s1_grant_vector, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_saved_chosen_master_vector <= 0;
      else if (sdram_s1_allow_new_arb_cycle)
          sdram_s1_saved_chosen_master_vector <= |sdram_s1_grant_vector ? sdram_s1_grant_vector : sdram_s1_saved_chosen_master_vector;
    end


  //onehot encoding of chosen master
  assign sdram_s1_grant_vector = {(sdram_s1_chosen_master_double_vector[1] | sdram_s1_chosen_master_double_vector[3]),
    (sdram_s1_chosen_master_double_vector[0] | sdram_s1_chosen_master_double_vector[2])};

  //sdram/s1 chosen master rotated left, which is an e_assign
  assign sdram_s1_chosen_master_rot_left = (sdram_s1_arb_winner << 1) ? (sdram_s1_arb_winner << 1) : 1;

  //sdram/s1's addend for next-master-grant
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_arb_addend <= 1;
      else if (|sdram_s1_grant_vector)
          sdram_s1_arb_addend <= sdram_s1_end_xfer? sdram_s1_chosen_master_rot_left : sdram_s1_grant_vector;
    end


  //sdram_s1_reset_n assignment, which is an e_assign
  assign sdram_s1_reset_n = reset_n;

  assign sdram_s1_chipselect = cpu_data_master_granted_sdram_s1 | cpu_instruction_master_granted_sdram_s1;
  //sdram_s1_firsttransfer first transaction, which is an e_assign
  assign sdram_s1_firsttransfer = sdram_s1_begins_xfer ? sdram_s1_unreg_firsttransfer : sdram_s1_reg_firsttransfer;

  //sdram_s1_unreg_firsttransfer first transaction, which is an e_assign
  assign sdram_s1_unreg_firsttransfer = ~(sdram_s1_slavearbiterlockenable & sdram_s1_any_continuerequest);

  //sdram_s1_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sdram_s1_reg_firsttransfer <= 1'b1;
      else if (sdram_s1_begins_xfer)
          sdram_s1_reg_firsttransfer <= sdram_s1_unreg_firsttransfer;
    end


  //sdram_s1_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sdram_s1_beginbursttransfer_internal = sdram_s1_begins_xfer;

  //sdram_s1_arbitration_holdoff_internal arbitration_holdoff, which is an e_assign
  assign sdram_s1_arbitration_holdoff_internal = sdram_s1_begins_xfer & sdram_s1_firsttransfer;

  //~sdram_s1_read_n assignment, which is an e_mux
  assign sdram_s1_read_n = ~((cpu_data_master_granted_sdram_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read));

  //~sdram_s1_write_n assignment, which is an e_mux
  assign sdram_s1_write_n = ~(cpu_data_master_granted_sdram_s1 & cpu_data_master_write);

  assign shifted_address_to_sdram_s1_from_cpu_data_master = {cpu_data_master_address_to_slave >> 2,
    cpu_data_master_dbs_address[1],
    {1 {1'b0}}};

  //sdram_s1_address mux, which is an e_mux
  assign sdram_s1_address = (cpu_data_master_granted_sdram_s1)? (shifted_address_to_sdram_s1_from_cpu_data_master >> 1) :
    (shifted_address_to_sdram_s1_from_cpu_instruction_master >> 1);

  assign shifted_address_to_sdram_s1_from_cpu_instruction_master = {cpu_instruction_master_address_to_slave >> 2,
    cpu_instruction_master_dbs_address[1],
    {1 {1'b0}}};

  //d1_sdram_s1_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sdram_s1_end_xfer <= 1;
      else 
        d1_sdram_s1_end_xfer <= sdram_s1_end_xfer;
    end


  //sdram_s1_waits_for_read in a cycle, which is an e_mux
  assign sdram_s1_waits_for_read = sdram_s1_in_a_read_cycle & sdram_s1_waitrequest_from_sa;

  //sdram_s1_in_a_read_cycle assignment, which is an e_assign
  assign sdram_s1_in_a_read_cycle = (cpu_data_master_granted_sdram_s1 & cpu_data_master_read) | (cpu_instruction_master_granted_sdram_s1 & cpu_instruction_master_read);

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sdram_s1_in_a_read_cycle;

  //sdram_s1_waits_for_write in a cycle, which is an e_mux
  assign sdram_s1_waits_for_write = sdram_s1_in_a_write_cycle & sdram_s1_waitrequest_from_sa;

  //sdram_s1_in_a_write_cycle assignment, which is an e_assign
  assign sdram_s1_in_a_write_cycle = cpu_data_master_granted_sdram_s1 & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sdram_s1_in_a_write_cycle;

  assign wait_for_sdram_s1_counter = 0;
  //~sdram_s1_byteenable_n byte enable port mux, which is an e_mux
  assign sdram_s1_byteenable_n = ~((cpu_data_master_granted_sdram_s1)? cpu_data_master_byteenable_sdram_s1 :
    -1);

  assign {cpu_data_master_byteenable_sdram_s1_segment_1,
cpu_data_master_byteenable_sdram_s1_segment_0} = cpu_data_master_byteenable;
  assign cpu_data_master_byteenable_sdram_s1 = ((cpu_data_master_dbs_address[1] == 0))? cpu_data_master_byteenable_sdram_s1_segment_0 :
    cpu_data_master_byteenable_sdram_s1_segment_1;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sdram/s1 enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end


  //grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_granted_sdram_s1 + cpu_instruction_master_granted_sdram_s1 > 1)
        begin
          $write("%0d ns: > 1 of grant signals are active simultaneously", $time);
          $stop;
        end
    end


  //saved_grant signals are active simultaneously, which is an e_process
  always @(posedge clk)
    begin
      if (cpu_data_master_saved_grant_sdram_s1 + cpu_instruction_master_saved_grant_sdram_s1 > 1)
        begin
          $write("%0d ns: > 1 of saved_grant signals are active simultaneously", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module sysid_control_slave_arbitrator (
                                        // inputs:
                                         clk,
                                         cpu_data_master_address_to_slave,
                                         cpu_data_master_read,
                                         cpu_data_master_write,
                                         reset_n,
                                         sysid_control_slave_readdata,

                                        // outputs:
                                         cpu_data_master_granted_sysid_control_slave,
                                         cpu_data_master_qualified_request_sysid_control_slave,
                                         cpu_data_master_read_data_valid_sysid_control_slave,
                                         cpu_data_master_requests_sysid_control_slave,
                                         d1_sysid_control_slave_end_xfer,
                                         sysid_control_slave_address,
                                         sysid_control_slave_readdata_from_sa,
                                         sysid_control_slave_reset_n
                                      )
;

  output           cpu_data_master_granted_sysid_control_slave;
  output           cpu_data_master_qualified_request_sysid_control_slave;
  output           cpu_data_master_read_data_valid_sysid_control_slave;
  output           cpu_data_master_requests_sysid_control_slave;
  output           d1_sysid_control_slave_end_xfer;
  output           sysid_control_slave_address;
  output  [ 31: 0] sysid_control_slave_readdata_from_sa;
  output           sysid_control_slave_reset_n;
  input            clk;
  input   [ 26: 0] cpu_data_master_address_to_slave;
  input            cpu_data_master_read;
  input            cpu_data_master_write;
  input            reset_n;
  input   [ 31: 0] sysid_control_slave_readdata;

  wire             cpu_data_master_arbiterlock;
  wire             cpu_data_master_arbiterlock2;
  wire             cpu_data_master_continuerequest;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_saved_grant_sysid_control_slave;
  reg              d1_reasons_to_wait;
  reg              d1_sysid_control_slave_end_xfer;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_sysid_control_slave;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire    [ 26: 0] shifted_address_to_sysid_control_slave_from_cpu_data_master;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_allgrants;
  wire             sysid_control_slave_allow_new_arb_cycle;
  wire             sysid_control_slave_any_bursting_master_saved_grant;
  wire             sysid_control_slave_any_continuerequest;
  wire             sysid_control_slave_arb_counter_enable;
  reg     [  1: 0] sysid_control_slave_arb_share_counter;
  wire    [  1: 0] sysid_control_slave_arb_share_counter_next_value;
  wire    [  1: 0] sysid_control_slave_arb_share_set_values;
  wire             sysid_control_slave_beginbursttransfer_internal;
  wire             sysid_control_slave_begins_xfer;
  wire             sysid_control_slave_end_xfer;
  wire             sysid_control_slave_firsttransfer;
  wire             sysid_control_slave_grant_vector;
  wire             sysid_control_slave_in_a_read_cycle;
  wire             sysid_control_slave_in_a_write_cycle;
  wire             sysid_control_slave_master_qreq_vector;
  wire             sysid_control_slave_non_bursting_master_requests;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  reg              sysid_control_slave_reg_firsttransfer;
  wire             sysid_control_slave_reset_n;
  reg              sysid_control_slave_slavearbiterlockenable;
  wire             sysid_control_slave_slavearbiterlockenable2;
  wire             sysid_control_slave_unreg_firsttransfer;
  wire             sysid_control_slave_waits_for_read;
  wire             sysid_control_slave_waits_for_write;
  wire             wait_for_sysid_control_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~sysid_control_slave_end_xfer;
    end


  assign sysid_control_slave_begins_xfer = ~d1_reasons_to_wait & ((cpu_data_master_qualified_request_sysid_control_slave));
  //assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign sysid_control_slave_readdata_from_sa = sysid_control_slave_readdata;

  assign cpu_data_master_requests_sysid_control_slave = (({cpu_data_master_address_to_slave[26 : 3] , 3'b0} == 27'h1910) & (cpu_data_master_read | cpu_data_master_write)) & cpu_data_master_read;
  //sysid_control_slave_arb_share_counter set values, which is an e_mux
  assign sysid_control_slave_arb_share_set_values = 1;

  //sysid_control_slave_non_bursting_master_requests mux, which is an e_mux
  assign sysid_control_slave_non_bursting_master_requests = cpu_data_master_requests_sysid_control_slave;

  //sysid_control_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign sysid_control_slave_any_bursting_master_saved_grant = 0;

  //sysid_control_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign sysid_control_slave_arb_share_counter_next_value = sysid_control_slave_firsttransfer ? (sysid_control_slave_arb_share_set_values - 1) : |sysid_control_slave_arb_share_counter ? (sysid_control_slave_arb_share_counter - 1) : 0;

  //sysid_control_slave_allgrants all slave grants, which is an e_mux
  assign sysid_control_slave_allgrants = |sysid_control_slave_grant_vector;

  //sysid_control_slave_end_xfer assignment, which is an e_assign
  assign sysid_control_slave_end_xfer = ~(sysid_control_slave_waits_for_read | sysid_control_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_sysid_control_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_sysid_control_slave = sysid_control_slave_end_xfer & (~sysid_control_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //sysid_control_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign sysid_control_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_sysid_control_slave & sysid_control_slave_allgrants) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests);

  //sysid_control_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_arb_share_counter <= 0;
      else if (sysid_control_slave_arb_counter_enable)
          sysid_control_slave_arb_share_counter <= sysid_control_slave_arb_share_counter_next_value;
    end


  //sysid_control_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_slavearbiterlockenable <= 0;
      else if ((|sysid_control_slave_master_qreq_vector & end_xfer_arb_share_counter_term_sysid_control_slave) | (end_xfer_arb_share_counter_term_sysid_control_slave & ~sysid_control_slave_non_bursting_master_requests))
          sysid_control_slave_slavearbiterlockenable <= |sysid_control_slave_arb_share_counter_next_value;
    end


  //cpu/data_master sysid/control_slave arbiterlock, which is an e_assign
  assign cpu_data_master_arbiterlock = sysid_control_slave_slavearbiterlockenable & cpu_data_master_continuerequest;

  //sysid_control_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign sysid_control_slave_slavearbiterlockenable2 = |sysid_control_slave_arb_share_counter_next_value;

  //cpu/data_master sysid/control_slave arbiterlock2, which is an e_assign
  assign cpu_data_master_arbiterlock2 = sysid_control_slave_slavearbiterlockenable2 & cpu_data_master_continuerequest;

  //sysid_control_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign sysid_control_slave_any_continuerequest = 1;

  //cpu_data_master_continuerequest continued request, which is an e_assign
  assign cpu_data_master_continuerequest = 1;

  assign cpu_data_master_qualified_request_sysid_control_slave = cpu_data_master_requests_sysid_control_slave;
  //master is always granted when requested
  assign cpu_data_master_granted_sysid_control_slave = cpu_data_master_qualified_request_sysid_control_slave;

  //cpu/data_master saved-grant sysid/control_slave, which is an e_assign
  assign cpu_data_master_saved_grant_sysid_control_slave = cpu_data_master_requests_sysid_control_slave;

  //allow new arb cycle for sysid/control_slave, which is an e_assign
  assign sysid_control_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign sysid_control_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign sysid_control_slave_master_qreq_vector = 1;

  //sysid_control_slave_reset_n assignment, which is an e_assign
  assign sysid_control_slave_reset_n = reset_n;

  //sysid_control_slave_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_firsttransfer = sysid_control_slave_begins_xfer ? sysid_control_slave_unreg_firsttransfer : sysid_control_slave_reg_firsttransfer;

  //sysid_control_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign sysid_control_slave_unreg_firsttransfer = ~(sysid_control_slave_slavearbiterlockenable & sysid_control_slave_any_continuerequest);

  //sysid_control_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          sysid_control_slave_reg_firsttransfer <= 1'b1;
      else if (sysid_control_slave_begins_xfer)
          sysid_control_slave_reg_firsttransfer <= sysid_control_slave_unreg_firsttransfer;
    end


  //sysid_control_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign sysid_control_slave_beginbursttransfer_internal = sysid_control_slave_begins_xfer;

  assign shifted_address_to_sysid_control_slave_from_cpu_data_master = cpu_data_master_address_to_slave;
  //sysid_control_slave_address mux, which is an e_mux
  assign sysid_control_slave_address = shifted_address_to_sysid_control_slave_from_cpu_data_master >> 2;

  //d1_sysid_control_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_sysid_control_slave_end_xfer <= 1;
      else 
        d1_sysid_control_slave_end_xfer <= sysid_control_slave_end_xfer;
    end


  //sysid_control_slave_waits_for_read in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_read = sysid_control_slave_in_a_read_cycle & sysid_control_slave_begins_xfer;

  //sysid_control_slave_in_a_read_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_read_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = sysid_control_slave_in_a_read_cycle;

  //sysid_control_slave_waits_for_write in a cycle, which is an e_mux
  assign sysid_control_slave_waits_for_write = sysid_control_slave_in_a_write_cycle & 0;

  //sysid_control_slave_in_a_write_cycle assignment, which is an e_assign
  assign sysid_control_slave_in_a_write_cycle = cpu_data_master_granted_sysid_control_slave & cpu_data_master_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = sysid_control_slave_in_a_write_cycle;

  assign wait_for_sysid_control_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //sysid/control_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module NIOSTOP_reset_clk_domain_synch_module (
                                               // inputs:
                                                clk,
                                                data_in,
                                                reset_n,

                                               // outputs:
                                                data_out
                                             )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module NIOSTOP (
                 // 1) global signals:
                  clk,
                  reset_n,

                 // the_LAN
                  MISO_to_the_LAN,
                  MOSI_from_the_LAN,
                  SCLK_from_the_LAN,
                  SS_n_from_the_LAN,

                 // the_LAN_CS
                  out_port_from_the_LAN_CS,

                 // the_LAN_RSTN
                  out_port_from_the_LAN_RSTN,

                 // the_LAN_nINT
                  in_port_to_the_LAN_nINT,

                 // the_NET_EN
                  in_port_to_the_NET_EN,

                 // the_NET_TESTDO
                  out_port_from_the_NET_TESTDO,

                 // the_USBSD_RDO
                  out_port_from_the_USBSD_RDO,

                 // the_USBSD_RVLD
                  out_port_from_the_USBSD_RVLD,

                 // the_USBSD_SEL
                  in_port_to_the_USBSD_SEL,

                 // the_USB_EN
                  in_port_to_the_USB_EN,

                 // the_USB_INT_I
                  in_port_to_the_USB_INT_I,

                 // the_USB_SCK_O
                  out_port_from_the_USB_SCK_O,

                 // the_USB_SCS_O
                  out_port_from_the_USB_SCS_O,

                 // the_USB_SDI_O
                  out_port_from_the_USB_SDI_O,

                 // the_USB_SDO_I
                  in_port_to_the_USB_SDO_I,

                 // the_epcs
                  data0_to_the_epcs,
                  dclk_from_the_epcs,
                  sce_from_the_epcs,
                  sdo_from_the_epcs,

                 // the_pio_led
                  out_port_from_the_pio_led,

                 // the_sdram
                  zs_addr_from_the_sdram,
                  zs_ba_from_the_sdram,
                  zs_cas_n_from_the_sdram,
                  zs_cke_from_the_sdram,
                  zs_cs_n_from_the_sdram,
                  zs_dq_to_and_from_the_sdram,
                  zs_dqm_from_the_sdram,
                  zs_ras_n_from_the_sdram,
                  zs_we_n_from_the_sdram
               )
;

  output           MOSI_from_the_LAN;
  output           SCLK_from_the_LAN;
  output           SS_n_from_the_LAN;
  output           dclk_from_the_epcs;
  output           out_port_from_the_LAN_CS;
  output           out_port_from_the_LAN_RSTN;
  output           out_port_from_the_NET_TESTDO;
  output  [ 15: 0] out_port_from_the_USBSD_RDO;
  output           out_port_from_the_USBSD_RVLD;
  output           out_port_from_the_USB_SCK_O;
  output           out_port_from_the_USB_SCS_O;
  output           out_port_from_the_USB_SDI_O;
  output  [  3: 0] out_port_from_the_pio_led;
  output           sce_from_the_epcs;
  output           sdo_from_the_epcs;
  output  [ 12: 0] zs_addr_from_the_sdram;
  output  [  1: 0] zs_ba_from_the_sdram;
  output           zs_cas_n_from_the_sdram;
  output           zs_cke_from_the_sdram;
  output           zs_cs_n_from_the_sdram;
  inout   [ 15: 0] zs_dq_to_and_from_the_sdram;
  output  [  1: 0] zs_dqm_from_the_sdram;
  output           zs_ras_n_from_the_sdram;
  output           zs_we_n_from_the_sdram;
  input            MISO_to_the_LAN;
  input            clk;
  input            data0_to_the_epcs;
  input            in_port_to_the_LAN_nINT;
  input            in_port_to_the_NET_EN;
  input            in_port_to_the_USBSD_SEL;
  input            in_port_to_the_USB_EN;
  input            in_port_to_the_USB_INT_I;
  input            in_port_to_the_USB_SDO_I;
  input            reset_n;

  wire    [  1: 0] LAN_CS_s1_address;
  wire             LAN_CS_s1_chipselect;
  wire    [ 31: 0] LAN_CS_s1_readdata;
  wire    [ 31: 0] LAN_CS_s1_readdata_from_sa;
  wire             LAN_CS_s1_reset_n;
  wire             LAN_CS_s1_write_n;
  wire    [ 31: 0] LAN_CS_s1_writedata;
  wire    [  1: 0] LAN_RSTN_s1_address;
  wire             LAN_RSTN_s1_chipselect;
  wire    [ 31: 0] LAN_RSTN_s1_readdata;
  wire    [ 31: 0] LAN_RSTN_s1_readdata_from_sa;
  wire             LAN_RSTN_s1_reset_n;
  wire             LAN_RSTN_s1_write_n;
  wire    [ 31: 0] LAN_RSTN_s1_writedata;
  wire    [  1: 0] LAN_nINT_s1_address;
  wire             LAN_nINT_s1_chipselect;
  wire             LAN_nINT_s1_irq;
  wire    [ 31: 0] LAN_nINT_s1_readdata;
  wire    [ 31: 0] LAN_nINT_s1_readdata_from_sa;
  wire             LAN_nINT_s1_reset_n;
  wire             LAN_nINT_s1_write_n;
  wire    [ 31: 0] LAN_nINT_s1_writedata;
  wire    [  2: 0] LAN_spi_control_port_address;
  wire             LAN_spi_control_port_chipselect;
  wire             LAN_spi_control_port_dataavailable;
  wire             LAN_spi_control_port_dataavailable_from_sa;
  wire             LAN_spi_control_port_endofpacket;
  wire             LAN_spi_control_port_endofpacket_from_sa;
  wire             LAN_spi_control_port_irq;
  wire             LAN_spi_control_port_irq_from_sa;
  wire             LAN_spi_control_port_read_n;
  wire    [ 15: 0] LAN_spi_control_port_readdata;
  wire    [ 15: 0] LAN_spi_control_port_readdata_from_sa;
  wire             LAN_spi_control_port_readyfordata;
  wire             LAN_spi_control_port_readyfordata_from_sa;
  wire             LAN_spi_control_port_reset_n;
  wire             LAN_spi_control_port_write_n;
  wire    [ 15: 0] LAN_spi_control_port_writedata;
  wire             MOSI_from_the_LAN;
  wire    [  1: 0] NET_EN_s1_address;
  wire    [ 31: 0] NET_EN_s1_readdata;
  wire    [ 31: 0] NET_EN_s1_readdata_from_sa;
  wire             NET_EN_s1_reset_n;
  wire    [  1: 0] NET_TESTDO_s1_address;
  wire             NET_TESTDO_s1_chipselect;
  wire    [ 31: 0] NET_TESTDO_s1_readdata;
  wire    [ 31: 0] NET_TESTDO_s1_readdata_from_sa;
  wire             NET_TESTDO_s1_reset_n;
  wire             NET_TESTDO_s1_write_n;
  wire    [ 31: 0] NET_TESTDO_s1_writedata;
  wire             SCLK_from_the_LAN;
  wire             SS_n_from_the_LAN;
  wire    [  1: 0] USBSD_RDO_s1_address;
  wire             USBSD_RDO_s1_chipselect;
  wire    [ 31: 0] USBSD_RDO_s1_readdata;
  wire    [ 31: 0] USBSD_RDO_s1_readdata_from_sa;
  wire             USBSD_RDO_s1_reset_n;
  wire             USBSD_RDO_s1_write_n;
  wire    [ 31: 0] USBSD_RDO_s1_writedata;
  wire    [  1: 0] USBSD_RVLD_s1_address;
  wire             USBSD_RVLD_s1_chipselect;
  wire    [ 31: 0] USBSD_RVLD_s1_readdata;
  wire    [ 31: 0] USBSD_RVLD_s1_readdata_from_sa;
  wire             USBSD_RVLD_s1_reset_n;
  wire             USBSD_RVLD_s1_write_n;
  wire    [ 31: 0] USBSD_RVLD_s1_writedata;
  wire    [  1: 0] USBSD_SEL_s1_address;
  wire    [ 31: 0] USBSD_SEL_s1_readdata;
  wire    [ 31: 0] USBSD_SEL_s1_readdata_from_sa;
  wire             USBSD_SEL_s1_reset_n;
  wire    [  1: 0] USB_EN_s1_address;
  wire    [ 31: 0] USB_EN_s1_readdata;
  wire    [ 31: 0] USB_EN_s1_readdata_from_sa;
  wire             USB_EN_s1_reset_n;
  wire    [  1: 0] USB_INT_I_s1_address;
  wire    [ 31: 0] USB_INT_I_s1_readdata;
  wire    [ 31: 0] USB_INT_I_s1_readdata_from_sa;
  wire             USB_INT_I_s1_reset_n;
  wire    [  1: 0] USB_SCK_O_s1_address;
  wire             USB_SCK_O_s1_chipselect;
  wire    [ 31: 0] USB_SCK_O_s1_readdata;
  wire    [ 31: 0] USB_SCK_O_s1_readdata_from_sa;
  wire             USB_SCK_O_s1_reset_n;
  wire             USB_SCK_O_s1_write_n;
  wire    [ 31: 0] USB_SCK_O_s1_writedata;
  wire    [  1: 0] USB_SCS_O_s1_address;
  wire             USB_SCS_O_s1_chipselect;
  wire    [ 31: 0] USB_SCS_O_s1_readdata;
  wire    [ 31: 0] USB_SCS_O_s1_readdata_from_sa;
  wire             USB_SCS_O_s1_reset_n;
  wire             USB_SCS_O_s1_write_n;
  wire    [ 31: 0] USB_SCS_O_s1_writedata;
  wire    [  1: 0] USB_SDI_O_s1_address;
  wire             USB_SDI_O_s1_chipselect;
  wire    [ 31: 0] USB_SDI_O_s1_readdata;
  wire    [ 31: 0] USB_SDI_O_s1_readdata_from_sa;
  wire             USB_SDI_O_s1_reset_n;
  wire             USB_SDI_O_s1_write_n;
  wire    [ 31: 0] USB_SDI_O_s1_writedata;
  wire    [  1: 0] USB_SDO_I_s1_address;
  wire    [ 31: 0] USB_SDO_I_s1_readdata;
  wire    [ 31: 0] USB_SDO_I_s1_readdata_from_sa;
  wire             USB_SDO_I_s1_reset_n;
  wire             clk_reset_n;
  wire    [ 26: 0] cpu_data_master_address;
  wire    [ 26: 0] cpu_data_master_address_to_slave;
  wire    [  3: 0] cpu_data_master_byteenable;
  wire    [  1: 0] cpu_data_master_byteenable_sdram_s1;
  wire    [  1: 0] cpu_data_master_dbs_address;
  wire    [ 15: 0] cpu_data_master_dbs_write_16;
  wire             cpu_data_master_debugaccess;
  wire             cpu_data_master_granted_LAN_CS_s1;
  wire             cpu_data_master_granted_LAN_RSTN_s1;
  wire             cpu_data_master_granted_LAN_nINT_s1;
  wire             cpu_data_master_granted_LAN_spi_control_port;
  wire             cpu_data_master_granted_NET_EN_s1;
  wire             cpu_data_master_granted_NET_TESTDO_s1;
  wire             cpu_data_master_granted_USBSD_RDO_s1;
  wire             cpu_data_master_granted_USBSD_RVLD_s1;
  wire             cpu_data_master_granted_USBSD_SEL_s1;
  wire             cpu_data_master_granted_USB_EN_s1;
  wire             cpu_data_master_granted_USB_INT_I_s1;
  wire             cpu_data_master_granted_USB_SCK_O_s1;
  wire             cpu_data_master_granted_USB_SCS_O_s1;
  wire             cpu_data_master_granted_USB_SDI_O_s1;
  wire             cpu_data_master_granted_USB_SDO_I_s1;
  wire             cpu_data_master_granted_cpu_jtag_debug_module;
  wire             cpu_data_master_granted_epcs_epcs_control_port;
  wire             cpu_data_master_granted_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_granted_pio_led_s1;
  wire             cpu_data_master_granted_sdram_s1;
  wire             cpu_data_master_granted_sysid_control_slave;
  wire    [ 31: 0] cpu_data_master_irq;
  wire             cpu_data_master_no_byte_enables_and_last_term;
  wire             cpu_data_master_qualified_request_LAN_CS_s1;
  wire             cpu_data_master_qualified_request_LAN_RSTN_s1;
  wire             cpu_data_master_qualified_request_LAN_nINT_s1;
  wire             cpu_data_master_qualified_request_LAN_spi_control_port;
  wire             cpu_data_master_qualified_request_NET_EN_s1;
  wire             cpu_data_master_qualified_request_NET_TESTDO_s1;
  wire             cpu_data_master_qualified_request_USBSD_RDO_s1;
  wire             cpu_data_master_qualified_request_USBSD_RVLD_s1;
  wire             cpu_data_master_qualified_request_USBSD_SEL_s1;
  wire             cpu_data_master_qualified_request_USB_EN_s1;
  wire             cpu_data_master_qualified_request_USB_INT_I_s1;
  wire             cpu_data_master_qualified_request_USB_SCK_O_s1;
  wire             cpu_data_master_qualified_request_USB_SCS_O_s1;
  wire             cpu_data_master_qualified_request_USB_SDI_O_s1;
  wire             cpu_data_master_qualified_request_USB_SDO_I_s1;
  wire             cpu_data_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_data_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_qualified_request_pio_led_s1;
  wire             cpu_data_master_qualified_request_sdram_s1;
  wire             cpu_data_master_qualified_request_sysid_control_slave;
  wire             cpu_data_master_read;
  wire             cpu_data_master_read_data_valid_LAN_CS_s1;
  wire             cpu_data_master_read_data_valid_LAN_RSTN_s1;
  wire             cpu_data_master_read_data_valid_LAN_nINT_s1;
  wire             cpu_data_master_read_data_valid_LAN_spi_control_port;
  wire             cpu_data_master_read_data_valid_NET_EN_s1;
  wire             cpu_data_master_read_data_valid_NET_TESTDO_s1;
  wire             cpu_data_master_read_data_valid_USBSD_RDO_s1;
  wire             cpu_data_master_read_data_valid_USBSD_RVLD_s1;
  wire             cpu_data_master_read_data_valid_USBSD_SEL_s1;
  wire             cpu_data_master_read_data_valid_USB_EN_s1;
  wire             cpu_data_master_read_data_valid_USB_INT_I_s1;
  wire             cpu_data_master_read_data_valid_USB_SCK_O_s1;
  wire             cpu_data_master_read_data_valid_USB_SCS_O_s1;
  wire             cpu_data_master_read_data_valid_USB_SDI_O_s1;
  wire             cpu_data_master_read_data_valid_USB_SDO_I_s1;
  wire             cpu_data_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_data_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_read_data_valid_pio_led_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1;
  wire             cpu_data_master_read_data_valid_sdram_s1_shift_register;
  wire             cpu_data_master_read_data_valid_sysid_control_slave;
  wire    [ 31: 0] cpu_data_master_readdata;
  wire             cpu_data_master_requests_LAN_CS_s1;
  wire             cpu_data_master_requests_LAN_RSTN_s1;
  wire             cpu_data_master_requests_LAN_nINT_s1;
  wire             cpu_data_master_requests_LAN_spi_control_port;
  wire             cpu_data_master_requests_NET_EN_s1;
  wire             cpu_data_master_requests_NET_TESTDO_s1;
  wire             cpu_data_master_requests_USBSD_RDO_s1;
  wire             cpu_data_master_requests_USBSD_RVLD_s1;
  wire             cpu_data_master_requests_USBSD_SEL_s1;
  wire             cpu_data_master_requests_USB_EN_s1;
  wire             cpu_data_master_requests_USB_INT_I_s1;
  wire             cpu_data_master_requests_USB_SCK_O_s1;
  wire             cpu_data_master_requests_USB_SCS_O_s1;
  wire             cpu_data_master_requests_USB_SDI_O_s1;
  wire             cpu_data_master_requests_USB_SDO_I_s1;
  wire             cpu_data_master_requests_cpu_jtag_debug_module;
  wire             cpu_data_master_requests_epcs_epcs_control_port;
  wire             cpu_data_master_requests_jtag_uart_avalon_jtag_slave;
  wire             cpu_data_master_requests_pio_led_s1;
  wire             cpu_data_master_requests_sdram_s1;
  wire             cpu_data_master_requests_sysid_control_slave;
  wire             cpu_data_master_waitrequest;
  wire             cpu_data_master_write;
  wire    [ 31: 0] cpu_data_master_writedata;
  wire    [ 26: 0] cpu_instruction_master_address;
  wire    [ 26: 0] cpu_instruction_master_address_to_slave;
  wire    [  1: 0] cpu_instruction_master_dbs_address;
  wire             cpu_instruction_master_granted_cpu_jtag_debug_module;
  wire             cpu_instruction_master_granted_epcs_epcs_control_port;
  wire             cpu_instruction_master_granted_sdram_s1;
  wire             cpu_instruction_master_latency_counter;
  wire             cpu_instruction_master_qualified_request_cpu_jtag_debug_module;
  wire             cpu_instruction_master_qualified_request_epcs_epcs_control_port;
  wire             cpu_instruction_master_qualified_request_sdram_s1;
  wire             cpu_instruction_master_read;
  wire             cpu_instruction_master_read_data_valid_cpu_jtag_debug_module;
  wire             cpu_instruction_master_read_data_valid_epcs_epcs_control_port;
  wire             cpu_instruction_master_read_data_valid_sdram_s1;
  wire             cpu_instruction_master_read_data_valid_sdram_s1_shift_register;
  wire    [ 31: 0] cpu_instruction_master_readdata;
  wire             cpu_instruction_master_readdatavalid;
  wire             cpu_instruction_master_requests_cpu_jtag_debug_module;
  wire             cpu_instruction_master_requests_epcs_epcs_control_port;
  wire             cpu_instruction_master_requests_sdram_s1;
  wire             cpu_instruction_master_waitrequest;
  wire    [  8: 0] cpu_jtag_debug_module_address;
  wire             cpu_jtag_debug_module_begintransfer;
  wire    [  3: 0] cpu_jtag_debug_module_byteenable;
  wire             cpu_jtag_debug_module_chipselect;
  wire             cpu_jtag_debug_module_debugaccess;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata;
  wire    [ 31: 0] cpu_jtag_debug_module_readdata_from_sa;
  wire             cpu_jtag_debug_module_reset_n;
  wire             cpu_jtag_debug_module_resetrequest;
  wire             cpu_jtag_debug_module_resetrequest_from_sa;
  wire             cpu_jtag_debug_module_write;
  wire    [ 31: 0] cpu_jtag_debug_module_writedata;
  wire             d1_LAN_CS_s1_end_xfer;
  wire             d1_LAN_RSTN_s1_end_xfer;
  wire             d1_LAN_nINT_s1_end_xfer;
  wire             d1_LAN_spi_control_port_end_xfer;
  wire             d1_NET_EN_s1_end_xfer;
  wire             d1_NET_TESTDO_s1_end_xfer;
  wire             d1_USBSD_RDO_s1_end_xfer;
  wire             d1_USBSD_RVLD_s1_end_xfer;
  wire             d1_USBSD_SEL_s1_end_xfer;
  wire             d1_USB_EN_s1_end_xfer;
  wire             d1_USB_INT_I_s1_end_xfer;
  wire             d1_USB_SCK_O_s1_end_xfer;
  wire             d1_USB_SCS_O_s1_end_xfer;
  wire             d1_USB_SDI_O_s1_end_xfer;
  wire             d1_USB_SDO_I_s1_end_xfer;
  wire             d1_cpu_jtag_debug_module_end_xfer;
  wire             d1_epcs_epcs_control_port_end_xfer;
  wire             d1_jtag_uart_avalon_jtag_slave_end_xfer;
  wire             d1_pio_led_s1_end_xfer;
  wire             d1_sdram_s1_end_xfer;
  wire             d1_sysid_control_slave_end_xfer;
  wire             dclk_from_the_epcs;
  wire    [  8: 0] epcs_epcs_control_port_address;
  wire             epcs_epcs_control_port_chipselect;
  wire             epcs_epcs_control_port_dataavailable;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_endofpacket;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_irq;
  wire             epcs_epcs_control_port_irq_from_sa;
  wire             epcs_epcs_control_port_read_n;
  wire    [ 31: 0] epcs_epcs_control_port_readdata;
  wire    [ 31: 0] epcs_epcs_control_port_readdata_from_sa;
  wire             epcs_epcs_control_port_readyfordata;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  wire             epcs_epcs_control_port_reset_n;
  wire             epcs_epcs_control_port_write_n;
  wire    [ 31: 0] epcs_epcs_control_port_writedata;
  wire             jtag_uart_avalon_jtag_slave_address;
  wire             jtag_uart_avalon_jtag_slave_chipselect;
  wire             jtag_uart_avalon_jtag_slave_dataavailable;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_irq;
  wire             jtag_uart_avalon_jtag_slave_irq_from_sa;
  wire             jtag_uart_avalon_jtag_slave_read_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_readdata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             jtag_uart_avalon_jtag_slave_reset_n;
  wire             jtag_uart_avalon_jtag_slave_waitrequest;
  wire             jtag_uart_avalon_jtag_slave_waitrequest_from_sa;
  wire             jtag_uart_avalon_jtag_slave_write_n;
  wire    [ 31: 0] jtag_uart_avalon_jtag_slave_writedata;
  wire             out_port_from_the_LAN_CS;
  wire             out_port_from_the_LAN_RSTN;
  wire             out_port_from_the_NET_TESTDO;
  wire    [ 15: 0] out_port_from_the_USBSD_RDO;
  wire             out_port_from_the_USBSD_RVLD;
  wire             out_port_from_the_USB_SCK_O;
  wire             out_port_from_the_USB_SCS_O;
  wire             out_port_from_the_USB_SDI_O;
  wire    [  3: 0] out_port_from_the_pio_led;
  wire    [  1: 0] pio_led_s1_address;
  wire             pio_led_s1_chipselect;
  wire    [ 31: 0] pio_led_s1_readdata;
  wire    [ 31: 0] pio_led_s1_readdata_from_sa;
  wire             pio_led_s1_reset_n;
  wire             pio_led_s1_write_n;
  wire    [ 31: 0] pio_led_s1_writedata;
  wire             reset_n_sources;
  wire             sce_from_the_epcs;
  wire             sdo_from_the_epcs;
  wire    [ 23: 0] sdram_s1_address;
  wire    [  1: 0] sdram_s1_byteenable_n;
  wire             sdram_s1_chipselect;
  wire             sdram_s1_read_n;
  wire    [ 15: 0] sdram_s1_readdata;
  wire    [ 15: 0] sdram_s1_readdata_from_sa;
  wire             sdram_s1_readdatavalid;
  wire             sdram_s1_reset_n;
  wire             sdram_s1_waitrequest;
  wire             sdram_s1_waitrequest_from_sa;
  wire             sdram_s1_write_n;
  wire    [ 15: 0] sdram_s1_writedata;
  wire             sysid_control_slave_address;
  wire             sysid_control_slave_clock;
  wire    [ 31: 0] sysid_control_slave_readdata;
  wire    [ 31: 0] sysid_control_slave_readdata_from_sa;
  wire             sysid_control_slave_reset_n;
  wire    [ 12: 0] zs_addr_from_the_sdram;
  wire    [  1: 0] zs_ba_from_the_sdram;
  wire             zs_cas_n_from_the_sdram;
  wire             zs_cke_from_the_sdram;
  wire             zs_cs_n_from_the_sdram;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram;
  wire    [  1: 0] zs_dqm_from_the_sdram;
  wire             zs_ras_n_from_the_sdram;
  wire             zs_we_n_from_the_sdram;
  LAN_spi_control_port_arbitrator the_LAN_spi_control_port
    (
      .LAN_spi_control_port_address                           (LAN_spi_control_port_address),
      .LAN_spi_control_port_chipselect                        (LAN_spi_control_port_chipselect),
      .LAN_spi_control_port_dataavailable                     (LAN_spi_control_port_dataavailable),
      .LAN_spi_control_port_dataavailable_from_sa             (LAN_spi_control_port_dataavailable_from_sa),
      .LAN_spi_control_port_endofpacket                       (LAN_spi_control_port_endofpacket),
      .LAN_spi_control_port_endofpacket_from_sa               (LAN_spi_control_port_endofpacket_from_sa),
      .LAN_spi_control_port_irq                               (LAN_spi_control_port_irq),
      .LAN_spi_control_port_irq_from_sa                       (LAN_spi_control_port_irq_from_sa),
      .LAN_spi_control_port_read_n                            (LAN_spi_control_port_read_n),
      .LAN_spi_control_port_readdata                          (LAN_spi_control_port_readdata),
      .LAN_spi_control_port_readdata_from_sa                  (LAN_spi_control_port_readdata_from_sa),
      .LAN_spi_control_port_readyfordata                      (LAN_spi_control_port_readyfordata),
      .LAN_spi_control_port_readyfordata_from_sa              (LAN_spi_control_port_readyfordata_from_sa),
      .LAN_spi_control_port_reset_n                           (LAN_spi_control_port_reset_n),
      .LAN_spi_control_port_write_n                           (LAN_spi_control_port_write_n),
      .LAN_spi_control_port_writedata                         (LAN_spi_control_port_writedata),
      .clk                                                    (clk),
      .cpu_data_master_address_to_slave                       (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_LAN_spi_control_port           (cpu_data_master_granted_LAN_spi_control_port),
      .cpu_data_master_qualified_request_LAN_spi_control_port (cpu_data_master_qualified_request_LAN_spi_control_port),
      .cpu_data_master_read                                   (cpu_data_master_read),
      .cpu_data_master_read_data_valid_LAN_spi_control_port   (cpu_data_master_read_data_valid_LAN_spi_control_port),
      .cpu_data_master_requests_LAN_spi_control_port          (cpu_data_master_requests_LAN_spi_control_port),
      .cpu_data_master_write                                  (cpu_data_master_write),
      .cpu_data_master_writedata                              (cpu_data_master_writedata),
      .d1_LAN_spi_control_port_end_xfer                       (d1_LAN_spi_control_port_end_xfer),
      .reset_n                                                (clk_reset_n)
    );

  LAN the_LAN
    (
      .MISO          (MISO_to_the_LAN),
      .MOSI          (MOSI_from_the_LAN),
      .SCLK          (SCLK_from_the_LAN),
      .SS_n          (SS_n_from_the_LAN),
      .clk           (clk),
      .data_from_cpu (LAN_spi_control_port_writedata),
      .data_to_cpu   (LAN_spi_control_port_readdata),
      .dataavailable (LAN_spi_control_port_dataavailable),
      .endofpacket   (LAN_spi_control_port_endofpacket),
      .irq           (LAN_spi_control_port_irq),
      .mem_addr      (LAN_spi_control_port_address),
      .read_n        (LAN_spi_control_port_read_n),
      .readyfordata  (LAN_spi_control_port_readyfordata),
      .reset_n       (LAN_spi_control_port_reset_n),
      .spi_select    (LAN_spi_control_port_chipselect),
      .write_n       (LAN_spi_control_port_write_n)
    );

  LAN_CS_s1_arbitrator the_LAN_CS_s1
    (
      .LAN_CS_s1_address                           (LAN_CS_s1_address),
      .LAN_CS_s1_chipselect                        (LAN_CS_s1_chipselect),
      .LAN_CS_s1_readdata                          (LAN_CS_s1_readdata),
      .LAN_CS_s1_readdata_from_sa                  (LAN_CS_s1_readdata_from_sa),
      .LAN_CS_s1_reset_n                           (LAN_CS_s1_reset_n),
      .LAN_CS_s1_write_n                           (LAN_CS_s1_write_n),
      .LAN_CS_s1_writedata                         (LAN_CS_s1_writedata),
      .clk                                         (clk),
      .cpu_data_master_address_to_slave            (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_LAN_CS_s1           (cpu_data_master_granted_LAN_CS_s1),
      .cpu_data_master_qualified_request_LAN_CS_s1 (cpu_data_master_qualified_request_LAN_CS_s1),
      .cpu_data_master_read                        (cpu_data_master_read),
      .cpu_data_master_read_data_valid_LAN_CS_s1   (cpu_data_master_read_data_valid_LAN_CS_s1),
      .cpu_data_master_requests_LAN_CS_s1          (cpu_data_master_requests_LAN_CS_s1),
      .cpu_data_master_waitrequest                 (cpu_data_master_waitrequest),
      .cpu_data_master_write                       (cpu_data_master_write),
      .cpu_data_master_writedata                   (cpu_data_master_writedata),
      .d1_LAN_CS_s1_end_xfer                       (d1_LAN_CS_s1_end_xfer),
      .reset_n                                     (clk_reset_n)
    );

  LAN_CS the_LAN_CS
    (
      .address    (LAN_CS_s1_address),
      .chipselect (LAN_CS_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_LAN_CS),
      .readdata   (LAN_CS_s1_readdata),
      .reset_n    (LAN_CS_s1_reset_n),
      .write_n    (LAN_CS_s1_write_n),
      .writedata  (LAN_CS_s1_writedata)
    );

  LAN_RSTN_s1_arbitrator the_LAN_RSTN_s1
    (
      .LAN_RSTN_s1_address                           (LAN_RSTN_s1_address),
      .LAN_RSTN_s1_chipselect                        (LAN_RSTN_s1_chipselect),
      .LAN_RSTN_s1_readdata                          (LAN_RSTN_s1_readdata),
      .LAN_RSTN_s1_readdata_from_sa                  (LAN_RSTN_s1_readdata_from_sa),
      .LAN_RSTN_s1_reset_n                           (LAN_RSTN_s1_reset_n),
      .LAN_RSTN_s1_write_n                           (LAN_RSTN_s1_write_n),
      .LAN_RSTN_s1_writedata                         (LAN_RSTN_s1_writedata),
      .clk                                           (clk),
      .cpu_data_master_address_to_slave              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_LAN_RSTN_s1           (cpu_data_master_granted_LAN_RSTN_s1),
      .cpu_data_master_qualified_request_LAN_RSTN_s1 (cpu_data_master_qualified_request_LAN_RSTN_s1),
      .cpu_data_master_read                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_LAN_RSTN_s1   (cpu_data_master_read_data_valid_LAN_RSTN_s1),
      .cpu_data_master_requests_LAN_RSTN_s1          (cpu_data_master_requests_LAN_RSTN_s1),
      .cpu_data_master_waitrequest                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                         (cpu_data_master_write),
      .cpu_data_master_writedata                     (cpu_data_master_writedata),
      .d1_LAN_RSTN_s1_end_xfer                       (d1_LAN_RSTN_s1_end_xfer),
      .reset_n                                       (clk_reset_n)
    );

  LAN_RSTN the_LAN_RSTN
    (
      .address    (LAN_RSTN_s1_address),
      .chipselect (LAN_RSTN_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_LAN_RSTN),
      .readdata   (LAN_RSTN_s1_readdata),
      .reset_n    (LAN_RSTN_s1_reset_n),
      .write_n    (LAN_RSTN_s1_write_n),
      .writedata  (LAN_RSTN_s1_writedata)
    );

  LAN_nINT_s1_arbitrator the_LAN_nINT_s1
    (
      .LAN_nINT_s1_address                           (LAN_nINT_s1_address),
      .LAN_nINT_s1_chipselect                        (LAN_nINT_s1_chipselect),
      .LAN_nINT_s1_readdata                          (LAN_nINT_s1_readdata),
      .LAN_nINT_s1_readdata_from_sa                  (LAN_nINT_s1_readdata_from_sa),
      .LAN_nINT_s1_reset_n                           (LAN_nINT_s1_reset_n),
      .LAN_nINT_s1_write_n                           (LAN_nINT_s1_write_n),
      .LAN_nINT_s1_writedata                         (LAN_nINT_s1_writedata),
      .clk                                           (clk),
      .cpu_data_master_address_to_slave              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_LAN_nINT_s1           (cpu_data_master_granted_LAN_nINT_s1),
      .cpu_data_master_qualified_request_LAN_nINT_s1 (cpu_data_master_qualified_request_LAN_nINT_s1),
      .cpu_data_master_read                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_LAN_nINT_s1   (cpu_data_master_read_data_valid_LAN_nINT_s1),
      .cpu_data_master_requests_LAN_nINT_s1          (cpu_data_master_requests_LAN_nINT_s1),
      .cpu_data_master_waitrequest                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                         (cpu_data_master_write),
      .cpu_data_master_writedata                     (cpu_data_master_writedata),
      .d1_LAN_nINT_s1_end_xfer                       (d1_LAN_nINT_s1_end_xfer),
      .reset_n                                       (clk_reset_n)
    );

  LAN_nINT the_LAN_nINT
    (
      .address    (LAN_nINT_s1_address),
      .chipselect (LAN_nINT_s1_chipselect),
      .clk        (clk),
      .in_port    (in_port_to_the_LAN_nINT),
      .irq        (LAN_nINT_s1_irq),
      .readdata   (LAN_nINT_s1_readdata),
      .reset_n    (LAN_nINT_s1_reset_n),
      .write_n    (LAN_nINT_s1_write_n),
      .writedata  (LAN_nINT_s1_writedata)
    );

  NET_EN_s1_arbitrator the_NET_EN_s1
    (
      .NET_EN_s1_address                           (NET_EN_s1_address),
      .NET_EN_s1_readdata                          (NET_EN_s1_readdata),
      .NET_EN_s1_readdata_from_sa                  (NET_EN_s1_readdata_from_sa),
      .NET_EN_s1_reset_n                           (NET_EN_s1_reset_n),
      .clk                                         (clk),
      .cpu_data_master_address_to_slave            (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_NET_EN_s1           (cpu_data_master_granted_NET_EN_s1),
      .cpu_data_master_qualified_request_NET_EN_s1 (cpu_data_master_qualified_request_NET_EN_s1),
      .cpu_data_master_read                        (cpu_data_master_read),
      .cpu_data_master_read_data_valid_NET_EN_s1   (cpu_data_master_read_data_valid_NET_EN_s1),
      .cpu_data_master_requests_NET_EN_s1          (cpu_data_master_requests_NET_EN_s1),
      .cpu_data_master_write                       (cpu_data_master_write),
      .d1_NET_EN_s1_end_xfer                       (d1_NET_EN_s1_end_xfer),
      .reset_n                                     (clk_reset_n)
    );

  NET_EN the_NET_EN
    (
      .address  (NET_EN_s1_address),
      .clk      (clk),
      .in_port  (in_port_to_the_NET_EN),
      .readdata (NET_EN_s1_readdata),
      .reset_n  (NET_EN_s1_reset_n)
    );

  NET_TESTDO_s1_arbitrator the_NET_TESTDO_s1
    (
      .NET_TESTDO_s1_address                           (NET_TESTDO_s1_address),
      .NET_TESTDO_s1_chipselect                        (NET_TESTDO_s1_chipselect),
      .NET_TESTDO_s1_readdata                          (NET_TESTDO_s1_readdata),
      .NET_TESTDO_s1_readdata_from_sa                  (NET_TESTDO_s1_readdata_from_sa),
      .NET_TESTDO_s1_reset_n                           (NET_TESTDO_s1_reset_n),
      .NET_TESTDO_s1_write_n                           (NET_TESTDO_s1_write_n),
      .NET_TESTDO_s1_writedata                         (NET_TESTDO_s1_writedata),
      .clk                                             (clk),
      .cpu_data_master_address_to_slave                (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_NET_TESTDO_s1           (cpu_data_master_granted_NET_TESTDO_s1),
      .cpu_data_master_qualified_request_NET_TESTDO_s1 (cpu_data_master_qualified_request_NET_TESTDO_s1),
      .cpu_data_master_read                            (cpu_data_master_read),
      .cpu_data_master_read_data_valid_NET_TESTDO_s1   (cpu_data_master_read_data_valid_NET_TESTDO_s1),
      .cpu_data_master_requests_NET_TESTDO_s1          (cpu_data_master_requests_NET_TESTDO_s1),
      .cpu_data_master_waitrequest                     (cpu_data_master_waitrequest),
      .cpu_data_master_write                           (cpu_data_master_write),
      .cpu_data_master_writedata                       (cpu_data_master_writedata),
      .d1_NET_TESTDO_s1_end_xfer                       (d1_NET_TESTDO_s1_end_xfer),
      .reset_n                                         (clk_reset_n)
    );

  NET_TESTDO the_NET_TESTDO
    (
      .address    (NET_TESTDO_s1_address),
      .chipselect (NET_TESTDO_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_NET_TESTDO),
      .readdata   (NET_TESTDO_s1_readdata),
      .reset_n    (NET_TESTDO_s1_reset_n),
      .write_n    (NET_TESTDO_s1_write_n),
      .writedata  (NET_TESTDO_s1_writedata)
    );

  USBSD_RDO_s1_arbitrator the_USBSD_RDO_s1
    (
      .USBSD_RDO_s1_address                           (USBSD_RDO_s1_address),
      .USBSD_RDO_s1_chipselect                        (USBSD_RDO_s1_chipselect),
      .USBSD_RDO_s1_readdata                          (USBSD_RDO_s1_readdata),
      .USBSD_RDO_s1_readdata_from_sa                  (USBSD_RDO_s1_readdata_from_sa),
      .USBSD_RDO_s1_reset_n                           (USBSD_RDO_s1_reset_n),
      .USBSD_RDO_s1_write_n                           (USBSD_RDO_s1_write_n),
      .USBSD_RDO_s1_writedata                         (USBSD_RDO_s1_writedata),
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USBSD_RDO_s1           (cpu_data_master_granted_USBSD_RDO_s1),
      .cpu_data_master_qualified_request_USBSD_RDO_s1 (cpu_data_master_qualified_request_USBSD_RDO_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USBSD_RDO_s1   (cpu_data_master_read_data_valid_USBSD_RDO_s1),
      .cpu_data_master_requests_USBSD_RDO_s1          (cpu_data_master_requests_USBSD_RDO_s1),
      .cpu_data_master_waitrequest                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                          (cpu_data_master_write),
      .cpu_data_master_writedata                      (cpu_data_master_writedata),
      .d1_USBSD_RDO_s1_end_xfer                       (d1_USBSD_RDO_s1_end_xfer),
      .reset_n                                        (clk_reset_n)
    );

  USBSD_RDO the_USBSD_RDO
    (
      .address    (USBSD_RDO_s1_address),
      .chipselect (USBSD_RDO_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_USBSD_RDO),
      .readdata   (USBSD_RDO_s1_readdata),
      .reset_n    (USBSD_RDO_s1_reset_n),
      .write_n    (USBSD_RDO_s1_write_n),
      .writedata  (USBSD_RDO_s1_writedata)
    );

  USBSD_RVLD_s1_arbitrator the_USBSD_RVLD_s1
    (
      .USBSD_RVLD_s1_address                           (USBSD_RVLD_s1_address),
      .USBSD_RVLD_s1_chipselect                        (USBSD_RVLD_s1_chipselect),
      .USBSD_RVLD_s1_readdata                          (USBSD_RVLD_s1_readdata),
      .USBSD_RVLD_s1_readdata_from_sa                  (USBSD_RVLD_s1_readdata_from_sa),
      .USBSD_RVLD_s1_reset_n                           (USBSD_RVLD_s1_reset_n),
      .USBSD_RVLD_s1_write_n                           (USBSD_RVLD_s1_write_n),
      .USBSD_RVLD_s1_writedata                         (USBSD_RVLD_s1_writedata),
      .clk                                             (clk),
      .cpu_data_master_address_to_slave                (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USBSD_RVLD_s1           (cpu_data_master_granted_USBSD_RVLD_s1),
      .cpu_data_master_qualified_request_USBSD_RVLD_s1 (cpu_data_master_qualified_request_USBSD_RVLD_s1),
      .cpu_data_master_read                            (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USBSD_RVLD_s1   (cpu_data_master_read_data_valid_USBSD_RVLD_s1),
      .cpu_data_master_requests_USBSD_RVLD_s1          (cpu_data_master_requests_USBSD_RVLD_s1),
      .cpu_data_master_waitrequest                     (cpu_data_master_waitrequest),
      .cpu_data_master_write                           (cpu_data_master_write),
      .cpu_data_master_writedata                       (cpu_data_master_writedata),
      .d1_USBSD_RVLD_s1_end_xfer                       (d1_USBSD_RVLD_s1_end_xfer),
      .reset_n                                         (clk_reset_n)
    );

  USBSD_RVLD the_USBSD_RVLD
    (
      .address    (USBSD_RVLD_s1_address),
      .chipselect (USBSD_RVLD_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_USBSD_RVLD),
      .readdata   (USBSD_RVLD_s1_readdata),
      .reset_n    (USBSD_RVLD_s1_reset_n),
      .write_n    (USBSD_RVLD_s1_write_n),
      .writedata  (USBSD_RVLD_s1_writedata)
    );

  USBSD_SEL_s1_arbitrator the_USBSD_SEL_s1
    (
      .USBSD_SEL_s1_address                           (USBSD_SEL_s1_address),
      .USBSD_SEL_s1_readdata                          (USBSD_SEL_s1_readdata),
      .USBSD_SEL_s1_readdata_from_sa                  (USBSD_SEL_s1_readdata_from_sa),
      .USBSD_SEL_s1_reset_n                           (USBSD_SEL_s1_reset_n),
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USBSD_SEL_s1           (cpu_data_master_granted_USBSD_SEL_s1),
      .cpu_data_master_qualified_request_USBSD_SEL_s1 (cpu_data_master_qualified_request_USBSD_SEL_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USBSD_SEL_s1   (cpu_data_master_read_data_valid_USBSD_SEL_s1),
      .cpu_data_master_requests_USBSD_SEL_s1          (cpu_data_master_requests_USBSD_SEL_s1),
      .cpu_data_master_write                          (cpu_data_master_write),
      .d1_USBSD_SEL_s1_end_xfer                       (d1_USBSD_SEL_s1_end_xfer),
      .reset_n                                        (clk_reset_n)
    );

  USBSD_SEL the_USBSD_SEL
    (
      .address  (USBSD_SEL_s1_address),
      .clk      (clk),
      .in_port  (in_port_to_the_USBSD_SEL),
      .readdata (USBSD_SEL_s1_readdata),
      .reset_n  (USBSD_SEL_s1_reset_n)
    );

  USB_EN_s1_arbitrator the_USB_EN_s1
    (
      .USB_EN_s1_address                           (USB_EN_s1_address),
      .USB_EN_s1_readdata                          (USB_EN_s1_readdata),
      .USB_EN_s1_readdata_from_sa                  (USB_EN_s1_readdata_from_sa),
      .USB_EN_s1_reset_n                           (USB_EN_s1_reset_n),
      .clk                                         (clk),
      .cpu_data_master_address_to_slave            (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USB_EN_s1           (cpu_data_master_granted_USB_EN_s1),
      .cpu_data_master_qualified_request_USB_EN_s1 (cpu_data_master_qualified_request_USB_EN_s1),
      .cpu_data_master_read                        (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USB_EN_s1   (cpu_data_master_read_data_valid_USB_EN_s1),
      .cpu_data_master_requests_USB_EN_s1          (cpu_data_master_requests_USB_EN_s1),
      .cpu_data_master_write                       (cpu_data_master_write),
      .d1_USB_EN_s1_end_xfer                       (d1_USB_EN_s1_end_xfer),
      .reset_n                                     (clk_reset_n)
    );

  USB_EN the_USB_EN
    (
      .address  (USB_EN_s1_address),
      .clk      (clk),
      .in_port  (in_port_to_the_USB_EN),
      .readdata (USB_EN_s1_readdata),
      .reset_n  (USB_EN_s1_reset_n)
    );

  USB_INT_I_s1_arbitrator the_USB_INT_I_s1
    (
      .USB_INT_I_s1_address                           (USB_INT_I_s1_address),
      .USB_INT_I_s1_readdata                          (USB_INT_I_s1_readdata),
      .USB_INT_I_s1_readdata_from_sa                  (USB_INT_I_s1_readdata_from_sa),
      .USB_INT_I_s1_reset_n                           (USB_INT_I_s1_reset_n),
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USB_INT_I_s1           (cpu_data_master_granted_USB_INT_I_s1),
      .cpu_data_master_qualified_request_USB_INT_I_s1 (cpu_data_master_qualified_request_USB_INT_I_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USB_INT_I_s1   (cpu_data_master_read_data_valid_USB_INT_I_s1),
      .cpu_data_master_requests_USB_INT_I_s1          (cpu_data_master_requests_USB_INT_I_s1),
      .cpu_data_master_write                          (cpu_data_master_write),
      .d1_USB_INT_I_s1_end_xfer                       (d1_USB_INT_I_s1_end_xfer),
      .reset_n                                        (clk_reset_n)
    );

  USB_INT_I the_USB_INT_I
    (
      .address  (USB_INT_I_s1_address),
      .clk      (clk),
      .in_port  (in_port_to_the_USB_INT_I),
      .readdata (USB_INT_I_s1_readdata),
      .reset_n  (USB_INT_I_s1_reset_n)
    );

  USB_SCK_O_s1_arbitrator the_USB_SCK_O_s1
    (
      .USB_SCK_O_s1_address                           (USB_SCK_O_s1_address),
      .USB_SCK_O_s1_chipselect                        (USB_SCK_O_s1_chipselect),
      .USB_SCK_O_s1_readdata                          (USB_SCK_O_s1_readdata),
      .USB_SCK_O_s1_readdata_from_sa                  (USB_SCK_O_s1_readdata_from_sa),
      .USB_SCK_O_s1_reset_n                           (USB_SCK_O_s1_reset_n),
      .USB_SCK_O_s1_write_n                           (USB_SCK_O_s1_write_n),
      .USB_SCK_O_s1_writedata                         (USB_SCK_O_s1_writedata),
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USB_SCK_O_s1           (cpu_data_master_granted_USB_SCK_O_s1),
      .cpu_data_master_qualified_request_USB_SCK_O_s1 (cpu_data_master_qualified_request_USB_SCK_O_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USB_SCK_O_s1   (cpu_data_master_read_data_valid_USB_SCK_O_s1),
      .cpu_data_master_requests_USB_SCK_O_s1          (cpu_data_master_requests_USB_SCK_O_s1),
      .cpu_data_master_waitrequest                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                          (cpu_data_master_write),
      .cpu_data_master_writedata                      (cpu_data_master_writedata),
      .d1_USB_SCK_O_s1_end_xfer                       (d1_USB_SCK_O_s1_end_xfer),
      .reset_n                                        (clk_reset_n)
    );

  USB_SCK_O the_USB_SCK_O
    (
      .address    (USB_SCK_O_s1_address),
      .chipselect (USB_SCK_O_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_USB_SCK_O),
      .readdata   (USB_SCK_O_s1_readdata),
      .reset_n    (USB_SCK_O_s1_reset_n),
      .write_n    (USB_SCK_O_s1_write_n),
      .writedata  (USB_SCK_O_s1_writedata)
    );

  USB_SCS_O_s1_arbitrator the_USB_SCS_O_s1
    (
      .USB_SCS_O_s1_address                           (USB_SCS_O_s1_address),
      .USB_SCS_O_s1_chipselect                        (USB_SCS_O_s1_chipselect),
      .USB_SCS_O_s1_readdata                          (USB_SCS_O_s1_readdata),
      .USB_SCS_O_s1_readdata_from_sa                  (USB_SCS_O_s1_readdata_from_sa),
      .USB_SCS_O_s1_reset_n                           (USB_SCS_O_s1_reset_n),
      .USB_SCS_O_s1_write_n                           (USB_SCS_O_s1_write_n),
      .USB_SCS_O_s1_writedata                         (USB_SCS_O_s1_writedata),
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USB_SCS_O_s1           (cpu_data_master_granted_USB_SCS_O_s1),
      .cpu_data_master_qualified_request_USB_SCS_O_s1 (cpu_data_master_qualified_request_USB_SCS_O_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USB_SCS_O_s1   (cpu_data_master_read_data_valid_USB_SCS_O_s1),
      .cpu_data_master_requests_USB_SCS_O_s1          (cpu_data_master_requests_USB_SCS_O_s1),
      .cpu_data_master_waitrequest                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                          (cpu_data_master_write),
      .cpu_data_master_writedata                      (cpu_data_master_writedata),
      .d1_USB_SCS_O_s1_end_xfer                       (d1_USB_SCS_O_s1_end_xfer),
      .reset_n                                        (clk_reset_n)
    );

  USB_SCS_O the_USB_SCS_O
    (
      .address    (USB_SCS_O_s1_address),
      .chipselect (USB_SCS_O_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_USB_SCS_O),
      .readdata   (USB_SCS_O_s1_readdata),
      .reset_n    (USB_SCS_O_s1_reset_n),
      .write_n    (USB_SCS_O_s1_write_n),
      .writedata  (USB_SCS_O_s1_writedata)
    );

  USB_SDI_O_s1_arbitrator the_USB_SDI_O_s1
    (
      .USB_SDI_O_s1_address                           (USB_SDI_O_s1_address),
      .USB_SDI_O_s1_chipselect                        (USB_SDI_O_s1_chipselect),
      .USB_SDI_O_s1_readdata                          (USB_SDI_O_s1_readdata),
      .USB_SDI_O_s1_readdata_from_sa                  (USB_SDI_O_s1_readdata_from_sa),
      .USB_SDI_O_s1_reset_n                           (USB_SDI_O_s1_reset_n),
      .USB_SDI_O_s1_write_n                           (USB_SDI_O_s1_write_n),
      .USB_SDI_O_s1_writedata                         (USB_SDI_O_s1_writedata),
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USB_SDI_O_s1           (cpu_data_master_granted_USB_SDI_O_s1),
      .cpu_data_master_qualified_request_USB_SDI_O_s1 (cpu_data_master_qualified_request_USB_SDI_O_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USB_SDI_O_s1   (cpu_data_master_read_data_valid_USB_SDI_O_s1),
      .cpu_data_master_requests_USB_SDI_O_s1          (cpu_data_master_requests_USB_SDI_O_s1),
      .cpu_data_master_waitrequest                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                          (cpu_data_master_write),
      .cpu_data_master_writedata                      (cpu_data_master_writedata),
      .d1_USB_SDI_O_s1_end_xfer                       (d1_USB_SDI_O_s1_end_xfer),
      .reset_n                                        (clk_reset_n)
    );

  USB_SDI_O the_USB_SDI_O
    (
      .address    (USB_SDI_O_s1_address),
      .chipselect (USB_SDI_O_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_USB_SDI_O),
      .readdata   (USB_SDI_O_s1_readdata),
      .reset_n    (USB_SDI_O_s1_reset_n),
      .write_n    (USB_SDI_O_s1_write_n),
      .writedata  (USB_SDI_O_s1_writedata)
    );

  USB_SDO_I_s1_arbitrator the_USB_SDO_I_s1
    (
      .USB_SDO_I_s1_address                           (USB_SDO_I_s1_address),
      .USB_SDO_I_s1_readdata                          (USB_SDO_I_s1_readdata),
      .USB_SDO_I_s1_readdata_from_sa                  (USB_SDO_I_s1_readdata_from_sa),
      .USB_SDO_I_s1_reset_n                           (USB_SDO_I_s1_reset_n),
      .clk                                            (clk),
      .cpu_data_master_address_to_slave               (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_USB_SDO_I_s1           (cpu_data_master_granted_USB_SDO_I_s1),
      .cpu_data_master_qualified_request_USB_SDO_I_s1 (cpu_data_master_qualified_request_USB_SDO_I_s1),
      .cpu_data_master_read                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_USB_SDO_I_s1   (cpu_data_master_read_data_valid_USB_SDO_I_s1),
      .cpu_data_master_requests_USB_SDO_I_s1          (cpu_data_master_requests_USB_SDO_I_s1),
      .cpu_data_master_write                          (cpu_data_master_write),
      .d1_USB_SDO_I_s1_end_xfer                       (d1_USB_SDO_I_s1_end_xfer),
      .reset_n                                        (clk_reset_n)
    );

  USB_SDO_I the_USB_SDO_I
    (
      .address  (USB_SDO_I_s1_address),
      .clk      (clk),
      .in_port  (in_port_to_the_USB_SDO_I),
      .readdata (USB_SDO_I_s1_readdata),
      .reset_n  (USB_SDO_I_s1_reset_n)
    );

  cpu_jtag_debug_module_arbitrator the_cpu_jtag_debug_module
    (
      .clk                                                            (clk),
      .cpu_data_master_address_to_slave                               (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                     (cpu_data_master_byteenable),
      .cpu_data_master_debugaccess                                    (cpu_data_master_debugaccess),
      .cpu_data_master_granted_cpu_jtag_debug_module                  (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module        (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_read                                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module          (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_requests_cpu_jtag_debug_module                 (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_waitrequest                                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                                          (cpu_data_master_write),
      .cpu_data_master_writedata                                      (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                        (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_cpu_jtag_debug_module           (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_latency_counter                         (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_read                                    (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module   (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_cpu_jtag_debug_module          (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_jtag_debug_module_address                                  (cpu_jtag_debug_module_address),
      .cpu_jtag_debug_module_begintransfer                            (cpu_jtag_debug_module_begintransfer),
      .cpu_jtag_debug_module_byteenable                               (cpu_jtag_debug_module_byteenable),
      .cpu_jtag_debug_module_chipselect                               (cpu_jtag_debug_module_chipselect),
      .cpu_jtag_debug_module_debugaccess                              (cpu_jtag_debug_module_debugaccess),
      .cpu_jtag_debug_module_readdata                                 (cpu_jtag_debug_module_readdata),
      .cpu_jtag_debug_module_readdata_from_sa                         (cpu_jtag_debug_module_readdata_from_sa),
      .cpu_jtag_debug_module_reset_n                                  (cpu_jtag_debug_module_reset_n),
      .cpu_jtag_debug_module_resetrequest                             (cpu_jtag_debug_module_resetrequest),
      .cpu_jtag_debug_module_resetrequest_from_sa                     (cpu_jtag_debug_module_resetrequest_from_sa),
      .cpu_jtag_debug_module_write                                    (cpu_jtag_debug_module_write),
      .cpu_jtag_debug_module_writedata                                (cpu_jtag_debug_module_writedata),
      .d1_cpu_jtag_debug_module_end_xfer                              (d1_cpu_jtag_debug_module_end_xfer),
      .reset_n                                                        (clk_reset_n)
    );

  cpu_data_master_arbitrator the_cpu_data_master
    (
      .LAN_CS_s1_readdata_from_sa                                    (LAN_CS_s1_readdata_from_sa),
      .LAN_RSTN_s1_readdata_from_sa                                  (LAN_RSTN_s1_readdata_from_sa),
      .LAN_nINT_s1_readdata_from_sa                                  (LAN_nINT_s1_readdata_from_sa),
      .LAN_spi_control_port_irq_from_sa                              (LAN_spi_control_port_irq_from_sa),
      .LAN_spi_control_port_readdata_from_sa                         (LAN_spi_control_port_readdata_from_sa),
      .NET_EN_s1_readdata_from_sa                                    (NET_EN_s1_readdata_from_sa),
      .NET_TESTDO_s1_readdata_from_sa                                (NET_TESTDO_s1_readdata_from_sa),
      .USBSD_RDO_s1_readdata_from_sa                                 (USBSD_RDO_s1_readdata_from_sa),
      .USBSD_RVLD_s1_readdata_from_sa                                (USBSD_RVLD_s1_readdata_from_sa),
      .USBSD_SEL_s1_readdata_from_sa                                 (USBSD_SEL_s1_readdata_from_sa),
      .USB_EN_s1_readdata_from_sa                                    (USB_EN_s1_readdata_from_sa),
      .USB_INT_I_s1_readdata_from_sa                                 (USB_INT_I_s1_readdata_from_sa),
      .USB_SCK_O_s1_readdata_from_sa                                 (USB_SCK_O_s1_readdata_from_sa),
      .USB_SCS_O_s1_readdata_from_sa                                 (USB_SCS_O_s1_readdata_from_sa),
      .USB_SDI_O_s1_readdata_from_sa                                 (USB_SDI_O_s1_readdata_from_sa),
      .USB_SDO_I_s1_readdata_from_sa                                 (USB_SDO_I_s1_readdata_from_sa),
      .clk                                                           (clk),
      .cpu_data_master_address                                       (cpu_data_master_address),
      .cpu_data_master_address_to_slave                              (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable_sdram_s1                           (cpu_data_master_byteenable_sdram_s1),
      .cpu_data_master_dbs_address                                   (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                  (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_LAN_CS_s1                             (cpu_data_master_granted_LAN_CS_s1),
      .cpu_data_master_granted_LAN_RSTN_s1                           (cpu_data_master_granted_LAN_RSTN_s1),
      .cpu_data_master_granted_LAN_nINT_s1                           (cpu_data_master_granted_LAN_nINT_s1),
      .cpu_data_master_granted_LAN_spi_control_port                  (cpu_data_master_granted_LAN_spi_control_port),
      .cpu_data_master_granted_NET_EN_s1                             (cpu_data_master_granted_NET_EN_s1),
      .cpu_data_master_granted_NET_TESTDO_s1                         (cpu_data_master_granted_NET_TESTDO_s1),
      .cpu_data_master_granted_USBSD_RDO_s1                          (cpu_data_master_granted_USBSD_RDO_s1),
      .cpu_data_master_granted_USBSD_RVLD_s1                         (cpu_data_master_granted_USBSD_RVLD_s1),
      .cpu_data_master_granted_USBSD_SEL_s1                          (cpu_data_master_granted_USBSD_SEL_s1),
      .cpu_data_master_granted_USB_EN_s1                             (cpu_data_master_granted_USB_EN_s1),
      .cpu_data_master_granted_USB_INT_I_s1                          (cpu_data_master_granted_USB_INT_I_s1),
      .cpu_data_master_granted_USB_SCK_O_s1                          (cpu_data_master_granted_USB_SCK_O_s1),
      .cpu_data_master_granted_USB_SCS_O_s1                          (cpu_data_master_granted_USB_SCS_O_s1),
      .cpu_data_master_granted_USB_SDI_O_s1                          (cpu_data_master_granted_USB_SDI_O_s1),
      .cpu_data_master_granted_USB_SDO_I_s1                          (cpu_data_master_granted_USB_SDO_I_s1),
      .cpu_data_master_granted_cpu_jtag_debug_module                 (cpu_data_master_granted_cpu_jtag_debug_module),
      .cpu_data_master_granted_epcs_epcs_control_port                (cpu_data_master_granted_epcs_epcs_control_port),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave           (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_granted_pio_led_s1                            (cpu_data_master_granted_pio_led_s1),
      .cpu_data_master_granted_sdram_s1                              (cpu_data_master_granted_sdram_s1),
      .cpu_data_master_granted_sysid_control_slave                   (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_irq                                           (cpu_data_master_irq),
      .cpu_data_master_no_byte_enables_and_last_term                 (cpu_data_master_no_byte_enables_and_last_term),
      .cpu_data_master_qualified_request_LAN_CS_s1                   (cpu_data_master_qualified_request_LAN_CS_s1),
      .cpu_data_master_qualified_request_LAN_RSTN_s1                 (cpu_data_master_qualified_request_LAN_RSTN_s1),
      .cpu_data_master_qualified_request_LAN_nINT_s1                 (cpu_data_master_qualified_request_LAN_nINT_s1),
      .cpu_data_master_qualified_request_LAN_spi_control_port        (cpu_data_master_qualified_request_LAN_spi_control_port),
      .cpu_data_master_qualified_request_NET_EN_s1                   (cpu_data_master_qualified_request_NET_EN_s1),
      .cpu_data_master_qualified_request_NET_TESTDO_s1               (cpu_data_master_qualified_request_NET_TESTDO_s1),
      .cpu_data_master_qualified_request_USBSD_RDO_s1                (cpu_data_master_qualified_request_USBSD_RDO_s1),
      .cpu_data_master_qualified_request_USBSD_RVLD_s1               (cpu_data_master_qualified_request_USBSD_RVLD_s1),
      .cpu_data_master_qualified_request_USBSD_SEL_s1                (cpu_data_master_qualified_request_USBSD_SEL_s1),
      .cpu_data_master_qualified_request_USB_EN_s1                   (cpu_data_master_qualified_request_USB_EN_s1),
      .cpu_data_master_qualified_request_USB_INT_I_s1                (cpu_data_master_qualified_request_USB_INT_I_s1),
      .cpu_data_master_qualified_request_USB_SCK_O_s1                (cpu_data_master_qualified_request_USB_SCK_O_s1),
      .cpu_data_master_qualified_request_USB_SCS_O_s1                (cpu_data_master_qualified_request_USB_SCS_O_s1),
      .cpu_data_master_qualified_request_USB_SDI_O_s1                (cpu_data_master_qualified_request_USB_SDI_O_s1),
      .cpu_data_master_qualified_request_USB_SDO_I_s1                (cpu_data_master_qualified_request_USB_SDO_I_s1),
      .cpu_data_master_qualified_request_cpu_jtag_debug_module       (cpu_data_master_qualified_request_cpu_jtag_debug_module),
      .cpu_data_master_qualified_request_epcs_epcs_control_port      (cpu_data_master_qualified_request_epcs_epcs_control_port),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_qualified_request_pio_led_s1                  (cpu_data_master_qualified_request_pio_led_s1),
      .cpu_data_master_qualified_request_sdram_s1                    (cpu_data_master_qualified_request_sdram_s1),
      .cpu_data_master_qualified_request_sysid_control_slave         (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_read                                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_LAN_CS_s1                     (cpu_data_master_read_data_valid_LAN_CS_s1),
      .cpu_data_master_read_data_valid_LAN_RSTN_s1                   (cpu_data_master_read_data_valid_LAN_RSTN_s1),
      .cpu_data_master_read_data_valid_LAN_nINT_s1                   (cpu_data_master_read_data_valid_LAN_nINT_s1),
      .cpu_data_master_read_data_valid_LAN_spi_control_port          (cpu_data_master_read_data_valid_LAN_spi_control_port),
      .cpu_data_master_read_data_valid_NET_EN_s1                     (cpu_data_master_read_data_valid_NET_EN_s1),
      .cpu_data_master_read_data_valid_NET_TESTDO_s1                 (cpu_data_master_read_data_valid_NET_TESTDO_s1),
      .cpu_data_master_read_data_valid_USBSD_RDO_s1                  (cpu_data_master_read_data_valid_USBSD_RDO_s1),
      .cpu_data_master_read_data_valid_USBSD_RVLD_s1                 (cpu_data_master_read_data_valid_USBSD_RVLD_s1),
      .cpu_data_master_read_data_valid_USBSD_SEL_s1                  (cpu_data_master_read_data_valid_USBSD_SEL_s1),
      .cpu_data_master_read_data_valid_USB_EN_s1                     (cpu_data_master_read_data_valid_USB_EN_s1),
      .cpu_data_master_read_data_valid_USB_INT_I_s1                  (cpu_data_master_read_data_valid_USB_INT_I_s1),
      .cpu_data_master_read_data_valid_USB_SCK_O_s1                  (cpu_data_master_read_data_valid_USB_SCK_O_s1),
      .cpu_data_master_read_data_valid_USB_SCS_O_s1                  (cpu_data_master_read_data_valid_USB_SCS_O_s1),
      .cpu_data_master_read_data_valid_USB_SDI_O_s1                  (cpu_data_master_read_data_valid_USB_SDI_O_s1),
      .cpu_data_master_read_data_valid_USB_SDO_I_s1                  (cpu_data_master_read_data_valid_USB_SDO_I_s1),
      .cpu_data_master_read_data_valid_cpu_jtag_debug_module         (cpu_data_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_data_master_read_data_valid_epcs_epcs_control_port        (cpu_data_master_read_data_valid_epcs_epcs_control_port),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave   (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read_data_valid_pio_led_s1                    (cpu_data_master_read_data_valid_pio_led_s1),
      .cpu_data_master_read_data_valid_sdram_s1                      (cpu_data_master_read_data_valid_sdram_s1),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register       (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_read_data_valid_sysid_control_slave           (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_readdata                                      (cpu_data_master_readdata),
      .cpu_data_master_requests_LAN_CS_s1                            (cpu_data_master_requests_LAN_CS_s1),
      .cpu_data_master_requests_LAN_RSTN_s1                          (cpu_data_master_requests_LAN_RSTN_s1),
      .cpu_data_master_requests_LAN_nINT_s1                          (cpu_data_master_requests_LAN_nINT_s1),
      .cpu_data_master_requests_LAN_spi_control_port                 (cpu_data_master_requests_LAN_spi_control_port),
      .cpu_data_master_requests_NET_EN_s1                            (cpu_data_master_requests_NET_EN_s1),
      .cpu_data_master_requests_NET_TESTDO_s1                        (cpu_data_master_requests_NET_TESTDO_s1),
      .cpu_data_master_requests_USBSD_RDO_s1                         (cpu_data_master_requests_USBSD_RDO_s1),
      .cpu_data_master_requests_USBSD_RVLD_s1                        (cpu_data_master_requests_USBSD_RVLD_s1),
      .cpu_data_master_requests_USBSD_SEL_s1                         (cpu_data_master_requests_USBSD_SEL_s1),
      .cpu_data_master_requests_USB_EN_s1                            (cpu_data_master_requests_USB_EN_s1),
      .cpu_data_master_requests_USB_INT_I_s1                         (cpu_data_master_requests_USB_INT_I_s1),
      .cpu_data_master_requests_USB_SCK_O_s1                         (cpu_data_master_requests_USB_SCK_O_s1),
      .cpu_data_master_requests_USB_SCS_O_s1                         (cpu_data_master_requests_USB_SCS_O_s1),
      .cpu_data_master_requests_USB_SDI_O_s1                         (cpu_data_master_requests_USB_SDI_O_s1),
      .cpu_data_master_requests_USB_SDO_I_s1                         (cpu_data_master_requests_USB_SDO_I_s1),
      .cpu_data_master_requests_cpu_jtag_debug_module                (cpu_data_master_requests_cpu_jtag_debug_module),
      .cpu_data_master_requests_epcs_epcs_control_port               (cpu_data_master_requests_epcs_epcs_control_port),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave          (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_requests_pio_led_s1                           (cpu_data_master_requests_pio_led_s1),
      .cpu_data_master_requests_sdram_s1                             (cpu_data_master_requests_sdram_s1),
      .cpu_data_master_requests_sysid_control_slave                  (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_waitrequest                                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                                         (cpu_data_master_write),
      .cpu_data_master_writedata                                     (cpu_data_master_writedata),
      .cpu_jtag_debug_module_readdata_from_sa                        (cpu_jtag_debug_module_readdata_from_sa),
      .d1_LAN_CS_s1_end_xfer                                         (d1_LAN_CS_s1_end_xfer),
      .d1_LAN_RSTN_s1_end_xfer                                       (d1_LAN_RSTN_s1_end_xfer),
      .d1_LAN_nINT_s1_end_xfer                                       (d1_LAN_nINT_s1_end_xfer),
      .d1_LAN_spi_control_port_end_xfer                              (d1_LAN_spi_control_port_end_xfer),
      .d1_NET_EN_s1_end_xfer                                         (d1_NET_EN_s1_end_xfer),
      .d1_NET_TESTDO_s1_end_xfer                                     (d1_NET_TESTDO_s1_end_xfer),
      .d1_USBSD_RDO_s1_end_xfer                                      (d1_USBSD_RDO_s1_end_xfer),
      .d1_USBSD_RVLD_s1_end_xfer                                     (d1_USBSD_RVLD_s1_end_xfer),
      .d1_USBSD_SEL_s1_end_xfer                                      (d1_USBSD_SEL_s1_end_xfer),
      .d1_USB_EN_s1_end_xfer                                         (d1_USB_EN_s1_end_xfer),
      .d1_USB_INT_I_s1_end_xfer                                      (d1_USB_INT_I_s1_end_xfer),
      .d1_USB_SCK_O_s1_end_xfer                                      (d1_USB_SCK_O_s1_end_xfer),
      .d1_USB_SCS_O_s1_end_xfer                                      (d1_USB_SCS_O_s1_end_xfer),
      .d1_USB_SDI_O_s1_end_xfer                                      (d1_USB_SDI_O_s1_end_xfer),
      .d1_USB_SDO_I_s1_end_xfer                                      (d1_USB_SDO_I_s1_end_xfer),
      .d1_cpu_jtag_debug_module_end_xfer                             (d1_cpu_jtag_debug_module_end_xfer),
      .d1_epcs_epcs_control_port_end_xfer                            (d1_epcs_epcs_control_port_end_xfer),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                       (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .d1_pio_led_s1_end_xfer                                        (d1_pio_led_s1_end_xfer),
      .d1_sdram_s1_end_xfer                                          (d1_sdram_s1_end_xfer),
      .d1_sysid_control_slave_end_xfer                               (d1_sysid_control_slave_end_xfer),
      .epcs_epcs_control_port_irq_from_sa                            (epcs_epcs_control_port_irq_from_sa),
      .epcs_epcs_control_port_readdata_from_sa                       (epcs_epcs_control_port_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                       (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                  (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa               (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .pio_led_s1_readdata_from_sa                                   (pio_led_s1_readdata_from_sa),
      .reset_n                                                       (clk_reset_n),
      .sdram_s1_readdata_from_sa                                     (sdram_s1_readdata_from_sa),
      .sdram_s1_waitrequest_from_sa                                  (sdram_s1_waitrequest_from_sa),
      .sysid_control_slave_readdata_from_sa                          (sysid_control_slave_readdata_from_sa)
    );

  cpu_instruction_master_arbitrator the_cpu_instruction_master
    (
      .clk                                                             (clk),
      .cpu_instruction_master_address                                  (cpu_instruction_master_address),
      .cpu_instruction_master_address_to_slave                         (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                              (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_cpu_jtag_debug_module            (cpu_instruction_master_granted_cpu_jtag_debug_module),
      .cpu_instruction_master_granted_epcs_epcs_control_port           (cpu_instruction_master_granted_epcs_epcs_control_port),
      .cpu_instruction_master_granted_sdram_s1                         (cpu_instruction_master_granted_sdram_s1),
      .cpu_instruction_master_latency_counter                          (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_cpu_jtag_debug_module  (cpu_instruction_master_qualified_request_cpu_jtag_debug_module),
      .cpu_instruction_master_qualified_request_epcs_epcs_control_port (cpu_instruction_master_qualified_request_epcs_epcs_control_port),
      .cpu_instruction_master_qualified_request_sdram_s1               (cpu_instruction_master_qualified_request_sdram_s1),
      .cpu_instruction_master_read                                     (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_cpu_jtag_debug_module    (cpu_instruction_master_read_data_valid_cpu_jtag_debug_module),
      .cpu_instruction_master_read_data_valid_epcs_epcs_control_port   (cpu_instruction_master_read_data_valid_epcs_epcs_control_port),
      .cpu_instruction_master_read_data_valid_sdram_s1                 (cpu_instruction_master_read_data_valid_sdram_s1),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register  (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_readdata                                 (cpu_instruction_master_readdata),
      .cpu_instruction_master_readdatavalid                            (cpu_instruction_master_readdatavalid),
      .cpu_instruction_master_requests_cpu_jtag_debug_module           (cpu_instruction_master_requests_cpu_jtag_debug_module),
      .cpu_instruction_master_requests_epcs_epcs_control_port          (cpu_instruction_master_requests_epcs_epcs_control_port),
      .cpu_instruction_master_requests_sdram_s1                        (cpu_instruction_master_requests_sdram_s1),
      .cpu_instruction_master_waitrequest                              (cpu_instruction_master_waitrequest),
      .cpu_jtag_debug_module_readdata_from_sa                          (cpu_jtag_debug_module_readdata_from_sa),
      .d1_cpu_jtag_debug_module_end_xfer                               (d1_cpu_jtag_debug_module_end_xfer),
      .d1_epcs_epcs_control_port_end_xfer                              (d1_epcs_epcs_control_port_end_xfer),
      .d1_sdram_s1_end_xfer                                            (d1_sdram_s1_end_xfer),
      .epcs_epcs_control_port_readdata_from_sa                         (epcs_epcs_control_port_readdata_from_sa),
      .reset_n                                                         (clk_reset_n),
      .sdram_s1_readdata_from_sa                                       (sdram_s1_readdata_from_sa),
      .sdram_s1_waitrequest_from_sa                                    (sdram_s1_waitrequest_from_sa)
    );

  cpu the_cpu
    (
      .clk                                   (clk),
      .d_address                             (cpu_data_master_address),
      .d_byteenable                          (cpu_data_master_byteenable),
      .d_irq                                 (cpu_data_master_irq),
      .d_read                                (cpu_data_master_read),
      .d_readdata                            (cpu_data_master_readdata),
      .d_waitrequest                         (cpu_data_master_waitrequest),
      .d_write                               (cpu_data_master_write),
      .d_writedata                           (cpu_data_master_writedata),
      .i_address                             (cpu_instruction_master_address),
      .i_read                                (cpu_instruction_master_read),
      .i_readdata                            (cpu_instruction_master_readdata),
      .i_readdatavalid                       (cpu_instruction_master_readdatavalid),
      .i_waitrequest                         (cpu_instruction_master_waitrequest),
      .jtag_debug_module_address             (cpu_jtag_debug_module_address),
      .jtag_debug_module_begintransfer       (cpu_jtag_debug_module_begintransfer),
      .jtag_debug_module_byteenable          (cpu_jtag_debug_module_byteenable),
      .jtag_debug_module_debugaccess         (cpu_jtag_debug_module_debugaccess),
      .jtag_debug_module_debugaccess_to_roms (cpu_data_master_debugaccess),
      .jtag_debug_module_readdata            (cpu_jtag_debug_module_readdata),
      .jtag_debug_module_resetrequest        (cpu_jtag_debug_module_resetrequest),
      .jtag_debug_module_select              (cpu_jtag_debug_module_chipselect),
      .jtag_debug_module_write               (cpu_jtag_debug_module_write),
      .jtag_debug_module_writedata           (cpu_jtag_debug_module_writedata),
      .reset_n                               (cpu_jtag_debug_module_reset_n)
    );

  epcs_epcs_control_port_arbitrator the_epcs_epcs_control_port
    (
      .clk                                                             (clk),
      .cpu_data_master_address_to_slave                                (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_epcs_epcs_control_port                  (cpu_data_master_granted_epcs_epcs_control_port),
      .cpu_data_master_qualified_request_epcs_epcs_control_port        (cpu_data_master_qualified_request_epcs_epcs_control_port),
      .cpu_data_master_read                                            (cpu_data_master_read),
      .cpu_data_master_read_data_valid_epcs_epcs_control_port          (cpu_data_master_read_data_valid_epcs_epcs_control_port),
      .cpu_data_master_requests_epcs_epcs_control_port                 (cpu_data_master_requests_epcs_epcs_control_port),
      .cpu_data_master_write                                           (cpu_data_master_write),
      .cpu_data_master_writedata                                       (cpu_data_master_writedata),
      .cpu_instruction_master_address_to_slave                         (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_granted_epcs_epcs_control_port           (cpu_instruction_master_granted_epcs_epcs_control_port),
      .cpu_instruction_master_latency_counter                          (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_epcs_epcs_control_port (cpu_instruction_master_qualified_request_epcs_epcs_control_port),
      .cpu_instruction_master_read                                     (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_epcs_epcs_control_port   (cpu_instruction_master_read_data_valid_epcs_epcs_control_port),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register  (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_epcs_epcs_control_port          (cpu_instruction_master_requests_epcs_epcs_control_port),
      .d1_epcs_epcs_control_port_end_xfer                              (d1_epcs_epcs_control_port_end_xfer),
      .epcs_epcs_control_port_address                                  (epcs_epcs_control_port_address),
      .epcs_epcs_control_port_chipselect                               (epcs_epcs_control_port_chipselect),
      .epcs_epcs_control_port_dataavailable                            (epcs_epcs_control_port_dataavailable),
      .epcs_epcs_control_port_dataavailable_from_sa                    (epcs_epcs_control_port_dataavailable_from_sa),
      .epcs_epcs_control_port_endofpacket                              (epcs_epcs_control_port_endofpacket),
      .epcs_epcs_control_port_endofpacket_from_sa                      (epcs_epcs_control_port_endofpacket_from_sa),
      .epcs_epcs_control_port_irq                                      (epcs_epcs_control_port_irq),
      .epcs_epcs_control_port_irq_from_sa                              (epcs_epcs_control_port_irq_from_sa),
      .epcs_epcs_control_port_read_n                                   (epcs_epcs_control_port_read_n),
      .epcs_epcs_control_port_readdata                                 (epcs_epcs_control_port_readdata),
      .epcs_epcs_control_port_readdata_from_sa                         (epcs_epcs_control_port_readdata_from_sa),
      .epcs_epcs_control_port_readyfordata                             (epcs_epcs_control_port_readyfordata),
      .epcs_epcs_control_port_readyfordata_from_sa                     (epcs_epcs_control_port_readyfordata_from_sa),
      .epcs_epcs_control_port_reset_n                                  (epcs_epcs_control_port_reset_n),
      .epcs_epcs_control_port_write_n                                  (epcs_epcs_control_port_write_n),
      .epcs_epcs_control_port_writedata                                (epcs_epcs_control_port_writedata),
      .reset_n                                                         (clk_reset_n)
    );

  epcs the_epcs
    (
      .address       (epcs_epcs_control_port_address),
      .chipselect    (epcs_epcs_control_port_chipselect),
      .clk           (clk),
      .data0         (data0_to_the_epcs),
      .dataavailable (epcs_epcs_control_port_dataavailable),
      .dclk          (dclk_from_the_epcs),
      .endofpacket   (epcs_epcs_control_port_endofpacket),
      .irq           (epcs_epcs_control_port_irq),
      .read_n        (epcs_epcs_control_port_read_n),
      .readdata      (epcs_epcs_control_port_readdata),
      .readyfordata  (epcs_epcs_control_port_readyfordata),
      .reset_n       (epcs_epcs_control_port_reset_n),
      .sce           (sce_from_the_epcs),
      .sdo           (sdo_from_the_epcs),
      .write_n       (epcs_epcs_control_port_write_n),
      .writedata     (epcs_epcs_control_port_writedata)
    );

  jtag_uart_avalon_jtag_slave_arbitrator the_jtag_uart_avalon_jtag_slave
    (
      .clk                                                           (clk),
      .cpu_data_master_address_to_slave                              (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_jtag_uart_avalon_jtag_slave           (cpu_data_master_granted_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave (cpu_data_master_qualified_request_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_read                                          (cpu_data_master_read),
      .cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave   (cpu_data_master_read_data_valid_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_requests_jtag_uart_avalon_jtag_slave          (cpu_data_master_requests_jtag_uart_avalon_jtag_slave),
      .cpu_data_master_waitrequest                                   (cpu_data_master_waitrequest),
      .cpu_data_master_write                                         (cpu_data_master_write),
      .cpu_data_master_writedata                                     (cpu_data_master_writedata),
      .d1_jtag_uart_avalon_jtag_slave_end_xfer                       (d1_jtag_uart_avalon_jtag_slave_end_xfer),
      .jtag_uart_avalon_jtag_slave_address                           (jtag_uart_avalon_jtag_slave_address),
      .jtag_uart_avalon_jtag_slave_chipselect                        (jtag_uart_avalon_jtag_slave_chipselect),
      .jtag_uart_avalon_jtag_slave_dataavailable                     (jtag_uart_avalon_jtag_slave_dataavailable),
      .jtag_uart_avalon_jtag_slave_dataavailable_from_sa             (jtag_uart_avalon_jtag_slave_dataavailable_from_sa),
      .jtag_uart_avalon_jtag_slave_irq                               (jtag_uart_avalon_jtag_slave_irq),
      .jtag_uart_avalon_jtag_slave_irq_from_sa                       (jtag_uart_avalon_jtag_slave_irq_from_sa),
      .jtag_uart_avalon_jtag_slave_read_n                            (jtag_uart_avalon_jtag_slave_read_n),
      .jtag_uart_avalon_jtag_slave_readdata                          (jtag_uart_avalon_jtag_slave_readdata),
      .jtag_uart_avalon_jtag_slave_readdata_from_sa                  (jtag_uart_avalon_jtag_slave_readdata_from_sa),
      .jtag_uart_avalon_jtag_slave_readyfordata                      (jtag_uart_avalon_jtag_slave_readyfordata),
      .jtag_uart_avalon_jtag_slave_readyfordata_from_sa              (jtag_uart_avalon_jtag_slave_readyfordata_from_sa),
      .jtag_uart_avalon_jtag_slave_reset_n                           (jtag_uart_avalon_jtag_slave_reset_n),
      .jtag_uart_avalon_jtag_slave_waitrequest                       (jtag_uart_avalon_jtag_slave_waitrequest),
      .jtag_uart_avalon_jtag_slave_waitrequest_from_sa               (jtag_uart_avalon_jtag_slave_waitrequest_from_sa),
      .jtag_uart_avalon_jtag_slave_write_n                           (jtag_uart_avalon_jtag_slave_write_n),
      .jtag_uart_avalon_jtag_slave_writedata                         (jtag_uart_avalon_jtag_slave_writedata),
      .reset_n                                                       (clk_reset_n)
    );

  jtag_uart the_jtag_uart
    (
      .av_address     (jtag_uart_avalon_jtag_slave_address),
      .av_chipselect  (jtag_uart_avalon_jtag_slave_chipselect),
      .av_irq         (jtag_uart_avalon_jtag_slave_irq),
      .av_read_n      (jtag_uart_avalon_jtag_slave_read_n),
      .av_readdata    (jtag_uart_avalon_jtag_slave_readdata),
      .av_waitrequest (jtag_uart_avalon_jtag_slave_waitrequest),
      .av_write_n     (jtag_uart_avalon_jtag_slave_write_n),
      .av_writedata   (jtag_uart_avalon_jtag_slave_writedata),
      .clk            (clk),
      .dataavailable  (jtag_uart_avalon_jtag_slave_dataavailable),
      .readyfordata   (jtag_uart_avalon_jtag_slave_readyfordata),
      .rst_n          (jtag_uart_avalon_jtag_slave_reset_n)
    );

  pio_led_s1_arbitrator the_pio_led_s1
    (
      .clk                                          (clk),
      .cpu_data_master_address_to_slave             (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_pio_led_s1           (cpu_data_master_granted_pio_led_s1),
      .cpu_data_master_qualified_request_pio_led_s1 (cpu_data_master_qualified_request_pio_led_s1),
      .cpu_data_master_read                         (cpu_data_master_read),
      .cpu_data_master_read_data_valid_pio_led_s1   (cpu_data_master_read_data_valid_pio_led_s1),
      .cpu_data_master_requests_pio_led_s1          (cpu_data_master_requests_pio_led_s1),
      .cpu_data_master_waitrequest                  (cpu_data_master_waitrequest),
      .cpu_data_master_write                        (cpu_data_master_write),
      .cpu_data_master_writedata                    (cpu_data_master_writedata),
      .d1_pio_led_s1_end_xfer                       (d1_pio_led_s1_end_xfer),
      .pio_led_s1_address                           (pio_led_s1_address),
      .pio_led_s1_chipselect                        (pio_led_s1_chipselect),
      .pio_led_s1_readdata                          (pio_led_s1_readdata),
      .pio_led_s1_readdata_from_sa                  (pio_led_s1_readdata_from_sa),
      .pio_led_s1_reset_n                           (pio_led_s1_reset_n),
      .pio_led_s1_write_n                           (pio_led_s1_write_n),
      .pio_led_s1_writedata                         (pio_led_s1_writedata),
      .reset_n                                      (clk_reset_n)
    );

  pio_led the_pio_led
    (
      .address    (pio_led_s1_address),
      .chipselect (pio_led_s1_chipselect),
      .clk        (clk),
      .out_port   (out_port_from_the_pio_led),
      .readdata   (pio_led_s1_readdata),
      .reset_n    (pio_led_s1_reset_n),
      .write_n    (pio_led_s1_write_n),
      .writedata  (pio_led_s1_writedata)
    );

  sdram_s1_arbitrator the_sdram_s1
    (
      .clk                                                            (clk),
      .cpu_data_master_address_to_slave                               (cpu_data_master_address_to_slave),
      .cpu_data_master_byteenable                                     (cpu_data_master_byteenable),
      .cpu_data_master_byteenable_sdram_s1                            (cpu_data_master_byteenable_sdram_s1),
      .cpu_data_master_dbs_address                                    (cpu_data_master_dbs_address),
      .cpu_data_master_dbs_write_16                                   (cpu_data_master_dbs_write_16),
      .cpu_data_master_granted_sdram_s1                               (cpu_data_master_granted_sdram_s1),
      .cpu_data_master_no_byte_enables_and_last_term                  (cpu_data_master_no_byte_enables_and_last_term),
      .cpu_data_master_qualified_request_sdram_s1                     (cpu_data_master_qualified_request_sdram_s1),
      .cpu_data_master_read                                           (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sdram_s1                       (cpu_data_master_read_data_valid_sdram_s1),
      .cpu_data_master_read_data_valid_sdram_s1_shift_register        (cpu_data_master_read_data_valid_sdram_s1_shift_register),
      .cpu_data_master_requests_sdram_s1                              (cpu_data_master_requests_sdram_s1),
      .cpu_data_master_waitrequest                                    (cpu_data_master_waitrequest),
      .cpu_data_master_write                                          (cpu_data_master_write),
      .cpu_instruction_master_address_to_slave                        (cpu_instruction_master_address_to_slave),
      .cpu_instruction_master_dbs_address                             (cpu_instruction_master_dbs_address),
      .cpu_instruction_master_granted_sdram_s1                        (cpu_instruction_master_granted_sdram_s1),
      .cpu_instruction_master_latency_counter                         (cpu_instruction_master_latency_counter),
      .cpu_instruction_master_qualified_request_sdram_s1              (cpu_instruction_master_qualified_request_sdram_s1),
      .cpu_instruction_master_read                                    (cpu_instruction_master_read),
      .cpu_instruction_master_read_data_valid_sdram_s1                (cpu_instruction_master_read_data_valid_sdram_s1),
      .cpu_instruction_master_read_data_valid_sdram_s1_shift_register (cpu_instruction_master_read_data_valid_sdram_s1_shift_register),
      .cpu_instruction_master_requests_sdram_s1                       (cpu_instruction_master_requests_sdram_s1),
      .d1_sdram_s1_end_xfer                                           (d1_sdram_s1_end_xfer),
      .reset_n                                                        (clk_reset_n),
      .sdram_s1_address                                               (sdram_s1_address),
      .sdram_s1_byteenable_n                                          (sdram_s1_byteenable_n),
      .sdram_s1_chipselect                                            (sdram_s1_chipselect),
      .sdram_s1_read_n                                                (sdram_s1_read_n),
      .sdram_s1_readdata                                              (sdram_s1_readdata),
      .sdram_s1_readdata_from_sa                                      (sdram_s1_readdata_from_sa),
      .sdram_s1_readdatavalid                                         (sdram_s1_readdatavalid),
      .sdram_s1_reset_n                                               (sdram_s1_reset_n),
      .sdram_s1_waitrequest                                           (sdram_s1_waitrequest),
      .sdram_s1_waitrequest_from_sa                                   (sdram_s1_waitrequest_from_sa),
      .sdram_s1_write_n                                               (sdram_s1_write_n),
      .sdram_s1_writedata                                             (sdram_s1_writedata)
    );

  sdram the_sdram
    (
      .az_addr        (sdram_s1_address),
      .az_be_n        (sdram_s1_byteenable_n),
      .az_cs          (sdram_s1_chipselect),
      .az_data        (sdram_s1_writedata),
      .az_rd_n        (sdram_s1_read_n),
      .az_wr_n        (sdram_s1_write_n),
      .clk            (clk),
      .reset_n        (sdram_s1_reset_n),
      .za_data        (sdram_s1_readdata),
      .za_valid       (sdram_s1_readdatavalid),
      .za_waitrequest (sdram_s1_waitrequest),
      .zs_addr        (zs_addr_from_the_sdram),
      .zs_ba          (zs_ba_from_the_sdram),
      .zs_cas_n       (zs_cas_n_from_the_sdram),
      .zs_cke         (zs_cke_from_the_sdram),
      .zs_cs_n        (zs_cs_n_from_the_sdram),
      .zs_dq          (zs_dq_to_and_from_the_sdram),
      .zs_dqm         (zs_dqm_from_the_sdram),
      .zs_ras_n       (zs_ras_n_from_the_sdram),
      .zs_we_n        (zs_we_n_from_the_sdram)
    );

  sysid_control_slave_arbitrator the_sysid_control_slave
    (
      .clk                                                   (clk),
      .cpu_data_master_address_to_slave                      (cpu_data_master_address_to_slave),
      .cpu_data_master_granted_sysid_control_slave           (cpu_data_master_granted_sysid_control_slave),
      .cpu_data_master_qualified_request_sysid_control_slave (cpu_data_master_qualified_request_sysid_control_slave),
      .cpu_data_master_read                                  (cpu_data_master_read),
      .cpu_data_master_read_data_valid_sysid_control_slave   (cpu_data_master_read_data_valid_sysid_control_slave),
      .cpu_data_master_requests_sysid_control_slave          (cpu_data_master_requests_sysid_control_slave),
      .cpu_data_master_write                                 (cpu_data_master_write),
      .d1_sysid_control_slave_end_xfer                       (d1_sysid_control_slave_end_xfer),
      .reset_n                                               (clk_reset_n),
      .sysid_control_slave_address                           (sysid_control_slave_address),
      .sysid_control_slave_readdata                          (sysid_control_slave_readdata),
      .sysid_control_slave_readdata_from_sa                  (sysid_control_slave_readdata_from_sa),
      .sysid_control_slave_reset_n                           (sysid_control_slave_reset_n)
    );

  sysid the_sysid
    (
      .address  (sysid_control_slave_address),
      .clock    (sysid_control_slave_clock),
      .readdata (sysid_control_slave_readdata),
      .reset_n  (sysid_control_slave_reset_n)
    );

  //reset is asserted asynchronously and deasserted synchronously
  NIOSTOP_reset_clk_domain_synch_module NIOSTOP_reset_clk_domain_synch
    (
      .clk      (clk),
      .data_in  (1'b1),
      .data_out (clk_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0 |
    cpu_jtag_debug_module_resetrequest_from_sa |
    cpu_jtag_debug_module_resetrequest_from_sa);

  //sysid_control_slave_clock of type clock does not connect to anything so wire it to default (0)
  assign sysid_control_slave_clock = 0;


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

`include "d:/altera/12.0/quartus/eda/sim_lib/altera_mf.v"
`include "d:/altera/12.0/quartus/eda/sim_lib/220model.v"
`include "d:/altera/12.0/quartus/eda/sim_lib/sgate.v"
`include "USB_EN.v"
`include "LAN_CS.v"
`include "sdram.v"
`include "sysid.v"
`include "USB_INT_I.v"
`include "USBSD_RDO.v"
`include "USB_SDO_I.v"
`include "epcs.v"
`include "pio_led.v"
`include "jtag_uart.v"
`include "USB_SCK_O.v"
`include "LAN.v"
`include "USB_SCS_O.v"
`include "cpu_test_bench.v"
`include "cpu_mult_cell.v"
`include "cpu_oci_test_bench.v"
`include "cpu_jtag_debug_module_tck.v"
`include "cpu_jtag_debug_module_sysclk.v"
`include "cpu_jtag_debug_module_wrapper.v"
`include "cpu.v"
`include "USBSD_RVLD.v"
`include "LAN_RSTN.v"
`include "LAN_nINT.v"
`include "NET_EN.v"
`include "USBSD_SEL.v"
`include "USB_SDI_O.v"
`include "NET_TESTDO.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             LAN_nINT_s1_irq;
  wire             LAN_spi_control_port_dataavailable_from_sa;
  wire             LAN_spi_control_port_endofpacket_from_sa;
  wire             LAN_spi_control_port_readyfordata_from_sa;
  wire             MISO_to_the_LAN;
  wire             MOSI_from_the_LAN;
  wire             SCLK_from_the_LAN;
  wire             SS_n_from_the_LAN;
  reg              clk;
  wire             data0_to_the_epcs;
  wire             dclk_from_the_epcs;
  wire             epcs_epcs_control_port_dataavailable_from_sa;
  wire             epcs_epcs_control_port_endofpacket_from_sa;
  wire             epcs_epcs_control_port_readyfordata_from_sa;
  wire             in_port_to_the_LAN_nINT;
  wire             in_port_to_the_NET_EN;
  wire             in_port_to_the_USBSD_SEL;
  wire             in_port_to_the_USB_EN;
  wire             in_port_to_the_USB_INT_I;
  wire             in_port_to_the_USB_SDO_I;
  wire             jtag_uart_avalon_jtag_slave_dataavailable_from_sa;
  wire             jtag_uart_avalon_jtag_slave_readyfordata_from_sa;
  wire             out_port_from_the_LAN_CS;
  wire             out_port_from_the_LAN_RSTN;
  wire             out_port_from_the_NET_TESTDO;
  wire    [ 15: 0] out_port_from_the_USBSD_RDO;
  wire             out_port_from_the_USBSD_RVLD;
  wire             out_port_from_the_USB_SCK_O;
  wire             out_port_from_the_USB_SCS_O;
  wire             out_port_from_the_USB_SDI_O;
  wire    [  3: 0] out_port_from_the_pio_led;
  reg              reset_n;
  wire             sce_from_the_epcs;
  wire             sdo_from_the_epcs;
  wire             sysid_control_slave_clock;
  wire    [ 12: 0] zs_addr_from_the_sdram;
  wire    [  1: 0] zs_ba_from_the_sdram;
  wire             zs_cas_n_from_the_sdram;
  wire             zs_cke_from_the_sdram;
  wire             zs_cs_n_from_the_sdram;
  wire    [ 15: 0] zs_dq_to_and_from_the_sdram;
  wire    [  1: 0] zs_dqm_from_the_sdram;
  wire             zs_ras_n_from_the_sdram;
  wire             zs_we_n_from_the_sdram;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  NIOSTOP DUT
    (
      .MISO_to_the_LAN              (MISO_to_the_LAN),
      .MOSI_from_the_LAN            (MOSI_from_the_LAN),
      .SCLK_from_the_LAN            (SCLK_from_the_LAN),
      .SS_n_from_the_LAN            (SS_n_from_the_LAN),
      .clk                          (clk),
      .data0_to_the_epcs            (data0_to_the_epcs),
      .dclk_from_the_epcs           (dclk_from_the_epcs),
      .in_port_to_the_LAN_nINT      (in_port_to_the_LAN_nINT),
      .in_port_to_the_NET_EN        (in_port_to_the_NET_EN),
      .in_port_to_the_USBSD_SEL     (in_port_to_the_USBSD_SEL),
      .in_port_to_the_USB_EN        (in_port_to_the_USB_EN),
      .in_port_to_the_USB_INT_I     (in_port_to_the_USB_INT_I),
      .in_port_to_the_USB_SDO_I     (in_port_to_the_USB_SDO_I),
      .out_port_from_the_LAN_CS     (out_port_from_the_LAN_CS),
      .out_port_from_the_LAN_RSTN   (out_port_from_the_LAN_RSTN),
      .out_port_from_the_NET_TESTDO (out_port_from_the_NET_TESTDO),
      .out_port_from_the_USBSD_RDO  (out_port_from_the_USBSD_RDO),
      .out_port_from_the_USBSD_RVLD (out_port_from_the_USBSD_RVLD),
      .out_port_from_the_USB_SCK_O  (out_port_from_the_USB_SCK_O),
      .out_port_from_the_USB_SCS_O  (out_port_from_the_USB_SCS_O),
      .out_port_from_the_USB_SDI_O  (out_port_from_the_USB_SDI_O),
      .out_port_from_the_pio_led    (out_port_from_the_pio_led),
      .reset_n                      (reset_n),
      .sce_from_the_epcs            (sce_from_the_epcs),
      .sdo_from_the_epcs            (sdo_from_the_epcs),
      .zs_addr_from_the_sdram       (zs_addr_from_the_sdram),
      .zs_ba_from_the_sdram         (zs_ba_from_the_sdram),
      .zs_cas_n_from_the_sdram      (zs_cas_n_from_the_sdram),
      .zs_cke_from_the_sdram        (zs_cke_from_the_sdram),
      .zs_cs_n_from_the_sdram       (zs_cs_n_from_the_sdram),
      .zs_dq_to_and_from_the_sdram  (zs_dq_to_and_from_the_sdram),
      .zs_dqm_from_the_sdram        (zs_dqm_from_the_sdram),
      .zs_ras_n_from_the_sdram      (zs_ras_n_from_the_sdram),
      .zs_we_n_from_the_sdram       (zs_we_n_from_the_sdram)
    );

  initial
    clk = 1'b0;
  always
    #5 clk <= ~clk;
  
  initial 
    begin
      reset_n <= 0;
      #100 reset_n <= 1;
    end

endmodule


//synthesis translate_on