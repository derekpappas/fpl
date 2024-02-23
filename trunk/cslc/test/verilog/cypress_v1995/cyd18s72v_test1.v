// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// -----------------------------------------------------------------------------
// File Name :  cyd18s72v_test.v
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
// Dependencies : model  cyd18s72v
// Description  : This file contains the example test bench which demonstrated basic 
//                read writes using the  cyd18s72v verilog model
// Simulation Notes : NA
// Application Note : NA
// Simulator : verilog xl.
// Terms & concepts : 
// Open issues and future enhancements : None
// References : 
// Revision History :
// Rev  Author    Phone           Date           Changes
// -----------------------------------------------------------------------------
//0.1   Ashlesha  2933700.2074    12.05.2003     New file
//1.0   Ashlesha                  16.05.2003     Added register rslt_reg_r for temporary 
//                                               storing results for right port, 
//                                               Added test cases 4.3, 4.4, 5.1, 5.2, 5.3         
//
//-----------------------------------------------------------------------------

`timescale 1ns/10ps
module  cyd18s72v_test;
      `include "cyd18s72v_test_define.v" 


   reg clkl, clkr;                        // to drive clock inputs      
   wire [`DT_M :0] dql,dqr;                  //to get  data out  
   reg [`DT_M :0]  dql_int,dqr_int;          // to drive data in  
   wire [`DT_M :0] dql_check, dqr_check;     
   reg [`DT_M :0] prev_dql_check, prev_dqr_check;     

   reg                 oe_nl,             //to drive oe inputs  
                       oe_nr;             
   wire                int_nl,            //to get interrupt output  
                       int_nr;             
  
   reg                 r_w_nl,r_w_nr;    // to drive R/Wrn


   reg [`BT_M :0]  b_nl,   
                       b_nr;             // to drive byte enable
   reg                 mrst_n;           // to dirve master reset

   reg [3:0]      vec;                  // vector number    

   reg [`AD_M :0] al, ar;                  // to drive address inputs
 
   integer             i,j,k;           // general purpose integers
   reg                 reset_over_test;     // flag to detect reset complete (set when reset complete)
   initial reset_over_test = 1'b0;           // flag initialized to '0'

   reg[145:0]         rslt[15:0];      //result array
   reg[145:0]         rslt_reg;         // result register
   reg[145:0]         rslt_reg_r;       // result register for right port
   reg                check_reset;               
   reg[21:0]          test_control_reg; // test control register         
   reg[3:0]          rslt_wr_ptr_l;     // result write pointer for left port
   reg[3:0]          rslt_wr_ptr_r;     // result write pointer for right port
   reg[3:0]          rslt_rd_ptr_l;     // result read pointer for left port
   reg[3:0]          rslt_rd_ptr_r;     // result read pointer for right port

   reg [`AD_M:0]         address;         // register for storing address used in testcases           
   reg [`AD_M:0]         a1, a2, a3;      // registers for storing addresses used in testcases           
   reg [`DT_M:0]         d1, d2, d3;      // register for storing data used in testcases           
   reg [`DT_M:0]         data_out;        // register for storing data used in testcases           
   reg [`BT_M:0]          b1, b2, b3;      // register for storing byte enable used in testcases 

   reg                get_next_data;    // read next data from result array if this is set
   initial            get_next_data =1;

   reg                x_event_f;        // flag for ignoring low-z event 
   initial            x_event_f = 0;


   reg                get_next_data_r;           // read next data from result array if this is set
   initial            get_next_data_r = 1'b1;    // for right port

   reg                x_event_f_r;               // flag for ignoring low-z event on right port
   initial            x_event_f_r = 0;

   reg                power_on_reset;
   initial            power_on_reset = 1;
   
   parameter          left_data  = 0;
   parameter          right_data = 1;
   parameter          left_intr  = 2;
   parameter          right_intr = 3;
   
   reg                fail_flag;
   initial            fail_flag = 0;  
   
    `include "cyd18s72v_test_tasks.v"  
    `include "cyd18s72v_testcases_task.v"   



   assign              dql = (r_w_nl === 1'b0) ? dql_int : `DT_S'bz ; // data bus is inout type. 
   assign              dqr = (r_w_nr === 1'b0) ? dqr_int : `DT_S'bz;  // tristated when read is performed
   assign              dql_check = (r_w_nl == 1'b0) ?  `DT_S'bz :  dql; 
   assign              dqr_check = (r_w_nr == 1'b0) ?  `DT_S'bz :  dqr; 

//Model is instantiated here. u1 is an instance of  cyd18s72v model
     cyd18s72v u1 (.al         (al),         // Address input left
                   .ar         (ar),         // Address input right
                   .clkl       (clkl),       // Clock input left
                   .clkr       (clkr),       // Clock input right
                   .dql        (dql),        // Data bus input/output left
                   .dqr        (dqr),        // Data bus input/output right
                   .oe_nl      (oe_nl),      // Output enable input left
                   .oe_nr      (oe_nr),      // Output enable input right
                   .int_nl     (int_nl),     // Mailbox interrupt flag output left
                   .int_nr     (int_nr),     // Mailbox interrupt flag output right
                   .r_w_nl     (r_w_nl),     // Read/Write Enable input left
                   .r_w_nr     (r_w_nr),     // Read/Write Enable input right
                   .b_nl       (b_nl),       // Byte select inputs left
                   .b_nr       (b_nr),       // Byte select inputs right
                   .mrst_n     (mrst_n)      // Master reset input 
                   );


//Left Port Data bus is checked in this block
   always@dql_check
     begin
        if ((reset_over_test == 1'b1) && (r_w_nl  == 1'b1)) begin //  check only output events
         
           if( get_next_data == 1'b1) begin               
              rslt_reg =  rslt[rslt_rd_ptr_l];
              rslt_rd_ptr_l = rslt_rd_ptr_l +1;   

           end      
           //This logic is built to ignore the low-z event
           if ((check_x_z(rslt_reg[`LEFT_DATA])  == 1'b0) || (x_event_f == 1'b1))
             begin
                x_event_f = 1'b0;
             end else begin
                get_next_data = 1'b0;     
                x_event_f = 1'b1;   
             end
           //-----
           if (x_event_f == 1'b1) begin
              check_x; // this is dummy task
           end else begin   
              if (rslt_reg[`LEFT_DATA] === dql_check) begin
              `ifdef TSTMSG 
                 $display("%t Test Passed for dql.", $realtime);
                 $display("%t Expected dql = %h Actual dql = %h", $realtime, rslt_reg[`LEFT_DATA],dql_check);
               `endif  
              end else begin
                 $display("%t Test Failed for dql.", $realtime);
                 $display("%t Expected dql = %h Actual dql = %h", $realtime,rslt_reg[`LEFT_DATA],dql_check);
                 fail_flag = 1'b1;
              end
              get_next_data = 1'b1;    
              
           end 

        end
     end//always@dql_check

//Right Port Data bus is checked in this block

always@dqr_check
begin
 if ((reset_over_test == 1'b1) && (r_w_nr == 1'b1) )begin
    if (get_next_data_r == 1'b1) begin  
       rslt_reg_r =  rslt[rslt_rd_ptr_r];    
       rslt_rd_ptr_r = rslt_rd_ptr_r +1;   
    end 
        
    if ((check_x_z(rslt_reg_r[`RIGHT_DATA])== 1'b0)||(x_event_f_r == 1'b1))
      x_event_f_r = 1'b0;
    else begin
      get_next_data_r = 1'b0;     
      x_event_f_r = 1'b1;   
    end
   
    if (x_event_f_r == 1'b1) begin
      check_x;
    end else begin   
      if (rslt_reg_r[`RIGHT_DATA] === dqr_check) begin
      `ifdef TSTMSG 
         $display("%t Test Passed for dqr.", $realtime);
         $display("%t Expected dqr = %h Actual dqr = %h", $realtime, rslt_reg_r[`RIGHT_DATA], dqr_check);
      `endif 
      end else begin
        $display("%t Test Failed for dqr.", $realtime);
        $display("%t Expected dqr = %h Actual dqr = %h", $realtime, rslt_reg_r[`RIGHT_DATA], dqr_check);    
        fail_flag = 1'b1;
      end  
      get_next_data_r = 1'b1;
    end   
 end
end

//Left mailbox interrupt check
always@int_nl
    
  if (reset_over_test == 1'b1) begin
  
   if (int_nl == test_control_reg[`LEFT_INTR]) begin
     $display("%t Test Passed for Left Mailbox Interrupt", $realtime);
     $display("%t Expected int_nl = %h Actual int_nl = %h", $realtime,test_control_reg[`LEFT_INTR], int_nl);
   end else begin
     $display("%t Test Failed for int_nl.", $realtime);
     $display("%t Expected int_nl = %h Actual int_nl = %h", $realtime, test_control_reg[`LEFT_INTR], int_nl);
   end        
   
 end     

//Right mailbox interrupt check
always@int_nr
   if (reset_over_test == 1'b1) begin
   if (int_nr == test_control_reg[`RIGHT_INTR]) begin
     $display("%t Test Passed for Right Mailbox Interrupt", $realtime);
     $display("%t Expected int_nr = %h Actual int_nr = %h", $realtime, test_control_reg[`RIGHT_INTR], int_nr);
   end else begin
     $display("%t Test Failed for int_nr.", $realtime);
    $display("%t Expected int_nr = %h Actual int_nr = %h", $realtime, test_control_reg[`RIGHT_INTR], int_nr); 
   end  
 end     

 

//Clocks are generated here

   always begin
      #`tCH2 
      if (reset_over_test == 1'b1)
      clkl = ~clkl;
   end
   always @(posedge clkl )begin

      #`tCCS clkr = 1'b1;
   end
   always @(negedge clkl )begin

      # `tCCS clkr = 1'b0;
   end


//All test cases are run in this block
   initial
     begin
      $timeformat (-9, 1, " ns", 12);// defined  format of time parameter 
        initialize;
        //Testcase 1.1 : Check Reset Operation  
     $display("Testcase 1.1 : Master Reset");     
        MasterReset;
        power_on_reset = 0;

        repeat(6)
        @(posedge clkl);       
               
        $display("Testcase 1.2 : Read Left Port"); 
        ReadLeftPort;

        $display("Testcase 1.3 : Read Right Port");   
        ReadRightPort;
        
        $display("Testcase 1.4: Write Left Port");   
        WriteLeftPort;

        $display("Testcase 1.5: Write Right Port");   
        WriteRightPort;
        
        $display("Testcase 1.6: Late OE Read"); 
        LateOERead;
        
        repeat(2)
          @(posedge clkl);
       // $display("Testcase 2.1: 8 bytes enabled"); 
       // BytesEnabled8;


       // $display("Testcase 2.2: 4 bytes enabled"); 
       // BytesEnabled4;

        $display("Testcase 2.3: 2 bytes enabled"); 
        BytesEnabled2;

        $display("Testcase 2.4:  single byte read write"); 
        SingleByteReadWrite;


        $display("Testcase 3.1:  Simultaneous Read"); 
        SimultaneousRead;                   

        $display("Testcase 3.2:  Simultaneous Write"); 
        SimultaneousWrite;                   


        $display("Testcase 3.3:  Simultaneous Read Write"); 
        SimultaneousReadWrite;                   

        $display("Testcase 3.4:  Simultaneous Read Write  on Different Bytes "); 
        SimultaneousReadWriteDiffBytes;                   


        $display("Testcase 4.1:  Back To Back Read"); 
        BackToBackRead;

        @(posedge clkl);
        $display("Testcase 4.2:  Back To Back Write"); 
        BackToBackWrite;

        $display("Testcase 4.3:  Back To Back Read on different bytes"); 
        BackToBackReadDiffBytes;

        $display("Testcase 4.4:  Back To Back Write on different bytes"); 
        BackToBackWriteDiffBytes;

        @(posedge clkl);
        $display("Testcase 4.5:  Read To Write To Read"); 
        ReadToWriteToRead;


        $display("Testcase 5.1:  Simultaneous Back To Back Read "); 
        SimultaneousBackToBackRead;


        $display("Testcase 5.2:  Simultaneous Back To Back Write "); 
        SimultaneousBackToBackWrite;

        $display("Testcase 5.3:  Simultaneous Read to Write to Read "); 
        SimultaneousReadToWriteToRead;


        $display("Testcase 6.1:  Rd/ Wr Setup Violation"); 
        RdWrSetupViolation;

        $display("Testcase 6.2:  Byte Enable Setup Violation"); 
        ByteEnSetupViolation;

        $display("Testcase 6.3:  Address Setup Violation"); 
        AddressSetupViolation;


        $display("Testcase 7.2:  Byte Enable Hold Violation"); 
        ByteEnHoldViolation;

        $display("Testcase 7.3:  Address Hold Violation"); 
        AddressHoldViolation;

        $display("Testcase 7.4:   Data Hold Violation"); 
        DataHoldViolation;



        $display("Testcase 8.1:  Left Mailbox Interrupt"); 
        LeftPortMailboxInterrupt;

        $display("Testcase 8.2:  Right Mailbox Interrupt"); 
        RightPortMailboxInterrupt;

        $display("Testcase 8.3:  Master Reset Resets Interrupts");
        MasterResetIntr; 

        $display("Testcase 6.4:   Data Setup Violation"); 
        DataSetupViolation;

        $display("Testcase 7.1:  Rd/ Wr Hold Violation"); 
        RdWrHoldViolation; 
        if (fail_flag == 1'b0)
          $display("Regression Completed Successfully.");   
        else  
          $display("One or More test cases failed in regression.");     



        repeat(10)     
          @(posedge clkl);

        
  $finish; // Simulation over

end


endmodule

//=================================End OF File=================================================//










