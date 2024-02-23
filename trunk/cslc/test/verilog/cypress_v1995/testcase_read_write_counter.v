
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
// File          : testcase_read_write_counter.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases to verify the read and write operations of the model
// addressed by burst counter
// *******************************************************************


  // Testcase for flow through mode  
  // Read and Write operation 
  // Using Burst Conuter   
  // For Left Port

  task read_write_flow_through_counter_l;

   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop;
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--      Testcase for flow through mode               --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--            Using Burst Conuter                    --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_flow_through;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_hold_l;
    master_reset;
    
    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l); 
   
    enable_write_op_l; 
    byte_l = 8'b00000000;
    counter_increment_l;
 
    randomdata_72bit(data_l);
    sdr_write_counter_l(1,data_l,byte_l);
 
    for (count_loop = 2; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      sdr_write_counter_l(count_loop,data_l,byte_l);
    end

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tHD_l);

    counter_hold_l;
    inleft_ce0    = 1'b1;

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tHAC_l);
    counter_load_l(0);

    @(posedge ileft_clk);
    #(TP.tHAC_l);
    counter_hold_l;

    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_ce0    = 1'b0;

    enable_read_op_l;
    counter_increment_l;

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+1);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tDC_l); 
       if(count_loop >= 2) sdr_compare_result_l((count_loop - 1),byte_l);
    end
    inleft_ce0    = 1'b1;    
    ileft_ce1     = 1'b0;  
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old; 
    report_test_result("read_write_flow_through_counter_l"); 
   end
  endtask


  // Testcase for SDR mode 2 pipeline stage 
  // Read and Write operation 
  // Using Burst Conuter  
  // For Left Port 
  
  task read_write_sdr2_counter_l;

   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop;
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for SDR mode 2 pipeline stage        --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--            Using Burst Conuter                    --");
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
   
    enable_write_op_l; 
    byte_l = 8'b00000000;
    counter_increment_l;
 
    randomdata_72bit(data_l);
    sdr_write_counter_l(1,data_l,byte_l);   
 
    for (count_loop = 2; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      sdr_write_counter_l(count_loop,data_l,byte_l);
    end

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    counter_hold_l;
    inleft_ce0    = 1'b1;

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tHD_l); 
    counter_load_l(0);

    @(posedge ileft_clk);
     #(TP.tHD_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_ce0    = 1'b0;

    enable_read_op_l;
    counter_increment_l;

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+2);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tDC_l); 
       if(count_loop >= 3) sdr_compare_result_l((count_loop - 2),byte_l);
    end
    inleft_ce0    = 1'b1;    
    ileft_ce1     = 1'b0;   
    report_test_result("read_write_sdr2_counter_l"); 
   end
  endtask

  
  // Testcase for DDR mode 2.5 pipeline stage  
  // Read and Write operation 
  // Using Burst Conuter   
  // For Left Port

  task read_write_ddr2_counter_l;

`ifdef DDR
   reg [2*`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_temp1_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_temp2_l;
`else
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
`endif
   integer count_loop;
   begin
  `ifdef SDR 
  `else
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for DDR mode 2.5 pipeline stage      --");
    if(nmsg == 1'b1)$display("--           Read and Write operation                --");
    if(nmsg == 1'b1)$display("--            Using Burst Conuter                    --");
    if(nmsg == 1'b1)$display("--                For Left Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    @(posedge ileft_clk);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    configure_device_ddr2;
    counter_hold_l;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);

    counter_increment_l;
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
    data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
    ddr_write_counter_l(1,data_temp1_l);
    @(posedge ileft_clk);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    ddr_write_counter_l(1,data_temp2_l);

    for (count_loop = 2; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_write_counter_l(count_loop,data_temp1_l);
      @(posedge ileft_clk);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      ddr_write_counter_l(count_loop,data_temp2_l);
    end
    @(posedge ileft_clk);
    #TP.tHAC_l;
    counter_hold_l;

    enable_read_op_l;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #TP.tHAC_l;
    counter_load_l(0);

    @(posedge ileft_clk);
    #TP.tHAC_l;
    counter_hold_l;

    @(posedge ileft_clk);

    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    inleft_ce0    = 1'b0;
    counter_increment_l;
    @(posedge ileft_clk);

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+1);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tDC_l);
      if(count_loop >= 2) ddr_compare_result_l(count_loop - 1);

      @(posedge ileft_clk);
      #(ileft_clk_period/2.0 - TP.tDC_l);
      if(count_loop >= 2) ddr_compare_result_l(count_loop - 1);
    end
    inleft_ce0   = 1'b1;
    ileft_ce1    = 1'b0;
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  `endif
    report_test_result("read_write_ddr2_counter_l");
   end
  endtask



  // Testcase for flow through mode  
  // Read and Write operation
  // Using Burst Conuter  
  // For Right Port

  task read_write_flow_through_counter_r;

   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count_loop;
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--       Testcase for flow through mode              --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--            Using Burst Conuter                    --");
    if(nmsg == 1'b1)$display("--                For Right Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    configure_device_flow_through;
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_FT_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_FT_min;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;
    
    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
   
    enable_write_op_r; 
    byte_r = 8'b00000000;
    counter_increment_r;
 
    randomdata_72bit(data_r);
    sdr_write_counter_r(1,data_r,byte_r);   
 
    for (count_loop = 2; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      sdr_write_counter_r(count_loop,data_r,byte_r);
    end

    @(posedge iright_clk);
    @(posedge iright_clk);

    #TP.tHAC_r;
    counter_hold_r;
    inright_ce0    = 1'b1;

    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);

    #TP.tHAC_r;
    counter_load_r(0);

    @(posedge iright_clk);
    #TP.tHAC_r;
    counter_hold_r;

    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_ce0    = 1'b0;

    enable_read_op_r;
    counter_increment_r;

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+1);count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tDC_r); 
       if(count_loop >= 2) sdr_compare_result_r((count_loop - 1),byte_r);
    end
    inright_ce0    = 1'b1;    
    iright_ce1     = 1'b0;   
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
    report_test_result("read_write_flow_through_counter_r"); 
   end
  endtask


  // Testcase for SDR mode 2 pipeline stage  
  // Read and Write operation   
  // Using Burst Conuter   
  // For Right Port

  task read_write_sdr2_counter_r;

   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count_loop;
   begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for SDR mode 2 pipeline stage        --");
    if(nmsg == 1'b1)$display("--          Read and Write operation                 --");
    if(nmsg == 1'b1)$display("--            Using Burst Conuter                    --");
    if(nmsg == 1'b1)$display("--                For Right Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    
    configure_device_sdr2;
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    counter_hold_r;
    master_reset;
    
    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
   
    enable_write_op_r; 
    byte_r = 8'b00000000;
    counter_increment_r;
 
    randomdata_72bit(data_r);
    sdr_write_counter_r(1,data_r,byte_r);   
 
    for (count_loop = 2; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      sdr_write_counter_r(count_loop,data_r,byte_r);
    end

    @(posedge iright_clk);
    @(posedge iright_clk);
    #TP.tHAC_r;
    counter_hold_r;
    inright_ce0    = 1'b1;

    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #TP.tHAC_r;
    counter_load_r(0);

    @(posedge iright_clk);
    #TP.tHAC_r;
    counter_hold_r;

    @(posedge iright_clk);
    #(TP.tHD_r); 
    inright_ce0    = 1'b0;

    enable_read_op_r;
    counter_increment_r;

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+2);count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tDC_r); 
       if(count_loop >= 3) sdr_compare_result_r((count_loop - 2),byte_r);
    end
    inright_ce0    = 1'b1;    
    iright_ce1     = 1'b0;   
    report_test_result("read_write_sdr2_counter_r"); 
   end
  endtask


  // Testcase for DDR mode 2.5 pipeline stage  
  // Read and Write operation      
  // Using Burst Conuter    
  // For Right Port

  task read_write_ddr2_counter_r;


`ifdef DDR
   reg [2*`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   reg [`CYP_DATAWIDTH - 1 : 0] data_temp1_r;
   reg [`CYP_DATAWIDTH - 1 : 0] data_temp2_r;
`else
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
   reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
`endif
   integer count_loop;
   begin
  `ifdef SDR 
  `else
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for DDR mode 2.5 pipeline stage      --");
    if(nmsg == 1'b1)$display("--           Read and Write operation                --");
    if(nmsg == 1'b1)$display("--            Using Burst Conuter                    --");
    if(nmsg == 1'b1)$display("--                For Right Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    @(posedge iright_clk);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    configure_device_ddr2;
    counter_hold_r;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);

    counter_increment_r;
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
    data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
    ddr_write_counter_r(1,data_temp1_r);
    @(posedge iright_clk);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    ddr_write_counter_r(1,data_temp2_r);

    for (count_loop = 2; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_write_counter_r(count_loop,data_temp1_r);
      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      ddr_write_counter_r(count_loop,data_temp2_r);
    end
    @(posedge iright_clk);
    #TP.tHAC_r;
    counter_hold_r;

    enable_read_op_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #TP.tHAC_r;
    counter_load_r(0);

    @(posedge iright_clk);
    #TP.tHAC_r;
    counter_hold_r;

    @(posedge iright_clk);

    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    inright_ce0    = 1'b0;
    counter_increment_r;
    @(posedge iright_clk);

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+1);count_loop = count_loop +1)
    begin
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tDC_r);
      if(count_loop >= 2) ddr_compare_result_r(count_loop - 1);

      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tDC_r);
      if(count_loop >= 2) ddr_compare_result_r(count_loop - 1);
    end
    inright_ce0   = 1'b1;
    iright_ce1    = 1'b0;
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
  `endif
    report_test_result("read_write_ddr2_counter_r");
   end
  endtask




