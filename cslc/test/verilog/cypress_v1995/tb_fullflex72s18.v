//Copyright 2005, Cypress Semiconductor Corporation
/*****************************************************************************/
//This software is owned by Cypress Semiconductor Corporation (Cypress) and is
//protected by United States copyright laws and international treaty provisions.
//Cypress hereby grants to Licensee a personal, non-exclusive, non-transferable
//license to copy, use, modify, create derivative works of, and compile the
//Cypress Source Code and derivative works for the sole purpose of creating
//custom software in support of Licensee product ("Licensee Product") to be
//used only in conjunction with a Cypress integrated circuit. Any reproduction,
//modification, translation, compilation, or representation of this software
//except as specified above is prohibited without the express written permission
//of Cypress.


//Disclaimer: Cypress makes no warranty of any kind, express or implied, with
//regard to this material, including, but not limited to, the implied warranties
//of merchantability and fitness for a particular purpose. Cypress reserves the
//right to make changes without further notice to the materials described
//herein. Cypress does not assume any liability arising out of the application
//or use of any product or circuit described herein. Cypress products described
// herein are not authorized for use as components in life-support devices.
//This software is protected by and subject to worldwide patent coverage,
//including U.S. and foreign patents. Use may be limited by and subject to
//the Cypress Software License Agreement.
/*****************************************************************************/

//Source File Information Header Template
// *******************************************************************
// File           : tb_fullflex72s18.v
// Author         : 
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
//       This is the top level testbench file for FullFlex72 (18M DP SRAM).
//       The top level model file is instantiated in this file.
//       All the testcases are included in this file.
//       Also this file is responsible for the clock generation for the
//       model testing
//
// *******************************************************************


`timescale 1ns/1ps

`include "fullflex72s18_top.v"


 module tb_fullflex72s18;

  parameter            DW_36_72 = (`CYP_DATAWIDTH == 72 || `CYP_DATAWIDTH == 36 ? 1 : 0);
  parameter            CYP_DDR_MULT =(`CYP_ISDDR ? 2 : 1);

  reg                  inmrst;
  reg                  ileft_ftsel;
  
  // Configuration signals
  reg                  ileft_ddron;
  reg                  ileft_cqen;
  reg [1:0]            ileft_portstd;
  
  // I/O control logic
  wire [`CYP_DATAWIDTH-1:0] ioleft_dq;
  reg  [`CYP_BYTEWIDTH-1:0] inleft_be;
  reg                  inleft_ce0;
  reg                  ileft_ce1;
  reg [1:0]            ileft_zq;
  reg                  inleft_oe;
  reg                  inleft_rw;
  wire                 oleft_cq0;
  wire                 oleft_cq0_n;
  wire                 oleft_cq1;
  wire                 oleft_cq1_n;
  
  //Address access logic
  wire [`CYP_ADDRWIDTH-1:0] ioleft_a;
  reg                  ileft_cntmsk;
  reg                  ileft_ads;
  reg                  ileft_cnten;
  reg                  ileft_cntrst;
  reg                  ileft_ret;
  wire                 onleft_cntint;
  wire                 ileft_clk;
  wire                 ileft_clk_n;
  reg                  inleft_wrp;
  wire                 onleft_busy;
  wire                 onleft_int;
  wire                 onleft_ready;
  reg                  inleft_lowspd;

  // RIGHT PORT SIGNALS

  // Configuration signals
  reg                  iright_ftsel;
  reg                  iright_ddron;
  reg                  iright_cqen;
  reg [1:0]            iright_portstd;

  // I/O control logic
  wire[`CYP_DATAWIDTH-1:0] ioright_dq;
  reg [`CYP_BYTEWIDTH-1:0] inright_be;
  reg [`CYP_BYTEWIDTH-1:0] byte_r;
  reg [`CYP_BYTEWIDTH-1:0] byte_l;
  reg                  inright_ce0;
  reg                  iright_ce1;
  reg [1:0]            iright_zq;
  reg                  inright_oe;
  reg                  inright_rw;
  wire                 oright_cq0;
  wire                 oright_cq0_n;
  wire                 oright_cq1;
  wire                 oright_cq1_n;

  //Address access logic
  wire[`CYP_ADDRWIDTH-1:0] ioright_a;
  reg                  iright_cntmsk;
  reg                  iright_ads;
  reg                  iright_cnten;
  reg                  iright_cntrst;
  reg                  iright_ret;
  wire                 onright_cntint;
  wire                 iright_clk;
  wire                 iright_clk_n;
  reg                  inright_wrp;
  wire                 onright_busy;
  wire                 onright_int;
  wire                 onright_ready;
  reg                  inright_lowspd;

  reg                  ileft_clk_arb;
  reg                  ileft_clk_arb_n;
  reg                  ileft_clk_norm;
  reg                  ileft_clk_norm_n;

  reg                  iright_clk_arb;
  reg                  iright_clk_arb_n;
  reg                  iright_clk_norm;
  reg                  iright_clk_norm_n;

  
  
  reg [`CYP_DATAWIDTH-1:0] dq_write_l;
  reg [`CYP_DATAWIDTH-1:0] dq_write_r;

  reg [`CYP_ADDRWIDTH-1:0] a_rw_l;
  reg [`CYP_ADDRWIDTH-1:0] a_rw_r;

  reg [`CYP_DATAWIDTH*CYP_DDR_MULT - 1:0] memory_data[0:`CYP_LASTADDR]; 
                                 //testbench memory data array
  reg op_read_l;                 // Left port Read operation indication
  reg op_write_l;                // Left port Write operation indication
  reg op_readback_l;             // Left port Readback operation indication
  reg op_config_l;               // Left port model configuration indication
  reg op_read_r;                 // right port Read operation indication
  reg op_write_r;                // right port Write operation indication
  reg op_readback_r;             // right port Readback operation indication
  reg op_config_r;               // Right port model configuration indication
  
  reg arb_test_on;               // Register indicates the arbitration test
  reg generate_clk_left;         // Left clock start
  reg generate_clk_right;        // Right clock start
  reg generate_clk_arb;          // Arbitration test clock start

  reg left_clk_first;            // Left clock comes before right clock
  reg right_clk_first;           // Right clock comes before left clock

  realtime arb_delay_left_right; // arbitration clock delay Left to Right
  realtime arb_delay_right_left; // arbitration clock delay Right to Left

  realtime tCCS_test;


  real ileft_clk_freq;           // left clock frequency 
  real iright_clk_freq;          // right clock frequency

  real ileft_clk_period;         // left clock period
  real iright_clk_period;        // right clock period
  real ileft_clk_period_old;     // left clock period back-up value
  real iright_clk_period_old;    // right clock period back-up value
  integer i,j;                   // internal control integers
  reg  failed_flag;              // Failed Flag for testcases
  reg  failed_flag_local;        // Local failed flag for the testcases
  realtime offset;               // Offset time for checking timing parameters
  reg [71:0] mem_test [150:0];   // Random data for memory write operations
  integer    rnd_data_ptr;       // Random data pointer
  reg [71:0] rand_temp_data;     // Temporary random data

  // Verbosity settings registers
  reg                     nmsg;  // NOTE message ON input
  reg                     wmsg;  // WARNING message ON input
  reg                     emsg;  // ERROR message ON input
  reg                     rmsg;  // Testcase report message ON input
 
  event                   busy_check_low_l;
  event                   busy_check_low_r;

  // Testbench task files included 
  `include "tb_fullflex72_tasks_left.v"
  `include "tb_fullflex72_tasks_right.v"

  // Testcase files included
  `include "testcase_read_write_addr.v"
  `include "testcase_read_write_counter.v"
  `include "testcase_echo_clock.v"
  `include "testcase_retransmit_test_wrp.v"
  `include "testcase_byte_enable.v"
  `include "testcase_counter_load_readback.v"
  `include "testcase_counter_hold.v"
  `include "testcase_mask_load_readback.v"
  `include "testcase_last_busy_addr.v"
  `include "testcase_mailbox.v"
  `include "testcase_master_reset.v"
  `include "testcase_reset_busy_reg.v"
  `include "testcase_counter_reset.v"
  `include "testcase_mask_reset.v"
  `include "testcase_retransmit_1_test.v"
  `include "testcase_counter_interrupt.v"
  `include "testcase_mask_register.v"
  `include "testcase_read_write_addr_count.v"
  `include "testcase_output_enable.v"
  `include "testcase_mask_invalid_load.v" 
  `include "testcase_freq_range.v"
  `include "testcase_invalid_operations.v"
  //`include "testcase_dynamic_config_error.v"
  `include "testcase_error_be_1.v"
  `include "testcase_read_write_sync.v"
  `include "testcase_timing_check.v"
  `include "testcase_chip_enable.v"
  `include "testcase_arb_sdr.v"
  `include "testcase_arb_flow_through.v"
  `include "testcase_arb_ddr.v"
  `include "testcase_arb_sdr_ddr.v"
  `include "testcase_arb_more_cycle.v"


  // Model (model under test) instantiation
  fullflex72s18_top #(
                 `CYP_ADDRWIDTH,  
                 `CYP_DATAWIDTH,  
                 `CYP_BYTEWIDTH,  
                 `CYP_LASTADDR,  
                 `CYP_ISDDR,      
                 `CYP_ISSDR,      
                 `CYP_ISFREQ250  ,
                 `CYP_ISFREQ200  ,
                 `CYP_ISFREQ167 , 
                 `CYP_ISFREQ133  ,
                 `CYP_ISFREQ100  ,
                 `CYP_ISFREQ83   ,
                 `CYP_ISMINDEL   ,
                 `CYP_ISMAXDEL                 
                )
       
   top_module   (
                 .inmrst         (inmrst),
                 .ileft_ftsel    (ileft_ftsel),
		 
                 // Configuration signals
                 .ileft_ddron    (ileft_ddron),
                 .ileft_cqen     (ileft_cqen),
                 .ileft_portstd  (ileft_portstd),
		 
                 // I/O control logic
                 .ioleft_dq      (ioleft_dq),
                 .inleft_be      (inleft_be),
                 .inleft_ce0     (inleft_ce0),
                 .ileft_ce1      (ileft_ce1),
                 .inleft_oe      (inleft_oe),
                 .ileft_zq       (ileft_zq),
                 .inleft_rw      (inleft_rw),
                 .oleft_cq0      (oleft_cq0),
                 .oleft_cq0_n    (oleft_cq0_n),
                 .oleft_cq1      (oleft_cq1),
                 .oleft_cq1_n    (oleft_cq1_n),
		 
                 //Address access logic
                 .ioleft_a       (ioleft_a),
                 .ileft_cntmsk   (ileft_cntmsk),
                 .ileft_ads      (ileft_ads),
                 .ileft_cnten    (ileft_cnten),
                 .ileft_cntrst   (ileft_cntrst),
                 .ileft_ret      (ileft_ret),
                 .onleft_cntint  (onleft_cntint),
                 .ileft_clk      (ileft_clk),
                 .ileft_clk_n    (ileft_clk_n),
                 .inleft_wrp     (inleft_wrp),
                 .onleft_busy    (onleft_busy),
                 .onleft_int     (onleft_int),
                 .onleft_ready   (onleft_ready),
                 .inleft_lowspd  (inleft_lowspd),

		 // RIGHT PORT SIGNALS
                 // Configuration signals
                 .iright_ftsel   (iright_ftsel),
                 .iright_ddron   (iright_ddron),
                 .iright_cqen    (iright_cqen),
                 .iright_portstd (iright_portstd),
		 
                 // I/O control logic
                 .ioright_dq     (ioright_dq),
                 .inright_be     (inright_be),
                 .inright_ce0    (inright_ce0),
                 .iright_ce1     (iright_ce1),
                 .inright_oe     (inright_oe),
                 .iright_zq      (iright_zq),
                 .inright_rw     (inright_rw),
                 .oright_cq0     (oright_cq0),
                 .oright_cq0_n   (oright_cq0_n),
                 .oright_cq1     (oright_cq1),
                 .oright_cq1_n   (oright_cq1_n),
		 
                 //Address access logic
                 .ioright_a      (ioright_a),
                 .iright_cntmsk  (iright_cntmsk),
                 .iright_ads     (iright_ads),
                 .iright_cnten   (iright_cnten),
                 .iright_cntrst  (iright_cntrst),
                 .iright_ret     (iright_ret),
                 .onright_cntint (onright_cntint),
                 .iright_clk     (iright_clk),
                 .iright_clk_n   (iright_clk_n),
                 .inright_wrp    (inright_wrp),
                 .onright_busy   (onright_busy),
                 .onright_int    (onright_int),
                 .onright_ready  (onright_ready),
                 .inright_lowspd (inright_lowspd)
                );


  // Instantiating the timing parameter module
  fullflex72s18_timing  # (
                 `CYP_ISFREQ250,
                 `CYP_ISFREQ200,
                 `CYP_ISFREQ167,
                 `CYP_ISFREQ133,
                 `CYP_ISFREQ100,
                 `CYP_ISFREQ83,
                 `CYP_ISMINDEL,
                 `CYP_ISMAXDEL)
              TP (
		 .inmsg(nmsg),
		 .iwmsg(wmsg),
		 .iemsg(emsg),
                 .ileft_ddron(`CYP_ISDDR || ((`CYP_ISSDR == 0) && ileft_ddron)),
                 .ileft_ftsel(ileft_ftsel),
		 .inleft_lowspd(inleft_lowspd),
		 .iright_ddron(`CYP_ISDDR || ((`CYP_ISSDR ==0) && iright_ddron)),
                 .iright_ftsel(iright_ftsel),
		 .inright_lowspd(inright_lowspd),
                 .inreset(inmrst),
		 .ileft_clk(ileft_clk),
		 .iright_clk(iright_clk)
                 );

  // Input/Output signal assignments
  assign ioleft_a     = (op_read_l==1'b1 || op_write_l ==1'b1 || op_config_l == 1'b1) ? 
	                 a_rw_l:{`CYP_ADDRWIDTH{1'bZ}}; 
  assign ioleft_dq    = (op_write_l == 1'b1) ? dq_write_l : {`CYP_DATAWIDTH{1'bZ}};

  assign ioright_a    = (op_read_r==1'b1 || op_write_r ==1'b1 || op_config_r == 1'b1) ?
	                 a_rw_r:{`CYP_ADDRWIDTH{1'bZ}};
  assign ioright_dq   = (op_write_r == 1'b1) ? dq_write_r : {`CYP_DATAWIDTH{1'bZ}};

  assign ileft_clk    = (arb_test_on == 1'b1) ? ileft_clk_arb : ileft_clk_norm;
  assign ileft_clk_n  = (arb_test_on == 1'b1 && ileft_ddron == 1'b1) ? 
	                 ileft_clk_arb_n  : ileft_clk_norm_n;
  assign iright_clk   = (arb_test_on == 1'b1) ? iright_clk_arb   : iright_clk_norm;
  assign iright_clk_n = ((arb_test_on == 1'b1) && (iright_ddron == 1'b1)) ? 
	                 iright_clk_arb_n : iright_clk_norm_n;

  // Test process starts here
  initial
  begin
      //$dumpfile("verilog.vcd");
      //$dumpvars();
      $readmemh("tb/rnd_data_file.txt",mem_test);

      failed_flag           = 1'b0;
      failed_flag_local     = 1'b0;
      inmrst                = 1'b1;
      ileft_ftsel           = 1'b1;
      ileft_ddron           = 1'b0;
      ileft_cqen            = 1'b0;
      ileft_portstd         = 2'b01;
      dq_write_l            = {`CYP_DATAWIDTH{1'b0}};
      inleft_be             = {`CYP_BYTEWIDTH{1'b0}};
      inleft_ce0            = 1'b1;
      ileft_ce1             = 1'b0;
      ileft_zq              = 2'b00;
      inleft_oe             = 1'b1;
      inleft_rw             = 1'b1;
      a_rw_l                = {`CYP_ADDRWIDTH{1'bZ}}; 
      ileft_cntmsk          = 1'b1;
      ileft_ads             = 1'b1;
      ileft_cnten           = 1'b0;
      ileft_cntrst          = 1'b1;
      ileft_ret             = 1'b1;
      ileft_clk_norm        = 1'b0;
      ileft_clk_norm_n      = 1'b1;
      ileft_clk_arb         = 1'b0;
      ileft_clk_arb_n       = 1'b1;
      inleft_wrp            = 1'b1;
      inleft_lowspd         = 1'b1;

      iright_ftsel          = 1'b1;
      iright_ddron          = 1'b0;
      iright_cqen           = 1'b0;
      iright_portstd        = 2'b01;
      dq_write_r            = {`CYP_DATAWIDTH{1'b0}};
      inright_be            = {`CYP_BYTEWIDTH{1'b0}};
      inright_ce0           = 1'b1;
      iright_ce1            = 1'b0;
      iright_zq             = 2'b00;
      inright_oe            = 1'b1;
      inright_rw            = 1'b1;
      a_rw_r                = {`CYP_ADDRWIDTH{1'bZ}};
      iright_cntmsk         = 1'b1;
      iright_ads            = 1'b1;
      iright_cnten          = 1'b0;
      iright_cntrst         = 1'b1;
      iright_ret            = 1'b1;
      iright_clk_norm       = 1'b0;
      iright_clk_norm_n     = 1'b1;
      iright_clk_arb        = 1'b0;
      iright_clk_arb_n      = 1'b1;
      inright_wrp           = 1'b1;
      inright_lowspd        = 1'b1;

      offset                = 0.005;
      arb_test_on           = 1'b0;
      generate_clk_arb      = 1'b0;
      generate_clk_left     = 1'b0;
      generate_clk_right    = 1'b0;

      left_clk_first        = 1'b1;
      right_clk_first       = 1'b0;
      arb_delay_left_right  = 0.0;
      arb_delay_right_left  = 0.0;
      tCCS_test             = 0.0;
      rnd_data_ptr          = 0;

      op_read_l             = 1'b0;
      op_read_r             = 1'b0;
      op_write_l            = 1'b0;
      op_write_r            = 1'b0;
      op_readback_l         = 1'b0;
      op_readback_r         = 1'b0;
      op_config_l           = 1'b1;
      op_config_l           = 1'b1;

      `ifdef nmsg       // All messages on
         nmsg <= 1'b1;
         wmsg <= 1'b1;
         emsg <= 1'b1;
	 rmsg <= 1'b1;
      `else
      `ifdef emsg       // Error messages ON
         nmsg <= 1'b0;
         wmsg <= 1'b0;
         emsg <= 1'b1;
	 rmsg <= 1'b0;
      `else
      `ifdef wmsg       // Warning and Error messages ON
         nmsg <= 1'b0;
         wmsg <= 1'b1;
         emsg <= 1'b1;
	 rmsg <= 1'b0;
      `else
      `ifdef rmsg       // Test report and Error messages ON
         nmsg <= 1'b0;
         wmsg <= 1'b0;
         emsg <= 1'b1;
	 rmsg <= 1'b1;
      `else
      `ifdef msgoff     // All messages OFF
         nmsg <= 1'b0;
         wmsg <= 1'b0;
         emsg <= 1'b0;
	 rmsg <= 1'b0;
      `else             // Default Error messages only ON
         nmsg <= 1'b0;
         wmsg <= 1'b0;
         emsg <= 1'b1;
	 rmsg <= 1'b0;
      `endif
      `endif
      `endif
      `endif
      `endif
      if (`CYP_ISDDR == 1)
      begin
	if(`CYP_ISFREQ167)
	begin
	  ileft_clk_period_old  = 6;
          iright_clk_period_old = 6;
          ileft_clk_period      = 6;
          iright_clk_period     = 6;
	end
	else
	begin
          ileft_clk_period_old  = 5;
          iright_clk_period_old = 5;
          ileft_clk_period      = 5;
          iright_clk_period     = 5;
        end
      end
      else
      begin
        ileft_clk_period_old  = 7.8;
        iright_clk_period_old = 7.8;
        ileft_clk_period      = 7.8;
        iright_clk_period     = 7.8;
      end
      
      # 50;
      
      `ifdef REGRESSION
         if (`CYP_ISSDR == 1) 
         begin
            read_write_flow_through_addr_l;
            read_write_flow_through_addr_r;
            read_write_sdr2_addr_l;
            read_write_sdr2_addr_r;
            read_write_flow_through_counter_l;
            read_write_flow_through_counter_r;
            read_write_sdr2_counter_l;
            read_write_sdr2_counter_r;
            read_write_sdr2_addr_count_l;
            read_write_sdr2_addr_count_r;
            byte_enable_sdr_test_l; 
            byte_enable_sdr_test_r;
            retransmit_wrp_l; 
            retransmit_wrp_r;
            counter_load_readback_sdr_test_l;
            counter_load_readback_sdr_test_r;
	    counter_hold_test_l;
	    counter_hold_test_r;
            mask_load_readback_test_l;
            mask_load_readback_test_r;
            counter_busy_readback_test_l;
            counter_busy_readback_test_r;
            mailbox_sdr_test;
            basic_reset_test;
            counter_reset_test_l;
            counter_reset_test_r;
            mask_reset_test_l;
            mask_reset_test_r;
            retransmit_1_test_l;
            retransmit_1_test_r;
            counter_interrupt_sdr_l;
            counter_interrupt_sdr_r;
            mask_reg_test_l;
            mask_reg_test_r;
            master_reset_counter_test_l;
            master_reset_counter_test_r;
            master_reset_mask_test_l;
            master_reset_mask_test_r;
            master_reset_mirror_reg_test_l;
            master_reset_mirror_reg_test_l;
	    master_reset_busy_reg_l;
            read_write_sdr2_addr_ce_r;
            read_write_sdr2_addr_ce_l;
            read_write_sdr2_addr_oe_l;
            read_write_sdr2_addr_oe_r; 
	    echo_clock_test_sdr;
            arb_test_w_w_violate_tCCS_l;
            arb_test_w_w_violate_tCCS_r;
            arb_test_r_w_violate_tCCS_l;
            arb_test_r_w_violate_tCCS_r;
            arb_test_w_r_violate_tCCS_l;
            arb_test_w_r_violate_tCCS_r;
            arb_test_r_w_no_violation_l;
            arb_test_r_w_no_violation_r;
            arb_test_w_w_violate_tCCS_flow_throgh_l;
            arb_test_long_time_l;
            arb_test_long_time_r;
         end
         else if (`CYP_ISDDR == 1)
         begin
            read_write_ddr2_addr_l;
            read_write_ddr2_addr_r;
            read_write_ddr2_counter_l;
            read_write_ddr2_counter_r;
	    byte_enable_ddr_test_l;
	    byte_enable_ddr_test_r;
            mailbox_ddr_test;
            echo_clock_test_ddr;
	    counter_interrupt_ddr_l;
	    counter_interrupt_ddr_r;
            arb_test_w_ddr_w_ddr_violate_tCCS_l;
            arb_test_w_ddr_w_ddr_violate_tCCS_r; 
         end
         else 
         begin
            basic_reset_test;
	    master_reset_busy_reg_l;
	    master_reset_busy_reg_r;
            master_reset_counter_test_l;
            master_reset_counter_test_r;
            master_reset_mask_test_l;
            master_reset_mask_test_r;
            master_reset_mirror_reg_test_l;
            master_reset_mirror_reg_test_r;
            read_write_flow_through_addr_l;
            read_write_flow_through_addr_r;
            read_write_sdr2_addr_l;
            read_write_sdr2_addr_r;
            read_write_flow_through_counter_l;
            read_write_flow_through_counter_r;
            read_write_sdr2_counter_l;
            read_write_sdr2_counter_r;
            read_write_sdr2_addr_count_l;
            read_write_sdr2_addr_count_r;
            read_write_ddr2_addr_l;
            read_write_ddr2_addr_r;
            read_write_ddr2_counter_l;
            read_write_ddr2_counter_r;
            byte_enable_sdr_test_l; 
            byte_enable_sdr_test_r;
	    byte_enable_ddr_test_l;
	    byte_enable_ddr_test_r;
            retransmit_wrp_l; 
            retransmit_wrp_r;
            counter_load_readback_sdr_test_l;
            counter_load_readback_sdr_test_r;
	    counter_load_readback_flow_through_test_l;
	    counter_load_readback_flow_through_test_r;
	    counter_load_readback_ddr_test_l;
	    counter_load_readback_ddr_test_r;
	    counter_hold_test_l;
            counter_hold_test_r;
            mask_load_readback_test_l;
            mask_load_readback_test_r;
            counter_busy_readback_test_l;
            counter_busy_readback_test_r;
            mailbox_sdr_test;
            mailbox_ddr_test;
	    mailbox_flow_through_test;
            counter_reset_test_l;
            counter_reset_test_r;
            mask_reset_test_l;
            mask_reset_test_r;
            retransmit_1_test_l;
            retransmit_1_test_r;
            counter_interrupt_sdr_l;
            counter_interrupt_ddr_l;
	    counter_interrupt_flow_through_l;
            counter_interrupt_sdr_r;
            counter_interrupt_ddr_r;
	    counter_interrupt_flow_through_r;
            mask_reg_test_l;
            mask_reg_test_r;
            read_write_sdr2_addr_ce_r;
            read_write_sdr2_addr_ce_l;
            read_write_ddr2_addr_ce_l;
            read_write_ddr2_addr_ce_r;
	    read_write_sdr2_addr_oe_l;
            read_write_sdr2_addr_oe_r; 
            read_write_sync;
	    echo_clock_test_sdr;
            echo_clock_test_ddr;
            arb_test_w_w_violate_tCCS_l;
            arb_test_w_w_violate_tCCS_r;
            arb_test_r_w_violate_tCCS_l;
            arb_test_r_w_violate_tCCS_r;
            arb_test_w_r_violate_tCCS_l;
            arb_test_w_r_violate_tCCS_r;
            arb_test_r_w_no_violation_l;
            arb_test_r_w_no_violation_r;
            arb_test_w_sdr_w_ddr_violate_tCCS_l;
            arb_test_w_ddr_w_ddr_violate_tCCS_l;
            arb_test_w_sdr_w_ddr_violate_tCCS_r;
            arb_test_w_ddr_w_ddr_violate_tCCS_r; 
            arb_test_w_w_violate_tCCS_flow_throgh_l;
            arb_test_long_time_l;
            arb_test_long_time_r;
	    
  end
      `else
	      
          // HERE USER CAN ADD NON REGRESSION TESTCASES
      
	  //freq_out_range_sdr_portstd00;
	  //freq_out_range_sdr_portstd01;
	  //freq_out_range_sdr_portstd10;
	  //freq_out_range_sdr_portstd11;
	  //freq_out_range_ddr_portstd00;
	  //freq_out_range_ddr_portstd01;
	  //freq_out_range_ddr_portstd10;
	  //freq_out_range_ddr_portstd11;
	  //freq_change_after_reset_sdr;
	  //freq_change_after_reset_ddr;
	  //reset_violate_tRS; 
	  //portstd_invalid_after_reset;	    
          //ddron_invalid_after_reset;
          //cqen_invalid_after_reset;
          //ftsel_invalid_after_reset;
	  //cqen_change_after_reset;
	  //ddron_change_after_reset; 
	  //ftsel_change_after_reset;
	  //portstd_change_after_reset;
      
      `endif
      master_reset; 

      if(failed_flag == 1'b1) 
          $display("\nTEST FAILED");
      else
          $display("\nTEST PASSED");

      //# 100;

      //$finish;
      $stop;
  end

  // Left port clock generation for all tests except 
  // arbitration tests
  always 
  begin
      #(ileft_clk_period/2.0);
      ileft_clk_norm      = !ileft_clk_norm;
      if (ileft_ddron == 1'b1) 
	 ileft_clk_norm_n = !ileft_clk_norm;
      else 
	 ileft_clk_norm_n = 1'b0;
  end

  // Right port clock generation for all tests except 
  // arbitration tests
  always 
  begin
      #(iright_clk_period/2.0);
      iright_clk_norm      = !iright_clk_norm;
      if (iright_ddron == 1'b1) 
	 iright_clk_norm_n = !iright_clk_norm;
      else 
	 iright_clk_norm_n = 1'b0;
  end

  // Clock generation for arbitration tests
  always 
  begin
     if(left_clk_first == 1'b1)
     begin
        if(ileft_clk_period/2.0 > arb_delay_left_right)
        begin	      
           #(ileft_clk_period/2.0 - arb_delay_left_right);
           ileft_clk_arb    = !ileft_clk_arb;
           ileft_clk_arb_n  = !ileft_clk_arb;
           #(arb_delay_left_right);
           iright_clk_arb   = ileft_clk_arb;
           iright_clk_arb_n = ileft_clk_arb_n;
        end
        else
        begin
           #(arb_delay_left_right - ileft_clk_period/2.0);
           iright_clk_arb   = !ileft_clk_arb;
           iright_clk_arb_n = !ileft_clk_arb_n;
	   #(ileft_clk_period - arb_delay_left_right);
           ileft_clk_arb    = !ileft_clk_arb;
           ileft_clk_arb_n  = !ileft_clk_arb;
        end	      
     end
     else if(right_clk_first == 1'b1)
     begin
        if(iright_clk_period/2.0 > arb_delay_right_left)
        begin	      
           #(iright_clk_period/2.0 - arb_delay_right_left);
           iright_clk_arb   = !iright_clk_arb;
           iright_clk_arb_n = !iright_clk_arb;
           #(arb_delay_right_left);
           ileft_clk_arb    = iright_clk_arb;
           ileft_clk_arb_n  = iright_clk_arb_n;
        end
        else
        begin
           #(arb_delay_right_left - iright_clk_period/2.0);
           ileft_clk_arb    = !iright_clk_arb;
           ileft_clk_arb_n  = !iright_clk_arb_n;
           #(iright_clk_period - arb_delay_right_left);
           iright_clk_arb   = !iright_clk_arb;
           iright_clk_arb_n = !iright_clk_arb;
        end	      
     end
  end


 endmodule
