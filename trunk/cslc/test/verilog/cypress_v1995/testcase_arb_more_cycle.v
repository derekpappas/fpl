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
// File          : testcase_arb_more_cycle.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases to verify the Arbitration function when when the collision
// occurs more than one cycles 
// *******************************************************************


  // Testcase  for  Arbitration when both Ports
  // Writing the data to memory  Violating tCCS 
  // and Left port Comes  First. Arbitration    
  // (collission) happens for more than one cycle
 
  task arb_test_long_time_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   begin 

    if(wmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase  for  Arbitration when both Ports     --");
    if(nmsg == 1'b1)$display("--    Writing the data to memory  Violating tCCS     --");
    if(nmsg == 1'b1)$display("--    and Left port Comes  First. Arbitration        --");
    if(nmsg == 1'b1)$display("--   (collission) happens for more than one cycle    --");
    if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
    if(wmsg == 1'b1)$display("-------------------------------------------------------");

     arb_test_on          = 1'b1;
     left_clk_first       = 1'b1;
     right_clk_first      = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_left_right = TP.tCYC_min * 0.05; 

     configure_device_sdr2;
     inleft_ce0     = 1'b0;
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

     @(posedge iright_clk);
     #(iright_clk_period - TP.tSAC_r);
     byte_r = 8'b00000000;

     // Write data to memory location 0 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     enable_write_op_l;
     sdr_write_addr_l(0,data_l,byte_l);
     
     // Write data to memory location 4 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     enable_write_op_r;
     sdr_write_addr_r(4,data_r,byte_r);


     // Write data to memory location 1 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(1,data_l,byte_l);
     
     // Write data to memory location 3 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(3,data_r,byte_r);

     // Write data to memory location 2 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(2,data_l,byte_l);
     
     // Write data to memory location 2 from right port // Collission
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(2,data_r,byte_r);
     
     // Write data to memory location 3 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(3,data_l,byte_l);
     
     // Write data to memory location 3 from right port // Collission
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(3,data_r,byte_r);
     
     // Write data to memory location 4 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(4,data_l,byte_l);
     
     // Write data to memory location 4 from right port // Collission
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(4,data_r,byte_r);
     
     // Write data to memory location 5 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(5,data_l,byte_l);
     
     // Write data to memory location 5 from right port // Collission
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(5,data_r,byte_r);
     
     // Write data to memory location 6 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(6,data_l,byte_l);
     @(posedge iright_clk);
     #0.001;

     // Write data to memory location 6 from right port // Collission
     randomdata_72bit(data_r);
     sdr_write_addr_r(6,data_r,byte_r);
     @(posedge ileft_clk);
     #0.001;
     
     // Write data to memory location 7 from left port
     randomdata_72bit(data_l);
     sdr_write_addr_l(7,data_l,byte_l);
     ->busy_check_low_l;
     @(posedge iright_clk);
     #0.001;
     
     // Write data to memory location 7 from right port // Collission
     randomdata_72bit(data_r);
     sdr_write_addr_r(7,data_r,byte_r);
     ->busy_check_low_r;
     @(posedge ileft_clk);
     #0.001;

     // Disable Write Operations    
     inleft_ce0     = 1'b1;
     ->busy_check_low_l;
     @(posedge iright_clk);
     #0.001;

     inright_ce0     = 1'b1;
     ->busy_check_low_r;    
     @(posedge ileft_clk);

     ->busy_check_low_l;
     @(posedge iright_clk);

     ->busy_check_low_r;     
     @(posedge ileft_clk);
     
     ->busy_check_low_l;
     @(posedge iright_clk);
     
     ->busy_check_low_r;
     @(posedge ileft_clk);
     
     ->busy_check_low_l;
     @(posedge iright_clk);
     
     ->busy_check_low_r;     
     @(posedge ileft_clk);

     ->busy_check_low_l;
     @(posedge iright_clk);
     
     ->busy_check_low_r;     
     @(posedge ileft_clk);

     #(TP.tBSY_l + offset);
     if(onleft_busy == 1'b1) begin 
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST PASSED:Left Port BUSY# is de-asserted",$realtime);
     end 
     else 
     begin 
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST FAILED:Left Port BUSY# is not de-asserted",$realtime);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
     end

     //@(posedge iright_clk);
     //#(TP.tBSY_r + offset);
     #(arb_delay_left_right); 
     if(onright_busy == 1'b1) begin 
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST PASSED:Right Port BUSY# is de-asserted",$realtime);
     end 
     else
     begin
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST FAILED:Right Port BUSY# not de-asserted",$realtime);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
     end
       
     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_long_time_l");
   end
  endtask
  
  
  // Testcase  for  Arbitration when both Ports  
  // Writing the data to memory  Violating tCCS  
  // and Right port Comes  First. Arbitration   
  // (collission) happens for more than one cycle 
 
  task arb_test_long_time_r;

   reg [`CYP_DATAWIDTH-1:0] data_r;
   reg [`CYP_DATAWIDTH-1:0] data_l;
   begin 

    if(wmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase  for  Arbitration when both Ports     --");
    if(nmsg == 1'b1)$display("--    Writing the data to memory  Violating tCCS     --");
    if(nmsg == 1'b1)$display("--    and Right port Comes  First. Arbitration       --");
    if(nmsg == 1'b1)$display("--   (collission) happens for more than one cycle    --");
    if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
    if(wmsg == 1'b1)$display("-------------------------------------------------------");

     arb_test_on          = 1'b1;
     right_clk_first      = 1'b1;
     left_clk_first       = 1'b0;
     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_right_left = TP.tCYC_min * 0.05; 

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

     @(posedge ileft_clk);
     #(ileft_clk_period - TP.tSAC_l);
     byte_l = 8'b00000000;

     // Write data to memory location 0 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     enable_write_op_r;
     sdr_write_addr_r(0,data_r,byte_r);
     
     // Write data to memory location 4 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     enable_write_op_l;
     sdr_write_addr_l(4,data_l,byte_l);


     // Write data to memory location 1 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(1,data_r,byte_r);
     
     // Write data to memory location 3 from left port
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(3,data_l,byte_l);

     // Write data to memory location 2 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(2,data_r,byte_r);
     
     // Write data to memory location 2 from left port // Collission
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(2,data_l,byte_l);
     
     // Write data to memory location 3 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(3,data_r,byte_r);
     
     // Write data to memory location 3 from left port // Collission
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(3,data_l,byte_l);
     
     // Write data to memory location 4 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(4,data_r,byte_r);
     
     // Write data to memory location 4 from left port // Collission
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(4,data_l,byte_l);
     
     // Write data to memory location 5 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(5,data_r,byte_r);
     
     // Write data to memory location 5 from left port // Collission
     randomdata_72bit(data_l);
     @(posedge ileft_clk);
     #0.001;
     sdr_write_addr_l(5,data_l,byte_l);
     
     // Write data to memory location 6 from right port
     randomdata_72bit(data_r);
     @(posedge iright_clk);
     #0.001;
     sdr_write_addr_r(6,data_r,byte_r);
     
     @(posedge ileft_clk);
     #0.001;
     
     // Write data to memory location 6 from left port // Collission
     randomdata_72bit(data_l);
     sdr_write_addr_l(6,data_l,byte_l);
     @(posedge iright_clk);
     #0.001;
     
     // Write data to memory location 7 from right port
     randomdata_72bit(data_r);
     sdr_write_addr_r(7,data_r,byte_r);

     ->busy_check_low_r;
     @(posedge ileft_clk);
     #0.001;
     
     // Write data to memory location 7 from left port // Collission
     randomdata_72bit(data_l);
     sdr_write_addr_l(7,data_l,byte_l);

     ->busy_check_low_l;
     @(posedge iright_clk);
     #0.001;
     // Disable Write Operations    
     inright_ce0     = 1'b1;

     ->busy_check_low_r;
     @(posedge ileft_clk);
     #0.001;
     inleft_ce0     = 1'b1;
     ->busy_check_low_l;
     @(posedge iright_clk);
     ->busy_check_low_r;
     @(posedge ileft_clk);
     ->busy_check_low_l;
     @(posedge iright_clk);
    
     ->busy_check_low_r;
     @(posedge ileft_clk);
     
     ->busy_check_low_l;
     @(posedge iright_clk);
     
     ->busy_check_low_r;
     @(posedge ileft_clk);

     ->busy_check_low_l;
     @(posedge iright_clk);

     ->busy_check_low_r;
     @(posedge ileft_clk);

     ->busy_check_low_l;
     @(posedge iright_clk);

     #(TP.tBSY_r + offset);
     if(onright_busy == 1'b1) begin 
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST PASSED:Right Port BUSY# is de-asserted",$realtime);
     end 
     else 
     begin 
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST FAILED:Right Port BUSY# is not de-asserted",$realtime);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
     end

     //@(posedge ileft_clk);
     //#(TP.tBSY_l + offset);
     #(arb_delay_right_left); 
     if(onleft_busy == 1'b1) begin 
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST PASSED:Left Port BUSY# is de-asserted",$realtime);
     end 
     else
     begin
       if(nmsg == 1'b1)$display("%10.2f ARBITRATION TEST FAILED:Left Port BUSY# not de-asserted",$realtime);
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
     end
       
     #100;    
     arb_test_on = 1'b0;
     report_test_result("arb_test_long_time_l");
   end
  endtask
  

