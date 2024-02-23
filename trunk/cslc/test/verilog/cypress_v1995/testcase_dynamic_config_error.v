
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
// File          : testcase_dynamic_config_error.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for tesing the dynamic reconfiguration error condition
// *******************************************************************


  // Testcase for SDR mode 2 pipeline stage  
  // Dynamic Model Configuration Error checking
  // For Left Port    

  task config_error_test_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop;
   begin

    $display("-------------------------------------------------------");
    $display("--     Testcase for SDR mode 2 pipeline stage        --");
    $display("--     Dynamic Model Configuration Error checking    --");
    $display("--                For Left Port                      --");
    $display("-------------------------------------------------------");
    configure_device_sdr2;
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    counter_hold_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    ileft_portstd=~ileft_portstd;
    ileft_ddron =~ileft_ddron;
    ileft_cqen=~ileft_cqen;
    ileft_ftsel=~ileft_ftsel;
    ileft_sc=~ileft_sc;  
      
    @(posedge ileft_clk);
    #(TP.tDC_l);
    inleft_ce0     = 1'b1;    
    ileft_ce1     = 1'b0;    
   end
  endtask




