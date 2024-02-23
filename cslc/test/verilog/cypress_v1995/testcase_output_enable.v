
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
// File          : testcase_output_enable.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases for testing the output enable operation of the model 
// *******************************************************************

  // This task will compare the expected output result and
  // actual output result to produce a PASS or FAIL report
  // for the left port

  task sdr_compare_result_oe_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   input [`CYP_BYTEWIDTH - 1: 0] byte_enable_l;
   reg [`CYP_DATAWIDTH - 1: 0] expected_result_l;
   reg [`CYP_DATAWIDTH - 1: 0] actual_result_l;
   begin
    expected_result_l   = 72'bZ;
    actual_result_l = ioleft_dq;
    if(actual_result_l === expected_result_l) begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED:For memory location %h:",$realtime,address_l);
     if(nmsg == 1'b1)$display("                     Ouput Data      = %h ",actual_result_l);
     if(nmsg == 1'b1)$display("                     Expected Result = %h ",expected_result_l);
    end else begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED:For memory location %h:",$realtime,address_l);
     if(nmsg == 1'b1)$display("                     Ouput Data      = %h ",actual_result_l);
     if(nmsg == 1'b1)$display("                     Expected Result = %h ",expected_result_l);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
    end
   end
  endtask

  // Testcase for SDR pipeline mode stage, Output Enable
  // Read and Write operation  Using Address Bus 
  // For Left Port

  task read_write_sdr2_addr_oe_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop;
   begin

    if(nmsg == 1'b1)$display("--------------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for SDR pipeline mode stage, Output Enable  --");
    if(nmsg == 1'b1)$display("--          Read and Write operation               	  --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                           --");
    if(nmsg == 1'b1)$display("--                For Left Port                             --");
    if(nmsg == 1'b1)$display("--------------------------------------------------------------");
    configure_device_sdr2;
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    sdr_write_addr_l(0,data_l,byte_l);

    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l);
      sdr_write_addr_l(count_loop,data_l,byte_l);
    end
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tDC_l);
    enable_read_op_l;
    //if(nmsg == 1'b1)$display( " \n OE for left port is asserted at time=",$realtime);
    inleft_ce0    = 1'b0;
    @(posedge ileft_clk);
    #(TP.tDC_l);
    sdr_read_addr_l(0,byte_l);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tDC_l);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_loop,byte_l);
       if(count_loop >= 3) sdr_compare_result_l((count_loop - 3),byte_l);
    end
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tDC_l);
    enable_read_op_l;
    //if(nmsg == 1'b1)$display("\n OE# left for port is de-asserted at time=",$realtime);
    inleft_oe=1'b1;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
       #(TP.tDC_l);
    inleft_ce0    = 1'b0;
    sdr_read_addr_l(0,byte_l);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tDC_l);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_loop,byte_l);
       if(count_loop >= 3) sdr_compare_result_oe_l((count_loop - 3),byte_l);
    end 

    // write operation 
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    enable_write_op_l;
    inleft_oe=1'b1;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    sdr_write_addr_l(0,data_l,byte_l);

    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l);
      sdr_write_addr_l(count_loop,data_l,byte_l);
    end
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tDC_l);
    enable_read_op_l;
    inleft_oe=1'b1;
    inleft_ce0    = 1'b0;
    @(posedge ileft_clk);
    #(TP.tDC_l);
    sdr_read_addr_l(0,byte_l);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tDC_l);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_loop,byte_l);
       if(count_loop >= 3) sdr_compare_result_oe_l((count_loop - 3),byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tDC_l);
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    report_test_result("read_write_sdr2_addr_oe_l");
   end
  endtask


  // This task will compare the expected output result and
  // actual output result to produce a PASS or FAIL report
  // for the right port

  task sdr_compare_result_oe_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   input [`CYP_BYTEWIDTH - 1: 0] byte_enable_r;
   reg [`CYP_DATAWIDTH - 1: 0] expected_result_r;
   reg [`CYP_DATAWIDTH - 1: 0] actual_result_r;
   begin
     expected_result_r   = 72'bZ;
    actual_result_r = ioright_dq;
    if(actual_result_r === expected_result_r) begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED:For memory location %h:",$realtime,address_r);
     if(nmsg == 1'b1)$display("                     Ouput Data      = %h ",actual_result_r);
     if(nmsg == 1'b1)$display("                     Expected Result = %h ",expected_result_r);
    end else begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED:For memory location %h:",$realtime,address_r);
     if(nmsg == 1'b1)$display("                     Ouput Data      = %h ",actual_result_r);
     if(nmsg == 1'b1)$display("                     Expected Result = %h ",expected_result_r);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
    end
   end
  endtask


  // Testcase for SDR pipeline mode, Output Enable 
  // Read and Write operation Using Address Bus 
  // For Right Port
    
  task read_write_sdr2_addr_oe_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_r;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count_loop;
   begin

    if(nmsg == 1'b1)$display("--------------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for SDR pipeline mode, Output Enable        --");
    if(nmsg == 1'b1)$display("--          Read and Write operation               	  --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                           --");
    if(nmsg == 1'b1)$display("--                For Right Port                            --");
    if(nmsg == 1'b1)$display("--------------------------------------------------------------");
    configure_device_sdr2;
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    counter_load_mode_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    sdr_write_addr_r(0,data_r,byte_r);

    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r);
      sdr_write_addr_r(count_loop,data_r,byte_r);
    end
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(TP.tDC_r);
    enable_read_op_r;
    //if(nmsg == 1'b1)$display( " \n OE for right port is asserted at time=",$realtime);
    inright_ce0    = 1'b0;
    @(posedge iright_clk);
    #(TP.tDC_r);
    sdr_read_addr_r(0,byte_r);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tDC_r);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_r(count_loop,byte_r);
       if(count_loop >= 3) sdr_compare_result_r((count_loop - 3),byte_r);
    end
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(TP.tDC_r);
    enable_read_op_r;
    //if(nmsg == 1'b1)$display("\n OE# right for port is de-asserted at time=",$realtime);
    inright_oe=1'b1;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    #(TP.tDC_r);
    inright_ce0    = 1'b0;
    sdr_read_addr_r(0,byte_r);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tDC_r);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_r(count_loop,byte_r);
       if(count_loop >= 3) sdr_compare_result_oe_r((count_loop - 3),byte_r);
    end 

    // write operation 
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    enable_write_op_r;
    inright_oe=1'b1;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    sdr_write_addr_r(0,data_r,byte_r);

    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r);
      sdr_write_addr_r(count_loop,data_r,byte_r);
    end
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(TP.tDC_r);
    enable_read_op_r;
    inright_oe=1'b1;
    inright_ce0    = 1'b0;
    @(posedge iright_clk);
    #(TP.tDC_r);
    sdr_read_addr_r(0,byte_r);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tDC_r);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_r(count_loop,byte_r);
       if(count_loop >= 3) sdr_compare_result_oe_r((count_loop - 3),byte_r);
    end
    @(posedge iright_clk);
    #(TP.tDC_r);
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    report_test_result("read_write_sdr2_addr_oe_r");
   end
  endtask


