// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// -----------------------------------------------------------------------------
// File Name :  cyd18s72v_test_tasks.v
// Version : 0.1
// Status : Module is Complete
// -----------------------------------------------------------------------------
// Author : Ashlesha Gokhale
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date : May, 12, 2003
// -----------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : May 12, 2003
// -----------------------------------------------------------------------------
// Dependencies :  cyd18s72v_test_defines.v
// Description  : This file contains tasks  require for test bench.
// Simulation Notes : NA
// Application Note : NA
// Simulator : verilog xl.
// Terms & concepts : 
// Open issues and future enhancements : None
// References : 
// Revision History :
// Rev  Author    Phone           Date           Changes
// -----------------------------------------------------------------------------
//0.1   Ashlesha  2933700.2074    12.05.2003       New file
//1.0                             16.05.2003       Added local variable rslt_reg in 
//                                                 fill_result_array task.                 
//1.1                             20.06.2003       Added function check_x_z to check
//                                                 if expected data is x or z                 
//-----------------------------------------------------------------------------

//************************************************************************************
// Task         : Initialization
// Author       : Ashlesha Gokhale
// Description  : This task initializes all the test bench variables
//                
//Modification:
//
//
//
//************************************************************************************


task initialize;
    begin

    // This is initialization of all variable, inputs     
     $dumpvars();                          // This stores all the variables of the module and 
    `ifdef GENVCD
     $dumpfile("cyd18s72v.vcd");         //submodules to cyd18s72v.vcd file which can used to 
     `endif                                               // check the waveform  later.  
     clkl = 1'b0;                          //both clocks are inititalized to 0.
     clkr = 1'b0;     
     al = `AD_M'b0;                           // left port adddress is initialized to 0.  
     ar = `AD_M'b1;                           // right port address initialized to 1.   
     dql_int = `DT_S'bx;                      // both data buses are tri-stated initially   
     dqr_int = `DT_S'bx;                       
     oe_nl = 'b1;                          // oe is inactive
     oe_nr = 'b1;
     r_w_nl = 'b1;                         // R/W_n is driven to 1 indicating read operation 
     r_w_nr = 'b1;
     b_nl= 'h0;                            //All byte are enabled 
     b_nr = 'h0;
     mrst_n = 1'b1;                        //Master reset initialized to 1. 
     rslt_wr_ptr_l = 0;
     rslt_wr_ptr_r = 0;
     rslt_rd_ptr_l = 0;
     rslt_rd_ptr_r = 0;
     test_control_reg = 'h0;
   end 
endtask // initialize


//************************************************************************************
// Task         : Master Reset
// Author       : Ashlesha Gokhale
// Description  : This task perform master reset operation
//                
//Modification:
//
//
//
//************************************************************************************


task MasterReset;
reg[145:0] rslt_reg;     
    begin
   `ifdef TSTDBG 
       $display(" Task Master Reset  Started  at time %t", $realtime);     
   `endif
       rslt_wr_ptr_r = 0;                                 
       rslt_wr_ptr_l = 0;
       rslt_rd_ptr_r = 0;                                 
       rslt_rd_ptr_l = 0;                                 
       for (i= 0; i <= 15; i = i+1)
         rslt[i] = 145'bz;
 // Cheks all outputs at inactive state after the reset
       if (power_on_reset) begin  
          rslt_reg[`LEFT_DATA] = `DT_S'hz;
          rslt_reg[`RIGHT_DATA] = `DT_S'hz;
          rslt[rslt_wr_ptr_l] = rslt_reg;
          rslt_wr_ptr_r = rslt_wr_ptr_r +1;                                       
          rslt_wr_ptr_l = rslt_wr_ptr_l +1;
       end
       test_control_reg[`LEFT_INTR] = 1'b1;
       test_control_reg[`RIGHT_INTR] = 1'b1;
       x_event_f = 1'b0;
       get_next_data = 1'b1;
       x_event_f_r = 1'b0;
       get_next_data_r = 1'b1;


       #`RESET_SETUP_TIME;                   // Wait for time more than required reset setup time 
       mrst_n = 1'b0;                        // Master reset is asserted
       dql_int = `DT_S'bz;
       dqr_int = `DT_S'bz;
       reset_over_test = 1'b1;                   // reset_over flag is set to indicate completion of
       //`RESET_PULSE_WIDTH;                  // wait for time greater that required reset pulse width
       repeat(`RESET_PULSE_WIDTH)
        @(posedge clkl);     
       mrst_n = 1'b1;                        // Master reset is de-aaserted
       

       
       #`RESET_RECOVERY_TIME;                // wait for reset recovert time.     
   `ifdef TSTDBG 
       $display(" Task Master Reset Ended at time %t", $realtime);     
   `endif
       
    end   
endtask // master_reset


//************************************************************************************
// Task         :WriteLeft
// Author       : Ashlesha Gokhale
// Description  :
//Modification:
//
//
//
//************************************************************************************

task WriteLeft; 
input [`AD_M:0] address;
input [`BT_M:0]  byte_enable;
input [`DT_M:0] data;

reg  [145:0] rslt_reg; 
begin
   `ifdef TSTDBG 
     $display(" Task WriteLeft Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
   `endif
  
   @(posedge clkl);
   fork
   // driving Rd/Wr signal for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_RD_L] == 1'b1)
       r_w_nl = #`HOLD_VIOLATION_TIME 1'b0;
     else if (test_control_reg[`SETUP_VIOLATION_RD_L] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      r_w_nl = 1'b0;                         
     end else begin
      #`SAFE_TIME;   
      r_w_nl = 1'b0;                         
     end 

   // driving Address for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_ADDR_L] == 1'b1)
      al = #`HOLD_VIOLATION_TIME address;
     else if (test_control_reg[`SETUP_VIOLATION_ADDR_L] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      al = address;
     end else begin
      #`SAFE_TIME;
      al = address;
     end  

   // driving Byte Enable signal for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_BE_L] == 1'b1)
       b_nl = #`HOLD_VIOLATION_TIME byte_enable;
     else if (test_control_reg[`SETUP_VIOLATION_BE_L] == 1'b1) 
      begin
      #`SETUP_VIOLATION_TIME;
       b_nl = byte_enable;
     end else begin
       #`SAFE_TIME;
    
       b_nl = byte_enable;
     end    

   // driving Data for normal condition, setup violation, hold violation
     begin
       if (oe_nl == 1'b0) begin // if oe is low, wait till data bus is tri-stated
         @(posedge clkl);
         @(posedge clkl);
       end 
       if (test_control_reg[`HOLD_VIOLATION_DATA_L] == 1'b1)
         dql_int = #`HOLD_VIOLATION_TIME data;
       else if (test_control_reg[`SETUP_VIOLATION_DATA_L] == 1'b1) 
         begin
         #`SETUP_VIOLATION_TIME;
         dql_int = data;
       end else begin
         #`SAFE_TIME;
         dql_int = data;
       end
     end
   join    
   if(address == `LAST_ADDRESS)
      test_control_reg[`RIGHT_INTR] = 1'b0 ; 
   `ifdef TSTDBG 
     $display(" Task WriteLeft Ended at time %t", $realtime);     
   `endif

    
end   
endtask//write_left

//************************************************************************************
// Task         : WriteRight
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************
task WriteRight; 
input [`AD_M:0] address;
input [`BT_M:0]  byte_enable;
input [`DT_M:0] data;

reg [145:0] rslt_reg;
begin
   `ifdef TSTDBG 
     $display(" Task WriteRight Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
   `endif

   @(posedge clkr);
   fork
    // driving Rd/Wr for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_RD_R] == 1'b1)
       r_w_nr = #0.2 1'b0;
     else if (test_control_reg[`SETUP_VIOLATION_RD_R] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      r_w_nr = 1'b0;                         
     end else begin
      #`SAFE_TIME;   
      r_w_nr = 1'b0;                         
     end 

     // driving Address for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_ADDR_R] == 1'b1)
      ar = #0.2 address;
     else if (test_control_reg[`SETUP_VIOLATION_ADDR_R] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      ar = address;
     end else begin
      #`SAFE_TIME;
      ar = address;
     end  

     // driving Byte Enable for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_BE_R] == 1'b1)
       b_nr = #0.2byte_enable;
     else if (test_control_reg[`SETUP_VIOLATION_BE_R] == 1'b1) 
      begin
      #`SETUP_VIOLATION_TIME;
       b_nr = byte_enable;
     end else begin
       #`SAFE_TIME;
       b_nr = byte_enable;
     end    
     
     // driving Data for normal condition, setup violation, hold violation
     begin 
       if (oe_nr == 1'b0)
        begin
         @(posedge clkr);
         @(posedge clkr);
        end    
       if (test_control_reg[`HOLD_VIOLATION_DATA_R] == 1'b1)
         dqr_int = #0.2 data;
       else if (test_control_reg[`SETUP_VIOLATION_DATA_R] == 1'b1) 
       begin
         #`SETUP_VIOLATION_TIME;
         dqr_int = data;
       end else begin
         #`SAFE_TIME;
         dqr_int = data;
       end
     end
   join    

     if(address == (`LAST_ADDRESS -1) ) 
     test_control_reg[`LEFT_INTR] = 'b0;
   `ifdef TSTDBG 
     $display(" Task WriteRight Ended at time %t", $realtime);     
   `endif

end   
endtask//write_right

//************************************************************************************
// Task         : ReadLeft
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************
/*
task ReadLeft; 
input [`AD_M:0] address;
input [`BT_M:0]  byte_enable;
input [`DT_M:0] data;      
reg [145:0] rslt_reg;
reg [`DT_M:0]  datax; 
begin
   `ifdef TSTDBG 
     $display("Task ReadLeft Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
   `endif

   @(posedge clkl);
  fork

 // driving Data for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_DATA_L] == 1'b1)
      dql_int = #0.2 `DT_S'bz;
       else begin
       #`SAFE_TIME;
       dql_int = `DT_S'bz;
     end

   // driving Rd/Wr signal for normal condition, setup violation, hold violation
     if (test_control_reg[`SETUP_VIOLATION_RD_L] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      r_w_nl = 1'b1;                         
     end else begin
      #`SAFE_TIME;   
      r_w_nl = #0.1 1'b1;                         
     end 

 // driving address for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_ADDR_L] == 1'b1)
      al = #0.2 address;
     else if (test_control_reg[`SETUP_VIOLATION_ADDR_L] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      al = address;
     end else begin
      #`SAFE_TIME;
      al = address;
     end  

 // driving Byte Enable signal for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_BE_L] == 1'b1)
       b_nl = #0.2 byte_enable;
     else if (test_control_reg[`SETUP_VIOLATION_BE_L] == 1'b1) 
      begin
      #`SETUP_VIOLATION_TIME;
       b_nl = byte_enable;
     end else begin
       #`SAFE_TIME;
       b_nl = byte_enable;
     end    


   join    
      //filling expected result array

   if(address == (`LAST_ADDRESS -1) ) begin
      test_control_reg[`LEFT_INTR] = 1'b1;
   end 
   fill_result_array(left_data, data, rslt_wr_ptr_l);       

   // If not in back-to-back mode, drive the late oe signal, de-assert oe. 
   if (test_control_reg[`BACK_TO_BACK_L] == 1'b0)  begin   
       repeat(2) 
       @(posedge clkl);
     //driving OE in Normal condition   
     if (test_control_reg[`LATE_OE_L]== 1'b0) begin
         oe_nl = #`OESKEW 1'b0;
     end else begin
      // @(posedge clkl);
       oe_nl = #`OESKEW 1'b0;
     end 
      @(posedge clkl);
      oe_nl =#`OESKEW 1'b1; 
      if (data!== `DT_S'bx )
        begin
          mask_result_x(data, datax);  // when few data bytes  are disabled.
          fill_result_array(left_data, datax, rslt_wr_ptr_l);       
        end  
      fill_result_array(left_data, `DT_S'hz, rslt_wr_ptr_l);       
    end else if  (oe_nl !== 1'b0) begin
     repeat(2)
     @(posedge clkl);
     oe_nl =#`OESKEW 1'b0;
   end 
   `ifdef TSTDBG 
     $display(" Task ReadLeft Ended at time %t", $realtime);     
   `endif
 
end   
endtask//read_left
*/

//************************************************************************************
// Task         : ReadRight
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************
/*
task ReadRight;
input [`AD_M:0] address;
input [`BT_M:0]  byte_enable;
input [`DT_M:0] data;      
reg   [`DT_M:0] datax;      
reg [145:0] rslt_reg;
begin
   `ifdef TSTDBG 
     $display(" Task ReadRight Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
   `endif

   @(posedge clkr);
   fork

   // driving Data for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_DATA_R] == 1'b1)
      dqr_int = #0.2 `DT_S'bz;
      else begin
       #`SAFE_TIME;
       dqr_int = `DT_S'bz;
     end

   // driving Rd/Wr for normal condition, setup violation, hold violation
     if (test_control_reg[`SETUP_VIOLATION_RD_R] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      r_w_nr = 1'b1;                         
     end else begin
      #`SAFE_TIME;   
      r_w_nr = #0.1 1'b1;                         
     end 

   // driving address for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_ADDR_R] == 1'b1)
      ar = #0.2 address;
     else if (test_control_reg[`SETUP_VIOLATION_ADDR_R] == 1'b1) 
     begin
      #`SETUP_VIOLATION_TIME;
      ar = address;
     end else begin
      #`SAFE_TIME;
      ar = address;
     end  

   // driving Byte Enable for normal condition, setup violation, hold violation
     if (test_control_reg[`HOLD_VIOLATION_BE_R] == 1'b1)
       b_nr = #0.2 byte_enable;
     else if (test_control_reg[`SETUP_VIOLATION_BE_R] == 1'b1) 
      begin
      #`SETUP_VIOLATION_TIME;
       b_nr = byte_enable;
     end else begin
       #`SAFE_TIME;
       b_nr = byte_enable;
     end    


   join    

   //fillling expected data array

     if(address == `LAST_ADDRESS)
       test_control_reg[`RIGHT_INTR] = 1'b1;
     

    fill_result_array(right_data, data, rslt_wr_ptr_r);       

   // If not in back-to-back mode, drive the late oe signal, de-assert oe. 


   if (test_control_reg[`BACK_TO_BACK_R] == 1'b0)  begin   
     repeat(2) 
     @(posedge clkr);
     //driving OE in Normal condition   
     if (test_control_reg[`LATE_OE_R]== 1'b0) begin
         oe_nr =#`OESKEW 1'b0;
     end else begin
       @(posedge clkr);
       oe_nr =#0.1 1'b0;
     end 
      @(posedge clkr);
      oe_nr = #`OESKEW 1'b1; 
      if (data!== `DT_S'bx )
        begin
          mask_result_x(data, datax);  // when few data bytes  are disabled.
          fill_result_array(right_data, datax, rslt_wr_ptr_r);       
       end  
    
     fill_result_array(right_data, `DT_S'bz, rslt_wr_ptr_r);       
   end else if (oe_nr !== 1'b0) begin
       repeat(2)
       @(posedge clkr);
       oe_nr =#`OESKEW 1'b0;
   end
   `ifdef TSTDBG 
     $display(" Task ReadRight Ended at time %t", $realtime);     
   `endif

  end   
endtask//ReadRight
*/

//************************************************************************************
// Task         : ReadLeft
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************

task ReadLeft; 
input [`AD_M:0] address;
input [`BT_M:0]  byte_enable;
input [`DT_M:0] data;      
reg [145:0] rslt_reg;
reg [`DT_M:0]  datax; 
begin
    `ifdef TSTDBG 
        $display("Task ReadLeft Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif
    @(posedge clkl);
    fork
        
        // driving Data for normal condition, setup violation, hold violation
              
       if ((test_control_reg[`HOLD_VIOLATION_DATA_L] == 1'b1) ||(test_control_reg[`HOLD_VIOLATION_RD_L] == 1'b1))
            dql_int = #0.1 `DT_S'bz;
       else if (test_control_reg[`SETUP_VIOLATION_DATA_L] == 1'b1)begin 
            #`SETUP_VIOLATION_TIME;
            dql_int = `DT_S'bz;
       end else begin
            #`SAFE_TIME;
            dql_int = `DT_S'bz;
       end

       // driving Rd/Wr signal for normal condition, setup violation, hold violation
       if ((test_control_reg[`SETUP_VIOLATION_RD_L] == 1'b1) || (test_control_reg[`SETUP_VIOLATION_DATA_L] == 1'b1)) begin
           #(`SETUP_VIOLATION_TIME + 1);
           r_w_nl = 1'b1;           
       end else if (test_control_reg[`HOLD_VIOLATION_RD_L] == 1'b1)begin
            r_w_nl = #0.2  1'b1;              
       end else begin
           #`SAFE_TIME;   
           r_w_nl = #0.1 1'b1;                         
       end 

       // driving address for normal condition, setup violation, hold violation
       if (test_control_reg[`HOLD_VIOLATION_ADDR_L] == 1'b1)
           al = #0.2 address;
       else if (test_control_reg[`SETUP_VIOLATION_ADDR_L] == 1'b1) begin
           #`SETUP_VIOLATION_TIME;
           al = address;
       end else begin
           #`SAFE_TIME;
           al = address;
       end  

       // driving Byte Enable signal for normal condition, setup violation, hold violation
       if (test_control_reg[`HOLD_VIOLATION_BE_L] == 1'b1)
           b_nl = #0.2 byte_enable;
       else if (test_control_reg[`SETUP_VIOLATION_BE_L] == 1'b1)begin
           #`SETUP_VIOLATION_TIME;
           b_nl = byte_enable;
       end else begin
           #`SAFE_TIME;
           b_nl = byte_enable;
       end    
   join    
   //filling expected result array
   if(address == (`LAST_ADDRESS -1) ) begin
      test_control_reg[`LEFT_INTR] = 1'b1;
   end 
   fill_result_array(left_data, data, rslt_wr_ptr_l);       
   // If not in back-to-back mode, drive the late oe signal, de-assert oe. 
   if (test_control_reg[`BACK_TO_BACK_L] == 1'b0)  begin   
       repeat(2) 
       @(posedge clkl);
       //driving OE in Normal condition   
       if (test_control_reg[`LATE_OE_L]== 1'b0) begin
           oe_nl = #`OESKEW 1'b0;
       end else begin
           // @(posedge clkl);
           oe_nl = #`OESKEW 1'b0;
       end 
       @(posedge clkl);
       oe_nl =#`OESKEW 1'b1; 
       if (data!== `DT_S'bx )begin
           mask_result_x(data, datax);  // when few data bytes  are disabled.
           fill_result_array(left_data, datax, rslt_wr_ptr_l);       
       end  
       fill_result_array(left_data, `DT_S'hz, rslt_wr_ptr_l);       
   end else if  (oe_nl !== 1'b0) begin
       repeat(2)
      @(posedge clkl);
     oe_nl =#`OESKEW 1'b0;
   end 
   `ifdef TSTDBG 
     $display(" Task ReadLeft Ended at time %t", $realtime);     
   `endif
 
end   
endtask//read_left


//************************************************************************************
// Task         : ReadRight
// Author       : Ashlesha Gokhale
// Description  : 
//Modification:
//
//
//
//************************************************************************************

task ReadRight;
input [`AD_M:0] address;
input [7:0]  byte_enable;
input [`DT_M:0] data;      
reg   [`DT_M:0] datax;      
reg [145:0] rslt_reg;
begin
    `ifdef TSTDBG 
        $display(" Task ReadRight Started with parameters address = %h, byte_enable = %h, data = %h at time %t", address, byte_enable, data, $realtime);     
    `endif

    @(posedge clkr);
    fork
        

       if ((test_control_reg[`HOLD_VIOLATION_DATA_R] == 1'b1) || (test_control_reg[`HOLD_VIOLATION_RD_R] == 1'b1))
            dqr_int = #0.1 `DT_S'bz;
       else if (test_control_reg[`SETUP_VIOLATION_DATA_R] == 1'b1)begin 
            #`SETUP_VIOLATION_TIME;
            dqr_int = `DT_S'bz;
       end else begin
            #`SAFE_TIME;
            dqr_int = `DT_S'bz;
       end

       // driving Rd/Wr signal for normal condition, setup violation, hold violation
       if ((test_control_reg[`SETUP_VIOLATION_RD_R] == 1'b1)|| (test_control_reg[`SETUP_VIOLATION_DATA_R] == 1'b1)) begin
           #(`SETUP_VIOLATION_TIME+1);
           r_w_nr = 1'b1;           
       end else if (test_control_reg[`HOLD_VIOLATION_RD_R] == 1'b1)begin
            r_w_nr = #0.2  1'b1;              
       end else begin
           #`SAFE_TIME;   
           r_w_nr = #0.1 1'b1;                         
       end 

 
        // driving address for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_ADDR_R] == 1'b1)
            ar  = #0.2 address;
        else if (test_control_reg[`SETUP_VIOLATION_ADDR_R] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            ar  = address;
        end else begin
            #`SAFE_TIME;
            ar  = address;
        end  
 
        // driving Byte Enable for normal condition, setup violation, hold violation
        if (test_control_reg[`HOLD_VIOLATION_BE_R] == 1'b1)
            b_nr = #0.2 byte_enable;
        else if (test_control_reg[`SETUP_VIOLATION_BE_R] == 1'b1) begin
            #`SETUP_VIOLATION_TIME;
            b_nr = byte_enable;
        end else begin
            #`SAFE_TIME;
            b_nr = byte_enable;
        end    
    join    

    //fillling expected data array

    if(address == `LAST_ADDRESS)
        test_control_reg[`RIGHT_INTR] = 1'b1;
    fill_result_array(right_data, data, rslt_wr_ptr_r);       

    // If not in back-to-back mode, drive the late oe signal, de-assert oe. 
    if (test_control_reg[`BACK_TO_BACK_R] == 1'b0)  begin   
        repeat(2) 
        @(posedge clkr);
        //driving OE in Normal condition   
        if (test_control_reg[`LATE_OE_R]== 1'b0) begin
            oe_nr =#`OESKEW 1'b0;
        end else begin
        @(posedge clkr);
        oe_nr =#0.1 1'b0;
    end 
        @(posedge clkr);
        oe_nr = #`OESKEW 1'b1; 
        if (data!== `DT_S'bx )begin
            mask_result_x(data, datax);  // when few data bytes  are disabled.
            fill_result_array(right_data, datax, rslt_wr_ptr_r);       
        end  
        fill_result_array(right_data, `DT_S'bz, rslt_wr_ptr_r);       
    end else if (oe_nr !== 1'b0) begin
        repeat(2)  @(posedge clkr);
        oe_nr =#`OESKEW 1'b0;
    end
    `ifdef TSTDBG 
         $display(" Task ReadRight Ended at time %t", $realtime);     
    `endif

end   
endtask//ReadRight

task fill_result_array;
input rslt_field;
input[`DT_M:0] rslt_value;
inout [31:0]  ptr;
reg  [145:0] rslt_reg;       
begin
  rslt_reg =  rslt[ptr];
  case (rslt_field)
    left_data:
    rslt_reg[`LEFT_DATA] = rslt_value;
    right_data:
    rslt_reg[`RIGHT_DATA] = rslt_value;
    left_intr:
    rslt_reg[`LEFT_MAILBOX_INT] = rslt_value[0];
    right_intr:
    rslt_reg[`RIGHT_MAILBOX_INT] = rslt_value[0];
  endcase
  rslt[ptr] = rslt_reg;
  ptr = ptr+1; 

end
endtask//fill_result_array;

task create_mask;
input[`BT_M:0] byte_enable;
output[`DT_M:0] mask;
integer i;
begin
    if (byte_enable[0] == 1'b0)
        mask[8:0] = 9'h1ff;
    else   
        mask[8:0] = 9'h00;    
    if (byte_enable[1] == 1'b0)
        mask[17:9] = 9'h1ff;
    else   
        mask[17:9] = 9'h00;    
    if (`BT_S > 2) begin 
      if (byte_enable[2] == 1'b0)
        mask[26:18] = 9'h1ff;
      else   
        mask[26:18] = 9'h00;    
   
      if (byte_enable[3] == 1'b0)
          mask[35:27] = 9'h1ff;
      else   
          mask[35:27] = 9'h00;    
    end      
    if (`BT_S == 8  ) begin
      if (byte_enable[4] == 1'b0)
         mask[44:36] = 9'h1ff;
      else   
         mask[44:36] = 9'h00;    

      if (byte_enable[5] == 1'b0)
         mask[53:45] = 9'h1ff;
      else   
         mask[53:45] = 9'h00;    

      if (byte_enable[6] == 1'b0)
         mask[62:54] = 9'h1ff;
      else   
         mask[62:54] = 9'h00;    

      if (byte_enable[7] == 1'b0)
         mask[71:63] = 9'h1ff;
      else   
         mask[71:63] = 9'h00;    
    end
           
end
endtask//
task get_result;
input[`DT_M:0] data1, data2;
input[`BT_M:0] byte_enable;
output[`DT_M:0] result;
reg[`DT_M:0] mask_reg; 
integer m;
begin
    create_mask(byte_enable,mask_reg);
    for (m = 0; m <= `DT_M; m= m+1)
         if (mask_reg[m] == 1'b1)
             result[m] = data1[m];
         else
             result[m] = data2[m];

end
endtask//

task mask_result_x;
input[`DT_M:0] datax;
output[`DT_M:0] data_masked;
integer i;
begin
    for (i = 0; i <= `DT_M; i = i+1)
        if (datax[i]=== 1'bz) 
            data_masked[i] = 1'bz; 
        else
            data_masked[i] = 1'bx;
end
endtask

function check_x_z;
input[`DT_M: 0] data;
reg[`DT_M:0] result;
integer i;
begin
    result = 1'b1;
    for (i = 0 ; i<=`DT_M; i= i+1)
        if ((data[i] === 1'bx ) ||   (data[i] === 1'bz ))
            result[i] = 1'b0;
        else begin
            result[i] = 1'b1;
        end
    if (result == `DT_M'b0)
        check_x_z = 1'b0;
    else
        check_x_z = 1'b1;
end
endfunction

task check_x;
begin

end
endtask


//==============================End OF File==================================================















