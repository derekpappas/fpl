 
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
// File          : testcase_arb_flow_through.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases to verify the Arbitration function in flow through mode 
// 
// *******************************************************************

      
  // Testcase for Arbitration when both 
  // Ports Writing the data to memory  
  // violating tCCS and Left port Comes
  // First.  No tPS Violation    
  // Both ports in Flow through mode 

  task arb_test_w_w_violate_tCCS_flow_throgh_l;

   reg [`CYP_DATAWIDTH-1:0] data_l;
   reg [`CYP_DATAWIDTH-1:0] data_r;
   integer count_loop;

   begin 

    arb_test_on          = 1'b1;
    left_clk_first       = 1'b1;
    right_clk_first      = 1'b0;
    ileft_ddron          = 1'b0;
    ileft_portstd        = 1'b1;
    iright_ddron         = 1'b0;
    iright_portstd       = 1'b1;
    tCCS_test            = TP.tCYC_min - 1;
    arb_delay_left_right = TP.tCYC_min * 0.05;  
    
    for(count_loop = 0; count_loop <=1; count_loop = count_loop + 1)
    begin

    case (count_loop)
      0: 
      begin
        ileft_ftsel  = 1'b0;
	iright_ftsel = 1'b0;
	ileft_clk_period_old  = ileft_clk_period;
        ileft_clk_period      = TP.tCYC_FT_min;
        iright_clk_period_old = iright_clk_period;
        iright_clk_period     = TP.tCYC_FT_min;
    
        if(wmsg == 1'b1)$display("-------------------------------------------------------");
        if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
        if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
        if(nmsg == 1'b1)$display("--     violating tCCS and Left port Comes            --");
        if(nmsg == 1'b1)$display("--          First.  No tPS Violation                 --");
        if(nmsg == 1'b1)$display("--      Both ports in Flow through mode              --");
	if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
        if(wmsg == 1'b1)$display("-------------------------------------------------------");
      end

      //1: 
      //begin
      //  ileft_ftsel  = 1'b1;
      //  iright_ftsel = 1'b0;
      //  ileft_clk_period_old  = ileft_clk_period;
      //  ileft_clk_period      = TP.tCYC_min;
      //  iright_clk_period_old = iright_clk_period;
      //  iright_clk_period     = TP.tCYC_FT_min;
    
      //  if(wmsg == 1'b1)$display("-------------------------------------------------------");
      //  if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
      //  if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
      //  if(nmsg == 1'b1)$display("--     violating tCCS and Left port Comes            --");
      //  if(nmsg == 1'b1)$display("--          First.  No tPS Violation                 --");
      //  if(nmsg == 1'b1)$display("-- Left port pipeline and Right in Flow through mode --");
      //  if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
      //  if(wmsg == 1'b1)$display("-------------------------------------------------------");
     //end

      //2: 
      //begin
      //  ileft_ftsel  = 1'b0;
      //  iright_ftsel = 1'b1;
      //  ileft_clk_period_old  = ileft_clk_period;
      //  ileft_clk_period      = TP.tCYC_FT_min;
      //  iright_clk_period_old = iright_clk_period;
      //  iright_clk_period     = TP.tCYC_min;
    
      //  if(wmsg == 1'b1)$display("-------------------------------------------------------");
      //  if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
      //  if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
      //  if(nmsg == 1'b1)$display("--     violating tCCS and Left port Comes            --");
      //  if(nmsg == 1'b1)$display("--          First.  No tPS Violation                 --");
      //  if(nmsg == 1'b1)$display("-- Right port pipeline and Left in Flow through mode --");
      //  if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
      //  if(wmsg == 1'b1)$display("-------------------------------------------------------");
     //end

      1: 
      begin
        ileft_ftsel  = 1'b1;
	iright_ftsel = 1'b1;
	ileft_clk_period_old  = ileft_clk_period;
        ileft_clk_period      = TP.tCYC_min;
        iright_clk_period_old = iright_clk_period;
        iright_clk_period     = TP.tCYC_min;
        if(wmsg == 1'b1)$display("-------------------------------------------------------");
        if(nmsg == 1'b1)$display("--     Testcase for Arbitration when both            --");
        if(nmsg == 1'b1)$display("--      Ports Writing the data to memory             --");
        if(nmsg == 1'b1)$display("--     violating tCCS and Left port Comes            --");
        if(nmsg == 1'b1)$display("--          First.  No tPS Violation                 --");
        if(nmsg == 1'b1)$display("--         Both ports in Pipeline mode               --");
	if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
        if(wmsg == 1'b1)$display("-------------------------------------------------------");
      end
    endcase
	    
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
     inleft_ce0  = 1'b1;  

     @(posedge iright_clk);
     #0.1; 
     inright_ce0 = 1'b1;  


     // Test for BUSY# assertion
     fork
       busy_check_low_after_4_period_l;
       busy_check_low_after_4_period_r;
     join

     ileft_clk_period   = ileft_clk_period_old;
     iright_clk_period  = iright_clk_period_old;

    end
     arb_test_on = 1'b0;
     report_test_result("arb_test_w_w_violate_tCCS_flow_throgh_l");
   end
  endtask

