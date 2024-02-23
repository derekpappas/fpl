 
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
// File          : testcase_arb_ddr.v 
// Author        : 
// Author's Email: 
// Date          : 23 MAR 2005
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcases to verify the Arbitration function when both the ports 
// are configured in DDR mode
// *******************************************************************


  // Testcase for Arbitration  when both Ports  
  // Writing the data to memory Violating tCCS  
  // and Left port Comes First. Both Ports  
  // Configured in DDR mode. No tPS Violation
    
  task arb_test_w_ddr_w_ddr_violate_tCCS_l;

   `ifdef DDR
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_r;
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_r;
   `else
     reg [`CYP_DATAWIDTH   - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
   `endif
  
   begin   
 
    if(wmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration  when both Ports      --");
    if(nmsg == 1'b1)$display("--    Writing the data to memory Violating tCCS      --");
    if(nmsg == 1'b1)$display("--      and Left port Comes First. Both Ports        --");
    if(nmsg == 1'b1)$display("--             Configured in DDR mode                --");
    if(nmsg == 1'b1)$display("--               No tPS Violation                    --");
    if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
    if(wmsg == 1'b1)$display("-------------------------------------------------------");

     arb_test_on          = 1'b1;
     left_clk_first       = 1'b1;
     right_clk_first      = 1'b0;

     ileft_ftsel    = 1'b1;
     ileft_ddron    = 1'b1;
     ileft_portstd  = 1'b1;
     iright_ftsel   = 1'b1;
     iright_ddron   = 1'b1;
     iright_portstd = 1'b1;

     inleft_ce0     = 1'b1;
     ileft_ce1      = 1'b0;
     inright_ce0    = 1'b1;
     iright_ce1     = 1'b0;
     a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
     a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
     ileft_clk_period_old  = ileft_clk_period;
     ileft_clk_period      = TP.tCYC_min;
     iright_clk_period_old = iright_clk_period;
     iright_clk_period     = TP.tCYC_min;

     tCCS_test            = TP.tCYC_min - 1;
     arb_delay_left_right = TP.tCYC_min * 0.05; 
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
     @(negedge ileft_clk);  
     enable_write_op_l;
     data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
     data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
     ddr_write_addr_l(0,data_temp1_l,byte_l);
     randomdata_72bit(data_l);
     
     // Write data to memory location 4 from right port
     randomdata_72bit(data_r);
     @(negedge iright_clk);  
     enable_write_op_r;
     data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
     data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
     ddr_write_addr_r(4,data_temp1_r,byte_r);
     
     // Write data to memory location 0 from left port
     @(posedge ileft_clk);
     ddr_write_addr_l(0,data_temp2_l,byte_l);
     
     // Write data to memory location 4 from right port
     @(posedge iright_clk);
     ddr_write_addr_r(4,data_temp2_r,byte_r);


     // Write data to memory location 1 from left port 
     randomdata_72bit(data_l);
     @(negedge ileft_clk);  
     data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
     data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
     ddr_write_addr_l(1,data_temp1_l,byte_l);
     randomdata_72bit(data_l);
     
     // Write data to memory location 3 from right port
     randomdata_72bit(data_r);
     @(negedge iright_clk);  
     enable_write_op_r;
     data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
     data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
     ddr_write_addr_r(3,data_temp1_r,byte_r);
     
     // Write data to memory location 1 from left port
     @(posedge ileft_clk);
     ddr_write_addr_l(1,data_temp2_l,byte_l);
     
     // Write data to memory location 3 from right port
     @(posedge iright_clk);
     ddr_write_addr_r(3,data_temp2_r,byte_r);

     // Write data to memory location 2 from left port 
     randomdata_72bit(data_l);
     @(negedge ileft_clk);  
     enable_write_op_l;
     data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
     data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
     ddr_write_addr_l(2,data_temp1_l,byte_l);
     randomdata_72bit(data_l);
     
     // Write data to memory location 2 from right port
     randomdata_72bit(data_r);
     @(negedge iright_clk);  
     enable_write_op_r;
     data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
     data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
     ddr_write_addr_r(2,data_temp1_r,byte_r);
     
     // Write data to memory location 2 from left port
     @(posedge ileft_clk);
     ddr_write_addr_l(2,data_temp2_l,byte_l);
     
     // Write data to memory location 2 from right port
     @(posedge iright_clk);
     ddr_write_addr_r(2,data_temp2_r,byte_r);

     // Disable Write Operations    
     @(negedge ileft_clk);
     inleft_ce0     = 1'b1;  

     @(negedge iright_clk);
     inright_ce0     = 1'b1;  

     // Test for BUSY# assertion
     fork
       busy_check_low_after_4_period_l;
       busy_check_low_after_4_period_r;
     join

     #100;    
     arb_test_on        = 1'b0;
     ileft_clk_period   = ileft_clk_period_old;
     iright_clk_period  = iright_clk_period_old;
     report_test_result("arb_test_w_ddr_w_ddr_violate_tCCS_l");
   end
  endtask


     
  // Testcase for Arbitration  when both Ports    
  // Writing the data to memory Violating tCCS    
  // and Right port Comes First. Both Ports    
  // Configured in DDR mode. No tPS Violation           
    
  task arb_test_w_ddr_w_ddr_violate_tCCS_r;

   `ifdef DDR
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_l;
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_l;
   `else
     reg [`CYP_DATAWIDTH   - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
   `endif
  
   begin   
 
    if(wmsg == 1'b1)$display("-------------------------------------------------------");
    if(nmsg == 1'b1)$display("--    Testcase for Arbitration  when both Ports      --");
    if(nmsg == 1'b1)$display("--    Writing the data to memory Violating tCCS      --");
    if(nmsg == 1'b1)$display("--      and Right port Comes First. Both Ports       --");
    if(nmsg == 1'b1)$display("--             Configured in DDR mode                --");
    if(nmsg == 1'b1)$display("--             No tPS Violation                      --");
    if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
    if(wmsg == 1'b1)$display("-------------------------------------------------------");

     arb_test_on           = 1'b1;
     right_clk_first       = 1'b1;
     left_clk_first        = 1'b0;

     iright_ftsel          = 1'b1;
     iright_ddron          = 1'b1;
     iright_portstd        = 1'b1;
     ileft_ftsel           = 1'b1;
     ileft_ddron           = 1'b1;
     ileft_portstd         = 1'b1;

     inright_ce0           = 1'b1;
     iright_ce1            = 1'b0;
     inleft_ce0            = 1'b1;
     ileft_ce1             = 1'b0;
     a_rw_l                = {`CYP_ADDRWIDTH{1'b0}};
     a_rw_r                = {`CYP_ADDRWIDTH{1'b0}};
     tCCS_test             = TP.tCYC_min - 1;
     arb_delay_right_left  = TP.tCYC_min * 0.05;
     ileft_clk_period_old  = ileft_clk_period;
     ileft_clk_period      = TP.tCYC_min;
     iright_clk_period_old = iright_clk_period;
     iright_clk_period     = TP.tCYC_min;

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
     @(negedge iright_clk);  
     enable_write_op_r;
     data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
     data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
     ddr_write_addr_r(0,data_temp1_r,byte_r);
     randomdata_72bit(data_r);
     
     // Write data to memory location 4 from left port
     randomdata_72bit(data_l);
     @(negedge ileft_clk);  
     enable_write_op_l;
     data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
     data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
     ddr_write_addr_l(4,data_temp1_l,byte_l);
     
     // Write data to memory location 0 from right port
     @(posedge iright_clk);
     ddr_write_addr_r(0,data_temp2_r,byte_r);
     
     // Write data to memory location 4 from left port
     @(posedge ileft_clk);
     ddr_write_addr_l(4,data_temp2_l,byte_l);


     // Write data to memory location 1 from right port 
     randomdata_72bit(data_r);
     @(negedge iright_clk);  
     data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
     data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
     ddr_write_addr_r(1,data_temp1_r,byte_r);
     randomdata_72bit(data_r);
     
     // Write data to memory location 3 from left port
     randomdata_72bit(data_l);
     @(negedge ileft_clk);  
     enable_write_op_l;
     data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
     data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
     ddr_write_addr_l(3,data_temp1_l,byte_l);
     
     // Write data to memory location 1 from right port
     @(posedge iright_clk);
     ddr_write_addr_r(1,data_temp2_r,byte_r);
     
     // Write data to memory location 3 from left port
     @(posedge ileft_clk);
     ddr_write_addr_l(3,data_temp2_l,byte_l);

     // Write data to memory location 2 from right port 
     randomdata_72bit(data_r);
     @(negedge iright_clk);  
     enable_write_op_r;
     data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
     data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
     ddr_write_addr_r(2,data_temp1_r,byte_r);
     randomdata_72bit(data_r);
     
     // Write data to memory location 2 from left port
     randomdata_72bit(data_l);
     @(negedge ileft_clk);  
     enable_write_op_l;
     data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
     data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
     ddr_write_addr_l(2,data_temp1_l,byte_l);
     
     // Write data to memory location 2 from right port
     @(posedge iright_clk);
     ddr_write_addr_r(2,data_temp2_r,byte_r);
     
     // Write data to memory location 2 from left port
     @(posedge ileft_clk);
     ddr_write_addr_l(2,data_temp2_l,byte_l);

     // Disable Write Operations    
     @(negedge iright_clk);
     inright_ce0 = 1'b1;  

     @(negedge ileft_clk);
     inleft_ce0  = 1'b1;  

     // Test for BUSY# assertion
     fork
       busy_check_low_after_4_period_r;
       busy_check_low_after_4_period_l;
     join

     #100;    
     arb_test_on = 1'b0;
     ileft_clk_period   = ileft_clk_period_old;
     iright_clk_period  = iright_clk_period_old;
     report_test_result("arb_test_w_ddr_w_ddr_violate_tCCS_r");
   end
  endtask



       
  // Testcase for Arbitration when both Ports  
  // Writing the data to memory Violating tPS 
  // and Left port Comes First. Both Ports 
  // Configured in DDR mode           
  // BUSY# flag may or maynot generate  

  task arb_test_w_ddr_w_ddr_violate_tPS_l;

   `ifdef DDR
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_r;
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_r;
   `else
     reg [`CYP_DATAWIDTH   - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
   `endif
  
   begin   
 
     arb_test_on         = 1'b1;
     left_clk_first      = 1'b1;
     right_clk_first     = 1'b0;
     tCCS_test           = TP.tCYC_min - 1;

       if(wmsg == 1'b1)$display("-------------------------------------------------------");
       if(nmsg == 1'b1)$display("--    Testcase for Arbitration when both Ports       --");
       if(nmsg == 1'b1)$display("--    Writing the data to memory Violating tPS       --");
       if(nmsg == 1'b1)$display("--     and Left port Comes First. Both Ports         --");
       if(nmsg == 1'b1)$display("--             Configured in DDR mode                --");
       if(nmsg == 1'b1)$display("--      BUSY# flag may or maynot generate            --");
       if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
       if(wmsg == 1'b1)$display("-------------------------------------------------------");

       ileft_ftsel    = 1'b1;
       ileft_ddron    = 1'b1;
       ileft_portstd  = 1'b1;
       iright_ftsel   = 1'b1;
       iright_ddron   = 1'b1;
       iright_portstd = 1'b1; 

       inleft_ce0     = 1'b1;
       ileft_ce1      = 1'b0;
       inright_ce0    = 1'b1;
       iright_ce1     = 1'b0;
       a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
       a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
       ileft_clk_period_old  = ileft_clk_period;
       ileft_clk_period      = TP.tCYC_min;
       iright_clk_period_old = iright_clk_period;
       iright_clk_period     = TP.tCYC_min;
    
       arb_delay_left_right  = iright_clk_period - TP.tPS +0.1;
       
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
       @(negedge ileft_clk);  
       enable_write_op_l;
       data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
       data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
       ddr_write_addr_l(0,data_temp1_l,byte_l);
       randomdata_72bit(data_l);
     
       // Write data to memory location 4 from right port
       randomdata_72bit(data_r);
       @(negedge iright_clk);  
       enable_write_op_r;
       data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
       data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
       ddr_write_addr_r(4,data_temp1_r,byte_r);
     
       // Write data to memory location 0 from left port
       @(posedge ileft_clk);
       ddr_write_addr_l(0,data_temp2_l,byte_l);
     
       // Write data to memory location 4 from right port
       @(posedge iright_clk);
       ddr_write_addr_r(4,data_temp2_r,byte_r);


       // Write data to memory location 1 from left port 
       randomdata_72bit(data_l);
       @(negedge ileft_clk);  
       data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
       data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
       ddr_write_addr_l(1,data_temp1_l,byte_l);
       randomdata_72bit(data_l);
     
       // Write data to memory location 3 from right port
       randomdata_72bit(data_r);
       @(negedge iright_clk);  
       enable_write_op_r;
       data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
       data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
       ddr_write_addr_r(3,data_temp1_r,byte_r);
     
       // Write data to memory location 1 from left port
       @(posedge ileft_clk);
       ddr_write_addr_l(1,data_temp2_l,byte_l);
     
       // Write data to memory location 3 from right port
       @(posedge iright_clk);
       ddr_write_addr_r(3,data_temp2_r,byte_r);

       // Write data to memory location 2 from left port 
       randomdata_72bit(data_l);
       @(negedge ileft_clk);  
       enable_write_op_l;
       data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
       data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
       ddr_write_addr_l(2,data_temp1_l,byte_l);
       randomdata_72bit(data_l);
     
       // Write data to memory location 2 from right port
       randomdata_72bit(data_r);
       @(negedge iright_clk);  
       enable_write_op_r;
       data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
       data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
       ddr_write_addr_r(2,data_temp1_r,byte_r);
     
       // Write data to memory location 2 from left port
       @(posedge ileft_clk);
       #0;
       ddr_write_addr_l(2,data_temp2_l,byte_l);
     
       // Write data to memory location 2 from right port
       @(posedge iright_clk);
       #0;
       ddr_write_addr_r(2,data_temp2_r,byte_r);

       // Disable Write Operations    
       @(negedge ileft_clk);
       inleft_ce0  = 1'b1;  

       @(negedge iright_clk);
       inright_ce0 = 1'b1;  


       // Checks the value in the content of the memory
       enable_read_op_l;
       inleft_ce0    = 1'b1;
       @(posedge ileft_clk);
       @(posedge ileft_clk_n);
       #(ileft_clk_period/2.0 - TP.tSAC_l);
       inleft_ce0    = 1'b0;
       ddr_read_addr_l(2);
       @(posedge ileft_clk_n);
       #(ileft_clk_period/2.0 - TP.tSAC_l);
       inleft_ce0    = 1'b1;
              
       @(posedge ileft_clk_n);
       #(ileft_clk_period/2.0 - TP.tDC_l);
       ddr_compare_result_l(2);
       @(posedge ileft_clk);
       #(ileft_clk_period/2.0 - TP.tDC_l);
       ddr_compare_result_l(2);
       inleft_ce0    = 1'b1;    
       ileft_ce1     = 1'b0;    

     #30;    
     ileft_clk_period  = 10;
     iright_clk_period = 10;
     arb_test_on       = 1'b0;
     ileft_clk_period  = ileft_clk_period_old;
     iright_clk_period = iright_clk_period_old;
     report_test_result("arb_test_w_ddr_w_ddr_violate_tPS_l");
   end
  endtask


      
  // Testcase for Arbitration when both Ports 
  // Writing the data to memory Violating tPS 
  // and Right port Comes First. Both Ports 
  // Configured in DDR mode    
  // BUSY# flag may or maynot generate  

  task arb_test_w_ddr_w_ddr_violate_tPS_r;

   `ifdef DDR
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_l;
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_r;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_temp2_l;
   `else
     reg [`CYP_DATAWIDTH   - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH   - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
   `endif
  
   begin   
 
       arb_test_on       = 1'b1;
       right_clk_first   = 1'b1;
       left_clk_first    = 1'b0;
       tCCS_test         = TP.tCYC_min - 1;
       
       if(wmsg == 1'b1)$display("-------------------------------------------------------");
       if(nmsg == 1'b1)$display("--    Testcase for Arbitration when both Ports       --");
       if(nmsg == 1'b1)$display("--    Writing the data to memory Violating tPS       --");
       if(nmsg == 1'b1)$display("--     and Right port Comes First. Both Ports        --");
       if(nmsg == 1'b1)$display("--             Configured in DDR mode                --");
       if(nmsg == 1'b1)$display("--      BUSY# flag may or maynot generate            --");
       if(wmsg == 1'b1)$display("--  Setup/Hold time violation WARNINGS are expected  --");
       if(wmsg == 1'b1)$display("-------------------------------------------------------");

       
       
       iright_ftsel    = 1'b1;
       iright_ddron    = 1'b1;
       iright_portstd  = 1'b0;
       ileft_ftsel     = 1'b1;
       ileft_ddron     = 1'b1;
       ileft_portstd   = 1'b1; 

       inright_ce0     = 1'b1;
       iright_ce1      = 1'b0;
       inleft_ce0      = 1'b1;
       ileft_ce1       = 1'b0;
       a_rw_l          = {`CYP_ADDRWIDTH{1'b0}};
       a_rw_r          = {`CYP_ADDRWIDTH{1'b0}};
       ileft_clk_period_old  = ileft_clk_period;
       ileft_clk_period      = TP.tCYC_min;
       iright_clk_period_old = iright_clk_period;
       iright_clk_period     = TP.tCYC_min;
    
       arb_delay_right_left = iright_clk_period - TP.tPS +0.1;
       counter_load_mode_r;
       counter_load_mode_l;
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
       @(negedge iright_clk);  
       enable_write_op_r;
       data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
       data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
       ddr_write_addr_r(0,data_temp1_r,byte_r);
       randomdata_72bit(data_r);
     
       // Write data to memory location 4 from left port
       randomdata_72bit(data_l);
       @(negedge ileft_clk);  
       enable_write_op_l;
       data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
       data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
       ddr_write_addr_l(4,data_temp1_l,byte_l);
     
       // Write data to memory location 0 from right port
       @(posedge iright_clk);
       ddr_write_addr_r(0,data_temp2_r,byte_r);
     
       // Write data to memory location 4 from left port
       @(posedge ileft_clk);
       ddr_write_addr_l(4,data_temp2_l,byte_l);


       // Write data to memory location 1 from right port 
       randomdata_72bit(data_r);
       @(negedge iright_clk);  
       data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
       data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
       ddr_write_addr_r(1,data_temp1_r,byte_r);
       randomdata_72bit(data_r);
     
       // Write data to memory location 3 from left port
       randomdata_72bit(data_l);
       @(negedge ileft_clk);  
       enable_write_op_l;
       data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
       data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
       ddr_write_addr_l(3,data_temp1_l,byte_l);
     
       // Write data to memory location 1 from right port
       @(posedge iright_clk);
       ddr_write_addr_r(1,data_temp2_r,byte_r);
     
       // Write data to memory location 3 from left port
       @(posedge ileft_clk);
       ddr_write_addr_l(3,data_temp2_l,byte_l);

       // Write data to memory location 2 from right port 
       randomdata_72bit(data_r);
       @(negedge iright_clk);
       #0;  
       enable_write_op_r;
       data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
       data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
       ddr_write_addr_r(2,data_temp1_r,byte_r);
       randomdata_72bit(data_r);
     
       // Write data to memory location 2 from left port
       randomdata_72bit(data_l);
       @(negedge ileft_clk);  
       #0;
       enable_write_op_l;
       data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
       data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
       ddr_write_addr_l(2,data_temp1_l,byte_l);
     
       // Write data to memory location 2 from right port
       @(posedge iright_clk);
       #0;
       ddr_write_addr_r(2,data_temp2_r,byte_r);
     
       // Write data to memory location 2 from left port
       @(posedge ileft_clk);
       #0;
       ddr_write_addr_l(2,data_temp2_l,byte_l);

       // Disable Write Operations    
       @(negedge iright_clk);
       #0;
       inright_ce0     = 1'b1;  

       @(negedge ileft_clk);
       inleft_ce0     = 1'b1;  


       // Checks the value in the content of the memory
       enable_read_op_r;
       inright_ce0    = 1'b1;
       @(posedge iright_clk);
       @(posedge iright_clk);
       @(posedge iright_clk_n);
       #(iright_clk_period/2.0 - TP.tSAC_r);
       inright_ce0    = 1'b0;
       ddr_read_addr_r(2);
       @(posedge iright_clk_n);
       #(iright_clk_period/2.0 - TP.tSAC_r);
       inright_ce0    = 1'b1;
              
       @(posedge iright_clk_n);
       #(iright_clk_period/2.0 - TP.tDC_r);
       ddr_compare_result_r(2);
       @(posedge iright_clk);
       #(iright_clk_period/2.0 - TP.tDC_r);
       ddr_compare_result_r(2);
       inright_ce0    = 1'b1;    
       iright_ce1     = 1'b0;    

     #30;   
     arb_test_on        = 1'b0;
     ileft_clk_period   = ileft_clk_period_old;
     iright_clk_period  = iright_clk_period_old;
     report_test_result("arb_test_w_ddr_w_ddr_violate_tPS_r");
     master_reset;
   end
  endtask




