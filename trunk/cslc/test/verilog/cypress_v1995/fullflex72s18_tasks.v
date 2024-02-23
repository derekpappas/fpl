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
// File           : fullflex72s18_tasks.v
// Author         : 
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
// This file contain the tasks used for the timing checks to all the
// input pins of the model 
//
// *******************************************************************

//----------------------------------------------------------------------
// task:        pv_reset
// Description: Resets all the previous value variables to zero
//----------------------------------------------------------------------
task pv_reset;
   begin
      inmrst_pv         = 1'b0;
      iright_pv_ftsel   = 1'b0;
      iright_pv_ddron   = 1'b0;
      iright_pv_cqen    = 1'b0;
      iright_pv_portstd = 2'b00;
      ioright_pv_dq     = 1'b0;
      inright_pv_be     = 1'b0;
      inright_pv_ce0    = 1'b0;
      iright_pv_ce1     = 1'b0;
      inright_pv_oe     = 1'b0;
      iright_pv_zq      = 2'b00;
      inright_pv_rw     = 1'b0;

      //Address access logic
      ioright_pv_a      = 1'b0;
      iright_pv_cntmsk  = 1'b0;
      iright_pv_ads     = 1'b0;
      iright_pv_cnten   = 1'b0;
      iright_pv_cntrst  = 1'b0;
      iright_pv_ret     = 1'b0;
      iright_pv_clk     = 1'b0;
      iright_pv_clk_n   = 1'b0;
      inright_pv_wrp    = 1'b0;
      inright_pv_lowspd = 1'b0;
      ileft_pv_ftsel    = 1'b0;
      ileft_pv_ddron    = 1'b0;
      ileft_pv_cqen     = 1'b0;
      ileft_pv_portstd  = 2'b00;

      // I/O control logic
      ioleft_pv_dq      = 1'b0;
      inleft_pv_be      = 1'b0;
      inleft_pv_ce0     = 1'b0;
      ileft_pv_ce1      = 1'b0;
      inleft_pv_oe      = 1'b0;
      ileft_pv_zq       = 2'b00;
      inleft_pv_rw      = 1'b0;

      //Address access logic
      ioleft_pv_a       = 1'b0;
      ileft_pv_cntmsk   = 1'b0;
      ileft_pv_ads      = 1'b0;
      ileft_pv_cnten    = 1'b0;
      ileft_pv_cntrst   = 1'b0;
      ileft_pv_ret      = 1'b0;
      ileft_pv_clk      = 1'b0;
      ileft_pv_clk_n    = 1'b0;
      inleft_pv_wrp     = 1'b0;
      inleft_pv_lowspd  = 1'b0;
   end
endtask // pv_reset


//----------------------------------------------------------------
// task:        event_reset
// Description: Resets all the event variables to zero
//----------------------------------------------------------------
task event_reset;
   begin
      inmrst_event         = 1'b0;
      iright_event_ftsel   = 1'b0;
      iright_event_ddron   = 1'b0;
      iright_event_cqen    = 1'b0;
      iright_event_portstd = 1'b0;
      ioright_event_dq     = 1'b0;
      inright_event_be     = 1'b0;
      inright_event_ce0    = 1'b0;
      iright_event_ce1     = 1'b0;
      inright_event_oe     = 1'b0;
      iright_event_zq      = 1'b0;
      inright_event_rw     = 1'b0;
                  
      //Address access logic
      iright_event_cntmsk  = 1'b0;
      iright_event_ads     = 1'b0;
      iright_event_cnten   = 1'b0;
      iright_event_cntrst  = 1'b0;
      iright_event_ret     = 1'b0;
      iright_event_clk     = 1'b0;
      iright_event_clk_n   = 1'b0;
      inright_event_wrp    = 1'b0;
      inright_event_lowspd = 1'b0;
      ileft_event_ftsel    = 1'b0;
      ileft_event_ddron    = 1'b0;
      ileft_event_cqen     = 1'b0;
      ileft_event_portstd  = 1'b0;
                  
      // I/O control logic              
      ioleft_event_dq      = 1'b0;
      inleft_event_be      = 1'b0;
      inleft_event_ce0     = 1'b0;
      ileft_event_ce1      = 1'b0;
      inleft_event_oe      = 1'b0;
      ileft_event_zq       = 1'b0;
      inleft_event_rw      = 1'b0;
                  
      //Address access logic         
      ileft_event_cntmsk   = 1'b0;
      ileft_event_ads      = 1'b0;
      ileft_event_cnten    = 1'b0;
      ileft_event_cntrst   = 1'b0;
      ileft_event_ret      = 1'b0;
      ileft_event_clk      = 1'b0;
      ileft_event_clk_n    = 1'b0;
      inleft_event_wrp     = 1'b0;
      inleft_event_lowspd  = 1'b0;
   end
endtask // event_reset

//-------------------------------------------------------------------
// task:        event_chk
// Description: Checks whether the event has occurred or not 
// on all the input pins
//-------------------------------------------------------------------

task event_chk;
   begin
      inmrst_event         = (inmrst_pv         !== inmrst);
      iright_event_ftsel   = (iright_pv_ftsel   !== iright_ftsel);
      iright_event_ddron   = (iright_pv_ddron   !== iright_ddron);
      iright_event_cqen    = (iright_pv_cqen    !== iright_cqen);
      iright_event_portstd = (iright_pv_portstd !== iright_portstd);
      ioright_event_dq     = (ioright_pv_dq     !== ioright_dq);
      inright_event_be     = (inright_pv_be     !== inright_be);
      inright_event_ce0    = (inright_pv_ce0    !== inright_ce0);
      iright_event_ce1     = (iright_pv_ce1     !== iright_ce1);
      inright_event_oe     = (inright_pv_oe     !== inright_oe);
      iright_event_zq      = (iright_pv_zq      !== iright_zq);
      inright_event_rw     = (inright_pv_rw     !== inright_rw);
                  
      //Address access logic
      iright_event_cntmsk  = (iright_pv_cntmsk  !== iright_cntmsk);
      iright_event_ads     = (iright_pv_ads     !== iright_ads);
      iright_event_cnten   = (iright_pv_cnten   !== iright_cnten);
      iright_event_cntrst  = (iright_pv_cntrst  !== iright_cntrst);
      iright_event_ret     = (iright_pv_ret     !== iright_ret);
      iright_event_clk     = (iright_pv_clk     !== iright_clk);
      iright_event_clk_n   = (iright_pv_clk_n   !== iright_clk_n);
      inright_event_wrp    = (inright_pv_wrp    !== inright_wrp);
      inright_event_lowspd = (inright_pv_lowspd !== inright_lowspd);
      ileft_event_ftsel    = (ileft_pv_ftsel    !== ileft_ftsel);
      ileft_event_ddron    = (ileft_pv_ddron    !== ileft_ddron);
      ileft_event_cqen     = (ileft_pv_cqen     !== ileft_cqen);
      ileft_event_portstd  = (ileft_pv_portstd  !== ileft_portstd);
                 
      // I/O control logic
      ioleft_event_dq      = (ioleft_pv_dq      !== ioleft_dq);
      inleft_event_be      = (inleft_pv_be      !== inleft_be);
      inleft_event_ce0     = (inleft_pv_ce0     !== inleft_ce0);
      ileft_event_ce1      = (ileft_pv_ce1      !== ileft_ce1);
      inleft_event_oe      = (inleft_pv_oe      !== inleft_oe);
      ileft_event_zq       = (ileft_pv_zq       !== ileft_zq);
      inleft_event_rw      = (inleft_pv_rw      !== inleft_rw);
                  
      //Address access logic
      ileft_event_cntmsk   = (ileft_pv_cntmsk   !== ileft_cntmsk);
      ileft_event_ads      = (ileft_pv_ads      !== ileft_ads);
      ileft_event_cnten    = (ileft_pv_cnten    !== ileft_cnten);
      ileft_event_cntrst   = (ileft_pv_cntrst   !== ileft_cntrst);
      ileft_event_ret      = (ileft_pv_ret      !== ileft_ret);
      ileft_event_clk      = (ileft_pv_clk      !== ileft_clk);
      ileft_event_clk_n    = (ileft_pv_clk_n    !== ileft_clk_n);
      inleft_event_wrp     = (inleft_pv_wrp     !== inleft_wrp);
      inleft_event_lowspd  = (inleft_pv_lowspd  !== inleft_lowspd);
                  
      if(((ioright_pv_a !==ioright_a) && (~ADRACC_R.readback))) 
      	        ->ioright_event_a;
      if((ioleft_pv_a !==ioleft_a) && (~ADRACC_L.readback)) 
                  ->ioleft_event_a;
   end
endtask // event_chk


//------------------------------------------------------------------------------
// task:        pv_assign
// Description: Assign the current values of all the pins to their respective
//              previous value variables
//------------------------------------------------------------------------------

task pv_assign;
   begin

      inmrst_pv         = inmrst;
      iright_pv_ftsel   = iright_ftsel;
      iright_pv_ddron   = iright_ddron;
      iright_pv_cqen    = iright_cqen;
      iright_pv_portstd = iright_portstd;
      ioright_pv_dq     = ioright_dq;
      inright_pv_be     = inright_be;
      inright_pv_ce0    = inright_ce0;
      iright_pv_ce1     = iright_ce1;
      inright_pv_oe     = inright_oe;
      iright_pv_zq      = iright_zq;
      inright_pv_rw     = inright_rw;
                  
      //Address access logic
      ioright_pv_a      = ioright_a;
      iright_pv_cntmsk  = iright_cntmsk;
      iright_pv_ads     = iright_ads;
      iright_pv_cnten   = iright_cnten;
      iright_pv_cntrst  = iright_cntrst;
      iright_pv_ret     = iright_ret;
      iright_pv_clk     = iright_clk;
      iright_pv_clk_n   = iright_clk_n;
      inright_pv_wrp    = inright_wrp;
      inright_pv_lowspd = inright_lowspd;
      ileft_pv_ftsel    = ileft_ftsel;
      ileft_pv_ddron    = ileft_ddron;
      ileft_pv_cqen     = ileft_cqen;
      ileft_pv_portstd  = ileft_portstd;
                  
      // I/O control logic
      ioleft_pv_dq      = ioleft_dq;
      inleft_pv_be      = inleft_be;
      inleft_pv_ce0     = inleft_ce0;
      ileft_pv_ce1      = ileft_ce1;
      inleft_pv_oe      = inleft_oe;
      ileft_pv_zq       = ileft_zq;
      inleft_pv_rw      = inleft_rw;
                  
      //Address access logic
      ioleft_pv_a       = ioleft_a;
      ileft_pv_cntmsk   = ileft_cntmsk;
      ileft_pv_ads      = ileft_ads;
      ileft_pv_cnten    = ileft_cnten;
	ileft_pv_cntrst = ileft_cntrst;
      ileft_pv_ret      = ileft_ret;
      ileft_pv_clk      = ileft_clk;
      ileft_pv_clk_n    = ileft_clk_n;
      inleft_pv_wrp     = inleft_wrp;
      inleft_pv_lowspd  = inleft_lowspd;
   end
endtask // pv_assign


//----------------------------------------------------------------------
// task:        timing_chk
// Description: Checks setup and hold violations for the input pins
//-----------------------------------------------------------------------

task timing_chk;
  begin

    //------------------------------------------------------------
    //Setup timing checks for left port
    //------------------------------------------------------------

    // Timing checks at left clock rising edge
    if (ileft_event_clk && (ileft_clk == 1'b1)) 
    begin      

      // Address setup time check
      if (((rising_edge_clk_l - addr_last_change_l) < 0.99 * TP.tSAC_l )) 
      begin
	 if(wmsg == 1'b1)
	   $display ("%t WARNING: A_L to CLK_L Setup-time -tSAC violation",$realtime);
         no_grnt_msg;
      end
	    
      // cntmsk set time check
      if (((rising_edge_clk_l - cntmsk_last_change_l) < 0.99 * TP.tSAC_l )) 
      begin
	if(wmsg == 1'b1)
	  $display ("%t WARNING: CNTMSK_L to CLK_L Setup time -tSAC violation",$realtime);
        no_grnt_msg;
      end
      
      // ret setup time check
      if (((rising_edge_clk_l - ret_last_change_l) < 0.99 * TP.tSAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : RET_L to CLK_L Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
     
      // cntrst setup time check
      if (((rising_edge_clk_l - cntrst_last_change_l) < 0.99 * TP.tSAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING :CNTRST_L to CLK_L Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
  
      // wrp setup time check
      if (((rising_edge_clk_l - wrp_last_change_l) < 0.99 * TP.tSAC_l ))
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : WRP_L to CLK_L Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
    
      // cnten setup time check
      if (((rising_edge_clk_l - cnten_last_change_l) < 0.99 * TP.tSAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING :CNTEN_L to CLK_L Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
      // ads setup time check
      if (((rising_edge_clk_l - ads_sel_last_change_l) < 0.99 * TP.tSAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : ADS_L to CLK_L Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end

      // Byte select setup time
      if (((rising_edge_clk_l - byte_sel_last_change_l) <0.99 * TP.tSBE_l ))
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : BE_L to CLK_L Setup time -tSBE violation",$realtime);
         no_grnt_msg;
      end
      
      // R/W Setup time
      if (((rising_edge_clk_l - rw_last_change_l) < 0.99 * TP.tSAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : R/W_L to CLK_L Setup time -tSAC violation", $realtime);
         no_grnt_msg;
      end

      // Input Data setup time
      if (((rising_edge_clk_l - dq_last_change_l) < 0.99 * TP.tSD_l ) && (inleft_rw == 0)) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : DQ_L to CLK_L Setup time -tSD violation.", $realtime);
         no_grnt_msg;
      end

    end // if (ileft_event_clk && ileft_clk == 1'b1)


    //--------------------------------------------------------------------
    // Setup timing checks for Right port
    //--------------------------------------------------------------------

    if (iright_event_clk && (iright_clk == 1'b1) && onright_ready==1'b0) 
    begin
    
      if (((rising_edge_clk_r - addr_last_change_r) < 0.99 * TP.tSAC_r)) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : A_R to CLK_R Setup time -tSAC violation",$realtime); 
         no_grnt_msg;
      end

      // cntmsk set time check
      if (((rising_edge_clk_r - cntmsk_last_change_r) < 0.99 * TP.tSAC_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("\n %t WARNING: CNTMSK_R to CLK_R Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
      
      // ret setup time check
      if (((rising_edge_clk_r - ret_last_change_r) < 0.99 * TP.tSAC_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("\n %t WARNING : RET_R to CLK_R Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
      
      // cntrst setup time check
      if (((rising_edge_clk_r - cntrst_last_change_r) < 0.99 * TP.tSAC_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("\n %t WARNING :CNTRST_R to CLK_R Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
     
      // wrp setup time check
      if (((rising_edge_clk_r - wrp_last_change_r) < 0.99 * TP.tSAC_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("\n %t WARNING : WRP_R to CLK_R Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
     
      // cnten setup time check
      if (((rising_edge_clk_r - cnten_last_change_r) < 0.99 * TP.tSAC_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("\n %t WARNING :CNTEN_R to CLK_R Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end
      
      // ads setup time check
      if (((rising_edge_clk_r - ads_sel_last_change_r) < 0.99 * TP.tSAC_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("\n %t WARNING : ADS_R to CLK_R Setup time -tSAC violation",$realtime);
         no_grnt_msg;
      end

      // Byte select setup time
      if (((rising_edge_clk_r - byte_sel_last_change_r) <0.99 * TP.tSBE_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : BE_R to CLK_R Setup time -tSBE violation",$realtime);
         no_grnt_msg;
      end

      // R/W Setup time
      if (((rising_edge_clk_r - rw_last_change_r) < 0.99 * TP.tSAC_r )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : R/W_R to CLK_R Setup time -tSAC violation", $realtime);
         no_grnt_msg;
      end

      // Input Data setup time
      if (((rising_edge_clk_r - dq_last_change_r) < 0.99 * TP.tSD_r ) && (inright_rw == 0)) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : DQ_R to CLK_R Setup time -tSD violation.", $realtime);
         no_grnt_msg;
      end
    end // if (iright_event_clk && (iright_clk == 1'b1))


    //---------------------------------------------
    // Hold violation checks
    //---------------------------------------------

    //----------------------------------------------
    // HOLD Time violation checks for left port
    //----------------------------------------------

    // cntmsk hold time
    if (ileft_event_cntmsk) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING:CLK_L to CNTMSK_L Hold time -tHAC violation.", $realtime);
        no_grnt_msg;
      end
      cntmsk_last_change_l= $realtime;
    end

    // ret hold time
    if (ileft_event_ret) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING:CLK_L to RET_L Hold time -tHAC violation.", $realtime);
         no_grnt_msg;
      end
      ret_last_change_l = $realtime;
    end
    
    //  cntrst hold time
    if (ileft_event_cntrst) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING:CLK_L to CNTRST_L Hold time -tHAC violation.", $realtime);
         no_grnt_msg;
      end
      cntrst_last_change_l = $realtime;
    end
    
    //  wrp hold time
    if (inleft_event_wrp) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING:CLK_L to WRP_L Hold time -tHAC violation.", $realtime);
         no_grnt_msg;
      end
      wrp_last_change_l = $realtime;
    end
    
    //  cnten hold time
    if (ileft_event_cnten) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING:CLK_L to CNTEN_L Hold time -tHAC violation.", $realtime);
         no_grnt_msg;
      end
      cnten_last_change_l = $realtime;
    end
    
    // ads hold time
    if (ileft_event_ads) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING:CLK_L to ADS_L Hold time -tHAC violation.", $realtime);
         no_grnt_msg;
      end
      ads_sel_last_change_l = $realtime;
    end
    
    // Byte select hold time
    if (inleft_event_be) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHBE_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : CLK_L to BE_L Hold time -tHBE violation.", $realtime);
         no_grnt_msg;
      end
      byte_sel_last_change_l = $realtime;
    end

    // R/W Hold time
    if (inleft_event_rw) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHAC_l )) 
      begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : CLK_L to R/W_L Hold time -tHAC violation", $realtime);
         no_grnt_msg;
      end
      rw_last_change_l = $realtime;
    end

    // Input Data hold time
    if (ioleft_event_dq) 
    begin
      if ((($realtime - rising_edge_clk_l) < 0.99 * TP.tHD_l ) && (inleft_rw == 0)) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING : CLK_L to DQ_L Hold time -tHD violation",$realtime);
        no_grnt_msg;
      end
      dq_last_change_l = $realtime;
    end

    //-----------------------------------------------
    // HOLD Time violation checks for right port
    //-----------------------------------------------

    // cntmsk hold time
    if (iright_event_cntmsk) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING:CLK_R to CNTMSK_R Hold time -tHAC violation.", $realtime);
        no_grnt_msg;
      end
      cntmsk_last_change_r= $realtime;
    end
    
    // ret hold time
    if (iright_event_ret) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING:CLK_R to RET_R Hold time -tHAC violation.", $realtime);
        no_grnt_msg;
      end
      ret_last_change_r = $realtime;
    end
    
    //  cntrst hold time
    if (iright_event_cntrst) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING:CLK_R to CNTRST_R Hold time -tHAC violation.", $realtime);
        no_grnt_msg;
      end
      cntrst_last_change_r = $realtime;
    end
    
    //  wrp hold time
    if (inright_event_wrp) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING:CLK_R to WRP_R Hold time -tHAC violation.", $realtime);
        no_grnt_msg;
      end
      wrp_last_change_r = $realtime;
    end
    
    //  cnten hold time
    if (iright_event_cnten) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING:CLK_R to CNTEN_R Hold time -tHAC violation.", $realtime);
        no_grnt_msg;
      end
      cnten_last_change_r = $realtime;
    end
    
    // ads hold time
    if (iright_event_ads) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING:CLK_R to ADS_R Hold time -tHAC violation.", $realtime);
        no_grnt_msg;
      end
      ads_sel_last_change_r = $realtime;
    end

    // Byte select hold time
    if (inright_event_be) 
    begin
       if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHBE_r )) 
       begin
         if(wmsg == 1'b1)
	   $display ("%t WARNING : CLK_R to BE_R Hold time -tHBE violation.", $realtime);
         no_grnt_msg;
       end
       byte_sel_last_change_r = $realtime;
    end

    // R/W Hold time
    if (inright_event_rw) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHAC_r )) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING : CLK_R to R/W_R Hold time -tHAC violation", $realtime);
        no_grnt_msg;
      end
      rw_last_change_r = $realtime;
    end

    // Input Data hold time
    if (ioright_event_dq) 
    begin
      if ((($realtime - rising_edge_clk_r) < 0.99 * TP.tHD_r ) && (inright_rw == 0)) 
      begin
        if(wmsg == 1'b1)
	  $display ("%t WARNING : CLK_R to DQ_R Hold time -tHD violation",$realtime);
        no_grnt_msg;
      end
      dq_last_change_r = $realtime;
    end

  end
endtask // timing_chk


// This task will display the message "Device
// operation not predictable"
task no_grnt_msg;
   if(wmsg == 1'b1)
     $display (" Device operation not predictable");
endtask // no_grnt_msg

