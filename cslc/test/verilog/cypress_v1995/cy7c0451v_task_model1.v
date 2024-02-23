//------------------------------------------------------------------------------
//
//     This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Spike technologies Inc.
//     In the event of publication, the following notice is applicable:
//
//                (C) COPYRIGHT 2002 SPIKE TECHNOLOGIES INC.
//                          ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies.
//
// File         : cy7c0451v_task_model.v
//
// Author       : Ashish Prabhu & Palaniappan
//
// Date         : Nov 20 2002
//
// Version      : 3.41
//
// Abstract     : This is the task file for Verilog Behavioral timing model 
//                of Cypress cy7c0451v, 2.5M QuadPort Data Path Select Element
//
// Notes        : Third Release, Added some revised features and timings
//
// Datasheet    : Cypress cy7c0451v,2.5M QuadPort DSE 
//                (Document No. 01-02117 Rev. **)
//
// Modification History:
// Date         By       Version     Change Description
// =============================================================================
// Dec 13 2001  ABP       0.1         Alpha Release
// Jan 29 2002  ABP       1.0         First Release
// Feb 13 2002  ABP       2.0         - Updated as per Rev.*B datasheet
// Feb 18 2002  ABP       2.1         - Timings changed as per Rev.*B[Feb 15'02]
//                                    - tCCS violations changes done as per 
//                                      customer's mail dated Feb 15'02
// May 08 2002  CZU       2.3         - Updated X-handling for dq bus
//
// Jul 18 2002  JHX       2.6		  - Changed filename to cy7c0451v_task_model.v
//
// Sep 02 2002  PAL       3.0         Third Release
//
// Sep 11 2002  PAL       3.1         - Updated as per the customer feedback mail dated
//                                      Sep 11'02
// Sep 21 2002  PAL       3.11        - Fix for counter Wrap Issue.
//
// Oct 10 2002  PAL       3.12        - tCCS violation changes
//                                      as per the customer feedback mail dated Oct 08'02
// Oct 15 2002  PAL       3.2         - OEb and cntintb changes
//                                      as per the customer feedback mail dated Oct 15'02
// Oct 16 2002  PAL       3.21        - cntintb changes and READYb changes
//                                      as per the customer feedback mail dated Oct 16'02
// Nov 01 2002  PAL       3.3         - tCCS/Overlapping violation changes
//                                      as per the customer feedback mails dated Oct 30'02
//                                      & Oct 31'02
// Nov 07 2002  NIS       3.31        - Negative tCCS violation changes, OE changes
//                                      as per the customer feedback mails dated Nov 05'02
//                                      & Nov 06'02
// Nov 13 2002  PAL       3.4         - tCCS/Overlapping voilation Issues
//                                      as per the customer feedback mails dated Nov 13'02
// Nov 20 2002  PAL       3.41        - tCCS/Overlapping voilation Display Issue
//                                      as per the customer feedback mails dated Nov 19'02
// ==============================================================================
//----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_r_w
//
// Description: Checks for any single unknown value on the r_w pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_r_w;

      input [60:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");
            chk_x_r_w = 1;
         end else begin
            chk_x_r_w = 0;
         end
      end
endfunction // chk_x_r_w

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_cntrst
//
// Description: Checks for any single unknown value on the cntrst pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_cntrst;

      input [90:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_cntrst = 1;
         end else begin
            chk_x_cntrst = 0;
         end
      end
endfunction // chk_x_cntrst
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_cntld
//
// Description: Checks for any single unknown value on the cntld pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_cntld;

      input [80:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_cntld = 1;
         end else begin
            chk_x_cntld = 0;
         end
      end
endfunction // chk_x_cntld 
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_cntinc
//
// Description: Checks for any single unknown value on the cntinc pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_cntinc;

      input [90:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_cntinc = 1;
         end else begin
            chk_x_cntinc = 0;
         end
      end
endfunction // chk_x_cntinc
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_cntrd
//
// Description: Checks for any single unknown value on the cntrd pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_cntrd;

      input [80:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_cntrd = 1;
         end else begin
            chk_x_cntrd = 0;
         end
      end
endfunction // chk_x_cntrd
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_mkld
//
// Description: Checks for any single unknown value on the mkld pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_mkld;

      input [70:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_mkld = 1;
         end else begin
            chk_x_mkld = 0;
         end
      end
endfunction // chk_x_mkld
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_mkrd
//
// Description: Checks for any single unknown value on the mkrd pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_mkrd;

      input [70:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_mkrd = 1;
         end else begin
            chk_x_mkrd = 0;
         end
      end
endfunction // chk_x_mkrd
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_wrp0
//
// Description: Checks for any single unknown value on the wrp0 pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_wrp0;

      input [70:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t\t          The value of Mirror Register is loaded in the counter register");  
            chk_x_wrp0 = 1;
         end else begin
            chk_x_wrp0 = 0;
         end
      end
endfunction // chk_x_wrp0
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_retx
//
// Description: Checks for any single unknown value on the retx pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_retx;

      input [70:0]     pin_name;      
      input val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_retx = 1;
         end else begin
            chk_x_retx = 0;
         end
      end
endfunction // chk_x_retx

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_b
//
// Description: Checks for any single unknown value on the Byte enable pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_b;
      input [45:0]     pin_name;      
      input [`BT_M:0]  val;
      begin      
         
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed"); 
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

      input [50:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_oe = 1;
         end else begin
            chk_x_oe = 0;
         end
      end
endfunction // chk_x_oe

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_ce1
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------
function chk_x_ce1;

      input [50:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display ("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_ce1 = 1;
         end else begin
            chk_x_ce1 = 0;
         end
      end
endfunction // chk_x_ce1

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_ce0
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_ce0;

      input [60:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t                  Device operation is not guaranteed");               
            chk_x_ce0 = 1;
         end else begin
            chk_x_ce0 = 0;
         end
      end
endfunction // chk_x_ce0


// added by CZU Rel 2.3
//-----------------------------------------------------------------------------------------------
// Function:    chk_x_dq
//
// Description: Checks for any single unknown value on the enabled bytes of dq bus
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_dq;

      input [35:0]     pin_name;      
      input [`DT_M:0]  val;
      input [`BT_M:0]  byte_en;

      begin      

         chk_x_dq = 0; // reset the flag

         if (byte_en[0] === 1'b0) begin
            if (^val[9:0] === 1'bx) begin
               chk_x_dq = 1;
            end
         end

         if (byte_en[1] === 1'b0) begin
            if (^val[19:10] === 1'bx) begin
               chk_x_dq = 1;
            end
         end

         if (byte_en[2] === 1'b0) begin
            if (^val[29:20] === 1'bx) begin
               chk_x_dq = 1;
            end
         end
         
         if (byte_en[3] === 1'b0) begin
            if (^val[39:30] === 1'bx) begin
               chk_x_dq = 1;
            end
         end

         if (chk_x_dq == 1) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display("\t\t                  No read or write Operation will be performed");
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

      input [30:0]     pin_name;      
      input [`AD_M:0]  val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t \t Model WARNING := Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display("\t\t                  No Address related Operation will be performed");
            chk_x_a = 1;
         end else begin
            chk_x_a = 0;
         end
      end
endfunction // chk_x_a

//-----------------------------------------------------------------------------------------------
// task:        pv_reset
//
// Description: Resets all the previous value variables to zero 
//
//-----------------------------------------------------------------------------------------------

task pv_reset;
      begin
         dqp1_pv       = 0;
         dqp2_pv       = 0;
         dqp3_pv       = 0;
         dqp4_pv       = 0;
         doff_p1_pv    = 0;//ver 3.0 PAL
         doff_p2_pv    = 0;//ver 3.0 PAL
         doff_p3_pv    = 0;//ver 3.0 PAL
         doff_p4_pv    = 0;//ver 3.0 PAL
         clkp1_pv      = 0; 
         clkp2_pv      = 0;
         clkp3_pv      = 0; 
         clkp4_pv      = 0;
//         mrst_n_pv     = 0;         //removed by shadab Rel 2.0
         ap1_pv        = 0;
         ap2_pv        = 0;
         ap3_pv        = 0;
         ap4_pv        = 0;
         ce0_np1_pv    = 0;
         ce0_np2_pv    = 0;
         ce0_np3_pv    = 0;
         ce0_np4_pv    = 0;
         ce1p1_pv      = 0;
         ce1p2_pv      = 0;
         ce1p3_pv      = 0;
         ce1p4_pv      = 0;
         cntrst_np1_pv = 0;
         cntrst_np2_pv = 0;
         cntrst_np3_pv = 0;
         cntrst_np4_pv = 0;
         cntld_np1_pv  = 0;
         cntld_np2_pv  = 0;
         cntld_np3_pv  = 0;
         cntld_np4_pv  = 0;
         cntinc_np1_pv = 0;
         cntinc_np2_pv = 0;
         cntinc_np3_pv = 0;
         cntinc_np4_pv = 0;
         cntrd_np1_pv  = 0;
         cntrd_np2_pv  = 0;
         cntrd_np3_pv  = 0;
         cntrd_np4_pv  = 0;
         mkld_np1_pv   = 0;
         mkld_np2_pv   = 0;
         mkld_np3_pv   = 0;
         mkld_np4_pv   = 0;
         mkrd_np1_pv   = 0;
         mkrd_np2_pv   = 0;
         mkrd_np3_pv   = 0;
         mkrd_np4_pv   = 0;
         wrp0_np1_pv   = 0;
         wrp0_np2_pv   = 0;
         wrp0_np3_pv   = 0;
         wrp0_np4_pv   = 0;
         retx_np1_pv   = 0;
         retx_np2_pv   = 0;
         retx_np3_pv   = 0;
         retx_np4_pv   = 0;
         oe_np1_pv     = 0;
         oe_np2_pv     = 0;
         oe_np3_pv     = 0;
         oe_np4_pv     = 0;
         r_w_np1_pv    = 0;
         r_w_np2_pv    = 0;
         r_w_np3_pv    = 0;
         r_w_np4_pv    = 0;
         b_np1_pv      = 4'b0000;
         b_np2_pv      = 4'b0000;
         b_np3_pv      = 4'b0000;
         b_np4_pv      = 4'b0000;
         // internal pins
         oep1_int_pv   = 0;
         oep2_int_pv   = 0;
         oep3_int_pv   = 0;
         oep4_int_pv   = 0;
         tOEp1_int_pv  = 0;
         tOEp2_int_pv  = 0;                           
         tOEp3_int_pv  = 0;
         tOEp4_int_pv  = 0;
         doff_np1_event_pv = 0;//ver 3.0 PAL
         doff_np2_event_pv = 0;//ver 3.0 PAL
         doff_np3_event_pv = 0;//ver 3.0 PAL
         doff_np4_event_pv = 0;//ver 3.0 PAL
      end
endtask // pv_reset

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
         dqp1_pv       = dqp1;
         dqp2_pv       = dqp2;         
         dqp3_pv       = dqp3;
         dqp4_pv       = dqp4;         
         doff_p1_pv    = doff_np1;//ver 3.0 PAL
         doff_p2_pv    = doff_np2;//ver 3.0 PAL
         doff_p3_pv    = doff_np3;//ver 3.0 PAL
         doff_p4_pv    = doff_np4;//ver 3.0 PAL
         clkp1_pv      = cpp1;
         clkp2_pv      = cpp2;
         clkp3_pv      = cpp3;
         clkp4_pv      = cpp4;
         mrst_n_pv     = mrst_n;
         doff_np1_event_pv   = doff_np1_event;//ver 3.0 PAL
         doff_np2_event_pv   = doff_np2_event;//ver 3.0 PAL
         doff_np3_event_pv   = doff_np3_event;//ver 3.0 PAL
         doff_np4_event_pv   = doff_np4_event;//ver 3.0 PAL
         ap1_pv        = ap1;
         ap2_pv        = ap2;
         ap3_pv        = ap3;
         ap4_pv        = ap4;
         ce0_np1_pv    = ce0_np1;
         ce0_np2_pv    = ce0_np2;
         ce0_np3_pv    = ce0_np3;
         ce0_np4_pv    = ce0_np4;
         ce1p1_pv      = ce1p1;
         ce1p2_pv      = ce1p2;
         ce1p3_pv      = ce1p3;
         ce1p4_pv      = ce1p4;
         cntrst_np1_pv = cntrst_np1;
         cntrst_np2_pv = cntrst_np2;
         cntrst_np3_pv = cntrst_np3;
         cntrst_np4_pv = cntrst_np4;
         cntld_np1_pv  = cntld_np1;
         cntld_np2_pv  = cntld_np2;
         cntld_np3_pv  = cntld_np3;
         cntld_np4_pv  = cntld_np4;
         cntinc_np1_pv = cntinc_np1;
         cntinc_np2_pv = cntinc_np2;
         cntinc_np3_pv = cntinc_np3;
         cntinc_np4_pv = cntinc_np4;
         cntrd_np1_pv  = cntrd_np1;
         cntrd_np2_pv  = cntrd_np2;
         cntrd_np3_pv  = cntrd_np3;
         cntrd_np4_pv  = cntrd_np4;
         mk_ldp1_pv    = mkld_np1;
         mk_ldp2_pv    = mkld_np2;
         mk_ldp3_pv    = mkld_np3;
         mk_ldp4_pv    = mkld_np4;
         mkrd_np1_pv   = mkrd_np1;
         mkrd_np2_pv   = mkrd_np2;
         mkrd_np3_pv   = mkrd_np3;
         mkrd_np4_pv   = mkrd_np4;
         wrp0_np1_pv   = wrp0_np1;
         wrp0_np2_pv   = wrp0_np2;
         wrp0_np3_pv   = wrp0_np3;
         wrp0_np4_pv   = wrp0_np4;
         retx_np1_pv   = retx_np1;
         retx_np2_pv   = retx_np2;
         retx_np3_pv   = retx_np3;
         retx_np4_pv   = retx_np4;
         oe_np1_pv     = oe_np1;
         oe_np2_pv     = oe_np2;
         oe_np3_pv     = oe_np3;
         oe_np4_pv     = oe_np4;
         r_w_np1_pv    = r_w_np1;
         r_w_np2_pv    = r_w_np2;
         r_w_np3_pv    = r_w_np3;
         r_w_np4_pv    = r_w_np4;
         b_np1_pv      = b_np1;
         b_np2_pv      = b_np2;
         b_np3_pv      = b_np3;
         b_np4_pv      = b_np4;
         // internal pins
         oep1_int_pv   = oep1_int;
         oep2_int_pv   = oep2_int;
         oep3_int_pv   = oep3_int;
         oep4_int_pv   = oep4_int;
         tOEp1_int_pv  = tOEp1_int;
         tOEp2_int_pv  = tOEp2_int;                           
         tOEp3_int_pv  = tOEp3_int;
         tOEp4_int_pv  = tOEp4_int;                           
      end
endtask // pv_assign
//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Function:    read_data_fn
//
// Description: Performs read operation.       
//              Returns vaild data to be read.
// Version : 3.0 PAL
//-----------------------------------------------------------------------------------------------

function [`DT_M : 0] read_data_fn;
      input [1:0]port;
      begin
         case (port)
           `port1: begin
              if(rdp1_violation_p2 == 1'b1)begin
                 read_data_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 read_data_fn[`DT_M:0] = mem[cntp1_reg_p2];
              end
           end          
           `port2: begin 
              if(rdp2_violation_p2 == 1'b1)begin
                 read_data_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 read_data_fn[`DT_M:0] = mem[cntp2_reg_p2];
              end
           end 
           `port3: begin 
              if(rdp3_violation_p2 == 1'b1)begin
                 read_data_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 read_data_fn[`DT_M:0] = mem[cntp3_reg_p2];
              end
           end 
           default:begin
              if(rdp4_violation_p2 == 1'b1)begin
                 read_data_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 read_data_fn[`DT_M:0] = mem[cntp4_reg_p2];
              end
           end
         endcase
      end
endfunction // read_data_fn



//-----------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
// task:        timing_chk
//
// Description: Checks setup and hold violations for the input pins
//
//-----------------------------------------------------------------------------------------------

task timing_chk;
      begin
         
         //-----------------------------------------------------------------
         // Clock High time check
         //-----------------------------------------------------------------
         if (clkp1_event && (cpp1 === 1'b0)) begin
            if (($realtime < (rising_edge_clk_p1 + tCH)) && ($realtime > 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 Clock High time - tCH violation.", $realtime);
               no_grnt_msg;
            end
            falling_edge_clk_p1 = $realtime;
         end
         
         if (clkp2_event && (cpp2 === 1'b0)) begin
            if (($realtime < (rising_edge_clk_p2 + tCH)) && ($realtime > 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 Clock High time - tCH violation.", $realtime);
               no_grnt_msg;
            end
            falling_edge_clk_p2 = $realtime;
         end
         
         if (clkp3_event && (cpp3 === 1'b0)) begin
            if (($realtime < (rising_edge_clk_p3 + tCH)) && ($realtime > 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 Clock High time - tCH violation.", $realtime);
               no_grnt_msg;
            end
            falling_edge_clk_p3 = $realtime;
         end
         
         if (clkp4_event && (cpp4 === 1'b0)) begin
            if (($realtime < (rising_edge_clk_p4 + tCH)) && ($realtime > 0) ) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 Clock High time - tCH violation.", $realtime);
               no_grnt_msg;
            end
            falling_edge_clk_p4 = $realtime;
         end
         
         
         //------------------------------------------------------------------------------
         //Setup timing checks for port one
         //------------------------------------------------------------------------------
         if (clkp1_event && (cpp1 === 1'b1)) begin
            // Clock cycle time check
            if (($realtime < (rising_edge_clk_p1 + tCYC)) && ($realtime > tCYC)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 Clock cycle time - tCYC violation.", $realtime);
               no_grnt_msg;
            end else begin
                 // Checking for clock stability
               if(($realtime - rising_edge_clk_p1) > 10)begin
                  if(mrst_n == 1'b0)begin
                     clk_stb_p1 = 1'b1;
                  end else begin //ver 2.0 palani
                     if((doff_np1 === 1'b1) && (ddisp_flag_p1 == 1'b0))begin
                        if(cnt_doff1 < 1023) 
                          cnt_doff1 = cnt_doff1 + 1;
                        else begin
                           if (TmsgOn) $display ("%t \t Model ERROR := CPP_P1 not stable ", $realtime);
                           if (TmsgOn) $display ("%t\t                The Model will function as per the timings set in the configuration mode", $realtime);//ver 2.0 ashish
                           if (TmsgOn) $display ("%t\t                DOFF_NP1 should be low to turn off the internal DLLs", $realtime);//ver 2.0 ashish
                           cnt_doff1 = 0;
                           ddisp_flag_p1 = 1'b1;
                        end
                     end 
                  end
               end else begin
                  clk_stb_p1 = 1'b0;
                  ddisp_flag_p1 = 1'b0;
                  cnt_doff1 = 0;
               end
            end
            if (reset_over == 1'b1)begin
               if (doff_flag_p1 == 1'b0) begin
                  if (cnt_stb_set_p1 < 1)
                    cnt_stb_set_p1 = cnt_stb_set_p1 + 1;
                  else begin
                     ready_np1 = 1'b0;
                     cnt_stb_set_p1 = 0;
                     ready_set_p1 = 1'b1;
                  end
               end
               else begin
                  if (cnt_stb_set1_p1 < 1023)
                    cnt_stb_set1_p1 = cnt_stb_set1_p1 + 1;
                  else begin
                     ready_np1 = 1'b0;
                     cnt_stb_set1_p1 = 0;
                     ready_set_p1 = 1'b1;
                  end
               end
            end //ver 2.0 palani
            rising_edge_clk_p1 = $realtime;
            
            //Clock low time check
            if ((rising_edge_clk_p1 < (falling_edge_clk_p1 + tCL)) && ($realtime > tCL)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 Clock LOW time - tCL violation.", $realtime);
               no_grnt_msg;
            end
            
            // Address setup time check
            if ((rising_edge_clk_p1 < (tSA  + addr_last_change_p1)) && setup_hold_chk && (!((mkp1_rd_en_p4 == 1'b1) || (cntp1_rd_en_p4 == 1'b1) ||  (msk_disable_p1 == 1'b1) || (cnt_disable_p1 == 1'b1) || (rdp1_tAC_p5 == 1'b1) || (rdp1_tAC_dis == 1'b1)))) begin
               if (TmsgOn) $display ("%t \t Model WARNING := A_P1 to CPP_P1 Setup time - tSA violation.", $realtime);
               no_grnt_msg;
            end
            
            // Byte select setup time
            if ((rising_edge_clk_p1 < (tSB + byte_sel_last_change_p1)) && setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := B_NP1 to CPP_P1 Setup time - tSB violation.", $realtime);
               no_grnt_msg;
            end
            
            // Chip enable setup time        
            if ((rising_edge_clk_p1 < (tSC + ce0_last_change_p1)) && setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE0_NP1 to CPP_P1 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            if ((rising_edge_clk_p1 < (tSC + ce1_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE1_P1 to CPP_P1 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            // R/W Setup time
            if ((rising_edge_clk_p1 < (tSW + rw_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := R_W_NP1 to CPP_P1 Setup time - tSW violation", $realtime);
               no_grnt_msg;
            end
            
            // Input Data setup time
            if ((rising_edge_clk_p1 < (tSD + dq_last_change_p1))&& (setup_hold_chk) && (r_w_np1 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DQ_P1 to CPP_P1 Setup time - tSD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRST Setup time
            if ((rising_edge_clk_p1 < (tSRST + cntrst_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRST_NP1 to CPP_P1 Setup time - tSRST violation.", $realtime);
               no_grnt_msg;
            end
            
           // CNTLD Setup time
           if ((rising_edge_clk_p1 < (tSCLD + cntld_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTLD_NP1 to CPP_P1 Setup time - tSCLD violation.", $realtime);
               no_grnt_msg;
           end
           
           // CNTINC Setup time
           if ((rising_edge_clk_p1 < (tSCINC + cntinc_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTINC_NP1 to CPP_P1 Setup time - tSCINC violation.", $realtime);
               no_grnt_msg;
           end
            
           // CNTRD Setup time
           if ((rising_edge_clk_p1 < (tSCRD + cntrd_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRD_NP1 to CPP_P1 Setup time - tSCRD violation.", $realtime);
               no_grnt_msg;
           end
           
           // MKLD Setup time
           if ((rising_edge_clk_p1 < (tSMLD + mkld_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKLD_NP1 to CPP_P1 Setup time - tSMLD violation.", $realtime);
               no_grnt_msg;
           end
           
           // MKRD Setup time
           if ((rising_edge_clk_p1 < (tSMRD + mkrd_last_change_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKRD_NP1 to CPP_P1 Setup time - tSMRD violation.", $realtime);
               no_grnt_msg;
           end
           
          // WRP0 Setup time
           if ((rising_edge_clk_p1 < (tSWRP + wrp0_nlast_change_p1)) && setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := WRP0_NP1 to CPP_P1 Setup time - tSWRP violation.", $realtime);
               no_grnt_msg;
           end
           
          // RETX Setup time
           if ((rising_edge_clk_p1 < (tSRT + retx_last_change_p1)) && setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := RETX_NP1 to CPP_P1 Setup time - tSRT violation.", $realtime);
               no_grnt_msg;
           end
         end    
         
         
         //------------------------------------------------------------------------------
         //Setup timing checks for port two
         //------------------------------------------------------------------------------
         
         if (clkp2_event && (cpp2 === 1'b1)) begin
            // Clock cycle time check
            if (($realtime < (rising_edge_clk_p2 + tCYC)) && ($realtime > tCYC)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 Clock cycle time - tCYC violation.", $realtime);
               no_grnt_msg;
            end else begin//ver 2.0 palani
               // Checking for clock stability
               if(($realtime - rising_edge_clk_p2) > 10)begin
                  if(mrst_n == 1'b0)begin
                     clk_stb_p2 = 1'b1;
                  end else begin
                     if((doff_np2 === 1'b1) && (ddisp_flag_p2 == 1'b0))begin
                        if(cnt_doff2 < 1023)
                          cnt_doff2 = cnt_doff2 + 1;
                        else begin
                           if (TmsgOn) $display ("%t \t Model ERROR := CPP_P2 not stable ", $realtime);
                           if (TmsgOn) $display ("%t\t                The Model will function as per the timings set in the configuration mode", $realtime);//ver 2.0 ashish
                           if (TmsgOn) $display ("%t\t                DOFF_NP2 should be low to turn off the internal DLLs", $realtime);//ver 2.0 ashish
                           cnt_doff2 = 0;
                           ddisp_flag_p2 = 1'b1;
                        end
                     end 
                  end
               end else begin
                  clk_stb_p2 = 1'b0;
                  ddisp_flag_p2 = 1'b0;                  
                  cnt_doff2 = 0;
               end
            end
            if (reset_over == 1'b1)begin
               if (doff_flag_p2 == 1'b0) begin
                  if (cnt_stb_set_p2 < 1)
                    cnt_stb_set_p2 = cnt_stb_set_p2 + 1;
                  else begin
                     ready_np2 = 1'b0;
                     cnt_stb_set_p2 = 0;
                     ready_set_p2 = 1'b1;
                  end
               end
               else begin
                  if (cnt_stb_set1_p2 < 1023)
                    cnt_stb_set1_p2 = cnt_stb_set1_p2 + 1;
                  else begin
                     ready_np2 = 1'b0;
                     cnt_stb_set1_p2 = 0;
                     ready_set_p2 = 1'b1;
                  end
               end
            end//ver 2.0 palani
            rising_edge_clk_p2 = $realtime;

            //Clock low time check
            if ((rising_edge_clk_p2 < (falling_edge_clk_p2 + tCL)) && ($realtime > tCL)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 Clock LOW time - tCL violation.", $realtime);
               no_grnt_msg;
            end
            
            // Address setup time check
            if ((rising_edge_clk_p2 < (tSA + addr_last_change_p2)) && setup_hold_chk && (!((mkp2_rd_en_p4 == 1'b1) || (cntp2_rd_en_p4 == 1'b1) ||  (msk_disable_p2 == 1'b1) || (cnt_disable_p2 == 1'b1) || (rdp2_tAC_p5 == 1'b1) || (rdp2_tAC_dis == 1'b1)))) begin
               if (TmsgOn) $display ("%t \t Model WARNING := A_P2 to CPP_P2 Setup time - tSA violation.", $realtime);
               no_grnt_msg;
            end
            
            // Byte select setup time
            if ((rising_edge_clk_p2 < (tSB + byte_sel_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := B_NP2 to CPP_P2 Setup time - tSB violation.", $realtime);
               no_grnt_msg;
            end
            
            // Chip enable setup time        
            if ((rising_edge_clk_p2 < (tSC + ce0_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE0_P2 to CPP_P2 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            if ((rising_edge_clk_p2 < (tSC + ce1_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE1_P2 to CPP_P2 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            // R/W Setup time
            if ((rising_edge_clk_p2 < (tSW + rw_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := R_W_NP2 to CPP_P2 Setup time - tSW violation", $realtime);
               no_grnt_msg;
            end
            
            // Input Data setup time
            if ((rising_edge_clk_p2 < (tSD + dq_last_change_p2))&& (setup_hold_chk) && (r_w_np2 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DQ_P2 to CPP_P2 Setup time - tSD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRST Setup time
            if ((rising_edge_clk_p2 < (tSRST + cntrst_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRST_NP2 to CPP_P2 Setup time - tSRST violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTLD Setup time
            if ((rising_edge_clk_p2 < (tSCLD + cntld_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTLD_NP2 to CPP_P2 Setup time - tSCLD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTINC Setup time
            if ((rising_edge_clk_p2 < (tSCINC + cntinc_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTINC_NP2 to CPP_P2 Setup time - tSCINC violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRD Setup time
            if ((rising_edge_clk_p2 < (tSCRD + cntrd_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRD_NP2 to CPP_P2 Setup time - tSCRD violation.", $realtime);
               no_grnt_msg;
            end
            
            // MKLD Setup time
            if ((rising_edge_clk_p2 < (tSMLD + mkld_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKLD_NP2 to CPP_P2 Setup time - tSMLD violation.", $realtime);
               no_grnt_msg;
            end
            
            // MKRD Setup time
            if ((rising_edge_clk_p2 < (tSMRD + mkrd_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKRD_NP2 to CPP_P2 Setup time - tSMRD violation.", $realtime);
               no_grnt_msg;
            end
            
            // WRP0 Setup time
            if ((rising_edge_clk_p2 < (tSWRP + wrp0_nlast_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := WRP0_NP2 to CPP_P2 Setup time - tSWRP violation.", $realtime);
               no_grnt_msg;
            end
            
            // RETX Setup time
            if ((rising_edge_clk_p2 < (tSRT + retx_last_change_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := RETX_NP2 to CPP_P2 Setup time - tSRT violation.", $realtime);
               no_grnt_msg;
            end
         end    
           

         //------------------------------------------------------------------------------
         //Setup timing checks for port three
         //------------------------------------------------------------------------------
         
         if (clkp3_event && (cpp3 === 1'b1)) begin
            // Clock cycle time check
            if (($realtime < (rising_edge_clk_p3 + tCYC)) && ($realtime > tCYC)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 Clock cycle time - tCYC violation.", $realtime);
               no_grnt_msg;
            end else begin//ver 2.0 palani
               // Checking for clock stability
               if(($realtime - rising_edge_clk_p3) > 10)begin
                  if(mrst_n == 1'b0)begin
                     clk_stb_p3 = 1'b1;
                  end else begin
                     if((doff_np3 === 1'b1) && (ddisp_flag_p3 == 1'b0))begin
                        if(cnt_doff3 < 1023)
                          cnt_doff3 = cnt_doff3 + 1;
                        else begin
                           if (TmsgOn) $display ("%t \t Model ERROR := CPP_P3 not stable ", $realtime);
                           if (TmsgOn) $display ("%t\t                The Model will function as per the timings set in the configuration mode", $realtime);//ver 2.0 ashish
                           if (TmsgOn) $display ("%t\t                DOFF_NP3 should be low to turn off the internal DLLs", $realtime);//ver 2.0 ashish
                           cnt_doff3 = 0;
                           ddisp_flag_p3 = 1'b1;
                        end
                     end 
                  end
               end else begin
                  clk_stb_p3 = 1'b0;
                  cnt_doff3 = 0;
                  ddisp_flag_p3 = 1'b0;
               end
            end
            if (reset_over == 1'b1)begin
               if (doff_flag_p3 == 1'b0) begin
                  if (cnt_stb_set_p3 < 1)
                    cnt_stb_set_p3 = cnt_stb_set_p3 + 1;
                  else begin
                     ready_np3 = 1'b0;
                     cnt_stb_set_p3 = 0;
                     ready_set_p3 = 1'b1;
                  end
               end
               else begin
                  if (cnt_stb_set1_p3 < 1023)
                    cnt_stb_set1_p3 = cnt_stb_set1_p3 + 1;
                  else begin
                     ready_np3 = 1'b0;
                     cnt_stb_set1_p3 = 0;
                     ready_set_p3 = 1'b1;
                  end
               end
            end//ver 2.0 palani
            rising_edge_clk_p3 = $realtime;
            
            //Clock low time check
            if ((rising_edge_clk_p3 < (falling_edge_clk_p3 + tCL)) && ($realtime > tCL)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 Clock LOW time - tCL violation.", $realtime);
               no_grnt_msg;
            end
            
            // Address setup time check
            if ((rising_edge_clk_p3 < (tSA + addr_last_change_p3))&& setup_hold_chk && (!((mkp3_rd_en_p4 == 1'b1) || (cntp3_rd_en_p4 == 1'b1) ||  (msk_disable_p3 == 1'b1) || (cnt_disable_p3 == 1'b1) || (rdp3_tAC_p5 == 1'b1) || (rdp3_tAC_dis == 1'b1)))) begin
               if (TmsgOn) $display ("%t \t Model WARNING := A_P3 to CPP_P3 Setup time - tSA violation.", $realtime);
               no_grnt_msg;
            end
            
            // Byte select setup time
            if ((rising_edge_clk_p3 < (tSB + byte_sel_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := B_NP3 to CPP_P3 Setup time - tSB violation.", $realtime);
               no_grnt_msg;
            end
            
            // Chip enable setup time        
            if ((rising_edge_clk_p3 < (tSC + ce0_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE0_P3 to CPP_P3 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            if ((rising_edge_clk_p3 < (tSC + ce1_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE1_P3 to CPP_P3 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            // R/W Setup time
            if ((rising_edge_clk_p3 < (tSW + rw_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := R_W_NP3 to CPP_P3 Setup time - tSW violation", $realtime);
               no_grnt_msg;
            end
            
            // Input Data setup time
            if ((rising_edge_clk_p3 < (tSD + dq_last_change_p3))&& (setup_hold_chk) && (r_w_np3 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DQ_P3 to CPP_P3 Setup time - tSD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRST Setup time
            if ((rising_edge_clk_p3 < (tSRST + cntrst_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRST_NP3 to CPP_P3 Setup time - tSRST violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTLD Setup time
            if ((rising_edge_clk_p3 < (tSCLD + cntld_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTLD_NP3 to CPP_P3 Setup time - tSCLD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTINC Setup time
            if ((rising_edge_clk_p3 < (tSCINC + cntinc_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTINC_NP3 to CPP_P3 Setup time - tSCINC violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRD Setup time
            if ((rising_edge_clk_p3 < (tSCRD + cntrd_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRD_NP3 to CPP_P3 Setup time - tSCRD violation.", $realtime);
               no_grnt_msg;
            end
            
            // MKLD Setup time
            if ((rising_edge_clk_p3 < (tSMLD + mkld_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKLD_NP3 to CPP_P3 Setup time - tSMLD violation.", $realtime);
               no_grnt_msg;
            end
            
            // MKRD Setup time
            if ((rising_edge_clk_p3 < (tSMRD + mkrd_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKRD_NP3 to CPP_P3 Setup time - tSMRD violation.", $realtime);
               no_grnt_msg;
            end
            
            // WRP0 Setup time
            if ((rising_edge_clk_p3 < (tSWRP + wrp0_nlast_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := WRP0_NP3 to CPP_P3 Setup time - tSWRP violation.", $realtime);
               no_grnt_msg;
            end
            
            // RETX Setup time
            if ((rising_edge_clk_p3 < (tSRT + retx_last_change_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := RETX_NP3 to CPP_P3 Setup time - tSRT violation.", $realtime);
               no_grnt_msg;
            end
         end    
           

         //------------------------------------------------------------------------------
         //Setup timing checks for port four
         //------------------------------------------------------------------------------
         
         if (clkp4_event && (cpp4 === 1'b1)) begin
            // Clock cycle time check
            if (($realtime < (rising_edge_clk_p4 + tCYC)) && ($realtime > tCYC)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 Clock cycle time - tCYC violation.", $realtime);
               no_grnt_msg;
            end else begin//ver 2.0 palani
               // Checking for clock stability
               if(($realtime - rising_edge_clk_p4) > 10)begin
                  if(mrst_n == 1'b0)begin
                     clk_stb_p4 = 1'b1;
                  end else begin
                     if((doff_np4 === 1'b1) && (ddisp_flag_p4 == 1'b0))begin
                        if(cnt_doff4 < 1023)
                          cnt_doff4 = cnt_doff4 + 1;
                        else begin
                           if (TmsgOn) $display ("%t \t Model ERROR := CPP_P4 not stable ", $realtime);
                           if (TmsgOn) $display ("%t\t                The Model will function as per the timings set in the configuration mode", $realtime);//ver 2.0 ashish
                           if (TmsgOn) $display ("%t\t                DOFF_NP4 should be low to turn off the internal DLLs", $realtime);//ver 2.0 ashish
                           cnt_doff4 = 0;
                           ddisp_flag_p4 = 1'b1;
                        end
                     end 
                  end
               end else begin
                  clk_stb_p4 = 1'b0;
                  ddisp_flag_p4 = 1'b0;
                  cnt_doff4 = 0;
               end
            end
            if (reset_over == 1'b1)begin
               if (doff_flag_p4 == 1'b0) begin
                  if (cnt_stb_set_p4 < 1)
                    cnt_stb_set_p4 = cnt_stb_set_p4 + 1;
                  else begin
                     ready_np4 = 1'b0;
                     cnt_stb_set_p4 = 0;
                     ready_set_p4 = 1'b1;
                  end
               end
               else begin
                  if (cnt_stb_set1_p4 < 1023)
                    cnt_stb_set1_p4 = cnt_stb_set1_p4 + 1;
                  else begin
                     ready_np4 = 1'b0;
                     cnt_stb_set1_p4 = 0;
                     ready_set_p4 = 1'b1;
                  end
               end
            end//ver 2.0 palani
            rising_edge_clk_p4 = $realtime;

            //Clock low time check
            if ((rising_edge_clk_p4 < (falling_edge_clk_p4 + tCL)) && ($realtime > tCL)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 Clock LOW time - tCL violation.", $realtime);
               no_grnt_msg;
            end
            
            // Address setup time check
            if ((rising_edge_clk_p4 < (tSA + addr_last_change_p4))&& setup_hold_chk && (!((mkp4_rd_en_p4 == 1'b1) || (cntp4_rd_en_p4 == 1'b1) ||  (msk_disable_p4 == 1'b1) || (cnt_disable_p4 == 1'b1) || (rdp4_tAC_p5 == 1'b1) || (rdp4_tAC_dis == 1'b1)))) begin
               if (TmsgOn) $display ("%t \t Model WARNING := A_P4 to CPP_P4 Setup time - tSA violation.", $realtime);
               no_grnt_msg;
            end
            
            // Byte select setup time
            if ((rising_edge_clk_p4 < (tSB + byte_sel_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := B_NP4 to CPP_P4 Setup time - tSB violation.", $realtime);
               no_grnt_msg;
            end
            
            // Chip enable setup time        
            if ((rising_edge_clk_p4 < (tSC + ce0_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE0_P4 to CPP_P4 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            if ((rising_edge_clk_p4 < (tSC + ce1_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CE1_P4 to CPP_P4 Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            // R/W Setup time
            if ((rising_edge_clk_p4 < (tSW + rw_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := R_W_NP4 to CPP_P4 Setup time - tSW violation", $realtime);
               no_grnt_msg;
            end
            
            // Input Data setup time
            if ((rising_edge_clk_p4 < (tSD + dq_last_change_p4))&& (setup_hold_chk) && (r_w_np4 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DQ_P4 to CPP_P4 Setup time - tSD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRST Setup time
            if ((rising_edge_clk_p4 < (tSRST + cntrst_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRST_NP4 to CPP_P4 Setup time - tSRST violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTLD Setup time
            if ((rising_edge_clk_p4 < (tSCLD + cntld_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTLD_NP4 to CPP_P4 Setup time - tSCLD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTINC Setup time
            if ((rising_edge_clk_p4 < (tSCINC + cntinc_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTINC_NP4 to CPP_P4 Setup time - tSCINC violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRD Setup time
            if ((rising_edge_clk_p4 < (tSCRD + cntrd_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CNTRD_NP4 to CPP_P4 Setup time - tSCRD violation.", $realtime);
               no_grnt_msg;
            end
            
            // MKLD Setup time
            if ((rising_edge_clk_p4 < (tSMLD + mkld_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKLD_NP4 to CPP_P4 Setup time - tSMLD violation.", $realtime);
               no_grnt_msg;
            end
            
            // MKRD Setup time
            if ((rising_edge_clk_p4 < (tSMRD + mkrd_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MKRD_NP4 to CPP_P4 Setup time - tSMRD violation.", $realtime);
               no_grnt_msg;
            end
            
            // WRP0 Setup time
            if ((rising_edge_clk_p4 < (tSWRP + wrp0_nlast_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := WRP0_NP4 to CPP_P4 Setup time - tSWRP violation.", $realtime);
               no_grnt_msg;
            end
            
            // RETX Setup time
            if ((rising_edge_clk_p4 < (tSRT + retx_last_change_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := RETX_NP4 to CPP_P4 Setup time - tSRT violation.", $realtime);
               no_grnt_msg;
            end
         end    
         

         //-------------------------------------------------------------------------------------------
         //                  Hold violation checks
         //------------------------------------------------------------------------------------------- 

         //----------------------------------------------
         // HOLD Time violation checks for port one
         //----------------------------------------------

         // Address hold time
         if (ap1_event) begin
            if (($realtime < (tHA + rising_edge_clk_p1)) && setup_hold_chk && (!((mkp1_rd_en_p4 == 1'b1) || (cntp1_rd_en_p4 == 1'b1) ||  (msk_disable_p1 == 1'b1) || (cnt_disable_p1 == 1'b1) || (rdp1_tAC_p5 == 1'b1) || (rdp1_tAC_dis == 1'b1)))) begin//ver 2.0 palani
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to A_P1 Hold time - tHA violation.", $realtime);
               no_grnt_msg;
            end
            addr_last_change_p1 = $realtime;
         end

         // Byte select hold time
         if (b_np1_event) begin
            if (($realtime < (tHB + rising_edge_clk_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to B_NP1 Hold time - tHB violation.", $realtime);
               no_grnt_msg;
            end
            
            if (($realtime < (tRSR + rising_edge_mrst))&& ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to B_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to B_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            byte_sel_last_change_p1 = $realtime;
         end
         
         
         // Chip enable hold time
         if (ce0_np1_event) begin
            if (($realtime < (tHC + rising_edge_clk_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to CE0_NP1 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE0_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to CE0_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce0_last_change_p1 = $realtime;
         end
         
         if (ce1p1_event) begin   
            if (($realtime < (tHC + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to CE1_P1 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE1_P1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to CE1_P1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce1_last_change_p1 = $realtime;
         end

         // R/W Hold time
         if (r_w_np1_event) begin
            if (($realtime < (tHW + rising_edge_clk_p1))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to R_W_NP1 Hold time - tHW violation", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to R_W_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to R_W_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            rw_last_change_p1 = $realtime;
         end
         
         // Input Data hold time
         if (dqp1_event) begin
            if (($realtime < (tHD + rising_edge_clk_p1))&& (setup_hold_chk) && (r_w_np1 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to DQ_P1 Hold time - tHD violation.", $realtime);
               no_grnt_msg;
            end
            dq_last_change_p1 = $realtime;
         end
         
         // CNTRST Hold time
         if (cntrst_np1_event) begin
            if (($realtime < (tHRST + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to CNTRST_NP1 Hold time - tHRST violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRST_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to CNTRST_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrst_last_change_p1 = $realtime;
         end
         
         // CNTLD Hold time
         if (cntld_np1_event) begin
            if (($realtime < (tHCLD + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to CNTLD_NP1 Hold time - tHCLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTLD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to CNTLD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntld_last_change_p1 = $realtime;
         end
         
         // CNTRD Hold time
         if (cntrd_np1_event) begin
            if (($realtime < (tHCRD + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to CNTRD_NP1 Hold time - tHCRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to CNTRD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrd_last_change_p1 = $realtime;
         end
         
         // CNTINC Hold time
         if (cntinc_np1_event) begin
            if (($realtime < (tHCINC + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to CNTINC_NP1 Hold time - tHCINC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTINC_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to CNTINC_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntinc_last_change_p1 = $realtime;
         end
         
         // MKLD Hold time
         if (mkld_np1_event) begin
            if (($realtime < (tHMLD + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to MKLD_NP1 Hold time - tHMLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKLD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to MKLD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkld_last_change_p1 = $realtime;
         end
         
         // MKRD Hold time
         if (mkrd_np1_event) begin
            if (($realtime < (tHMRD + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to MKRD_NP1 Hold time - tHMRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKRD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to MKRD_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkrd_last_change_p1 = $realtime;
         end
         
         // WRP0 Hold time
         if (wrp0_nnp1_event) begin
            if (($realtime < (tHWRP + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to WRP0_NP1 Hold time - tHWRP violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to WRP0_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to WRP0_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            wrp0_nlast_change_p1 = $realtime;
         end
         
         // RETX Hold time
         if (retx_np1_event) begin
            if (($realtime < (tHRT + rising_edge_clk_p1)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P1 to RETX_NP1 Hold time - tHRT violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to RETX_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np1))&& ($realtime > tRSR) && (doff_np1_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP1 to RETX_NP1 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            retx_last_change_p1 = $realtime;
         end
         
         
         //----------------------------------------------
         // HOLD Time violation checks for port two
         //----------------------------------------------
         
         // Address hold time
         if (ap2_event) begin
            if (($realtime < (tHA + rising_edge_clk_p2)) && setup_hold_chk&& (!((mkp2_rd_en_p4 == 1'b1) || (cntp2_rd_en_p4 == 1'b1) ||  (msk_disable_p2 == 1'b1) || (cnt_disable_p2 == 1'b1) || (rdp2_tAC_p5 == 1'b1) || (rdp2_tAC_dis == 1'b1)))) begin//ver 2.0 palani
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to A_P2 Hold time - tHA violation.", $realtime);
               no_grnt_msg;
            end
            addr_last_change_p2 = $realtime;
         end
         
         // Byte select hold time
         if (b_np2_event) begin
            if (($realtime < (tHB + rising_edge_clk_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to B_NP2 Hold time - tHB violation.", $realtime);
               no_grnt_msg;
            end
            
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to B_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to B_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            byte_sel_last_change_p2 = $realtime;
         end
         
         
         // Chip enable hold time
         if (ce0_np2_event) begin
            if (($realtime < (tHC + rising_edge_clk_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to CE0_P2 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE0_P2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to CE0_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce0_last_change_p2 = $realtime;
         end
         
         if (ce1p2_event) begin   
            if (($realtime < (tHC + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to CE1_P2 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE1_P2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to CE1_P2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce1_last_change_p2 = $realtime;
         end

         // R/W Hold time
         if (r_w_np2_event) begin
            if (($realtime < (tHW + rising_edge_clk_p2))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to R_W_NP2 Hold time - tHW violation", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to R_W_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to R_W_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            rw_last_change_p2 = $realtime;
         end
         
         // Input Data hold time
         if (dqp2_event) begin
            if (($realtime < (tHD + rising_edge_clk_p2))&& (setup_hold_chk) && (r_w_np2 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to DQ_P2 Hold time - tHD violation.", $realtime);
               no_grnt_msg;
            end
            dq_last_change_p2 = $realtime;
         end
         
         // CNTRST Hold time
         if (cntrst_np2_event) begin
            if (($realtime < (tHRST + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to CNTRST_NP2 Hold time - tHRST violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRST_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to CNTRST_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrst_last_change_p2 = $realtime;
         end
         
         // CNTLD Hold time
         if (cntld_np2_event) begin
            if (($realtime < (tHCLD + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to CNTLD_NP2 Hold time - tHCLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTLD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to CNTLD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntld_last_change_p2 = $realtime;
         end
         
         // CNTRD Hold time
         if (cntrd_np2_event) begin
            if (($realtime < (tHCRD + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to CNTRD_NP2 Hold time - tHCRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to CNTRD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrd_last_change_p2 = $realtime;
         end
         
         // CNTINC Hold time
         if (cntinc_np2_event) begin
            if (($realtime < (tHCINC + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to CNTINC_NP2 Hold time - tHCINC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTINC_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to CNTINC_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntinc_last_change_p2 = $realtime;
         end
         
         // MKLD Hold time
         if (mkld_np2_event) begin
            if (($realtime < (tHMLD + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to MKLD_NP2 Hold time - tHMLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKLD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to MKLD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkld_last_change_p2 = $realtime;
         end
         
         // MKRD Hold time
         if (mkrd_np2_event) begin
            if (($realtime < (tHMRD + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to MKRD_NP2 Hold time - tHMRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKRD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to MKRD_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkrd_last_change_p2 = $realtime;
         end
         
         // WRP0 Hold time
         if (wrp0_nnp2_event) begin
            if (($realtime < (tHWRP + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to WRP0_NP2 Hold time - tHWRP violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to WRP0_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to WRP0_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            wrp0_nlast_change_p2 = $realtime;
         end
         
         // RETX Hold time
         if (retx_np2_event) begin
            if (($realtime < (tHRT + rising_edge_clk_p2)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P2 to RETX_NP2 Hold time - tHRT violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to RETX_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np2))&& ($realtime > tRSR) && (doff_np2_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP2 to RETX_NP2 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            retx_last_change_p2 = $realtime;
         end
         
         
         //----------------------------------------------
         // HOLD Time violation checks for port three
         //----------------------------------------------
         
         // Address hold time
         if (ap3_event) begin
            if (($realtime < (tHA + rising_edge_clk_p3)) && setup_hold_chk && (!((mkp3_rd_en_p4 == 1'b1) || (cntp3_rd_en_p4 == 1'b1) ||  (msk_disable_p3 == 1'b1) || (cnt_disable_p3 == 1'b1) || (rdp3_tAC_p5 == 1'b1) || (rdp3_tAC_dis == 1'b1)))) begin//ver 2.0 palani
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to A_P3 Hold time - tHA violation.", $realtime);
               no_grnt_msg;
            end
            addr_last_change_p3 = $realtime;
         end
         
         // Byte select hold time
         if (b_np3_event) begin
            if (($realtime < (tHB + rising_edge_clk_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to B_NP3 Hold time - tHB violation.", $realtime);
               no_grnt_msg;
            end
            
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to B_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to B_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            byte_sel_last_change_p3 = $realtime;
         end
         
         
         // Chip enable hold time
         if (ce0_np3_event) begin
            if (($realtime < (tHC + rising_edge_clk_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to CE0_P3 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE0_p3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to CE0_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce0_last_change_p3 = $realtime;
         end
         
         if (ce1p3_event) begin   
            if (($realtime < (tHC + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to CE1_P3 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE1_p3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to CE1_P3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce1_last_change_p3 = $realtime;
         end

         // R/W Hold time
         if (r_w_np3_event) begin
            if (($realtime < (tHW + rising_edge_clk_p3))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to R_W_NP3 Hold time - tHW violation", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to R_W_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to R_W_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            rw_last_change_p3 = $realtime;
         end
         
         // Input Data hold time
         if (dqp3_event) begin
            if (($realtime < (tHD + rising_edge_clk_p3))&& (setup_hold_chk) && (r_w_np3 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to DQ_P3 Hold time - tHD violation.", $realtime);
               no_grnt_msg;
            end
            dq_last_change_p3 = $realtime;
         end
         
         // CNTRST Hold time
         if (cntrst_np3_event) begin
            if (($realtime < (tHRST + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to CNTRST_NP3 Hold time - tHRST violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRST_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to CNTRST_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrst_last_change_p3 = $realtime;
         end
         
         // CNTLD Hold time
         if (cntld_np3_event) begin
            if (($realtime < (tHCLD + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to CNTLD_NP3 Hold time - tHCLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTLD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to CNTLD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntld_last_change_p3 = $realtime;
         end
         
         // CNTRD Hold time
         if (cntrd_np3_event) begin
            if (($realtime < (tHCRD + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to CNTRD_NP3 Hold time - tHCRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to CNTRD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrd_last_change_p3 = $realtime;
         end
         
         // CNTINC Hold time
         if (cntinc_np3_event) begin
            if (($realtime < (tHCINC + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to CNTINC_NP3 Hold time - tHCINC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTINC_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to CNTINC_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntinc_last_change_p3 = $realtime;
         end
         
         // MKLD Hold time
         if (mkld_np3_event) begin
            if (($realtime < (tHMLD + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to MKLD_NP3 Hold time - tHMLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKLD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to MKLD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkld_last_change_p3 = $realtime;
         end
         
         // MKRD Hold time
         if (mkrd_np3_event) begin
            if (($realtime < (tHMRD + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to MKRD_NP3 Hold time - tHMRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKRD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to MKRD_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkrd_last_change_p3 = $realtime;
         end
         
         // WRP0 Hold time
         if (wrp0_nnp3_event) begin
            if (($realtime < (tHWRP + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to WRP0_NP3 Hold time - tHWRP violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to WRP0_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to WRP0_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            wrp0_nlast_change_p3 = $realtime;
         end
         
         // RETX Hold time
         if (retx_np3_event) begin
            if (($realtime < (tHRT + rising_edge_clk_p3)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P3 to RETX_NP3 Hold time - tHRT violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to RETX_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np3))&& ($realtime > tRSR) && (doff_np3_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP3 to RETX_NP3 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            retx_last_change_p3 = $realtime;
         end
         
         
         //----------------------------------------------
         // HOLD Time violation checks for port four
         //----------------------------------------------
         
         // Address hold time
         if (ap4_event) begin
            if (($realtime < (tHA + rising_edge_clk_p4)) && setup_hold_chk && (!((mkp4_rd_en_p4 == 1'b1) || (cntp4_rd_en_p4 == 1'b1) ||  (msk_disable_p4 == 1'b1) || (cnt_disable_p4 == 1'b1) || (rdp4_tAC_p5 == 1'b1) || (rdp4_tAC_dis == 1'b1)))) begin//ver 2.0 palani
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to A_P4 Hold time - tHA violation.", $realtime);
               no_grnt_msg;
            end
            addr_last_change_p4 = $realtime;
         end
         
         // Byte select hold time
         if (b_np4_event) begin
            if (($realtime < (tHB + rising_edge_clk_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to B_NP4 Hold time - tHB violation.", $realtime);
               no_grnt_msg;
            end
            
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to B_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to B_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            byte_sel_last_change_p4 = $realtime;
         end
         
         
         // Chip enable hold time
         if (ce0_np4_event) begin
            if (($realtime < (tHC + rising_edge_clk_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to CE0_P4 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE0_p4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to CE0_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce0_last_change_p4 = $realtime;
         end
         
         if (ce1p4_event) begin   
            if (($realtime < (tHC + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to CE1_P4 Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CE1_p4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to CE1_P4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            ce1_last_change_p4 = $realtime;
         end

         // R/W Hold time
         if (r_w_np4_event) begin
            if (($realtime < (tHW + rising_edge_clk_p4))&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to R_W_NP4 Hold time - tHW violation", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to R_W_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to R_W_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            rw_last_change_p4 = $realtime;
         end
         
         // Input Data hold time
         if (dqp4_event) begin
            if (($realtime < (tHD + rising_edge_clk_p4))&& (setup_hold_chk) && (r_w_np4 === 0)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to DQ_P4 Hold time - tHD violation.", $realtime);
               no_grnt_msg;
            end
            dq_last_change_p4 = $realtime;
         end
         
         // CNTRST Hold time
         if (cntrst_np4_event) begin
            if (($realtime < (tHRST + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to CNTRST_NP4 Hold time - tHRST violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRST_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to CNTRST_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrst_last_change_p4 = $realtime;
         end
         
         // CNTLD Hold time
         if (cntld_np4_event) begin
            if (($realtime < (tHCLD + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to CNTLD_NP4 Hold time - tHCLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTLD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to CNTLD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntld_last_change_p4 = $realtime;
         end
         
         // CNTRD Hold time
         if (cntrd_np4_event) begin
            if (($realtime < (tHCRD + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to CNTRD_NP4 Hold time - tHCRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTRD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to CNTRD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntrd_last_change_p4 = $realtime;
         end
         
         // CNTINC Hold time
         if (cntinc_np4_event) begin
            if (($realtime < (tHCINC + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to CNTINC_NP4 Hold time - tHCINC violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to CNTINC_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to CNTINC_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            cntinc_last_change_p4 = $realtime;
         end
         
         // MKLD Hold time
         if (mkld_np4_event) begin
            if (($realtime < (tHMLD + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to MKLD_NP4 Hold time - tHMLD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKLD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to MKLD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkld_last_change_p4 = $realtime;
         end
         
         // MKRD Hold time
         if (mkrd_np4_event) begin
            if (($realtime < (tHMRD + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to MKRD_NP4 Hold time - tHMRD violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to MKRD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to MKRD_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            mkrd_last_change_p4 = $realtime;
         end
         
         // WRP0 Hold time
         if (wrp0_nnp4_event) begin
            if (($realtime < (tHWRP + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to WRP0_NP4 Hold time - tHWRP violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to WRP0_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to WRP0_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            wrp0_nlast_change_p4 = $realtime;
         end
         
         // RETX Hold time
         if (retx_np4_event) begin
            if (($realtime < (tHRT + rising_edge_clk_p4)) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t \t Model WARNING := CPP_P4 to RETX_NP4 Hold time - tHRT violation.", $realtime);
               no_grnt_msg;
            end
            if (($realtime < (rising_edge_mrst + tRSR)) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := MRST to RETX_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            if (($realtime < (tRSR + rising_edge_doff_np4))&& ($realtime > tRSR) && (doff_np4_event=== 1'b1)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := DOFF_NP4 to RETX_NP4 Recovery Time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            //-------------------
            // ver 3.0 PAL
            //-------------------
            retx_last_change_p4 = $realtime;
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
            if ((rising_edge_mrst < (falling_edge_mrst + tRS )) && ($realtime > tRS)) begin
               if (TmsgOn) $display ("%t \t Model WARNING := Master Reset Pulse Width - tRS violation.", $realtime);
               no_grnt_msg;
            end 
            //*************************************************************************
            // ver 2.0 ashish
            //*************************************************************************
            if(mrstedge_flag_p1 == 1'b1)begin
               mrstedge_flag_p1 = 1'b0;
               if(doff_np1 == 1'b0)begin
                  tCD_DLL_p1 = tCD2;
                  tDC_DLL_p1 = tDC2;
                  tCKLZ_DLL_p1 = tCKLZ2;
                  tCKHZ_min_DLL_p1 = tCKHZ2_min;
                  tCKHZ_max_DLL_p1 = tCKHZ2_max;                  
                  doff_flag_p1 = 1'b0;
               end else begin
                  tCD_DLL_p1 = tCD; 
                  tDC_DLL_p1 = tDC;
                  tCKLZ_DLL_p1 = tCKLZ;
                  tCKHZ_min_DLL_p1 = tCKHZ_min;
                  tCKHZ_max_DLL_p1 = tCKHZ_max;
                  doff_flag_p1 = 1'b1;
               end
            end 
            if(mrstedge_flag_p2 == 1'b1)begin
               mrstedge_flag_p2 = 1'b0;
               if(doff_np2 == 1'b0)begin
                  tCD_DLL_p2 = tCD2;
                  tDC_DLL_p2 = tDC2;
                  tCKLZ_DLL_p2 = tCKLZ2;
                  tCKHZ_min_DLL_p2 = tCKHZ2_min;                  
                  tCKHZ_max_DLL_p2 = tCKHZ2_max;
                  doff_flag_p2 = 1'b0;
               end else begin
                  tCD_DLL_p2 = tCD; 
                  tDC_DLL_p2 = tDC;
                  tCKLZ_DLL_p2 = tCKLZ;
                  tCKHZ_min_DLL_p2 = tCKHZ_min;
                  tCKHZ_max_DLL_p2 = tCKHZ_max;
                  doff_flag_p2 = 1'b1;
               end
            end
            if(mrstedge_flag_p3 == 1'b1)begin
               mrstedge_flag_p3 = 1'b0;
               if(doff_np3 == 1'b0)begin
                  tCD_DLL_p3 = tCD2;
                  tDC_DLL_p3 = tDC2;
                  tCKLZ_DLL_p3 = tCKLZ2;
                  tCKHZ_min_DLL_p3 = tCKHZ2_min;                  
                  tCKHZ_max_DLL_p3 = tCKHZ2_max;
                  doff_flag_p3 = 1'b0;
               end else begin
                  tCD_DLL_p3 = tCD; 
                  tDC_DLL_p3 = tDC;
                  tCKLZ_DLL_p3 = tCKLZ;
                  tCKHZ_min_DLL_p3 = tCKHZ_min;
                  tCKHZ_max_DLL_p3 = tCKHZ_max;
                  doff_flag_p3 = 1'b1;
               end
            end
            if(mrstedge_flag_p4 == 1'b1)begin
               mrstedge_flag_p4 = 1'b0;
               if(doff_np4 == 1'b0)begin
                  tCD_DLL_p4 = tCD2; 
                  tDC_DLL_p4 = tDC2;
                  tCKLZ_DLL_p4 = tCKLZ2;
                  tCKHZ_min_DLL_p4 = tCKHZ2_min;
                  tCKHZ_max_DLL_p4 = tCKHZ2_max;                  
                  doff_flag_p4 = 1'b0;
               end else begin
                  tCD_DLL_p4 = tCD; 
                  tDC_DLL_p4 = tDC;
                  tCKLZ_DLL_p4 = tCKLZ;
                  tCKHZ_min_DLL_p4 = tCKHZ_min;
                  tCKHZ_max_DLL_p4 = tCKHZ_max;
                  doff_flag_p4 = 1'b1;
               end
            end
            //*************************************************************************
            // ver 2.0 ashish
            //*************************************************************************
            if(clk_stb_p1 == 1'b1) begin
               if(TmsgOn) $display ("%t \t Model ERROR := MRST_N is deasserted before the CPP_P1 stability", $realtime);
            end                                                  
            if(clk_stb_p2 == 1'b1) begin                         
               if(TmsgOn) $display ("%t \t Model ERROR := MRST_N is deasserted before the CPP_P2 stability", $realtime);
            end                                                  
            if(clk_stb_p3 == 1'b1) begin                         
               if(TmsgOn) $display ("%t \t Model ERROR := MRST_N is deasserted before the CPP_P3 stability", $realtime);
            end                                                  
            if(clk_stb_p4 == 1'b1) begin                         
               if(TmsgOn) $display ("%t \t Model ERROR := MRST_N is deasserted before the CPP_P4 stability", $realtime);
            end
         end // if (mrst_n_event && (mrst_n === 1'b1))
         //-------------------------------------------
         // ver 3.0 PAL
         //-------------------------------------------
         else begin
            if(doff_event_p1)begin
               if(doff_np1 == 1'b0)begin
                  tCD_DLL_p1 = tCD2;
                  tDC_DLL_p1 = tDC2;
                  tCKLZ_DLL_p1 = tCKLZ2;
                  tCKHZ_min_DLL_p1 = tCKHZ2_min;
                  tCKHZ_max_DLL_p1 = tCKHZ2_max;                  
                  doff_flag_p1 = 1'b0;
               end else begin
                  tCD_DLL_p1 = tCD; 
                  tDC_DLL_p1 = tDC;
                  tCKLZ_DLL_p1 = tCKLZ;
                  tCKHZ_min_DLL_p1 = tCKHZ_min;
                  tCKHZ_max_DLL_p1 = tCKHZ_max;
                  doff_flag_p1 = 1'b1;
               end
            end 
            if(doff_event_p2)begin
               if(doff_np2 == 1'b0)begin
                  tCD_DLL_p2 = tCD2;
                  tDC_DLL_p2 = tDC2;
                  tCKLZ_DLL_p2 = tCKLZ2;
                  tCKHZ_min_DLL_p2 = tCKHZ2_min;                  
                  tCKHZ_max_DLL_p2 = tCKHZ2_max;
                  doff_flag_p2 = 1'b0;
               end else begin
                  tCD_DLL_p2 = tCD; 
                  tDC_DLL_p2 = tDC;
                  tCKLZ_DLL_p2 = tCKLZ;
                  tCKHZ_min_DLL_p2 = tCKHZ_min;
                  tCKHZ_max_DLL_p2 = tCKHZ_max;
                  doff_flag_p2 = 1'b1;
               end
            end
            if(doff_event_p3)begin
               if(doff_np3 == 1'b0)begin
                  tCD_DLL_p3 = tCD2;
                  tDC_DLL_p3 = tDC2;
                  tCKLZ_DLL_p3 = tCKLZ2;
                  tCKHZ_min_DLL_p3 = tCKHZ2_min;                  
                  tCKHZ_max_DLL_p3 = tCKHZ2_max;
                  doff_flag_p3 = 1'b0;
               end else begin
                  tCD_DLL_p3 = tCD; 
                  tDC_DLL_p3 = tDC;
                  tCKLZ_DLL_p3 = tCKLZ;
                  tCKHZ_min_DLL_p3 = tCKHZ_min;
                  tCKHZ_max_DLL_p3 = tCKHZ_max;
                  doff_flag_p3 = 1'b1;
               end
            end
            if(doff_event_p4)begin
               if(doff_np4 == 1'b0)begin
                  tCD_DLL_p4 = tCD2; 
                  tDC_DLL_p4 = tDC2;
                  tCKLZ_DLL_p4 = tCKLZ2;
                  tCKHZ_min_DLL_p4 = tCKHZ2_min;
                  tCKHZ_max_DLL_p4 = tCKHZ2_max;                  
                  doff_flag_p4 = 1'b0;
               end else begin
                  tCD_DLL_p4 = tCD; 
                  tDC_DLL_p4 = tDC;
                  tCKLZ_DLL_p4 = tCKLZ;
                  tCKHZ_min_DLL_p4 = tCKHZ_min;
                  tCKHZ_max_DLL_p4 = tCKHZ_max;
                  doff_flag_p4 = 1'b1;
               end
            end
         end // else: !if(mrst_n_event && (mrst_n === 1'b1))
         //-------------------------------------------
         // ver 3.0 PAL
         //-------------------------------------------
                  
      end
endtask // timing_chk

task no_grnt_msg;
      if (TmsgOn) $display ("\t\t\t          Device operation is not guaranteed");
endtask // no_grnt_msg

//---------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------
// Function:    reset_chk_fn
//
// Description: Checks whether reset is over or not ? and returns 1 if it's reset.
//-----------------------------------------------------------------------------------------------
function reset_chk_fn;
      input none;
      
      begin
         if (reset_over == 1'b0) begin
            if (rst_disp_flag == 1'b0) begin
               if (TmsgOn) $display("%t\t Model WARNING := Operating the device without performing Reset operation:", $realtime);
               if (TmsgOn) $display("\t\t\t          Reset the device to function properly\n");
               rst_disp_flag = 1'b1;
            end           
            reset_chk_fn = 1'b0;
         end else begin
            reset_chk_fn = 1'b1;
         end
      end
endfunction // reset_chk_fn

//-----------------------------------------------------------------------------------------------
// Function:    read_tCCS_chk_fn
//
// Description: Checks tCCS violation while accessing same memory location simultaneously
//               by two ports.
// Version : 3.41 PAL
//-----------------------------------------------------------------------------------------------

function read_tCCS_chk_fn;
      input [1:0]port;
      integer t1,t2,t3,t4,t_tccs;
      begin
         case (port)
           `port1: begin              
              t_tccs = 1000 * tCCS;
              t2 = 1000 * ($realtime - tCCS_chk_w2);
              t3 = 1000 * ($realtime - tCCS_chk_w3);
              t4 = 1000 * ($realtime - tCCS_chk_w4);
              if ((((t2 < t_tccs) && (last_access_type_p2 == `WRITE) && (last_addr_p2 == cntp1_reg_p1)) || ((t3 < t_tccs) && (last_access_type_p3 == `WRITE) && (last_addr_p3 == cntp1_reg_p1)) || ((t4 < t_tccs) && (last_access_type_p4 == `WRITE) && (last_addr_p4 == cntp1_reg_p1))) && !(last_port == `port1)) begin
                 if (TmsgOn && !p2_1 && !p3_1 && !p4_1) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port1:", $realtime);
                 if (TmsgOn && !p2_1 && !p3_1 && !p4_1) $display("\t\t                Data Output is unpredictable");
                 read_tCCS_chk_fn = 1'b1;
              end else begin
                 if (DmsgOn) $display("%t Model :=  Reading Data from Port1 ", $realtime);
                 read_tCCS_chk_fn = 1'b0;
              end
              last_access_type_p1 = `READ;               
           end          
           `port2: begin
              t_tccs = 1000 * tCCS;              
              t1 = 1000 * ($realtime - tCCS_chk_w1);
              t3 = 1000 * ($realtime - tCCS_chk_w3);
              t4 = 1000 * ($realtime - tCCS_chk_w4);
              if ((((t1 < t_tccs) && (last_access_type_p1 == `WRITE) && (last_addr_p1 == cntp2_reg_p1)) || ((t3 < t_tccs) && (last_access_type_p3 == `WRITE) && (last_addr_p3 == cntp2_reg_p1)) || ((t4 < t_tccs) && (last_access_type_p4 == `WRITE) && (last_addr_p4 == cntp2_reg_p1))) && !(last_port == `port2)) begin
                 if (TmsgOn && !p1_2 && !p3_2 && !p4_2) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port2:", $realtime);
                 if (TmsgOn && !p1_2 && !p3_2 && !p4_2) $display("\t\t                Data Output is unpredictable");
                 read_tCCS_chk_fn = 1'b1;
              end else begin
                 if (DmsgOn) $display("%t Model :=  Reading Data from Port2 ", $realtime);
                 read_tCCS_chk_fn = 1'b0;
              end
              last_access_type_p2 = `READ;                             
           end 
           `port3: begin
              t_tccs = 1000 * tCCS;              
              t2 = 1000 * ($realtime - tCCS_chk_w2);
              t1 = 1000 * ($realtime - tCCS_chk_w1);
              t4 = 1000 * ($realtime - tCCS_chk_w4);              
              if ((((t2 < t_tccs) && (last_access_type_p2 == `WRITE) && (last_addr_p2 == cntp3_reg_p1)) || ((t1 < t_tccs) && (last_access_type_p1 == `WRITE) && (last_addr_p1 == cntp3_reg_p1)) || ((t4 < t_tccs) && (last_access_type_p4 == `WRITE) && (last_addr_p4 == cntp3_reg_p1))) && !(last_port == `port3)) begin
                 if (TmsgOn && !p1_3 && !p2_3 && !p4_3) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port3:", $realtime);
                 if (TmsgOn && !p1_3 && !p2_3 && !p4_3) $display("\t\t                Data Output is unpredictable");
                 read_tCCS_chk_fn = 1'b1;
              end else begin
                 if (DmsgOn) $display("%t Model := Reading Data from Port3 ", $realtime);
                 read_tCCS_chk_fn = 1'b0;
              end
              last_access_type_p3 = `READ;                             
           end 
           default:begin
              t_tccs = 1000 * tCCS;              
              t2 = 1000 * ($realtime - tCCS_chk_w2);
              t3 = 1000 * ($realtime - tCCS_chk_w3);
              t1 = 1000 * ($realtime - tCCS_chk_w1);
              if ((((t2 < t_tccs) && (last_access_type_p2 == `WRITE) && (last_addr_p2 == cntp4_reg_p1)) || ((t3 < t_tccs) && (last_access_type_p3 == `WRITE) && (last_addr_p3 == cntp4_reg_p1)) || ((t1 < t_tccs) && (last_access_type_p1 == `WRITE) && (last_addr_p1 == cntp4_reg_p1))) && !(last_port == `port4)) begin
                 if (TmsgOn && !p1_4 && !p2_4 && !p3_4) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port4:", $realtime);
                 if (TmsgOn && !p1_4 && !p2_4 && !p3_4) $display("\t\t                Data Output is unpredictable");
                 read_tCCS_chk_fn = 1'b1;
              end else begin
                 if (DmsgOn) $display("%t  Model := Reading Data from Port4 ", $realtime); 
                 read_tCCS_chk_fn = 1'b0;
              end
              last_access_type_p4 = `READ;                             
           end
         endcase
         tCCS_chk = $realtime;
      end
endfunction // read_tCCS_chk_fn


//-----------------------------------------------------------------------------------------------
// Function:    write_data_and_tCCS_chk_fn
//
// Description: Checks tCCS violation while accessing same memory location simultaneously
//              by two ports.
//              Performs write operation. 
//              Returns vaild data to be written.
// Version : 3.41 PAL
//-----------------------------------------------------------------------------------------------
function [`DT_M : 0] write_data_and_tCCS_chk_fn;
      input [1:0]port;
      reg   corruptp1_w2,corruptp1_w3,corruptp1_w4;
      reg   corruptp2_w1,corruptp2_w3,corruptp2_w4;
      reg   corruptp3_w1,corruptp3_w2,corruptp3_w4;
      reg   corruptp4_w1,corruptp4_w2,corruptp4_w3;      

      begin
         case (port)
           `port1 : begin
              if (((last_addr_p2 == cntp1_reg_p1) && wrp2_flag_p2) && (last_access_type_p2 == `WRITE)) begin
                 if (TmsgOn && !p2_1_w && !p3_1_w && !p4_1_w && !p1_3_w && !p1_4_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port1: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp1_reg_p1);
                 if (TmsgOn && !p2_1_w && !p3_2_w && !p4_2_w && !p2_3_w && !p2_4_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port2: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp1_reg_p1);
                 corruptp1_w2 = 1'b1;
                 p1_2 = 1'b0;
                 p1_2_w = 1'b1;
              end else if ((last_addr_p2 == cntp1_reg_p1) && (rdp2_tDC_p2 == 1'b1) && (last_access_type_p2 == `READ)) begin
                 if (TmsgOn && !p3_2 && !p4_2) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port2:", $realtime);
                 if (TmsgOn && !p3_2 && !p4_2) $display("\t\t\t        Data Output is unpredictable");
                 rdp2_violation_p1 = 1'b1;
                 corruptp1_w2 = 1'b0;
                 p1_2 = 1'b1; 
                 p1_2_w = 1'b0;
              end else begin
                 corruptp1_w2 = 1'b0;
                 p1_2 = 1'b0;
                 p1_2_w = 1'b0; 
              end
              if (((last_addr_p4 == cntp1_reg_p1) && wrp4_flag_p2) && (last_access_type_p4 == `WRITE)) begin
                 if (TmsgOn && !p4_1_w && !p2_1_w && !p3_1_w && !p1_2_w && !p1_3_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port1: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp1_reg_p1);
                 if (TmsgOn && !p4_1_w && !p4_2_w && !p4_3_w && !p2_4_w && !p3_4_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port4: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp1_reg_p1);
                 corruptp1_w4 = 1'b1;
                 p1_4 = 1'b0; 
                 p1_4_w = 1'b1; 
              end else if ((last_addr_p4 == cntp1_reg_p1) && (rdp4_tDC_p2 == 1'b1) && (last_access_type_p4 == `READ)) begin
                 if (TmsgOn && !p3_4 && !p2_4) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port4:", $realtime);
                 if (TmsgOn && !p3_4 && !p2_4) $display("\t\t\t        Data Output is unpredictable");
                 rdp4_violation_p1 = 1'b1;
                 corruptp1_w4 = 1'b0;
                 p1_4 = 1'b1;
                 p1_4_w = 1'b0;                 
              end else begin 
                 corruptp1_w4 = 1'b0;
                 p1_4 = 1'b0;
                 p1_4_w = 1'b0;                 
              end
              if (((last_addr_p3 == cntp1_reg_p1) && wrp3_flag_p2) && (last_access_type_p3 == `WRITE)) begin
                 if (TmsgOn && !p3_1_w && !p2_1_w && !p4_1_w && !p1_2_w && !p1_4_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port1: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp1_reg_p1);
                 if (TmsgOn && !p3_1_w && !p3_2_w && !p3_4_w && !p2_3_w && !p4_3_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port3: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp1_reg_p1);
                 corruptp1_w3 = 1'b1;
                 p1_3 = 1'b0;
                 p1_3_w = 1'b1;                 
              end else if ((last_addr_p3 == cntp1_reg_p1) && (rdp3_tDC_p2 == 1'b1) && (last_access_type_p3 == `READ)) begin
                 if (TmsgOn && !p2_3 && !p4_3) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port3:", $realtime);
                 if (TmsgOn && !p2_3 && !p4_3) $display("\t\t\t        Data Output is unpredictable");
                 rdp3_violation_p1 = 1'b1;
                 corruptp1_w3 = 1'b0;                 
                 p1_3 = 1'b1;
                 p1_3_w = 1'b0;                 
              end else begin
                 corruptp1_w3 = 1'b0;
                 p1_3 = 1'b0;
                 p1_3_w = 1'b0;                 
              end
              if(corruptp1_w2 || corruptp1_w3 || corruptp1_w4)begin
                 write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 if(dqp1_w2 === `DT_S'hz)begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
                    if (DmsgOn) $display("\t\t\t        Data written at address %h is %h ", cntp1_reg_p1,'hX);
                 end else begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = dqp1_w2;
                 end
              end   
              last_access_type_p1 = `WRITE;
              tCCS_chk_w1 = $realtime;
           end
           `port2 : begin
              if ((last_addr_p1 == cntp2_reg_p1) && (wrp1_flag_p2) && (last_access_type_p1 == `WRITE)) begin
                 if (TmsgOn && !p1_2_w && !p1_3_w && !p1_4_w && !p3_1_w && !p4_1_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port1: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp2_reg_p1);
                 if (TmsgOn && !p1_2_w && !p2_3_w && !p2_4_w && !p3_2_w && !p4_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port2: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp2_reg_p1);
                 corruptp2_w1 = 1'b1;
                 p2_1 = 1'b0;
                 p2_1_w = 1'b1;                 
              end else if ((last_addr_p1 == cntp2_reg_p1) && (rdp1_tDC_p2 == 1'b1) && (last_access_type_p1 == `READ)) begin
                 if (TmsgOn && !p3_1 && !p4_1) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port1:", $realtime);
                 if (TmsgOn && !p3_1 && !p4_1) $display("\t\t\t        Data Output is unpredictable");
                 rdp1_violation_p1 = 1'b1;
                 corruptp2_w1 = 1'b0;
                 p2_1 = 1'b1;
                 p2_1_w = 1'b0;                                  
              end else begin
                 corruptp2_w1 = 1'b0;
                 p2_1 = 1'b0;
                 p2_1_w = 1'b0;                                  
              end
              if (((last_addr_p4 == cntp2_reg_p1) && wrp4_flag_p2) && (last_access_type_p4 == `WRITE)) begin
                 if (TmsgOn && !p4_2_w && !p3_2_w && !p2_3_w && !p2_1_w && !p1_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port2: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp2_reg_p1);
                 if (TmsgOn && !p4_2_w && !p4_3_w && !p4_1_w && !p3_4_w && !p1_4_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port4: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp2_reg_p1);
                 corruptp2_w4 = 1'b1;
                 p2_4 = 1'b0; 
                 p2_4_w = 1'b1;                                                 
              end else if ((last_addr_p4 == cntp2_reg_p1) && (rdp4_tDC_p2 == 1'b1) && (last_access_type_p4 == `READ)) begin
                 if (TmsgOn && !p3_4 && !p1_4) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port4:", $realtime);
                 if (TmsgOn && !p3_4 && !p1_4) $display("\t\t\t        Data Output is unpredictable");
                 rdp4_violation_p1 = 1'b1;
                 corruptp2_w4 = 1'b0;
                 p2_4 = 1'b1;
                 p2_4_w = 1'b0;                                  
              end else begin
                 corruptp2_w4 = 1'b0;
                 p2_4 = 1'b0;
                 p2_4_w = 1'b0;                                  
              end
              if (((last_addr_p3 == cntp2_reg_p1) && wrp3_flag_p2) && (last_access_type_p3 == `WRITE)) begin
                 if (TmsgOn && !p3_2_w && !p1_2_w && !p2_1_w && !p2_4_w && !p4_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port2: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp2_reg_p1);
                 if (TmsgOn && !p3_2_w && !p3_1_w && !p1_3_w && !p3_4_w && !p4_3_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port3: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp2_reg_p1);
                 corruptp2_w3 = 1'b1;
                 p2_3 = 1'b0;
                 p2_3_w = 1'b1;                                  
              end else if ((last_addr_p3 == cntp2_reg_p1) && (rdp3_tDC_p2 == 1'b1) && (last_access_type_p3 == `READ)) begin 
                 if (TmsgOn && !p1_3 && !p4_3) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port3:", $realtime);
                 if (TmsgOn && !p1_3 && !p4_3) $display("\t\t\t        Data Output is unpredictable");
                 rdp3_violation_p1 = 1'b1;
                 corruptp2_w3 = 1'b0;     
                 p2_3 = 1'b1;
                 p2_3_w = 1'b0;                                  
              end else begin 
                 corruptp2_w3 = 1'b0;
                 p2_3 = 1'b0;
                 p2_3_w = 1'b0;                                  
              end
              if(corruptp2_w1 || corruptp2_w3 || corruptp2_w4)begin
                 write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 if(dqp2_w2 === `DT_S'hz)begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
                    if (DmsgOn) $display("\t\t\t        Data written at address %h is %h ", cntp2_reg_p1,'hX);
                 end else begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = dqp2_w2;
                 end
              end   
              last_access_type_p2 = `WRITE;                             
              tCCS_chk_w2 = $realtime;
           end
           `port3 : begin
              if ((last_addr_p1 == cntp3_reg_p1) && (wrp1_flag_p2) && (last_access_type_p1 == `WRITE)) begin
                 if (TmsgOn && !p1_3_w && !p2_3_w && !p3_2_w && !p3_4_w && !p4_3_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port3: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp3_reg_p1);
                 if (TmsgOn && !p1_3_w && !p1_2_w && !p1_4_w && !p2_1_w && !p4_1_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port1: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp3_reg_p1);
                 corruptp3_w1 = 1'b1;
                 p3_1 = 1'b0;
                 p3_1_w = 1'b1;                                  
              end else if ((last_addr_p1 == cntp3_reg_p1) && (rdp1_tDC_p2 == 1'b1) && (last_access_type_p1 == `READ)) begin
                 if (TmsgOn && !p2_1 && !p4_1) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port1:", $realtime);
                 if (TmsgOn && !p2_1 && !p4_1) $display("\t\t\t        Data Output is unpredictable");
                 rdp1_violation_p1 = 1'b1;
                 corruptp3_w1 = 1'b0;
                 p3_1 = 1'b1;
                 p3_1_w = 1'b0;                                                   
              end else begin
                 corruptp3_w1 = 1'b0;
                 p3_1 = 1'b0;
                 p3_1_w = 1'b0;                                                   
              end
              if (((last_addr_p4 == cntp3_reg_p1) && wrp4_flag_p2) && (last_access_type_p4 == `WRITE)) begin
                 if (TmsgOn && !p4_3_w && !p1_3_w && !p2_3_w && !p3_1_w && !p3_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port3: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp3_reg_p1);
                 if (TmsgOn && !p4_3_w && !p1_4_w && !p2_4_w && !p4_1_w && !p4_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port4: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp3_reg_p1);
                 corruptp3_w4 = 1'b1;
                 p3_4 = 1'b0;
                 p3_4_w = 1'b1;                                                   
              end else if ((last_addr_p4 == cntp3_reg_p1) && (rdp4_tDC_p2 == 1'b1) && (last_access_type_p4 == `READ)) begin
                 if (TmsgOn && !p2_4 && !p1_4) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port4:", $realtime);
                 if (TmsgOn && !p2_4 && !p1_4) $display("\t\t\t        Data Output is unpredictable");
                 rdp4_violation_p1 = 1'b1;
                 corruptp3_w4 = 1'b0;
                 p3_4 = 1'b1;
                 p3_4_w = 1'b0;                                                   
              end else begin
                 corruptp3_w4 = 1'b0;         
                 p3_4 = 1'b0;
                 p3_4_w = 1'b0;                                                   
              end 
              if (((last_addr_p2 == cntp3_reg_p1) && wrp2_flag_p2) && (last_access_type_p2 == `WRITE)) begin
                 if (TmsgOn && !p2_3_w && !p1_3_w && !p3_1_w && !p3_4_w && !p4_3_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port3: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp3_reg_p1);
                 if (TmsgOn && !p2_3_w && !p1_2_w && !p2_1_w && !p2_4_w && !p4_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port2: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp3_reg_p1);
                 corruptp3_w2 = 1'b1;
                 p3_2 = 1'b0;
                 p3_2_w = 1'b1;                                                   
              end else if ((last_addr_p2 == cntp3_reg_p1) && (rdp2_tDC_p2 == 1'b1) && (last_access_type_p2 == `READ)) begin
                 if (TmsgOn && !p1_2 && !p4_2) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port2:", $realtime);
                 if (TmsgOn && !p1_2 && !p4_2) $display("\t\t\t        Data Output is unpredictable");
                 rdp2_violation_p1 = 1'b1;
                 corruptp3_w2 = 1'b0;
                 p3_2 = 1'b1;
                 p3_2_w = 1'b0;                                                                                     
              end else begin
                 corruptp3_w2 = 1'b0;                       
                 p3_2 = 1'b0;
                 p3_2_w = 1'b0;                                                   
              end
              if(corruptp3_w1 || corruptp3_w2 || corruptp3_w4)begin
                 write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 if(dqp3_w2 === `DT_S'hz)begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
                    if (DmsgOn) $display("\t\t\t        Data written at address %h is %h ", cntp3_reg_p1,'hX);
                 end else begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = dqp3_w2;
                 end
              end   
              last_access_type_p3 = `WRITE;                             
              tCCS_chk_w3 = $realtime;
           end
           `port4 : begin
              if ((last_addr_p1 == cntp4_reg_p1) && (wrp1_flag_p2) && (last_access_type_p1 == `WRITE)) begin
                 if (TmsgOn && !p1_4_w && !p2_4_w && !p3_4_w && !p4_2_w && !p4_3_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port4: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp4_reg_p1);
                 if (TmsgOn && !p1_4_w && !p1_2_w && !p1_3_w && !p3_1_w && !p2_1_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port1: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp4_reg_p1);
                 corruptp4_w1 = 1'b1;
                 p4_1 = 1'b0;
                 p4_1_w = 1'b1;
              end else if ((last_addr_p1 == cntp4_reg_p1) && (rdp1_tDC_p2 == 1'b1) && (last_access_type_p1 == `READ)) begin
                 if (TmsgOn && !p3_1 && !p2_1) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port1:", $realtime);
                 if (TmsgOn && !p3_1 && !p2_1) $display("\t\t\t        Data Output is unpredictable");
                 rdp1_violation_p1 = 1'b1;
                 corruptp4_w1 = 1'b0;
                 p4_1 = 1'b1;
                 p4_1_w = 1'b0;                 
              end else begin
                 corruptp4_w1 = 1'b0;
                 p4_1 = 1'b0;
                 p4_1_w = 1'b0;                 
              end
              if (((last_addr_p2 == cntp4_reg_p1) && wrp2_flag_p2) && (last_access_type_p2 == `WRITE)) begin
                 if (TmsgOn && !p2_4_w && !p1_4_w && !p3_4_w && !p4_3_w && !p4_1_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port4: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp4_reg_p1);
                 if (TmsgOn && !p2_4_w && !p1_2_w && !p2_1_w && !p2_3_w && !p3_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port2: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp4_reg_p1);
                 corruptp4_w2 = 1'b1;
                 p4_2 = 1'b0;
                 p4_2_w = 1'b1;                 
              end else if ((last_addr_p2 == cntp4_reg_p1) && (rdp2_tDC_p2 == 1'b1) && (last_access_type_p2 == `READ)) begin
                 if (TmsgOn && !p3_2 && !p1_2) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port2:", $realtime);
                 if (TmsgOn && !p3_2 && !p1_2) $display("\t\t\t        Data Output is unpredictable");
                 rdp2_violation_p1 = 1'b1;
                 corruptp4_w2 = 1'b0;
                 p4_2 = 1'b1;
                 p4_2_w = 1'b0;                 
              end else begin
                 corruptp4_w2 = 1'b0;
                 p4_2 = 1'b0;
                 p4_2_w = 1'b0;                 
              end
              if (((last_addr_p3 == cntp4_reg_p1) && wrp3_flag_p2) && (last_access_type_p3 == `WRITE)) begin
                 if (TmsgOn && !p3_4_w && !p1_4_w && !p2_4_w && !p4_2_w && !p4_1_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port4: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp4_reg_p1);
                 if (TmsgOn && !p3_4_w && !p1_3_w && !p2_3_w && !p3_1_w && !p3_2_w) $display("%t \t Model ERROR := Overlapping of writes occured while Writing to the same memory location from Port3: \n\t\t\t        Data is corrupted at address %h ", $realtime,cntp4_reg_p1);
                 corruptp4_w3 = 1'b1;
                 p4_3 = 1'b0;
                 p4_3_w = 1'b1;                 
              end else if ((last_addr_p3 == cntp4_reg_p1) && (rdp3_tDC_p2 == 1'b1) && (last_access_type_p3 == `READ)) begin
                 if (TmsgOn && !p2_3 && !p1_3) $display("%t \t Model ERROR := Violating tCCS while Reading the same memory location from Port3:", $realtime);
                 if (TmsgOn && !p2_3 && !p1_3) $display("\t\t\t        Data Output is unpredictable");
                 rdp3_violation_p1 = 1'b1;
                 corruptp4_w3 = 1'b0;
                 p4_3 = 1'b1;
                 p4_3_w = 1'b0;                 
              end else begin 
                 corruptp4_w3 = 1'b0;
                 p4_3 = 1'b0;
                 p4_3_w = 1'b0;                 
              end
              if(corruptp4_w1 || corruptp4_w2 || corruptp4_w3)begin
                 write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
              end else begin
                 if(dqp4_w2 === `DT_S'hz)begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hx;
                    if (DmsgOn) $display("\t\t\t        Data written at address %h is %h ", cntp4_reg_p1,'hX);
                 end else begin
                    write_data_and_tCCS_chk_fn[`DT_M:0] = dqp4_w2;
                 end
              end   
              last_access_type_p4 = `WRITE;                             
              tCCS_chk_w4 = $realtime;
           end
         endcase // case(port)
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
         mrst_n_event      = 0;
         doff_np1_pos_event    = 0;//ver 3.0 PAL
         doff_np2_pos_event    = 0;//ver 3.0 PAL
         doff_np3_pos_event    = 0;//ver 3.0 PAL
         doff_np4_pos_event    = 0;//ver 3.0 PAL
         doff_event_p1     = 0;//ver 3.0 PAL
         doff_event_p2     = 0;//ver 3.0 PAL
         doff_event_p3     = 0;//ver 3.0 PAL
         doff_event_p4     = 0;//ver 3.0 PAL
         wrp0_nnp1_event   = 0;
         wrp0_nnp2_event   = 0;
         wrp0_nnp3_event   = 0;
         wrp0_nnp4_event   = 0;
         cntrst_np3_event  = 0;
         cntrst_np4_event  = 0;
         cntrst_np1_event  = 0;
         cntrst_np2_event  = 0;
         mkld_np1_event    = 0;
         mkld_np2_event    = 0;
         mkld_np3_event    = 0;
         mkld_np4_event    = 0;
         cntld_np1_event   = 0;
         cntld_np2_event   = 0;
         cntld_np3_event   = 0;
         cntld_np4_event   = 0;
         retx_np1_event    = 0;
         retx_np2_event    = 0;
         retx_np3_event    = 0;
         retx_np4_event    = 0;
         cntinc_np3_event  = 0;
         cntinc_np4_event  = 0;
         cntinc_np1_event  = 0;
         cntinc_np2_event  = 0;
         cntrd_np3_event   = 0;
         cntrd_np4_event   = 0;
         cntrd_np1_event   = 0;
         cntrd_np2_event   = 0;
         mkrd_np3_event    = 0;
         mkrd_np4_event    = 0;
         mkrd_np1_event    = 0;
         mkrd_np2_event    = 0;
         dqp1_event        = 0;
         dqp2_event        = 0;
         dqp3_event        = 0;
         dqp4_event        = 0;
         clkp1_event       = 0;
         clkp2_event       = 0;
         clkp3_event       = 0;
         clkp4_event       = 0;
         ap1_event         = 0;
         ap2_event         = 0;
         ap3_event         = 0;
         ap4_event         = 0;
         ce0_np1_event     = 0;
         ce0_np2_event     = 0;
         ce0_np3_event     = 0;
         ce0_np4_event     = 0;
         ce1p1_event       = 0;
         ce1p2_event       = 0;
         ce1p3_event       = 0;
         ce1p4_event       = 0;
         oe_np3_event      = 0;
         oe_np4_event      = 0;
         oe_np1_event      = 0;
         oe_np2_event      = 0;
         r_w_np3_event     = 0;
         r_w_np4_event     = 0;
         r_w_np1_event     = 0;
         r_w_np2_event     = 0;
         b_np3_event       = 4'b0000;
         b_np4_event       = 4'b0000;
         b_np1_event       = 4'b0000;
         b_np2_event       = 4'b0000;
         // internal pins 
         oep3_int_event    = 0;
         oep4_int_event    = 0;
         oep1_int_event    = 0;
         oep2_int_event    = 0;
         tOEp3_int_event   = 0;
         tOEp4_int_event   = 0;         
         tOEp1_int_event   = 0;
         tOEp2_int_event   = 0;         
      end
endtask // event_reset
//-----------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        event_chk
//
// Description: Checks whether the event has occurred or not on all the input pins
//
//-----------------------------------------------------------------------------------------------
task event_chk;
      begin
         mrst_n_event      = (mrst_n_pv !== mrst_n);

         doff_np1_pos_event    = (doff_np1_event_pv !== doff_np1_event);//ver 3.0 PAL
         doff_np2_pos_event    = (doff_np2_event_pv !== doff_np2_event);//ver 3.0 PAL
         doff_np3_pos_event    = (doff_np3_event_pv !== doff_np3_event);//ver 3.0 PAL
         doff_np4_pos_event    = (doff_np4_event_pv !== doff_np4_event);//ver 3.0 PAL

         doff_event_p1    = (doff_p1_pv !== doff_np1);//ver 3.0 PAL
         doff_event_p2    = (doff_p2_pv !== doff_np2);//ver 3.0 PAL
         doff_event_p3    = (doff_p3_pv !== doff_np3);//ver 3.0 PAL
         doff_event_p4    = (doff_p4_pv !== doff_np4);//ver 3.0 PAL
         
         wrp0_nnp1_event   = (wrp0_np1_pv !== wrp0_np1);
         wrp0_nnp2_event   = (wrp0_np2_pv !== wrp0_np2);
         wrp0_nnp3_event   = (wrp0_np3_pv !== wrp0_np3);
         wrp0_nnp4_event   = (wrp0_np4_pv !== wrp0_np4);
         
         mkld_np1_event    = (mk_ldp1_pv !== mkld_np1);
         mkld_np2_event    = (mk_ldp2_pv !== mkld_np2);
         mkld_np3_event    = (mk_ldp3_pv !== mkld_np3);
         mkld_np4_event    = (mk_ldp4_pv !== mkld_np4);
         cntld_np1_event   = (cntld_np1_pv !== cntld_np1);
         cntld_np2_event   = (cntld_np2_pv !== cntld_np2);
         cntld_np3_event   = (cntld_np3_pv !== cntld_np3);
         cntld_np4_event   = (cntld_np4_pv !== cntld_np4);
         retx_np1_event    = (retx_np1_pv !== retx_np1);
         retx_np2_event    = (retx_np2_pv !== retx_np2);
         retx_np3_event    = (retx_np3_pv !== retx_np3);
         retx_np4_event    = (retx_np4_pv !== retx_np4);
         cntinc_np1_event  = (cntinc_np1_pv !== cntinc_np1);
         cntinc_np2_event  = (cntinc_np2_pv !== cntinc_np2);
         cntinc_np3_event  = (cntinc_np3_pv !== cntinc_np3);
         cntinc_np4_event  = (cntinc_np4_pv !== cntinc_np4);
         cntrd_np1_event   = (cntrd_np1_pv !== cntrd_np1);
         cntrd_np2_event   = (cntrd_np2_pv !== cntrd_np2);
         cntrd_np3_event   = (cntrd_np3_pv !== cntrd_np3);
         cntrd_np4_event   = (cntrd_np4_pv !== cntrd_np4);
         mkrd_np1_event    = (mkrd_np1_pv !== mkrd_np1);
         mkrd_np2_event    = (mkrd_np2_pv !== mkrd_np2);
         mkrd_np3_event    = (mkrd_np3_pv !== mkrd_np3);
         mkrd_np4_event    = (mkrd_np4_pv !== mkrd_np4);
         dqp1_event        = (dqp1_pv !== dqp1);
         dqp2_event        = (dqp2_pv !== dqp2);
         dqp3_event        = (dqp3_pv !== dqp3);
         dqp4_event        = (dqp4_pv !== dqp4);
         clkp1_event       = (clkp1_pv !== cpp1);
         clkp2_event       = (clkp2_pv !== cpp2);
         clkp3_event       = (clkp3_pv !== cpp3);
         clkp4_event       = (clkp4_pv !== cpp4);
         ap1_event         = (ap1_pv !== ap1);
         ap2_event         = (ap2_pv !== ap2);
         ap3_event         = (ap3_pv !== ap3);
         ap4_event         = (ap4_pv !== ap4);
         ce0_np1_event     = (ce0_np1_pv !== ce0_np1);
         ce0_np2_event     = (ce0_np2_pv !== ce0_np2);
         ce0_np3_event     = (ce0_np3_pv !== ce0_np3);
         ce0_np4_event     = (ce0_np4_pv !== ce0_np4);
         ce1p1_event       = (ce1p1_pv !== ce1p1);
         ce1p2_event       = (ce1p2_pv !== ce1p2);
         ce1p3_event       = (ce1p3_pv !== ce1p3);
         ce1p4_event       = (ce1p4_pv !== ce1p4);
         cntrst_np1_event  = (cntrst_np1_pv !== cntrst_np1);
         cntrst_np2_event  = (cntrst_np2_pv !== cntrst_np2);
         cntrst_np3_event  = (cntrst_np3_pv !== cntrst_np3);
         cntrst_np4_event  = (cntrst_np4_pv !== cntrst_np4);
         oe_np1_event      = (oe_np1_pv !== oe_np1);
         oe_np2_event      = (oe_np2_pv !== oe_np2);
         oe_np3_event      = (oe_np3_pv !== oe_np3);
         oe_np4_event      = (oe_np4_pv !== oe_np4);
         r_w_np1_event     = (r_w_np1_pv !== r_w_np1);
         r_w_np2_event     = (r_w_np2_pv !== r_w_np2);
         r_w_np3_event     = (r_w_np3_pv !== r_w_np3);
         r_w_np4_event     = (r_w_np4_pv !== r_w_np4);
         b_np1_event       = (b_np1_pv !== b_np1);
         b_np2_event       = (b_np2_pv !== b_np2);
         b_np3_event       = (b_np3_pv !== b_np3);
         b_np4_event       = (b_np4_pv !== b_np4);
         // internal pins 
         oep1_int_event    = (oep1_int_pv !== oep1_int);
         oep2_int_event    = (oep2_int_pv !== oep2_int);
         oep3_int_event    = (oep3_int_pv !== oep3_int);
         oep4_int_event    = (oep4_int_pv !== oep4_int);
         tOEp1_int_event   = (tOEp1_int_pv !== tOEp1_int);
         tOEp2_int_event   = (tOEp2_int_pv !== tOEp2_int);                  
         tOEp3_int_event   = (tOEp3_int_pv !== tOEp3_int);
         tOEp4_int_event   = (tOEp4_int_pv !== tOEp4_int);                  
      end
endtask // event_chk

//-----------------------------------------------------------------------------------------------
