
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
// File          : testcase_chip_enable.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase to test the chip enable operation of the model 
// *******************************************************************


  // Testcase for SDR pipeline, chip enable
  // Read and Write operation  For Left Port 

  task read_write_sdr2_addr_ce_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for SDR pipeline, chip enable         --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    configure_device_sdr2;
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    // write operation
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    inleft_ce0     = 1'b0;
    ileft_ce1     = 1'b1;
    inleft_rw     = 1'b0;
    op_read_l     = 1'b0;
    op_write_l    = 1'b1;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;
    byte_l        = 8'b00000000;
    data_l        = {(`CYP_DATAWIDTH-1){1'b0}};
    data_l[0]     = 1'b1;
    sdr_write_addr_l(0,data_l,byte_l);   
 
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_ce0    = 1'b0;
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;

    sdr_read_addr_l(0,byte_l);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    sdr_read_addr_l(0,byte_l);
   if(ioleft_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioleft_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq); 
   end
   else 
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
   // write operation  with chip enable disabled conditions
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_ce0    = 1'b0;
    ileft_ce1     = 1'b0;
    inleft_rw     = 1'b0;
    op_read_l     = 1'b0;
    op_write_l    = 1'b1;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;

    byte_l = 8'b00000000;
    data_l=72'b0;
    sdr_write_addr_l(0,data_l,byte_l);

    // read operation with chip enabled conditions
    @(posedge ileft_clk); 
    #(TP.tDC_l); 
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;
    inleft_ce0    = 1'b0;
    ileft_ce1     = 1'b1; 
    sdr_read_addr_l(0,byte_l);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tDC_l); 
   if(ioleft_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioleft_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq); 
   end
   else 
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
   // 3rd write 
   @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    inleft_rw     = 1'b0;
    op_read_l     = 1'b0;
    op_write_l    = 1'b1;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;

    byte_l        = 8'b00000000;
    data_l[`CYP_DATAWIDTH-1:1] = {(`CYP_DATAWIDTH-1){1'b0}};
    data_l[0]     = 1'b1;
    sdr_write_addr_l(0,data_l,byte_l);
    // read operation with chip enabled conditions
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;
    inleft_ce0    = 1'b0;
    ileft_ce1     = 1'b1;
    sdr_read_addr_l(0,byte_l);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tDC_l); 
   if(ioleft_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioleft_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
  // 4th write
   @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b1;
    inleft_rw     = 1'b0;
    op_read_l     = 1'b0;
    op_write_l    = 1'b1;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;

    byte_l        = 8'b00000000;
    data_l        = {72{1'b0}};
    sdr_write_addr_l(0,data_l,byte_l);
  // read operation with chip enabled conditions
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;
    inleft_ce0    = 1'b0;
    ileft_ce1     = 1'b1;
    sdr_read_addr_l(0,byte_l);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tDC_l); 
   if(ioleft_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioleft_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result =1 actual result=%h ",
     $realtime, ioleft_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
   // read operation with chip enabled conditions
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;
    inleft_ce0    = 1'b0;
    ileft_ce1     = 1'b0;
    sdr_read_addr_l(0,byte_l);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
       #(TP.tDC_l); 
   if(ioleft_dq === {`CYP_DATAWIDTH{1'bz}})
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = z actual result=%h ",
     $realtime, ioleft_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = z actual result=%h ",
     $realtime, ioleft_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
  // read operation with chip enabled conditions
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    sdr_read_addr_l(0,byte_l);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tDC_l); 
   if(ioleft_dq === {`CYP_DATAWIDTH{1'bz}})
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = z actual result=%h ",
     $realtime, ioleft_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = z actual result=%h ",
     $realtime, ioleft_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
   // read operation with chip enabled conditions
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    inleft_oe     = 1'b0;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b1;
    sdr_read_addr_l(0,byte_l);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tDC_l); 
   if(ioleft_dq === {`CYP_DATAWIDTH{1'bz}})
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = z actual result=%h ",
     $realtime, ioleft_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = z actual result=%h ",
     $realtime, ioleft_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_ce0    = 1'b1;    
    ileft_ce1     = 1'b0;    
    report_test_result("read_write_sdr2_addr_ce_l");
   end
  endtask



  // Testcase for SDR pipeline, chip enable
  // Read and Write operation 
  // Using Address Bus For Right Port 

  task read_write_sdr2_addr_ce_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_r;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for SDR pipeline, chip enable         --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Right Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    configure_device_sdr2;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_load_mode_r;
    master_reset;

    wait (onright_ready == 1'b0);
    // write operation
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    inright_ce0   = 1'b0;
    iright_ce1    = 1'b1; 
    inright_rw    = 1'b0;
    op_read_r     = 1'b0;
    op_write_r    = 1'b1;
    op_readback_r = 1'b0;
    inright_oe    = 1'b0;
    byte_r        = {`CYP_BYTEWIDTH{1'b0}};
    data_r[`CYP_DATAWIDTH-1:1] = {(`CYP_DATAWIDTH-1){1'b0}};
    data_r[0]     = 1'b1;
    sdr_write_addr_r(0,data_r,byte_r);   
 
    @(posedge iright_clk);
    #(TP.tHD_r);
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(TP.tHD_r);
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b1;
    inright_rw     = 1'b1;
    op_read_r      = 1'b1;
    op_write_r     = 1'b0;
    op_readback_r  = 1'b0;
    inright_oe     = 1'b0;

    sdr_read_addr_r(0,byte_r);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(TP.tDC_r); 
   if(ioright_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioright_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = h1 actual result=%h ",
     $realtime, ioright_dq); 
   end
   else 
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result =h1 actual result=%h ",
     $realtime, ioright_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end 
   // write operation  with chip enable disabled conditions
    @(posedge iright_clk);
    #(TP.tDC_r); 
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b0;
    inright_rw     = 1'b0;
    op_read_r      = 1'b0;
    op_write_r     = 1'b1;
    op_readback_r  = 1'b0;
    inright_oe     = 1'b0;

    byte_r = {`CYP_BYTEWIDTH{1'b0}};
    data_r = {`CYP_DATAWIDTH{1'b0}};
    sdr_write_addr_r(0,data_r,byte_r);

    // read operation with chip enabled conditions
    @(posedge iright_clk); 
    #(TP.tDC_r); 
    inright_rw     = 1'b1;
    op_read_r     = 1'b1;
    op_write_r    = 1'b0;
    op_readback_r = 1'b0;
    inright_oe     = 1'b0;
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b1; 
    sdr_read_addr_r(0,byte_r);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tDC_r); 
   if(ioright_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioright_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result =1 actual result=%h ",
     $realtime, ioright_dq); 
   end
   else 
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result =1 actual result=%h ",
     $realtime, ioright_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
   // 3rd write 
   @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    inright_rw     = 1'b0;
    op_read_r      = 1'b0;
    op_write_r     = 1'b1;
    op_readback_r  = 1'b0;
    inright_oe     = 1'b0;

    byte_r = 8'b00000000;
    data_r[`CYP_DATAWIDTH-1:1] = {(`CYP_DATAWIDTH-1){1'b0}};
    data_r[0]     = 1'b1;
    sdr_write_addr_r(0,data_r,byte_r);
    // read operation with chip enabled conditions
    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_rw     = 1'b1;
    op_read_r     = 1'b1;
    op_write_r    = 1'b0;
    op_readback_r = 1'b0;
    inright_oe     = 1'b0;
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b1;
    sdr_read_addr_r(0,byte_r);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tDC_r); 
   if(ioright_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioright_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = 1 actual result=%h ",
     $realtime, ioright_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = 1 actual result=%h ",
     $realtime, ioright_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
  // 4th write
   @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b1;
    inright_rw     = 1'b0;
    op_read_r      = 1'b0;
    op_write_r     = 1'b1;
    op_readback_r  = 1'b0;
    inright_oe     = 1'b0;

    byte_r         = 8'b00000000;
    data_r         = {72{1'b0}};
    sdr_write_addr_r(0,data_r,byte_r);
  // read operation with chip enabled conditions
    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_rw     = 1'b1;
    op_read_r     = 1'b1;
    op_write_r    = 1'b0;
    op_readback_r = 1'b0;
    inright_oe     = 1'b0;
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b1;
    sdr_read_addr_r(0,byte_r);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tDC_r); 
   if(ioright_dq[`CYP_DATAWIDTH-1:1] == {(`CYP_DATAWIDTH-1){1'b0}}  &&
      ioright_dq[0] == 1'b1)
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = 1 actual result=%h ",
     $realtime, ioright_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = 1 actual result=%h ",
     $realtime, ioright_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
   // read operation with chip enabled conditions
    @(posedge iright_clk);
    #(TP.tDC_r); 
    inright_rw     = 1'b1;
    op_read_r      = 1'b1;
    op_write_r     = 1'b0;
    op_readback_r  = 1'b0;
    inright_oe     = 1'b0;
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b0;
    sdr_read_addr_r(0,byte_r);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
       #(TP.tDC_r); 
   if(ioright_dq === {`CYP_DATAWIDTH{1'bZ}})
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = z actual result=%h ",
     $realtime, ioright_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = z actual result=%h ",
     $realtime, ioright_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
  // read operation with chip enabled conditions
    @(posedge iright_clk);
    #(TP.tDC_r); 
    inright_rw     = 1'b1;
    op_read_r      = 1'b1;
    op_write_r     = 1'b0;
    op_readback_r  = 1'b0;
    inright_oe     = 1'b0;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    sdr_read_addr_r(0,byte_r);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tDC_r); 
   if(ioright_dq === {`CYP_DATAWIDTH{1'bZ}})
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = z actual result=%h ",
     $realtime, ioright_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = z actual result=%h ",
     $realtime, ioright_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
   // read operation with chip enabled conditions
    @(posedge iright_clk);
    #(TP.tDC_r); 
    inright_rw     = 1'b1;
    op_read_r      = 1'b1;
    op_write_r     = 1'b0;
    op_readback_r  = 1'b0;
    inright_oe     = 1'b0;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b1;
    sdr_read_addr_r(0,byte_r);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tDC_r); 
   if(ioright_dq === {`CYP_DATAWIDTH{1'bZ}})
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST PASSED: expected result = z actual result=%h ",
     $realtime, ioright_dq);
   end
   else
   begin
     if(nmsg == 1'b1)$display("%10.2f TEST FAILED: expected result = z actual result=%h ",
     $realtime, ioright_dq);
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
   end
    @(posedge iright_clk);
    #(TP.tDC_r); 
    inright_ce0    = 1'b1;    
    iright_ce1     = 1'b0;    
    report_test_result("read_write_sdr2_addr_ce_r");
   end
  endtask


  // Testcase for SDR pipeline, chip enable
  // Read and Write operation  For Left Port 

  task read_write_ddr2_addr_ce_l;

 `ifdef CYP_ISDDR
   reg [2*`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [2*`CYP_BYTEWIDTH - 1 : 0] byte_l;
   reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_l;
   reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_l;
 `else
   reg [`CYP_DATAWIDTH   - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH   - 1 : 0] byte_l;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
 `endif
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for DDR pipeline, chip enable         --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    configure_device_ddr2;
    inleft_ce0  = 1'b1;
    ileft_ce1   = 1'b0;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    // write operation

    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    byte_l        = 8'b00000000;
    data_l        = {(`CYP_DATAWIDTH-1){1'b0}};
    data_l[0]     = 1'b1;
    data_l[9]     = 1'b1;
    enable_write_op_l;
    data_temp1_l  = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
    data_temp2_l  = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
    ddr_write_addr_l(0,data_temp1_l,byte_l);
    @(posedge ileft_clk);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    ddr_write_addr_l(0,data_temp2_l,byte_l);
    @(posedge ileft_clk_n);
    #TP.tHD_l;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    op_read_l = 1'b1;
    op_write_l = 1'b0;
    @(posedge ileft_clk);
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    inleft_ce0    = 1'b0;
    inleft_rw = 1'b1;
    ddr_read_addr_l(0);
    @(posedge ileft_clk);
    #TP.tHAC_l;
    ileft_ce1    = 1'b0;
    @(posedge ileft_clk);
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tDC_l);
    ddr_compare_result_l(0);
    @(posedge ileft_clk);
    #(ileft_clk_period/2.0 - TP.tDC_l);
    ddr_compare_result_l(0);
    
    report_test_result("read_write_ddr2_addr_ce_l");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
   end
  endtask

  
  // Testcase for SDR pipeline, chip enable
  // Read and Write operation  For Right Port 
  task read_write_ddr2_addr_ce_r;

 `ifdef CYP_ISDDR
   reg [2*`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [2*`CYP_BYTEWIDTH - 1 : 0] byte_r;
   reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_r;
   reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_r;
 `else
   reg [`CYP_DATAWIDTH   - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH   - 1 : 0] byte_r;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
 `endif
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for DDR pipeline, chip enable         --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Right Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    configure_device_ddr2;
    inright_ce0  = 1'b1;
    iright_ce1   = 1'b0;
    #1;
    iright_clk_period_old  = iright_clk_period;
    iright_clk_period      = TP.tCYC_min;
    ileft_clk_period_old   = ileft_clk_period;
    ileft_clk_period       = TP.tCYC_min;
    counter_load_mode_r;
    master_reset;

    wait (onright_ready == 1'b0);
    // write operation

    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    byte_r        = 8'b00000000;
    data_r        = {(`CYP_DATAWIDTH-1){1'b0}};
    data_r[0]     = 1'b1;
    data_r[9]     = 1'b1;
    enable_write_op_r;
    data_temp1_r  = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
    data_temp2_r  = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
    ddr_write_addr_r(0,data_temp1_r,byte_r);
    @(posedge iright_clk);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    ddr_write_addr_r(0,data_temp2_r,byte_r);
    @(posedge iright_clk_n);
    #TP.tHD_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    inright_ce0    = 1'b0;
    ddr_read_addr_r(0);
    op_read_r = 1'b1;
    op_write_r = 1'b0;
    inright_rw = 1'b1;
    @(posedge iright_clk);
    #TP.tHAC_r;
    iright_ce1    = 1'b0;
    @(posedge iright_clk);
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tDC_r);
    ddr_compare_result_r(0);
    @(posedge iright_clk);
    #(iright_clk_period/2.0 - TP.tDC_r);
    ddr_compare_result_r(0);
    
    report_test_result("read_write_ddr2_addr_ce_r");
    iright_clk_period  = iright_clk_period_old;
    ileft_clk_period   = ileft_clk_period_old;
   end
  endtask


