
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
// File          : testcase_counter_load_readback.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases for testing the burst counter load operation
// and counter readback operation
// *******************************************************************


 // Testcase for Burst Counter Load and 
 // Readback operation For Left Port
 // SDR operation 

 task counter_load_readback_sdr_test_l;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Burst Counter Load and           --");
    if(nmsg == 1'b1)$display("--       Readback operation For Left Port            --");
    if(nmsg == 1'b1)$display("--                SDR operation                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_sdr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);

    count_load_value = `CYP_ADDRWIDTH'h07C;
    counter_load_l(count_load_value);

    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_l;
    counter_readback_l;

    @(posedge ileft_clk);
    #(TP.tHAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    compare_readback_result_l(count_load_value);

    @(posedge ileft_clk);
    #(TP.tHAC_l);
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    report_test_result("counter_load_readback_sdr_test_l");
  end
 endtask


 // Testcase for Burst Counter Load and 
 // Readback operation For Left Port
 // Flow through operation 

 task counter_load_readback_flow_through_test_l;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Burst Counter Load and           --");
    if(nmsg == 1'b1)$display("--       Readback operation For Left Port            --");
    if(nmsg == 1'b1)$display("--            Flow through operation                 --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_flow_through;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);

    count_load_value = `CYP_ADDRWIDTH'h07C;
    counter_load_l(count_load_value);

    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_l;
    counter_readback_l;

    @(posedge ileft_clk);
    #(TP.tHAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    compare_readback_result_l(count_load_value);

    @(posedge ileft_clk);
    #(TP.tHAC_l);
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    report_test_result("counter_load_readback_flow_through_test_l");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask

 // Testcase for Burst Counter Load and 
 // Readback operation For Left Port
 // DDR operation 

 task counter_load_readback_ddr_test_l;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Burst Counter Load and           --");
    if(nmsg == 1'b1)$display("--       Readback operation For Left Port            --");
    if(nmsg == 1'b1)$display("--                DDR operation                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_ddr2;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);

    count_load_value = `CYP_ADDRWIDTH'h07C;
    counter_load_l(count_load_value);

    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_l;
    counter_readback_l;

    @(posedge ileft_clk);
    #(TP.tHAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    //@(posedge ileft_clk_n);
    compare_readback_result_l(count_load_value);

    @(posedge ileft_clk);
    #(TP.tHAC_l);
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    report_test_result("counter_load_readback_ddr_test_l");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask


 // Testcase for Burst Counter Load and 
 // Readback operation For Right Port  
 // SDR operation 

 task counter_load_readback_sdr_test_r;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Burst Counter Load and           --");
    if(nmsg == 1'b1)$display("--     Readback operation  For Right Port            --");
    if(nmsg == 1'b1)$display("--               For SDR operation                   --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    configure_device_sdr2;
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    count_load_value = `CYP_ADDRWIDTH'h07C;     
    counter_load_r(count_load_value);

    @(posedge iright_clk);
    #(TP.tHAC_r); 

    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_r;
    counter_readback_r;

    @(posedge iright_clk);
    #(TP.tHAC_r);
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);
    compare_readback_result_r(count_load_value);

    @(posedge iright_clk);
    #(TP.tHAC_r);
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    report_test_result("counter_load_readback_sdr_test_r");
  end
 endtask


 // Testcase for Burst Counter Load and 
 // Readback operation For Right Port  
 // Flow through operation 

 task counter_load_readback_flow_through_test_r;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Burst Counter Load and           --");
    if(nmsg == 1'b1)$display("--     Readback operation  For Right Port            --");
    if(nmsg == 1'b1)$display("--         For Flow through operation                --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    configure_device_flow_through;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    count_load_value = `CYP_ADDRWIDTH'h07C;     
    counter_load_r(count_load_value);

    @(posedge iright_clk);
    #(TP.tHAC_r); 

    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_r;
    counter_readback_r;

    @(posedge iright_clk);
    #(TP.tHAC_r);
    counter_hold_r;

    @(posedge iright_clk);
    compare_readback_result_r(count_load_value);

    @(posedge iright_clk);
    #(TP.tHAC_r);
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    report_test_result("counter_load_readback_flow_through_test_r");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask


 // Testcase for Burst Counter Load and 
 // Readback operation For Right Port  
 // DDR operation 

 task counter_load_readback_ddr_test_r;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Burst Counter Load and           --");
    if(nmsg == 1'b1)$display("--     Readback operation  For Right Port            --");
    if(nmsg == 1'b1)$display("--              For DDR operation                    --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    configure_device_ddr2;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 

    count_load_value = `CYP_ADDRWIDTH'h07C;     
    counter_load_r(count_load_value);

    @(posedge iright_clk);
    #(TP.tHAC_r); 

    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_r;
    counter_readback_r;

    @(posedge iright_clk);
    #(TP.tHAC_r);
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);
    //@(posedge iright_clk_n);
    compare_readback_result_r(count_load_value);

    @(posedge iright_clk);
    #(TP.tHAC_r);
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    report_test_result("counter_load_readback_ddr_test_r");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask


