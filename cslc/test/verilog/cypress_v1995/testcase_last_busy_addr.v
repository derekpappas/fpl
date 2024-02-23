
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
// File          : testcase_last_busy_addr.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// This testcases tests the busy address readback operation
// *******************************************************************


 // Testcase for last busy address readback 
 // Readback operation For Left Port 

 task counter_busy_readback_test_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l,byte_r;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for last busy address readback       --");
    if(nmsg == 1'b1)$display("--             Readback operation                    --");
    if(nmsg == 1'b1)$display("--               For Left Port                       --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    
    randomdata_72bit(rand_temp_data);
    count_load_value = rand_temp_data[`CYP_ADDRWIDTH-1:0];

    @(posedge ileft_clk);
    #(TP.tHAC_l);

    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_l;
    busy_address_readback_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l);

    counter_hold_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    count_load_value=`CYP_DATAWIDTH'b0; 
    compare_readback_result_l(count_load_value);

    @(posedge ileft_clk);
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    report_test_result("counter_busy_readback_test_l");
  end
 endtask


 // Testcase for last busy address  and 
 // Readback operation For Right Port 

 task counter_busy_readback_test_r;

  reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for last busy address  and           --");
    if(nmsg == 1'b1)$display("--            Readback operation                     --");
    if(nmsg == 1'b1)$display("--              For Right Port                       --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);

    randomdata_72bit(rand_temp_data);
    count_load_value = rand_temp_data[`CYP_ADDRWIDTH-1:0];

    @(posedge iright_clk);
    #(TP.tHAC_r);

    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};

    enable_readback_op_r;
    busy_address_readback_r;
    @(posedge iright_clk);
    #(TP.tHAC_r);
    counter_hold_r;

    @(posedge iright_clk);
    @(posedge iright_clk);
    count_load_value=`CYP_DATAWIDTH'b0; 
    compare_readback_result_r(count_load_value);

    @(posedge iright_clk);
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    report_test_result("counter_busy_readback_test_r");
  end
 endtask







