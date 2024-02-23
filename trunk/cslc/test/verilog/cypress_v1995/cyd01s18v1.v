// Copyright (c) 2003 by Wipro Technologies
//
// This module is confidential and propritery property of Wiipro Technologies  
// and a possetion or use of this module requires a written permission from Wipro 
// Technologies.
// -----------------------------------------------------------------------------
// File Name :  cyd01s18vvr.v
// Version : 1.0
// Status : Module is Complete
// -----------------------------------------------------------------------------
// Author : Ashlesha Gokhale
// E-mail : ashlesha.gokhale@wipro.com
// Company : Wipro Technologies
// Creation date : April, 08, 2004
// --------------------------------------------------------------------------------------------------------
// Last modified by : Ashlesha Gokhale 
// Last modified on : April 08, 2004
// --------------------------------------------------------------------------------------------------------
// Dependencies : cyd01s18v_Define_model.v, cyd01s18v_Timing_model.v, cyd01s18v_Task_model.v
// Description  : This file contains the functional description of the device cyd01s18v.
// Simulation Notes : NA
// Application Note : NA
// Simulator : verilog xl 2.2, vsim 5.7d
// Terms & concepts : 
// Open issues and future enhancements : None
// References : 
// Revision History :
// Rev  Author    Phone           Date           Changes
// -------------------------------------------------------------------------------------------------------
//0.1   Ashlesha  22933700.2074   08.05.2003    New file
//--------------------------------------------------------------------------------------------------------

`timescale 1ns/10ps

// This file is a congifuration file and defines data width, 
// memory depth, byte enable width etc. parametes.

`include "cyd01s18v_Define_model.v"

//**************** Declairing DP SRAM module***********************************//
module   cyd01s18v (al,        // Address input left
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
                   ce0_nl,     // Chip Enable 0 left
                   ce1_l,      // Chip Enable 1 left   
                   ce0_nr,     // Chip Enable 0 right
                   ce1_r,     // Chip Enable 1 right
                   ads_nl,     // Address strobe input left
                   ads_nr,     // Address strobe input right  
                   cnten_nl,   // Counter Enable left
                   cnten_nr,   // Counter Enable right 
                   cntrst_nl,  // Counter reset  left
                   cntrst_nr,  // Counter reset  right
                   cnt_msk_nl,  // Address Counter mask enable left
                   cnt_msk_nr,  // Address Counter mask enable right
                   cntint_nl,   // Counter Interrupt left
                   cntint_nr,   // Counter Interrupt right                
                   mrst_n      // Master reset input
                   );
//**************** Module Declairation Ends Here ******************************//


//***************Input output Declairation ************************************//
// This file contains all timing parameters.   
`include "cyd01s18v_Timing_model.v" 



   inout [`AD_M : 0] al, ar;     // Address inputs

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

   input             ce0_nl,      // Chip Enable 0 left                      
                     ce1_l,       // Chip Enable 1 left                     
                     ce0_nr,      // Chip Enable 0 right                    
                     ce1_r,      // Chip Enable 1 right                    
                     ads_nl,      // Address strobe input left              
                     ads_nr,      // Address strobe input right             
                     cnten_nl,    // Counter Enable left                    
                     cnten_nr,    // Counter Enable right                   
                     cntrst_nl,   // Counter reset  left                    
                     cntrst_nr,   // Counter reset  right                   
                     cnt_msk_nl,  // Address Counter mask enable left       
                     cnt_msk_nr;   // Address Counter mask enable right      
   output            cntint_nl,   // Counter Interrupt left                 
                     cntint_nr;   // Counter Interrupt right                

   input             mrst_n;     // Master reset input

//===============Input Output Declairation ends here===========================//


//**************Internal Registers, variables declairation*********************//
   integer           rsp_fv; // response file pointer

   reg [`DT_M : 0]   mem[0 : `LAST_ADR]; // define memory array size


   reg [`BT_M : 0]   rdl_en_p1, //Byte enable for current operation on left port
                     rdr_en_p1, //Byte enable for current operation on right port
                     rdl_en_p2, //Byte enable for last    operation on left port
                     rdr_en_p2; //Byte enable for lasr    operation on right port

   reg [`DT_M : 0]   dql_p1,     // Read Data of current operation on left port
                     dql_p2,     // Read Data of current operation on right port
                     dqr_p1,     // Read Data of last operation on left port 
                     dqr_p2,     // Read Data of last operation on right port
                     read_buffer_l, // temporarily stores data accessed from 
                                    // memory for left port.
                     write_buffer_l,// temporarily stores data obtained from 
                                    // data bus of left port.
                     read_buffer_r, // temporarily stores data accessed from 
                                    // memory for right port.
                     write_buffer_r;// temporarily stores data obtained from 
                                    // data bus of left port.
   
   reg [2:0]         debug;         // register for message level settings
   reg               OmsgOn,        // Model debug messages on if this is set 
                     XmsgOn,        // X-handling messages on  if this is set 
                     TmsgOn;        // Timing messages on  if this is set

   reg               setup_hold_chk, // Check setup hold timings  
                     flag_al,        // only after this reg is set.
                     flag_ar;        // only after this reg is set.

   reg               tRS_f;          // indicates if reset operation has started.
   reg               reset_over_l;   // inidicates reset operation is complete
   reg               reset_over_r;   // inidicates reset operation is complete
   reg               reset_detected; 
   

   reg [2:0]         last_opernl_p1, // current operation on left port 
                     last_opernl_p2, // current operation on right port 
                     last_opernr_p1, // last operation on left port 
                     last_opernr_p2; // last operation on right port


   reg               last_access_type; // last access type on left or right port.

   reg [`AD_M : 0]   last_addr;        // stores last address
   reg               no_use;

   reg [`AD_M :0]   counter_reg_l, counter_reg_r;
   reg [`AD_M :0]   mask_reg_l, mask_reg_r;
   reg [`AD_M :0]   mirror_reg_l, mirror_reg_r;
   reg [`AD_M :0]   address_l, address_r;
   reg [`AD_M :0]   mask_length_l, mask_length_r;  
   reg [`AD_M :0]   max_count_l , max_count_r;  
   reg              no_operation_l_f, no_operation_r_f;
   // Registers for Output ports
   reg [`AD_M :0]    al_r,
                     ar_r;
   reg [`AD_M :0]    al_p1,
                     ar_p1;
   reg [`AD_M :0]    al_p2,
                     ar_p2;

   reg [`DT_M :0]    dql_r,
                     dqr_r;
   reg [`DT_M :0]    dql_r_delayed,
                     dqr_r_delayed;

   reg               int_nl,
                     int_nr;
                     
   reg               cntint_nl,
                     cntint_nr;                  

                     

//*****************Registers for timing checks*********************************//

   // Timing violation check variables
   realtime          tRS_chk;
   realtime          tCCS_chk;

   realtime          oel_pulse_chk_low, oer_pulse_chk_low;
   realtime          oel_pulse_chk_high, oer_pulse_chk_high;

   realtime          rising_edge_clk_l, rising_edge_clk_r;
   realtime          falling_edge_clk_l,falling_edge_clk_r;

   realtime          addr_last_change_l, addr_last_change_r;
   realtime          byte_sel_last_change_l, byte_sel_last_change_r;

   realtime          rw_last_change_l,       rw_last_change_r;
   realtime          dq_last_change_l,       dq_last_change_r;
   realtime          ads_sel_last_change_l,  ads_sel_last_change_r;
   realtime          rising_edge_mrst,       falling_edge_mrst;
   realtime          ce0_last_change_l,       ce0_last_change_r;
   realtime          ce1_last_change_l,       ce1_last_change_r;
   realtime          ads_last_change_l,     ads_last_change_r;        
   realtime          cnten_last_change_l;   
   realtime          cnten_last_change_r;   
   realtime          cntrst_last_change_l;  
   realtime          cntrst_last_change_r;  
   realtime          cnt_msk_last_change_l; 
   realtime          cnt_msk_last_change_r; 
   realtime          cntint_last_change_l;  
   realtime          cntint_last_change_r;  


   reg               dql_event, dqr_event,
                     clkl_event, clkr_event,
                     mrst_n_event,
                     al_event, ar_event,
                     ads_nl_event, ads_nr_event,
                     ce0_nl_event, ce0_nr_event,
                     ce1_l_event, ce1_r_event,
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
               
   reg               ce0_nl_pv,     
                     ce1_l_pv,      
                     ce0_nr_pv,     
                     ce1_r_pv,     
                     ads_nl_pv,     
                     ads_nr_pv,     
                     cnten_nl_pv,   
                     cnten_nr_pv,   
                     cntrst_nl_pv,  
                     cntrst_nr_pv,  
                     cnt_msk_nl_pv, 
                     cnt_msk_nr_pv, 
                     cntint_nl_pv,  
                     cntint_nr_pv;  

   integer           i;
   integer           j, k, n ;
   integer           bit_no;

   reg               mailintl_en,
                     mailintr_en;
   reg               x_detected_l;                     
   reg               x_detected_r;                     

   reg               opl, opr;    
   
   reg               cntint_nl_f,  cntint_nr_f;
   reg               rsetup_violation_l;
   reg               rsetup_violation_r;
   reg               hold_violation_l;
   reg               hold_violation_r;
   reg               r_w_hold_violation_l;
   reg               r_w_hold_violation_r;
   reg               addr_hold_violation_l;
   reg               addr_hold_violation_r;

   
//======================End of Declairation======================================

//*********************** Assigning bidirectional prots to registers ***********

   assign            dql = dql_r; 
   assign            dqr = dqr_r;
   
   assign            al  = al_r; 
   assign            ar  = ar_r;
   
//*********************** Assigning bidirectional prots to registers ***********
// This file contains model related tasks.
`include "cyd01s18v_Task_model.v"        

//*********************** Inititalizing internal variables ********************//
   initial begin
       : INIT
       $timeformat (-9, 1, " ns", 12); // defined  format of time parameter 
       $readmemh("dpram_array.txt", mem); // initializing memory  from  file.

       falling_edge_mrst = 0;
       rdl_en_p1 = 'b00;
       rdr_en_p1 = 'b00;
       rdl_en_p2 = 'b00;
       rdr_en_p2 = 'b00;
      read_buffer_l = 'b00;
      

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
      
      
       last_opernl_p1 = 'bx;   // x defines no read or write operation
       last_opernl_p2 = 'bx;
      
       last_opernr_p1 = 'bx;
       last_opernr_p2 = 'bx;
      

       last_access_type = `READ;

       last_addr = `AD_S'hx; // X can't be previous valid address.

       al_r = `AD_S'hx;
       ar_r = `AD_S'hx;
       dql_r = `DT_S'hx; //changed initialization to 'x'
       dqr_r = `DT_S'hx;

       cntint_nl = 1;
       cntint_nr = 1;


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
       opl = 1'b0;
       opr = 1'b0;

       //create a response file. using a c-shell script compare this file against 
       //gold file      
      `ifdef GENRSPFILE

          rsp_fv = $fopen("cyd01s18v.rsp");

          $fdisplay(rsp_fv, "\t                Cypress  cyd01s18v Memory Model Tests Response                                  ");
          $fdisplay(rsp_fv, "\t---------------------------------------------------------------------------------------------------");
          $fdisplay(rsp_fv, "\tTIME       M  C  A    C C A C C C C B R O D      I | C A    C C A C C C C B R  O  D       I ");
          $fdisplay(rsp_fv, "\t           R  L  D    E E D N N N N Y / E A      N | L D    E E D N N N N Y /  E  A       N ");
          $fdisplay(rsp_fv, "\t           S  K  D    0 1 S T T T T T W | T      T | K D    0 1 S T T T T T W  |  T       T ");
          $fdisplay(rsp_fv, "\t           T  |  R    | | | E R | I E | N A      | | | R    | | | E R | I E |  N  A       |");
          $fdisplay(rsp_fv, "\t           |  L  |    N L N N S M N | N L |      N | R |    N R N N S M N | N  R  |       N ");
          $fdisplay(rsp_fv, "\t           N     L    L   L | T S T L L   L        |   R    R   R | | S T R R     R       R ");
          $fdisplay(rsp_fv, "\t                            N | K |                |              N N K |                    ");
          $fdisplay(rsp_fv, "\t                            L N | N                |              R R | N         ");
          $fdisplay(rsp_fv, "\t                              L N L                |                  N R         ");
          $fdisplay(rsp_fv, "\t                                L                  |                  R           ");
       $fdisplay(rsp_fv, "\t---------------------------------------------------|-----------------------------------------------");

      
          $fmonitor(rsp_fv, "%t : %b  %b  %h %b %b %b %b %b %b %b %h %b %b %h  %b | %b %h %b %b %b %b %b %b %b %h %b  %b  %h   %b", 
          $realtime, mrst_n, clkl, al, ce0_nl, ce1_l, ads_nl, cnten_nl, cntrst_nl, 
          cnt_msk_nl, cntint_nl, b_nl, r_w_nl, oe_nl, dql, int_nl, clkr, ar, ce0_nr,
          ce1_r, ads_nr, cnten_nr, cntrst_nr, cnt_msk_nr, cntint_nr,  b_nr, r_w_nr, 
          oe_nr, dqr, int_nr);
      `endif
   end
//*********************** Inititalization Ends Here ***************************//


//************ This always block checks all the set up and hold timings.*******//
 
   always @(mrst_n or clkl or clkr or al or ar or oe_nl or oe_nr or 
            r_w_nl or r_w_nr or b_nl or b_nr or dql or dqr or ads_nl or cnten_nl or cntrst_nl or cnt_msk_nl or ads_nr or cnten_nr or cntrst_nr or cnt_msk_nr or ce0_nl or ce1_l or ce0_nr or ce1_r) begin
       event_chk; 
       timing_chk;
       pv_assign;
       event_reset;
   end
//**********************End of Timing Check ***********************************//

//************************Reset Block******************************************//
   always@(mrst_n) begin 
      if (mrst_n === 0) begin // Device is reset
         if (OmsgOn) $display("%t:: Model Reset Block :  Reseting the Device", $realtime);


         // -- all  register are reset
         if ($realtime > 0) setup_hold_chk = 0;
         
         rdl_en_p1 = 'b00;
         rdr_en_p1 = 'b00;
         rdl_en_p2 = 'b00;
         rdr_en_p2 = 'b00;

         dql_p1 = `DT_S'hx;
         dql_p2 = `DT_S'hx;

         dqr_p1 = `DT_S'hx;
         dqr_p2 = `DT_S'hx;


         tRS_f = `START;
         reset_detected = 0;
         
         al_r = `AD_S'hz;
         ar_r = `AD_S'hz;


         last_opernl_p1 = 'bx;   // x defines no read or write operation
         last_opernl_p2 = 'bx;

         last_opernr_p1 = 'bx;
         last_opernr_p2 = 'bx;


         last_access_type = `READ;

         last_addr = `AD_S'hx; // X can't be previous valid address.


         // -- Interrupt flags
         int_nl <= #tRScntint 1'b1;
         int_nr <= #tRScntint 1'b1;
         

         tRS_chk = $realtime;
         tCCS_chk = $realtime;
         oel_pulse_chk_low = $realtime;
         oer_pulse_chk_low = $realtime;
         oel_pulse_chk_high = $realtime;
         oer_pulse_chk_high = $realtime;
         
         mask_reg_l = `LAST_ADR;
         mask_reg_r = `LAST_ADR; 
         counter_reg_l = `AD_S'h0;
         counter_reg_r = `AD_S'h0;
         mirror_reg_l = `AD_S'h0;
         mirror_reg_r = `AD_S'h0;
         mask_length_l  = `AD_S;
         mask_length_r  = `AD_S;
         max_count_l    = `LAST_ADR;
         max_count_r    = `LAST_ADR;
         i = 0;
         j = 0;
         bit_no = 0;
         flag_al = 0;
         flag_ar = 0;

         mailintl_en = 0;
         mailintr_en = 0;
         prev_mrst_n = 'b0;  
         
     // Reset operation was performed and device is out of reset now.

      end else if ((prev_mrst_n===0)&& (mrst_n === 1)) begin



         if (OmsgOn) $display("%t:: Model Reset Block : Reset operation over", $realtime);
         if (tRS_f == `START) begin
             if ($realtime - tRS_chk < tRS) begin
                 if(TmsgOn)
                     $display("%t WARNING : Master Reset Pulse Width - tRS violation during Master Reset", $realtime);
            end
            tRS_f = `STOP;
            reset_detected = 1;
                       
            reset_over_l <= #tRSR 1'b1 ;
            reset_over_r <= #tRSR 1'b1 ;
            dql_r <= #tRSR `DT_S'hz;
            dqr_r <= #tRSR `DT_S'hz;
            al_r  <= #tRSR `AD_S'hz;
            ar_r  <= #tRSR `AD_S'hz;

            if ($realtime > 0) setup_hold_chk <= #tRSR 1;
         end

      end // else if ((prev_mrst_n===0)&& (mrst_n === 1))
   end//always@(mrst_n)

   //==========================================================================
   
   //************************ LEFT PORT OPERATION ******************************//

   always@(clkl or  hold_violation_l)  //changed for hold violation
     begin

        if(clkl === 1'b0)begin
           flag_al =  0;
        end
        
           
     
      if ((clkl === 1'b1) || (hold_violation_l == 1'b1)) begin //changed for hold violation

 
        // Check if ce0 or ce1 is not x and ce is enabled.  
        if( (chk_x_ce("ce0_nl", ce0_nl)| chk_x_ce("ce1_l", ce1_l)==0 ) && 
            (ce0_nl == 1'b0) && (ce1_l == 1'b1) ) begin
             if (hold_violation_l !== 1'b1)
             setup_check_l; 
            // Any operation is performed only after device is reset at 
            // least once.
            if(reset_over_l == 1) begin       // Left Port clock Active  
    
                
                // data read on last clock is forwarded for output.
                dql_p2 = dql_p1;  

                // address output forwarded  
                al_p2 = al_p1;
              
                // operation performed on last clock is forwarded.   
                last_opernl_p2 = last_opernl_p1; 
                
                // current operation is intialized to 'x'.
                last_opernl_p1 = 'bx;                 
               
               
                // Checking Unknown value on control inputs and address    
                x_detected_l = chk_x_r_w("r_w_nl", r_w_nl) | chk_x_b("b_nl", b_nl); 
                
                     
                if ( x_detected_l === 1'b0) begin 
                    get_next_address_left;
                    if (no_operation_l_f == 1'b0) begin  

                        //******** Read operation starts here *************************//
                  
                        if ((r_w_nl === 1'b1) && (!r_w_hold_violation_l))  begin               //changed for hold violation 
                                        
                            if (OmsgOn) $display("%t Left Port Read Operation", $realtime);
                            last_opernl_p1 = `READ;   
                            read_buffer_l = read_data_and_tCCS_chk_fn(`LEFT);        
                            // all data bits are initialized to 'z'.
                            dql_p1 = `DT_S'hz;                
                            //**** this loop is performed for all  bytes of data*****//   
                            for (i = 0; i < `BT_S; i = i+1)      
                                if (b_nl[i] == 1'b0) begin    //checks if byte i is enabled
                                   j = `BYTE_SIZE*(i+1)-1;    // j is MSB of ith byte
                                   k = `BYTE_SIZE*(i);        // k is LSB of ith byte
                                
                                   // byte enable mask for current operation is stored.
                                   rdl_en_p1[i] = 1'b1;       
                                
                                   // this loop assigns data read from memory to 
                                   // output buffer1 bit by bit 
                                   for(n = k; n <= j; n = n+1)  dql_p1[n] = read_buffer_l[n];
                                end  // if (b_nl[i] == 1'b0)        


                           
                            //**** end of byte enable loop **********//
                            
                            if ((rsetup_violation_l === 1'b1) || (hold_violation_l === 1'b1)) begin
                               dql_p1 = `DT_S'hx;
                             
                            end 
                            // Mailbox interrupt Ack for left port  
                            if (address_l == (`LAST_ADR-1))  
                                mailintl_en = 1'b0;  
                        
                            //******** Read operation ends here ************************// 
                        
                        end else if ((r_w_nl === 0) || ((r_w_hold_violation_l == 1'b1) && (r_w_nl == 1'b1))) begin //changed for hold violation    
                           
                            //******** write operation starts here***********************//
                        
                            if(OmsgOn) $display("%t Left Port Write Operation", $realtime);
                        
                            //Get data from location where new data has to be written.
                            //This ensures, data is written only to enabled bytes   
                            read_buffer_l = mem[address_l]; 
                             
                            // get data from data bus.
                            write_buffer_l= write_data_and_tCCS_chk_fn(`LEFT); 
                            last_opernl_p1 = `WRITE;
                        
                            // all bits are initialized to 'X'.
                            dql_p1 = `DT_S'hx;     
                        
                            // checks  of the data pins is in unknown state             
                            no_use = chk_x_dq("dql", dql); 
                        
                            for (i = 0; i < `BT_S; i = i+1)   
                                if (b_nl[i] == 1'b0) begin
                                   j = `BYTE_SIZE*(i+1)-1;  
                                   k = `BYTE_SIZE*(i);    
                                   // only enabled bytes are chenged
                                   for ( n = k ; n <= j ; n = n+1)
                                   read_buffer_l[n] = write_buffer_l[n]; 
                                end // if (b_nl[i] == 1'b0)     
                    
                            if ((rsetup_violation_l === 1'b1)||(hold_violation_l === 1'b1)) begin
                               if (addr_hold_violation_l)
                                   mem[al_prev] = `DT_S'hx;
                                else begin   
                                   mem[address_l] = `DT_S'hx;
                                   
                                end   
                    
                            end else
                               mem[address_l] = read_buffer_l;
                            // Mailbox interrupt Generation for right port
                            if (address_l == `LAST_ADR)  mailintr_en = 1'b1; 
                        end // if (r_w_nl === 0)
                        // Set Right port Mailbox interrupt pin from clk edge
                        if (mailintr_en == 1'b1) begin
                           int_nr <= #tSINT 1'b0;
                        end
                        // Reset Left port Mailbox interrupt pin from clk edge
                        if (mailintl_en == 1'b0) begin
                          int_nl <= #tRINT 1'b1;
                        end
                    end//no_operation_l_f  
                        
                  end// if (x_detected_l == 0)
              end else if   ((reset_over_l == 0) &&( $realtime > tRSS + tRS + tRSR))  begin
                  if (TmsgOn) $display("%t Operating the device without performing Reset operation:",$realtime);
                  if (TmsgOn) $display("\t\t Reset the device to function properly\n");
              end  //if (reset_over == 0)
              
              opl = ~opl;
          end//( ce enabled)   
          rsetup_violation_l = 1'b0;
          if (hold_violation_l) begin
              hold_violation_l = 1'b0;
              if (r_w_hold_violation_l == 1'b1)begin
                  r_w_hold_violation_l = 1'b0;
              end    
              if (addr_hold_violation_l == 1'b1)begin
                  addr_hold_violation_l = 1'b0;    
              end    
          end 
       end//if(clk =1)
   end//(alway@clkl)
   
   //******************** Driving outputs of left port **********************//
   always@(opl)begin

        //-------------Driving Address output  -----------------------//
        if (last_opernl_p2 == `COUNTERREADBACK) begin
            al_r <= #tCKLZ `AD_S'bx;
            al_r <= #tCA2   al_p2;
        end else if (last_opernl_p2 == `MASKREADBACK) begin
            al_r <= #tCKLZ `AD_S'bx;
            al_r <= #tCM2  al_p2;
        end else if (al_r !== `AD_S'bz)begin    
           al_r <= #tDC `AD_S'bx;
           al_r <= #tCKHZ `AD_S'bz ;
           flag_al <= #(0.99 * tCKHZ) 1;
//           flag_al <= #(tCKHZ) 0;
        end     
           
                  
        //-------------Driving data outputs in Write cycle---------------// 

        if (cntint_nl_f == 1'b1) begin   
          if ( cntint_nl !== 1'b0) begin 
              cntint_nl <= #tRCINT    'b0; 
          end 
        end else if  (cntint_nl !== 1) begin
           cntint_nl <= #tSCINT    'b1; 
        end             


        if (last_opernl_p1 !== `READ) begin 
            if ((dql_r  !== `DT_S'bz) && (oe_nl == 'h0))
                if (tDC < tCKHZmin)
                    dql_r_delayed <= #tCKHZmin `DT_S'bx;  
                else
                    dql_r_delayed <= #tDC `DT_S'bx;  
             
            // if last operation was not read, drive data to high-Z 
            if ((last_opernl_p2 == `WRITE)  && (oe_nl == 'h0))
                dql_r_delayed <= #tCKHZ `DT_S'bz;  
             
        //-------------Driving data outputs in Read cycle-----------------//
             
        end else  
             
            // If read was performed in the last clock then drive the outputs 
            if (last_opernl_p2 == `READ) begin 

                // checks if oe is asserted.
                if (oe_nl == 1'b0)  begin

                    //Check if data has changed     
                    if (dql_r !== dql_p2) 
                    
                        //This loop drives data bitwise depending on byte enable
                        for (i= 0; i <= `DT_M; i = i+1)  
                            if (dql_p2[i] !== 1'bz) begin
                                dql_r_delayed[i] <= #tCKLZ `DT_S'bx;   // Low-z  simulation
                         
                                // Valid data is assigned  after tCD2 delay
                                dql_r_delayed[i] <= #tCD2  dql_p2[i]; 

                         
                            end else 
                                // if byte was not enabled for read, drive data to high-Z 
                                dql_r_delayed[i] <= #tCKHZ 'bz;  
                        //for loop ends here     
                    //checking of data change checked here  
                end  
            end else  if (reset_over_l == 1'b1)begin
                 // if last operation was not read, drive data to high-Z 
                 dql_r_delayed <= #tCKHZ `DT_S'bz;  
            end     

  end//always@(opl)                      

  always@(dql_r_delayed)
  if (oe_nl == 1'b0)
    dql_r = dql_r_delayed;
                        
  //************************ Right PORT OPERATION *****************************//
   always@(clkr or hold_violation_r  ) // changed for hold violation    
     begin

        if (clkr === 1'b0) begin
           flag_ar =  0;
        end
        if (clkr === 1'b1) begin

           if((chk_x_ce("ce0_nr", ce0_nr)| chk_x_ce("ce1_r", ce1_r)==0 ) && 
              (ce0_nr == 1'b0) && (ce1_r == 1'b1) ) begin        
               
              // Any operation is performed only after device is reset at 
              // least once.
              if (reset_over_r == 1'b1) begin     // Right Port clock Active
                   if (hold_violation_r !== 1'b1)            
                   setup_check_r;        
                  // data read on last clock is forwarded for output.
                  dqr_p2 = dqr_p1;      
                      
                  // address output forwarded  
                  ar_p2 = ar_p1;  
                      
                  // operation performed on last clock is forwarded.     
                  last_opernr_p2 = last_opernr_p1;
                      
                  // current operation is intialized to 'x'.
                  last_opernr_p1 = 1'bx;
                        
                  // X-Handling of input pins
                  x_detected_r = chk_x_r_w("r_w_nr", r_w_nr)|chk_x_b("b_nr", b_nr) ; 
                        
                  if (x_detected_r == 1'b0) begin  
                  
                      get_next_address_right;

                      if (no_operation_r_f == 1'b0) begin
                      //******** Read operation starts here ************************// 
                          if ((r_w_nr === 1) && (!r_w_hold_violation_r)) begin  
                              if (OmsgOn) $display("%t Right Port Read Operation", $realtime);
                              last_opernr_p1 = `READ;
                              read_buffer_r = read_data_and_tCCS_chk_fn(`RIGHT);
                              
                              // all data bits are initialized to 'z'.
                              dqr_p1 = `DT_S'hz;
                   
                              //**** this loop is performed for all  bytes of data*****//
                              for (i = 0; i < `BT_S; i = i+1)   
                                   if (b_nr[i] == 1'b0) begin
                                       j = `BYTE_SIZE*(i+1)-1; 
                                       k = `BYTE_SIZE*(i);    
                       
                                       // byte enable mask for current operation is stored.
                                       rdr_en_p1[i] = 1'b1;
                       
                                       // this loop assigns data read from memory to 
                                       // output buffer1 bit by bit 
                                       for ( n = k ; n <= j ; n = n+1) 
                                            dqr_p1[n] = read_buffer_r[n];
                                   end// if (b_nr[i] == 1'b0)                  
                                   //**** end of byte enable loop **********//
                                   if ((rsetup_violation_r === 1'b1)||(hold_violation_r === 1'b1))
                                       dqr_p1[n] = `DT_S'hx;

                                   // Mailbox interrupt Ack for right port    
                                   if (address_r == `LAST_ADR) mailintr_en = 1'b0; 
                   
                               //******** Read operation ends here ***********************//
           
                          end else if ((r_w_nr === 0) || (( r_w_hold_violation_r == 1'b1) && (r_w_nr == 1'b1)))
                               begin // changed for hold violation  
           
                               //******** write operation starts here**********************//
 
           
                               if(OmsgOn)$display("%t Right Port Write Operation",$realtime);
           
                               //Get data from location where new data has to be written.
                               //This ensures, data is written only to enabled bytes   
                               read_buffer_r = mem[address_r];
                   
                               //Get data from data bus
                               write_buffer_r= write_data_and_tCCS_chk_fn(`RIGHT);
                               last_opernr_p1 = `WRITE;
                   
                               // all bits are initialized to 'X'.
                               dqr_p1 = `DT_S'hx;
                               no_use = chk_x_dq("dqr", dqr);
                   
                               for (i = 0; i < `BT_S; i = i+1)   
                                   if (b_nr[i] === 1'b0) begin
                                       j = `BYTE_SIZE*(i+1)-1;  
                                       k = `BYTE_SIZE*(i);    
                                       for ( n = k ; n <= j ; n = n+1)
                                            read_buffer_r[n] = write_buffer_r[n];
                                   end 
                                   if ((rsetup_violation_r === 1'b1)||(hold_violation_r === 1'b1))
                                      if (addr_hold_violation_r)
                                          mem[ar_prev] = `DT_S'hx;
                                      else   
                                          mem[address_r] = `DT_S'hx;  
                                   else    
                                       mem[address_r] = read_buffer_r;
           
                               //Mailbox interrupt Generation for right port
                               if (address_r == `LAST_ADR-1 )mailintl_en = 1'b1; 
                          end // if (r_w_nr == 0)     
                          // Set Right port Mailbox interrupt pin from clk edge
                          if (mailintr_en == 1'b0) begin
                              int_nr <= #tSINT 1'b1;
                          end
                 
                          // Reset Right port Mailbox interrupt pin from clk edge
                          if (mailintl_en == 1'b1) begin
                              int_nl <= #tRINT 1'b0;
                          end
                      end// ( x_detected_r == 0)
                  end// no_operation_r_f          
                 
           end else if  ((reset_over_r == 0) &&( $realtime > tRSS + tRS + tRSR))begin
                 
               if (TmsgOn)$display ("%t Operating the device without performing Reset operation:",$realtime);
               if(TmsgOn) $display("\t\t Reset the device to function properly\n");
           end// (reset_over == 1'b0)   
           
            opr = ~opr;
         end// (ce enabled)         
          rsetup_violation_r = 1'b0;
          if (hold_violation_r == 1'b1) begin
              hold_violation_r = 1'b0;
              if (r_w_hold_violation_r == 1'b1) // changed for hold violation
                  r_w_hold_violation_r = 1'b0;
              if (addr_hold_violation_r == 1'b1)begin
                  addr_hold_violation_r = 1'b0;    
              end         
          end        
          
      end // clk==1         
   end// always@clkr    



   //******************** Driving outputs of right port ***********************//        
   always@(opr) begin
        
       
      //-------------Driving Address output  -----------------------//
      if (last_opernr_p2 == `COUNTERREADBACK) begin
           ar_r <= #tCKLZ `AD_S'bx;
           ar_r <= #tCA2   ar_p2;
        end else if (last_opernr_p2 == `MASKREADBACK) begin
           ar_r <= #tCKLZ `AD_S'bx;
           ar_r <= #tCM2  ar_p2;
        end else if (ar_r !== `AD_S'bz)begin    
           ar_r <= #tDC `AD_S'bx;
           ar_r <= #tCKHZ `AD_S'bz ;         
           flag_ar <= #(0.99 * tCKHZ) 1;
//           flag_ar <= #(tCKHZ) 0;
        end     
       
        if (cntint_nr_f == 1'b1) begin    
           if (cntint_nr !== 1'b0) begin
              cntint_nr <= #tRCINT    'b0; 
           end   
        end else if  (cntint_nr !== 1) begin
             cntint_nr <= #tSCINT    'b1; 
        end             
       


        //-------------Driving outputs in Write cycle---------------------//


        if (last_opernr_p1 == `WRITE) begin 
            if ((dqr_r  !== `DT_S'bz ) && (oe_nr == 0))
                if (tDC < tCKHZmin)
                    dqr_r_delayed <= #tCKHZmin `DT_S'bx; 
                    //drive data to high-Z 
                else
                    dqr_r_delayed <= #tDC `DT_S'bx;  
            // if last operation was not read, drive data to high-Z 
            if ((last_opernr_p2 == `WRITE)  && (oe_nr == 'h0))
               dqr_r_delayed <= #tCKHZ `DT_S'bz;  
        end else  
        //-------------Driving outputs in Read cycle---------------------// 
        // If read was performed in the last clock then drive the outputs 
            if  (last_opernr_p2 == `READ) begin
        
                if (oe_nr == 1'b0) begin
        
                    if (dqr_r !== dqr_p2 ) 
                        for (i= 0; i <= `DT_M; i = i+1) 
                              if (dqr_p2[i] !== 1'bz )begin
                                 dqr_r_delayed[i] <= #tCKLZ 'bx;   
                                 dqr_r_delayed[i] <= #tCD2  dqr_p2[i];
                             end else  
                                 dqr_r_delayed[i] <= #tCKHZ 'bz; 
                        //end for loop//
                    //end dq_r== //    
                end 
            //-----------------------------------------
            end // if (last_opernr_p2 == `READ)
            else if (reset_over_r == 1'b1) 
                dqr_r_delayed <= #tCKHZ `DT_S'bz;         
                
   end// always@(opr) 
       
   //--------------------------------------------------------------------------
           
   always@(dqr_r_delayed)
   if (oe_nr == 1'b0)
   dqr_r = dqr_r_delayed;
        
   always@(oe_nr)   begin
     if( (chk_x_ce("ce0_nr", ce0_nr)| chk_x_ce("ce1_r", ce1_r)==0 ) && 
       (ce0_nr == 1'b0) && (ce1_r == 1'b1) ) begin
       if ((chk_x_oe("oe_nr", oe_nr) == 1'b0) && (reset_over_r == 1'b1)) begin
          if  (oe_nr === 0) begin            // outputs from oe low event
             oer_pulse_chk_low = $realtime;
             
             if (OmsgOn) $display("%t Drive Right Port Data outputs from oe", 
                                 $realtime);
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
       end else //if ((chk_x_oe("oe_nr", oe_nr) == 1'b0) && (reset_over == 1'b1))
         dqr_r <=  `DT_S'hx;
     end// if ce is enabled    
   end // always@(oe_nr)  

   //--------------------------------------------------------------------------
   always@(oe_nl) begin
     if( (chk_x_ce("ce0_nl", ce0_nl)| chk_x_ce("ce1_l", ce1_l)==0 ) && 
           (ce0_nl == 1'b0) && (ce1_l == 1'b1) ) begin
       if ((reset_over_l == 1'b1) && (chk_x_oe("oe_nl", oe_nl) == 1'b0)) begin
         if  (oe_nl === 0) begin            // outputs from oe low event
            oel_pulse_chk_low = $realtime; // oe pulse width chek starts 
            
            if (OmsgOn) 
              $display("%t Drive Left Port Data outputs from oe", $realtime);
            // output  is driven only if latency time is over
            if (last_opernl_p2 == `READ) begin 

               for (i = 0;  i<= `DT_M;  i= i +1)
                 if (dql_p2[i] !== 1'bz  )begin
                    dql_r[i] <= #tOLZ 'hx; //Low-Z timing
                    // valid data is driven after tOE
                    dql_r[i] <= #tOE  dql_p2[i]; 
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
    end// ce enabled  
      
  end // always(oe_nl)




endmodule //  cyd01s18v

//==================================End OF File================================//                    



















