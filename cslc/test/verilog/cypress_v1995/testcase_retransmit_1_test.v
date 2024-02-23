
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
// File          : testcase_retransmit_1_test.v 
// Author        : 
// Author's Email:
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase to verify the RETRANSMIT#1 operation of the model
// *******************************************************************


 // Testcase for Retransmit#1 operation  
 // For Left Port

 task retransmit_1_test_l;

   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--       Testcase for Retransmit#1 operation         --");
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
    
    // Writing to the memory
    enable_write_op_l;
    byte_l = 8'b00000000;

    counter_increment_l;
    enable_write_op_l;
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
    #TP.tHAC_l;
    counter_hold_l;
    inleft_ce0    = 1'b1;

    // Loading the counter with 5 
    #(TP.tHAC_l); 
    counter_load_l(`CYP_ADDRWIDTH'd5);

    @(posedge ileft_clk);
    #(TP.tHAC_l); 
    counter_hold_l;

    @(posedge ileft_clk);
    #(TP.tHAC_l); 

    inleft_ce0    = 1'b0;
    enable_read_op_l;
    counter_increment_l;

    for (count_loop = 6;count_loop <= 15 ;count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tDC_l); 
       if(count_loop >= 6+2) sdr_compare_result_l((count_loop - 2),byte_l);
    end

    @(posedge ileft_clk);
    #(TP.tDC_l); 

    sdr_compare_result_l((16 - 2),byte_l);
    retransmit_1_l;
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    sdr_compare_result_l((17 - 2),byte_l);
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    sdr_compare_result_l((18 - 2),byte_l);
    @(posedge ileft_clk);
    #(TP.tDC_l); 

    sdr_compare_result_l(`CYP_ADDRWIDTH'd5,byte_l);
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    sdr_compare_result_l(`CYP_ADDRWIDTH'd5,byte_l);
    @(posedge ileft_clk);
    #(TP.tDC_l); 
    sdr_compare_result_l(`CYP_ADDRWIDTH'd5,byte_l);

    inleft_ce0 = 1'b1;
    ileft_ce1  = 1'b0;
    report_test_result("retransmit_1_test_l");
  end
 endtask


 // Testcase for Retransmit#1 operation 
 // For Right Port

 task retransmit_1_test_r;

   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count_loop;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--       Testcase for Retransmit#1 operation         --");
    if(nmsg == 1'b1)$display("--                For Right Port                      --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    configure_device_sdr2;
    inright_ce0   = 1'b1;
    iright_ce1    = 1'b0;
    counter_hold_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    
    // Writing to the memory
    enable_write_op_r;
    byte_r = 8'b00000000;

    counter_increment_r;
    enable_write_op_r;
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
    #(TP.tHAC_r);
    counter_hold_r;
    #(TP.tHAC_r);
    inright_ce0    = 1'b1;
   
    // Loading the counter with 5 
    counter_load_r(`CYP_ADDRWIDTH'd5);

    @(posedge iright_clk);
    #(TP.tHAC_r);
    counter_hold_r;

    @(posedge iright_clk);
    #(TP.tHAC_r);

    inright_ce0    = 1'b0;
    enable_read_op_r;
    counter_increment_r;

    for (count_loop = 6;count_loop <= 15 ;count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tDC_r);     
       if(count_loop >= 6+2) sdr_compare_result_r((count_loop - 2),byte_r);
    end

    @(posedge iright_clk);
    #(TP.tDC_r); 

    sdr_compare_result_r((16 - 2),byte_r);
    retransmit_1_r;
    @(posedge iright_clk);
    #(TP.tDC_r); 
    sdr_compare_result_r((17 - 2),byte_r);
    @(posedge iright_clk);
    #(TP.tDC_r); 
    sdr_compare_result_r((18 - 2),byte_r);
    @(posedge iright_clk);
    #(TP.tDC_r); 

    sdr_compare_result_r(`CYP_ADDRWIDTH'd5,byte_r);
    @(posedge iright_clk);
    #(TP.tDC_r); 
    sdr_compare_result_r(`CYP_ADDRWIDTH'd5,byte_r);
    @(posedge iright_clk);
    #(TP.tDC_r); 
    sdr_compare_result_r(`CYP_ADDRWIDTH'd5,byte_r);

    inright_ce0 = 1'b1;
    iright_ce1  = 1'b0;
    report_test_result("retransmit_1_test_r");
  end
 endtask




