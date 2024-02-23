 
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
// File          : testcase_arb_sdr.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases to verify the Arbitration function when both the ports 
// are configured in SDR mode
// *******************************************************************


  // Testcase for Arbitration when both  
  // Ports Writing the data to memory   
  // Violating tCCS and Left port     
  // Comes First No tPS Violation             

  task arb_test_w_w_violate_tCCS_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin 

    if(wmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
    if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
    if(nmsg == 1'b1)$display("--        Violating tCCS and Left port               --");
    if(nmsg == 1'b1)$display("--                Comes First                        --");
    if(nmsg == 1'b1)$display("--             No tPS Violation                      --");
    if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
    if(wmsg == 1'b1)$display("-------------------------------------------------------");

     arb_test_on          = 1'b1;
     left_clk_first       = 1'b1;
     right_clk_first      = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_left_right = TP.tCYC_min * 0.05;  
     
     configure_device_sdr2;
     inleft_ce0           = 1'b1;
     ileft_ce1            = 1'b0;
     inright_ce0          = 1'b1;
     iright_ce1           = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onleft_ready  == 1'b0);
     wait (onright_ready == 1'b0);
     @(posedge iright_clk);
     @(posedge ileft_clk );

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     // Write data to memory location 0 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.1; 
     enable_write_op_l;
     sdr_write_addr_l(0,data_l,byte_l);
     
     // Write data to memory location 4 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.1; 
     enable_write_op_r;
     sdr_write_addr_r(4,data_r,byte_r);


     // Write data to memory location 1 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.1; 
     sdr_write_addr_l(1,data_l,byte_l);
     
     // Write data to memory location 3 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.1; 
     sdr_write_addr_r(3,data_r,byte_r);

     // Write data to memory location 2 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.1; 
     sdr_write_addr_l(2,data_l,byte_l);
     
     // Write data to memory location 2 from right port // Collission
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.1; 
     sdr_write_addr_r(2,data_r,byte_r);

     // Disable Write Operations    
     @(posedge ileft_clk);
     #0.1; 
     inleft_ce0     = 1'b1;  

     @(posedge iright_clk);
     #0.1; 
     inright_ce0     = 1'b1;  


     // Test for BUSY# assertion
     fork
       busy_check_low_after_4_period_l;
       busy_check_low_after_4_period_r;
     join

     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_w_w_violate_tCCS_l");
   end
  endtask


  // Testcase for Arbitration when both
  // Ports Writing the data to memory
  // Violating tPS and Left port 
  // Comes First. No tCCS violation 
  // BUSY# flag may or maynot generate  

  task arb_test_w_w_violate_tPS_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin 
     arb_test_on     = 1'b1;
     left_clk_first  = 1'b1;
     right_clk_first = 1'b0;
     tCCS_test       = TP.tCYC_min - 1;

     if((ileft_clk_period - TP.tPS +0.1) > tCCS_test)
     begin

       if(nmsg == 1'b1)$display("-------------------------------------------------------");
       if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
       if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
       if(nmsg == 1'b1)$display("--         Violating tPS and Left port               --");
       if(nmsg == 1'b1)$display("--                Comes First                        --");
       if(nmsg == 1'b1)$display("--             No tCCS violation                     --");
       if(nmsg == 1'b1)$display("--      BUSY# flag may or maynot generate            --");
       if(nmsg == 1'b1)$display("-------------------------------------------------------");
       
       arb_delay_left_right = ileft_clk_period - TP.tPS +0.1;

       configure_device_sdr2;
       inleft_ce0    = 1'b1;
       ileft_ce1     = 1'b0;
       inright_ce0   = 1'b1;
       iright_ce1    = 1'b0;
       counter_load_mode_l;
       counter_load_mode_r;
       master_reset;

       wait (onleft_ready == 1'b0);
       wait (onright_ready == 1'b0);
       @(posedge iright_clk);
       @(posedge ileft_clk);

       @(posedge ileft_clk);
       #(ileft_clk_period - TP.tSAC_l);
       byte_l = 8'b00000000;

       @(posedge iright_clk);
       #(iright_clk_period - TP.tSAC_r);
       byte_r = 8'b00000000;

       // Write data to memory location 0 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       enable_write_op_l;
       sdr_write_addr_l(0,data_l,byte_l);
     
       // Write data to memory location 4 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       enable_write_op_r;
       sdr_write_addr_r(4,data_r,byte_r);


       // Write data to memory location 1 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(1,data_l,byte_l);
     
       // Write data to memory location 3 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(3,data_r,byte_r);

       // Write data to memory location 2 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(2,data_l,byte_l);
     
       // Write data to memory location 2 from right port // Collission
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(2,data_r,byte_r);

       // Disable Write Operations    
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       inleft_ce0     = 1'b1;  

       @(posedge iright_clk);
       #(TP.tHAC_r);
       inright_ce0     = 1'b1;  

       // Checks the value in the content of the memory
       enable_read_op_l;
       inleft_ce0    = 1'b1;
       @(posedge ileft_clk);
       #(TP.tDC_l);
       inleft_ce0    = 1'b0;
       sdr_read_addr_l(2,byte_l);
       @(posedge ileft_clk);
       @(posedge ileft_clk);
       @(posedge ileft_clk);
       #(TP.tDC_l);
       sdr_compare_result_l(2,byte_l);
       inleft_ce0    = 1'b1;    
       ileft_ce1     = 1'b0;    

     end
     #100;
     arb_test_on = 1'b0;
     report_test_result("arb_test_w_w_violate_tPS_l");
   end
  endtask


  // Testcase for Arbitration when both 
  // Ports Writing the data to memory
  // Violating tPS and tCCS, Left   
  // port  Comes First         
  // BUSY# flag may or maynot generate  

  task arb_test_w_w_violate_tCCS_tPS_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin
	   
       arb_test_on     = 1'b1;
       left_clk_first  = 1'b1;
       right_clk_first = 1'b0;
       tCCS_test       = TP.tCYC_min - 1;

       configure_device_sdr2;
       inleft_ce0      = 1'b1;
       ileft_ce1       = 1'b0;
       inright_ce0     = 1'b1;
       iright_ce1      = 1'b0;
       #0;

       ileft_clk_period   = tCCS_test + TP.tPS - 0.2;
       iright_clk_period  = tCCS_test + TP.tPS - 0.2; 
	
       if(nmsg == 1'b1)$display("-------------------------------------------------------");
       if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
       if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
       if(nmsg == 1'b1)$display("--        Violating tPS and tCCS, Left               --");
       if(nmsg == 1'b1)$display("--             port  Comes First                     --");
       if(nmsg == 1'b1)$display("--      BUSY# flag may or maynot generate            --");
       if(nmsg == 1'b1)$display("-------------------------------------------------------");
       
       arb_delay_left_right = tCCS_test - 0.1;

       configure_device_sdr2;
       inleft_ce0    = 1'b1;
       ileft_ce1     = 1'b0;
       inright_ce0   = 1'b1;
       iright_ce1    = 1'b0;
       counter_load_mode_l;
       counter_load_mode_r;
       master_reset;

       wait (onleft_ready == 1'b0);
       wait (onright_ready == 1'b0);
       @(posedge iright_clk);
       @(posedge ileft_clk);

       @(posedge ileft_clk);
       #(ileft_clk_period - TP.tSAC_l);
       byte_l = 8'b00000000;

       @(posedge iright_clk);
       #(iright_clk_period - TP.tSAC_r);
       byte_r = 8'b00000000;

       // Write data to memory location 0 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       enable_write_op_l;
       sdr_write_addr_l(0,data_l,byte_l);
     
       // Write data to memory location 4 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       enable_write_op_r;
       sdr_write_addr_r(4,data_r,byte_r);


       // Write data to memory location 1 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(1,data_l,byte_l);
     
       // Write data to memory location 3 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(3,data_r,byte_r);

       // Write data to memory location 2 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(2,data_l,byte_l);
     
       // Write data to memory location 2 from right port // Collission
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(2,data_r,byte_r);

       // Disable Write Operations    
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       inleft_ce0     = 1'b1;  

       @(posedge iright_clk);
       #(TP.tHAC_r);
       inright_ce0     = 1'b1;  


       // Test for BUSY# assertion or de-assertion
       @(posedge ileft_clk);
       @(posedge ileft_clk);
       @(posedge ileft_clk);
       @(posedge ileft_clk);

       if((TP.tBSY_l + offset) < arb_delay_left_right)
       begin
         #(TP.tBSY_l + offset);
	 if(onleft_busy == 1'b0) begin
	   if(nmsg == 1'b1)$display("\n %10.2f Left Port BUSY Asserted",$realtime);
         end
         else 
	 begin
	   if(nmsg == 1'b1)$display("\n %10.2f Left Port BUSY# is not asserted",$realtime);
         end
	 @(posedge iright_clk);
	 #(TP.tBSY_r + offset);
	 if(onright_busy == 1'b0)
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Right Port BUSY Asserted\n ",$realtime);
         end
         else 
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Right Port BUSY# is not asserted\n ",$realtime);
         end
       end
       else
       begin
         @(posedge iright_clk);
	 #(TP.tBSY_l + offset - arb_delay_left_right);
	 if(onleft_busy == 1'b0) 
	 begin
	   if(nmsg == 1'b1)$display("\n %10.2f Left Port BUSY Asserted",$realtime);
         end
         else
         begin
	   if(nmsg == 1'b1)$display("\n %10.2f Left Port BUSY# is not asserted",$realtime);
         end

	 #(TP.tBSY_r + offset - (TP.tBSY_l + offset - arb_delay_left_right));
         if(onright_busy == 1'b0) 
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Right Port BUSY Asserted\n",$realtime);
         end
         else 
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Right Port BUSY# is not asserted\n",$realtime);
         end
       end	       

       inleft_ce0    = 1'b1;    
       ileft_ce1     = 1'b0;    

     #100;
     ileft_clk_period   = 10;
     iright_clk_period  = 10;    
     arb_test_on        = 1'b0;
     report_test_result("arb_test_w_w_violate_tCCS_tPS_l");
   end
  endtask


  // Testcase for Arbitration when both 
  // Ports Writing the data to memory  
  // Violating tCCS and Right port   
  // Comes First   No tPS Violation 

 task arb_test_w_w_violate_tCCS_r;

   reg [`CYP_DATAWIDTH-1:0] data_r;
   reg [`CYP_DATAWIDTH-1:0] data_l;
   begin 

    if(wmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
    if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
    if(nmsg == 1'b1)$display("--        Violating tCCS and Right port              --");
    if(nmsg == 1'b1)$display("--                Comes First                        --");
    if(nmsg == 1'b1)$display("--             No tPS Violation                      --");
    if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
    if(wmsg == 1'b1)$display("-------------------------------------------------------");

     arb_test_on          = 1'b1;
     right_clk_first      = 1'b1;
     left_clk_first       = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_right_left = TP.tCYC_min * 0.05; 

     configure_device_sdr2;
     inright_ce0 = 1'b1;
     iright_ce1  = 1'b0;
     inleft_ce0  = 1'b1;
     ileft_ce1   = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onright_ready == 1'b0);
     wait (onleft_ready  == 1'b0);
     @(posedge ileft_clk);
     @(posedge iright_clk);

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     // Write data to memory location 0 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.1; 
     enable_write_op_r;
     sdr_write_addr_r(0,data_r,byte_r);
     
     // Write data to memory location 4 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.1; 
     enable_write_op_l;
     sdr_write_addr_l(4,data_l,byte_l);

     // Write data to memory location 1 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.1; 
     sdr_write_addr_r(1,data_r,byte_r);
     
     // Write data to memory location 3 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.1; 
     sdr_write_addr_l(3,data_l,byte_l);

     // Write data to memory location 2 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.1; 
     sdr_write_addr_r(2,data_r,byte_r);
     
     // Write data to memory location 2 from left port // Collission
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.1; 
     sdr_write_addr_l(2,data_l,byte_l);

     // Disable Write Operations    
     @(posedge iright_clk);
     #0.1; 
     inright_ce0    = 1'b1;  

     @(posedge ileft_clk);
     #0.1; 
     inleft_ce0     = 1'b1;  


     // Test for BUSY# assertion
     fork
       busy_check_low_after_4_period_r;
       busy_check_low_after_4_period_l;
     join

     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_w_w_violate_tCCS_r");
   end
  endtask


  // Testcase for Arbitration when both
  // Ports Writing the data to memory 
  // Violating tPS and Right port 
  // Comes First. No tCCS violation
  // BUSY# flag may or maynot generate
  
  task arb_test_w_w_violate_tPS_r;

   reg [`CYP_DATAWIDTH-1:0] data_r;
   reg [`CYP_DATAWIDTH-1:0] data_l;
   begin 
     arb_test_on     = 1'b1;
     right_clk_first = 1'b1;
     left_clk_first  = 1'b0;
     tCCS_test       = TP.tCYC_min - 1;

     if((iright_clk_period - TP.tPS +0.1) > tCCS_test)
     begin

      if(nmsg == 1'b1)$display("-------------------------------------------------------");
      if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
      if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
      if(nmsg == 1'b1)$display("--        Violating tPS and Right port               --");
      if(nmsg == 1'b1)$display("--                Comes First                        --");
      if(nmsg == 1'b1)$display("--             No tCCS violation                     --");
      if(nmsg == 1'b1)$display("--      BUSY# flag may or maynot generate            --");
      if(nmsg == 1'b1)$display("-------------------------------------------------------");

       arb_delay_right_left = iright_clk_period - TP.tPS +0.1;

       configure_device_sdr2;
       inright_ce0  = 1'b1;
       iright_ce1   = 1'b0;
       inleft_ce0   = 1'b1;
       ileft_ce1    = 1'b0;
       counter_load_mode_l;
       counter_load_mode_r;
       master_reset;

       wait (onright_ready == 1'b0);
       wait (onleft_ready  == 1'b0);
       @(posedge ileft_clk);
       @(posedge iright_clk);

       @(posedge iright_clk);
       #(iright_clk_period - TP.tSAC_r);
       byte_r = 8'b00000000;

       @(posedge ileft_clk);
       #(ileft_clk_period - TP.tSAC_l);
       byte_l = 8'b00000000;

       // Write data to memory location 0 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       enable_write_op_r;
       sdr_write_addr_r(0,data_r,byte_r);
     
       // Write data to memory location 4 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       enable_write_op_l;
       sdr_write_addr_l(4,data_l,byte_l);


       // Write data to memory location 1 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(1,data_r,byte_r);
     
       // Write data to memory location 3 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(3,data_l,byte_l);

       // Write data to memory location 2 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(2,data_r,byte_r);
     
       // Write data to memory location 2 from left port // Collission
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(2,data_l,byte_l);

       // Disable Write Operations    
       @(posedge iright_clk);
       #(TP.tHAC_r);
       inright_ce0 = 1'b1;  

       @(posedge ileft_clk);
       #(TP.tHAC_l);
       inleft_ce0  = 1'b1;  


       // Checks the value in the content of the memory
       enable_read_op_r;
       inright_ce0 = 1'b1;
       @(posedge iright_clk);
       #(TP.tDC_r);
       inright_ce0 = 1'b0;
       sdr_read_addr_r(2,byte_r);
       @(posedge iright_clk);
       @(posedge iright_clk);
       @(posedge iright_clk);
       #(TP.tDC_r);
       sdr_compare_result_r(2,byte_r);
       inright_ce0 = 1'b1;    
       iright_ce1  = 1'b0;    

     end
     #100;    
     arb_test_on   = 1'b0;
     report_test_result("arb_test_w_w_violate_tPS_r");
   end
  endtask


  // Testcase for Arbitration when both 
  // Ports Writing the data to memory 
  // Violating tPS and tCCS, Rgiht  
  // port  Comes First    
  // BUSY# flag may or maynot generate

  task arb_test_w_w_violate_tCCS_tPS_r;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin 
     arb_test_on = 1'b1;
     left_clk_first = 1'b0;
     right_clk_first = 1'b1;
     tCCS_test   = TP.tCYC_min - 1;

       configure_device_sdr2;
       inleft_ce0    = 1'b1;
       ileft_ce1     = 1'b0;
       inright_ce0   = 1'b1;
       iright_ce1    = 1'b0;
       #0;

       ileft_clk_period   = tCCS_test + TP.tPS - 0.2;
       iright_clk_period  = tCCS_test + TP.tPS - 0.2; 
	
       if(nmsg == 1'b1)$display("-------------------------------------------------------");
       if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
       if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
       if(nmsg == 1'b1)$display("--       Violating tPS and tCCS, Rgiht               --");
       if(nmsg == 1'b1)$display("--             port  Comes First                     --");
       if(nmsg == 1'b1)$display("--      BUSY# flag may or maynot generate            --");
       if(nmsg == 1'b1)$display("-------------------------------------------------------");
       
       arb_delay_right_left = tCCS_test - 0.1;

       counter_load_mode_l;
       counter_load_mode_r;
       master_reset;

       wait (onleft_ready == 1'b0);
       wait (onright_ready == 1'b0);

       @(posedge ileft_clk);
       @(posedge iright_clk);

       @(posedge iright_clk);
       #(iright_clk_period - TP.tSAC_r);
       byte_r = 8'b00000000;

       @(posedge ileft_clk);
       #(ileft_clk_period - TP.tSAC_l);
       byte_l = 8'b00000000;

       // Write data to memory location 0 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       enable_write_op_r;
       sdr_write_addr_r(0,data_r,byte_r);
     
       // Write data to memory location 4 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       enable_write_op_l;
       sdr_write_addr_l(4,data_l,byte_l);


       // Write data to memory location 1 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(1,data_r,byte_r);
     
       // Write data to memory location 3 from left port
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(3,data_l,byte_l);

       // Write data to memory location 2 from right port
       randomdata_72bit(data_r);
       @(posedge iright_clk);
       #(TP.tHAC_r);
       sdr_write_addr_r(2,data_r,byte_r);
     
       // Write data to memory location 2 from left port // Collission
       randomdata_72bit(data_l);
       @(posedge ileft_clk);
       #(TP.tHAC_l);
       sdr_write_addr_l(2,data_l,byte_l);

       // Disable Write Operations    
       @(posedge iright_clk);
       #(TP.tHAC_r);
       inright_ce0     = 1'b1;  

       @(posedge ileft_clk);
       #(TP.tHAC_l);
       inleft_ce0     = 1'b1;  


       // Test for BUSY# assertion or de-assertion

       @(posedge iright_clk);
       @(posedge iright_clk);
       @(posedge iright_clk);
       @(posedge iright_clk);

       if((TP.tBSY_r + offset) < arb_delay_right_left)
       begin
         #(TP.tBSY_r + offset);
         if(onright_busy == 1'b0)  
	 begin
	   if(nmsg == 1'b1)$display("\n %10.2f Right Port BUSY Asserted",$realtime);
         end
         else 
	 begin
	   if(nmsg == 1'b1)$display("\n %10.2f Right Port BUSY# is not asserted",$realtime);
         end

	 @(posedge ileft_clk);
	 #(TP.tBSY_l + offset);
	 if(onleft_busy == 1'b0)
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Left Port BUSY Asserted\n ",$realtime);
         end
         else 
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Left Port BUSY# is not asserted\n ",$realtime);
	 end
       end
       else
       begin
         @(posedge ileft_clk);
	 #(TP.tBSY_r + offset - arb_delay_right_left);
	 if(onright_busy == 1'b0) 
	 begin
	   if(nmsg == 1'b1)$display("\n %10.2f Right Port BUSY Asserted",$realtime);
	 end
         else 
	 begin
	   if(nmsg == 1'b1)$display("\n %10.2f Right Port BUSY# is not asserted",$realtime);
	 end

	 #(TP.tBSY_l + offset - (TP.tBSY_r + offset - arb_delay_right_left));
         if(onleft_busy == 1'b0) 
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Left Port BUSY Asserted\n",$realtime);
	 end
         else 
	 begin
	   if(nmsg == 1'b1)$display("%10.2f Left Port BUSY# is not asserted\n",$realtime);
	 end
       end	       

       inright_ce0    = 1'b1;    
       iright_ce1     = 1'b0;    

     #100;    
     arb_test_on = 1'b0;

     ileft_clk_period  = 10;
     iright_clk_period = 10;
     report_test_result("arb_test_w_w_violate_tCCS_tPS_r");
   end
  endtask


  // Testcase for Arbitration when Left Port
  // Reading and Right port Writing 
  // Violating tCCS and Left port 
  // Comes First 

  task arb_test_r_w_violate_tCCS_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin 

    if(nmsg == 1'b1)$display("-----------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration when Left Port      --");
    if(nmsg == 1'b1)$display("--        Reading and Right port Writing           --");
    if(nmsg == 1'b1)$display("--         Violating tCCS and Left port            --");
    if(nmsg == 1'b1)$display("--                 Comes First                     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------");

     arb_test_on          = 1'b1;
     left_clk_first       = 1'b1;
     right_clk_first      = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_left_right = tCCS_test - 0.1;

     configure_device_sdr2;
     inleft_ce0     = 1'b1;
     ileft_ce1      = 1'b0;
     inright_ce0    = 1'b1;
     iright_ce1     = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onleft_ready  == 1'b0);
     wait (onright_ready == 1'b0);
     @(posedge iright_clk);
     @(posedge ileft_clk);

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     // Write Random data to memory 0 to 4 from left side
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     enable_write_op_l;
     sdr_write_addr_l(0,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(1,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(2,data_l,byte_l);

     
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(3,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(4,data_l,byte_l);

     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0     = 1'b1;
     ileft_ce1      = 1'b0;
     @(posedge ileft_clk);
     @(posedge ileft_clk);

     
     // Enable Read operation from Left side and Write from Right side

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;
  
     // Read data from memory location 0 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     enable_read_op_l;
     sdr_read_addr_l(0,byte_l);

     // Write data to memory location 4 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     enable_write_op_r;
     sdr_write_addr_r(4,data_r,byte_r);

     // Read data from memory location 1 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     sdr_read_addr_l(1,byte_l);

     // Write data to memory location 3 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(3,data_r,byte_r);

     // Read data from memory location 2 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     sdr_read_addr_l(2,byte_l);

     // Write data to memory location 2 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(2,data_r,byte_r);  // Collission

     // Disable Read and Write Operations    
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0  = 1'b1;  

     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0 = 1'b1;  

     fork
       busy_check_low_after_4_period_l;
       busy_check_high_after_4_period_r;
     join
       
     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_r_w_violate_tCCS_l");
   end
  endtask


  // Testcase for Arbitration when right Port
  // Reading and left port Writing 
  // Violating tCCS and right port
  // Comes First 

  task arb_test_r_w_violate_tCCS_r;

   reg [`CYP_DATAWIDTH-1:0] data_r;
   reg [`CYP_DATAWIDTH-1:0] data_l;
   begin 

    if(nmsg == 1'b1)$display("-----------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration when right Port     --");
    if(nmsg == 1'b1)$display("--         Reading and left port Writing           --");
    if(nmsg == 1'b1)$display("--         Violating tCCS and right port           --");
    if(nmsg == 1'b1)$display("--                 Comes First                     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------");

     arb_test_on          = 1'b1;
     right_clk_first      = 1'b1;
     left_clk_first       = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_right_left = tCCS_test - 0.1;

     configure_device_sdr2;
     inright_ce0     = 1'b1;
     iright_ce1      = 1'b0;
     inleft_ce0      = 1'b1;
     ileft_ce1       = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onright_ready == 1'b0);
     wait (onleft_ready  == 1'b0);
     @(posedge ileft_clk);
     @(posedge iright_clk);

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     // Write Random data to memory 0 to 4 from right side
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     enable_write_op_r;
     sdr_write_addr_r(0,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(1,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(2,data_r,byte_r);

     
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(3,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(4,data_r,byte_r);

     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0     = 1'b1;
     iright_ce1      = 1'b0;
     @(posedge iright_clk);
     @(posedge iright_clk);

     
     // Enable Read operation from right side and Write from left side

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;
  
     // Read data from memory location 0 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     enable_read_op_r;
     sdr_read_addr_r(0,byte_r);

     // Write data to memory location 4 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     enable_write_op_l;
     sdr_write_addr_l(4,data_l,byte_l);

     // Read data from memory location 1 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     sdr_read_addr_r(1,byte_r);

     // Write data to memory location 3 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(3,data_l,byte_l);

     // Read data from memory location 2 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     sdr_read_addr_r(2,byte_r);

     // Write data to memory location 2 from Left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(2,data_l,byte_l);  // Collission

     // Disable Read and Write Operations    
     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0 = 1'b1;  

     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0  = 1'b1;  

     fork 
       busy_check_low_after_4_period_r;
       busy_check_high_after_4_period_l;
     join

     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_r_w_violate_tCCS_r");
   end
  endtask


  // Testcase for Arbitration when left Port 
  // Writing and Right port Reading 
  // Violating tCCS and left port 
  // Comes First
     
  task arb_test_w_r_violate_tCCS_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin 

    if(nmsg == 1'b1)$display("-----------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration when left Port      --");
    if(nmsg == 1'b1)$display("--         Writing and Right port Reading          --");
    if(nmsg == 1'b1)$display("--          Violating tCCS and left port           --");
    if(nmsg == 1'b1)$display("--                 Comes First                     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------");

     arb_test_on          = 1'b1;
     left_clk_first       = 1'b1;
     right_clk_first      = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_left_right = tCCS_test - 0.1;

     configure_device_sdr2;
     inleft_ce0     = 1'b1;
     ileft_ce1      = 1'b0;
     inright_ce0    = 1'b1;
     iright_ce1     = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onleft_ready  == 1'b0);
     wait (onright_ready == 1'b0);
     @(posedge iright_clk);
     @(posedge ileft_clk);

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     // Write Random data to memory 0 to 4 from left side
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     enable_write_op_l;
     sdr_write_addr_l(0,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(1,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(2,data_l,byte_l);
   
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(3,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(4,data_l,byte_l);

     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0     = 1'b1;
     ileft_ce1      = 1'b0;
     @(posedge ileft_clk);
     @(posedge ileft_clk);

     
     // Enable Write operation from left side and Read from right side

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;
  
     // Write data from memory location 0 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     enable_write_op_l;
     sdr_write_addr_l(0,data_l,byte_l);

     // Read data to memory location 4 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     enable_read_op_r;
     sdr_read_addr_r(4,byte_r);

     // Write data from memory location 1 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(1,data_l,byte_l);

     // Read data to memory location 3 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     sdr_read_addr_r(3,byte_r);

     // Write data from memory location 2 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(2,data_l,byte_l);

     // Read data to memory location 2 from right port   // Collission
     @(posedge iright_clk);
     #(TP.tDC_r);
     sdr_read_addr_r(2,byte_r);  

     // Disable Read and Write Operations    
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0  = 1'b1;  

     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0 = 1'b1;  
     
     fork
       busy_check_low_after_4_period_r;
       busy_check_high_after_4_period_l;
     join

     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_w_r_violate_tCCS_l");
   end
  endtask


  // Testcase for Arbitration when right Port
  // Writing and left port Reading
  // Violating tCCS and right port 
  // Comes First

  task arb_test_w_r_violate_tCCS_r;

   reg [`CYP_DATAWIDTH-1:0] data_r;
   reg [`CYP_DATAWIDTH-1:0] data_l;
   begin 

    if(nmsg == 1'b1)$display("-----------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration when right Port     --");
    if(nmsg == 1'b1)$display("--         Writing and left port Reading           --");
    if(nmsg == 1'b1)$display("--         Violating tCCS and right port           --");
    if(nmsg == 1'b1)$display("--                 Comes First                     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------");

     arb_test_on          = 1'b1;
     right_clk_first      = 1'b1;
     left_clk_first       = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_right_left = tCCS_test - 0.1;

     configure_device_sdr2;
     inright_ce0     = 1'b1;
     iright_ce1      = 1'b0;
     inleft_ce0      = 1'b1;
     ileft_ce1       = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onright_ready == 1'b0);
     wait (onleft_ready  == 1'b0);
     @(posedge ileft_clk);
     @(posedge iright_clk);

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     // Write Random data to memory 0 to 4 from right side
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     enable_write_op_r;
     sdr_write_addr_r(0,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(1,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(2,data_r,byte_r);
   
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(3,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(4,data_r,byte_r);

     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0     = 1'b1;
     iright_ce1      = 1'b0;
     @(posedge iright_clk);
     @(posedge iright_clk);

     
     // Enable Write operation from right side and Read from left side

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;
  
     // Write data from memory location 0 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     enable_write_op_r;
     sdr_write_addr_r(0,data_r,byte_r);

     // Read data to memory location 4 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     enable_read_op_l;
     sdr_read_addr_l(4,byte_l);

     // Write data from memory location 1 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(1,data_r,byte_r);

     // Read data to memory location 3 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     sdr_read_addr_l(3,byte_l);

     // Write data from memory location 2 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(2,data_r,byte_r);

     // Read data to memory location 2 from left port   // Collission
     @(posedge ileft_clk);
     #(TP.tDC_l);
     sdr_read_addr_l(2,byte_l);  

     // Disable Read and Write Operations    
     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0 = 1'b1;  

     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0  = 1'b1;  
     
     fork
       busy_check_low_after_4_period_l;
       busy_check_high_after_4_period_r;
     join

     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_w_r_violate_tCCS_r");
   end
  endtask



  // Testcase for Arbitration when Left Port
  // Reading and  Right port Writing 
  // With no violation and Left port
  // Comes First  

  task arb_test_r_w_no_violation_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin 

    if(nmsg == 1'b1)$display("-----------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration when Left Port      --");
    if(nmsg == 1'b1)$display("--        Reading and  Right port Writing          --");
    if(nmsg == 1'b1)$display("--        With no violation and Left port          --");
    if(nmsg == 1'b1)$display("--                 Comes First                     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------");

     arb_test_on          = 1'b1;
     left_clk_first       = 1'b1;
     right_clk_first      = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_left_right = tCCS_test + 0.1;

     configure_device_sdr2;
     inleft_ce0     = 1'b1;
     ileft_ce1      = 1'b0;
     inright_ce0    = 1'b1;
     iright_ce1     = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onleft_ready  == 1'b0);
     wait (onright_ready == 1'b0);
     @(posedge iright_clk);
     @(posedge ileft_clk);

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     // Write Random data to memory 0 to 4 from left side
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     enable_write_op_l;
     sdr_write_addr_l(0,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(1,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(2,data_l,byte_l);

     
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(3,data_l,byte_l);

     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(4,data_l,byte_l);

     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0     = 1'b1;
     ileft_ce1      = 1'b0;
     @(posedge ileft_clk);
     @(posedge ileft_clk);

     
     // Enable Read operation from Left side and Write from Right side

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;
  
     // Read data from memory location 0 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     enable_read_op_l;
     sdr_read_addr_l(0,byte_l);

     // Write data to memory location 4 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     enable_write_op_r;
     sdr_write_addr_r(4,data_r,byte_r);

     // Read data from memory location 1 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     sdr_read_addr_l(1,byte_l);

     // Write data to memory location 3 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(3,data_r,byte_r);

     // Read data from memory location 2 from left port
     @(posedge ileft_clk);
     #(TP.tDC_l);
     sdr_read_addr_l(2,byte_l);

     // Write data to memory location 2 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(2,data_r,byte_r);

     // Disable Read and Write Operations  
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0     = 1'b1;  

     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0     = 1'b1;  

     fork
       busy_check_high_after_4_period_l;
       busy_check_high_after_4_period_r;
     join
   

     // Checks the value in the content of the memory
       enable_read_op_l;
       inleft_ce0    = 1'b1;
       @(posedge ileft_clk);
       #(TP.tDC_l);
       inleft_ce0    = 1'b0;
       sdr_read_addr_l(2,byte_l);
       @(posedge ileft_clk);
       @(posedge ileft_clk);
       @(posedge ileft_clk);
       @(posedge ileft_clk);
       #(TP.tDC_l);
       sdr_compare_result_l(2,byte_l);
       inleft_ce0    = 1'b1;    
       ileft_ce1     = 1'b0;  
 
     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_r_w_no_violation_l");
   end
  endtask


  // Testcase for Arbitration when Right Port
  // Reading and  Left port Writing 
  // With no violation and Right port 
  // Comes First  

  task arb_test_r_w_no_violation_r;

   reg [`CYP_DATAWIDTH-1:0] data_r;
   reg [`CYP_DATAWIDTH-1:0] data_l;
   begin 

    if(nmsg == 1'b1)$display("-----------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration when Right Port      --");
    if(nmsg == 1'b1)$display("--        Reading and  Left port Writing          --");
    if(nmsg == 1'b1)$display("--        With no violation and Right port          --");
    if(nmsg == 1'b1)$display("--                 Comes First                     --");
    if(nmsg == 1'b1)$display("-----------------------------------------------------");

     arb_test_on          = 1'b1;
     right_clk_first      = 1'b1;
     left_clk_first       = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_right_left = tCCS_test + 0.1;

     configure_device_sdr2;
     inright_ce0   = 1'b1;
     iright_ce1    = 1'b0;
     inleft_ce0    = 1'b1;
     ileft_ce1     = 1'b0;
     counter_load_mode_l;
     counter_load_mode_r;
     master_reset;

     wait (onright_ready == 1'b0);
     wait (onleft_ready  == 1'b0);
     @(posedge ileft_clk);
     @(posedge iright_clk);

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     // Write Random data to memory 0 to 4 from right side
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     enable_write_op_r;
     sdr_write_addr_r(0,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(1,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(2,data_r,byte_r);

     
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(3,data_r,byte_r);

     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #(TP.tHAC_r);
     sdr_write_addr_r(4,data_r,byte_r);

     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0     = 1'b1;
     iright_ce1      = 1'b0;
     @(posedge iright_clk);
     @(posedge iright_clk);

     
     // Enable Read operation from Right side and Write from Left side

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;
  
     // Read data from memory location 0 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     enable_read_op_r;
     sdr_read_addr_r(0,byte_r);

     // Write data to memory location 4 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     enable_write_op_l;
     sdr_write_addr_l(4,data_l,byte_l);

     // Read data from memory location 1 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     sdr_read_addr_r(1,byte_r);

     // Write data to memory location 3 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(3,data_l,byte_l);

     // Read data from memory location 2 from right port
     @(posedge iright_clk);
     #(TP.tDC_r);
     sdr_read_addr_r(2,byte_r);

     // Write data to memory location 2 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #(TP.tHAC_l);
     sdr_write_addr_l(2,data_l,byte_l);

     // Disable Read and Write Operations  
     @(posedge iright_clk);
     #(TP.tHAC_r);
     inright_ce0     = 1'b1;  

     @(posedge ileft_clk);
     #(TP.tHAC_l);
     inleft_ce0     = 1'b1;  

     fork
       busy_check_high_after_4_period_r;
       busy_check_high_after_4_period_l;
     join
   

     // Checks the value in the content of the memory
       enable_read_op_r;
       inright_ce0    = 1'b1;
       @(posedge iright_clk);
       #(TP.tDC_r);
       inright_ce0    = 1'b0;
       sdr_read_addr_r(2,byte_r);
       @(posedge iright_clk);
       @(posedge iright_clk);
       @(posedge iright_clk);
       @(posedge iright_clk);
       #(TP.tDC_r);
       sdr_compare_result_r(2,byte_r);
       inright_ce0    = 1'b1;    
       iright_ce1     = 1'b0;  
 
     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_r_w_no_violation_r");
   end
  endtask


