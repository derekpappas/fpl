
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
// File          : testcase_mask_invalid_load.v 
// Author        : 
// Author's Email: 
// Date          : 02 JUL 2004
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for testing the invalid mask load condition
// *******************************************************************


 // Testcase for Illegal mask register load
 // For Left Port 

 task mask_load_invalid_test_l;

  reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;

  begin

    $display("-------------------------------------------------------");
    $display("--     Testcase for Illegal mask register load       --");
    $display("--                For Left Port                      --");
    $display("-------------------------------------------------------");

    configure_device_sdr2;
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    $display("\n Load non contineous 1's ");
    mask_load_value =18'b000101010101010100;
    mask_load_l(mask_load_value);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    master_reset;
    $display("\n load mask register with more than 3 contiguous regions");
    mask_load_value =18'b000111110000000000;
    mask_load_l(mask_load_value);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
     
    

    @(posedge ileft_clk);
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
  end
 endtask


 // Testcase for Illegal Mask Register Load and 
 // For Right Port 

 task mask_load_invalid_test_r;

  reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;

  begin

    $display("-------------------------------------------------------");
    $display("--     Testcase for Illegal Mask Register Load and   --");
    $display("--                For Right Port                     --");
    $display("-------------------------------------------------------");

    configure_device_sdr2;
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);

    $display("\n Load non contineous 1's ");
    mask_load_value = `CYP_ADDRWIDTH'haaa;
    mask_load_r(mask_load_value);

    master_reset;
    $display("\n load mask register with more than 3 contiguous regions");
    mask_load_value =18'b000111110000000000;
    mask_load_r(mask_load_value);
    @(posedge iright_clk);
    master_reset;
    @(posedge iright_clk);
    @(posedge iright_clk);
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
  end
 endtask

