
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
// File          : testcase_retransmit_test_wrp.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for verifying the WRP# pin operation
// *******************************************************************

 // Testcase for Retransmit Operation 
 // Using WRP# pin For Left Port 

 task retransmit_wrp_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--        Testcase for Retransmit Operation          --");
    if(nmsg == 1'b1)$display("--                Using WRP# pin                     --");
    if(nmsg == 1'b1)$display("--                 For Left Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    configure_device_sdr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    inleft_wrp    = 1'b0;

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

    for (count = 2; count<= 64;count = count +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      sdr_write_counter_l(count,data_l,byte_l);
    end

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #TP.tHAC_l;
    counter_hold_l;
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

    inleft_ce0    = 1'b0;
    enable_read_op_l;
    counter_increment_l;

    @(posedge ileft_clk);
    @(posedge ileft_clk);

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--      Testing the Left port with WRP# = 0          --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge ileft_clk);
    #(TP.tDC_l); 
    sdr_compare_result_l(`CYP_ADDRWIDTH'h2f,byte_l);

    for (count = `CYP_ADDRWIDTH'h31; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge ileft_clk);
      #(TP.tDC_l); 
      sdr_compare_result_l(count,byte_l);
    end

    for (count = `CYP_ADDRWIDTH'h21; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge ileft_clk);
      #(TP.tDC_l); 
      sdr_compare_result_l(count,byte_l);
    end


    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--      Testing the Left port with WRP# = 1          --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    // Testing the model with WRP# pin 1
    inleft_wrp    = 1'b1;
    for (count = `CYP_ADDRWIDTH'h21; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge ileft_clk);
      #(TP.tDC_l); 
      sdr_compare_result_l(count,byte_l);
    end

    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge ileft_clk);
      #(TP.tDC_l); 
      sdr_compare_result_l(count,byte_l);
    end

    @(posedge ileft_clk);
    #(TP.tDC_l); 
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    report_test_result("retransmit_wrp_l"); 
  end
 endtask


 // Testcase for Retransmit Operation 
 // Using WRP# pin For Right Port

 task retransmit_wrp_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--        Testcase for Retransmit Operation          --");
    if(nmsg == 1'b1)$display("--                 Using WRP# pin                    --");
    if(nmsg == 1'b1)$display("--                 For Right Port                    --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    configure_device_sdr2;
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    inright_wrp    = 1'b0;

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

    for (count = 2; count<= 64;count = count +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      sdr_write_counter_r(count,data_r,byte_r);
    end

    @(posedge iright_clk);
    @(posedge iright_clk);

    #TP.tHAC_r;
    counter_hold_r;
    inright_ce0    = 1'b1;

    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r); 
    
    mask_load_value[`CYP_ADDRWIDTH - 1: 5] = {(`CYP_ADDRWIDTH - 5){1'b0}};
    mask_load_value[4:1] = 4'b1111;
    mask_load_value[0]   = 1'b0; 
    mask_load_r(mask_load_value);

    @(posedge iright_clk);
    #(TP.tHAC_r); 
    a_rw_r = `CYP_ADDRWIDTH'bZ;
   
    count_load_value[`CYP_ADDRWIDTH - 1: 6] = {(`CYP_ADDRWIDTH - 6){1'b0}};
    count_load_value[5:2] = 4'b1011;
    count_load_value[1:0] = 2'b01;

    counter_load_r(count_load_value);   // Load conter with 'h2d;

    @(posedge iright_clk);
    #(TP.tHAC_r); 

    counter_hold_r;
    @(posedge iright_clk);
    #(TP.tHAC_r); 

    inright_ce0    = 1'b0;
    enable_read_op_r;
    counter_increment_r;

    @(posedge iright_clk);
    @(posedge iright_clk);
    //@(posedge iright_clk);

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--      Testing the Right port with WRP# = 0          --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    @(posedge iright_clk);
    #(TP.tDC_r); 
    sdr_compare_result_r(`CYP_ADDRWIDTH'h2f,byte_r);

    for (count = `CYP_ADDRWIDTH'h31; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge iright_clk);
      #(TP.tDC_r); 
      sdr_compare_result_r(count,byte_r);
    end

    for (count = `CYP_ADDRWIDTH'h21; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge iright_clk);
      #(TP.tDC_r); 
      sdr_compare_result_r(count,byte_r);
    end


    if(nmsg == 1'b1)$display("-------------------------------------------------------");    
    if(nmsg == 1'b1)$display("--      Testing the Right port with WRP# = 1          --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");    

    // Testing the model with WRP# pin 1
    inright_wrp    = 1'b1;
    for (count = `CYP_ADDRWIDTH'h21; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge iright_clk);
      #(TP.tDC_r); 
      sdr_compare_result_r(count,byte_r);
    end

    for (count = `CYP_ADDRWIDTH'h2d; count <= `CYP_ADDRWIDTH'h3f;count = count +2)
    begin
      @(posedge iright_clk);
      #(TP.tDC_r); 
      sdr_compare_result_r(count,byte_r);
    end

    @(posedge iright_clk);
    #(TP.tDC_r); 
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    report_test_result("retransmit_wrp_r"); 
  end
 endtask



