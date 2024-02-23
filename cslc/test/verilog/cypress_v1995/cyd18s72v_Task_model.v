// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// ----------------------------------------------------------------------------------------
// File Name : cyd18s72v_Task_model.v                                                    
// Version : 0.1                                                                           
// Status : Module is Complete                                                             
// ----------------------------------------------------------------------------------------
// Author : Ashlesha Gokhale                                                               
// E-mail : ashlesha.gokhale@wipro.com                                                     
// Company : Wipro Technologies                                                            
// Creation date : May, 12, 2003                                                           
// ----------------------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale                                                     
// Last modified on : May 12, 2003                                                         
// ----------------------------------------------------------------------------------------
// Dependencies : NONE                                                                     
// Description  : This file contains the tasks  used in the model for unknown handling,    
//                timings checks, read and write.                                          
//-----------------------------------------------------------------------------------------
// Simulation Notes : NA                                                                   
// Application Note : NA                                                                   
// Simulator : verilog xl.                                                                 
// Terms & concepts :                                                                      
// Open issues and future enhancements : None                                              
// References :                                                                            
// Revision History :                                                                      
// Rev  Author    Phone           Date           Changes                                   
// ----------------------------------------------------------------------------------------
//0.1   Ashlesha  2933700.2074    09.05.2003       New file                                
//                                                                                         
//-----------------------------------------------------------------------------------------
                                                                                           
                                                                                           
                                                                                           
//-----------------------------------------------------------------------------------------
// Function:    chk_x_r_w                                                                  
//                                                                                         
// Description: Checks for any single unknown value on the r_w pin                         
//              and returns '1' if found x, otherwise '0'.                                 
//-----------------------------------------------------------------------------------------

function chk_x_r_w;

      input [50:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : No operation will be performed");               
            chk_x_r_w = 1;
         end else begin
            chk_x_r_w = 0;
         end
      end
endfunction // chk_x_r_w


//-----------------------------------------------------------------------------------------------
// Function:    chk_x_b
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_b;

      input [30:0]     pin_name;      
      input [`BT_M:0]  val;

      begin      
         
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : No operation will be performed");               
            chk_x_b = 1;
         end else begin
            chk_x_b = 0;
         end
      end
endfunction // chk_x_b

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_oe
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_oe;

      input [40:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : No operation will be performed");               
            chk_x_oe = 1;
         end else begin
            chk_x_oe = 0;
         end
      end
endfunction // chk_x_oe

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_dq
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_dq;

      input [30:0]     pin_name;      
      input [`DT_M:0]  val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            chk_x_dq = 1;
         end else begin
            chk_x_dq = 0;
         end
      end
endfunction // chk_x_dq

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_a
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_a;

      input [20:0]     pin_name;      
      input [`AD_M:0]  val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display("\t\t No Operation will be performed");
            chk_x_a = 1;
         end else begin
            chk_x_a = 0;
         end
      end
endfunction // chk_x_a

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Function:    reset_chk_fn
//
// Description: Checks whether reset is over or not ? and returns 1 if it's reset.
//-----------------------------------------------------------------------------------------------
/*
function reset_chk_fn;
       begin
         if (reset_over_l == 1'b0) begin
            if (TmsgOn) $display("%t Operating the device without performing Reset operation:", $realtime);
            if (TmsgOn) $display("\t\t Reset the device to function properly\n");
            reset_chk_fn = 1'b0;
         end else begin
            reset_chk_fn = 1'b1;
         end
      end
endfunction // reset_chk_fn
*/
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Function:    read_data_and_tCCS_chk_fn
//
// Description: Checks tCCS violation while accessing same memory location simultaneously
//               by two ports.
//              Performs read operation. 
//              Returns vaild data to be read. 
//-----------------------------------------------------------------------------------------------

function [`DT_M : 0] read_data_and_tCCS_chk_fn;
      input port;
      begin
         if (port == `LEFT) begin 
            if ((($realtime - tCCS_chk) < tCCS) && !(last_access_type == `READ)) begin
               if (last_addr == al) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Reading the same memory location from Left port:", $realtime);
                  if (TmsgOn) $display("\t\t Data Output is unpredictable");
                  read_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
               end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Left port ", $realtime);
                  read_data_and_tCCS_chk_fn[`DT_M:0] = mem[al];
               end                  
            end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Left port ", $realtime);

               read_data_and_tCCS_chk_fn[`DT_M:0] = mem[al];

            end
            last_addr = al;
            last_opernl_p1 = `READ;            
         end else begin
            if ((($realtime - tCCS_chk) < tCCS) && !(last_access_type == `READ)) begin
               if (last_addr == ar) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Reading the same memory location from Right port:", $realtime);
                  if (TmsgOn) $display("\t\t Data Output is unpredictable");
                  read_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
               end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Right port ", $realtime);               
                  read_data_and_tCCS_chk_fn[`DT_M:0] = mem[ar];
               end                  
            end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Right port ", $realtime);
               
               read_data_and_tCCS_chk_fn[`DT_M:0] = mem[ar];

            end
            last_addr = ar;
            last_opernr_p1 = `READ;                        
         end
         tCCS_chk = $realtime;
         last_access_type = `READ;
      end
endfunction // read_data_and_tCCS_chk_fn


//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Function:    write_data_and_tCCS_chk_fn
//
// Description: Checks tCCS violation while accessing same memory location simultaneously
//               by two ports.
//              Performs write operation. 
//              Returns vaild data to be written. 
//-----------------------------------------------------------------------------------------------


function [`DT_M : 0] write_data_and_tCCS_chk_fn;
      input port;
      begin
         if (port == `LEFT) begin 
            if (($realtime - tCCS_chk) < tCCS) begin
               if (last_addr == al) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Writing to the same memory location from Left port:", $realtime);
                  if (last_access_type == `WRITE) begin
                     if (TmsgOn) $display("\t\t\t Invalid Data is Written at  %h  ", al);
                     write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'bx;   
                  end else begin
                     write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
                  end
               end else begin
                  if (OmsgOn) $display("%t \t\t Writing Data on Left port ", $realtime);
                  write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
               end
            end else begin
               if (OmsgOn) $display("%t \t\t Writing Data on Left port ", $realtime);               
               write_data_and_tCCS_chk_fn[`DT_M:0] = dql;

            end
            last_addr = al;
            last_opernl_p1 = `WRITE;            
         end else begin
            if (($realtime - tCCS_chk) < tCCS) begin
               if (last_addr == ar) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Writing to the same memory location from Right port:", $realtime);
                  if (last_access_type == `WRITE) begin
                     if (TmsgOn) $display("\t\t\t Invalid Data is Written at  %h  ", ar);
                     write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;               
                  end else begin
                     write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
                  end
               end else begin
                  if (OmsgOn) $display("%t \t\t Writing Data on Right port ", $realtime);                
                  write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
               end                  
            end else begin
                  if (OmsgOn) $display("%t \t\t Writing Data on Right port ", $realtime);                
               write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
            end
            last_addr = ar;         
            last_opernr_p1 = `WRITE;            
         end
         tCCS_chk = $realtime;
         last_access_type = `WRITE;
      end
endfunction // write_data_and_tCCS_chk_fn


//-----------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------
// task:        event_reset
//
// Description: Resets all the event variables to zero 
//
//-----------------------------------------------------------------------------------------------

task event_reset;
      begin
         dql_event = 0;
         dqr_event = 0;
         clkl_event = 0;
         clkr_event = 0;
         mrst_n_event = 0;
         al_event = 0;
         ar_event = 0;
         oe_nl_event = 0;
         oe_nr_event = 0;
         r_w_nl_event = 0;
         r_w_nr_event = 0;
         b_nl_event = 0;
         b_nr_event = 0;
         // internal pins

         
      end
endtask // event_reset

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        pv_reset
//
// Description: Resets all the previous value variables to zero 
//
//-----------------------------------------------------------------------------------------------

task pv_reset;
      begin
         dql_pv = 0;
         dqr_pv = 0;
         clkl_pv = 0; 
         clkr_pv = 0;
         mrst_n_pv = 0;
         al_pv = 0;
         ar_pv = 0;
         oe_nl_pv = 0;
         oe_nr_pv = 0;
         r_w_nl_pv = 0;
         r_w_nr_pv = 0;
         b_nl_pv = 0;
         b_nr_pv = 0;
         // internal pins

         
      end
endtask // pv_reset

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        event_chk
//
// Description: Checks whether the event has occurred or not on all the input pins
//
//-----------------------------------------------------------------------------------------------

task event_chk;
      begin
         dql_event = (dql_pv !== dql);
         dqr_event = (dqr_pv !== dqr);
         clkl_event = (clkl_pv !== clkl);
         clkr_event = (clkr_pv !== clkr);
         mrst_n_event = (mrst_n_pv !== mrst_n);
         al_event = (al_pv !== al);
         ar_event = (ar_pv !== ar);
         oe_nl_event = (oe_nl_pv !== oe_nl);
         oe_nr_event = (oe_nr_pv !== oe_nr);
         r_w_nl_event = (r_w_nl_pv !== r_w_nl);
         r_w_nr_event = (r_w_nr_pv !== r_w_nr);
         b_nl_event = (b_nl_pv !== b_nl);
         b_nr_event = (b_nr_pv !== b_nr);
         // internal pins
           
      end
endtask // event_chk

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        pv_assign
//
// Description: Assigns the current values of all the pins to their respective 
//              previous value variables
//
//-----------------------------------------------------------------------------------------------

task pv_assign;
      begin
         dql_pv = dql;
         dqr_pv = dqr;         
         clkl_pv = clkl;
         clkr_pv = clkr;
         mrst_n_pv = mrst_n;
         al_pv = al;
         ar_pv = ar;
         oe_nl_pv = oe_nl;
         oe_nr_pv = oe_nr;
         r_w_nl_pv = r_w_nl;
         r_w_nr_pv = r_w_nr;
         b_nl_pv = b_nl;
         b_nr_pv = b_nr;
         // internal pins
         
      end
endtask // pv_assign


//-----------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
// task:        timing_chk
//
// Description: Checks setup and hold violations for the input pins
//
//-------------------------------------------------------------------------------
task timing_chk;
begin

    //-----------------------------------------------------------------
    // Clock High time check
    //-----------------------------------------------------------------
    if (clkl_event && (clkl === 1'b0)) begin
        if ((($realtime - rising_edge_clk_l) < tCH2) && ($realtime > 0)) begin
            if (TmsgOn) $display ("%t WARNING : CLK_L Clock High time - tCH2 violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
            
        end
        falling_edge_clk_l = $realtime;
    end
    if (clkr_event && (clkr === 1'b0)) begin
        if ((($realtime - rising_edge_clk_r) < tCH2) && ($realtime > 0) && ($realtime > 0)) begin
            if (TmsgOn) $display("%t WARNING : CLK_R Clock High time - tCH2 violation.",$realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end
        falling_edge_clk_r = $realtime;
    end

         
         
      
    //------------------------------------------------------------------------------
    //                  Hold violation checks
    //------------------------------------------------------------------------------

    //----------------------------------------------
    // HOLD Time violation checks for left port
    //----------------------------------------------
    
    
    // Address hold time
    if (al_event  ) begin
        if ((($realtime - rising_edge_clk_l) < tHA ) && setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CLK_L to A_L Hold time - tHA violation.", $realtime);
            no_grnt_msg;
            hold_violation_l = 1'b1;   
            addr_hold_violation_l = 1'b1;
            al_prev = al_pv; 
        end
        addr_last_change_l = $realtime;
    end
     
    // Byte select hold time
     if (b_nl_event) begin
        if ((($realtime - rising_edge_clk_l) < tHB )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CLK_L to B_L Hold time - tHB violation.", $realtime);
            no_grnt_msg;
            hold_violation_l = 1'b1;   

        end
        
         if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
            if (TmsgOn) $display ("%t WARNING : MRST to B_L Hold time - tRSR violation.", $realtime);
            no_grnt_msg;
            hold_violation_l = 1'b1;   

        end
        byte_sel_last_change_l = $realtime;
    end
    
    // R/W Hold time
    if (r_w_nl_event) begin
        if ((($realtime - rising_edge_clk_l) < tHW )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CLK_L to R/W_L Hold time - tHW violation", $realtime);
            no_grnt_msg;
            hold_violation_l = 1'b1;   
            r_w_hold_violation_l = 1'b1;
        end
        if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
            if (TmsgOn) $display ("%t WARNING : MRST to R/W_L Hold time - tRSR violation.", $realtime);
            no_grnt_msg;
            hold_violation_l = 1'b1;   

        end
        rw_last_change_l = $realtime;
    end
    
    
    
         
     // Input Data hold time
     if (dql_event) begin
         if ((($realtime - rising_edge_clk_l) < tHD )&& (setup_hold_chk) && (r_w_nl === 0)) begin
             if (TmsgOn) $display ("%t WARNING : CLK_L to DQ_L Hold time - tHD violation.", $realtime);
             no_grnt_msg;
             hold_violation_l = 1'b1;   

         end
         dq_last_change_l = $realtime;
     end


     //-----------------------------------------------
     // HOLD Time violation checks for right port
     //-----------------------------------------------
     
     // Address hold time                             
     if (ar_event) begin
         if ((($realtime - rising_edge_clk_r) < tHA )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to A_R Hold time - tHA violation.", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;   
             addr_hold_violation_r = 1'b1;
             ar_prev = ar_pv; 
        end
        addr_last_change_r = $realtime;
     end
     
     
     // Byte select hold time
     if (b_nr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHB )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to B_R Hold time - tHB violation.", $realtime);
             no_grnt_msg;
                        hold_violation_r = 1'b1;   

         end
         if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
             if (TmsgOn) $display ("%t WARNING : MRST to B_R Hold time - tRSR violation.", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;   

         end
         byte_sel_last_change_r = $realtime;
     end
    
     // R/W Hold time
     if (r_w_nr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHW )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to R/W_R Hold time - tHW violation", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;   
             r_w_hold_violation_r = 1'b1;
         end
         if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
             if (TmsgOn) $display ("%t WARNING : MRST to R/W_R Hold time - tRSR violation.", $realtime);
                no_grnt_msg;
                hold_violation_r = 1'b1;   
                r_w_hold_violation_r = 1'b1;
         end
         rw_last_change_r = $realtime;
     end
    


    
     
     // Input Data hold time
     if (dqr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHD )&& (setup_hold_chk) && (r_w_nr === 0)) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to DQ_R Hold time - tHD violation.", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;   

         end
         dq_last_change_r = $realtime;
     end

    
    
     //------------------------------------------------------------
     // Master Reset timings check
     //------------------------------------------------------------
     if (mrst_n_event && (mrst_n === 1'b0)) begin
         falling_edge_mrst = $realtime;
     end
     
     if (mrst_n_event && (mrst_n === 1'b1)) begin
         rising_edge_mrst = $realtime;
         // Master reset pulse width tRS check
         if (((rising_edge_mrst - falling_edge_mrst) < tRS ) && ($realtime > tRS)) begin
             if (TmsgOn) $display("%t WARNING : Master Reset Pulse Width - tRS violation.", $realtime);
             no_grnt_msg;
         end
     
         // Master reset setup time checks - tRSS
         if (((rising_edge_mrst - byte_sel_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
             if (TmsgOn) $display ("%t WARNING : Master Reset to B_L Setup time - tRSS violation.", $realtime);
             no_grnt_msg;
         end

         if (((rising_edge_mrst - rw_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
             if (TmsgOn) $display ("%t WARNING : Master Reset to R/W_L Setup time - tRSS violation.", $realtime);
             no_grnt_msg;
         end
         
         // Right port pins
         
         if (((rising_edge_mrst - byte_sel_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
             if (TmsgOn)$display("%t WARNING : Master Reset to B_R Setup time - tRSS violation.", $realtime);
             no_grnt_msg;
         end
         
         if (((rising_edge_mrst - rw_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
             if (TmsgOn)$display("%t WARNING : Master Reset to R/W_R Setup time - tRSS violation.", $realtime);
             no_grnt_msg;
         end
         
     end // if (mrst_n_event && (mrst === 1'b1))
end  
endtask // timing_chk

task setup_check_l;
begin
    //---------------------------------------------------------------------------
    //Setup timing checks for left port
    //---------------------------------------------------------------------------
        if ((($realtime - rising_edge_clk_l) < tCYC2) && ($realtime > tCYC2)) begin
            if (TmsgOn) $display ("%t WARNING : CLK_L Clock cycle time - tCYC2 violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end
        rising_edge_clk_l = $realtime;
        //Clock low time check
        if (((rising_edge_clk_l - falling_edge_clk_l) < tCL2) && ($realtime > tCL2)) begin
            if (TmsgOn) $display("%t WARNING : CLK_L Clock LOW time - tCL2 violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end
       
          // Address setup time check

        if (((rising_edge_clk_l - addr_last_change_l) < tSA)&& setup_hold_chk)begin
           
            if (TmsgOn) $display ("%t WARNING : A_L to CLK_L Setup time - tSA violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end

        // Byte select setup time
        if (((rising_edge_clk_l - byte_sel_last_change_l) < tSB )&& setup_hold_chk)  begin
            if (TmsgOn) $display ("%t WARNING : B_L to CLK_L Setup time - tSB violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end

        // R/W Setup time
        if (((rising_edge_clk_l - rw_last_change_l) < tSW )&& setup_hold_chk) begin
            if (TmsgOn) $display("%t WARNING : R/W_L to CLK_L Setup time - tSW violation", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end


        // Input Data setup time
        if (((rising_edge_clk_l - dq_last_change_l) < tSD )&& (setup_hold_chk) && (r_w_nl === 0)) begin
            if (TmsgOn) $display ("%t WARNING : DQ_L to CLK_L Setup time - tSD violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end



    

end
endtask // setup_check_l;

task setup_check_r;

begin
    //----------------------------------------------------------------------
    //Setup timing checks for Right port
    //----------------------------------------------------------------------
   
    // Clock cycle time 
        if ((($realtime - rising_edge_clk_r) < tCYC2) && ($realtime > tCYC2)) begin
            if (TmsgOn) $display ("%t WARNING : CLK_R Clock cycle time - tCYC2 violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end
        rising_edge_clk_r = $realtime;
        //Clock low time check
        if (((rising_edge_clk_r - falling_edge_clk_r) < tCL2) && ($realtime > tCL2))begin
            if (TmsgOn) $display ("%t WARNING : CLK_R Clock LOW time - tCL2 violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end
            
        // Address setup time check

        if (((rising_edge_clk_r - addr_last_change_r) < tSA )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : A_R to CLK_R Setup time - tSA violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end

        // Byte select setup time
        if (((rising_edge_clk_r - byte_sel_last_change_r) < tSB )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : B_R to CLK_R Setup time - tSB violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end

        // R/W Setup time
        
        if (((rising_edge_clk_r - rw_last_change_r) < tSW )&& setup_hold_chk) begin

            if (TmsgOn) $display ("%t WARNING : R/W_R to CLK_R Setup time - tSW violation", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end




        // Input Data setup time
        if (((rising_edge_clk_r - dq_last_change_r) < tSD )&& (setup_hold_chk) && (r_w_nr === 0)) begin
            if (TmsgOn) $display ("%t WARNING : DQ_R to CLK_R Setup time - tSD violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end

    

end 
endtask

task no_grnt_msg;
      if (TmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
endtask // no_grnt_msg

//================================ End OF File ====================================================//
