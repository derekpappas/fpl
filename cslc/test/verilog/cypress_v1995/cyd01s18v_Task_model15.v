// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro
// Technologies.
// ------------------------------------------------------------------------------
// File Name : cyd01s36v_Task_model.v 
// Version : 0.1
// Status : Module is Complete                                                   
// ------------------------------------------------------------------------------
// Author : Ashlesha Gokhale                                                     
// E-mail : ashlesha.gokhale@wipro.com                                           
// Company : Wipro Technologies                                                  
// Creation date : April,08,2004                                                
// ------------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale                                           
// Last modified on : April 08,2004                                              
// ------------------------------------------------------------------------------
// Dependencies : NONE                                                          
// Description  : This file contains the tasks  used in the model for unknown 
//                handling,timings checks, read and write.                       
//-------------------------------------------------------------------------------
// Simulation Notes : NA                                                         
// Application Note : NA           
// Simulator : verilog xl.                                              
// Terms & concepts :                                                 
// Open issues and future enhancements : None   
// References :                                                               
// Revision History :                                                            
// Rev  Author    Phone           Date           Changes                        
//-------------------------------------------------------------------------------
//0.1   Ashlesha  22933700.2074    08.04.2004       New file             
//-------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Function:    chk_x_ce                                                        
//                                                                              
// Description: Checks for any single unknown value on the ce0, ce1 pin          
//              and returns '1' if found x, otherwise '0'.                       
//-------------------------------------------------------------------------------
function chk_x_ce;
input [50:0]     pin_name;      
input            val;
begin      
    if (val === 1'bx) begin
        if (XmsgOn) 
            $display("%t WARNING : Unknown value on %s:",$realtime, pin_name);
        if (XmsgOn) 
            $display("\t\t WARNING : No operation will be performed");
        chk_x_ce = 1;
    end else begin
        chk_x_ce = 0;
    end
end
endfunction // chk_x_ce




//------------------------------------------------------------------------------
// Function:    chk_x_r_w                                                        
//                                                                              
// Description: Checks for any single unknown value on the r_w pin              
//              and returns '1' if found x, otherwise '0'.                       
//-------------------------------------------------------------------------------
function chk_x_r_w;
input [50:0]     pin_name;      
input            val;
begin      
    if (^val === 1'bx) begin
        if (XmsgOn) 
            $display("%t WARNING : Unknown value on %s:",$realtime, pin_name);
        if (XmsgOn) 
            $display("\t\t WARNING : No operation will be performed");
        chk_x_r_w = 1;
    end else begin
        chk_x_r_w = 0;
    end
end
endfunction // chk_x_r_w


//-------------------------------------------------------------------------------
// Function:    chk_x_b
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-------------------------------------------------------------------------------

function chk_x_b;
input [30:0]     pin_name;      
input [`BT_M:0]  val;
begin      
    if (^val === 1'bx) begin
        if (XmsgOn) 
            $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
        if (XmsgOn) 
            $display ("\t\t WARNING : No operation will be performed");               
        chk_x_b = 1;
    end else begin
        chk_x_b = 0;
    end
end
endfunction // chk_x_b

//-------------------------------------------------------------------------------
// Function:    chk_x_oe
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-------------------------------------------------------------------------------

function chk_x_oe;
input [40:0]     pin_name;      
input            val;
begin      
    if (^val === 1'bx) begin
        if (XmsgOn) 
            $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
        if (XmsgOn) 
            $display ("\t\t WARNING : No operation will be performed");              
        chk_x_oe = 1;
    end else begin
        chk_x_oe = 0;
    end
  end
endfunction // chk_x_oe

//-------------------------------------------------------------------------------
// Function:    chk_x_dq
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-------------------------------------------------------------------------------
function chk_x_dq;
input [30:0]     pin_name;      
input [`DT_M:0]  val;

begin      
    if (^val === 1'bx) begin
        if (XmsgOn) 
            $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
        chk_x_dq = 1;
    end else begin
        chk_x_dq = 0;
    end
end
endfunction // chk_x_dq

//-------------------------------------------------------------------------------
// Function:    chk_x_a
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-------------------------------------------------------------------------------

function chk_x_a;
input [20:0]     pin_name;      
input [`AD_M:0]  val;
begin      
    if (^val === 1'bx) begin
        if (XmsgOn) 
            $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
        if (XmsgOn)
            $display("\t\t No Operation will be performed");
        chk_x_a = 1;
   end else begin
        chk_x_a = 0;
   end
end
endfunction // chk_x_a

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Function:    chk_x                                                        
//                                                                              
// Description: Checks for any single unknown value on the  pin "pin_name"  
//              and returns '1' if found x, otherwise '0'.                       
//-------------------------------------------------------------------------------
function chk_x;
input [50:0]     pin_name;      
input            val;
begin      
    if (^val === 1'bx) begin
        if (XmsgOn) 
            $display("%t WARNING : Unknown value on %s:",$realtime, pin_name);
        if (XmsgOn) 
            $display("\t\t WARNING : No operation will be performed");
        chk_x = 1;
    end else begin
        chk_x = 0;
    end
end
endfunction // chk_x





//------------------------------------------------------------------------------
// Function:    reset_chk_fn
//
// Description: Checks whether reset is over or not and returns 1 if it's reset.
//-------------------------------------------------------------------------------

function reset_chk_fn;
input i;
begin
    if (reset_over_l == 1'b0) begin
        if (TmsgOn) 
            $display("%t Operating the device without performing Reset operation:", $realtime);
        if (TmsgOn) 
            $display("\t\t Reset the device to function properly\n");
        reset_chk_fn = 1'b0;
    end else begin
        reset_chk_fn = 1'b1;
    end
end
endfunction // reset_chk_fn

//-------------------------------------------------------------------------------
// Function:    read_data_and_tCCS_chk_fn
//
// Description: Checks tCCS violation while accessing same memory location 
//              simultaneously  by two ports.
//              Performs read operation. 
//              Returns vaild data to be read. 
//-------------------------------------------------------------------------------
function [`DT_M : 0] read_data_and_tCCS_chk_fn;
input port;
begin
    if (port == `LEFT) begin 
        if ((($realtime - tCCS_chk) < tCCS) && !(last_access_type == `READ)) begin
            if (last_addr == address_l) begin
                if (TmsgOn)
                    $display("%t WARNING : Violating tCCS while Reading the same memory location from Left port:", 
                    $realtime);
                if (TmsgOn) 
                    $display("\t\t Data Output is unpredictable");
                read_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
            end else begin
                if (OmsgOn) 
                    $display("%t \t\t Reading Data from Left port ", $realtime);
                read_data_and_tCCS_chk_fn[`DT_M:0] = mem[address_l];
            end                  
        end else begin // No violation 
            if (OmsgOn) $display("%t \t\t Reading Data from Left port ", $realtime);
            read_data_and_tCCS_chk_fn[`DT_M:0] = mem[address_l];
            //$display("read data = %h at mem %h", mem[address_l], address_l);
        end
        last_addr = address_l;
        last_opernl_p1 = `READ;            
    end else begin // if right port
        if ((($realtime - tCCS_chk) < tCCS) && !(last_access_type == `READ)) begin
            if (last_addr == address_r) begin
                if (TmsgOn)
                    $display("%t WARNING : Violating tCCS while Reading the same memory location from Right port:", 
                    $realtime);
                if (TmsgOn) $display("\t\t Data Output is unpredictable");
                read_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
            end else begin // address is different
                if (OmsgOn) $display("%t \t\t Reading Data from Right port ",$realtime);
                read_data_and_tCCS_chk_fn[`DT_M:0] = mem[address_r];
            end                  
        end else begin
            if (OmsgOn)
                $display("%t \t\t Reading Data from Right port ", $realtime);
            read_data_and_tCCS_chk_fn[`DT_M:0] = mem[address_r];
        end
        last_addr = address_r;
        last_opernr_p1 = `READ;                        
    end
    tCCS_chk = $realtime;
    last_access_type = `READ;
end
endfunction // read_data_and_tCCS_chk_fn


//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Function:    write_data_and_tCCS_chk_fn
// Description: Checks tCCS violation while accessing same memory location 
//              simultaneously by two ports. Performs write operation. 
//              Returns vaild data to be written. 
//------------------------------------------------------------------------------
function [`DT_M : 0] write_data_and_tCCS_chk_fn;
input port;
begin
if ((hold_violation_l !== 1'b1) && (hold_violation_r !== 1'b1))begin
    if (port == `LEFT) begin 
        if (($realtime - tCCS_chk) < tCCS) begin
             if (last_addr == address_l) begin
                 if (TmsgOn)
                     $display("%t WARNING : Violating tCCS while Writing to the same memory location from Left port:", 
                     $realtime);
                 if (last_access_type == `WRITE) begin
                     if (TmsgOn) $display("\t\t\t Invalid Data is Written at  %h", address_l);
                     write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'bx;   
                 end else begin
                     write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
                 end
             end else begin
                 if (OmsgOn) $display("%t \t\t Writing Data on Left port", $realtime);
                 write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
             end
        end else begin
            if (OmsgOn) $display("%t \t\t Writing Data on Left port", $realtime);
            write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
        end
        last_addr = address_l;
        last_opernl_p1 = `WRITE;            
    end else begin
        if (($realtime - tCCS_chk) < tCCS) begin
            if (last_addr == address_r) begin
                if (TmsgOn) 
                    $display("%t WARNING : Violating tCCS while Writing to the same memory location from Right port:", 
                    $realtime);
                if (last_access_type == `WRITE) begin
                    if (TmsgOn) $display("\t\t\t Invalid Data is Written %h  ", address_r);
                    write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;               
                end else begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
                end
            end else begin
                if (OmsgOn)$display("%t \t\t Writing Data on Right port", $realtime);
                write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
            end                  
        end else begin
            if (OmsgOn) $display("%t \t\t Writing Data on Right port ", $realtime);
                write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
        end
        last_addr = address_r;         
        last_opernr_p1 = `WRITE;            
    end
    tCCS_chk = $realtime;
    last_access_type = `WRITE;
end
end
endfunction // write_data_and_tCCS_chk_fn


//-------------------------------------------------------------------------------


//-------------------------------------------------------------------------------
// task:        event_reset
//
// Description: Resets all the event variables to zero 
//
//-----------------------------------------------------------------------------

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
     ce0_nl_event = 0;
     ce0_nr_event = 0; 
     ce1_l_event = 0;
     ce1_r_event = 0; 
     ads_nl_event=0;
     ads_nr_event= 0;
     ce0_nl_event= 0;
     ce0_nr_event= 0;
     ce1_l_event= 0;
     ce1_r_event= 0;
     cnten_nl_event= 0;
     cnten_nr_event= 0;
     cntrst_nl_event= 0;
     cntrst_nr_event= 0;
     cnt_msk_nl_event= 0;
     cnt_msk_nr_event= 0;
     
 end
endtask // event_reset

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
// task:        pv_reset
//
// Description: Resets all the previous value variables to zero 
//
//-------------------------------------------------------------------------------

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
    ce0_nl_pv = 0;
    ce0_nr_pv = 0;
    ce1_l_pv = 0;
    ce1_r_pv = 0;
    ads_nl_pv= 0;     
    ads_nr_pv= 0;     
    cnten_nl_pv= 0;   
    cnten_nr_pv= 0;   
    cntrst_nl_pv= 0;  
    cntrst_nr_pv= 0;  
    cnt_msk_nl_pv= 0; 
    cnt_msk_nr_pv= 0; 


    // internal pins
end
endtask // pv_reset

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
// task:        event_chk
//
// Description:Checks whether the event has occurred or not on all the input pins
//-------------------------------------------------------------------------------
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
     ce0_nl_event = (ce0_nl_pv !== ce0_nl);
     ce0_nr_event = (ce0_nr_pv !== ce0_nr);
     ce1_l_event =  (ce1_l_pv !== ce1_l);
     ce1_r_event =  (ce1_r_pv !== ce1_r);    
     ads_nl_event =    (ads_nl_pv !== ads_nl);
     ads_nr_event =    (ads_nr_pv !== ads_nr);
     cnten_nl_event =  (cnten_nl_pv !== cnten_nl);
     cnten_nr_event =  (cnten_nr_pv !== cnten_nr);
     cntrst_nl_event = (cntrst_nl_pv !== cntrst_nl);
     cntrst_nr_event = (cntrst_nr_pv !== cntrst_nr);
     cnt_msk_nl_event =(cnt_msk_nl_pv !== cnt_msk_nl);
     cnt_msk_nr_event =(cnt_msk_nr_pv !== cnt_msk_nr);
end
endtask // event_chk

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
// task:        pv_assign
//
// Description: Assigns the current values of all the pins to their respective 
//              previous value variables
//
//-------------------------------------------------------------------------------

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
     ce0_nl_pv = ce0_nl;       
     ce0_nr_pv = ce0_nr;  
     ce1_l_pv = ce1_l;    
     ce1_r_pv = ce1_r;    
     ads_nl_pv = ads_nl;    
     ads_nr_pv = ads_nr;    
     cnten_nl_pv = cnten_nl;
     cnten_nr_pv = cnten_nr;
     cntrst_nl_pv = cntrst_nl;
     cntrst_nr_pv = cntrst_nr;
     cnt_msk_nl_pv = cnt_msk_nl;
     cnt_msk_nr_pv = cnt_msk_nr;



     // internal pins
     
end
endtask // pv_assign


//-------------------------------------------------------------------------------

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
    if (al_event  && ((last_opernl_p2 !== `COUNTERREADBACK) && (last_opernl_p2 !== `MASKREADBACK))  ) begin
        if ((ads_nl == 1'b0) && (cnten_nl == 1'b0)) begin
           if ((($realtime - rising_edge_clk_l) < tHA ) && setup_hold_chk) begin
              if (TmsgOn) $display ("%t WARNING : CLK_L to A_L Hold time - tHA violation.", $realtime);
                 no_grnt_msg;
                 hold_violation_l = 1'b1;
                 addr_hold_violation_l = 1'b1;
                 al_prev = al_pv; 
           end
           addr_last_change_l = $realtime;
        end
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
    
    // CE Hold time
    if (ce0_nl_event) begin
        if ((($realtime - rising_edge_clk_l) < tHC )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CLK_L to CE0_L Hold time - tHC violation", $realtime);
            no_grnt_msg;
            if (ce0_nl == 1'b1)
                hold_violation_l = 1'b1;

        end
        if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
            if (TmsgOn) $display ("%t WARNING : MRST to CE0_L Hold time - tRSR violation.", $realtime);
            no_grnt_msg;

        end
        ce0_last_change_l = $realtime;
     end
    
     if (ce1_l_event) begin
         if ((($realtime - rising_edge_clk_l) < tHC )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_L to CE1_L Hold time - tHC violation", $realtime);
             no_grnt_msg;
             if (ce1_l == 1'b0)
                hold_violation_l = 1'b1;

         end
         if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
             if (TmsgOn) $display ("%t WARNING : MRST to CE1_L Hold time - tRSR violation.", $realtime);
             no_grnt_msg;
             hold_violation_l = 1'b1;

         end
         ce1_last_change_l = $realtime;
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
     if (ads_nl_event) begin
         if ((($realtime - rising_edge_clk_l) < tHAD )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_L to ADS_NL Hold time - tHC violation", $realtime);
             no_grnt_msg;
             hold_violation_l = 1'b1;
             if (cnt_msk_nl == 1'b0)
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
             
         end
         ads_last_change_l = $realtime;
     end
 
     if (cnten_nl_event) begin
         if ((($realtime - rising_edge_clk_l) < tHCN )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_L to CNTEN_NL Hold time - tHCN violation", $realtime);
             no_grnt_msg;
             hold_violation_l = 1'b1;
             if (cnt_msk_nl == 1'b0) 
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
           

         end
         cnten_last_change_l = $realtime;
     end
     if (cntrst_nl_event) begin
         if ((($realtime - rising_edge_clk_l) < tHRST )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_L to CNTRST_NL Hold time - tHRST violation", $realtime);
             no_grnt_msg;
             hold_violation_l = 1'b1;
             if (cnt_msk_nl == 1'b0) 
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
                                    
         end
         cntrst_last_change_l = $realtime;
         
     end
     if (cnt_msk_nl_event) begin
         if ((($realtime - rising_edge_clk_l) < tHCM )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_L to CNT_MSK_NL Hold time - tHCM violation", $realtime);
             no_grnt_msg;
             hold_violation_l = 1'b1;
             if (cnt_msk_nl == 1'b1) 
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
                                    
         end
         cnt_msk_last_change_l = $realtime;
     end

     //-----------------------------------------------
     // HOLD Time violation checks for right port
     //-----------------------------------------------
     
     // Address hold time                             
     if (ar_event && ((last_opernr_p2 !== `COUNTERREADBACK) && (last_opernr_p2 !== `MASKREADBACK))) begin
         if ((ads_nr == 1'b0) && (cnten_nr == 1'b0)) begin
            if ((($realtime - rising_edge_clk_r) < tHA )&& setup_hold_chk) begin
                if (TmsgOn) $display ("%t WARNING : CLK_R to A_R Hold time - tHA violation.", $realtime);
                hold_violation_r = 1'b1;
                no_grnt_msg;
                addr_hold_violation_r = 1'b1;
                ar_prev = ar_pv;
            end
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
             

         end
         rw_last_change_r = $realtime;
     end
    
     // CE Hold time
     if (ce0_nr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHW )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to CE0_R Hold time - tHC violation", $realtime);
             no_grnt_msg;
             if (ce0_nr == 1'b1)
             hold_violation_r = 1'b1;

         end
         if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
             if (TmsgOn) $display ("%t WARNING : MRST to CE0_R Hold time - tRSR violation.", $realtime);
             no_grnt_msg;
             
             hold_violation_r = 1'b1;

         end
         ce0_last_change_r = $realtime;
     end
    
     if (ce1_r_event) begin
         if ((($realtime - rising_edge_clk_r) < tHW )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to CE1_R Hold time - tHC violation", $realtime);
             no_grnt_msg;
             if (ce1_r == 1'b0)
             hold_violation_r = 1'b1;

         end
         if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
             if (TmsgOn) $display ("%t WARNING : MRST to CE1_R Hold time - tRSR violation.", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;

        end
        ce1_last_change_r = $realtime;
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

     if (ads_nr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHAD )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to ADS_NR Hold time - tHC violation", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;
             if (cnt_msk_nr == 1'b0) 
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
                                    

         end
         ads_last_change_r = $realtime;
     end


     if (cnten_nr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHCN )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to CNTEN_NR Hold time - tHCN violation", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;
             if (cnt_msk_nr == 1'b0) 
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
                                    
         end
         
         cnten_last_change_r = $realtime;
     end

     if (cntrst_nr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHRST )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to CNTRST_NR Hold time - tHRST violation", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;
             if (cnt_msk_nr == 1'b0) 
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
                                    
         end
        cntrst_last_change_r = $realtime;
     end

     if (cnt_msk_nr_event) begin
         if ((($realtime - rising_edge_clk_r) < tHCM )&& setup_hold_chk) begin
             if (TmsgOn) $display ("%t WARNING : CLK_R to CNT_MSK_NR Hold time - tHCM violation", $realtime);
             no_grnt_msg;
             hold_violation_r = 1'b1;
             if (cnt_msk_nr == 1'b1) 
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
                                    
         end
         cnt_msk_last_change_r = $realtime;
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
         
         if (((rising_edge_mrst - ce0_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
             if (TmsgOn) $display ("%t WARNING : Master Reset to CE0_L Setup time - tRSS violation.", $realtime);
             no_grnt_msg;
         end
         
         
         if (((rising_edge_mrst - ce1_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
             if (TmsgOn) $display ("%t WARNING : Master Reset to CE1_L Setup time - tRSS violation.", $realtime);
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
         
         if (((rising_edge_mrst - ce0_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
             if (TmsgOn)$display("%t WARNING : Master Reset to CE0_R Setup time - tRSS violation.", $realtime);
             no_grnt_msg;
         end


         if (((rising_edge_mrst - ce1_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
             if(TmsgOn)$display("%t WARNING : Master Reset to CE1_R Setup time - tRSS violation.", $realtime);
             no_grnt_msg;
         end
         
     end // if (mrst_n_event && (mrst === 1'b1))
end  
endtask // timing_chk

//-------------------------------------------------------------------------------
// task:        get_next_address_left
// Description: This taks checks all the counter related inputs and gets the
//              next address. The next address is stored in next_address_l_r 
//                register 
//
//-----------------------------------------------------------------------------
task get_next_address_left;
reg x_detected;     
begin
    x_detected= 1'b0; 
    x_detected = chk_x("cntrst_nl", cntrst_nl) | chk_x("cnt_msk_nl", cnt_msk_nl)
               |chk_x("cnten_nl", cnten_nl) | chk_x("ads_nl", ads_nl);
                          

    if (x_detected == 1'b0) begin
        if (cnt_msk_nl == 1'b1)
            if (cntrst_nl == 1'b0) 
                counter_reset_l;
            else if (ads_nl == 1'b0)
                if (cnten_nl == 1'b0)
                     counter_load_l;
                else
                     counter_readback_l;
            else if (cnten_nl == 1'b0)
                counter_increment_l;
            else
                counter_hold_l;
        else if (cntrst_nl == 1'b0) 
            mask_reset_l;
        else if (ads_nl == 1'b0)
            if (cnten_nl == 1'b0)
                mask_load_l;
            else
                mask_readback_l;
        else begin
            $display("%t WARNING : Illegal combination of couter inputs detected on left prot", $realtime);
            $display("\t         : No Operation will be performed ");  
        end   
    end else begin
        no_operation_l_f = 1'b1;           
        last_opernl_p1 = `NOP;            
    end   
end
endtask// get_next_address_left

//-------------------------------------------------------------------------------
// task:        counter_reset
// Description: This task resets counter unmasked portion to all 0s.  
//
//-----------------------------------------------------------------------------
task counter_reset_l;
integer i;     
begin
    for ( i = 0; i <= mask_length_l ; i = i+1)
        counter_reg_l[i] = 1'b0;
    no_operation_l_f = 1'b0;
    cntint_nl_f = 1'b0;
end
endtask

//-------------------------------------------------------------------------------
// task:        counter_load
// Description: Load address counter with external address value presented on 
//              address lines 
//
//-----------------------------------------------------------------------------
task counter_load_l;
integer i;
begin
    al_r = `AD_S'hz; 
    if (chk_x_a("al", al) == 1'b0) begin 
        counter_reg_l = al;
        mirror_reg_l = al;
        no_operation_l_f = 1'b0;
        address_l = al;   
        max_count_l = al;
        for (i = 0; i <= mask_length_l; i = i+1) 
            max_count_l[i] = 1'b1;
        if (counter_reg_l == max_count_l)
            cntint_nl_f  = 1'b1; 
        else
            cntint_nl_f  = 1'b0; 
    end else
        no_operation_l_f = 1'b1;    
     
end
endtask

//-------------------------------------------------------------------------------
// task:        counter_readback
// Description: Read out counter internal value  on address lines 
//
//-----------------------------------------------------------------------------
task counter_readback_l;
integer i;     
begin
    al_p1 = counter_reg_l;
    no_operation_l_f = 1'b1;
    last_opernl_p1 = `COUNTERREADBACK;            
 
end
endtask

//-------------------------------------------------------------------------------
// task:        counter_increment
// Description: Internally increments address counter value
//
//-----------------------------------------------------------------------------
task counter_increment_l;
integer i;     
reg[`AD_M:0]  temp_addr;
begin

    al_p1 = `AD_S'hz;  
    if (mask_reg_l[0] == 1'b0)  
        counter_reg_l = counter_reg_l +2;
    else begin  
        if (counter_reg_l == max_count_l)begin
            counter_reg_l = mirror_reg_l;
            cntint_nl_f = 1'b0;
        end else begin  
            cntint_nl_f = 1'b0;
            temp_addr = `AD_S'h0; 
            for( i = 0 ; i <= mask_length_l; i = i+1)
                 temp_addr[i] = counter_reg_l[i];
            temp_addr = temp_addr +1;
            for( i = 0 ; i <= mask_length_l; i = i+1)
                counter_reg_l[i] = temp_addr[i];     
            if (counter_reg_l == max_count_l)
                cntint_nl_f = 1'b1;
       
        end  
    end   
    no_operation_l_f = 1'b0;
    address_l = counter_reg_l;
end
endtask

//-------------------------------------------------------------------------------
// task:        counter_hold
// Description: no operation is perfomed on counter 
//
//-----------------------------------------------------------------------------
task counter_hold_l;
begin
    no_operation_l_f = 1'b0;      
    al_p1 = `AD_S'hz; 
    if (OmsgOn) 
        $display("%t NOTE :  Counter Hold Operation performed on left port", $realtime);
end 
endtask


//-------------------------------------------------------------------------------
// task:        mask_reset 
// Description: This task resets counter unmasked portion to all 0s.  
//
//-----------------------------------------------------------------------------
task mask_reset_l;
integer i;     
begin
    al_p1 = `AD_S'hz; 
    for ( i = 0 ; i <= `AD_M; i = i +1)     
        mask_reg_l[i] = 1'b1;
    no_operation_l_f = 1'b1;
    last_opernl_p1 = `MASKRESET;              
    mask_length_l = `AD_M;
end
endtask

//-------------------------------------------------------------------------------
// task:        mask_load
// Description: Load mask with external address value presented on 
//              address lines 
//
//-----------------------------------------------------------------------------
task mask_load_l;
integer i;
begin
    al_p1 = `AD_S'hz; 
    if (chk_x_a("al", al) == 1'b0) begin
        mask_reg_l = al;
        no_operation_l_f = 1'b1;
        for (i = 0; i <= `AD_M; i = i+1) 
            if (mask_reg_l[i] == 1'b0)begin
               mask_length_l = i-1;
               i = `AD_S;
            end   
    end else
        no_operation_l_f = 1'b1;    
    last_opernl_p1 = `MASKLOAD;               
end
endtask

//-------------------------------------------------------------------------------
// task:        mask_readback
// Description: Read out counter internal value  on address lines 
//
//-----------------------------------------------------------------------------
task mask_readback_l;
integer i;     
begin
    al_p1 = mask_reg_l;
    no_operation_l_f = 1'b1;
    last_opernl_p1 = `MASKREADBACK;            
end
endtask


//-------------------------------------------------------------------------------
// task:        get_next_address_right
// Description: This taks checks all the counter related inputs and gets the
//              next address. The next address is stored in next_address_l_r 
//                register 
//
//-----------------------------------------------------------------------------
task get_next_address_right;
 reg x_detected;     
begin
    x_detected= 1'b0; 
    x_detected = chk_x("cntrst_nr", cntrst_nr) | chk_x("cnt_msk_nr", cnt_msk_nr)
               |chk_x("cnten_nr", cnten_nr) | chk_x("ads_nr", ads_nr);
               // $display("Execute get_next_address_right");                                       

    if (x_detected == 1'b0) begin
        if (cnt_msk_nr == 1'b1) begin
            if (cntrst_nr == 1'b0) 
                counter_reset_r;
            else if (ads_nr == 1'b0)
                 if (cnten_nr == 1'b0) begin
                     counter_load_r;
//                   $display("check1 at time %t", $realtime);
                 end else
                     counter_readback_r;
            else if (cnten_nr == 1'b0)
                 counter_increment_r;
            else
                 counter_hold_r;
        end else if (cntrst_nr == 1'b0) 
            mask_reset_r;
        else if (ads_nr == 1'b0)
             if (cnten_nr == 1'b0)
                 mask_load_r;
             else
                 mask_readback_r;
        else begin
             $display("%t WARNING : Illegal combination of couter inputs deected on right port", $realtime);
             $display("\t         : No Operation will be performed ");  
        end   
    end else begin
        no_operation_r_f = 1'b1;           
        last_opernr_p1 = `NOP;            
    end   
     
end
endtask// get_next_address_right

//-------------------------------------------------------------------------------
// task:        counter_reset
// Description: This task resets counter unmasked portion to all 0s.  
//
//-----------------------------------------------------------------------------
task counter_reset_r;
integer i;     
begin
//    $display("Counter resest");
    
    for ( i = 0; i <= mask_length_r ; i = i+1)
         counter_reg_r[i] = 1'b0;
    no_operation_r_f = 1'b0;
  
end
endtask

//-------------------------------------------------------------------------------
// task:        counter_load
// Description: Load address counter with external address value presented on 
//              address lines 
//
//-----------------------------------------------------------------------------
task counter_load_r;
integer i;
begin
//   $display("Counter load with address = %h",  ar ); 
     ar_p1 = `AD_S'hz; 
     if (chk_x_a("ar", ar) == 1'b0) begin 
         counter_reg_r = ar;
         mirror_reg_r = ar;
         no_operation_r_f = 1'b0;
         address_r = ar;   
         max_count_r = ar;
         for (i = 0; i <= mask_length_r; i = i+1) 
             max_count_r[i] = 1'b1;
         if (counter_reg_r == max_count_r)
             cntint_nr_f  = 1'b1; 
         else
             cntint_nr_f  = 1'b0; 
     end else
         no_operation_r_f = 1'b1;  
       
end
endtask

//-------------------------------------------------------------------------------
// task:        counter_readback
// Description: Read out counter internal value  on address lines 
//
//-----------------------------------------------------------------------------
task counter_readback_r;
integer i;     
begin
//   $display("Counter readback"); 
     ar_p1 = counter_reg_r;
     no_operation_r_f = 1'b1;
     last_opernr_p1 = `COUNTERREADBACK;            
end
endtask

//-------------------------------------------------------------------------------
// task:        counter_increment
// Description: Internally increments address counter value
//
//-----------------------------------------------------------------------------
task counter_increment_r;
integer i;     
reg[`AD_M:0]  temp_addr;
begin
//        $display("Counter increment");
     ar_p1 = `AD_S'hz;  
     if ( mask_reg_r[0] == 1'b0)  
         counter_reg_r = counter_reg_r +2;
     else begin  
          if (counter_reg_r == max_count_r) begin
             counter_reg_r = mirror_reg_r;
             cntint_nr_f = 1'b0;
          end else begin  
              temp_addr = `AD_S'h0; 
              for( i = 0 ; i <= mask_length_r; i = i+1)
                  temp_addr[i] = counter_reg_r[i];
                  temp_addr = temp_addr +1;
              for( i = 0 ; i <= mask_length_r; i = i+1)
                   counter_reg_r[i] = temp_addr[i];   
              if (counter_reg_r == max_count_r)
                  cntint_nr_f = 1'b1;
          end  
     end   
     no_operation_r_f = 1'b0;
     address_r = counter_reg_r;
end      
endtask

//-------------------------------------------------------------------------------
// task:        counter_hold
// Description: no operation is perfomed on counter 
//
//-----------------------------------------------------------------------------
task counter_hold_r;
begin
//     $display("Counter Hold");   
     no_operation_r_f = 1'b0;      
     ar_p1 = `AD_S'hz;     
     if (OmsgOn) 
        $display("%t NOTE :  Counter Hold Operation performed on left port", $realtime);
end
endtask


//-------------------------------------------------------------------------------
// task:        mask_reset 
// Description: This task resets counter unmasked portion to all 0s.  
//
//-----------------------------------------------------------------------------
task mask_reset_r;
integer i;     
begin
//      $display("Mask resest");  
     ar_p1 = `AD_S'hz; 
     for ( i = 0 ; i <= `AD_M; i = i +1)     
         mask_reg_r[i] = 1'b1;
     no_operation_r_f = 1'b1;
     last_opernr_p1 = `MASKRESET;            
     mask_length_r = `AD_M;
end
endtask

//-------------------------------------------------------------------------------
// task:        mask_load
// Description: Load mask with external address value presented on 
//              address lines 
//
//-----------------------------------------------------------------------------
task mask_load_r;
integer i;
begin
//        $display("Mask  Load");
    ar_p1 = `AD_S'hz; 
    if (chk_x_a("ar", ar) == 1'b0) begin
        mask_reg_r = ar;
        no_operation_r_f = 1'b1;
        for (i = 0; i <= `AD_M; i = i+1) 
            if (mask_reg_r[i] == 1'b0) begin
                mask_length_r = i-1;
                i = `AD_S;
            end  
    end else
       no_operation_r_f = 1'b1;    
    last_opernr_p1 = `MASKLOAD;               
end
endtask

//-------------------------------------------------------------------------------
// task:        mask_readback
// Description: Read out counter internal value  on address lines 
//
//-----------------------------------------------------------------------------
task mask_readback_r;
integer i;     
begin
//   $display("Execute Mask Readback"); 
    ar_p1 = mask_reg_r;
    no_operation_r_f = 1'b1;
    last_opernr_p1 = `MASKREADBACK;            
end
endtask

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
         if ((last_opernl_p2 !== `COUNTERREADBACK) && (last_opernl_p2 !== `MASKREADBACK))
`ifdef FREQ167
           
          if (((rising_edge_clk_l - addr_last_change_l) < tSA) && setup_hold_chk && (flag_al === 0))begin
           
            if (TmsgOn) $display ("%t WARNING : A_L to CLK_L Setup time - tSA violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end
`else
              
         if (((rising_edge_clk_l - addr_last_change_l) < tSA)&& setup_hold_chk)begin
         
             if (TmsgOn) $display ("%t WARNING : A_L to CLK_L Setup time - tSA violation.", $realtime);
             no_grnt_msg;
             rsetup_violation_l = 1'b1;
         end
`endif // !ifdef if
   
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

        // CE Setup time
        if (((rising_edge_clk_l - ce0_last_change_l) < tSC )&& setup_hold_chk)begin
            if (TmsgOn) $display("%t WARNING : CE0_L to CLK_L Setup time - tSC violation", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end

        if (((rising_edge_clk_l - ce1_last_change_l) < tSC )&& setup_hold_chk)begin
            if (TmsgOn) $display("%t WARNING : CE1_L to CLK_L Setup time - tSC violation", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end

        // Input Data setup time
        if (((rising_edge_clk_l - dq_last_change_l) < tSD )&& (setup_hold_chk) && (r_w_nl === 0)) begin
            if (TmsgOn) $display ("%t WARNING : DQ_L to CLK_L Setup time - tSD violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
        end


        if (((rising_edge_clk_l - ads_last_change_l) < tSAD )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : ADS_NL to CLK_L Setup time - tSAD violation", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
            if (cnt_msk_nl == 1'b0)
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
             
        end

        if (((rising_edge_clk_l - cnten_last_change_l) < tSCN )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CNTEN_NL to CLK_L Setup time - tSCN violation", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
            if (cnt_msk_nl == 1'b0)
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
             
        end

        if (((rising_edge_clk_l - cntrst_last_change_l) < tSRST )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CNTRST_NL to CLK_L Setup time - tSRST violation", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
            if (cnt_msk_nl == 1'b0)
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
             
        end
        if (((rising_edge_clk_l - cnt_msk_last_change_l) < tSCM )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CNT_MSK_NL to CLK_L Setup time - tSCM violation", $realtime);
            no_grnt_msg;
            rsetup_violation_l = 1'b1;
            if (cnt_msk_nl == 1'b0)
                mask_reg_l  = `AD_S'hx;
             else
                counter_reg_l = `AD_S'hx;
             
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
`ifdef FREQ167
        if ((last_opernr_p2 !== `COUNTERREADBACK) && (last_opernr_p2 !== `MASKREADBACK))
        if (((rising_edge_clk_r - addr_last_change_r) < tSA ) && setup_hold_chk && (flag_ar === 0)) begin
            if (TmsgOn) $display ("%t WARNING : A_R to CLK_R Setup time - tSA violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end
`else
        if ((last_opernr_p2 !== `COUNTERREADBACK) && (last_opernr_p2 !== `MASKREADBACK))
        if (((rising_edge_clk_r - addr_last_change_r) < tSA )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : A_R to CLK_R Setup time - tSA violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end
`endif
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


        // CE Setup time
        if (((rising_edge_clk_r - ce0_last_change_r) < tSW )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CE0_R to CLK_R Setup time - tSC violation", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end


        if (((rising_edge_clk_r - ce1_last_change_r) < tSW )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CE1_R to CLK_R Setup time - tSC violation", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end

        // Input Data setup time
        if (((rising_edge_clk_r - dq_last_change_r) < tSD )&& (setup_hold_chk) && (r_w_nr === 0)) begin
            if (TmsgOn) $display ("%t WARNING : DQ_R to CLK_R Setup time - tSD violation.", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
        end

        if (((rising_edge_clk_r - ads_last_change_r) < tSAD )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : ADS_NR to CLK_R Setup time - tSAD violation", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
            if (cnt_msk_nr == 1'b0)
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
             
        end

        if (((rising_edge_clk_r - cnten_last_change_r) < tSCN )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CNTEN_NR to CLK_R Setup time - tSCN violation", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
            if (cnt_msk_nr == 1'b0)
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
            
        end

        if (((rising_edge_clk_r - cntrst_last_change_r) < tSRST )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CNTRST_NR to CLK_R Setup time - tSRST violation", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
            if (cnt_msk_nr == 1'b0)
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
            
        end

        if (((rising_edge_clk_r - cnt_msk_last_change_r) < tSCM )&& setup_hold_chk) begin
            if (TmsgOn) $display ("%t WARNING : CNT_MSK_NR to CLK_R Setup time - tSCM violation", $realtime);
            no_grnt_msg;
            rsetup_violation_r = 1'b1;
            if (cnt_msk_nr == 1'b0)
                mask_reg_r  = `AD_S'hx;
             else
                counter_reg_r = `AD_S'hx;
            
        end

    

end 
endtask


//-------------------------------------------------------------------------------
// task:        no_grnt_msg
// Description: No guaranted message.
//
//-----------------------------------------------------------------------------
task no_grnt_msg;
begin
    if (TmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");   
   
end
endtask // no_grnt_msg

//================================ End OF File ================================//


















