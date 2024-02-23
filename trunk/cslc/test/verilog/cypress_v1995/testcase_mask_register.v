
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
// File          : testcase_mask_register.v
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases for verifying the mask register operation
// *******************************************************************

 // Testcase for Mask Register Operation 
 // For Left Port 

 task mask_reg_test_l;

   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   integer count1,count2;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--       Testcase for Mask Register Operation        --");
    if(nmsg == 1'b1)$display("--                 For Left Port                     --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inleft_ce0 = 1'b1;
    ileft_ce1  = 1'b0;
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

    for (count1 = 2; count1 <= `CYP_LASTADDR_TEST;count1 = count1 +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(ileft_clk_period - TP.tSAC_l); 
      sdr_write_counter_l(count1,data_l,byte_l);
    end

    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(TP.tHAC_l);
    counter_hold_l;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);

    for(count2 = 0; count2 <= 2; count2 = count2 + 1)
    begin

      @(posedge ileft_clk);
      #(TP.tHAC_l);
      count_load_value = {`CYP_ADDRWIDTH{1'b0}};
      counter_load_l(count_load_value);
      @(posedge ileft_clk);
      #(TP.tHAC_l); 

      mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
      case (count2)
        3'd0:  
        begin
          mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
        end
        3'd1:
        begin
          mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
          mask_load_value[0]   = 1'b0;
        end
        3'd2: 
        begin
          mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
          mask_load_value[1:0] = 2'b00;
        end
      endcase
 
      mask_load_l(mask_load_value);
      @(posedge ileft_clk);
      #(TP.tHAC_l); 

      counter_hold_l;

      @(posedge ileft_clk);
      #(TP.tHAC_l); 
      inleft_ce0 = 1'b0;

      enable_read_op_l;
      counter_increment_l;

      case (count2)
        3'd0:
        begin
          if(nmsg == 1'b1)$display("-----------------------------------------");
          if(nmsg == 1'b1)$display("--     Counter Incrementing by 1       --");
          if(nmsg == 1'b1)$display("-----------------------------------------");

          for (count1 = 0;count1 <=(`CYP_LASTADDR_TEST+1);count1 = count1 +1)
          begin
            @(posedge ileft_clk);
            #(TP.tDC_l); 
            if(count1 >= 2) sdr_compare_result_l((count1 - 1),byte_l);
          end
          inleft_ce0 = 1'b1;
        end

        3'd1:        
        begin     
          if(nmsg == 1'b1)$display("-----------------------------------------");
          if(nmsg == 1'b1)$display("--     Counter Incrementing by 2       --");
          if(nmsg == 1'b1)$display("-----------------------------------------");

          for (count1 = 0;count1 <=(`CYP_LASTADDR_TEST+2);count1 = count1 +2)
          begin
            @(posedge ileft_clk);
            #(TP.tDC_l); 
            if(count1 >= 4) sdr_compare_result_l((count1 - 2),byte_l);
          end
          inleft_ce0 = 1'b1;
        end

        3'd2:
        begin              
          if(nmsg == 1'b1)$display("-----------------------------------------");
          if(nmsg == 1'b1)$display("--     Counter Incrementing by 4       --");
          if(nmsg == 1'b1)$display("-----------------------------------------");

          for (count1 = 0;count1 <=(`CYP_LASTADDR_TEST+4);count1 = count1 +4)
          begin
            @(posedge ileft_clk);
            #(TP.tDC_l); 
            if(count1 >= 8) sdr_compare_result_l((count1 - 4),byte_l);
          end
          inleft_ce0 = 1'b1;
        end

      endcase
    end

    ileft_ce1  = 1'b0;
    report_test_result("mask_reg_test_l"); 
  end
 endtask


 // Testcase for Mask Register Operation
 // For Right Port 

 task mask_reg_test_r;

   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   reg [`CYP_ADDRWIDTH - 1 : 0] mask_load_value;
   reg [`CYP_ADDRWIDTH - 1 : 0] count_load_value;
   integer count1,count2;

  begin

    if(nmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--       Testcase for Mask Register Operation        --");
    if(nmsg == 1'b1)$display("--                 For Right Port                    --");
    if(nmsg == 1'b1)$display("-------------------------------------------------------");

    configure_device_sdr2;
    inright_ce0 = 1'b1;
    iright_ce1  = 1'b0;
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

    for (count1 = 2; count1 <= `CYP_LASTADDR_TEST;count1 = count1 +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 
      sdr_write_counter_r(count1,data_r,byte_r);
    end

    @(posedge iright_clk);
    @(posedge iright_clk);
    #(TP.tHAC_r);
    counter_hold_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);

    for(count2 = 0; count2 <= 2; count2 = count2 + 1)
    begin

      @(posedge iright_clk);
      #(TP.tHAC_l);
      count_load_value = {`CYP_ADDRWIDTH{1'b0}};
      counter_load_r(count_load_value);
      @(posedge iright_clk);
      #(iright_clk_period - TP.tSAC_r); 

      mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
      case (count2)
        3'd0:  
        begin
          mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
        end
        3'd1:
        begin
          mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
          mask_load_value[0]   = 1'b0;
        end
        3'd2: 
        begin
          mask_load_value = {`CYP_ADDRWIDTH{1'b1}};
          mask_load_value[1:0] = 2'b00;
        end
      endcase
 
      mask_load_r(mask_load_value);
      @(posedge iright_clk);
      #(TP.tHAC_r); 

      counter_hold_r;

      @(posedge iright_clk);
      #(TP.tHAC_r);
      inright_ce0 = 1'b0;

      enable_read_op_r;
      counter_increment_r;

      case (count2)
        3'd0:
        begin
          if(nmsg == 1'b1)$display("-----------------------------------------");
          if(nmsg == 1'b1)$display("--     Counter Incrementing by 1       --");
          if(nmsg == 1'b1)$display("-----------------------------------------");

          for (count1 = 0;count1 <=(`CYP_LASTADDR_TEST+1);count1 = count1 +1)
          begin
            @(posedge iright_clk);
            #(TP.tDC_r); 
            if(count1 >= 2) sdr_compare_result_r((count1 - 1),byte_r);
          end
          inright_ce0 = 1'b1;
        end

        3'd1:        
        begin     
          if(nmsg == 1'b1)$display("-----------------------------------------");
          if(nmsg == 1'b1)$display("--     Counter Incrementing by 2       --");
          if(nmsg == 1'b1)$display("-----------------------------------------");

          for (count1 = 0;count1 <=(`CYP_LASTADDR_TEST+2);count1 = count1 +2)
          begin
            @(posedge iright_clk);
            #(TP.tDC_r); 
            if(count1 >= 4) sdr_compare_result_r((count1 - 2),byte_r);
          end
          inright_ce0 = 1'b1;
        end

        3'd2:
        begin              
          if(nmsg == 1'b1)$display("-----------------------------------------");
          if(nmsg == 1'b1)$display("--     Counter Incrementing by 4       --");
          if(nmsg == 1'b1)$display("-----------------------------------------");

          for (count1 = 0;count1 <=(`CYP_LASTADDR_TEST+4);count1 = count1 +4)
          begin
            @(posedge iright_clk);
            #(TP.tDC_r); 
            if(count1 >= 8) sdr_compare_result_r((count1 - 4),byte_r);
          end
          inright_ce0 = 1'b1;
        end

      endcase
    end

    iright_ce1  = 1'b0;
    report_test_result("mask_reg_test_r"); 
  end
 endtask



