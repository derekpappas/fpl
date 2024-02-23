
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
// File          : testcase_freq_range.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for testing out of range input clock frequency
// *******************************************************************

  // Testcase for Out of Range Frequency test
  // Both ports in SDR mode
  // PORTSDT = 2'b00 

  task freq_out_range_sdr_portstd00;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in SDR mode. PORTSTD set to 2'b00.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b00;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b00;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask


  // Testcase for Out of Range Frequency test
  // Both ports in SDR mode
  // PORTSDT = 2'b01 
  task freq_out_range_sdr_portstd01;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in SDR mode. PORTSTD set to 2'b01.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b01;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b01;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask

  
  // Testcase for Out of Range Frequency test
  // Both ports in SDR mode
  // PORTSDT = 2'b10 
  task freq_out_range_sdr_portstd10;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in SDR mode. PORTSTD set to 2'b10.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b10;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b10;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask

  
  // Testcase for Out of Range Frequency test
  // Both ports in SDR mode
  // PORTSDT = 2'b11 
  task freq_out_range_sdr_portstd11;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in SDR mode. PORTSTD set to 2'b11.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b11;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b11;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask

  // Testcase for Out of Range Frequency test
  // Both ports in DDR mode
  // PORTSDT = 2'b00 
  task freq_out_range_ddr_portstd00;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in DDR mode. PORTSTD set to 2'b00.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_ddr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b00;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b00;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask


  // Testcase for Out of Range Frequency test
  // Both ports in DDR mode
  // PORTSDT = 2'b01 
  task freq_out_range_ddr_portstd01;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in DDR mode. PORTSTD set to 2'b01.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_ddr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b01;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b01;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask


  // Testcase for Out of Range Frequency test
  // Both ports in DDR mode
  // PORTSDT = 2'b10 
  task freq_out_range_ddr_portstd10;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in DDR mode. PORTSTD set to 2'b10.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_ddr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b10;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b10;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask


  // Testcase for Out of Range Frequency test
  // Both ports in DDR mode
  // PORTSDT = 2'b11 
  task freq_out_range_ddr_portstd11;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--   Testcase for Out of Range Frequency Operation   --");
    if(nmsg == 1'b1)$display("--   Both ports in DDR mode. PORTSTD set to 2'b11.   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the error message Left and Right clock --");
    if(nmsg == 1'b1)$display("--             frequencies are out of range'         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period  = 2;
    iright_clk_period = 2; 
    configure_device_ddr2;
    counter_hold_l;
    counter_hold_r;
    inleft_ce0        = 1'b1;
    ileft_ce1         = 1'b0;
    ileft_portstd     = 2'b11;
    inright_ce0       = 1'b1;
    iright_ce1        = 1'b0;
    iright_portstd    = 2'b11;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #(TP.tDC_l);
    #200;
    inleft_ce0  = 1'b1;  
    inright_ce0 = 1'b1;
   end
  endtask


  // Testcase for variation of input clock frequency
  // after reset operation.
  // Both ports in SDR mode
  task freq_change_after_reset_sdr;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--  Testcase for variation of input clock frequency  --");
    if(nmsg == 1'b1)$display("--   after reset operation. Both ports in SDR mode   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the warning message clock frequency    --");
    if(nmsg == 1'b1)$display("--           changed after reset operation'          --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
    a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
    configure_device_sdr2;
    #1;
    ileft_clk_period  = TP.tCYC_min;
    iright_clk_period = TP.tCYC_min; 
    counter_hold_l;
    counter_hold_r;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #200;

    ileft_clk_period  = TP.tCYC_min+1;
    iright_clk_period = TP.tCYC_min+1;
    #200;

   end
  endtask


  // Testcase for variation of input clock frequency
  // after reset operation.
  // Both ports in DDR mode
  task freq_change_after_reset_ddr;

   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--  Testcase for variation of input clock frequency  --");
    if(nmsg == 1'b1)$display("--   after reset operation. Both ports in DDR mode   --");
    if(nmsg == 1'b1)$display("--   This testcase is not self testing. Model will   --");
    if(nmsg == 1'b1)$display("--   display the warning message clock frequency    --");
    if(nmsg == 1'b1)$display("--           changed after reset operation'          --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
    a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
    configure_device_ddr2;
    #1;
    ileft_clk_period  = TP.tCYC_min;
    iright_clk_period = TP.tCYC_min; 
    counter_hold_l;
    counter_hold_r;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #200;

    ileft_clk_period  = TP.tCYC_min+1;
    iright_clk_period = TP.tCYC_min+1;
    #200;

   end
  endtask

