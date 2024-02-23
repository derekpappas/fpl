
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
// File           : fullflex72s18_timing.v
// Author         :
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description : This file defines all the timing parameters
//               of the device 
//
// *******************************************************************


module fullflex72s18_timing(inmsg         ,
		        iwmsg         ,
		        iemsg         ,
		        ileft_ddron   ,
                        ileft_ftsel   ,
			inleft_lowspd ,
                        iright_ddron  ,
                        iright_ftsel  ,
			inright_lowspd,
                        inreset       ,
		        ileft_clk     ,
		        iright_clk
		       );

   // Selectable parameters
   parameter             CYP_ISFREQ250 = 1;
   parameter             CYP_ISFREQ200 = 0;
   parameter             CYP_ISFREQ167 = 0;
   parameter             CYP_ISFREQ133 = 0;
   parameter             CYP_ISFREQ100 = 0;
   parameter             CYP_ISFREQ83  = 0;
   parameter             CYP_ISMINDEL  = 1;
   parameter             CYP_ISMAXDEL  = 0; 

   input inmsg;              // NOTE message ON input
   input iwmsg;              // WARNING message ON input
   input iemsg;              // ERROR message ON input
   input ileft_ddron;        // Left port ddron, 1 is DDR ; '0' is SDR
   input ileft_ftsel;        // Left FLOW-THROUGH mode select
   input inleft_lowspd;      // Left Port low speed select
   input iright_ddron;       // Left port ddron, 1 is DDR ; '0' is SDR
   input iright_ftsel;       // Right FLOW-THROUGH mode select
   input inright_lowspd;     // Right Port low speed select
   input inreset;            // Master rest signal
   input ileft_clk;          // Left clock
   input iright_clk;         // Right clock

   realtime    tCKD_min_l;   // Minimum C clock duty cycle 
   realtime    tCKD_max_l;   // Maximum C clock duty cycle
   realtime    tSBE_l;       // Byte enable Setup Time to C/C# Rise 
   realtime    tHBE_l;       // Byte enable Hold Time after C/C# Rise
   realtime    tCH_l;        // C/C# Clock HIGH Time
   realtime    tCL_l;        // C/C# Clock LOW Time
   realtime    tCHCH_l;      // C/C# Clock Rise to C#/C Clock Rise
   realtime    tSD_l;        // Data Input Setup Time to C/C# Rise
   realtime    tHD_l;        // Data Input Hold Time after C/C# Rise
   realtime    tSAC_l;       // Address & Control Input except BE# Setup Time
   realtime    tHAC_l;       // Address & Control Input except BE# Hold Time 
   realtime    tOLZ_l;       // OE to Low Z
   realtime    tOHZ_l;       // OE to High Z
   realtime    tCD_l;        // C/C# rise to DQ Valid
   realtime    tDC_l;        // DQ Output Hold After C/C# rise
   realtime    tCCQ_min_l;   // Minimum C/C# rise to CQ/CQ# rise
   realtime    tCCQ_max_l;   // Maximum C/C# rise to CQ/CQ# rise
   realtime    tCKHZ_l;      // C/C# rise to DQ output High Z
   realtime    tCKLZ_l;      // C/C# rise to DQ output Low Z
   realtime    tCA_l;        // C Rise to Address Readback valid
   realtime    tAC_l;        // Address output hold after C rise
   realtime    tCKHZA_l;     // C Rise to Address Output High Z
   realtime    tCKLZA_l;     // C Rise to Address Output Low  Z
   realtime    tSCINT_l;     // C rise to CNTINT low
   realtime    tRCINT_l;     // C rise to CNTINT high
   realtime    tSINT_l;      // C rise to INT low
   realtime    tRINT_l;      // C rise to INT high
   realtime    tBSY_l;       // C rise to BUSY# valid
   realtime    tOE_l;        // Output enable to data valid
   realtime    tCQHQV_l;     // Echo clock high to output valid
   realtime    tCQHQX_l;     // Echo clock high to output hold


   realtime    tCKD_min_r;   // Minimum C clock duty cycle 
   realtime    tCKD_max_r;   // Minimum C clock duty cycle
   realtime    tSBE_r;       // Byte enable Setup Time to C/C# Rise 
   realtime    tHBE_r;       // Byte enable Hold Time after C/C# Rise
   realtime    tCH_r;        // C/C# Clock HIGH Time
   realtime    tCL_r;        // C/C# Clock LOW Time
   realtime    tCHCH_r;      // C/C# Clock Rise to C#/C Clock Rise
   realtime    tSD_r;        // Data Input Setup Time to C/C# Rise
   realtime    tHD_r;        // Data Input Hold Time after C/C# Rise
   realtime    tSAC_r;       // Address & Control Input except BE# Setup Time 
   realtime    tHAC_r;       // Address & Control Input except BE# Hold Time ise
   realtime    tOLZ_r;       // OE to Low Z
   realtime    tOHZ_r;       // OE to High Z
   realtime    tCD_r;        // C/C# rise to DQ Valid
   realtime    tDC_r;        // DQ Output Hold After C/C# rise
   realtime    tCCQ_min_r;   // Minimum C/C# rise to CQ/CQ# rise
   realtime    tCCQ_max_r;   // Maximum C/C# rise to CQ/CQ# rise
   realtime    tCKHZ_r;      // C/C# rise to DQ output High Z
   realtime    tCKLZ_r;      // C/C# rise to DQ output Low Z
   realtime    tCA_r;        // C Rise to Address Readback valid
   realtime    tAC_r;        // Address output hold after C rise
   realtime    tCKHZA_r;     // C Rise to Address Output High Z
   realtime    tCKLZA_r;     // C Rise to Address Output Low Z
   realtime    tSCINT_r;     // C rise to CNTINT low
   realtime    tRCINT_r;     // C rise to CNTINT high
   realtime    tSINT_r;      // C rise to INT low
   realtime    tRINT_r;      // C rise to INT high
   realtime    tBSY_r;       // C rise to BUSY# valid
   realtime    tOE_r;        // Output enable to data valid
   realtime    tCQHQV_r;     // Echo clock high to output valid
   realtime    tCQHQX_r;     // Echo clock high to output hold
   realtime    tRS;          // Master reset pulse width
   realtime    tCYC_min;     // Minimum C clock cycle time
   realtime    tCYC_FT_min;  // Minimum C clock cycle time for Flow-through
   realtime    tPS;          // C rise to opposite port C rise set-up time
                             // for port BUSY flag generation for 
                             // write-write operation

   integer    tLOWLOCKTIME;
   integer    tHIGHLOCKTIME;
   realtime   clock_period_l;
   realtime   clock_period_r;
   realtime   clock_period_reset_l;
   realtime   clock_period_reset_r;
   realtime   left_clk_event_time;
   realtime   right_clk_event_time;
   reg        left_period_in_range;
   reg        right_period_in_range;
   integer    out_freq_count_l;
   integer    out_freq_count_r;
   reg        first_reset_complete;

   // Variable initialization
   initial
   begin
      clock_period_l        = 10;
      clock_period_r        = 10;
      left_clk_event_time   = 0;
      right_clk_event_time  = 0;
      left_period_in_range  = 1'b1;
      right_period_in_range = 1'b1;
      tCYC_FT_min           = 15.0;
      tCYC_min              = 5.0;
      out_freq_count_l      = 0;
      out_freq_count_r      = 0;
      first_reset_complete  = 1'b0;
   end

   // Left Clock Period Calculation
   always @(ileft_clk)
   begin
      clock_period_l = 2*($realtime - left_clk_event_time);
      left_clk_event_time = $realtime;

      if((first_reset_complete == 1'b1) && (inreset == 1'b1) &&
	 (clock_period_reset_l < 0.95 * clock_period_l ||
	  clock_period_reset_l > 1.05 * clock_period_l)
	)
      begin
        out_freq_count_l = out_freq_count_l + 1;
	if(out_freq_count_l == 15)
	begin
          if(iwmsg == 1'b1)
	  begin
	    $display($realtime, " WARNING: Left clock frequency changed after reset operation"); 
          end
	  out_freq_count_l = 0;
	end
      end
      else
      begin
        out_freq_count_l    = 0;
      end
   end

   // Right Clock Period Calculation
   always @(iright_clk)
   begin
      clock_period_r = 2*($realtime - right_clk_event_time);
      right_clk_event_time = $realtime;

      if((first_reset_complete == 1'b1) && (inreset == 1'b1) &&
	 (clock_period_reset_r < 0.98 * clock_period_r ||
	  clock_period_reset_r > 1.02 * clock_period_r)
	)
      begin
        out_freq_count_r = out_freq_count_r + 1;
	if(out_freq_count_r == 15)
	begin
          if(iwmsg == 1'b1)
	  begin
	    $display($realtime," WARNING: Right clock frequency changed after reset operation"); 
          end
	  out_freq_count_r = 0;
	end
      end
      else
      begin
        out_freq_count_r = 0;
      end
   end

   // First reset operation flag update
   always @(inreset)
   begin
      if($realtime > 1)
         first_reset_complete = 1'b1;
   end

   // Reset Pulse width Calculation
   always @(inreset    /* or ileft_ddron  or 
            ileft_ftsel or iright_ddron or 
	    iright_ftsel*/)
   begin

   if($realtime > 0)
   begin
    // Wait until clock period is updated
    if((ileft_ddron  == 1'b0 && ileft_ftsel  == 1'b0) ||
       (iright_ddron == 1'b0 && iright_ftsel == 1'b0))
    begin
      #30;
    end
    else
    begin
      #15;
    end
      
    #10; 
    // Checking Left clock period is in range
    if(ileft_ddron == 1'b1)
    begin

      if(CYP_ISFREQ167 ) begin     // 167 Mhz freq bin
        if(clock_period_l >= 6)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ200) begin
	if(clock_period_l >= 5)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ133) begin
	if(clock_period_l >= 7.5)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else  // 250 Mhz freq bin
      begin
	if(clock_period_l >= 4)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
    end else if(ileft_ftsel == 1'b1) 
    begin
      if(CYP_ISFREQ167 ) begin     // 167 Mhz freq bin
        if(clock_period_l >= 6)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ200) begin
	if(clock_period_l >= 5)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ133) begin
	if(clock_period_l >= 7.5)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else  // 250 Mhz freq bin
      begin
	if(clock_period_l >= 4)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
    end else
    begin
      if(CYP_ISFREQ167 ) begin     // 167 Mhz freq bin
        if(clock_period_l >= 15)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ200) begin
	if(clock_period_l >= 13)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ133) begin
	if(clock_period_l >= 18)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
      else  // 250 Mhz freq bin
      begin
	if(clock_period_l >= 10)
		left_period_in_range = 1'b1;
	else    left_period_in_range = 1'b0;
      end
    end
    clock_period_reset_l = clock_period_l;

    // Checking Right clock period is in range
    if(iright_ddron == 1'b1)
    begin

      if(CYP_ISFREQ167 ) begin     // 167 Mhz freq bin
        if(clock_period_r >= 6)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ133) begin // 133 Mhz freq bin
	if(clock_period_l >= 7.5)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ200) begin
	if(clock_period_r >= 5)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else  // 250 Mhz freq bin
      begin
	if(clock_period_r >= 4)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
    end else if(iright_ftsel == 1'b1)
    begin
      if(CYP_ISFREQ167 ) begin     // 167 Mhz freq bin
        if(clock_period_r >= 6)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ200) begin
	if(clock_period_r >= 5)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ133) begin
	if(clock_period_r >= 7.5)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else  // 250 Mhz freq bin
      begin
	if(clock_period_r >= 4)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
    end else
    begin
      if(CYP_ISFREQ167) begin     // 167 Mhz freq bin
        if(clock_period_r >= 15)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ200) begin
	if(clock_period_r >= 13)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else if(CYP_ISFREQ133) begin
	if(clock_period_r >= 18)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
      else  // 250 Mhz freq bin
      begin
	if(clock_period_r >= 10)
		right_period_in_range = 1'b1;
	else    right_period_in_range = 1'b0;
      end
    end
    clock_period_reset_r = clock_period_r;

    // Reset pulse width assignment
    if($realtime > 0)
    begin
     case ({left_period_in_range, right_period_in_range})
      2'b11:
      begin
       if(clock_period_l > clock_period_r) tRS = 5* clock_period_l;
       else tRS = 5* clock_period_r;
      end
      2'b10:
      begin 
        if(inreset == 1'b1)
	   if(iemsg == 1'b1)
	     $display($realtime, " ERROR: Right clock frequency out of range");
	tRS = 5* clock_period_l;
	// $finish;
      end
      2'b01:
      begin 
        if(inreset == 1'b1)
	   if(iemsg == 1'b1)
	     $display($realtime, " ERROR: Left clock frequency out of range");
	tRS = 5* clock_period_r;
	// $finish;
      end
      2'b00:
      begin 
        if(inreset == 1'b1)
	   if(iemsg == 1'b1)
	     $display($realtime, " ERROR: Left and Righ clock frequencies are out of range");
	tRS = 20;  // Minimum clock period (4) * 5
	// $finish;
      end
     endcase
    end
   end
  end

  // Common timing parameters.
  always @(inreset        or 
	   ileft_ddron    or             
	   ileft_ftsel    or
	   inleft_lowspd  or
           iright_ddron   or
           iright_ftsel   or
           inright_lowspd)
  begin 

    tLOWLOCKTIME  = 5;     // 5 cycles 
    tHIGHLOCKTIME = 1024;  // 1024 cycles

    if(CYP_ISFREQ167) begin     // 167 Mhz freq bin
      tCYC_min    = 6.0;
      tCYC_FT_min = 15.0;
      tPS         = 0.0;
    end
    else if(CYP_ISFREQ200) begin
      tCYC_min    = 5.0;
      tCYC_FT_min = 13.0;
      tPS         = 0.0;
    end
    else if(CYP_ISFREQ133) begin
      tCYC_min    = 7.50;
      tCYC_FT_min = 18.0;
      tPS         = 0.0;
    end
    else if(CYP_ISFREQ100) begin
      tCYC_min    = 10.0;
      tCYC_FT_min = 10.0;
      tPS         = 0.0;
    end
    else
    begin
      tCYC_min = 4.0;
      tPS      = 0.0;
    end

  end 


  //TIMING PARAMETERS FOR THE LEFT PORT
  always @(inreset or ileft_ddron or ileft_ftsel)
  begin 
    case (ileft_ddron)  
      1'b1:     // DDR mode   
      begin 
        if(CYP_ISFREQ167 && inleft_lowspd == 1'b1) 
	begin                                     // 167 Mhz freq bin
             tCH_l     = 2.40;
             tCL_l     = 2.40;
             tCHCH_l   = 2.70;
             tSD_l     = 0.50;
             tHD_l     = 0.50;
             tSBE_l    = 0.50;
             tHBE_l    = 0.50;
             tSAC_l    = 1.70;
             tHAC_l    = 0.50;
             tOE_l     = 5.00;
             tOLZ_l    = 1.00;
             tOHZ_l    = 5.00;
             tCD_l     = 0.50;
             tDC_l     = 0.50; // negative
             tCCQ_min_l= 0.50; // negative
	     tCCQ_max_l= 0.50;
             tCQHQV_l  = 0.40;
             tCQHQX_l  = 0.40; // negative
             tCKHZ_l   = 0.50;
             tCKLZ_l   = 0.50;
             tCA_l     = 5.90;
             tAC_l     = 1.00;
             tCKHZA_l  = 5.90;
             tCKLZA_l  = 1.00;
             tSCINT_l  = 4.00;
             tRCINT_l  = 1.00;
             tSINT_r   = (5.90 + clock_period_l/2.0); // minimum clock period
             tRINT_l   = (5.90 + clock_period_l/2.0); // minimum clock period
             tBSY_l    = 4.00;
       end
       else if(CYP_ISFREQ133 || inleft_lowspd == 1'b0)  // 133 Mhz freq bin
       begin     
             tCH_l     = 3.00;
             tCL_l     = 3.00;
             tCHCH_l   = 3.38;
             tSD_l     = 0.50;
             tHD_l     = 0.50;
             tSBE_l    = 0.50;
             tHBE_l    = 0.50;
             tSAC_l    = 1.80;
             tHAC_l    = 0.50;
             tOE_l     = 5.50;
             tOLZ_l    = 1.00;
             tOHZ_l    = 5.50;
             tCD_l     = 0.70;
             tDC_l     = 0.70; // negative
             tCCQ_min_l= 0.70; // negative
	     tCCQ_max_l= 0.70;
             tCQHQV_l  = 0.30;
             tCQHQX_l  = 0.30; // negative
             tCKHZ_l   = 0.70;
             tCKLZ_l   = 0.70;
             tCA_l     = 7.40;
             tAC_l     = 1.00;
             tCKHZA_l  = 7.40;
             tCKLZA_l  = 1.00;
             tSCINT_l  = 5.00;
             tRCINT_l  = 1.00;
             tSINT_r   = (7.40 + clock_period_l/2.0); // minimum clock period
             tRINT_l   = (7.40 + clock_period_l/2.0); // minimum clock period
             tBSY_l    = 5.00;
       end
       else
       begin
         if(CYP_ISFREQ200 && inleft_lowspd == 1'b1) 
	 begin                                      // 200 MH Frequency Bin
              tCH_l     = 2.00;
              tCL_l     = 2.00;
              tCHCH_l   = 2.20;
              tSD_l     = 0.40;
              tHD_l     = 0.40;
              tSBE_l    = 0.40;
              tHBE_l    = 0.40;
              tSAC_l    = 1.50;
              tHAC_l    = 0.50;
              tOE_l     = 4.40;
              tOLZ_l    = 1.00;
              tOHZ_l    = 4.40;
              tCD_l     = 0.50;
              tDC_l     = 0.50; // negative
              tCCQ_min_l= 0.50; // negative
	      tCCQ_max_l= 0.50;
              tCQHQV_l  = 0.35;
              tCQHQX_l  = 0.35; // negative
              tCKHZ_l   = 0.50;
              tCKLZ_l   = 0.50; // negative
              tCA_l     = 4.90;
              tAC_l     = 1.00;
              tCKHZA_l  = 4.90;
              tCKLZA_l  = 1.00;
              tSCINT_l  = 3.30;
              tRCINT_l  = 3.30;
              tSINT_r   = (4.90 + clock_period_l/2.0);
              tRINT_l   = (4.90 + clock_period_l/2.0);
              tBSY_l    = 3.30;
         end
         else      // 250 Mhz frequency bin, This is default bin     
         begin
              tCH_l     = 1.60;
              tCL_l     = 1.60;
              tCHCH_l   = 1.80;
              tSD_l     = 0.35;
              tHD_l     = 0.35;
              tSBE_l    = 0.35;
              tHBE_l    = 0.35;
              tSAC_l    = 1.20;
              tHAC_l    = 0.50;
              tOE_l     = 3.40;
              tOLZ_l    = 1.00;
              tOHZ_l    = 3.40;
              tCD_l     = 0.50;
              tDC_l     = 0.50; // negative
              tCCQ_min_l= 0.50;
	      tCCQ_max_l= 0.50;
              tCQHQV_l  = 0.30;
              tCQHQX_l  = 0.30; // negative
              tCKHZ_l   = 0.50;
              tCKLZ_l   = 0.50;
              tCA_l     = 3.90;
              tAC_l     = 1.00;
              tCKHZA_l  = 3.90;
              tCKLZA_l  = 1.00;
              tSCINT_l  = 2.64;
              tRCINT_l  = 2.64;
              tSINT_r   = (3.90 + clock_period_l/2.0);
              tRINT_l   = (3.90 + clock_period_l/2.0);
              tBSY_l    = 2.64;
         end
       end 
      end

      1'b0: // SDR mode 
      begin 
       if(CYP_ISFREQ133 || inleft_lowspd == 1'b0) 
       begin                                      // 133 Mhz freq bin
             tCKD_max_l  = 55;  
             tSD_l       = 1.80;
             tHD_l       = 0.50;
             tSAC_l      = 1.80;
             tHAC_l      = 0.50;
             tOE_l       = 5.50;
             tOLZ_l      = 1.00;
             tOHZ_l      = 5.50;
             tDC_l       = 1.00; 
             tCCQ_max_l  = 4.50;
	     tCCQ_min_l  = 1.0;
             tCQHQV_l    = 0.80;
             tCQHQX_l    = 0.80; // negative
             tCKLZ_l     = 1.00;
             tAC_l       = 1.00;
             tCKLZA_l    = 1.00;
             tSCINT_l    = 4.50;
             tRCINT_l    = 4.50;
             tSINT_r     = 7.40;
             tRINT_l     = 7.40;
             tBSY_l      = 4.50;

	     if(ileft_ftsel == 1'b1)
	     begin
	       tCD_l    = 4.50;
	       tCKHZ_l  = 4.50;
	       tCA_l    = 7.40;
	       tCKHZA_l = 7.40;
	     end
	     else
	     begin
	       tCD_l    = 13.00;
               tCKHZ_l  = 13.00; 
	       tCA_l    = 13.00;
	       tCKHZA_l = 13.00;
	     end      
       end
       else if(CYP_ISFREQ200 && inleft_lowspd == 1'b1)    
       begin	             // 200 Mhz frequency bin, This is default bin     
             tCKD_max_l  = 55;
             tSD_l       = 1.50;
             tHD_l       = 0.50;
             tSAC_l      = 1.50;
             tHAC_l      = 0.50;
             tOE_l       = 4.40;
             tOLZ_l      = 1.00;
             tOHZ_l      = 4.40;
             tDC_l       = 1.00;
             tCCQ_max_l  = 3.30;
	     tCCQ_min_l  = 1.00;
             tCQHQV_l    = 0.70;
             tCQHQX_l    = 0.70; // negative
             tCKLZ_l     = 1.00;
             tAC_l       = 1.00;
             tCKLZA_l    = 1.00;
             tSCINT_l    = 3.30;
             tRCINT_l    = 3.30;
             tSINT_r     = 4.90;
             tRINT_l     = 4.90;
             tBSY_l      = 3.30;

	     if(ileft_ftsel == 1'b1)
	     begin
               tCD_l     = 3.30;
	       tCKHZ_l   = 3.30;
	       tCA_l     = 4.90;
	       tCKHZA_l  = 4.90;
	     end
	     else
	     begin
               tCD_l     = 9.00;
	       tCKHZ_l   = 9.00;
	       tCA_l     = 9.00;
	       tCKHZA_l  = 9.00;
	     end
       end
       else if(CYP_ISFREQ167 && inleft_lowspd == 1'b1) 
       begin      // 167 Mhz freq bin
             tCKD_max_l   = 55;  
             tSD_l        = 1.70;
             tHD_l        = 0.50;
             tSAC_l       = 1.70;
             tHAC_l       = 0.50;
             tOE_l        = 5.00;
             tOLZ_l       = 1.00;
             tOHZ_l       = 5.00;
             tDC_l        = 1.00; 
             tCCQ_max_l   = 4.00;
	     tCCQ_min_l   = 1.00;
             tCQHQV_l     = 0.80;
             tCQHQX_l     = 0.80; // negative
             tCKLZ_l      = 1.00;
             tAC_l        = 1.00;
             tCKLZA_l     = 1.00;
             tSCINT_l     = 4.00;
             tRCINT_l     = 4.00;
             tSINT_r      = 5.90;
             tRINT_l      = 5.90;
             tBSY_l       = 4.00;

	     if(ileft_ftsel == 1'b1)
             begin
               tCD_l      = 4.00;
	       tCKHZ_l    = 4.00;
	       tCA_l      = 5.90;
	       tCKHZA_l   = 5.90;
             end
             else
             begin
               tCD_l      = 11.00;
	       tCKHZ_l    = 11.00;
	       tCA_l      = 11.00;
	       tCKHZA_l   = 11.00;
	     end
       end
       else       // 250 Mhz frequency bin, This is default bin    
       begin 
              tCKD_max_l  = 55;
              tSD_l       = 1.20;
              tHD_l       = 0.50;
              tSAC_l      = 1.20;
              tHAC_l      = 0.50;
              tOE_l       = 3.40;
              tOLZ_l      = 1.00;
              tOHZ_l      = 3.40;
              tDC_l       = 1.00;
              tCCQ_max_l  = 2.64;
	      tCCQ_min_l  = 1.00;
              tCQHQV_l    = 0.60;
              tCQHQX_l    = 0.60; // negative
              tCKLZ_l     = 1.00;
              tAC_l       = 1.00;
              tCKLZA_l    = 1.00;
              tSCINT_l    = 2.64;
              tRCINT_l    = 2.64;
              tSINT_r     = 3.90;
              tRINT_l     = 3.90;
              tBSY_l      = 2.64;

	      if(ileft_ftsel == 1'b1)
              begin
                 tCD_l    = 2.64;
		 tCKHZ_l  = 2.64;
		 tCA_l    = 3.90;
		 tCKHZA_l = 3.90;
              end
              else
              begin
                 tCD_l    = 7.20;
	         tCKHZ_l  = 7.20;
	         tCA_l    = 7.20;
	         tCKHZA_l = 7.20;
	      end 
        end
      end
    endcase
  end


  //TIMING PARAMETERS FOR THE RIGHT PORT
  always @(inreset  or iright_ddron or iright_ftsel)
  begin 
    case (iright_ddron)  
      1'b1:     // DDR mode   
      begin 
        if(CYP_ISFREQ167 && inright_lowspd == 1'b1) 
	begin                                       // 167 Mhz freq bin
             tCH_r     = 2.40;
             tCL_r     = 2.40;
             tCHCH_r   = 2.70;
             tSD_r     = 0.50;
             tHD_r     = 0.50;
             tSBE_r    = 0.50;
             tHBE_r    = 0.50;
             tSAC_r    = 1.70;
             tHAC_r    = 0.50;
             tOE_r     = 5.00;
             tOLZ_r    = 1.00;
             tOHZ_r    = 5.00;
             tCD_r     = 0.50;
             tDC_r     = 0.50; // negative
             tCCQ_min_r= 0.50; // negative
	     tCCQ_max_r= 0.50;
             tCQHQV_r  = 0.40;
             tCQHQX_r  = 0.40; // negative
             tCKHZ_r   = 0.50;
             tCKLZ_r   = 0.50;
             tCA_r     = 5.90;
             tAC_r     = 1.00;
             tCKHZA_r  = 5.90;
             tCKLZA_r  = 1.00;
             tSCINT_r  = 4.00;
             tRCINT_r  = 1.00;
             tSINT_l   = (5.90 + clock_period_r/2.0); // minimum clock period
             tRINT_r   = (5.90 + clock_period_r/2.0);
             tBSY_r    = 4.00;
       end
       else if(CYP_ISFREQ133 || inright_lowspd == 1'b0)  // 133 Mhz freq bin
       begin     
             tCH_r     = 3.00;
             tCL_r     = 3.00;
             tCHCH_r   = 3.38;
             tSD_r     = 0.50;
             tHD_r     = 0.50;
             tSBE_r    = 0.50;
             tHBE_r    = 0.50;
             tSAC_r    = 1.80;
             tHAC_r    = 0.50;
             tOE_r     = 5.50;
             tOLZ_r    = 1.00;
             tOHZ_r    = 5.50;
             tCD_r     = 0.70;
             tDC_r     = 0.70; // negative
             tCCQ_min_r= 0.70; // negative
	     tCCQ_max_r= 0.70;
             tCQHQV_r  = 0.30;
             tCQHQX_r  = 0.30; // negative
             tCKHZ_r   = 0.70;
             tCKLZ_r   = 0.70;
             tCA_r     = 7.40;
             tAC_r     = 1.00;
             tCKHZA_r  = 7.40;
             tCKLZA_r  = 1.00;
             tSCINT_r  = 5.00;
             tRCINT_r  = 1.00;
             tSINT_l   = (7.40 + clock_period_r/2.0); // minimum clock period
             tRINT_r   = (7.40 + clock_period_r/2.0); // minimum clock period
             tBSY_r    = 5.00;
       end
       else     
       begin
         if(CYP_ISFREQ200 && inright_lowspd == 1'b1) 
	 begin                                      // 200 MH Frequency Bin
              tCH_r     = 2.00;
              tCL_r     = 2.00;
              tCHCH_r   = 2.20;
              tSD_r     = 0.40;
              tHD_r     = 0.40;
              tSBE_r    = 0.40;
              tHBE_r    = 0.40;
              tSAC_r    = 1.50;
              tHAC_r    = 0.50;
              tOE_r     = 4.40;
              tOLZ_r    = 1.00;
              tOHZ_r    = 4.40;
              tCD_r     = 0.50;
              tDC_r     = 0.50; // negative
              tCCQ_min_r= 0.50; // negative
	      tCCQ_max_r= 0.50;
              tCQHQV_r  = 0.35;
              tCQHQX_r  = 0.35; // negative
              tCKHZ_r   = 0.50;
              tCKLZ_r   = 0.50; // negative
              tCA_r     = 4.90;
              tAC_r     = 1.00;
              tCKHZA_r  = 4.90;
              tCKLZA_r  = 1.00;
              tSCINT_r  = 3.30;
              tRCINT_r  = 3.30;
              tSINT_l   = (4.90 + clock_period_r/2.0);
              tRINT_r   = (4.90 + clock_period_r/2.0);
              tBSY_r    = 3.30;
         end
         else      // 250 Mhz frequency bin, This is default bin     
         begin
              tCH_r     = 1.60;
              tCL_r     = 1.60;
              tCHCH_r   = 1.80;
              tSD_r     = 0.35;
              tHD_r     = 0.35;
              tSBE_r    = 0.35;
              tHBE_r    = 0.35;
              tSAC_r    = 1.20;
              tHAC_r    = 0.50;
              tOE_r     = 3.40;
              tOLZ_r    = 1.00;
              tOHZ_r    = 3.40;
              tCD_r     = 0.50;
              tDC_r     = 0.50; // negative
              tCCQ_min_r= 0.50;
	      tCCQ_max_r= 0.50;
              tCQHQV_r  = 0.30;
              tCQHQX_r  = 0.30; // negative
              tCKHZ_r   = 0.50;
              tCKLZ_r   = 0.50;
              tCA_r     = 3.90;
              tAC_r     = 1.00;
              tCKHZA_r  = 3.90;
              tCKLZA_r  = 1.00;
              tSCINT_r  = 2.64;
              tRCINT_r  = 2.64;
              tSINT_l   = (3.90 + clock_period_r/2.0);
              tRINT_r   = (3.90 + clock_period_r/2.0);
              tBSY_r    = 2.64;
         end
       end 
      end

      1'b0: // SDR mode 
      begin 
       if(CYP_ISFREQ133 || inright_lowspd == 1'b0) 
       begin                                      // 133 Mhz freq bin
             tCKD_max_r  = 55;  
             tSD_r       = 1.80;
             tHD_r       = 0.50;
             tSAC_r      = 1.80;
             tHAC_r      = 0.50;
             tOE_r       = 5.50;
             tOLZ_r      = 1.00;
             tOHZ_r      = 5.50;
             tDC_r       = 1.00; 
             tCCQ_max_r  = 4.50;
	     tCCQ_min_r  = 1.0;
             tCQHQV_r    = 0.80;
             tCQHQX_r    = 0.80; // negative
             tCKLZ_r     = 1.00;
             tAC_r       = 1.00;
             tCKLZA_r    = 1.00;
             tSCINT_r    = 4.50;
             tRCINT_r    = 4.50;
             tSINT_l     = 7.40;
             tRINT_r     = 7.40;
             tBSY_r      = 4.50;

	     if(iright_ftsel == 1'b1)
	     begin
	       tCD_r    = 4.50;
	       tCKHZ_r  = 4.50;
	       tCA_r    = 7.40;
	       tCKHZA_r = 7.40;
	     end
	     else
	     begin
	       tCD_r    = 13.00;
               tCKHZ_r  = 13.00; 
	       tCA_r    = 13.00;
	       tCKHZA_r = 13.00;
	     end      
       end
       else if(CYP_ISFREQ200 && inright_lowspd == 1'b1)    
       begin                // 200 Mhz frequency bin, This is default bin
             tCKD_max_r  = 55;
             tSD_r       = 1.50;
             tHD_r       = 0.50;
             tSAC_r      = 1.50;
             tHAC_r      = 0.50;
             tOE_r       = 4.40;
             tOLZ_r      = 1.00;
             tOHZ_r      = 4.40;
             tDC_r       = 1.00;
             tCCQ_max_r  = 3.30;
	     tCCQ_min_r  = 1.00;
             tCQHQV_r    = 0.70;
             tCQHQX_r    = 0.70; // negative
             tCKLZ_r     = 1.00;
             tAC_r       = 1.00;
             tCKLZA_r    = 1.00;
             tSCINT_r    = 3.30;
             tRCINT_r    = 3.30;
             tSINT_l     = 4.90;
             tRINT_r     = 4.90;
             tBSY_r      = 3.30;

	     if(iright_ftsel == 1'b1)
	     begin
               tCD_r     = 3.30;
	       tCKHZ_r   = 3.30;
	       tCA_r     = 4.90;
	       tCKHZA_r  = 4.90;
	     end
	     else
	     begin
               tCD_r     = 9.00;
	       tCKHZ_r   = 9.00;
	       tCA_r     = 9.00;
	       tCKHZA_r  = 9.00;
	     end
       end
       else if(CYP_ISFREQ167 && inright_lowspd == 1'b1) 
       begin      // 167 Mhz freq bin
             tCKD_max_r   = 55;  
             tSD_r        = 1.70;
             tHD_r        = 0.50;
             tSAC_r       = 1.70;
             tHAC_r       = 0.50;
             tOE_r        = 5.00;
             tOLZ_r       = 1.00;
             tOHZ_r       = 5.00;
             tDC_r        = 1.00; 
             tCCQ_max_r   = 4.00;
	     tCCQ_min_r   = 1.00;
             tCQHQV_r     = 0.80;
             tCQHQX_r     = 0.80; // negative
             tCKLZ_r      = 1.00;
             tAC_r        = 1.00;
             tCKLZA_r     = 1.00;
             tSCINT_r     = 4.00;
             tRCINT_r     = 4.00;
             tSINT_l      = 5.90;
             tRINT_r      = 5.90;
             tBSY_r       = 4.00;

	     if(iright_ftsel == 1'b1)
             begin
               tCD_r      = 4.00;
	       tCKHZ_r    = 4.00;
	       tCA_r      = 5.90;
	       tCKHZA_r   = 5.90;
             end
             else
             begin
               tCD_r      = 11.00;
	       tCKHZ_r    = 11.00;
	       tCA_r      = 11.00;
	       tCKHZA_r   = 11.00;
	     end
       end
       else       // 250 Mhz frequency bin, This is default bin    
       begin 
              tCKD_max_r  = 55;
              tSD_r       = 1.20;
              tHD_r       = 0.50;
              tSAC_r      = 1.20;
              tHAC_r      = 0.50;
              tOE_r       = 3.40;
              tOLZ_r      = 1.00;
              tOHZ_r      = 3.40;
              tDC_r       = 1.00;
              tCCQ_max_r  = 2.64;
	      tCCQ_min_r  = 1.00;
              tCQHQV_r    = 0.60;
              tCQHQX_r    = 0.60; // negative
              tCKLZ_r     = 1.00;
              tAC_r       = 1.00;
              tCKLZA_r    = 1.00;
              tSCINT_r    = 2.64;
              tRCINT_r    = 2.64;
              tSINT_l     = 3.90;
              tRINT_r     = 3.90;
              tBSY_r      = 2.64;

	      if(iright_ftsel == 1'b1)
              begin
                 tCD_r    = 2.64;
		 tCKHZ_r  = 2.64;
		 tCA_r    = 3.90;
		 tCKHZA_r = 3.90;
              end
              else
              begin
                 tCD_r    = 7.20;
	         tCKHZ_r  = 7.20;
	         tCA_r    = 7.20;
	         tCKHZA_r = 7.20;
	      end 
        end
      end
    endcase
  end

endmodule



