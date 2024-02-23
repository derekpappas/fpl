
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
// File          : testcase_mailbox.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for testing the mail box operation of the model
// *******************************************************************

 // Testcase for SDR pipeline mode
 // Mail Box Operation 

 task mailbox_sdr_test;

  reg [`CYP_DATAWIDTH - 1 : 0] data_l;
  reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
  reg [`CYP_DATAWIDTH - 1 : 0] data_r;
  reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
  integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--        Testcase for SDR pipeline mode             --");
    if(nmsg == 1'b1)$display("--              Mail Box Operation                   --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_sdr2;
    inleft_ce0   = 1'b1;
    ileft_ce1    = 1'b0;
    inright_ce0  = 1'b1;
    iright_ce1   = 1'b0;

    counter_load_mode_l;
    counter_load_mode_r; 
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);

    // Testing Right port Mail Box operation
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    sdr_write_addr_l(`CYP_LASTADDR - 5,data_l,byte_l);

    for(count= (`CYP_LASTADDR - 4); count <= `CYP_LASTADDR; count = count +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      sdr_write_addr_l(count,data_l,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Right Port Interrupt assertion        --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    //@(posedge ileft_clk);
    if(onright_int == 1'b1)
    begin
      #(TP.tSINT_r - TP.tHD_l); 
      if(onright_int == 1'b0)
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Right port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   asserted when data written to Right port mail box");
      end
      else
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   not asserted when data written to Right port mail box");
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
      if(nmsg == 1'b1)$display("not asserted when data written to Right port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end


    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Left Port Interrupt assertion         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    // Testing Left port Mail Box operation
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);   
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    sdr_write_addr_r(`CYP_LASTADDR - 5,data_r,byte_r);

    for(count= (`CYP_LASTADDR - 4); count <= `CYP_LASTADDR - 1; count = count +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      sdr_write_addr_r(count,data_r,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;

    //@(posedge iright_clk);
    if(onleft_int == 1'b1)
    begin
      @(posedge iright_clk);
      #(TP.tSINT_l - TP.tHD_r);
      if(onleft_int == 1'b0)
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Left port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   asserted when data written to Left port mail box");
      end
      else
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   not asserted when data written to Left port mail box");
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
      if(nmsg == 1'b1)$display("   not asserted when data written to Left port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end

    // Test for de-assertion of Left port interrupt

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Left Port Interrupt de-assertion      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    enable_read_op_l;
    sdr_read_addr_l(`CYP_LASTADDR - 5,byte_l);
    for (count = (`CYP_LASTADDR - 4);count <=(`CYP_LASTADDR - 1);count = count +1)
    begin
      @(posedge ileft_clk);
       #(TP.tHD_l); 
       sdr_read_addr_l(count,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_ce0  = 1'b1;
    ileft_ce1   = 1'b0;

    //@(posedge ileft_clk);
    if(onleft_int == 1'b0)
    begin
      #(TP.tRINT_l);
      if(onleft_int == 1'b1)
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Left port interrupt",$realtime);
       if(nmsg == 1'b1)$display("   de-asserted properly when read from Left port mail box"); 
      end
      else
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
       if(nmsg == 1'b1)$display("  not de-asserted properly when read from Left port mail box");
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
      if(nmsg == 1'b1)$display("  not de-asserted properly when read from Left port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end

    // Test for de-assertion of Right port interrupt

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Right Port Interrupt de-assertion     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");    

    @(posedge iright_clk);
    #(TP.tHD_r); 
    enable_read_op_r;
    sdr_read_addr_r(`CYP_LASTADDR - 5,byte_r);
    for (count = (`CYP_LASTADDR - 4);count <= `CYP_LASTADDR; count = count +1)
    begin
      @(posedge iright_clk);
       #(TP.tHD_r); 
       sdr_read_addr_r(count,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_ce0  = 1'b1;
    iright_ce1   = 1'b0;
    
    //@(posedge iright_clk);
    if(onright_int == 1'b0)
    begin
      #(TP.tRINT_r); 
      if(onright_int == 1'b1)
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Right port interrupt",$realtime);
       if(nmsg == 1'b1)$display("   de-asserted properly when read from right port mail box");         end
      else
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
       if(nmsg == 1'b1)$display(" not de-asserted properly when read from right port mail box");
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
      end    
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
      if(nmsg == 1'b1)$display("  not de-asserted properly when read from Right port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end
    report_test_result("mailbox_sdr_test");
  end
 endtask


 // Testcase for Flow-Through mode
 // Mail Box Operation 

 task mailbox_flow_through_test;

  reg [`CYP_DATAWIDTH - 1 : 0] data_l;
  reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
  reg [`CYP_DATAWIDTH - 1 : 0] data_r;
  reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
  integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--        Testcase for Flow Through mode             --");
    if(nmsg == 1'b1)$display("--              Mail Box Operation                   --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_flow_through;
    #1;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    inleft_ce0   = 1'b1;
    ileft_ce1    = 1'b0;
    inright_ce0  = 1'b1;
    iright_ce1   = 1'b0;

    counter_load_mode_l;
    counter_load_mode_r; 
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);

    // Testing Right port Mail Box operation
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    sdr_write_addr_l(`CYP_LASTADDR - 5,data_l,byte_l);

    for(count= (`CYP_LASTADDR - 4); count <= `CYP_LASTADDR; count = count +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      sdr_write_addr_l(count,data_l,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Right Port Interrupt assertion        --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    //@(posedge ileft_clk);
    if(onright_int == 1'b1)
    begin
      #(TP.tSINT_r - TP.tHD_l); 
      if(onright_int == 1'b0)
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Right port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   asserted when data written to Right port mail box");
      end
      else
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   not asserted when data written to Right port mail box");
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
      if(nmsg == 1'b1)$display("not asserted when data written to Right port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end


    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Left Port Interrupt assertion         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    // Testing Left port Mail Box operation
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);   
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    sdr_write_addr_r(`CYP_LASTADDR - 5,data_r,byte_r);

    for(count= (`CYP_LASTADDR - 4); count <= `CYP_LASTADDR - 1; count = count +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      sdr_write_addr_r(count,data_r,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;

    //@(posedge iright_clk);
    if(onleft_int == 1'b1)
    begin
      @(posedge iright_clk);
      #(TP.tSINT_l - TP.tHD_r);
      if(onleft_int == 1'b0)
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Left port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   asserted when data written to Left port mail box");
      end
      else
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   not asserted when data written to Left port mail box");
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
      if(nmsg == 1'b1)$display("   not asserted when data written to Left port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end

    // Test for de-assertion of Left port interrupt

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Left Port Interrupt de-assertion      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    enable_read_op_l;
    sdr_read_addr_l(`CYP_LASTADDR - 5,byte_l);
    for (count = (`CYP_LASTADDR - 4);count <=(`CYP_LASTADDR - 1);count = count +1)
    begin
      @(posedge ileft_clk);
       #(TP.tHD_l); 
       sdr_read_addr_l(count,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_ce0  = 1'b1;
    ileft_ce1   = 1'b0;

    //@(posedge ileft_clk);
    if(onleft_int == 1'b0)
    begin
      #(TP.tRINT_l);
      if(onleft_int == 1'b1)
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Left port interrupt",$realtime);
       if(nmsg == 1'b1)$display("   de-asserted properly when read from Left port mail box"); 
      end
      else
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
       if(nmsg == 1'b1)$display("  not de-asserted properly when read from Left port mail box");
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
      if(nmsg == 1'b1)$display("  not de-asserted properly when read from Left port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end

    // Test for de-assertion of Right port interrupt

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Right Port Interrupt de-assertion     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");    

    @(posedge iright_clk);
    #(TP.tHD_r); 
    enable_read_op_r;
    sdr_read_addr_r(`CYP_LASTADDR - 5,byte_r);
    for (count = (`CYP_LASTADDR - 4);count <= `CYP_LASTADDR; count = count +1)
    begin
      @(posedge iright_clk);
       #(TP.tHD_r); 
       sdr_read_addr_r(count,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_ce0  = 1'b1;
    iright_ce1   = 1'b0;
    
    //@(posedge iright_clk);
    if(onright_int == 1'b0)
    begin
      #(TP.tRINT_r); 
      if(onright_int == 1'b1)
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Right port interrupt",$realtime);
       if(nmsg == 1'b1)$display("   de-asserted properly when read from right port mail box");         end
      else
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
       if(nmsg == 1'b1)$display(" not de-asserted properly when read from right port mail box");
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
      end    
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
      if(nmsg == 1'b1)$display("  not de-asserted properly when read from Right port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end
    report_test_result("mailbox_flow_through_test");
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  end
 endtask


 
 // Testcase for DDR pipeline mode
 // Mail Box Operation 

 task mailbox_ddr_test;

  reg [`CYP_DATAWIDTH   - 1 : 0] data_l;
  reg [`CYP_BYTEWIDTH   - 1 : 0] byte_l;
  reg [`CYP_DATAWIDTH   - 1 : 0] data_r;
  reg [`CYP_BYTEWIDTH   - 1 : 0] byte_r;
  reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
  reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
  reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
  reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
  integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--       Testcase for DDR pipeline mode              --");
    if(nmsg == 1'b1)$display("--              Mail Box Operation                   --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_ddr2;
    inleft_ce0  = 1'b1;
    ileft_ce1   = 1'b0;
    inright_ce0 = 1'b1;
    iright_ce1  = 1'b0;

    counter_load_mode_l;
    counter_load_mode_r; 
    master_reset;

    wait (onleft_ready  == 1'b0);
    wait (onright_ready == 1'b0);

    // Testing Right port Mail Box operation

    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
    data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
    ddr_write_addr_l(`CYP_LASTADDR - 5,data_temp1_l,byte_l);
    @(posedge ileft_clk);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    ddr_write_addr_l(`CYP_LASTADDR - 5,data_temp2_l,byte_l);

    for (count = (`CYP_LASTADDR - 4); count<= `CYP_LASTADDR;count = count +1)
    begin
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_write_addr_l(count,data_temp1_l,byte_l);
      @(posedge ileft_clk);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_write_addr_l(count,data_temp2_l,byte_l);
    end
    @(posedge ileft_clk_n);
    #TP.tHD_l;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Right Port Interrupt assertion        --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    //@(posedge ileft_clk);
    if(onright_int == 1'b1)
    begin
      #(TP.tSINT_r - TP.tHD_l - ileft_clk_period/2.0); 
      if(onright_int == 1'b0)
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Right port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   asserted when data written to Right port mail box");
      end
      else
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   not asserted when data written to Right port mail box");
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
      if(nmsg == 1'b1)$display("not asserted when data written to Right port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end


    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Left Port Interrupt assertion         --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    // Testing Left port Mail Box operation
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
    data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
    ddr_write_addr_r(`CYP_LASTADDR - 5,data_temp1_r,byte_r);
    @(posedge iright_clk);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    ddr_write_addr_r(`CYP_LASTADDR - 5,data_temp2_r,byte_r);

    for (count = (`CYP_LASTADDR - 4); count<= `CYP_LASTADDR - 1;count = count +1)
    begin
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_write_addr_r(count,data_temp1_r,byte_r);
      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_write_addr_r(count,data_temp2_r,byte_l);
    end
    @(posedge iright_clk_n);
    #(TP.tHD_r); 
    inright_ce0 = 1'b1;
    iright_ce1  = 1'b0;

    //@(posedge iright_clk);
    if(onleft_int == 1'b1)
    begin
      @(posedge iright_clk);
      #(TP.tSINT_l - TP.tHD_r - iright_clk_period/2.0);
      if(onleft_int == 1'b0)
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Left port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   asserted when data written to Left port mail box");
      end
      else
      begin
        if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
        if(nmsg == 1'b1)$display("   not asserted when data written to Left port mail box");
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
      if(nmsg == 1'b1)$display("   not asserted when data written to Left port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end

    // Test for de-assertion of Left port interrupt

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Left Port Interrupt de-assertion      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    enable_read_op_l;
    ddr_read_addr_l(`CYP_LASTADDR - 5);

    for (count = (`CYP_LASTADDR - 4);count <=(`CYP_LASTADDR - 1);count = count +1)
    begin
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_read_addr_l(count);
    end
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    inleft_ce0  = 1'b1;
    ileft_ce1   = 1'b0;

    if(onleft_int == 1'b0)
    begin
      #(TP.tRINT_l);
      if(onleft_int == 1'b1)
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Left port interrupt",$realtime);
       if(nmsg == 1'b1)$display("   de-asserted properly when read from Left port mail box"); 
      end
      else
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
       if(nmsg == 1'b1)$display("  not de-asserted properly when read from Left port mail box");
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
      end
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Left port interrupt",$realtime);
      if(nmsg == 1'b1)$display("  not de-asserted properly when read from Left port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end

    // Test for de-assertion of Right port interrupt

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testing Right Port Interrupt de-assertion     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");    

    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    enable_read_op_r;
    ddr_read_addr_r(`CYP_LASTADDR - 5);
    @(posedge iright_clk);

    for (count = (`CYP_LASTADDR - 4);count <=`CYP_LASTADDR;count = count +1)
    begin
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_read_addr_r(count);
    end

    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_ce0  = 1'b1;
    iright_ce1   = 1'b0;
    
    //@(posedge iright_clk);
    if(onright_int == 1'b0)
    begin
      #(TP.tRINT_r); 
      if(onright_int == 1'b1)
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST PASSED: Right port interrupt",$realtime);
       if(nmsg == 1'b1)$display("  de-asserted properly when read from right port mail box"); 
      end
      else
      begin
       if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
       if(nmsg == 1'b1)$display(" not de-asserted properly when read from right port mail box");
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
      end    
    end
    else
    begin
      if(nmsg == 1'b1)$display("%10.2f Mail Box TEST FAILED: Right port interrupt",$realtime);
      if(nmsg == 1'b1)$display("  not de-asserted properly when read from Right port mail box");
      failed_flag       = 1'b1;
      failed_flag_local = 1'b1;
    end
    ileft_clk_period    = ileft_clk_period_old;
    iright_clk_period   = iright_clk_period_old;
    report_test_result("mailbox_ddr_test");
  end
 endtask

