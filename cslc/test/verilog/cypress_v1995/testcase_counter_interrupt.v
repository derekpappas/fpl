
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
// File          : testcase_counter_interrupt.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for verifying the counter interrupt operation
// *******************************************************************

 // Testcase for Counter Interrupt Operation 
 // For Left Port in SDR mode

 task counter_interrupt_sdr_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Counter Interrupt Operation      --");
    if(nmsg == 1'b1)$display("--             For Left Port in SDR Mode             --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    inleft_wrp    = 1'b0;

    counter_hold_l;
    master_reset;

    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    
    mask_load_value[`CYP_ADDRWIDTH - 1: 5] = {(`CYP_ADDRWIDTH - 5){1'b0}};
    mask_load_value[4:1] = 4'b1111;
    mask_load_value[0]   = 1'b0; 
    mask_load_l(mask_load_value);

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};
   
    count_load_value[`CYP_ADDRWIDTH - 1: 6] = {(`CYP_ADDRWIDTH - 6){1'b0}};
    count_load_value[5:2] = 4'b1011;
    count_load_value[1:0] = 2'b01;

    counter_load_l(count_load_value);   // Load conter with 'h2d;
    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    counter_hold_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    counter_increment_l;
    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge ileft_clk);
      if(count == `CYP_ADDRWIDTH'h3d)
      begin
        if(onleft_cntint == 1'b0)
	begin
           #(TP.tRCINT_l + offset);
	   if(onleft_cntint == 1'b1)
           begin
	      if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST PASSED:Left Port CNTINT# is asserted",$realtime);
           end 
           else
           begin
              if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Left Port CNTINT# not de-asserted",$realtime);
              failed_flag       = 1'b1;
	      failed_flag_local = 1'b1;
           end
	end
	else
	begin
           if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Left Port CNTINT# not asserted",$realtime);
           failed_flag       = 1'b1;
	   failed_flag_local = 1'b1;
	end
      end
    end
    
    #(TP.tDC_l); 
    inleft_ce0     = 1'b1;
    report_test_result("counter_interrupt_sdr_l");
  end
 endtask


 // Testcase for Counter Interrupt Operation 
 // For Left Port in DDR mode

 task counter_interrupt_ddr_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Counter Interrupt Operation      --");
    if(nmsg == 1'b1)$display("--             For Left Port in DDR Mode             --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    configure_device_ddr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    inleft_wrp    = 1'b0;

    counter_hold_l;
    master_reset;

    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    
    mask_load_value[`CYP_ADDRWIDTH - 1: 5] = {(`CYP_ADDRWIDTH - 5){1'b0}};
    mask_load_value[4:1] = 4'b1111;
    mask_load_value[0]   = 1'b0; 
    mask_load_l(mask_load_value);

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};
   
    count_load_value[`CYP_ADDRWIDTH - 1: 6] = {(`CYP_ADDRWIDTH - 6){1'b0}};
    count_load_value[5:2] = 4'b1011;
    count_load_value[1:0] = 2'b01;

    counter_load_l(count_load_value);   // Load conter with 'h2d;
    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    counter_hold_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    counter_increment_l;
    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge ileft_clk);
      if(count == `CYP_ADDRWIDTH'h3d)
      begin
        if(onleft_cntint == 1'b0)
	begin
           #(TP.tRCINT_l + offset);
	   if(onleft_cntint == 1'b1)
           begin
	      if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST PASSED:Left Port CNTINT# is asserted",$realtime);
           end 
           else
           begin
              if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Left Port CNTINT# not de-asserted",$realtime);
              failed_flag       = 1'b1;
	      failed_flag_local = 1'b1;
           end
	end
	else
	begin
           if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Left Port CNTINT# not asserted",$realtime);
           failed_flag       = 1'b1;
	   failed_flag_local = 1'b1;
	end
      end
    end
    
    #(TP.tDC_l); 
    inleft_ce0     = 1'b1;
    report_test_result("counter_interrupt_ddr_l");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask


  // Testcase for Counter Interrupt Operation 
 // For Left Port in Flow through mode

 task counter_interrupt_flow_through_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Counter Interrupt Operation      --");
    if(nmsg == 1'b1)$display("--         For Left Port in Flow Through Mode        --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    configure_device_flow_through;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    inleft_wrp    = 1'b0;

    counter_hold_l;
    master_reset;

    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    
    mask_load_value[`CYP_ADDRWIDTH - 1: 5] = {(`CYP_ADDRWIDTH - 5){1'b0}};
    mask_load_value[4:1] = 4'b1111;
    mask_load_value[0]   = 1'b0; 
    mask_load_l(mask_load_value);

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    a_rw_l = {`CYP_ADDRWIDTH{1'bZ}};
   
    count_load_value[`CYP_ADDRWIDTH - 1: 6] = {(`CYP_ADDRWIDTH - 6){1'b0}};
    count_load_value[5:2] = 4'b1011;
    count_load_value[1:0] = 2'b01;

    counter_load_l(count_load_value);   // Load conter with 'h2d;
    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    counter_hold_l;
    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    counter_increment_l;
    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge ileft_clk);
      if(count == `CYP_ADDRWIDTH'h3d)
      begin
        if(onleft_cntint == 1'b0)
	begin
           #(TP.tRCINT_l + offset);
	   if(onleft_cntint == 1'b1)
           begin
	      if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST PASSED:Left Port CNTINT# is asserted",$realtime);
           end 
           else
           begin
              if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Left Port CNTINT# not de-asserted",$realtime);
              failed_flag       = 1'b1;
	      failed_flag_local = 1'b1;
           end
	end
	else
	begin
           if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Left Port CNTINT# not asserted",$realtime);
           failed_flag       = 1'b1;
	   failed_flag_local = 1'b1;
	end
      end
    end
    
    #(TP.tDC_l); 
    inleft_ce0     = 1'b1;
    report_test_result("counter_interrupt_flow_through_l");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask

 
 // Testcase for Counter Interrupt Operation 
 // For Right Port in SDR mode

 task counter_interrupt_sdr_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Counter Interrupt Operation      --");
    if(nmsg == 1'b1)$display("--             For Right Port in SDR mode            --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    inright_wrp    = 1'b0;

    counter_hold_r;
    master_reset;

    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    
    mask_load_value[`CYP_ADDRWIDTH - 1: 5] = {(`CYP_ADDRWIDTH - 5){1'b0}};
    mask_load_value[4:1] = 4'b1111;
    mask_load_value[0]   = 1'b0; 
    mask_load_r(mask_load_value);

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};
   
    count_load_value[`CYP_ADDRWIDTH - 1: 6] = {(`CYP_ADDRWIDTH - 6){1'b0}};
    count_load_value[5:2] = 4'b1011;
    count_load_value[1:0] = 2'b01;

    counter_load_r(count_load_value);   // Load conter with 'h2d;
    @(posedge iright_clk);
    #(TP.tHAC_r); 

    counter_hold_r;
    @(posedge iright_clk);
    #(TP.tHAC_r); 

    counter_increment_r;
    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge iright_clk);
      if(count == `CYP_ADDRWIDTH'h3d)
      begin
        if(onright_cntint == 1'b0)
	begin
           #(TP.tRCINT_r + offset);
	   if(onright_cntint == 1'b1)
           begin
	      if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST PASSED:Right Port CNTINT# is asserted",$realtime);
           end 
           else
           begin
              if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Right Port CNTINT# not de-asserted",$realtime);
              failed_flag       = 1'b1;
	      failed_flag_local = 1'b1;
           end
	end
	else
	begin
           if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Right Port CNTINT# not asserted",$realtime);
           failed_flag       = 1'b1;
	   failed_flag_local = 1'b1;
	end
      end
    end
    
    #(TP.tDC_r); 
    inright_ce0     = 1'b1;
    report_test_result("counter_interrupt_sdr_r");
  end
 endtask

 
 // Testcase for Counter Interrupt Operation 
 // For Right Port in dDR mode

 task counter_interrupt_ddr_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Counter Interrupt Operation      --");
    if(nmsg == 1'b1)$display("--             For Right Port in DDR mode            --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_ddr2;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    inright_wrp    = 1'b0;

    counter_hold_r;
    master_reset;

    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    
    mask_load_value[`CYP_ADDRWIDTH - 1: 5] = {(`CYP_ADDRWIDTH - 5){1'b0}};
    mask_load_value[4:1] = 4'b1111;
    mask_load_value[0]   = 1'b0; 
    mask_load_r(mask_load_value);

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};
   
    count_load_value[`CYP_ADDRWIDTH - 1: 6] = {(`CYP_ADDRWIDTH - 6){1'b0}};
    count_load_value[5:2] = 4'b1011;
    count_load_value[1:0] = 2'b01;

    counter_load_r(count_load_value);   // Load conter with 'h2d;
    @(posedge iright_clk);
    #(TP.tHAC_r); 

    counter_hold_r;
    @(posedge iright_clk);
    #(TP.tHAC_r); 

    counter_increment_r;
    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge iright_clk);
      if(count == `CYP_ADDRWIDTH'h3d)
      begin
        if(onright_cntint == 1'b0)
	begin
           #(TP.tRCINT_r + offset);
	   if(onright_cntint == 1'b1)
           begin
	      if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST PASSED:Right Port CNTINT# is asserted",$realtime);
           end 
           else
           begin
              if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Right Port CNTINT# not de-asserted",$realtime);
              failed_flag       = 1'b1;
	      failed_flag_local = 1'b1;
           end
	end
	else
	begin
           if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Right Port CNTINT# not asserted",$realtime);
           failed_flag       = 1'b1;
	   failed_flag_local = 1'b1;
	end
      end
    end
    
    #(TP.tDC_r); 
    inright_ce0     = 1'b1;
    report_test_result("counter_interrupt_ddr_r");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask

 
 // Testcase for Counter Interrupt Operation 
 // For Right Port in Flow Through mode

 task counter_interrupt_flow_through_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Counter Interrupt Operation      --");
    if(nmsg == 1'b1)$display("--        For Right Port in Flow Through mode        --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_flow_through;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    inright_wrp    = 1'b0;

    counter_hold_r;
    master_reset;

    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    
    mask_load_value[`CYP_ADDRWIDTH - 1: 5] = {(`CYP_ADDRWIDTH - 5){1'b0}};
    mask_load_value[4:1] = 4'b1111;
    mask_load_value[0]   = 1'b0; 
    mask_load_r(mask_load_value);

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    a_rw_r = {`CYP_ADDRWIDTH{1'bZ}};
   
    count_load_value[`CYP_ADDRWIDTH - 1: 6] = {(`CYP_ADDRWIDTH - 6){1'b0}};
    count_load_value[5:2] = 4'b1011;
    count_load_value[1:0] = 2'b01;

    counter_load_r(count_load_value);   // Load conter with 'h2d;
    @(posedge iright_clk);
    #(TP.tHAC_r); 

    counter_hold_r;
    @(posedge iright_clk);
    #(TP.tHAC_r); 

    counter_increment_r;
    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge iright_clk);
      if(count == `CYP_ADDRWIDTH'h3d)
      begin
        if(onright_cntint == 1'b0)
	begin
           #(TP.tRCINT_r + offset);
	   if(onright_cntint == 1'b1)
           begin
	      if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST PASSED:Right Port CNTINT# is asserted",$realtime);
           end 
           else
           begin
              if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Right Port CNTINT# not de-asserted",$realtime);
              failed_flag       = 1'b1;
	      failed_flag_local = 1'b1;
           end
	end
	else
	begin
           if(nmsg == 1'b1)$display("%10.2f COUNTER INTERRUPT TEST FAILED:Right Port CNTINT# not asserted",$realtime);
           failed_flag       = 1'b1;
	   failed_flag_local = 1'b1;
	end
      end
    end
    
    #(TP.tDC_r); 
    inright_ce0     = 1'b1;
    report_test_result("counter_interrupt_flow_through_r");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask

