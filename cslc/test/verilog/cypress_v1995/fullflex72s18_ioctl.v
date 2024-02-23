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
// File           : fullflex72s18_ioctl.v
// Author         : 
// Author's Email : 
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description : Input Output control block
//               This block will control the data input
//               and output to memory as per model configuration 
//               Also this block will control the read latency
//
// *******************************************************************

 module fullflex72s18_ioctl ( iport             ,
	                  inmsg             ,
		          iwmsg             ,
		          iemsg             ,
                          inreset           ,
                          iclk              ,
                          iclk_n            ,
                          iftsel            ,
                          iddron            , 
                          icqen             ,
                          iportstd          ,
                          iodq              ,
                          inbe              ,
                          ince0             ,
                          ice1              ,
                          inoe              ,
                          inrw              ,
                          ocq0              , 
                          ocq0_n            ,
                          ocq1              ,
                          ocq1_n            ,
                          ireadback_ind     , 
                          inready           ,
                          oread_en          ,
                          owrite_en         ,
                          oread_en_present  ,
                          owrite_en_present ,
                          iodq_int          ,
                          onbe_int          ,
                          trigger_mem_clk
                        );
                     
 // User settable parameters
  parameter                  CYP_ADDRWIDTH = 18;
  parameter                  CYP_DATAWIDTH = 72;
  parameter                  CYP_BYTEWIDTH = 8;
  parameter                  CYP_LASTADDR  = 262143;
  parameter                  CYP_ISDDR     = 0;
  parameter                  CYP_ISSDR     = 0;
  parameter                  CYP_ISFREQ250 = 1;
  parameter                  CYP_ISFREQ200 = 0;
  parameter                  CYP_ISFREQ167 = 0;
  parameter                  CYP_ISFREQ133 = 0;
  parameter                  CYP_ISFREQ100 = 0;
  parameter                  CYP_ISFREQ83  = 0;
  parameter                  CYP_ISMINDEL  = 1;
  parameter                  CYP_ISMAXDEL  = 0;

 // Internal parameters 
  parameter                  CYP_DDR_MULT  = (CYP_ISDDR ? 2 : 1);
  parameter                  DW_INT_DIV72  = ((CYP_DATAWIDTH*CYP_DDR_MULT == 72) ? 1 : 0);
  parameter                  DW_INT_DIV36  = ((CYP_DATAWIDTH*CYP_DDR_MULT == 36) ? 1 : 0);
  parameter                  DW_INT_36_72  = ((CYP_DATAWIDTH*CYP_DDR_MULT == 36 || 
	                                       CYP_DATAWIDTH*CYP_DDR_MULT == 72) ? 1 : 0);
				       
  parameter                  DW_DIV72      = ((CYP_DATAWIDTH == 72) ? 1 : 0);
  parameter                  DW_DIV36      = ((CYP_DATAWIDTH == 36) ? 1 : 0);
  parameter                  DW_36_72      = ((CYP_DATAWIDTH == 36 || 
	                                       CYP_DATAWIDTH == 72) ? 1 : 0);
				       
  input                      iport;            // port identifier
  input                      inmsg;            // NOTE message on input
  input                      iwmsg;            // WARNING message on input
  input                      iemsg;            // ERROR message on input
  input                      inreset;          // Master reset
  input                      iclk;             // Input clock 
  input                      iclk_n;           // Active low Input clock
  input                      iftsel;           // Pipeline/Flow-through selection
  input                      iddron;           // DDR mode control input
  input                      icqen;            // Echo clock output enable
  input [1:0]                iportstd;         // Port standard selection
  input [CYP_BYTEWIDTH-1:0]  inbe;             // Byte Enables
  input                      ince0;            // Active low chip enable 0
  input                      ice1;             // Active high chip enable 1
  input                      inoe;             // Output enable
  input                      inrw;             // Read or Write control
  input                      ireadback_ind;    // Readback indication from address logic
  input                      inready;          // READY# input

  output                     ocq0;             // CQ positive clock output with  dq[71:36]
  output                     ocq0_n;           // CQ negative clock output with  dq[71:36]
  output                     ocq1;             // CQ positive clock output with  dq[35:0]
  output                     ocq1_n;           // CQ negative clock output with dq[35:0]
  output                     oread_en;         // Memory Read enable signal
  output                     owrite_en;        // Memory write enable
  output                     oread_en_present; // Memory Read enable signal
  output                     owrite_en_present;// Memory write enable
  output [CYP_DDR_MULT*CYP_BYTEWIDTH-1:0] onbe_int; // Byte enables to memory
  inout  [CYP_DDR_MULT*CYP_DATAWIDTH-1:0] iodq_int; // data output to memory
  inout  [CYP_DATAWIDTH-1:0] iodq;             // input data bus
  input                      trigger_mem_clk;  // Memory update clock

  reg                        cq0;              // CQ positive clock output with data dq[71:36]
  reg                        cq0_n;            // CQ negative clock output with data dq[71:36]
  reg                        cq1;              // CQ positive clock output with data dq[35:0]
  reg                        cq1_n;            // CQ negative clock output with data dq[35:0]
  reg                        read_en;          // Memory Read enable signal
  reg                        read_en_1delay;   // Read enable delayed by 1 period
  reg                        read_en_2delay;   // Read enable delayed by 2 period
  reg                        write_en;         // Memory write enable
  
  reg                        read_en_temp;     // Read enable signal
  reg                        write_en_temp;    // Write enable

  reg                        oe_delayed;       // OE# delayed by tOHZ or tOLZ
  reg                        ddr_read_operation1; // DDR read operation flag
  reg                        ddr_read_operation2; // DDR read operation flag
  
  wire[CYP_DDR_MULT*CYP_DATAWIDTH-1:0] iodq_int;  // data output to memory 
  reg [CYP_DATAWIDTH-1:0] iodq_temp1;
  
  reg [CYP_DATAWIDTH-1:0]    dq_read_value; // DQ output with proper latency
  reg [71:0]                 dq_read_value_temp1; // DQ temporary storage reg 1
  reg [71:0]                 dq_read_value_temp2; // DQ temporary storage reg 2
  reg [71:0]                 dq_read_value_temp3; // DQ temporary storage reg 3
  reg [71:0]                 dq_write_value;      // DQ input temporary storage
  reg [71:0]                 dq_write_value_temp1;// DQ input temporary storage
  reg [CYP_DDR_MULT*CYP_BYTEWIDTH - 1:0]  onbe_int;  // BE# output
  reg [CYP_DDR_MULT*CYP_BYTEWIDTH - 1:0]  nbe_int;  // BE# output
  reg [7:0]                  be_int_temp1;        // BE# temporary register 1
  reg [7:0]                  be_int_temp;         // BE# temporary register
  reg [7:0]                  be_int_temp2;         // BE# temporary register
  reg [1:0]                  portstd_buf;         // Buffer PORSTD input upon master reset
  reg                        ftsel_buf;           // Buffer FTSEL# input upon master reset
  reg                        cqen_buf;            // Buffer CQEN input upon master reset
  reg                        ddron_buf;           // Buffer DDRON input upon master reset

  real                       latency;             // latency for read operation
  real                       clock_period;        // input clock period
  real                       clock_event_time;    // Input Clock event time
  real                       echo_clock_delay;    // Echo clock delay
  real                       clock_frequency;     // input clock frequency in MHz
  realtime                   tCD,tDC;             // port independent timing parameter tCD, tDC
  realtime                   tCCQ_min, tCCQ_max;  // port independent timing parameter tCCQ_min, tCCQ_max
  realtime                   tOHZ, tOLZ;          // port independent timing parameter tOHZ, tOLZ
  realtime                   tCQHQV;              // port independent timing parameter tCQHQV
  realtime                   oe_set_time;         // indicates the time at which OE# is set HIGH
  reg                        out_of_range_freq;   // out of range frequency indication flag 
  reg                        trigger_io_clk;      // Model signal update trigger clock
  integer                    portstd_change_count;// Clock count after PORTSTD input change
  integer                    ftsel_change_count;  // Clock count after FTSEL# input change
  integer                    cqen_change_count;   // Clock count after CQEN input change
  integer                    ddron_change_count;  // Clock count after DDRON input change
  reg                        first_rst_complete;  // First reset complete flag
  

  // Assiging data to tht data output
  assign iodq_int = dq_write_value;
  assign iodq = iodq_temp1;

  // Model initialization
  initial
  begin
     latency             = 2.0;
     clock_period        = 10.0;
     clock_event_time    = 0.0;
     echo_clock_delay    = 0.0;
     clock_frequency     = 10.0;
     out_of_range_freq   = 1'b0;
     trigger_io_clk      = 1'b0;
     onbe_int            = {CYP_DDR_MULT*CYP_BYTEWIDTH{1'b0}};
     nbe_int            = {CYP_DDR_MULT*CYP_BYTEWIDTH{1'b0}};
     oe_set_time         = 0;
     portstd_change_count= 0;
     ftsel_change_count  = 0;
     ddron_change_count  = 0;
     cqen_change_count   = 0;
     portstd_buf         = iportstd;
     ftsel_buf           = iftsel;
     ddron_buf           = iddron;
     cqen_buf            = icqen;
     first_rst_complete  = 1'b0;

     dq_read_value       = {CYP_DATAWIDTH{1'bZ}};
     dq_read_value_temp1 = {72{1'bZ}}; 
     dq_read_value_temp2 = {72{1'bZ}}; 
     dq_read_value_temp3 = {72{1'bZ}};
     
  end


  // IO BUS assignment
  always @ (inreset or ireadback_ind or oe_delayed or dq_read_value or iddron)
  begin
    if (inreset == 1'b0 || ireadback_ind == 1'b1 || oe_delayed == 1'b1)
    begin
        iodq_temp1 = {CYP_DATAWIDTH{1'bZ}};
    end
    else
    begin
        iodq_temp1 = dq_read_value[CYP_DATAWIDTH - 1 : 0];
    end

    if(iddron == 1'b1 && CYP_ISDDR == 0) 
    begin
	if(DW_DIV72 == 1)
	begin
            iodq_temp1[DW_DIV72 * 71 : DW_DIV72 * 63] = {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
            iodq_temp1[DW_DIV72 * 53 : DW_DIV72 * 45] = {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
	end
	if(DW_36_72 == 1)
	begin
	    iodq_temp1[DW_36_72*35 : DW_36_72*27] = {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
	end
	iodq_temp1[17 : 09] = {18{1'bZ}};
    end
  end
  
  // Generate port independent timing parameters 
  always@(iport or inreset)
   begin
     if(iport)
        begin
           tCD      = TP.tCD_l;
           tDC      = TP.tDC_l;
           tCCQ_min = TP.tCCQ_min_l;
	   tCCQ_max = TP.tCCQ_max_l;
	   tOHZ     = TP.tOHZ_l;
	   tOLZ     = TP.tOLZ_l;
	   tCQHQV   = TP.tCQHQV_l;
        end
     else
        begin
           tCD      = TP.tCD_r;
           tDC      = TP.tDC_r;
	   tCCQ_min = TP.tCCQ_min_r;
	   tCCQ_max = TP.tCCQ_max_r;
	   tOHZ     = TP.tOHZ_r;
	   tOLZ     = TP.tOLZ_r;
	   tCQHQV   = TP.tCQHQV_r;
        end
  end

  
  // Master Reset Release
  always 
  begin
       @(posedge inreset);
       if($realtime > 0) 
       begin
	       
	  // Reset internal buffers
          dq_read_value        = {CYP_DATAWIDTH{1'bZ}};
          dq_read_value_temp1  = {72{1'bZ}}; 
          dq_read_value_temp2  = {72{1'bZ}}; 
          dq_read_value_temp3  = {72{1'bZ}}; 
          dq_write_value       = {72{1'bZ}}; 
          dq_write_value_temp1 = {72{1'bZ}};
	  first_rst_complete   = 1'b1;

	  #0; 
	 
	  // Buffer the control input signals
	  portstd_buf          = iportstd;
          ftsel_buf            = iftsel;
          ddron_buf            = iddron;
          cqen_buf             = icqen;
     
	  // Checking unknown values in FTSEL# pin
	  if(iftsel === 1'bx || iftsel === 1'bz)
	  begin
             if(iemsg == 1'b1 && iport == 1'b1)
	     begin
	       $display($realtime, " ERROR: Unknown value in Left FTSEL# pin. Model operation not predictable"); 
             end
	     else if(iemsg == 1'b1 && iport == 1'b0)
	     begin
	       $display($realtime, " ERROR: Unknown value in Right FTSEL# pin. Model operation not predictable"); 
             end
	  end 

	  // Checking unknown values in DDRON pin
	  if(iddron === 1'bx || iddron === 1'bz)
	  begin
             if(iemsg == 1'b1 && iport == 1'b1)
	     begin
	       $display($realtime, " ERROR: Unknown value in Left DDRON pin. Model operation not predictable"); 
             end
	     else if(iemsg == 1'b1 && iport == 1'b0)
	     begin
	       $display($realtime, " ERROR: Unknown value in Right DDRON pin. Model operation not predictable"); 
             end
	  end 

	  // Checking unknown values in CQEN pin
	  if(icqen === 1'bx || icqen === 1'bz)
	  begin
             if(iemsg == 1'b1 && iport == 1'b1)
	     begin
	       $display($realtime, " ERROR: Unknown value in Left CQEN pin. Model operation not predictable"); 
             end
	     else if(iemsg == 1'b1 && iport == 1'b0)
	     begin
	       $display($realtime, " ERROR: Unknown value in Right CQEN pin. Model operation not predictable"); 
             end
	  end

	  // Checking unknown values in PORTSTD pins
	  if(iportstd[0] === 1'bx || iportstd[0] === 1'bz || iportstd[1] === 1'bx || iportstd[1] === 1'bz)
	  begin
             if(iemsg == 1'b1 && iport == 1'b1)
	     begin
	       $display($realtime, " ERROR: Unknown value in Left PORTSTD pin. Model operation not predictable"); 
             end
	     else if(iemsg == 1'b1 && iport == 1'b0)
	     begin
	       $display($realtime, " ERROR: Unknown value in Right PORTSTD pin. Model operation not predictable"); 
             end
	  end 
	  
          // latency selection as per model configuration
          case ({iftsel,iddron})
            2'b10 : latency = 2;
            2'b11 : latency = 2.5;
            2'b00 : latency = 1;  
            2'b01 : latency = 2.5; 
            default: 
	      if(inready == 1'b0)  
		 if(iemsg == 1'b1)
		   $display($realtime,"Unknown value on FTSEL# or DDRON pin");
          endcase

          // input clock period calculation 
          @ (posedge iclk);
             clock_event_time = $realtime;
          @ (posedge iclk);
             clock_period     = $realtime - clock_event_time;

          // Echo clock delay calculation
          @ (posedge iclk);

          if(tCD > tCQHQV)
	     echo_clock_delay = 1.01* (tCD - tCQHQV);
          else 
	     echo_clock_delay = 0.09* tCCQ_max;

       end // end of the if (realtime >0)
  end // End always

  // Monitoring control input signals change after reset operation
  always @(inreset or iclk)
  begin
    if(inreset == 1'b0)
    begin
       portstd_change_count = 0;
       ftsel_change_count   = 0;
       ddron_change_count   = 0;
       cqen_change_count    = 0;
    end
    else if(first_rst_complete == 1'b1)
    begin

      // Monitoring PORTSTD input signals change after reset operation
      if(iportstd !== portstd_buf)
      begin
        portstd_change_count = portstd_change_count + 1;
	if(portstd_change_count == 15)
	begin
	  if(iwmsg == 1'b1 && iport == 1'b1)
	  begin
	     $display($realtime, " WARNING: Left PORTSTD input changed after reset operation. Reset the model to behave properly");
          end
	  else if(iwmsg == 1'b1 && iport == 1'b0)
	  begin
	     $display($realtime, " WARNING: Right PORTSTD input changed after reset operation. Reset the model to behave properly");
          end
          portstd_change_count = 0;
	end
      end
      else
      begin
        portstd_change_count = 0;
      end

      // Monitoring FTSEL# input signal change after reset operation
      if(iftsel !== ftsel_buf)
      begin
        ftsel_change_count = ftsel_change_count + 1;
	if(ftsel_change_count == 15)
	begin
	  if(iwmsg == 1'b1 && iport == 1'b1)
	  begin
	     $display($realtime, " WARNING: Left FTSEL# input changed after reset operation. Reset the model to behave properly");
          end
	  else if(iwmsg == 1'b1 && iport == 1'b0)
	  begin
	     $display($realtime, " WARNING: Right FTSEL# input changed after reset operation. Reset the model to behave properly");
          end
          ftsel_change_count = 0;
	end
      end
      else
      begin
        ftsel_change_count = 0;
      end

      // Monitoring DDRON input signal change after reset operation
      if(iddron !== ddron_buf)
      begin
        ddron_change_count = ddron_change_count + 1;
	if(ddron_change_count == 15)
	begin
	  if(iwmsg == 1'b1 && iport == 1'b1)
	  begin
	     $display($realtime, " WARNING: Left DDRON input changed after reset operation. Reset the model to behave properly");
          end
	  else if(iwmsg == 1'b1 && iport == 1'b0)
	  begin
	     $display($realtime, " WARNING: Right DDRON input changed after reset operation. Reset the model to behave properly");
          end
          ddron_change_count = 0;
	end
      end
      else
      begin
        ddron_change_count = 0;
      end

      // Monitoring CQEN input signal change after reset operation
      if(icqen !== cqen_buf)
      begin
        cqen_change_count = cqen_change_count + 1;
	if(cqen_change_count == 15)
	begin
	  if(iwmsg == 1'b1 && iport == 1'b1)
	  begin
	     $display($realtime, " WARNING: Left CQEN input changed after reset operation. Reset the model to behave properly");
          end
	  else if(iwmsg == 1'b1 && iport == 1'b0)
	  begin
	     $display($realtime, " WARNING: Right CQEN input changed after reset operation. Reset the model to behave properly");
          end
          cqen_change_count = 0;
	end
      end
      else
      begin
        cqen_change_count = 0;
      end

    end 
  end
  
  // Echo clock generation CQ0, CQ1
  always @(iclk)
  begin
     if (icqen == 1'b1 && (!(iftsel == 1'b0 && iddron == 1'b0)) ) 
     begin
        cq0      <= #(echo_clock_delay) iclk;
        cq1      <= #(echo_clock_delay) iclk;

        if (iddron == 1'b0) 
        begin
           cq0_n <= #(echo_clock_delay) !iclk;
           cq1_n <= #(echo_clock_delay) !iclk;
        end
     end 
     else
     begin
       cq0   <= 1'bZ;
       cq1   <= 1'bZ;
       cq0_n <= 1'bZ;
       cq1_n <= 1'bZ;
     end
  end

  // Echo clock generation CQ0#, CQ1# for DDR mode
  always @(iclk_n)
  begin
     if (iddron == 1'b1 && icqen == 1'b1) 
     begin
        cq0_n <= #(echo_clock_delay) iclk_n;
        cq1_n <= #(echo_clock_delay) iclk_n;
     end
  end
  
  //Echo clock output update
  assign ocq0   = cq0;
  assign ocq0_n = cq0_n;
  assign ocq1   = cq1;
  assign ocq1_n = cq1_n;
  
  
  // Generating Write Enable and Read Enable
  always @(inoe or ince0 or ice1 or inrw)
  begin
    if((inoe == 1'b0)&& (ince0 == 1'b0)&& (ice1 == 1'b1)&& (inrw == 1'b1))
    begin
      read_en  = 1'b1;
      write_en = 1'b0;
    end 
    else if((ince0 == 1'b0)&& (ice1 == 1'b1)&& (inrw == 1'b0))
    begin
      read_en  = 1'b0;
      write_en = 1'b1;
    end 
    else 
    begin
      read_en  = 1'b0;
      write_en = 1'b0;
    end
  end

  
  // Bus turn-around Error check
  always @(posedge iclk)
  begin
   
     if(((iftsel == 1'b0 && iddron == 1'b0) && 
	 (write_en == 1'b1 && read_en_1delay == 1'b1)
        ) ||
	((!(iftsel == 1'b0 && iddron == 1'b0)) && 
         (write_en == 1'b1 && (read_en_1delay == 1'b1 || read_en_2delay == 1'b1))
        )
       )	
     begin
       if(iwmsg == 1'b1) 
       begin
         $display($realtime, "\n WARNING :Bus turnaround error. Model write corrupt data to memory");
       end
     end
  end
  
  // Delay output enable signal (OE# by tOHZ or tOLZ)
  always @(inoe)
  begin
     if(inoe == 1'b1)
     begin
        oe_delayed <= #(tOHZ) inoe;
        oe_set_time = $realtime;
     end
     else
     begin
	if(($realtime - oe_set_time) > tOHZ)
           oe_delayed <= #(tOLZ) inoe;   
        else
	   oe_delayed <= #(tOHZ - ($realtime -oe_set_time)) inoe;
     end
  end 
  
  // Delaying Read Enable by one clock cycle
  // Delayed read enable signal is used for latency adjustment
  always @(read_en)
  begin
    read_en_temp   <= #(clock_period) read_en;
    read_en_1delay <= #(clock_period) read_en;
    read_en_2delay <= #(2 * clock_period) read_en;
  end
  

  // Delaying Write Enable by one clock cycle
  // Delayed write enable signal is used for latency adjustment
  always @(write_en)
  begin
    write_en_temp <= #(clock_period) write_en;
  end 

  // BE# latency adjustment for SDR mode 
  always @(inbe)
  begin
     if(iddron == 1'b0 && iftsel == 1'b0)
         be_int_temp[CYP_BYTEWIDTH-1:0] <= inbe;	    
     else if(iddron == 1'b0 && iftsel == 1'b1) 
	 be_int_temp[CYP_BYTEWIDTH-1:0] <= #(clock_period) inbe;
     else 
	 be_int_temp[CYP_BYTEWIDTH-1:0] <= inbe;
     be_int_temp2[CYP_BYTEWIDTH-1:0] <= inbe;
  end
 
  // Delaying the BE# value for DDR mode
  always @(iclk)
  begin
    if(iddron == 1'b0 && iclk == 1'b1)
    begin
      if(iftsel == 1'b0)
         onbe_int     = be_int_temp[CYP_DDR_MULT*CYP_BYTEWIDTH-1:0];
      else
	 onbe_int     = be_int_temp2[CYP_DDR_MULT*CYP_BYTEWIDTH-1:0];
      nbe_int         = be_int_temp[CYP_DDR_MULT*CYP_BYTEWIDTH-1:0];
    end
    else if(iddron == 1'b1 && iclk == 1'b1)
    begin
      onbe_int        = be_int_temp1[CYP_DDR_MULT*CYP_BYTEWIDTH-1:0];
      nbe_int        = be_int_temp1[CYP_DDR_MULT*CYP_BYTEWIDTH-1:0];

      if(CYP_ISDDR == 1) // DDR only package
      begin 
         be_int_temp1[7] = inbe[3*DW_INT_36_72];
         be_int_temp1[5] = inbe[2*DW_INT_36_72];
         be_int_temp1[3] = inbe[1];
         be_int_temp1[1] = inbe[0];
      end
      else               // DDR and SDR package
      begin
         be_int_temp1[7] = inbe[6*DW_INT_DIV72];
         be_int_temp1[5] = inbe[4*DW_INT_DIV72];
         be_int_temp1[3] = inbe[2*DW_INT_36_72];
         be_int_temp1[1] = inbe[0];
      end
    end
    else if(iddron == 1'b1 && iclk == 1'b0)
    begin
      if(CYP_ISDDR == 1) // DDR only package
      begin
         be_int_temp1[6] = inbe[3*DW_INT_36_72];
         be_int_temp1[4] = inbe[2*DW_INT_36_72];
         be_int_temp1[2] = inbe[1];
         be_int_temp1[0] = inbe[0];
      end
      else               // DDR and SDR package
      begin
         be_int_temp1[6] = inbe[6*DW_INT_DIV72];
         be_int_temp1[4] = inbe[4*DW_INT_DIV72];
         be_int_temp1[2] = inbe[2*DW_INT_36_72];
         be_int_temp1[0] = inbe[0];
      end
    end 
  end

  // Clock generation for memory write
  always @(iclk)
  begin
    trigger_io_clk = iclk;
  end


  // Memory Write operation
  always @(iclk)
  begin
    
     case (latency)
       1: 
          begin
            if (iclk == 1'b1) 
            begin
              if ((write_en) && (inready == 1'b0)) 
              begin 
                dq_write_value[CYP_DDR_MULT*CYP_DATAWIDTH - 1:0] = iodq; 
              end
              else
              begin 
                dq_write_value = {72{1'bZ}}; 
              end
            end
          end
	  
     2: begin
            if (iclk == 1'b1)
            begin
              // dq_write_value = dq_write_value_temp1; 
              if ((write_en) && (inready == 1'b0)) 
              begin  
                dq_write_value[CYP_DDR_MULT*CYP_DATAWIDTH-1:0] = iodq;
              end
              else
              begin 
                dq_write_value= {72{1'bZ}}; 
              end
            end
          end
        
     2.5: begin

            if (iclk == 1'b1) 
            begin
               
	       dq_write_value = dq_write_value_temp1; 
               
	       if ((write_en) && (inready == 1'b0)) 
               begin
		       
                 if(CYP_DDR_MULT*CYP_DATAWIDTH == 72) 
                 begin
		   if(CYP_ISDDR == 1)
		   begin
                      {dq_write_value_temp1[71:63],
                       dq_write_value_temp1[53:45],
                       dq_write_value_temp1[35:27],
                       dq_write_value_temp1[17:9]
                      } = iodq[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0];
	           end
	           else
	           begin
		      dq_write_value_temp1[DW_INT_DIV72 *71:DW_INT_DIV72 *63] 
		                                  = iodq[DW_DIV72 * 62:DW_DIV72 * 54];
                      dq_write_value_temp1[DW_INT_DIV72 *53:DW_INT_DIV72 *45] 
		                                  = iodq[DW_DIV72 * 44:DW_DIV72 * 36];
                      dq_write_value_temp1[DW_INT_36_72*35:DW_INT_36_72*27] 
		                                  = iodq[DW_36_72 * 26:DW_36_72 * 18];
                      dq_write_value_temp1[17:09] = iodq[08:00];
	           end
		      
                 end
		 
                 else if(CYP_DDR_MULT*CYP_DATAWIDTH == 36) 
                 begin
	           if(CYP_ISDDR == 1)
		   begin
                     {dq_write_value_temp1[35:27],
                      dq_write_value_temp1[17:9]
                     } = iodq[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0];
	           end
		   else
		   begin
		      dq_write_value_temp1[DW_INT_36_72*35:DW_INT_36_72*27] 
		                                  = iodq[DW_36_72*26:DW_36_72*18];
                      dq_write_value_temp1[17:09] = iodq[08:00];
	           end
                 end
		 
                 else if(CYP_DDR_MULT*CYP_DATAWIDTH == 18) 
                 begin
		   if(CYP_ISDDR == 1)
		   begin
                       dq_write_value_temp1[17:9]
                        = iodq[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0];
		   end
		   else
		   begin
                       dq_write_value_temp1[17:09] = iodq[08:00];
		   end
                 end
               end
	       
               else
               begin
                 dq_write_value_temp1 = {72{1'bZ}}; 
               end
            end 

            else if(iclk == 1'b0) 
            begin
              if ((write_en) && (inready == 1'b0)) 
              begin
                if(CYP_DDR_MULT*CYP_DATAWIDTH == 72) 
                begin
		   if(CYP_ISDDR == 1)
		   begin
                      {dq_write_value_temp1[62:54],
                       dq_write_value_temp1[44:36],
                       dq_write_value_temp1[26:18],
                       dq_write_value_temp1[8:0]
                      } = iodq[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0];
	           end
	           else
	           begin
                      dq_write_value_temp1[DW_INT_DIV72*62:DW_INT_DIV72*54] 
		                                  = iodq[DW_DIV72*62:DW_DIV72*54];
                      dq_write_value_temp1[DW_INT_DIV72*44:DW_INT_DIV72*36] 
		                                  = iodq[DW_DIV72*44:DW_DIV72*36];
                      dq_write_value_temp1[DW_INT_36_72*26:DW_INT_36_72*18] 
		                                  = iodq[DW_36_72*26:DW_36_72*18];
                      dq_write_value_temp1[08:00] = iodq[08:00];
	           end
                end
                else if(CYP_DDR_MULT*CYP_DATAWIDTH == 36) 
                begin
		   if(CYP_ISDDR == 1)
		   begin
                      {dq_write_value_temp1[26:18],
                       dq_write_value_temp1[08:00]
                      } = iodq[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0]; 
		   end
	           else
	           begin
                      dq_write_value_temp1[DW_INT_36_72*26:DW_INT_36_72*18] 
		                                  = iodq[DW_36_72*26:DW_36_72*18];
                      dq_write_value_temp1[08:00] = iodq[08:00];
	           end
                end
                else if(CYP_DDR_MULT*CYP_DATAWIDTH == 18) 
                begin
		   if(CYP_ISDDR == 1)
		   begin
                      dq_write_value_temp1[8:0]
                        = iodq[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0]; 
		   end
	           else
	           begin
                      dq_write_value_temp1[08:00] = iodq[08:00];
	           end
                end
              end
            end
          end
        
      default: begin
             end 
     endcase
  end


  // Memory Read operation
  always @(negedge trigger_io_clk or trigger_mem_clk)
  begin
    
     #0;
     case (latency)

       1,2 : begin
            if (trigger_io_clk == 1'b1) 
            begin
              if (((latency == 1 && read_en == 1'b1) || 
		   (latency == 2 && read_en_temp == 1'b1)
	          ) && ( inready == 1'b0)) 
              begin
		      
		 if(nbe_int[0] == 1'b1)
                    dq_read_value[8:0] <= #(tDC) {9{1'bZ}};
	         else
		    dq_read_value[8:0] <= #(tDC) {9{1'bX}};

	         if(nbe_int[1] == 1'b1)
                    dq_read_value[17:9] <= #(tDC) {9{1'bZ}};
	         else
		    dq_read_value[17:9] <= #(tDC) {9{1'bX}};
	    
	         if(DW_36_72 == 1)
		 begin
	           if(nbe_int[DW_36_72 * 2] == 1'b1)
                      dq_read_value[DW_36_72 * 26 : DW_36_72*18] <= #(tDC) {(DW_36_72 == 1 ? 9 : 1){1'bZ}};
	           else
		      dq_read_value[DW_36_72 * 26 : DW_36_72*18] <= #(tDC) {(DW_36_72 == 1 ? 9 : 1){1'bX}};

	           if(nbe_int[DW_36_72 * 3] == 1'b1)
                      dq_read_value[DW_36_72 * 35 : DW_36_72*27] <= #(tDC) {(DW_36_72 == 1 ? 9 : 1){1'bZ}};
	           else
		      dq_read_value[DW_36_72 * 35 : DW_36_72*27] <= #(tDC) {(DW_36_72 == 1 ? 9 : 1){1'bX}};
		 end

		 if(DW_DIV72 == 1)
		 begin
	           if(nbe_int[DW_DIV72 * 4] == 1'b1)
                      dq_read_value[DW_DIV72 * 44 : DW_DIV72*36] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
	           else
		      dq_read_value[DW_DIV72 * 44 : DW_DIV72*36] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};

	           if(nbe_int[DW_DIV72 * 5] == 1'b1)
                      dq_read_value[DW_DIV72 * 53 : DW_DIV72*45] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
	           else
		      dq_read_value[DW_DIV72 * 53 : DW_DIV72*45] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};

	           if(nbe_int[DW_DIV72 * 6] == 1'b1)
                      dq_read_value[DW_DIV72 * 62 : DW_DIV72*54] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
	           else
		      dq_read_value[DW_DIV72 * 62 : DW_DIV72*54] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};

	           if(nbe_int[DW_DIV72 * 7] == 1'b1)
                      dq_read_value[DW_DIV72 * 71 : DW_DIV72*63] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
	           else
                   dq_read_value[DW_DIV72 * 71 : DW_DIV72*63] <= #(tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
                 end

                 dq_read_value <= #(tCD) iodq_int[CYP_DATAWIDTH-1:0];
		   
              end 
              else
              begin 
                  dq_read_value  <= #(tDC) {CYP_DATAWIDTH{1'bZ}};
              end
            end
          end	     

     	  2.5: begin

            if (trigger_io_clk == 1'b1) 
            begin
              if(CYP_DDR_MULT*CYP_DATAWIDTH == 72) 
              begin
	        if(CYP_ISDDR == 1)
		begin
                   dq_read_value[(CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1)*DW_INT_DIV72 :0] <= #(tCD)
                                 {dq_read_value_temp2[62*DW_INT_DIV72:54*DW_INT_DIV72],
                                  dq_read_value_temp2[44*DW_INT_DIV72:36*DW_INT_DIV72],
                                  dq_read_value_temp2[26*DW_INT_DIV72:18*DW_INT_DIV72],
                                  dq_read_value_temp2[8:0]};
		end
		else
		begin
		   dq_read_value[62*DW_DIV72:54*DW_DIV72] <= #(tCD) 
		                  dq_read_value_temp2[62*DW_DIV72:54*DW_DIV72];
		   dq_read_value[44*DW_DIV72:36*DW_DIV72] <= #(tCD) 
		                  dq_read_value_temp2[44*DW_DIV72:36*DW_DIV72];
		   dq_read_value[26*DW_DIV72:18*DW_DIV72] <= #(tCD) 
		                  dq_read_value_temp2[26*DW_DIV72:18*DW_DIV72];
		   dq_read_value[08:00] <= #(tCD) dq_read_value_temp2[08:00];
		   
		   dq_read_value[71*DW_DIV72:63*DW_DIV72] <= #(tCD) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
		   dq_read_value[53*DW_DIV72:45*DW_DIV72] <= #(tCD) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
		   dq_read_value[35*DW_DIV72:27*DW_DIV72] <= #(tCD) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
		   dq_read_value[17:9]  <= #(tCD) {9{1'bX}};
		end
              end else if(CYP_DDR_MULT*CYP_DATAWIDTH == 36) 
              begin
		if(CYP_ISDDR == 1)
		begin
                   dq_read_value[(CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1)*DW_INT_DIV36 :0] <= #(tCD)
                                 {dq_read_value_temp2[26*DW_INT_DIV36:18*DW_INT_DIV36],
                                  dq_read_value_temp2[8:0]};
	        end
		else
		begin
		   dq_read_value[26*DW_DIV36:18*DW_DIV36] <= #(tCD) 
		                  dq_read_value_temp2[26*DW_DIV36:18*DW_DIV36];
		   dq_read_value[08:00] <= #(tCD) dq_read_value_temp2[08:00];
		   dq_read_value[35*DW_DIV36:27*DW_DIV36] <= #(tCD) {(DW_DIV36 == 1 ? 9 : 1){1'bX}};
		   dq_read_value[17:9]  <= #(tCD) {9{1'bX}};
		end
              end else if(CYP_DDR_MULT*CYP_DATAWIDTH == 18) 
              begin
		if(CYP_ISDDR == 1)
		begin
                   dq_read_value[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0] <= #(tCD)
                                  dq_read_value_temp2[8:0];
	        end
		else
		begin
		   dq_read_value[08:00] <= #(tCD) dq_read_value_temp2[08:00];
		   dq_read_value[17:9]  <= #(tCD) {9{1'bX}};
		end
              end
	      
              if(ddr_read_operation2 == 1'b1)
	      begin
		if(CYP_ISDDR == 1)
		begin
                  dq_read_value[CYP_DATAWIDTH-1:0] 
		                       <= #(clock_period/2.0 -tDC) {CYP_DATAWIDTH{1'bX}};
		end
		else
		begin
		  if(DW_DIV72 == 1)
		  begin
                    dq_read_value[DW_DIV72*62: DW_DIV72*54] 
		                       <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
		    dq_read_value[DW_DIV72*44: DW_DIV72*36] 
		                       <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
		  end
		  if(DW_36_72 == 1)
		  begin
		    dq_read_value[DW_36_72*26: DW_36_72*18] 
		                       <= #(clock_period/2.0 -tDC) {(DW_36_72 == 1 ? 9 : 1){1'bX}};
		  end
		  dq_read_value[08:00] <= #(clock_period/2.0 -tDC) {9{1'bX}};
	        end
	      end
              else
	      begin
		if(CYP_ISDDR == 1)
		begin
                  dq_read_value[CYP_DATAWIDTH-1:0] 
		                       <= #(clock_period/2.0 -tDC) {CYP_DATAWIDTH{1'bZ}};
		end
		else
		begin
		  if(DW_DIV72 == 1)
		  begin
                    dq_read_value[DW_DIV72*62: DW_DIV72*54] 
		                       <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
		    dq_read_value[DW_DIV72*44: DW_DIV72*36] 
		                       <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
		  end
		  if(DW_36_72 == 1)
		  begin
		    dq_read_value[DW_36_72*26: DW_36_72*18] 
		                       <= #(clock_period/2.0 -tDC) {(DW_36_72 == 1 ? 9 : 1){1'bZ}};
		  end
		  dq_read_value[08:00] <= #(clock_period/2.0 -tDC) {9{1'bZ}};
		end
	      end
	      
               if ((read_en_temp == 1'b1) &&( inready == 1'b0)) 
               begin
                 dq_read_value_temp1  = iodq_int;
		 ddr_read_operation1  = 1'b1;
               end 
               else
               begin
                 dq_read_value_temp1  = {72{1'bZ}}; 
		 ddr_read_operation1  = 1'b0;
               end
               dq_read_value_temp2    = dq_read_value_temp1;
	       ddr_read_operation2    = ddr_read_operation1;
            end 
            else if(trigger_io_clk == 1'b0) 
            begin
              if (inready == 1'b0) 
              begin
                if(CYP_DDR_MULT*CYP_DATAWIDTH == 72) 
                begin
                  if(CYP_ISDDR == 1)
		  begin
                     dq_read_value[(CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1)*DW_INT_DIV72 :0] <= #(tCD)
		                   {dq_read_value_temp2[71*DW_INT_DIV72:63*DW_INT_DIV72],
                                    dq_read_value_temp2[53*DW_INT_DIV72:45*DW_INT_DIV72],
                                    dq_read_value_temp2[35*DW_INT_DIV72:27*DW_INT_DIV72],
                                    dq_read_value_temp2[17*DW_INT_DIV72:09*DW_INT_DIV72]
                                   };
		  end
		  else
		  begin
		     dq_read_value[62*DW_DIV72:54*DW_DIV72] <= #(tCD) dq_read_value_temp2[71*DW_DIV72:63*DW_DIV72];
		     dq_read_value[44*DW_DIV72:36*DW_DIV72] <= #(tCD) dq_read_value_temp2[53*DW_DIV72:45*DW_DIV72];
		     dq_read_value[26*DW_DIV72:18*DW_DIV72] <= #(tCD) dq_read_value_temp2[35*DW_DIV72:27*DW_DIV72];
		     dq_read_value[08:00] <= #(tCD) dq_read_value_temp2[17:09];
		  end
                end
                else if(CYP_DDR_MULT*CYP_DATAWIDTH == 36) 
                begin
		  if(CYP_ISDDR == 1)
		  begin
                     dq_read_value[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0] <= #(tCD)
                                   {dq_read_value_temp2[35*DW_INT_DIV36:27*DW_INT_DIV36],
                                    dq_read_value_temp2[17:09]
                                   };
		  end
		  else
		  begin
		     dq_read_value[26*DW_DIV36:18*DW_DIV36] <= #(tCD) dq_read_value_temp2[35*DW_DIV36:27*DW_DIV36];
		     dq_read_value[08:00] <= #(tCD) dq_read_value_temp2[17:09];
		  end
                end
                else if(CYP_DDR_MULT*CYP_DATAWIDTH == 18) 
                begin
		  if(CYP_ISDDR == 1)
		  begin
                     dq_read_value[CYP_DDR_MULT*CYP_DATAWIDTH/2 - 1 :0] <= #(tCD)
                                   dq_read_value_temp2[17:09];
		  end
		  else
		  begin
		     dq_read_value[08:00] <= #(tCD) dq_read_value_temp2[17:09];
		  end
                end

		if(ddr_read_operation2 == 1'b1)
		begin
                   if(CYP_ISDDR == 1)
		   begin
                      dq_read_value[CYP_DATAWIDTH-1:0] 
		                          <= #(clock_period/2.0 -tDC) {CYP_DATAWIDTH{1'bX}};
		   end
		   else
		   begin
		      if(DW_DIV72 == 1)
		      begin
                        dq_read_value[DW_DIV72*62: DW_DIV72*54] 
		                          <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
		        dq_read_value[DW_DIV72*44: DW_DIV72*36] 
		                          <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bX}};
		      end
		      if(DW_36_72 == 1)
		      begin
		        dq_read_value[DW_36_72*26: DW_36_72*18] 
		                          <= #(clock_period/2.0 -tDC) {(DW_36_72 == 1 ? 9 : 1){1'bX}};
		      end
		      dq_read_value[08:00] <= #(clock_period/2.0 -tDC) {9{1'bX}};
		   end
	        end
		else
		begin
		   if(CYP_ISDDR == 1)
		   begin
                      dq_read_value[CYP_DATAWIDTH-1:0] 
		                          <= #(clock_period/2.0 -tDC) {CYP_DATAWIDTH{1'bZ}};
		   end
		   else
		   begin
		      if(DW_DIV72 == 1)
		      begin
                        dq_read_value[DW_DIV72*62: DW_DIV72*54] 
		                          <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
		        dq_read_value[DW_DIV72*44: DW_DIV72*36] 
		                          <= #(clock_period/2.0 -tDC) {(DW_DIV72 == 1 ? 9 : 1){1'bZ}};
		      end
		      if(DW_36_72 == 1)
		      begin
		        dq_read_value[DW_36_72*26: DW_36_72*18] 
		                          <= #(clock_period/2.0 -tDC) {(DW_36_72 == 1 ? 9 : 1){1'bZ}};
		      end
		      dq_read_value[08:00] <= #(clock_period/2.0 -tDC) {9{1'bZ}};
		   end
		end
              end 
            end
          end
        
      default: begin
             end 
     endcase
  end

  // Read/ Write enable signals to memory block
  assign oread_en          = ((iddron == 1'b1) || (iddron == 1'b0 && iftsel == 1'b1)) ?
	                     read_en_temp : read_en;
  assign oread_en_present  = read_en;
 
  assign owrite_en         = ((iddron == 1'b1) || (iddron == 1'b0 && iftsel == 1'b1)) ?
	                     write_en_temp : write_en;
  assign owrite_en_present = write_en;

 endmodule

