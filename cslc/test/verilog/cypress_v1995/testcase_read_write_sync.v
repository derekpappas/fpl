
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
// File          : testcase_read_write_sync.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase to verify the read and write operations of the model
// while both ports working parallally
// *******************************************************************


// Task for reading the memory from left port
// in 2 pipeline stage read operation

task read_sdr2_l;

  integer count_l;

  begin
   @(posedge ileft_clk);
   @(posedge ileft_clk);

    #(ileft_clk_period - TP.tSAC_l);
    enable_read_op_l;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tDC_l);
    inleft_ce0    = 1'b0;
    sdr_read_addr_l(0,byte_l);
    for (count_l = 1;count_l <=(`CYP_LASTADDR_TEST+3);count_l = count_l +1)
    begin
      @(posedge ileft_clk);
       #(TP.tDC_l);
       if(count_l <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_l,byte_l);
       if(count_l >= 3) sdr_compare_result_l((count_l - 3),byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tDC_l);
    inleft_ce0     = 1'b1;    
    ileft_ce1     = 1'b0;    
  end
endtask


// Task for reading the memory from right port
// in 2 pipeline stage read operation

task read_ddr2_r;

  integer count_r;
  begin

  `ifdef SDR
  `else
    #(iright_clk_period/2.0 - TP.tSAC_r);
    enable_read_op_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);

    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    inright_ce0    = 1'b0;
    ddr_read_addr_r(0);

    for (count_r = 1;count_r <=(`CYP_LASTADDR_TEST+2);count_r = count_r +1)
    begin
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      if(count_r <= `CYP_LASTADDR_TEST) ddr_read_addr_r(count_r);
      #(TP.tSAC_r - TP.tDC_r);
      if(count_r >= 2) ddr_compare_result_r(count_r - 2);

      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tDC_r);
      if(count_r >= 2) ddr_compare_result_r(count_r - 2);
    end
  `endif
  end
endtask


// Testcase for the read and write operation when both the 
// ports working together. Left port is configured for 
// 2 pipelined stage SDR mode and right port configured 
// for 2.5 stage DDR model
// Frequency of operation for both the ports are different

task read_write_sync;

  integer count_loop;
  reg [`CYP_DATAWIDTH-1:0] data_l;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--  Testcase for the read and write operation when   --");
    if(nmsg == 1'b1)$display("--        both the ports working together            --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    
    ileft_clk_period_old  = ileft_clk_period;
    ileft_clk_period      = TP.tCYC_min + 0.5;
    iright_clk_period_old = iright_clk_period;
    iright_clk_period     = TP.tCYC_min;
    
    ileft_ftsel    = 1'b1; 
    ileft_ddron    = 1'b0; // Configure left port for SDR
    ileft_portstd  = 1'b1;
    iright_ftsel   = 1'b1;
    iright_ddron   = 1'b1; // Configure right port for DDR
    iright_portstd = 1'b1;
 
    inleft_ce0     = 1'b1;
    ileft_ce1      = 1'b0;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
    a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
    counter_load_mode_l;
    counter_load_mode_r;
    master_reset;

    wait (onleft_ready == 1'b0);
    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    @(posedge ileft_clk);

    #(ileft_clk_period - TP.tSAC_l);
    enable_write_op_l;
    byte_l = 8'b00000000;
    byte_r = 8'b00000000;
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
    inleft_ce0    = 1'b1;
 
    fork
      read_sdr2_l;
      read_ddr2_r;
    join
    ileft_clk_period   = ileft_clk_period_old;
    iright_clk_period  = iright_clk_period_old;
    report_test_result("read_write_sync");
  end
endtask
