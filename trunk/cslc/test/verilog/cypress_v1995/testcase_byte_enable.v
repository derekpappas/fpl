
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
// File          : testcase_byte_enable.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase file for testing the Byte Enable pins
// operation of both left and right ports
// *******************************************************************


 // Testcase for SDR mode 2 pipeline stage 
 // Byte Enable operation  
 // Using Address Bus For Left Port  

 task byte_enable_sdr_test_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop;
   integer count_loop2;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for SDR mode 2 pipeline stage        --");
    if(nmsg == 1'b1)$display("--            Byte Enable operation                  --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0);

    // Writing random data to memory using address bus
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    sdr_write_addr_l(0,data_l,byte_l);

    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      sdr_write_addr_l(count_loop,data_l,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    
    for(count_loop2 =0; count_loop2 <= 24; count_loop2 =count_loop2 +1)
    begin

      byte_l = 8'b00000000;
      if(count_loop2 >= 1 && count_loop2 <= `CYP_BYTEWIDTH) 
      begin
        byte_l = 8'b00000000;
        byte_l[count_loop2 - 1] = 1'b1;
      end
      else if(count_loop2 >= 9 && count_loop2 <= 16)
      begin
        byte_l = 8'b1111_1111;
        byte_l[count_loop2 - 9] = 1'b0;
      end
      else if(count_loop2 >= 17 && count_loop2 <= 24)
      begin
	randomdata_72bit(rand_temp_data);
        byte_l = rand_temp_data[`CYP_BYTEWIDTH-1:0];
      end


      if(nmsg == 1'b1)$display("----------------------------------------------------");
      if(nmsg == 1'b1)$display("--   Testing Byte Enable for Read operation       --");
      if(nmsg == 1'b1)$display("--         When BE# pin value is %hh              --",byte_l);
      if(nmsg == 1'b1)$display("--              For Left Port                     --");
      if(nmsg == 1'b1)$display("----------------------------------------------------");

      enable_read_op_l;
      inleft_ce0    = 1'b1;
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tDC_l); 
      inleft_ce0    = 1'b0;
      sdr_read_addr_l(0,byte_l);
      for(count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
      begin
        @(posedge ileft_clk);
        #(TP.tDC_l); 
        if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_loop,byte_l);
        if(count_loop >= 3) sdr_compare_result_l((count_loop - 3),byte_l);
      end
      @(posedge ileft_clk);
      #(TP.tDC_l); 
      inleft_ce0     = 1'b1;
      ileft_ce1     = 1'b0;
    end
    

    for(count_loop2 =0; count_loop2 <= 24; count_loop2 =count_loop2 +1)
    begin

      byte_l = 8'b00000000;
      if(count_loop2 >= 1 && count_loop2 <= `CYP_BYTEWIDTH)
      begin
        byte_l = 8'b00000000;
        byte_l[count_loop2 - 1] = 1'b1;
      end
      else if(count_loop2 >= 9 && count_loop2 <= 16)
      begin
        byte_l = 8'b1111_1111;
        byte_l[count_loop2 - 9] = 1'b0;
      end
      else if(count_loop2 >= 17 && count_loop2 <= 24)
      begin
	randomdata_72bit(rand_temp_data);
        byte_l = rand_temp_data[`CYP_BYTEWIDTH-1:0];
      end

      if(nmsg == 1'b1)$display("----------------------------------------------------");
      if(nmsg == 1'b1)$display("--   Testing Byte Enable for Write operation      --");
      if(nmsg == 1'b1)$display("--         When BE# pin value is %hh              --",byte_l);
      if(nmsg == 1'b1)$display("--              For Left Port                     --");
      if(nmsg == 1'b1)$display("----------------------------------------------------");

      enable_write_op_l;
      inleft_ce0    = 1'b1;
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      inleft_ce0    = 1'b0;

      randomdata_72bit(data_l);
      sdr_write_addr_l(0,data_l,byte_l);

      for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
      begin
        randomdata_72bit(data_l);
        @(posedge ileft_clk);
        #(ileft_clk_period - TP.tSAC_l); 
        sdr_write_addr_l(count_loop,data_l,byte_l);
      end

      @(posedge ileft_clk);
      #(TP.tHD_l); 

      enable_read_op_l;
      inleft_ce0    = 1'b1;
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tDC_l); 

      inleft_ce0    = 1'b0;
      byte_l = 8'b00000000;
      sdr_read_addr_l(0,byte_l);
      for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop =count_loop +1)
      begin
        @(posedge ileft_clk);
        #(TP.tDC_l); 
        if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_loop,byte_l);
        if(count_loop >= 3) sdr_compare_result_l((count_loop - 3),byte_l);
      end
      @(posedge ileft_clk);
      #(TP.tDC_l); 
      inleft_ce0     = 1'b1;
      ileft_ce1     = 1'b0;
    end
    report_test_result("byte_enable_sdr_test_l");
  end
 endtask


 // Testcase for SDR mode 2 pipeline stage
 // Byte Enable operation  
 // Using Address Bus For Right Port

 task byte_enable_sdr_test_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_r;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count_loop;
   integer count_loop2;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for SDR mode 2 pipeline stage        --");
    if(nmsg == 1'b1)$display("--            Byte Enable operation                  --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Right Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_load_mode_r;
    master_reset;

    wait (onright_ready == 1'b0);

    // Writing random data to memory using address bus
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    sdr_write_addr_r(0,data_r,byte_r);

    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      sdr_write_addr_r(count_loop,data_r,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tHD_r); 
    
    for(count_loop2 =0; count_loop2 <= 24; count_loop2 =count_loop2 +1)
    begin

      byte_r = 8'b00000000;
      if(count_loop2 >= 1 && count_loop2 <= `CYP_BYTEWIDTH) 
      begin
        byte_r = 8'b00000000;
        byte_r[count_loop2 - 1] = 1'b1;
      end
      else if(count_loop2 >= 9 && count_loop2 <= 16)
      begin
        byte_r = 8'b1111_1111;
        byte_r[count_loop2 - 9] = 1'b0;
      end
      else if(count_loop2 >= 17 && count_loop2 <= 24)
      begin
	randomdata_72bit(rand_temp_data);
        byte_r = rand_temp_data[`CYP_BYTEWIDTH-1:0];
      end


      if(nmsg == 1'b1)$display("----------------------------------------------------");
      if(nmsg == 1'b1)$display("--   Testing Byte Enable for Read operation       --");
      if(nmsg == 1'b1)$display("--         When BE# pin value is %hh              --",byte_r);
      if(nmsg == 1'b1)$display("--              For Right Port                     --");
      if(nmsg == 1'b1)$display("----------------------------------------------------");

      enable_read_op_r;
      inright_ce0    = 1'b1;
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tDC_r); 
      inright_ce0    = 1'b0;
      byte_r =8'b00000000;
      sdr_read_addr_r(0,byte_r);
      for(count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
      begin
        @(posedge iright_clk);
        #(TP.tDC_r); 
        if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_r(count_loop,byte_r);
        if(count_loop >= 3) sdr_compare_result_r((count_loop - 3),byte_r);
      end
      @(posedge iright_clk);
      #(TP.tDC_r); 
      inright_ce0     = 1'b1;
      iright_ce1     = 1'b0;
    end
    

    for(count_loop2 =0; count_loop2 <= 24; count_loop2 =count_loop2 +1)
    begin

      byte_r = 8'b00000000;
      if(count_loop2 >= 1 && count_loop2 <= `CYP_BYTEWIDTH)
      begin
        byte_r = 8'b00000000;
        byte_r[count_loop2 - 1] = 1'b1;
      end
      else if(count_loop2 >= 9 && count_loop2 <= 16)
      begin
        byte_r = 8'b1111_1111;
        byte_r[count_loop2 - 9] = 1'b0;
      end
      else if(count_loop2 >= 17 && count_loop2 <= 24)
      begin
	randomdata_72bit(rand_temp_data);
        byte_r = rand_temp_data[`CYP_BYTEWIDTH-1:0];
      end

      if(nmsg == 1'b1)$display("----------------------------------------------------");
      if(nmsg == 1'b1)$display("--   Testing Byte Enable for Write operation      --");
      if(nmsg == 1'b1)$display("--         When BE# pin value is %hh              --",byte_r);
      if(nmsg == 1'b1)$display("--              For Right Port                     --");
      if(nmsg == 1'b1)$display("----------------------------------------------------");

      enable_write_op_r;
      inright_ce0    = 1'b1;
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      inright_ce0    = 1'b0;

      randomdata_72bit(data_r);
      sdr_write_addr_r(0,data_r,byte_r);

      for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
      begin
        randomdata_72bit(data_r);
        @(posedge iright_clk);
        #(iright_clk_period - TP.tSAC_r); 
        sdr_write_addr_r(count_loop,data_r,byte_r);
      end

      @(posedge iright_clk);
      #(TP.tHD_r); 

      enable_read_op_r;
      inright_ce0    = 1'b1;
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tDC_r); 

      inright_ce0    = 1'b0;
      byte_r = 8'b00000000;
      sdr_read_addr_r(0,byte_r);
      for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop =count_loop +1)
      begin
        @(posedge iright_clk);
        #(TP.tDC_r); 
        if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_r(count_loop,byte_r);
        if(count_loop >= 3) sdr_compare_result_r((count_loop - 3),byte_r);
      end
      @(posedge iright_clk);
      #(TP.tDC_r); 
      inright_ce0     = 1'b1;
      iright_ce1     = 1'b0;
    end
    report_test_result("byte_enable_sdr_test_r");
  end
 endtask


 // Testcase for DDR mode 2 pipeline stage 
 // Byte Enable operation  
 // Using Address Bus For Left Port  

 task byte_enable_ddr_test_l;

   reg [`CYP_ADDRWIDTH   - 1 : 0] address_l;
 `ifdef DDR
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

   integer count_loop;
   integer count_loop2;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for DDR mode 2 pipeline stage        --");
    if(nmsg == 1'b1)$display("--            Byte Enable operation                  --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    configure_device_ddr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0);

    // Writing random data to memory will all bytes enabled
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
    data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
    ddr_write_addr_l(0,data_temp1_l,byte_l);
    @(posedge ileft_clk);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    ddr_write_addr_l(0,data_temp2_l,byte_l);

    for (count_loop = 1; count_loop<= 5;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_write_addr_l(count_loop,data_temp1_l,byte_l);
      @(posedge ileft_clk);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_write_addr_l(count_loop,data_temp2_l,byte_l);
    end
    @(posedge ileft_clk_n);
    #TP.tHD_l;


    // Assigning different values for byte enables 
    for(count_loop2 =0; count_loop2 <= 24; count_loop2 =count_loop2 +1)
    begin

      byte_l = 8'b00000000;
      if(count_loop2 >= 1 && count_loop2 <= 8) 
      begin
        byte_l = 8'b00000000;
        byte_l[count_loop2 - 1] = 1'b1;
      end
      else if(count_loop2 >= 9 && count_loop2 <= 16)
      begin
        byte_l = 8'b1111_1111;
        byte_l[count_loop2 - 9] = 1'b0;
      end
      else if(count_loop2 >= 17 && count_loop2 <= 24)
      begin
	randomdata_72bit(rand_temp_data);
        byte_l = rand_temp_data[`CYP_BYTEWIDTH-1:0];
      end

      if(nmsg == 1'b1)$display("----------------------------------------------------");
      if(nmsg == 1'b1)$display("--   Testing Byte Enable for Write operation      --");
      if(nmsg == 1'b1)$display("--         When BE# pin value is %hh              --",byte_l);
      if(nmsg == 1'b1)$display("--              For Left Port                     --");
      if(nmsg == 1'b1)$display("----------------------------------------------------");

      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      enable_write_op_l;
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      ddr_write_addr_l(0,data_temp1_l,byte_l);
      @(posedge ileft_clk);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_write_addr_l(0,data_temp2_l,byte_l);

      for (count_loop = 1; count_loop<= 5;count_loop = count_loop +1)
      begin
        randomdata_72bit(data_l);
        data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
        data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
        @(posedge ileft_clk_n);
        #(ileft_clk_period/2.0 - TP.tSAC_l);
        ddr_write_addr_l(count_loop,data_temp1_l,byte_l);
        @(posedge ileft_clk);
        #(ileft_clk_period/2.0 - TP.tSAC_l);
        ddr_write_addr_l(count_loop,data_temp2_l,byte_l);
      end
      @(posedge ileft_clk_n);
      #TP.tHD_l;
      inleft_ce0    = 1'b1;

      // Read operation and compare the result
      
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      enable_read_op_l;
      ddr_read_addr_l(0);

      for (count_loop = 1;count_loop <=(5+2);count_loop = count_loop +1)
      begin
         @(posedge ileft_clk_n);
         #(ileft_clk_period/2.0 - TP.tSAC_l);
         if(count_loop <= 5) ddr_read_addr_l(count_loop);
	 if(count_loop >  5) inleft_ce0    = 1'b1;
         #(TP.tSAC_l- TP.tDC_l);
         if(count_loop >= 2) ddr_compare_result_l(count_loop - 2);

         @(posedge ileft_clk);
         #(ileft_clk_period/2.0 - TP.tDC_l);
         if(count_loop >= 2) ddr_compare_result_l(count_loop - 2);
      end
    end
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
    report_test_result("byte_enable_ddr_test_l");
  end
 endtask


 // Testcase for DDR mode 2 pipeline stage 
 // Byte Enable operation  
 // Using Address Bus For Right Port  

 task byte_enable_ddr_test_r;

   reg [`CYP_ADDRWIDTH   - 1 : 0] address_r;
 `ifdef DDR
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

   integer count_loop;
   integer count_loop2;
  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for DDR mode 2 pipeline stage        --");
    if(nmsg == 1'b1)$display("--            Byte Enable operation                  --");
    if(nmsg == 1'b1)$display("--              Using Address Bus                    --");
    if(nmsg == 1'b1)$display("--                For Right Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    configure_device_ddr2;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_load_mode_r;
    master_reset;

    wait (onright_ready == 1'b0);

    // Writing random data to memory will all bytes enabled
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
    data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
    ddr_write_addr_r(0,data_temp1_r,byte_r);
    @(posedge iright_clk);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    ddr_write_addr_r(0,data_temp2_r,byte_r);

    for (count_loop = 1; count_loop<= 5;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_write_addr_r(count_loop,data_temp1_r,byte_r);
      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_write_addr_r(count_loop,data_temp2_r,byte_r);
    end
    @(posedge iright_clk_n);
    #TP.tHD_r;


    // Assigning different values for byte enables 
    for(count_loop2 =0; count_loop2 <= 24; count_loop2 =count_loop2 +1)
    begin

      byte_r = 8'b00000000;
      if(count_loop2 >= 1 && count_loop2 <= 8) 
      begin
        byte_r = 8'b00000000;
        byte_r[count_loop2 - 1] = 1'b1;
      end
      else if(count_loop2 >= 9 && count_loop2 <= 16)
      begin
        byte_r = 8'b1111_1111;
        byte_r[count_loop2 - 9] = 1'b0;
      end
      else if(count_loop2 >= 17 && count_loop2 <= 24)
      begin
	randomdata_72bit(rand_temp_data);
        byte_r = rand_temp_data[`CYP_BYTEWIDTH-1:0];
      end

      if(nmsg == 1'b1)$display("----------------------------------------------------");
      if(nmsg == 1'b1)$display("--   Testing Byte Enable for Write operation      --");
      if(nmsg == 1'b1)$display("--         When BE# pin value is %hh              --",byte_r);
      if(nmsg == 1'b1)$display("--              For Right Port                    --");
      if(nmsg == 1'b1)$display("----------------------------------------------------");

      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      enable_write_op_r;
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      ddr_write_addr_r(0,data_temp1_r,byte_r);
      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_write_addr_r(0,data_temp2_r,byte_r);

      for (count_loop = 1; count_loop<= 5;count_loop = count_loop +1)
      begin
        randomdata_72bit(data_r);
        data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
        data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
        @(posedge iright_clk_n);
        #(iright_clk_period/2.0 - TP.tSAC_r);
        ddr_write_addr_r(count_loop,data_temp1_r,byte_r);
        @(posedge iright_clk);
        #(iright_clk_period/2.0 - TP.tSAC_r);
        ddr_write_addr_r(count_loop,data_temp2_r,byte_r);
      end
      @(posedge iright_clk_n);
      #TP.tHD_r;
      inright_ce0    = 1'b1;

      // Read operation and compare the result
      
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      enable_read_op_r;
      ddr_read_addr_r(0);

      for (count_loop = 1;count_loop <=(5+2);count_loop = count_loop +1)
      begin
         @(posedge iright_clk_n);
         #(iright_clk_period/2.0 - TP.tSAC_r);
         if(count_loop <= 5) ddr_read_addr_r(count_loop);
	 if(count_loop >  5) inright_ce0    = 1'b1;
         #(TP.tSAC_l- TP.tDC_r);
         if(count_loop >= 2) ddr_compare_result_r(count_loop - 2);

         @(posedge iright_clk);
         #(iright_clk_period/2.0 - TP.tDC_r);
         if(count_loop >= 2) ddr_compare_result_r(count_loop - 2);
      end
    end
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
    report_test_result("byte_enable_ddr_test_r");
  end
 endtask


