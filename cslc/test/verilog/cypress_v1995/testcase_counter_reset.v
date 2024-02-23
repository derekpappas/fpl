
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
// File          : testcase_counter_reset.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases for the burst counter reset operation
// *******************************************************************


 // Testcase for Burst Counter Reset operation 
 // For Left Port  

 task counter_reset_test_l;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
  reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
  reg [`CYP_ADDRWIDTH - 1 : 0] expected_count_value;
  reg [`CYP_ADDRWIDTH - 1 : 0] expected_mirror_reg_value;

  begin
   
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Burst Counter Reset operation     --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
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
    count_load_value = `CYP_ADDRWIDTH'h045; 
    counter_load_l(count_load_value);

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);

    mask_load_value = `CYP_ADDRWIDTH'h0fe;
    mask_load_l(mask_load_value);
    @(posedge ileft_clk);
    #(TP.tHAC_l);
    
    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    counter_increment_l;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tHAC_l);
 
    expected_count_value = count_load_value + (2 * 4);    

    counter_hold_l;
    @(posedge ileft_clk);
    @(posedge ileft_clk);    
    @(posedge ileft_clk);    
    @(posedge ileft_clk);    
    #(TP.tHAC_l);

    counter_reset_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l);

    counter_hold_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l);

    expected_mirror_reg_value = count_load_value & (~mask_load_value);
    expected_count_value = expected_count_value & (~mask_load_value);

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Burst Counter Reset Operation         --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    enable_readback_op_l;
    counter_readback_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l);

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};    
    counter_hold_l;
    @(posedge ileft_clk);
    @(posedge ileft_clk);

    compare_readback_result_l(expected_count_value);
    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    // Load mirror register value to counter
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Mirror Register Reset Operation       --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    #(TP.tHAC_l);
    retransmit_1_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l);

    enable_readback_op_l;
    counter_readback_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l);
    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};
    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);

    compare_readback_result_l(expected_mirror_reg_value);
    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    @(posedge ileft_clk);
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    report_test_result("counter_reset_test_l");
  end
 endtask



 // Testcase for Burst Counter Reset operation
 // For Right Port 

 task counter_reset_test_r;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
  reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
  reg [`CYP_ADDRWIDTH - 1 : 0] expected_count_value;
  reg [`CYP_ADDRWIDTH - 1 : 0] expected_mirror_reg_value;

  begin
   
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Burst Counter Reset operation     --");
    if(nmsg == 1'b1)$display("--                For Right Port                     --");
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
    count_load_value = `CYP_ADDRWIDTH'h045; 
    counter_load_r(count_load_value);

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);

    mask_load_value = `CYP_ADDRWIDTH'h0fe;
    mask_load_r(mask_load_value);
    @(posedge iright_clk);
    #(TP.tHAC_r);
    
    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    counter_increment_r;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(TP.tHAC_r);
 
    expected_count_value = count_load_value + (2 * 4); 

    counter_hold_r;
    @(posedge iright_clk);
    @(posedge iright_clk);    
    @(posedge iright_clk);    
    @(posedge iright_clk);    
    #(TP.tHAC_r);

    counter_reset_r;
    @(posedge iright_clk);
    #(TP.tHAC_r);

    counter_hold_r;
    @(posedge iright_clk);
    #(TP.tHAC_r);

    expected_mirror_reg_value = count_load_value & (~mask_load_value);
    expected_count_value = expected_count_value & (~mask_load_value);

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Burst Counter Reset Operation         --");
    if(nmsg == 1'b1)$display("--                For Right Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    enable_readback_op_r;
    counter_readback_r;
    @(posedge iright_clk);
    #(TP.tHAC_l);

    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};    
    counter_hold_r;
    @(posedge iright_clk);
    @(posedge iright_clk);

    compare_readback_result_r(expected_count_value);
    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    // Load mirror register value to counter
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Mirror Register Reset Operation       --");
    if(nmsg == 1'b1)$display("--                For Right Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    #(TP.tHAC_r);
    retransmit_1_r;
    @(posedge iright_clk);
    #(TP.tHAC_r);

    enable_readback_op_r;
    counter_readback_r;
    @(posedge iright_clk);
    #(TP.tHAC_r);
    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);

    compare_readback_result_r(expected_mirror_reg_value);
    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    @(posedge iright_clk);
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    report_test_result("counter_reset_test_r");
  end
 endtask

