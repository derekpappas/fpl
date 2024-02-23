
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
// File          : testcase_echo_clock.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases for the Echo clock generation operation verifications
// in different configurations of the model
// *******************************************************************


 // Testcase for Echo Clocking 
 // For SDR mode operation  

 task echo_clock_test_sdr;

   real iclk_pos_event_time;
   real oclk_pos_event_time;
   real clock_event_time_diff;
   real dq_event_time;
   real dq_event_time_diff;
   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--         Testcase for Echo Clocking                --");
    if(nmsg == 1'b1)$display("--           For SDR mode operation                  --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
  
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min; 
    configure_device_sdr2;
    counter_hold_l;
    ileft_cqen  = 1'b1;
    iright_cqen = 1'b1;
    master_reset;

    // Testing the echo clock generation for the Left port
    wait (onleft_ready == 1'b0);
    #100;
    // // Testing CQU output clock for left port
    @(posedge ileft_clk);
    iclk_pos_event_time = $realtime;
    @(posedge oleft_cq0);
    oclk_pos_event_time = $realtime;
    
    clock_event_time_diff = oclk_pos_event_time - iclk_pos_event_time;

    // Testing tCCQ for Left Port
    if ((clock_event_time_diff <= TP.tCCQ_max_l) && 
        (clock_event_time_diff >= TP.tCCQ_min_l))
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCCQ timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCCQ timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCCQ = %10.2f,  Minimum tCCQ = %10.2f", TP.tCCQ_max_l, TP.tCCQ_min_l);
       if(nmsg == 1'b1)$display("Actual tCCQ = %10.2f", clock_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end

    // Testing tCCQ for Right Port
    @(posedge iright_clk);
    iclk_pos_event_time = $realtime;
    @(posedge oright_cq0);
    oclk_pos_event_time = $realtime;
    
    clock_event_time_diff = oclk_pos_event_time - iclk_pos_event_time;

    if ((clock_event_time_diff <= TP.tCCQ_max_r) && 
        (clock_event_time_diff >= TP.tCCQ_min_r))
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCCQ timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCCQ timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCCQ = %10.2f,  Minimum tCCQ = %10.2f", TP.tCCQ_max_r, TP.tCCQ_min_r);
       if(nmsg == 1'b1)$display("Actual tCCQ = %10.2f", clock_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
    
    // Memory write and read
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    counter_load_mode_l;
    enable_write_op_l;
    byte_l = 8'b00000000;
    data_l = {`CYP_DATAWIDTH{1'b1}};
    sdr_write_addr_l(0,data_l,byte_l);
    @(posedge ileft_clk);
    #(TP.tHD_l);
    dq_write_l = {`CYP_DATAWIDTH{1'bZ}};
    enable_read_op_l;
    sdr_read_addr_l(0,byte_l);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge oleft_cq0);
    oclk_pos_event_time = $realtime;
    @(posedge ioleft_dq[0]);
    dq_event_time = $realtime;
    dq_event_time_diff = dq_event_time - oclk_pos_event_time;

    // Testing tCQHQV for Left Port
    if (dq_event_time_diff <= TP.tCQHQV_l)  
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCQHQV timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_l,dq_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
    @(posedge ileft_clk);
    #(TP.tHD_l);
    inleft_ce0    = 1'b1;
   
    // Read operation right port
    @(posedge iright_clk);
    #(TP.tHD_r);
    counter_load_mode_r;
    enable_read_op_r;
    sdr_read_addr_r(0,byte_r);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge oright_cq0);
    oclk_pos_event_time = $realtime;
    @(posedge ioright_dq[0]);
    dq_event_time = $realtime;
    dq_event_time_diff = dq_event_time - oclk_pos_event_time;

    // Testing tCQHQV for Right Port
    if (dq_event_time_diff <= TP.tCQHQV_r)
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCQHQV timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_r,dq_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
    @(posedge iright_clk);
    #(TP.tHD_r);
    inright_ce0    = 1'b1;
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
    report_test_result("echo_clock_test_sdr");
  end
endtask



 // Testcase for Echo Clocking 
 // For Flow-through mode operation  

 task echo_clock_test_flow_through;

   real iclk_pos_event_time;
   real oclk_pos_event_time;
   real clock_event_time_diff;
   real dq_event_time;
   real dq_event_time_diff;
   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--         Testcase for Echo Clocking                --");
    if(nmsg == 1'b1)$display("--       For Flow-through mode operation             --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
  
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    configure_device_flow_through;
    counter_hold_l;
    ileft_cqen  = 1'b1;
    iright_cqen = 1'b1;
    master_reset;

    // Testing the echo clock generation for the Left port
    wait (onleft_ready == 1'b0);
    #100;
    // // Testing CQU output clock for left port
    @(posedge ileft_clk);
    iclk_pos_event_time = $realtime;
    @(posedge oleft_cq0);
    oclk_pos_event_time = $realtime;
    
    clock_event_time_diff = oclk_pos_event_time - iclk_pos_event_time;

    // Testing tCCQ for Left Port
    // This test is commented as the EROS need to be
    // modified for Flow-through echo clock generation

    //if ((clock_event_time_diff <= TP.tCCQ_max_l) && 
    //    (clock_event_time_diff >= TP.tCCQ_min_l))
    //begin
    //   if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCCQ timing TEST PASSED",$realtime);
    //end
    //else
    //begin
    //   if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCCQ timing TEST FAILED",$realtime);
    //   if(nmsg == 1'b1)$display("Expected Max tCCQ = %10.2f,  Minimum tCCQ = %10.2f", TP.tCCQ_max_l, TP.tCCQ_min_l);
    //   if(nmsg == 1'b1)$display("Actual tCCQ = %10.2f", clock_event_time_diff);
    //   failed_flag       = 1'b1;
    //   failed_flag_local = 1'b1;
    //end

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    counter_load_mode_l;
    enable_write_op_l;
    byte_l = 8'b00000000;
    data_l = {`CYP_DATAWIDTH{1'b1}};
    sdr_write_addr_l(0,data_l,byte_l);
    @(posedge ileft_clk);
    #(TP.tHD_l);
    dq_write_l = {`CYP_DATAWIDTH{1'bZ}};
    enable_read_op_l;
    sdr_read_addr_l(0,byte_l);
    @(posedge ileft_clk);
    @(posedge oleft_cq0);
    oclk_pos_event_time = $realtime;
    @(posedge ioleft_dq[0]);
    dq_event_time = $realtime;
    dq_event_time_diff = dq_event_time - oclk_pos_event_time;

    // Testing tCQHQV for Left Port
    if (dq_event_time_diff <= TP.tCQHQV_l)  
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCQHQV timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_l,dq_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
    @(posedge ileft_clk);
    #(TP.tHD_l);
    inleft_ce0    = 1'b1;
   

    // Read operation right port
    @(posedge iright_clk);
    #(TP.tHD_r);
    counter_load_mode_r;
    enable_read_op_r;
    sdr_read_addr_r(0,byte_r);
    @(posedge iright_clk);
    @(posedge oright_cq0);
    oclk_pos_event_time = $realtime;
    @(posedge ioright_dq[0]);
    dq_event_time = $realtime;
    dq_event_time_diff = dq_event_time - oclk_pos_event_time;

    // Testing tCQHQV for Right Port
    if (dq_event_time_diff <= TP.tCQHQV_r)
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCQHQV timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_r,dq_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
    @(posedge iright_clk);
    #(TP.tHD_r);
    inright_ce0    = 1'b1;
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
    report_test_result("echo_clock_test_flow_through"); 
  end
endtask



 // Testcase for Echo Clocking 
 // For SDR mode operation  

 task echo_clock_test_ddr;

   real iclk_pos_event_time;
   real oclk_pos_event_time;
   real clock_event_time_diff;
   real dq_event_time;
   real dq_event_time_diff;
   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--         Testcase for Echo Clocking                --");
    if(nmsg == 1'b1)$display("--           For DDR mode operation                  --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
  
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    configure_device_ddr2;
    counter_hold_l;
    ileft_cqen  = 1'b1;
    iright_cqen = 1'b1;
    master_reset;

    // Testing the echo clock generation for the Left port
    wait (onleft_ready == 1'b0);
    #100;
    // // Testing CQU output clock for left port
    @(posedge ileft_clk);
    iclk_pos_event_time = $realtime;
    @(posedge oleft_cq0);
    oclk_pos_event_time = $realtime;
    
    clock_event_time_diff = oclk_pos_event_time - iclk_pos_event_time;

    // Testing tCCQ for Left Port
    // Note: tCCQ_min value is negative
    if ((clock_event_time_diff <= TP.tCCQ_max_l) || 
        (clock_event_time_diff >= (ileft_clk_period - TP.tCCQ_min_l)))
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCCQ timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCCQ timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCCQ = %10.2f,  Minimum tCCQ = %10.2f", TP.tCCQ_max_l, TP.tCCQ_min_l);
       if(nmsg == 1'b1)$display("Actual tCCQ = %10.2f", clock_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end

    // Testing CQU output clock for right port
    @(posedge iright_clk);
    iclk_pos_event_time = $realtime;
    @(posedge oright_cq0);
    oclk_pos_event_time = $realtime;
    
    clock_event_time_diff = oclk_pos_event_time - iclk_pos_event_time;
    
    // Testing tCCQ for Right Port
    // Note: tCCQ_min value is negative
    if ((clock_event_time_diff <= TP.tCCQ_max_r) || 
        (clock_event_time_diff >= (iright_clk_period - TP.tCCQ_min_r)))
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCCQ timing TEST PASSED",$realtime);
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCCQ timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCCQ = %10.2f,  Minimum tCCQ = - %10.2f", TP.tCCQ_max_r, TP.tCCQ_min_r);
       if(nmsg == 1'b1)$display("Actual tCCQ = %10.2f", clock_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
   
    // Write operation 
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    enable_write_op_l;
    byte_l = 8'b00000000;
    data_l = {`CYP_DATAWIDTH{1'b1}};
    ddr_write_addr_l(0,data_l[`CYP_DATAWIDTH/2 -1 : 0],byte_l);
    @(posedge ileft_clk);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    ddr_write_addr_l(0,data_l[`CYP_DATAWIDTH/2 -1 : 0],byte_l);
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);

    // Read operation
    enable_read_op_l;
    ddr_read_addr_l(0);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk_n);
    @(posedge oleft_cq0_n);
    oclk_pos_event_time = $realtime;
    @(posedge ioleft_dq[0]);
    dq_event_time = $realtime;
    dq_event_time_diff = dq_event_time - oclk_pos_event_time;

    // Testing tCQHQV for Left Port
    if (dq_event_time_diff <= TP.tCQHQV_l)  
    begin
              
       @(posedge oleft_cq0);
       oclk_pos_event_time = $realtime;
       @(posedge ioleft_dq[0]);
       dq_event_time = $realtime;
       dq_event_time_diff = dq_event_time - oclk_pos_event_time;
    
       if (dq_event_time_diff <= TP.tCQHQV_l)  
       begin
          if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCQHQV timing TEST PASSED",$realtime);
       end
       else
       begin
          if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
          if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_l,dq_event_time_diff);
          failed_flag       = 1'b1;
	  failed_flag_local = 1'b1;
       end
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Left Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_l,dq_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
    @(posedge ileft_clk);
    #(TP.tHD_l);
    inleft_ce0    = 1'b1;


    // Testing tCQHQV for Right Port
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);

    // Read operation
    enable_read_op_r;
    counter_load_mode_r;
    ddr_read_addr_r(0);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk_n);
    @(posedge oright_cq0_n);
    oclk_pos_event_time = $realtime;
    @(posedge ioright_dq[0]);
    dq_event_time = $realtime;
    dq_event_time_diff = dq_event_time - oclk_pos_event_time;

    // Testing tCQHQV for Right Port
    if (dq_event_time_diff <= TP.tCQHQV_r)  
    begin
              
       @(posedge oright_cq0);
       oclk_pos_event_time = $realtime;
       @(posedge ioright_dq[0]);
       dq_event_time = $realtime;
       dq_event_time_diff = dq_event_time - oclk_pos_event_time;
    
       if (dq_event_time_diff <= TP.tCQHQV_r)  
       begin
          if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCQHQV timing TEST PASSED",$realtime);
       end
       else
       begin
          if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
          if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_r,dq_event_time_diff);
          failed_flag       = 1'b1;
	  failed_flag_local = 1'b1;
       end
    end
    else
    begin
       if(nmsg == 1'b1)$display("%10.2f Right Port Echo Clock tCQHQV timing TEST FAILED",$realtime);
       if(nmsg == 1'b1)$display("Expected Max tCQHQV = %10.2f,  Actual tCQHQV = %10.2f", TP.tCQHQV_r,dq_event_time_diff);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
    end
    @(posedge iright_clk);
    #(TP.tHD_r);
    inright_ce0    = 1'b1;
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
    report_test_result("echo_clock_test_ddr"); 
  end
endtask
