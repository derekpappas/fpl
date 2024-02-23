
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

// *******************************************************************
// File           : fullflex72s18_rstlogic.v 
// Author         :
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
// This model will generate the reset to all the other blocks in the design
// And it will checks the reset period and asserts the ready signal
// *******************************************************************


 module fullflex72s18_rstlogic (iwmsg          ,
	                    inmrst         ,
                            ileft_clk      ,
                            iright_clk     ,
                            ileft_zq       ,
                            iright_zq      ,
                            ileft_cqen     ,
                            iright_cqen    ,
                            inleft_lowspd  ,
                            inright_lowspd ,
                            onreset        ,
                            onleft_ready   ,
                            onright_ready
                           );

  input    iwmsg;             // WARNING message ON input
  input    ileft_clk;         // left port clock input
  input    iright_clk;        // right port clock input
  input    inmrst;            // master reset input to the model
  input [1:0] ileft_zq;          // left port VIS output impedence matching input
  input [1:0] iright_zq;         // right port VIS output impedence matching input
  input    ileft_cqen;        // left port echo clock output enable
  input    iright_cqen;       // right port echo clock output enable
  input    inleft_lowspd;     // left port low speed select
  input    inright_lowspd;    // right port low speed select
  output   onreset;           // internal master reset signal
  output   onleft_ready;      // left port read output
  output   onright_ready;     // right port read output

  wire     mrst_int_n;        // internal master reset signal
  reg      ready_l_n;         // left port read output
  reg      ready_r_n;         // right port read output
  reg      mrst_delayed_n;    // reset input delayed by minimum reset pulse width
  reg      mrst_last;         // Buffers the last value of inmrst signal
  wire     num_clock_cycle_l; // Number of cycles for left  port READY# lock
  wire     num_clock_cycle_r; // Number of cycles for right port READY# lock
  integer  ready_lock_l;      // left port ready lock cycles
  integer  ready_lock_r;      // right port ready lock cycles
  integer  left_count;
  integer  right_count;
  realtime reset_assert_time; // Reset assertion time
  reg inmrst_1delay_l;
  reg inmrst_2delay_l;
  reg inmrst_3delay_l;
  reg inmrst_4delay_l;
  reg inmrst_5delay_l;
  reg inmrst_1delay_r;
  reg inmrst_2delay_r;
  reg inmrst_3delay_r;
  reg inmrst_4delay_r;
  reg inmrst_5delay_r;

  assign mrst_int_n        = inmrst || mrst_delayed_n;
  assign onreset           = mrst_int_n;
  assign num_clock_cycle_l = ((inleft_lowspd == 1'b0) && 
	                      (ileft_zq[0]  !== 1'b0) &&
			      (ileft_zq[1]  !== 1'b0) &&
			      (ileft_cqen  == 1'b0));
  assign num_clock_cycle_r = ((inright_lowspd == 1'b0) && 
	                      (iright_zq[0]  !== 1'b0) &&
			      (iright_zq[1]  !== 1'b0) &&
			      (iright_cqen == 1'b0));
  assign onleft_ready      = ready_l_n;
  assign onright_ready     = ready_r_n; 


  // Initialization
  initial
  begin
   ready_l_n         = 1'b1;
   ready_r_n         = 1'b1;
   mrst_delayed_n    = 1'b1;
   ready_lock_l      = 0;
   ready_lock_r      = 0;
   reset_assert_time = 0;
   mrst_last         = inmrst;
   inmrst_1delay_l   = 1'b1;
   inmrst_2delay_l   = 1'b1;
   inmrst_3delay_l   = 1'b1;
   inmrst_4delay_l   = 1'b1;
   inmrst_5delay_l   = 1'b1;
   inmrst_1delay_r   = 1'b1;
   inmrst_2delay_r   = 1'b1;
   inmrst_3delay_r   = 1'b1;
   inmrst_4delay_r   = 1'b1;
   inmrst_5delay_r   = 1'b1;
  end

  // Delaying inmrst with respect to left clock
  always @(posedge ileft_clk)
  begin
     inmrst_5delay_l = inmrst_4delay_l;
     inmrst_4delay_l = inmrst_3delay_l;
     inmrst_3delay_l = inmrst_2delay_l;
     inmrst_2delay_l = inmrst_1delay_l;
     inmrst_1delay_l = inmrst; 
  end

  // Delaying inmrst with respect to right clock
  always @(posedge iright_clk)
  begin
     inmrst_5delay_r = inmrst_4delay_r;
     inmrst_4delay_r = inmrst_3delay_r;
     inmrst_3delay_r = inmrst_2delay_r;
     inmrst_2delay_r = inmrst_1delay_r;
     inmrst_1delay_r = inmrst; 
  end

  // Check reset operation wrt left clock
  always @(negedge inmrst_5delay_l or inmrst)
  begin
    if(inmrst == 1'b1)
    begin
       mrst_delayed_n <= inmrst;
    end
    else if(!(TP.right_period_in_range == 1'b1 && inmrst_1delay_r == 1'b0 && inmrst_5delay_r == 1'b1))
    begin
        mrst_delayed_n <= inmrst_5delay_l;
    end
  end

  // Check reset operation wrt right clock
  always @(negedge inmrst_5delay_r or inmrst)
  begin
    if((inmrst == 1'b0) && (!(TP.left_period_in_range == 1'b1 && inmrst_1delay_l == 1'b0 && inmrst_5delay_l == 1'b1)))
    begin
        mrst_delayed_n <= inmrst_5delay_l;
    end
  end

  // This block tracks the reset time change
  always @(inmrst) 
  begin

    if(mrst_last !== inmrst)
    begin
      if(inmrst == 1'b0)
      begin
        reset_assert_time = $realtime;
      end
      else if(inmrst == 1'b1 && mrst_last == 1'b0)
      begin
        if(($realtime - reset_assert_time < TP.tRS && reset_assert_time != 0) && ((inmrst_5delay_l == 1'b1 && inmrst_1delay_l == 1'b0 && TP.left_period_in_range == 1'b1) || (inmrst_5delay_r == 1'b1 && inmrst_1delay_r == 1'b0 && TP.right_period_in_range == 1'b1)))
	begin
	  #0;
          if(iwmsg == 1'b1)
	  begin
	    $display($realtime, " WARNING: Reset pulse width is less than tRS. Model not reseted"); 
          end
	end
      end
      mrst_last = inmrst;
    end
  end

  // This block keep changing control the final ready assertion  
  always@(mrst_int_n or ileft_clk or iright_clk)
  begin 
    if(mrst_int_n ==1'b0)
    begin 
       ready_l_n <= 1'b1;
       ready_r_n <= 1'b1;
    end
  end
 
  // READY# signal update for Left port
  always @(posedge mrst_int_n) 
    begin 
    if(mrst_int_n == 1'b1) begin
      if($realtime > 0) 
      begin
        if(num_clock_cycle_l == 1'b1) 
        begin
           ready_lock_l = TP.tLOWLOCKTIME;
        end else if(num_clock_cycle_l == 1'b0)
	begin
           ready_lock_l = TP.tHIGHLOCKTIME;
        end

        left_count = 0;
        while(left_count <= ready_lock_l - 2)
        begin
           @(posedge ileft_clk);
           if(mrst_int_n == 1'b1) left_count = left_count + 1;
           else left_count = 0;
        end
        ready_l_n = 1'b0; 
      end
    end 
  end 
  
  // READY# signal update for Right port
  always @( posedge mrst_int_n) 
  begin 
    if(mrst_int_n == 1'b1) 
    begin
      if($realtime > 0) 
      begin
        if(num_clock_cycle_r == 1'b1) 
        begin
           ready_lock_r = TP.tLOWLOCKTIME;
        end else if(num_clock_cycle_l == 1'b0)
	begin
           ready_lock_r = TP.tHIGHLOCKTIME;
        end
        right_count = 0;

        while(right_count <= ready_lock_r - 2)
        begin
           @(posedge iright_clk);
           if(mrst_int_n == 1'b1) right_count = right_count + 1;
           else right_count = 0;
        end
        ready_r_n = 1'b0; 
      end
    end 
  end 
  
endmodule



