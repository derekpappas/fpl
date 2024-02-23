// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// -----------------------------------------------------------------------------
// File Name :  cyd18s72vvr.v
// Version : 1.0
// Status : Module is Complete
// -----------------------------------------------------------------------------
// Author : Ashlesha Gokhale
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date : May, 06, 2003
// -----------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : May 06, 2003
// -----------------------------------------------------------------------------
// Dependencies : 
//  cyd18s72v_Define_model.v, cyd18s72v_Timing_model.v, cyd18s72v_Task_model.v
// Description  : This file contains the functional description of the device  cyd18s72v.
// Simulation Notes : NA
// Application Note : NA
// Simulator : verilog xl.
// Terms & concepts : 
// Open issues and future enhancements : None
// References : 
// Revision History :
// Rev  Author    Phone           Date           Changes
// -----------------------------------------------------------------------------
//      <Name>    <number>        <Date>          <details>
//0.1   Ashlesha  2933700.2074    10.05.2003       New file
//1.0   Ashlesha                                   Added the tDC timing parameter     
//1.1   Ashlesha 22933700.2074    02.04.2003       Fixed for modelsim simulator
//                                                 version 5.7d
//-----------------------------------------------------------------------------

`timescale 1ns/10ps
`include "cyd18s72v_Define_model.v"

module  cyd18s72v (al,        // Address input left
                   ar,         // Address input right
                   clkl,       // Clock input left
                   clkr,       // Clock input right
                   dql,        // Data bus input/output left
                   dqr,        // Data bus input/output right
                   oe_nl,      // Output enable input left
                   oe_nr,      // Output enable input right
                   int_nl,     // Mailbox interrupt flag output left
                   int_nr,     // Mailbox interrupt flag output right
                   r_w_nl,     // Read/Write Enable input left
                   r_w_nr,     // Read/Write Enable input right
                   b_nl,       // Byte select inputs left
                   b_nr,       // Byte select inputs right
                   mrst_n      // Master reset input
                   );

   input [`AD_M :0] al, ar;     // Address inputs

   input            clkl,       // Clock input left
                    clkr;       // Clock input right
   inout [`DT_M :0] dql,        // Data bus input/output left
                    dqr;        // Data bus input/output right

   input            oe_nl,      // Output enable input left
                    oe_nr;      // Output enable input right

   output           int_nl,     // Mailbox interrupt flag output left
                    int_nr;     // Mailbox interrupt flag output right

   input            r_w_nl,     // Read/Write Enable input left
                    r_w_nr;     // Read/Write Enable input right

   input [`BT_M : 0] b_nl,       // Byte select inputs left
                     b_nr;       // Byte select inputs right

   input             mrst_n;     // Master reset input

   //====================================================================================================

   // variables
   integer           rsp_fv; // response file pointer

   reg [`DT_M : 0]   mem[0 : `LAST_ADR]; // define memory array size


   reg [`BT_M : 0]   rdl_en_p1,  // Byte enable for current operation on left port
                     rdr_en_p1,  // Byte enable for current operation on right port
                     rdl_en_p2,  // Byte enable for last    operation on left port
                     rdr_en_p2;  // Byte enable for lasr    operation on right port

   reg [`DT_M : 0]   dql_p1,     // Read Data of current operation on left port
                     dql_p2,     // Read Data of current operation on right port
                     dqr_p1,     // Read Data of last operation on left port 
                     dqr_p2,     // Read Data of last operation on right port
                     read_buffer_l, // temporarily stores data accessed from memory for left port.
                     write_buffer_l,// temporarily stores data obtained from data bus of left port.
                     read_buffer_r, // temporarily stores data accessed from memory for right port.
                     write_buffer_r;// temporarily stores data obtained from data bus of left port.
   
   reg [2:0]         debug; // register for message level settings
   reg               OmsgOn, // Model debug messages on if this is set 
                     XmsgOn, // X-handling messages on  if this is set 
                     TmsgOn; // Timing messages on  if this is set

   reg               setup_hold_chk; // Check setup hold timings  only after this reg is set.

   reg               tRS_f; // indicates if reset operation has started.
   reg               reset_over_l; // inidicates reset operation is complete
   reg               reset_over_r; // inidicates reset operation is complete
   reg               reset_detected;
   
   //integer           reset_counter_l;  required if reset recovery time 
   //integer           reset_counter_r;  is deifned in clk cycles


   


   reg               last_opernl_p1, // current operation on left port 
                     last_opernl_p2, // current operation on right port 
                     last_opernr_p1, // last operation on left port 
                     last_opernr_p2; // last operation on right port


   reg               last_access_type; // last access type  on left or right port.

   reg [`AD_M : 0]   last_addr; // stores last address
   reg [`AD_M : 0]   tempA_reg1;
   
   reg [`DT_M : 0]   tempD_reg1,
                     tempD_reg2;

   reg               no_use;

   // Registers for Output ports
   reg [`AD_M :0]    al_r,
                     ar_r;

   reg [`DT_M :0]    dql_r,
                     dqr_r;

   reg               int_nl,
                     int_nr;


   // Timing violation check variables
   realtime          tRS_chk;
   realtime          tCCS_chk;

   realtime          oel_pulse_chk_low,          oer_pulse_chk_low;
   realtime          oel_pulse_chk_high,          oer_pulse_chk_high;

   realtime          rising_edge_clk_l,      rising_edge_clk_r;
   realtime          falling_edge_clk_l,     falling_edge_clk_r;

   realtime          addr_last_change_l,     addr_last_change_r;
   realtime          byte_sel_last_change_l, byte_sel_last_change_r;

   realtime          rw_last_change_l,       rw_last_change_r;
   realtime          dq_last_change_l,       dq_last_change_r;
   realtime          ads_sel_last_change_l,  ads_sel_last_change_r;
   realtime          rising_edge_mrst,       falling_edge_mrst;


   reg               dql_event, dqr_event,
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



   reg               mrst_n_pv;
   reg               prev_mrst_n;    
   reg [`DT_M:0]     dql_pv, dqr_pv;
   reg               clkl_pv, clkr_pv;
   reg [`AD_M:0]     al_pv, ar_pv;
   reg [`AD_M:0]     al_prev, ar_prev;
   reg               oe_nl_pv, oe_nr_pv;
   reg               r_w_nl_pv, r_w_nr_pv;
   reg [`BT_M:0]     b_nl_pv, b_nr_pv;


   integer           i;
   integer           j, k, n ;
   integer           bit_no;

   reg               mailintl_en,
                     mailintr_en;
   reg               x_detected_l;                     
   reg               x_detected_r;                     
   reg               rsetup_violation_l;
   reg               rsetup_violation_r;   
   reg               hold_violation_l;
   reg               hold_violation_r;   
   reg               r_w_hold_violation_l;
   reg               r_w_hold_violation_r;
   reg               addr_hold_violation_l;
   reg               addr_hold_violation_r;

 
`include "cyd18s72v_Timing_model.v" // This file contains all timing parameters.
`include "cyd18s72v_Task_model.v"        // This file contains model related tasks.

   //====================================================================================================

   assign            dql = dql_r; 
   assign            dqr = dqr_r;


   initial begin
      : INIT
      $timeformat (-9, 1, " ns", 12); // defined  format of time parameter 
      $readmemh("dpram_array.txt", mem); // initializing memory  from  file.
      
      falling_edge_mrst = 0;
      rdl_en_p1 = 'b00;
      rdr_en_p1 = 'b00;
      rdl_en_p2 = 'b00;
      rdr_en_p2 = 'b00;


      dql_p1 = `DT_S'hx;
      dqr_p1 = `DT_S'hx;
      dql_p2 = `DT_S'hx;
      dqr_p2 = `DT_S'hx;
`ifdef TIMINGDEBUG
      TmsgOn = 1'b1;
`else
      TmsgOn = 1'b0;
`endif
`ifdef UNKNOWNDEBUG      
      XmsgOn = 1'b1;
`else
      XmsgOn = 1'b0;
`endif
`ifdef MODELDEBUG   
      OmsgOn =  1'b1;
`else  
      OmsgOn =  1'b0;
`endif 
      setup_hold_chk = 0;

      tRS_f = `STOP;
      reset_over_l = 0;
      reset_over_r = 0;
      reset_detected = 'b0;
      
      
      last_opernl_p1 = 1'bx;   // x defines no read or write operation
      last_opernl_p2 = 1'bx;
      
      last_opernr_p1 = 1'bx;
      last_opernr_p2 = 1'bx;
      

      last_access_type = `READ;

      last_addr = `AD_S'hx; // X can't be previous valid address.
      tempA_reg1 = `AD_S'h0;
      tempD_reg1 = `DT_S'h0;
      tempD_reg2 = `DT_S'h0;

      al_r = `AD_S'h0;
      ar_r = `AD_S'h0;
      dql_r = `DT_S'hx; //changed initialization to 'x'
      dqr_r = `DT_S'hx;

      int_nl = 1;
      int_nr = 1;

      tRS_chk = 0;
      tCCS_chk = 0;
      oel_pulse_chk_low = 0;
      oer_pulse_chk_low = 0;
      oel_pulse_chk_high = 0;
      oer_pulse_chk_high = 0;


      hold_violation_l = 1'b0;
      hold_violation_r = 1'b0;
      r_w_hold_violation_l = 1'b0;                   
      r_w_hold_violation_r = 1'b0;                   
      addr_hold_violation_l = 1'b0;                   
      addr_hold_violation_r = 1'b0;                   


      i = 0;
      j = 0;
      bit_no = 0;
      

      mailintl_en = 0;
      mailintr_en = 0;

      event_reset;
      pv_reset;

      `ifdef GENRSPFILE
      //create a response file. using a c-shell script compare this file against gold file//
      
      rsp_fv = $fopen("cyd18s72v.rsp");

      $fdisplay(rsp_fv, "\t                Cypress  cyd18s72v Memory Model Tests Response                                  ");
      $fdisplay(rsp_fv, "\t-----------------------------------------------------------------------------------------------");
      $fdisplay(rsp_fv, "\tTIME       M  C  A      B  R O D                   I | C A      B  R  O  D                    I ");
      $fdisplay(rsp_fv, "\t           R  L  D      Y  / E A                   N | L D      Y  /  E  A                    N ");
      $fdisplay(rsp_fv, "\t           S  K  D      T  W | T                   T | K D      T  W  |  T                    T ");
      $fdisplay(rsp_fv, "\t           T  |  R      E  | N A                   | | | R      E  |  N  A                    |");
      $fdisplay(rsp_fv, "\t           |  L  |      |  N L |                   N | R |      |  N  R  |                    N ");
      $fdisplay(rsp_fv, "\t           N     L      L  L   L                   L |   R      R  R     R                    R ");

      $fdisplay(rsp_fv, "\t-----------------------------------------------------|------------------------------------------");

      //strobe essential
      $fmonitor(rsp_fv, "%t : %b  %b  %h  %h %b %b %h  %b | %b %h  %h %b  %b  %h   %b", $realtime, mrst_n, clkl, al, b_nl, r_w_nl, oe_nl, dql, int_nl, clkr, ar, b_nr, r_w_nr, oe_nr, dqr, int_nr);

`endif
   end
   // This always block checks all the set up and hold timings. 
   
   always @(mrst_n or clkl or clkr or al or ar or oe_nl or oe_nr or r_w_nl or r_w_nr or b_nl or b_nr or   dql or dqr) begin

      event_chk; 
      timing_chk;
      pv_assign;
      event_reset;
   end

   // This block executes all reset activities.
   always@(mrst_n) begin
      if (mrst_n === 0) begin // Device is reset
         if (OmsgOn) $display("%t Reseting the Device", $realtime);

         // -- all  register are reset
         if ($realtime > 0) setup_hold_chk = 0;
         
         rdl_en_p1 = 'b00;
         rdr_en_p1 = 'b00;
         rdl_en_p2 = 'b00;
         rdr_en_p2 = 'b00;

         

         dql_p1 = `DT_S'hx;
         dqr_p1 = `DT_S'hx;
         dql_p2 = `DT_S'hx;
         dqr_p2 = `DT_S'hx;


         tRS_f = `START;
         reset_detected = 0;



         last_opernl_p1 = 1'bx;   // x defines no read or write operation
         last_opernl_p2 = 1'bx;

         last_opernr_p1 = 1'bx;
         last_opernr_p2 = 1'bx;


         last_access_type = `READ;

         last_addr = `AD_S'hx; // X can't be previous valid address.
         tempA_reg1 = `AD_S'h0;
         tempD_reg1 = `DT_S'h0;
         tempD_reg2 = `DT_S'h0;

         // -- addr and data outputs




         // -- Interrupt flags
         int_nl <= #tRSF 1'b1;
         int_nr <= #tRSF 1'b1;
         

         tRS_chk = $realtime;
         tCCS_chk = $realtime;
         oel_pulse_chk_low = $realtime;
         oer_pulse_chk_low = $realtime;
         oel_pulse_chk_high = $realtime;
         oer_pulse_chk_high = $realtime;


         i = 0;
         j = 0;
         bit_no = 0;


         mailintl_en = 0;
         mailintr_en = 0;
         prev_mrst_n = 'b0;  
         

      end else if ((prev_mrst_n===0)&& (mrst_n === 1)) begin // Reset operation was performed and
         // device is out of reset now.

         if (OmsgOn) $display("%t Reset operation over", $realtime);
         if (tRS_f == `START) begin
            if ($realtime - tRS_chk < tRS) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset Pulse Width - tRS violation during Master Reset", $realtime);
            end
            tRS_f = `STOP;
            reset_detected = 1;
           // reset_counter_l = 4;
           // reset_counter_r = 4;
           
           reset_over_l <= #tRSR 1'b1 ;
           reset_over_r <= #tRSR 1'b1 ;
           dql_r <= #tRSR `DT_S'hz;
           dqr_r <= #tRSR `DT_S'hz;
            if ($realtime > 0) setup_hold_chk <= #tRSR 1;
         end

      end // else if ((prev_mrst_n===0)&& (mrst_n === 1))
   end//always@(mrst_n)
   //==========================================================================
   // LEFT PORT

   always@(clkl or hold_violation_l)
     begin
        if  ((clkl === 1)|| (hold_violation_l == 1'b1))  begin

           rsetup_violation_l = 1'b0;
           if (hold_violation_l !== 1'b1)            
              setup_check_l; 
           // This block is required if reset recovery time is defined in 
           // terms of clk cycles.
          /* if ((reset_detected == 1'b1) && ( reset_over_l == 0))
             begin
                reset_counter_l = reset_counter_l - 1; 
                if (reset_counter_l == 0)begin
                   reset_over_l = 1;
                   dql_r <=  `DT_S'hz;
                end
             end */ 
           if(reset_over_l == 1)begin // Left Port clock Active
              
              dql_p2 = dql_p1;                 // data read on last clock is forwarded for output.
              
              last_opernl_p2 = last_opernl_p1; // operation performed on last clock is forwarded.   
              last_opernl_p1 = 1'bx;                 // current operation is intialized to 'x'.
              
              x_detected_l = chk_x_r_w("r_w_nl", r_w_nl) | chk_x_b("b_nl", b_nl) | chk_x_a("al",al);


              // Read or write operations are performed only after device is reset at least once.

              if  ( x_detected_l === 1'b0) begin
                 // Checks if reset is performed and Rd/Wrn /= 'x'.
                 if ((r_w_nl === 1'b1) && (!r_w_hold_violation_l))  begin               //changed for hold violation 
  
                    if (OmsgOn) $display("%t Left Port Read Operation", $realtime);
                    last_opernl_p1 = `READ;   
                    read_buffer_l = read_data_and_tCCS_chk_fn(`LEFT);  
                    dql_p1 = `DT_S'hz;                  // all bits are initialized to 'z'.
                    for (i = 0; i < 8; i = i+1)      // this loop is performed for all 8 bytes of data 
                      if (b_nl[i] == 1'b0) begin    // checks if byte i is enabled
                         j = `BYTE_SIZE*(i+1)-1;    // j is MSB of ith byte
                         k = `BYTE_SIZE*(i);      // k is LSB of ith byte
                         rdl_en_p1[i] = 1'b1;       // byte enabled for current operation is stored.
                         
                         for ( n = k ; n <= j ; n = n+1)  // this loop assigns data read from 
                           dql_p1[n] = read_buffer_l[n];     //memory to output buffer1 bit by bit.
                      end  // if (b_nl[i] == 1'b0)        

                    if ((rsetup_violation_l === 1'b1)|| (hold_violation_l === 1'b1))  begin
                               dql_p1 = `DT_S'hx;
                               
                    end                       

                    if (al == (`LAST_ADR-1))  
                      mailintl_en = 1'b0;  // Mailbox interrupt Ack for left port
                    
                    end else if ((r_w_nl === 0) || ((r_w_hold_violation_l == 1'b1) && (r_w_nl == 1'b1))) begin //changed for hold violation    
                    if (OmsgOn) $display("%t Left Port Write Operation", $realtime);
                    read_buffer_l = mem[al]; //get data from location where new data
                    //has to be written. This ensures, data is written only
                    //to enabled bytes   
                    
                    write_buffer_l= write_data_and_tCCS_chk_fn(`LEFT); // get data from data bus.

                    last_opernl_p1 = `WRITE;
                    dql_p1 = `DT_S'hx;                  // all bits are initialized to 'z'.
                    no_use = chk_x_dq("dql", dql); // checks  of the data pins is in unknown state
                    for (i = 0; i < 8; i = i+1)   
                      if (b_nl[i] == 1'b0) begin
                         j = `BYTE_SIZE*(i+1)-1;  
                         k = `BYTE_SIZE*(i);    
                         for ( n = k ; n <= j ; n = n+1)
                           read_buffer_l[n] = write_buffer_l[n]; // only enabled bytes are chenged
                      end // if (b_nl[i] == 1'b0)     
                    
                     if ((rsetup_violation_l === 1'b1)|| (hold_violation_l === 1'b1)) begin
                           if (addr_hold_violation_l)
                               mem[al_prev] = `DT_S'hx;
                           else 
                               mem[al] = `DT_S'hx;
                     end else
                      mem[al] = read_buffer_l;         
                     
                    if (al == `LAST_ADR)  mailintr_en = 1'b1; // Mailbox interrupt Generation for right port
                 end // if (r_w_nl === 0)

                 //-----------------------------------------
                 // Driving the outputs
                 // Set Right port Mailbox interrupt pin from clk edge
                 if (mailintr_en == 1'b1) begin
                    int_nr <= #tSINT 1'b0;
                 end
                 // Reset Left port Mailbox interrupt pin from clk edge
                 if (mailintl_en == 1'b0) begin
                    int_nl <= #tRINT 1'b1;
                 end
              end // if (x_detected_l == 0)
              if  (last_opernl_p1 == `WRITE) begin // if read was performed last clock
                 if ((dql_r  !== `DT_S'bz) && (oe_nl == 'h0))
                   if (tDC < tCKHZmin)
                     dql_r <= #tCKHZmin `DT_S'bx;  
                   else
                     dql_r <= #tDC `DT_S'bx;  // added by ashlesha 20/09/03
                 
                 if ((last_opernl_p2 == `WRITE)  && (oe_nl == 'h0))
                   dql_r <= #tCKHZ `DT_S'bz;  // if last operation was not read, drive data to high-Z 
              end else  if  (last_opernl_p2 == `READ) begin // if read was performed last clock
                 // Data is outputed on te data bus in this clock   
                 if (oe_nl == 1'b0)  begin             // checks if oe is already asserted.
                    if (dql_r !== dql_p2) 
                      for (i= 0; i <= `DT_M; i = i+1)  // only those bytes which are enabled for read
                        if (dql_p2[i] !== 1'bz) begin
                           dql_r[i] <= #tCKLZ `DT_S'bx;   // Low-z  simulation
                           dql_r[i] <= #tCD2  dql_p2[i]; // Valid data is assigned  after tCD2 delay.
                        end else 
                          dql_r[i] <= #tCKHZ 'bz;  // if byte was not enabled for read,  drive data to                                                  //  high-Z  for that byte.
                 end  
              end   else  begin
                   dql_r <= #tCKHZ `DT_S'bz;  // if last operation was not read, drive data to high-Z 
                 
              end     
              
              //-----------------------------------------
           end else if  ((reset_over_l == 0) && ( $realtime > tRSS + tRS + tRSR))  begin
              if (TmsgOn) $display("%t Operating the device without performing Reset operation:", $realtime);
              if (TmsgOn) $display("\t\t Reset the device to function properly\n");
           end//if (reset_over == 0)
           hold_violation_l =1'b0;
           if (r_w_hold_violation_l == 1'b1)begin
                  r_w_hold_violation_l = 1'b0;
           end    
           if (addr_hold_violation_l == 1'b1)begin
                  addr_hold_violation_l = 1'b0;    
           end    
        end // if (clkl === 1)
        
     end//
   


   //==========================================================================
   // Right PORT

   always@(clkr or hold_violation_r  ) // changed for hold violation    
     begin
        if  (clkr === 1'b1) begin
           rsetup_violation_r = 1'b0;
           if (hold_violation_r !== 1'b1)            
           setup_check_r; 

           if (reset_over_r == 1'b1) begin // Right Port clock Active
              
              dqr_p2 = dqr_p1;       // pipeline data
              last_opernr_p2 = last_opernr_p1;
              last_opernr_p1 = 1'bx;
              // X-Handling of input pins
              x_detected_r = chk_x_r_w("r_w_nr", r_w_nr) | chk_x_b("b_nr", b_nr) | chk_x_a("ar",ar);

              if (x_detected_r == 1'b0) begin  
                 if ((r_w_nr === 1) && (!r_w_hold_violation_r) ) begin  // Read operation
                    if (OmsgOn) $display("%t Right Port Read Operation", $realtime);
                    last_opernr_p1 = `READ;
                    read_buffer_r = read_data_and_tCCS_chk_fn(`RIGHT);
                    dqr_p1 = `DT_S'hz;
                    for (i = 0; i < 8; i = i+1)   
                      if (b_nr[i] == 1'b0) begin
                         j = `BYTE_SIZE*(i+1)-1; 
                         k = `BYTE_SIZE*(i);    
                         rdr_en_p1[i] = 1'b1;
                         for ( n = k ; n <= j ; n = n+1) 
                           dqr_p1[n] = read_buffer_r[n];
                         
                      end          
                      if ((rsetup_violation_r === 1'b1)|| (hold_violation_r === 1'b1)) begin
                          dqr_p1 = `DT_S'hx;
                     end                       

                    if (ar == `LAST_ADR)mailintr_en = 1'b0; // Mailbox interrupt Ack for right port

                 end else if ((r_w_nr === 0) || (( r_w_hold_violation_r == 1'b1) && (r_w_nr == 1'b1)))
                 begin  
                 
                    if (OmsgOn) $display("%t Right Port Write Operation", $realtime);
                    read_buffer_r = mem[ar];
                    write_buffer_r= write_data_and_tCCS_chk_fn(`RIGHT);
                    last_opernr_p1 = `WRITE;
                    dqr_p1 = `DT_S'hx;
                    no_use = chk_x_dq("dqr", dqr);
                    
                    for (i = 0; i < 8; i = i+1)   
                      if (b_nr[i] === 1'b0) begin
                         j = `BYTE_SIZE*(i+1)-1;  
                         k = `BYTE_SIZE*(i);    
                         for ( n = k ; n <= j ; n = n+1)
                           read_buffer_r[n] = write_buffer_r[n];
                      end     
                     
                     if ((rsetup_violation_r === 1'b1)|| (hold_violation_r === 1'b1)) begin
                        if (addr_hold_violation_r) begin
                            
                            mem[ar_prev] = `DT_S'hx;
                        end else   
                            mem[ar] = `DT_S'hx;
                            
                     end else
                     mem[ar] = read_buffer_r;           

                    if (ar == `LAST_ADR-1 )mailintl_en = 1'b1; //Mailbox interrupt Generation for right port
                 end // if (r_w_nr == 0)     
                 
                 
                 

                 //-----------------------------------------
                 // Driving the outputs
                 
                 // Set Right port Mailbox interrupt pin from clk edge
                 if (mailintr_en == 1'b0) begin
                    int_nr <= #tSINT 1'b1;
                 end

                 // Reset Right port Mailbox interrupt pin from clk edge
                 if (mailintl_en == 1'b1) begin
                    int_nl <= #tRINT 1'b0;
                 end
              end// ( x_detected_r == 0)

              if  (last_opernr_p1 == `WRITE) begin // if read was performed last clock
                 if ((dqr_r  !== `DT_S'bz ) && (oe_nr == 0))
                   if (tDC < tCKHZmin)
                     dqr_r <= #tCKHZmin `DT_S'bx;  // if last operation was not read, 
                 //drive data to high-Z 
                   else
                     dqr_r <= #tDC `DT_S'bx;  //Added by ashlesha 20/09/03
                 if ((last_opernr_p2 == `WRITE)  && (oe_nr == 'h0))
                   dqr_r <= #tCKHZ `DT_S'bz;  // if last operation was not read, drive data to high-Z 
              end else  if  (last_opernr_p2 == `READ) begin
                 if (oe_nr == 1'b0) begin
                    if (dqr_r !== dqr_p2 ) 
                      for (i= 0; i <= `DT_M; i = i+1) 
                        if (dqr_p2[i] !== 1'bz )begin
                           dqr_r[i] <= #tCKLZ 'bx;   
                           dqr_r[i] <= #tCD2  dqr_p2[i];
                        end  else  
                          dqr_r[i] <= #tCKHZ 'bz; 
                    
                 end 
                 //-----------------------------------------
              end // if (last_opernr_p2 == `READ)
              else  
                   dqr_r <= #tCKHZ `DT_S'bz; 
           end else if  ((reset_over_r == 0) && ( $realtime > tRSS + tRS + tRSR))  begin
              
              if (TmsgOn) $display("%t Operating the device without performing Reset operation:", $realtime);
              if (TmsgOn) $display("\t\t Reset the device to function properly\n");
           end// (reset_over == 1'b0)   
           hold_violation_r =1'b0;           
           if (r_w_hold_violation_r == 1'b1)begin
              r_w_hold_violation_r = 1'b0;
           end    
           if (addr_hold_violation_r == 1'b1)begin
              addr_hold_violation_r = 1'b0;    
           end    
        end         
     end// always@clkr    

   //--------------------------------------------------------------------------

   always@(oe_nr)   begin
      if ((chk_x_oe("oe_nr", oe_nr) == 1'b0) && (reset_over_r == 1'b1)) begin
         if  (oe_nr === 0) begin            // outputs from oe low event
            oer_pulse_chk_low = $realtime;
            
            if (OmsgOn) $display("%t Drive Right Port Data outputs from oe", $realtime);
            if (last_opernr_p2 == `READ) begin
               for (i = 0;  i<= `DT_M;  i= i +1)
                 if (dqr_p2[i] !== 1'bz )begin
                    dqr_r[i] <= #tOLZ 'hx;
                    dqr_r[i] <= #tOE  dqr_p2[i];
                 end
            end

         end else if (oe_nr === 1) begin
            oer_pulse_chk_high = $realtime;
            for ( i = 0; i < `DT_S; i = i+1) 
                if (dqr[i] !== 1'bz)
                 dqr_r[i] <= #tOHZmin 'bx;
            dqr_r <= #tOHZ `DT_S'bz;
         end
      end else // if ((chk_x_oe("oe_nr", oe_nr) == 1'b0) && (reset_over == 1'b1))
        dqr_r <=  `DT_S'hx;
   end // always@(oe_nr)  

   always@(oe_nl) begin
      if ((reset_over_l == 1'b1) && (chk_x_oe("oe_nl", oe_nl) == 1'b0)) begin
         if  (oe_nl === 0) begin            // outputs from oe low event
            oel_pulse_chk_low = $realtime; // oe pulse width chek starts 
            
            if (OmsgOn) $display("%t Drive Left Port Data outputs from oe", $realtime);
            if (last_opernl_p2 == `READ) begin // output  is driven only if latency time is over

               for (i = 0;  i<= `DT_M;  i= i +1)
                 if (dql_p2[i] !== 1'bz  )begin
                    dql_r[i] <= #tOLZ 'hx; //Low-Z timing
                    dql_r[i] <= #tOE  dql_p2[i]; // valid data is driven after tOE
                 end
            end
         end else if (oe_nl === 1) begin
            oel_pulse_chk_high = $realtime; // low pulse check
            for ( i = 0; i < `DT_S; i = i+1) 
                
                if (dql[i] !== 1'bz) 

                    dql_r[i] <= #tOHZmin 1'bx;


            dql_r <= #tOHZ `DT_S'bz;
         end
      end else // if ((reset_over == 1'b1) && (chk_x_oe("oe_nl", oe_nl) == 1'b0))
        dql_r <= `DT_S'hx;
      

  end // always(oe_nl)




endmodule //  cyd18s72v

//==================================End OF File=====================================================//










