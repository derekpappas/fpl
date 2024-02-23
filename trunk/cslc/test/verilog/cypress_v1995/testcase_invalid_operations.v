
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
// File          : testcase_invalid_operations.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases for testing invalid model operations
// *******************************************************************

  // Testcase for testing invalid values in PORTSTD
  // pin after master reset operation
  // This testcase is not self testing. Model will
  // display the error message Unknown value in
  // PORTSTD pin. Model operation not predictable'

  task portstd_invalid_after_reset;

   begin

    if(nmsg == 1'b1)$display("----------------------------------------------------");
    if(nmsg == 1'b1)$display("-- Testcase for testing invalid values in PORTSTD --");
    if(nmsg == 1'b1)$display("--        pin after master reset operation        --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will  --");
    if(nmsg == 1'b1)$display("--  display the error message Unknown value in   --");
    if(nmsg == 1'b1)$display("-- PORTSTD pin. Model operation not predictable'  --");
    if(nmsg == 1'b1)$display("----------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    ileft_portstd     = 2'bXX;
    iright_portstd    = 2'bZZ;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #200;
   end
  endtask


  // Testcase for testing invalid values in DDRON
  // pin after master reset operation
  // This testcase is not self testing. Model will
  // display the error message Unknown value in
  // DDRON pin. Model operation not predictable'

  task ddron_invalid_after_reset;

   begin

    if(nmsg == 1'b1)$display("----------------------------------------------------");
    if(nmsg == 1'b1)$display("-- Testcase for testing invalid values in DDRON   --");
    if(nmsg == 1'b1)$display("--        pin after master reset operation        --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will  --");
    if(nmsg == 1'b1)$display("--  display the error message Unknown value in   --");
    if(nmsg == 1'b1)$display("--  DDRON pin. Model operation not predictable'   --");
    if(nmsg == 1'b1)$display("----------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    ileft_ddron   = 1'bX;
    iright_ddron  = 1'bZ;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #200;
   end
  endtask


  // Testcase for testing invalid values in CQEN 
  // pin after master reset operation
  // This testcase is not self testing. Model will
  // display the error message Unknown value in
  // CQEN pin. Model operation not predictable'

  task cqen_invalid_after_reset;

   begin

    if(nmsg == 1'b1)$display("----------------------------------------------------");
    if(nmsg == 1'b1)$display("--  Testcase for testing invalid values in CQEN   --");
    if(nmsg == 1'b1)$display("--        pin after master reset operation        --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will  --");
    if(nmsg == 1'b1)$display("--  display the error message Unknown value in   --");
    if(nmsg == 1'b1)$display("--  CQEN pin. Model operation not predictable'    --");
    if(nmsg == 1'b1)$display("----------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    ileft_cqen   = 1'bX;
    iright_cqen  = 1'bZ;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #200;
   end
  endtask


  // Testcase for testing invalid values in FTSEL# 
  // pin after master reset operation
  // This testcase is not self testing. Model will
  // display the error message Unknown value in
  // FTSEL# pin. Model operation not predictable'

  task ftsel_invalid_after_reset;

   begin

    if(nmsg == 1'b1)$display("----------------------------------------------------");
    if(nmsg == 1'b1)$display("-- Testcase for testing invalid values in FTSEL#  --");
    if(nmsg == 1'b1)$display("--        pin after master reset operation        --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will  --");
    if(nmsg == 1'b1)$display("--  display the error message Unknown value in   --");
    if(nmsg == 1'b1)$display("-- FTSEL# pin. Model operation not predictable'   --");
    if(nmsg == 1'b1)$display("----------------------------------------------------");

    configure_device_ddr2;
    counter_hold_l;
    counter_hold_r;
    #0;
    ileft_clk_period  = TP.tCYC_min;
    iright_clk_period = TP.tCYC_min;
    ileft_ftsel       = 1'bX;
    iright_ftsel      = 1'bZ;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #200;
   end
  endtask

  // Testcase for testing change in CQEN pin state during
  // normal operation
  task cqen_change_after_reset;

   begin

    if(nmsg == 1'b1)$display("-----------------------------------------------------------");
    if(nmsg == 1'b1)$display("--  Testcase for testing change in CQEN pin state during --");
    if(nmsg == 1'b1)$display("--                   normal operation                    --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will display --");
    if(nmsg == 1'b1)$display("-- the warning message CQEN input changed after reset   --");
    if(nmsg == 1'b1)$display("--    operation. Reset the model to behave properly'     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #100;
    ileft_cqen   = !(ileft_cqen);
    iright_cqen  = !(iright_cqen);
    #500;
   end
  endtask


  // Testcase for testing change in DDRON pin state during
  // normal operation
  task ddron_change_after_reset;

   begin

    if(nmsg == 1'b1)$display("-----------------------------------------------------------");
    if(nmsg == 1'b1)$display("--  Testcase for testing change in CQEN pin state during --");
    if(nmsg == 1'b1)$display("--                   normal operation                    --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will display --");
    if(nmsg == 1'b1)$display("-- the warning message DDRON input changed after reset   --");
    if(nmsg == 1'b1)$display("--    operation. Reset the model to behave properly'     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #100;
    ileft_ddron   = !(ileft_ddron);
    iright_ddron  = !(iright_ddron);
    #500;
   end
  endtask

  // Testcase for testing change in FTSEL# pin state during
  // normal operation
  task ftsel_change_after_reset;

   begin

    if(nmsg == 1'b1)$display("-----------------------------------------------------------");
    if(nmsg == 1'b1)$display("-- Testcase for testing change in FTSEL# pin state during--");
    if(nmsg == 1'b1)$display("--                   normal operation                    --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will display --");
    if(nmsg == 1'b1)$display("-- the warning message FTSEL# input changed after reset --");
    if(nmsg == 1'b1)$display("--    operation. Reset the model to behave properly'     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #100;
    ileft_ftsel   = !(ileft_ftsel);
    iright_ftsel  = !(iright_ftsel);
    #500;
   end
  endtask

  // Testcase for testing change in PORTSTD pin state during
  // normal operation
  task portstd_change_after_reset;

   begin

    if(nmsg == 1'b1)$display("-----------------------------------------------------------");
    if(nmsg == 1'b1)$display("--Testcase for testing change in PORTSTD pin state during--");
    if(nmsg == 1'b1)$display("--                   normal operation                    --");
    if(nmsg == 1'b1)$display("-- This testcase is not self testing. Model will display --");
    if(nmsg == 1'b1)$display("-- the warning message PORTSTD input changed after reset--");
    if(nmsg == 1'b1)$display("--    operation. Reset the model to behave properly'     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------------");

    configure_device_sdr2;
    counter_hold_l;
    counter_hold_r;
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge ileft_clk);
    @(posedge iright_clk);
    #100;
    ileft_portstd[0]   = !(ileft_portstd[0]);
    iright_portstd[0]  = !(iright_portstd[0]);
    #500;
   end
  endtask

