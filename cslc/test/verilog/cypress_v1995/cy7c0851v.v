//------------------------------------------------------------------------------
//
//     This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Spike technologies Inc.
//     In the event of publication, the following notice is applicable:
//
//                (C) COPYRIGHT 2001 SPIKE TECHNOLOGIES INC.
//                          ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies.
//
// File         : cy7c0851v.v
//
// Author       : Chandrakant Umate
//
// Date         : Sep 03 '01
//
// Version      : 1.0
//
// Abstract     : This is a Verilog Behavioral timing model for
//                Cypress cy7c0851v, 64 K x 36 Synchronous Dual Port RAM.
//
// Notes        : First Release
//
// Datasheet    : Cypress cy7c0851v, 3.3V 64K x 36 Synchronous Dual Port RAM,
//                (January 22, 2001)
//
// Modification History:
// Date         By       Version     Change Description
// ==========================================================================
// 03/09/2001  CZU       1.0         First Release
//
//
//
// ==========================================================================
//------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------
// module:      cy7c0851v
//
// Description: Top level module for cy7c0851v behavioral model
//              It contains following three files
//              1. cy7c0851v_Define_model.v - definitions
//              2. cy7c0851v_Timing_model.v - timing parameters
//              3. cy7c0851v_Task_model.v   - tasks and functions
//-----------------------------------------------------------------------------------------------


`timescale 1ns/10ps
`include "cy7c0851v_Define_model.v"

module cy7c0851v (al,        // Address input left
                 ar,         // Address input right
                 ads_nl,     // Address strobe input left
                 ads_nr,     // Address strobe input right
                 ce0_nl,     // Active low chip enable input left
                 ce0_nr,     // Active low chip enable input right
                 ce1l,       // Active high chip enable input left
                 ce1r,       // Active high chip enable input right
                 clkl,       // Clock input left
                 clkr,       // Clock input right
                 cnten_nl,   // Counter enable input left
                 cnten_nr,   // Counter enable input right
                 cntrst_nl,  // Counter reset input left
                 cntrst_nr,  // Counter reset input right
                 cnt_msk_nl, // Address counter mask register enable input left
                 cnt_msk_nr, // Address counter mask register enable input right
                 dql,        // Data bus input/output left
                 dqr,        // Data bus input/output right
                 oe_nl,      // Output enable input left
                 oe_nr,      // Output enable input right
                 int_nl,     // Mailbox interrupt flag output left
                 int_nr,     // Mailbox interrupt flag output right
                 cntint_nl,  // Counter interrupt output left
                 cntint_nr,  // Counter interrupt output right
                 r_w_nl,     // Read/Write Enable input left
                 r_w_nr,     // Read/Write Enable input right
                 b_nl,       // Byte select inputs left
                 b_nr,       // Byte select inputs right
                 mrst_n      // Master reset input
                 );

   inout [`AD_M :0] al, ar;     // Address inputs

   input                ads_nl,
                        ads_nr,       // Address strobe inputs
                        ce0_nl,
                        ce0_nr,
                        ce1l,       // Active high chip enable input left
                        ce1r,       // Active high chip enable input right
                        clkl,       // Clock input left
                        clkr,       // Clock input right
                        cnten_nl,   // Counter enable input left
                        cnten_nr,   // Counter enable input right
                        cntrst_nl,  // Counter reset input left
                        cntrst_nr,  // Counter reset input right
                        cnt_msk_nl, // Address counter mask register enable input left
                        cnt_msk_nr; // Address counter mask register enable input right

   inout [`DT_M :0]     dql,        // Data bus input/output left
                        dqr;        // Data bus input/output right

   input                oe_nl,      // Output enable input left
                        oe_nr;      // Output enable input right

   output               int_nl,     // Mailbox interrupt flag output left
                        int_nr,     // Mailbox interrupt flag output right
                        cntint_nl,  // Counter interrupt output left
                        cntint_nr;  // Counter interrupt output right

   input                r_w_nl,     // Read/Write Enable input left
                        r_w_nr;     // Read/Write Enable input right

   input [`BT_M : 0]    b_nl,       // Byte select inputs left
                        b_nr;       // Byte select inputs right

   input                mrst_n;     // Master reset input

   //====================================================================================================

   // variables
   integer              rsp_fv;

   reg [`DT_M : 0]      mem[0 : `LAST_ADR]; // define memory array size

   reg [`AD_M : 0]      cntl_reg,
                        cntr_reg,
                        mskl_reg,
                        mskr_reg;

   reg [`BT_M : 0]      rdl_en_p1,     // Indicates current operation
                        rdr_en_p1,
                        rdl_en_p2,
                        rdr_en_p2;

   reg                  rdl_tDC_p1,
                        rdr_tDC_p1,
                        rdl_tDC_p2,
                        rdr_tDC_p2,
                        rdl_tDC_p3,
                        rdr_tDC_p3;

   reg [`DT_M : 0]      dql_p1,
                        dql_p2,
                        dqr_p1,
                        dqr_p2;

   reg                  mskl_rd_en_p1,
                        mskl_rd_en_p2,
                        mskr_rd_en_p1,
                        mskr_rd_en_p2;

   reg                  cntl_rd_en_p1,
                        cntl_rd_en_p2,
                        cntr_rd_en_p1,
                        cntr_rd_en_p2;

   reg [`AD_M : 0]      mskl_rdbk_p1,
                        mskl_rdbk_p2,
                        mskr_rdbk_p1,
                        mskr_rdbk_p2;

   reg [`AD_M : 0]      cntl_rdbk_p1,
                        cntl_rdbk_p2,
                        cntr_rdbk_p1,
                        cntr_rdbk_p2;

   reg                  cntintl_en_p1,
                        cntintr_en_p1;

   reg                  mirrorl_loaded_en,
                        mirrorr_loaded_en;

   integer              mskpartl_bit_no,
                        mskpartr_bit_no;

   reg [3:0]            opernl_type,
                        opernr_type;

   reg [`AD_M : 0]      mirrorl_reg,
                        mirrorr_reg;

   reg [2:0]            debug;
   reg                  OmsgOn,
                        XmsgOn,
                        TmsgOn;

   reg                  setup_hold_chk;

   reg                  tRS_f;
   reg                  reset_over;

   reg                  oel_int,   // internal pin for oe low to high transition
                        oer_int,   // internal pin for oe low to high transition
                        tOEl_int,  // internal pin for to avoid old data out by oe low in read operation
                        tOEr_int;  // internal pin for to avoid old data out by oe low in read operation


   reg                  last_opernl_p1,
                        last_opernl_p2,
                        last_opernl_p3,
                        last_opernr_p1,
                        last_opernr_p2,
                        last_opernr_p3;

   reg                  last_access_type;

   reg [`AD_M : 0]      last_addr;
   reg [`AD_M : 0]      tempA_reg1;
   
   reg [`DT_M : 0]      tempD_reg1,
                        tempD_reg2;

   reg                  no_use;

   // Registers for Output ports
   reg [`AD_M :0]       al_r,
                        ar_r;

   reg [`DT_M :0]       dql_r,
                        dqr_r;

   reg                  int_nl,
                        int_nr,
                        cntint_nl,
                        cntint_nr;

   // Timing violation check variables
   realtime             tRS_chk;
   realtime             tCCS_chk;
   realtime             tOEl_over_chk,          tOEr_over_chk;
   realtime             oel_pulse_chk,          oer_pulse_chk;

   realtime             rising_edge_clk_l,      rising_edge_clk_r;
   realtime             falling_edge_clk_l,     falling_edge_clk_r;

   realtime             addr_last_change_l,     addr_last_change_r;
   realtime             byte_sel_last_change_l, byte_sel_last_change_r;
   realtime             ce0_last_change_l,      ce0_last_change_r;
   realtime             ce1_last_change_l,      ce1_last_change_r;
   realtime             rw_last_change_l,       rw_last_change_r;
   realtime             dq_last_change_l,       dq_last_change_r;
   realtime             ads_sel_last_change_l,  ads_sel_last_change_r;
   realtime             cnten_last_change_l,    cnten_last_change_r;
   realtime             cntrst_last_change_l,   cntrst_last_change_r;
   realtime             cnt_msk_last_change_l,  cnt_msk_last_change_r;
   realtime             rising_edge_mrst,       falling_edge_mrst;


   reg                  dql_event, dqr_event,
                        clkl_event, clkr_event,
                        mrst_n_event,
                        al_event, ar_event,
                        ads_nl_event, ads_nr_event,
                        ce0_nl_event, ce0_nr_event,
                        ce1l_event, ce1r_event,
                        cnten_nl_event, cnten_nr_event,
                        cntrst_nl_event, cntrst_nr_event,
                        cnt_msk_nl_event, cnt_msk_nr_event,
                        oe_nl_event, oe_nr_event,
                        r_w_nl_event, r_w_nr_event,
                        b_nl_event, b_nr_event;

   reg                  oel_int_event,
                        oer_int_event,
                        tOEl_int_event,
                        tOEr_int_event;

   reg                  mrst_n_pv;
   reg [`DT_M:0]        dql_pv, dqr_pv;
   reg                  clkl_pv, clkr_pv;
   reg [`AD_M:0]        al_pv, ar_pv;
   reg                  ads_nl_pv, ads_nr_pv;
   reg                  ce0_nl_pv, ce0_nr_pv;
   reg                  ce1l_pv, ce1r_pv;
   reg                  cnten_nl_pv, cnten_nr_pv;
   reg                  cntrst_nl_pv, cntrst_nr_pv;
   reg                  cnt_msk_nl_pv, cnt_msk_nr_pv;
   reg                  oe_nl_pv, oe_nr_pv;
   reg                  r_w_nl_pv, r_w_nr_pv;
   reg [`BT_M:0]        b_nl_pv, b_nr_pv;

   reg                  oel_int_pv,
                        oer_int_pv,
                        tOEl_int_pv,
                        tOEr_int_pv;

   integer              i;
   integer              j;
   integer              bit_no;
   reg                  valid_msk_f;
   reg                  temp_f;

   reg                  mailintl_en,
                        mailintr_en;

   reg                  cnthldl_en_p1,
                        cnthldl_en_p2,
                        cnthldr_en_p1,
                        cnthldr_en_p2;

   reg                  tOHZ_overl_f,
                        tOHZ_overr_f;

`include "cy7c0851v_Timing_model.v"
`include "cy7c0851v_Task_model.v"

   //====================================================================================================

   assign               dql = dql_r;
   assign               dqr = dqr_r;
   assign               al = al_r;
   assign               ar = ar_r;

   initial begin
      : INIT
      $timeformat (-9, 1, " ns", 12);
      $readmemh("../test/dpram_array.txt", mem);

      tOHZ_overl_f = 1'b0;
      tOHZ_overr_f = 1'b0;
      
      cntl_reg = `AD_S'h0000;
      cntr_reg = `AD_S'h0000;
      mskl_reg = `UNMASK_ALL;
      mskr_reg = `UNMASK_ALL;

      rdl_en_p1 = `BT_S'h0;
      rdr_en_p1 = `BT_S'h0;
      rdl_en_p2 = `BT_S'h0;
      rdr_en_p2 = `BT_S'h0;

      rdl_tDC_p1 = 1'b0;
      rdr_tDC_p1 = 1'b0;
      rdl_tDC_p2 = 1'b0;
      rdr_tDC_p2 = 1'b0;
      rdl_tDC_p3 = 1'b0;
      rdr_tDC_p3 = 1'b0;

      dql_p1 = `DT_S'h0;
      dqr_p1 = `DT_S'h0;
      dql_p2 = `DT_S'h0;
      dqr_p2 = `DT_S'h0;

      mskl_rd_en_p1 = 1'b0;
      mskl_rd_en_p2 = 1'b0;
      mskr_rd_en_p1 = 1'b0;
      mskr_rd_en_p2 = 1'b0;

      cntl_rd_en_p1 = 1'b0;
      cntl_rd_en_p2 = 1'b0;
      cntr_rd_en_p1 = 1'b0;
      cntr_rd_en_p2 = 1'b0;

      mskl_rdbk_p1 = `AD_S'b0;
      mskl_rdbk_p2 = `AD_S'b0;
      mskr_rdbk_p1 = `AD_S'b0;
      mskr_rdbk_p2 = `AD_S'b0;

      cntl_rdbk_p1 = `AD_S'b0;
      cntl_rdbk_p2 = `AD_S'b0;
      cntr_rdbk_p1 = `AD_S'b0;
      cntr_rdbk_p2 = `AD_S'b0;

      cntintl_en_p1 = 1'b0;
      cntintr_en_p1 = 1'b0;

      mirrorl_loaded_en = 1'b0;
      mirrorr_loaded_en = 1'b0;

      mskpartl_bit_no = `AD_M;
      mskpartr_bit_no = `AD_M;

      opernl_type = `NONE;
      opernr_type = `NONE;

      mirrorl_reg = `AD_S'h0;
      mirrorr_reg = `AD_S'h0;

      debug = 3'b110;
      TmsgOn = debug[2];
      XmsgOn = debug[1];
      OmsgOn = debug[0];

      setup_hold_chk = 0;

      tRS_f = `STOP;
      reset_over = 0;

      oel_int = 0;
      oer_int = 0;
      tOEl_int = 0;
      tOEr_int = 0;

      last_opernl_p1 = 1'bx;   // x defines no read or write operation
      last_opernl_p2 = 1'bx;
      last_opernl_p3 = 1'bx;
      last_opernr_p1 = 1'bx;
      last_opernr_p2 = 1'bx;
      last_opernr_p3 = 1'bx;

      last_access_type = `READ;

      last_addr = `AD_S'hx; // X can't be previous valid address.
      tempA_reg1 = `AD_S'h0;
      tempD_reg1 = `DT_S'h0;
      tempD_reg2 = `DT_S'h0;

      al_r = `AD_S'h0;
      ar_r = `AD_S'h0;
      dql_r = `DT_S'h0;
      dqr_r = `DT_S'h0;

      int_nl = 1;
      int_nr = 1;
      cntint_nl = 1;
      cntint_nr = 1;

      tRS_chk = 0;
      tCCS_chk = 0;
      oel_pulse_chk = 0;
      oer_pulse_chk = 0;
      tOEl_over_chk = 0;
      tOEr_over_chk = 0;

      i = 0;
      j = 0;
      bit_no = 0;
      valid_msk_f = 1;

      mailintl_en = 0;
      mailintr_en = 0;

      cnthldl_en_p1 = 0;
      cnthldl_en_p2 = 0;
      cnthldr_en_p1 = 0;
      cnthldr_en_p2 = 0;

      event_reset;
      pv_reset;

      //create a response file. using a c-shell script compare this file against gold file//
      rsp_fv = $fopen("cy7c0851v.rsp");

      $fdisplay(rsp_fv, "\t                Cypress cy7c0851v Memory Model Tests Response                                              ");
      $fdisplay(rsp_fv, "\t-----------------------------------------------------------------------------------------------------------");
      $fdisplay(rsp_fv, "\tTIME       M C C C ADDR_L A  B   R O   DATA_L   C C C C I | C C C ADDR_R A  B   R O   DATA_R   C C C C I   ");
      $fdisplay(rsp_fv, "\t           R L E E        D  Y   / E            N N N N N | L E E        D  Y   / E            N N N N N   ");
      $fdisplay(rsp_fv, "\t           S K 0 1        S  T   W |            T T T T T | K 0 1        S  T   W |            T T T T T   ");
      $fdisplay(rsp_fv, "\t           T L | |        L  E   | N            R E | I | | R | |        R  E   | N            R E | I |   ");
      $fdisplay(rsp_fv, "\t           |   N L           |   N L            S N M N N |   N R           |   N R            S N M N N   ");
      $fdisplay(rsp_fv, "\t           N   L             L   L              T | S T L |   R             R   R              T | S T R   ");
      $fdisplay(rsp_fv, "\t                                                | L K |   |                                    | R K |     ");
      $fdisplay(rsp_fv, "\t                                                N   | N   |                                    N   | N     ");
      $fdisplay(rsp_fv, "\t                                                L   N L   |                                    R   N R     ");
      $fdisplay(rsp_fv, "\t                                                    L     |                                        R       ");
      $fdisplay(rsp_fv, "\t----------------------------------------------------------|------------------------------------------------");

      //strobe essential
      $fmonitor(rsp_fv, "%t : %b %b %b %b %h  %b %b %b %b %h  %b %b %b %b %b | %b %b %b %h  %b %b %b %b %h  %b %b %b %b %b", $realtime, mrst_n, clkl, ce0_nl, ce1l, al, ads_nl, b_nl, r_w_nl, oe_nl, dql, cntrst_nl, cnten_nl, cnt_msk_nl, cntint_nl, int_nl, clkr, ce0_nr, ce1r, ar, ads_nr, b_nr, r_w_nr, oe_nr, dqr, cntrst_nr, cnten_nr, cnt_msk_nr, cntint_nr, int_nr);

   end

   always @(mrst_n or clkl or clkr or al or ar or ads_nl or ads_nr or ce0_nl or ce0_nr or ce1l or ce1r or clkl or clkr or cnten_nl or cnten_nr or cntrst_nl or cntrst_nr or cnt_msk_nl or cnt_msk_nr or oe_nl or oe_nr or r_w_nl or r_w_nr or b_nl or b_nr or oel_int or oer_int or tOEl_int or tOEr_int or dql or dqr) begin

      event_chk;
      timing_chk;

      if ((mrst_n_event) && (mrst_n === 0)) begin
         if (OmsgOn) $display("%t Reseting the Device", $realtime);

         // -- Register and counters
         if ($realtime > 0) setup_hold_chk = 0;

         tOHZ_overl_f = 1'b0;  
         tOHZ_overr_f = 1'b0;  
         
         cntl_reg = `AD_S'h0000;
         cntr_reg = `AD_S'h0000;
         mskl_reg = `UNMASK_ALL;
         mskr_reg = `UNMASK_ALL;

         rdl_en_p1 = `BT_S'h0;
         rdr_en_p1 = `BT_S'h0;
         rdl_en_p2 = `BT_S'h0;
         rdr_en_p2 = `BT_S'h0;

         rdl_tDC_p1 = 1'b0;
         rdr_tDC_p1 = 1'b0;
         rdl_tDC_p2 = 1'b0;
         rdr_tDC_p2 = 1'b0;
         rdl_tDC_p3 = 1'b0;
         rdr_tDC_p3 = 1'b0;

         dql_p1 = `DT_S'h0;
         dqr_p1 = `DT_S'h0;
         dql_p2 = `DT_S'h0;
         dqr_p2 = `DT_S'h0;

         mskl_rd_en_p1 = 1'b0;
         mskl_rd_en_p2 = 1'b0;
         mskr_rd_en_p1 = 1'b0;
         mskr_rd_en_p2 = 1'b0;

         cntl_rd_en_p1 = 1'b0;
         cntl_rd_en_p2 = 1'b0;
         cntr_rd_en_p1 = 1'b0;
         cntr_rd_en_p2 = 1'b0;

         mskl_rdbk_p1 = `AD_S'b0;
         mskl_rdbk_p2 = `AD_S'b0;
         mskr_rdbk_p1 = `AD_S'b0;
         mskr_rdbk_p2 = `AD_S'b0;

         cntl_rdbk_p1 = `AD_S'b0;
         cntl_rdbk_p2 = `AD_S'b0;
         cntr_rdbk_p1 = `AD_S'b0;
         cntr_rdbk_p2 = `AD_S'b0;

         cntintl_en_p1 = 1'b0;
         cntintr_en_p1 = 1'b0;

         mirrorl_loaded_en = 1'b0;
         mirrorr_loaded_en = 1'b0;

         mskpartl_bit_no = `AD_M;
         mskpartr_bit_no = `AD_M;

         opernl_type = `NONE;
         opernr_type = `NONE;

         mirrorl_reg = `AD_S'h0;
         mirrorr_reg = `AD_S'h0;

         tRS_f = `START;
         reset_over = 0;

         oel_int = 0;
         oer_int = 0;
         tOEl_int = 0;
         tOEr_int = 0;

         last_opernl_p1 = 1'bx;   // x defines no read or write operation
         last_opernl_p2 = 1'bx;
         last_opernl_p3 = 1'bx;
         last_opernr_p1 = 1'bx;
         last_opernr_p2 = 1'bx;
         last_opernr_p3 = 1'bx;

         last_access_type = `READ;

         last_addr = `AD_S'hx; // X can't be previous valid address.
         tempA_reg1 = `AD_S'h0;
         tempD_reg1 = `DT_S'h0;
         tempD_reg2 = `DT_S'h0;

         // -- addr and data outputs
         al_r <= #tRSF `AD_S'hZ;
         ar_r <= #tRSF `AD_S'hZ;
         dql_r <= #tRSF `DT_S'hZ;
         dqr_r <= #tRSF `DT_S'hZ;

         // -- Interrupt flags
         int_nl <= #tRScntint 1'b1;
         int_nr <= #tRScntint 1'b1;
         cntint_nl <= #tRScntint 1'b1;
         cntint_nr <= #tRScntint 1'b1;

         tRS_chk = $realtime;
         tCCS_chk = $realtime;
         oel_pulse_chk = $realtime;
         oer_pulse_chk = $realtime;
         tOEl_over_chk = $realtime;
         tOEr_over_chk = $realtime;

         i = 0;
         j = 0;
         bit_no = 0;
         valid_msk_f = 1;

         mailintl_en = 0;
         mailintr_en = 0;

         cnthldl_en_p1 = 0;
         cnthldl_en_p2 = 0;
         cnthldr_en_p1 = 0;
         cnthldr_en_p2 = 0;

      end else if ((mrst_n_event) && (mrst_n === 1)) begin

         if (OmsgOn) $display("%t Reset operation over", $realtime);
         if (tRS_f == `START) begin
            if ($realtime - tRS_chk < tRS) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset Pulse Width - tRS violation during Master Reset", $realtime);
            end
            tRS_f = `STOP;
            reset_over = 1;
            if ($realtime > 0) setup_hold_chk <= #tRSR 1;
         end

      end else if ((!mrst_n_event) && (mrst_n === 1)) begin

         //==========================================================================================
         // LEFT PORT

         if ((clkl_event) && (clkl === 1)) begin // Left Port clock Active
            
            mirrorl_loaded_en = 1'b0;
            if (cntintl_en_p1 == 1'b1) begin
               cntl_reg = mirrorl_reg;           // load mirror reg into counter reg after reaching max value
               mirrorl_loaded_en = 1'b1;             // Don't increment cnt on the same edge of clk
            end
            cntintl_en_p1 = 1'b0;

            dql_p2 = dql_p1;       // pipeline data
            rdl_en_p2 = rdl_en_p1; // pipeline read enable signal
            rdl_tDC_p3 = rdl_tDC_p2; // pipeline of control signal for tDC
            rdl_tDC_p2 = rdl_tDC_p1; // pipeline of control signal for tDC

            mskl_rd_en_p2 = mskl_rd_en_p1;
            mskl_rd_en_p1 = 1'b0;
            mskl_rdbk_p2 = mskl_rdbk_p1;
            mskl_rdbk_p1 = `AD_S'h0;

            cntl_rd_en_p2 = cntl_rd_en_p1;
            cntl_rd_en_p1 = 1'b0;
            cntl_rdbk_p2 = cntl_rdbk_p1;
            cntl_rdbk_p1 = `AD_S'h0;

            cnthldl_en_p2 = cnthldl_en_p1;
            cnthldl_en_p1 = 1'b0;
            tOEl_over_chk = $realtime;
            last_opernl_p3 = last_opernl_p2;
            last_opernl_p2 = last_opernl_p1;
            last_opernl_p1 = 1'bx;

            case ({cnt_msk_nl, cntrst_nl})

              2'b00: begin // Mask Reset
                 if (OmsgOn) $display("%t Reseting the Mask Register for Left port to all 1s", $realtime);
                 mskl_reg = `UNMASK_ALL;
                 mskpartl_bit_no = `AD_M;
              end

              2'b01: begin // Mask register functions
                 case ({ads_nl, cnten_nl})
                   2'b00: begin // Mask Load
                      mskl_reg = chk_and_load_msk_fn(`LEFT);
                      cnthldl_en_p1 = 1'b1;
                      opernl_type = `MASKLD;
                   end

                   2'b01: begin // Mask Readback
                      if (OmsgOn) $display("%t Mask Readback operation", $realtime);
                      mskl_rd_en_p1 = 1'b1;
                      mskl_rdbk_p1 = mskl_reg;
                      rdl_en_p1 = `BT_S'h0;   // for msk read operation dq goes High-Z in the next clk cycle
                      rdl_tDC_p1 = 1'b0;   // No read operation will be performed, so no holding of data reqd
                      opernl_type = `MASKRD;
                   end

                   2'b10: begin // Reserved
                      $display("%t Operation Undefined", $realtime);
                      cnthldl_en_p1 = 1'b1;
                      opernl_type = `NONE;
                   end

                   2'b11: begin // Reserved
                      $display("%t Operation Undefined", $realtime);
                      cnthldl_en_p1 = 1'b1;
                      opernl_type = `NONE;
                   end

                   default: begin
                      cnthldl_en_p1 = 1'b1;
                      opernl_type = `NONE;
                      no_use = chk_x_ads("ads_nl", ads_nl);
                      no_use = chk_x_cnten("cnten_nl", cnten_nl);
                   end
                 endcase // case({ads_nl, cnten_nl})
              end

              2'b10: begin // Counter Reset
                 if (OmsgOn) $display("%t Reseting Counter at Left port", $realtime);
                 if (mskl_reg[0] == 1) begin // Reset only unmasked region
                    cntl_reg[0] = 1'b0;
                 end
                 for (i=1; i<= mskpartl_bit_no; i=i+1) begin  // Reset only unmasked region
                    cntl_reg[i] = 1'b0;
                 end
                 opernl_type = `CNTRST;
              end

              2'b11: begin // Counter functions
                 case ({ads_nl, cnten_nl})
                   2'b00: begin // Counter Load
                      if (chk_x_a("al", al)) begin
                         opernl_type = `NONE;
                      end else begin
                         if (OmsgOn) $display("%t Loading Address Counter at Left port", $realtime);
                         cntl_reg = al;
                         mirrorl_reg = al;
                         opernl_type = `CNTLD;
                      end
                   end

                   2'b01: begin // Counter Readback
                      if (OmsgOn) $display("%t Reading back the counter at Left port", $realtime);
                      cntl_rd_en_p1 = 1'b1;
                      cntl_rdbk_p1 = cntl_reg;
                      rdl_en_p1 = `BT_S'h0;   // for msk read operation dq goes High-Z in the next clk cycle
                      rdl_tDC_p1 = 1'b0;  // No read operation will be performed, so no holding of data reqd
                      opernl_type = `CNTRD;
                   end

                   2'b10: begin // Counter Increment
                      if (mirrorl_loaded_en == 1'b0) begin
                         // Increment unmasked region only
                         tempA_reg1 = cntl_reg;
                         if (mskl_reg[0] == 1) begin
                            tempA_reg1 = tempA_reg1 + 1;
                         end else begin
                            tempA_reg1 = tempA_reg1 + 2;
                         end
                         for (i = 0; i <= mskpartl_bit_no; i = i+1) begin
                            cntl_reg[i] = tempA_reg1[i];
                         end
                      end
                      //chk the wrapover of cnt register and interrupt
                      temp_f = 1'b1;
                      if (mskl_reg[0] == 1) begin
                         for (i = 0; i <= mskpartl_bit_no; i = i+1) begin
                            if (cntl_reg[i] != mskl_reg[i])   temp_f = 1'b0;
                         end
                      end else begin
                         for (i = 1; i <= mskpartl_bit_no; i = i+1) begin
                            if (cntl_reg[i] != mskl_reg[i])   temp_f = 1'b0;
                         end
                      end

                      if (temp_f == 1'b1)   cntintl_en_p1 = 1'b1;
                      opernl_type = `CNTINC;
                   end

                   2'b11: begin // Counter Hold
                      cnthldl_en_p1 = 1'b1;
                      opernl_type = `CNTHLD;
                   end

                   default: begin
                      cnthldl_en_p1 = 1'b1;
                      opernl_type = `NONE;
                      no_use = chk_x_ads("ads_nl", ads_nl);
                      no_use = chk_x_cnten("cnten_nl", cnten_nl);
                   end
                 endcase // case({ads_nl, cnten_nl})
              end
              default: begin
                 cnthldl_en_p1 = 1'b1;
                 opernl_type = `NONE;
                 no_use = chk_x_cnt_msk("cnt_msk_nl", cnt_msk_nl);
                 no_use = chk_x_cntrst("cntrst_nl", cntrst_nl);
              end
            endcase // case({cnt_msk_nl, cntrst_nl})

            if (!((opernl_type == `MASKRD) || (opernl_type == `CNTRD))) begin
               if ((ce0_nl === 0) && (ce1l === 1) && (r_w_nl === 1)) begin  // Read operation
                  if ((reset_chk_fn(no_use)) == 1) begin
                     case (b_nl)
                       
                       `BT_S'b1111: begin
                          if (OmsgOn) $display("%t Left Port No Byte Read Operation", $realtime);
                          rdl_en_p1 = ~b_nl;
                          rdl_tDC_p1 = 1'b0;
                       end
                       
                       `BT_S'b0000,`BT_S'b0001,`BT_S'b0010,`BT_S'b0011,
                         `BT_S'b0100,`BT_S'b0101,`BT_S'b0110,`BT_S'b0111,
                         `BT_S'b1000,`BT_S'b1001,`BT_S'b1010,`BT_S'b1011,
                         `BT_S'b1100,`BT_S'b1101,`BT_S'b1110 : begin
                            if (OmsgOn) $display("%t Left Port Read Operation", $realtime);
                            dql_p1 = read_data_and_tCCS_chk_fn(`LEFT);
                            rdl_en_p1 = ~b_nl;
                            rdl_tDC_p1 = 1'b1;
                            if (cntl_reg == `LAST_ADR-1)  mailintl_en = 1'b0;  // Mailbox interrupt Ack for left port
                         end
                       
                       default : begin
                          no_use = chk_x_b("b_nl", b_nl);
                          rdl_en_p1 = `BT_S'h0; // disable outputs
                          rdl_tDC_p1 = 1'b0;
                       end
                     endcase // case(b_nl)
                  end
               end else if ((ce0_nl === 0) && (ce1l === 1) && (r_w_nl === 0)) begin  // Write operation
                  if ((reset_chk_fn(no_use)) == 1) begin
                     rdl_en_p1 = `BT_S'h0;
                     rdl_en_p2 = `BT_S'h0; // for write operation dq goes High-Z at the same clk cycle
                     rdl_tDC_p1 = 1'b0;
                     rdl_tDC_p2 = 1'b0;
                     rdl_tDC_p3 = 1'b0;
                     
                     if ((chk_x_dq("dql", dql)) == 0) begin
                        case(b_nl)
                          
                          `BT_S'b0000,`BT_S'b0001,`BT_S'b0010,`BT_S'b0011,
                          `BT_S'b0100,`BT_S'b0101,`BT_S'b0110,`BT_S'b0111,
                          `BT_S'b1000,`BT_S'b1001,`BT_S'b1010,`BT_S'b1011,
                          `BT_S'b1100,`BT_S'b1101,`BT_S'b1110 : begin
                             
                             if (OmsgOn) $display("%t Left Port Write Operation", $realtime);
                             tempD_reg1 = mem[cntl_reg]; // get the previous data
                             tempD_reg2 = write_data_and_tCCS_chk_fn(`LEFT); // save the current data temporarily
                             if (b_nl[0] === 1'b0) begin
                                tempD_reg1[8:0] = tempD_reg2[8:0];
                             end
                             if (b_nl[1] === 1'b0) begin
                                tempD_reg1[17:9] = tempD_reg2[17:9];
                             end
                             if (b_nl[2] === 1'b0) begin
                                tempD_reg1[26:18] = tempD_reg2[26:18];
                             end
                             if (b_nl[3] === 1'b0) begin
                                tempD_reg1[35:27] = tempD_reg2[35:27];
                             end
                             mem[cntl_reg] = tempD_reg1;                     // write to memory
                             if (cntl_reg == `LAST_ADR)  mailintr_en = 1'b1; // Mailbox interrupt Generation for right port
                          end
                          
                          `BT_S'b1111: begin
                             if (OmsgOn) $display("%t Left Port No Byte Write Operation", $realtime);
                          end
                          default : begin
                             no_use = chk_x_b("b_nl", b_nl);
                          end
                        endcase // case(b_nl)
                     end
                  end
               end else if (!((ce0_nl === 0) && (ce1l === 1))) begin
                  if (OmsgOn) $display("%t Left Port Deselected", $realtime);
                  rdl_en_p1 = `BT_S'h0;
                  rdl_tDC_p1 = 1'b0;
               end
            end // if (!((opernl_type == `MASKRD) || (opernl_type == `CNTRD)))


            //-----------------------------------------
            // Driving the outputs
            if (reset_over == 1) begin
               // Drive Address outputs from clk edge
               if (mskl_rd_en_p2 == 1'b1) begin
                  al_r <= # tCKLZ `AD_S'hX;
                  al_r <= # tCM2 mskl_rdbk_p2;
               end else if (cntl_rd_en_p2 == 1'b1) begin
                  al_r <= # tCKLZ `AD_S'hX;
                  al_r <= # tCA2 cntl_rdbk_p2;
               end else begin
                  al_r <= # tCKHZ `AD_S'hZ;
               end

               // Drive Cntint interrupt pin from clk edge
               if (cntintl_en_p1 == 1'b1) begin
                  cntint_nl <= #tSCINT 1'b0;
               end else begin
                  cntint_nl <= #tRCINT 1'b1;
               end

               // Set Right port Mailbox interrupt pin from clk edge
               if (mailintr_en == 1'b1) begin
                  int_nr <= #tSINT 1'b0;
               end

               // Reset Left port Mailbox interrupt pin from clk edge
               if (mailintl_en == 1'b0) begin
                  int_nl <= #tRINT 1'b1;
               end
            end

            //-----------------------------------------
            // X-Handling of input pins
            no_use = chk_x_ce0("ce0_nl", ce0_nl);
            no_use = chk_x_ce1("ce1l", ce1l);
            no_use = chk_x_r_w("r_w_nl", r_w_nl);

         end // if ((clkl_event) && (clkl === 1))

         //---------------------------------------------------------------------------------

         // Drive Data outputs from this block only when mrst_n is high
         if ((oe_nl_event) && (oe_nl === 0)) begin            // outputs from oe low event
            oel_pulse_chk = $realtime;
            tOEl_over_chk = $realtime;
            tOHZ_overl_f = 1'b0;             
            tOEl_int <= #tOE ~tOEl_int;

            if (OmsgOn) $display("%t Drive Left Port Data outputs from oe", $realtime);
            case (rdl_en_p2)
              `BT_S'b0000: begin
                 dql_r <= #tOLZ `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
              end
              
              `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin
                   if (rdl_en_p2[0] == 1'b1) begin
                      dql_r[8:0] <= #tOLZ `BITSPL'hX;
                   end
                   if (rdl_en_p2[1] == 1'b1) begin
                      dql_r[17:9] <= #tOLZ `BITSPL'hX;
                   end
                   if (rdl_en_p2[2] == 1'b1) begin
                      dql_r[26:18] <= #tOLZ `BITSPL'hX;
                   end
                   if (rdl_en_p2[3] == 1'b1) begin
                      dql_r[35:27] <= #tOLZ `BITSPL'hX;
                   end
                end
              default: $display("Model Internal Error");
            endcase // case(rdl_en_p2)
         
         end else if ((oe_nl_event) && (oe_nl === 1) && (!oel_int_event)) begin   // outputs from oe high event
            oel_pulse_chk = $realtime;
            oel_int <= #tOHZ ~oel_int;

         end else if (!((oe_nl_event) && (oe_nl === 0)) && (oel_int_event)) begin
            if (OmsgOn) $display("%t Drive Left port Data Outputs High-Z", $realtime);
            if (($realtime - oel_pulse_chk) >= tOHZ) begin
               tOHZ_overl_f = 1'b1; 
               dql_r <= `DT_S'hZ;
            end

         end else if (!((oe_nl_event) && (oe_nl === 0)) && (tOEl_int_event)) begin
            if (OmsgOn) $display("%t Drive Left Port Data outputs from oe", $realtime);
            if (($realtime - tOEl_over_chk) >= tOE) begin
               case (rdl_en_p2)
                 `BT_S'b0000: begin
                    dql_r <= #0 `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
                 end
                 `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                   `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                   `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                   `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin

                      if (rdl_en_p2[0] == 1'b1) begin
                         dql_r[8:0] <= #0 dql_p2[8:0];
                      end
                      if (rdl_en_p2[1] == 1'b1) begin
                         dql_r[17:9] <= #0 dql_p2[17:9];
                      end
                      if (rdl_en_p2[2] == 1'b1) begin
                         dql_r[26:18] <= #0 dql_p2[26:18];
                      end
                      if (rdl_en_p2[3] == 1'b1) begin
                         dql_r[35:27] <= #0 dql_p2[35:27];
                      end
                   end
                 default: $display("Model Internal Error");                 
               endcase // case(rdl_en_p2)
            end

         end else if ((!oe_nl_event) && (oe_nl === 0) && (clkl_event) && (clkl === 1)) begin  // outputs from clk
            if (OmsgOn) $display("%t Drive Left Port Data outputs from clk ", $realtime);
            if (!((cnthldl_en_p2 == 1'b1) && (last_opernl_p2 === `READ) && (last_opernl_p3 === `READ))) begin
               case (rdl_en_p2)
                 `BT_S'b0000: begin
                    if ((cntl_rd_en_p2 == 1'b0) && (mskl_rd_en_p2 == 1'b0)) begin  // In mskrd and cntrd modes outputs should go to High-Z only and not the Low-Z.
                       if (rdl_tDC_p3 == 1'b1) begin
                          dql_r <= #tDC `DT_S'hX;
                       end
                    end
                    dql_r <= #tCKHZ `DT_S'hZ;
                 end

                 `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                   `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                   `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                   `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin
                      drive_valid_outputs(`LEFT, 0);
                      drive_valid_outputs(`LEFT, 1);
                      drive_valid_outputs(`LEFT, 2);
                      drive_valid_outputs(`LEFT, 3);                      
                   end
                 default: $display("Model Internal Error");                 
               endcase // case(rdl_en_p2)
            end

         end else if ((!oe_nl_event) && (oe_nl === 1) && (tOHZ_overl_f == 1'b0) && (clkl_event) && (clkl === 1)) begin  // outputs from clk
            if (OmsgOn) $display("%t Drive Left Port Data outputs from clk ", $realtime);
            if (!((cnthldl_en_p2 == 1'b1) && (last_opernl_p2 === `READ) && (last_opernl_p3 === `READ))) begin
               case (rdl_en_p2)
                 `BT_S'b0000: begin
                    dql_r <= #tCKHZ `DT_S'hZ;
                 end

                 `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                   `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                   `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                   `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin
                       drive_outputs_oe_hi(`LEFT, 0);
                       drive_outputs_oe_hi(`LEFT, 1);
                       drive_outputs_oe_hi(`LEFT, 2);
                       drive_outputs_oe_hi(`LEFT, 3);                      
                   end
                 default: $display("Model Internal Error");                 
               endcase // case(rdl_en_p2)
            end

         end else if ((!oe_nl_event) && (oe_nl === 1) && (tOHZ_overl_f == 1'b1) && (clkl_event) && (clkl === 1)) begin  // outputs from clk
            if (OmsgOn) $display("%t Drive Left Port Data outputs to High-Z from clk when OE is high", $realtime);
            dql_r <= `DT_S'hZ;
            
         end else if ((oe_nl_event) && (oe_nl === 1'bx)) begin
            no_use = chk_x_oe("oe_nl", oe_nl);
         end

         //================================================================================================
         // RIGHT PORT

         if ((clkr_event) && (clkr === 1)) begin // Right Port clock Active

            mirrorr_loaded_en = 1'b0;
            if (cntintr_en_p1 == 1'b1) begin
               cntr_reg = mirrorr_reg;          // load mirror reg into counter reg after reaching max value
               mirrorr_loaded_en = 1'b1;
            end
            cntintr_en_p1 = 1'b0;

            dqr_p2 = dqr_p1;       // pipeline data
            rdr_en_p2 = rdr_en_p1; // pipeline read enable signal
            rdr_tDC_p3 = rdr_tDC_p2; // pipeline of control signal for tDC
            rdr_tDC_p2 = rdr_tDC_p1; // pipeline of control signal for tDC

            mskr_rd_en_p2 = mskr_rd_en_p1;
            mskr_rd_en_p1 = 1'b0;
            mskr_rdbk_p2 = mskr_rdbk_p1;
            mskr_rdbk_p1 = `AD_S'h0;

            cntr_rd_en_p2 = cntr_rd_en_p1;
            cntr_rd_en_p1 = 1'b0;
            cntr_rdbk_p2 = cntr_rdbk_p1;
            cntr_rdbk_p1 = `AD_S'h0;

            cnthldr_en_p2 = cnthldr_en_p1;
            cnthldr_en_p1 = 1'b0;
            tOEr_over_chk = $realtime;
            last_opernr_p3 = last_opernr_p2;
            last_opernr_p2 = last_opernr_p1;
            last_opernr_p1 = 1'bx;

            case ({cnt_msk_nr, cntrst_nr})

              2'b00: begin // Mask Reset
                 if (OmsgOn) $display("%t Reseting the Mask Register for Right port to all 1s", $realtime);
                 mskr_reg = `UNMASK_ALL;
                 mskpartr_bit_no = `AD_M;
              end

              2'b01: begin // Mask register functions
                 case ({ads_nr, cnten_nr})
                   2'b00: begin // Mask Load
                      mskr_reg = chk_and_load_msk_fn(`RIGHT);
                      cnthldr_en_p1 = 1'b1;
                      opernr_type = `MASKLD;
                   end

                   2'b01: begin // Mask Readback
                      if (OmsgOn) $display("%t Mask Readback operation", $realtime);
                      mskr_rd_en_p1 = 1'b1;
                      mskr_rdbk_p1 = mskr_reg;
                      rdr_en_p1 = `BT_S'h0;   // for msk read operation dq goes High-Z in the next clk cycle
                      rdr_tDC_p1 = 1'b0;   // No read operation will be performed, so no holding of data reqd
                      opernr_type = `MASKRD;
                   end

                   2'b10: begin // Reserved
                      $display("%t Operation Undefined", $realtime);
                      cnthldr_en_p1 = 1'b1;
                      opernr_type = `NONE;
                   end

                   2'b11: begin // Reserved
                      $display("%t Operation Undefined", $realtime);
                      cnthldr_en_p1 = 1'b1;
                      opernr_type = `NONE;
                   end

                   default: begin
                      cnthldr_en_p1 = 1'b1;
                      opernr_type = `NONE;
                      no_use = chk_x_ads("ads_nr", ads_nr);
                      no_use = chk_x_cnten("cnten_nr", cnten_nr);
                   end
                 endcase // case({ads_nr, cnten_nr})
              end

              2'b10: begin // Counter Reset
                 if (OmsgOn) $display("%t Reseting Counter at Right port", $realtime);
                 if (mskr_reg[0] == 1) begin // Reset only unmasked region
                    cntr_reg[0] = 1'b0;
                 end
                 for (i=1; i<= mskpartr_bit_no; i=i+1) begin  // Reset only unmasked region
                    cntr_reg[i] = 1'b0;
                 end
                 opernr_type = `CNTRST;
              end

              2'b11: begin // Counter functions
                 case ({ads_nr, cnten_nr})
                   2'b00: begin // Counter Load
                      if (chk_x_a("ar", ar)) begin
                         opernr_type = `NONE;
                      end else begin
                         if (OmsgOn) $display("%t Loading Address Counter at Right port", $realtime);
                         cntr_reg = ar;
                         mirrorr_reg = ar;
                         opernr_type = `CNTLD;
                      end
                   end

                   2'b01: begin // Counter Readback
                      if (OmsgOn) $display("%t Reading back the counter at Right port", $realtime);
                      cntr_rd_en_p1 = 1'b1;
                      cntr_rdbk_p1 = cntr_reg;
                      rdr_en_p1 = `BT_S'h0;   // for msk read operation dq goes High-Z in the next clk cycle
                      rdr_tDC_p1 = 1'b0;   // No read operation will be performed, so no holding of data reqd
                      opernr_type = `CNTRD;
                   end

                   2'b10: begin // Counter Increment
                      if (mirrorr_loaded_en == 1'b0) begin
                         // Increment unmasked region only
                         tempA_reg1 = cntr_reg;
                         if (mskr_reg[0] == 1) begin
                            tempA_reg1 = tempA_reg1 + 1;
                         end else begin
                            tempA_reg1 = tempA_reg1 + 2;
                         end
                         for (i = 0; i <= mskpartr_bit_no; i = i+1) begin
                            cntr_reg[i] = tempA_reg1[i];
                         end
                      end
                      //chk the wrapover of cnt register and interrupt
                      temp_f = 1'b1;
                      if (mskr_reg[0] == 1) begin
                         for (i = 0; i <= mskpartr_bit_no; i = i+1) begin
                            if (cntr_reg[i] != mskr_reg[i])   temp_f = 1'b0;
                         end
                      end else begin
                         for (i = 1; i <= mskpartr_bit_no; i = i+1) begin
                            if (cntr_reg[i] != mskr_reg[i])   temp_f = 1'b0;
                         end
                      end

                      if (temp_f == 1'b1)   cntintr_en_p1 = 1'b1;
                      opernr_type = `CNTINC;
                   end

                   2'b11: begin // Counter Hold
                      cnthldr_en_p1 = 1'b1;
                      opernr_type = `CNTHLD;
                   end

                   default: begin
                      cnthldr_en_p1 = 1'b1;
                      opernr_type = `NONE;
                      no_use = chk_x_ads("ads_nr", ads_nr);
                      no_use = chk_x_cnten("cnten_nr", cnten_nr);
                   end
                 endcase // case({ads_nr, cnten_nr})
              end
              default: begin
                 cnthldr_en_p1 = 1'b1;
                 opernr_type = `NONE;
                 no_use = chk_x_cnt_msk("cnt_msk_nr", cnt_msk_nr);
                 no_use = chk_x_cntrst("cntrst_nr", cntrst_nr);
              end
            endcase // case({cnt_msk_nr, cntrst_nr})

            if (!((opernr_type == `MASKRD) || (opernr_type == `CNTRD))) begin
               if ((ce0_nr === 0) && (ce1r === 1) && (r_w_nr === 1)) begin // Read operation
                  if ((reset_chk_fn(no_use)) == 1) begin
                     case (b_nr)
                       
                       `BT_S'b1111: begin
                          if (OmsgOn) $display("%t Right Port No Byte Read Operation", $realtime);
                          rdr_en_p1 = ~b_nr;
                          rdr_tDC_p1 = 1'b0;
                       end
                       
                       `BT_S'b0000,`BT_S'b0001,`BT_S'b0010,`BT_S'b0011,
                         `BT_S'b0100,`BT_S'b0101,`BT_S'b0110,`BT_S'b0111,
                         `BT_S'b1000,`BT_S'b1001,`BT_S'b1010,`BT_S'b1011,
                         `BT_S'b1100,`BT_S'b1101,`BT_S'b1110 : begin
                            if (OmsgOn) $display("%t Right Port Read Operation", $realtime);
                            dqr_p1 = read_data_and_tCCS_chk_fn(`RIGHT);
                            rdr_en_p1 = ~b_nr;
                            rdr_tDC_p1 = 1'b1;
                            if (cntr_reg == `LAST_ADR)  mailintr_en = 1'b0;  // Mailbox interrupt Ack for right port
                         end
                       
                       default : begin
                          no_use = chk_x_b("b_nr", b_nr);
                          rdr_en_p1 = `BT_S'h0; // disable outputs
                          rdr_tDC_p1 = 1'b0;
                       end
                     endcase // case(b_nr)
                  end
               end else if ((ce0_nr === 0) && (ce1r === 1) && (r_w_nr === 0)) begin // Write operation
                  if ((reset_chk_fn(no_use)) == 1) begin
                     rdr_en_p1 = `BT_S'h0;
                     rdr_en_p2 = `BT_S'h0; // for write operation dq goes High-Z at the same clk cycle
                     rdr_tDC_p1 = 1'b0;
                     rdr_tDC_p2 = 1'b0;
                     rdr_tDC_p3 = 1'b0;
                     
                     if ((chk_x_dq("dqr", dqr)) == 0) begin
                        case(b_nr)
                          
                          `BT_S'b0000,`BT_S'b0001,`BT_S'b0010,`BT_S'b0011,
                          `BT_S'b0100,`BT_S'b0101,`BT_S'b0110,`BT_S'b0111,
                          `BT_S'b1000,`BT_S'b1001,`BT_S'b1010,`BT_S'b1011,
                          `BT_S'b1100,`BT_S'b1101,`BT_S'b1110 : begin
                             
                             if (OmsgOn) $display("%t Right Port Write Operation", $realtime);
                             tempD_reg1 = mem[cntr_reg]; // get the previous data
                             tempD_reg2 = write_data_and_tCCS_chk_fn(`RIGHT); // save the current data temporarily
                             if (b_nr[0] === 1'b0) begin
                                tempD_reg1[8:0] = tempD_reg2[8:0];
                             end
                             if (b_nr[1] === 1'b0) begin
                                tempD_reg1[17:9] = tempD_reg2[17:9];
                             end
                             if (b_nr[2] === 1'b0) begin
                                tempD_reg1[26:18] = tempD_reg2[26:18];
                             end
                             if (b_nr[3] === 1'b0) begin
                                tempD_reg1[35:27] = tempD_reg2[35:27];
                             end
                             mem[cntr_reg] = tempD_reg1;                     // write to memory
                             if (cntr_reg == `LAST_ADR-1)  mailintl_en = 1'b1; // Mailbox interrupt Generation for right port
                          end
                          
                          `BT_S'b1111: begin
                             if (OmsgOn) $display("%t Right Port No Byte Write Operation", $realtime);
                          end
                          default : begin
                             no_use = chk_x_b("b_nr", b_nr);
                          end
                        endcase // case(b_nr)
                     end
                  end
               end else if (!((ce0_nr === 0) && (ce1r === 1))) begin
                  if (OmsgOn) $display("%t Right Port Deselected", $realtime);
                  rdr_en_p1 = `BT_S'h0;
                  rdr_tDC_p1 = 1'b0;
               end
            end // if (!((opernr_type == `MASKRD) || (opernr_type == `CNTRD)))

            
            //-----------------------------------------
            // Driving the outputs
            if (reset_over == 1) begin
               // Drive Address outputs from clk edge
               if (mskr_rd_en_p2 == 1'b1) begin
                  ar_r <= # tCKLZ `AD_S'hX;
                  ar_r <= # tCM2 mskr_rdbk_p2;
               end else if (cntr_rd_en_p2 == 1'b1) begin
                  ar_r <= # tCKLZ `AD_S'hX;
                  ar_r <= # tCA2 cntr_rdbk_p2;
               end else begin
                  ar_r <= # tCKHZ `AD_S'hZ;
               end

               // Drive Cntint interrupt pin from clk edge
               if (cntintr_en_p1 == 1'b1) begin
                  cntint_nr <= #tSCINT 1'b0;
               end else begin
                  cntint_nr <= #tRCINT 1'b1;
               end

               // Set Left port Mailbox interrupt pin from clk edge
               if (mailintl_en == 1'b1) begin
                  int_nl <= #tSINT 1'b0;
               end

               // Reset Right port Mailbox interrupt pin from clk edge
               if (mailintr_en == 1'b0) begin
                  int_nr <= #tRINT 1'b1;
               end
            end
            
            //-----------------------------------------
            // X-Handling of input pins
            no_use = chk_x_ce0("ce0_nr", ce0_nr);
            no_use = chk_x_ce1("ce1r", ce1r);
            no_use = chk_x_r_w("r_w_nr", r_w_nr);

         end // if ((clkr_event) && (clkr === 1))

         //---------------------------------------------------------------------------------

         // Drive Data outputs from this block only when mrst_n is high
         if ((oe_nr_event) && (oe_nr === 0)) begin            // outputs from oe low event
            oer_pulse_chk = $realtime;
            tOEr_over_chk = $realtime;
            tOHZ_overr_f = 1'b0;             
            tOEr_int <= #tOE ~tOEr_int;

            if (OmsgOn) $display("%t Drive Right Port Data outputs from oe", $realtime);
            case (rdr_en_p2)
              `BT_S'b0000: begin
                 dqr_r <= #tOLZ `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
              end
              
              `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin
                   if (rdr_en_p2[0] == 1'b1) begin
                      dqr_r[8:0] <= #tOLZ `BITSPL'hX;
                   end
                   if (rdr_en_p2[1] == 1'b1) begin
                      dqr_r[17:9] <= #tOLZ `BITSPL'hX;
                   end
                   if (rdr_en_p2[2] == 1'b1) begin
                      dqr_r[26:18] <= #tOLZ `BITSPL'hX;
                   end
                   if (rdr_en_p2[3] == 1'b1) begin
                      dqr_r[35:27] <= #tOLZ `BITSPL'hX;
                   end
                end
              default: $display("Model Internal Error");
            endcase // case(rdr_en_p2)
         
         end else if ((oe_nr_event) && (oe_nr === 1) && (!oer_int_event)) begin   // outputs from oe high event
            oer_pulse_chk = $realtime;
            oer_int <= #tOHZ ~oer_int;

         end else if (!((oe_nr_event) && (oe_nr === 0)) && (oer_int_event)) begin
            if (OmsgOn) $display("%t Drive Right port Data Outputs High-Z", $realtime);
            if (($realtime - oer_pulse_chk) >= tOHZ) begin
               tOHZ_overr_f = 1'b1;                
               dqr_r <= `DT_S'hZ;
            end

         end else if (!((oe_nr_event) && (oe_nr === 0)) && (tOEr_int_event)) begin
            if (OmsgOn) $display("%t Drive Right Port Data outputs from oe", $realtime);
            if (($realtime - tOEr_over_chk) >= tOE) begin
               case (rdr_en_p2)
                 `BT_S'b0000: begin
                    dqr_r <= #0 `DT_S'hZ; // This is required only during initialization of model. tOLZ is min.
                 end
                 `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                   `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                   `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                   `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin

                      if (rdr_en_p2[0] == 1'b1) begin
                         dqr_r[8:0] <= #0 dqr_p2[8:0];
                      end
                      if (rdr_en_p2[1] == 1'b1) begin
                         dqr_r[17:9] <= #0 dqr_p2[17:9];
                      end
                      if (rdr_en_p2[2] == 1'b1) begin
                         dqr_r[26:18] <= #0 dqr_p2[26:18];
                      end
                      if (rdr_en_p2[3] == 1'b1) begin
                         dqr_r[35:27] <= #0 dqr_p2[35:27];
                      end
                   end
                 default: $display("Model Internal Error");                 
               endcase // case(rdr_en_p2)
            end

         end else if ((!oe_nr_event) && (oe_nr === 0) && (clkr_event) && (clkr === 1)) begin  // outputs from clk
            if (OmsgOn) $display("%t Drive Right Port Data outputs from clk ", $realtime);
            if (!((cnthldr_en_p2 == 1'b1) && (last_opernr_p2 === `READ) && (last_opernr_p3 === `READ))) begin
               case (rdr_en_p2)
                 `BT_S'b0000: begin
                    if ((cntr_rd_en_p2 == 1'b0) && (mskr_rd_en_p2 == 1'b0)) begin  // In mskrd and cntrd modes outputs should go to High-Z only and not the Low-Z.
                       if (rdr_tDC_p3 == 1'b1) begin
                          dqr_r <= #tDC `DT_S'hX;
                       end
                    end
                    dqr_r <= #tCKHZ `DT_S'hZ;
                 end

                 `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                   `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                   `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                   `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin
                      drive_valid_outputs(`RIGHT, 0);
                      drive_valid_outputs(`RIGHT, 1);
                      drive_valid_outputs(`RIGHT, 2);
                      drive_valid_outputs(`RIGHT, 3);                      
                   end                   
                 default: $display("Model Internal Error");
               endcase // case(rdr_en_p2)
            end

         end else if ((!oe_nr_event) && (oe_nr === 1) && (tOHZ_overr_f == 1'b0) && (clkr_event) && (clkr === 1)) begin  // outputs from clk
            if (OmsgOn) $display("%t Drive Right Port Data outputs from clk ", $realtime);
            if (!((cnthldr_en_p2 == 1'b1) && (last_opernr_p2 === `READ) && (last_opernr_p3 === `READ))) begin
               case (rdr_en_p2)
                 `BT_S'b0000: begin
                    dqr_r <= #tCKHZ `DT_S'hZ;
                 end

                 `BT_S'b0001,`BT_S'b0010,`BT_S'b0011,`BT_S'b0100,
                   `BT_S'b0101,`BT_S'b0110,`BT_S'b0111,`BT_S'b1000,
                   `BT_S'b1001,`BT_S'b1010,`BT_S'b1011,`BT_S'b1100,
                   `BT_S'b1101,`BT_S'b1110,`BT_S'b1111 : begin
                       drive_outputs_oe_hi(`RIGHT, 0);
                       drive_outputs_oe_hi(`RIGHT, 1);
                       drive_outputs_oe_hi(`RIGHT, 2);
                       drive_outputs_oe_hi(`RIGHT, 3);                      
                   end                   
                 default: $display("Model Internal Error");
               endcase // case(rdr_en_p2)
            end

         end else if ((!oe_nr_event) && (oe_nr === 1) && (tOHZ_overr_f == 1'b1) && (clkr_event) && (clkr === 1)) begin  // outputs from clk
            if (OmsgOn) $display("%t Drive Right Port Data outputs to High-Z from clk when OE is high", $realtime);
            dqr_r <= `DT_S'hZ; // Added by CZU 24Aug01
            
         end else if ((oe_nr_event) && (oe_nr === 1'bx)) begin
            no_use = chk_x_oe("oe_nr", oe_nr);
         end

         //================================================================================================         
      end // if ((!mrst_n_event) && (mrst_n === 1))

      pv_assign;
      event_reset;

   end // always @ (mrst_n or clkl or clkr or al or ar or ads_nl or ads_nr or ce0_nl or ce0_nr or ce1l or ce1r or clkl or clkr or cnten_nl or cnten_nr or cntrst_nl or cntrst_nr or cnt_msk_nl or cnt_msk_nr or oe_nl or oe_nr or r_w_nl or r_w_nr or b_nl or b_nr or oel_int or oer_int or tOEl_int or tOEr_int or dql or dqr)




endmodule // cy7c0851v

/******************************************************************************************************/
