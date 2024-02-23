
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
// File          : testcase_error_be_1.v 
// Author        : 
// Author's Email: 
// Date          : 02 JUL 2004
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for testing BE invalid load condition
// *******************************************************************

  // Byte Enables Error Testcase for SDR mode 2 pipeline stage
  // Read and Write operation Using Address Bus 
  // For Left Port  

  task read_error_be_1_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop,i;
   begin

    $display("----------------------------------------------------------------");
    $display("--Byte Enables Error Testcase for SDR mode 2 pipeline stage   --");
    $display("--          Read and Write operation                          --");
    $display("--              Using Address Bus                             --");
    $display("--                For Left Port                               --");
    $display("----------------------------------------------------------------");
    configure_device_sdr2;
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0); 
    
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    enable_write_op_l;
    randomdata_72bit(rand_temp_data);
    byte_l = rand_temp_data[`CYP_BYTEWIDTH-1:0];
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
    @(posedge ileft_clk);
    #(TP.tDC_l);
    inleft_ce0    = 1'b0;
    sdr_read_addr_l(0,byte_l);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
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
  endtask

