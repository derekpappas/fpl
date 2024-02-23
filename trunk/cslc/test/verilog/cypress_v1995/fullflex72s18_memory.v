
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
// File           : fullflex72s18_memory.v
// Author         :
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
//       This is the Dual port memory
//       It returns the read data zero latency.
//       Number of pipeline stages, SDR, DDR or Flow through will take care
//       in the I/O control block outside to this.
//       This module is also responsible for Arbitration and BUSY# output
//       generation.
//       This module does not contain any timing information or latency.
//
// *******************************************************************



module fullflex72s18_memory(inmsg                       ,
		        iwmsg                       ,
		        iemsg                       ,
		        inreset                     ,
                        ileft_clk                   ,
                        ileft_ddron                 ,
			ileft_ftsel                 ,
                        ileft_ad                    ,
			ileft_addr_present_pipeline ,
                        ioleft_data                 ,
                        inleft_be                   ,
                        ileft_read_en               ,
                        ileft_write_en              ,
			ileft_read_en_present       ,
			ileft_write_en_present      ,
                        onleft_busy                 ,
                        onleft_busy_int             ,
                        obusy_addr_left             ,
                        oleft_trigger_mem_clk       ,
                        iright_clk                  ,
                        iright_ddron                ,
			iright_ftsel                ,
                        iright_ad                   ,
			iright_addr_present_pipeline,
                        ioright_data                ,
                        inright_be                  ,
                        iright_read_en              ,
                        iright_write_en             ,
			iright_read_en_present      ,
			iright_write_en_present     ,
                        onright_busy                ,
                        onright_busy_int            ,
                        obusy_addr_right            ,
                        oright_trigger_mem_clk
                       );

  // User settable parameters
  parameter             CYP_ADDRWIDTH = 18;
  parameter             CYP_DATAWIDTH = 72;
  parameter             CYP_BYTEWIDTH = 8;
  parameter             CYP_LASTADDR  = 262143;
  parameter             CYP_ISDDR     = 0;
  parameter             CYP_ISSDR     = 0;

  // Internal parameters 
  parameter             CYP_DDR_MULT = (CYP_ISDDR ? 2 : 1);
  parameter             DW_36_72     = ((CYP_DDR_MULT*CYP_DATAWIDTH == 72 || 
	                                 CYP_DDR_MULT*CYP_DATAWIDTH == 36) ? 1 : 0);
  parameter             DW_72        = (CYP_DDR_MULT*CYP_DATAWIDTH==72 ? 1 : 0);

  // Input, Output Declarations
  input                      inmsg;                   // NOTE message on input
  input                      iwmsg;                   // WARNING message on input
  input                      iemsg;                   // ERROR message on input
  input                      inreset;                 // Master reset        
  input                      ileft_clk;               // Left port clk
  input                      ileft_ddron;             // Left DDRON input
  input                      ileft_ftsel;             // Left FTSEL# input
  input [CYP_ADDRWIDTH-1:0]  ileft_ad;                // Left port address
  input [CYP_ADDRWIDTH-1:0]  ileft_addr_present_pipeline;  // present address
  inout [CYP_DDR_MULT*CYP_DATAWIDTH -1:0] ioleft_data;     // Left port data; 
                                                      // Bidirectional
  input [CYP_DDR_MULT*CYP_BYTEWIDTH-1:0]  inleft_be;  // Left port byte enable
  input                      ileft_read_en;           // Left port read  enable
  input                      ileft_write_en;          // Left port write enable 
  input                      ileft_read_en_present;   // Left port read enable
  input                      ileft_write_en_present;  // Left port write enable
  output                     onleft_busy;             // Left port busy output 
  output                     onleft_busy_int;         // Left port internal busy  
  output [CYP_ADDRWIDTH-1:0] obusy_addr_left;         // Output Busy address
  output                     oleft_trigger_mem_clk;   // Memory output clock
  input                      iright_clk;              // Right port clk
  input                      iright_ddron;            // Right DDRON input
  input                      iright_ftsel;            // Right FTSEL# input
  input [CYP_ADDRWIDTH-1:0]  iright_ad;               // Right port address bus
  input [CYP_ADDRWIDTH-1:0]  iright_addr_present_pipeline;// present address
  inout [CYP_DDR_MULT*CYP_DATAWIDTH -1:0]  ioright_data;  // Right port bi-directionaldata bus
  input [CYP_DDR_MULT*CYP_BYTEWIDTH-1:0]  inright_be;     // Right port byte enable active low
  input                      iright_read_en;          // Right port read  enable
  input                      iright_write_en;         // Right port write enable
  input                      iright_read_en_present;  // Right port read  enable
  input                      iright_write_en_present; // Right port write enable 
  output                     onright_busy;            // Right port busy output 
  output                     onright_busy_int;        // Right port busy internal output
  output [CYP_ADDRWIDTH-1:0] obusy_addr_right;        // Output Busy address
  output                     oright_trigger_mem_clk;  // Memory output clock

  // Memory Declaration
  reg [CYP_DDR_MULT*CYP_DATAWIDTH -1 :0] dpsram[CYP_LASTADDR:0]; // memory declaration

  // Memory write or read values for pipeline stages
  reg [71:0]                 memory_write_value_l;
  reg [71:0]                 memory_read_value_l;
  reg [71:0]                 memory_old_vlue_l;
  reg [71:0]                 memory_read_value_actual_l;
  reg [71:0]                 memory_write_value_r;
  reg [71:0]                 memory_read_value_r;
  reg [71:0]                 memory_old_vlue_r;
  reg [71:0]                 memory_read_value_actual_r;

  // Internal BUSY registers for BUSY latency adjustment 
  wire                       onleft_busy;
  reg                        onleft_busy_1;
  wire                       onright_busy;
  reg                        onright_busy_1;
  reg                        onleft_busy_int;
  reg                        onright_busy_int;
  reg                        nleft_busy_1delay;
  reg                        nleft_busy_2delay;
  reg                        nleft_busy_3delay;
  reg                        nleft_busy_3delay_1;
  reg                        nleft_busy_4delay;
  reg                        nright_busy_1delay;
  reg                        nright_busy_2delay;
  reg                        nright_busy_3delay;
  reg                        nright_busy_3delay_1;
  reg                        nright_busy_4delay;
  reg                        nleft_busy_temp1;
  reg                        nleft_busy_temp2;
  reg                        nleft_busy_temp3;
  reg                        nleft_busy_temp4;
  reg                        nright_busy_temp1;
  reg                        nright_busy_temp2;
  reg                        nright_busy_temp3;
  reg                        nright_busy_temp4;
  reg                        nleft_busy_int;
  reg                        nright_busy_int;
 
  // Port execution flag
  reg                        left_process_flag;
  reg                        right_process_flag;
 
  // Arbitration read or write control registers
  reg                        read_new_data_l; 
  reg                        read_corrept_data_l;
  reg                        read_new_data_r; 
  reg                        read_corrept_data_r;
  reg                        write_corrept_data_l;
  reg                        write_new_data_l;
  reg                        write_corrept_data_r;
  reg                        write_new_data_r;
 
  reg                        read_new_data_l_prev; 
  reg                        read_corrept_data_l_prev;
  reg                        read_new_data_r_prev; 
  reg                        read_corrept_data_r_prev;
  reg                        write_corrept_data_l_prev;
  reg                        write_new_data_l_prev;
  reg                        write_corrept_data_r_prev;
  reg                        write_new_data_r_prev;
  
  // Adress registers for latency adjustment
  reg [CYP_ADDRWIDTH-1:0]    obusy_addr_left;
  reg [CYP_ADDRWIDTH-1:0]    obusy_addr_right;
  reg [CYP_ADDRWIDTH-1:0]    left_ad_delayed;
  reg [CYP_ADDRWIDTH-1:0]    right_ad_delayed;
  //reg [CYP_ADDRWIDTH-1:0]    left_addr_present_rclk_delayed;
  //reg [CYP_ADDRWIDTH-1:0]    right_addr_present_lclk_delayed;
  wire [CYP_ADDRWIDTH-1:0]   left_ad_active;
  wire [CYP_ADDRWIDTH-1:0]   right_ad_active;
 
  // BUSY# signal control registers 
  wire                       right_busy_change_request;
  wire                       left_busy_change_request;
  reg [32:1]                 right_busy_change_request_array;
  reg [32:1]                 left_busy_change_request_array;
  reg                        right_request_not_done;
  reg                        left_request_not_done;

  // Internal clocks
  reg                        trigger_clk_left;
  reg                        trigger_clk_left_update;
  reg                        trigger_clk_right;
  reg                        trigger_clk_right_update;

  // Read or write enable signals latency adjustment
  reg                        left_read_en_latch;
  reg                        left_write_en_latch;
  reg                        left_read_en_latch_present;
  reg                        left_write_en_latch_present;
  reg                        right_read_en_latch;
  reg                        right_write_en_latch;
  reg                        right_read_en_latch_present;
  reg                        right_write_en_latch_present;
  reg                        left_read_en_latch_prev;
  reg                        left_write_en_latch_prev;
  reg                        right_read_en_latch_prev;
  reg                        right_write_en_latch_prev;
  wire                       left_read_en_latch_active;
  wire                       left_write_en_latch_active;
  wire                       right_read_en_latch_active;
  wire                       right_write_en_latch_active;

  // Arbitration control flags
  reg                        violate_tccs_flag_l;
  reg                        violate_tccs_flag_r; 
  reg                        difference_low_flag_l;
  reg                        difference_low_flag_r;

  // Clock event monitoring variables
  realtime                   left_clk_last_event;
  realtime                   right_clk_last_event;
  realtime                   left_clk_event_next;
  realtime                   right_clk_event_next;

  // Clock period
  realtime                   clock_period_l;
  realtime                   clock_period_r;

  // Arbitration control timing parameters
  realtime tCCS;
  integer left_clk_edge_count;
  integer right_clk_edge_count;
  
  // Reset complete flag
  reg first_reset_complete;
  
  // Memory data output bus update
  assign ioleft_data = (((ileft_ftsel == 1'b0) && 
	                 (read_new_data_l == 1'b1 || read_corrept_data_l == 1'b1)) ||
			 ((ileft_ftsel == 1'b1) && 
	                 (read_new_data_l_prev == 1'b1 || read_corrept_data_l_prev == 1'b1))) ? 
	          memory_read_value_actual_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] : {72{1'bZ}};

  assign ioright_data = (((iright_ftsel == 1'b0) && 
	                 (read_new_data_r == 1'b1 || read_corrept_data_r == 1'b1)) ||
			 ((iright_ftsel == 1'b1) && 
	                 (read_new_data_r_prev == 1'b1 || read_corrept_data_r_prev == 1'b1))) ?
	          memory_read_value_actual_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] : {72{1'bZ}};

  // Output clock
  assign oleft_trigger_mem_clk       = trigger_clk_left_update;
  assign oright_trigger_mem_clk      = trigger_clk_right_update;

  // BUSY# output assignment
  assign onleft_busy                 = ((inreset === 1'b0) || (first_reset_complete == 1'b0)) ?
	                               1'bZ : onleft_busy_1;
  assign onright_busy                = ((inreset === 1'b0) || (first_reset_complete == 1'b0)) ?
	                               1'bZ : onright_busy_1;

  // Busy control signals assignment
  assign right_busy_change_request = |(right_busy_change_request_array);
  assign left_busy_change_request  = |(left_busy_change_request_array);
	  
  // Read or write enable control latency adjust
  assign right_read_en_latch_active  = (ileft_ftsel == iright_ftsel) ? 
	                               right_read_en_latch :
				       (ileft_ftsel == 1'b0 && iright_ftsel == 1'b1) ?
				       right_read_en_latch_present :
 				       (ileft_ftsel == 1'b1 && iright_ftsel == 1'b0) ?
 				       right_read_en_latch_prev : right_read_en_latch_active;
			      
  assign right_write_en_latch_active = (ileft_ftsel == iright_ftsel) ? 
	                               right_write_en_latch :
				       (ileft_ftsel == 1'b0 && iright_ftsel == 1'b1) ?
				       right_write_en_latch_present :
				       (ileft_ftsel == 1'b1 && iright_ftsel == 1'b0) ?
				       right_write_en_latch_prev : right_write_en_latch_active;
			     
  assign left_read_en_latch_active   = (iright_ftsel == ileft_ftsel) ? 
	                               left_read_en_latch :
				       (iright_ftsel == 1'b0 && ileft_ftsel == 1'b1) ?
				       left_read_en_latch_present :
				       (iright_ftsel == 1'b1 && ileft_ftsel == 1'b0) ?
				       left_read_en_latch_prev : left_read_en_latch_active;
			     
  assign left_write_en_latch_active  = (iright_ftsel == ileft_ftsel) ? 
	                               left_write_en_latch :
				       (iright_ftsel == 1'b0 && ileft_ftsel == 1'b1) ?
				       left_write_en_latch_present :
				       (iright_ftsel == 1'b1 && ileft_ftsel == 1'b0) ?
				       left_write_en_latch_prev : left_write_en_latch_active;

  // Active address value for arbitration ckecking
  assign left_ad_active              = (ileft_ftsel == iright_ftsel) ?  
	                               ileft_ad :
	                               (ileft_ftsel == 1'b0 && iright_ftsel == 1'b1) ?
				       left_ad_delayed :
			               (ileft_ftsel == 1'b1 && iright_ftsel == 1'b0) ?
				       ileft_addr_present_pipeline :
			               ileft_ad;

  assign right_ad_active             = (iright_ftsel == ileft_ftsel) ?  
	                               iright_ad :
	                               (iright_ftsel == 1'b0 && ileft_ftsel == 1'b1) ?
				       right_ad_delayed :
			               (iright_ftsel == 1'b1 && ileft_ftsel == 1'b0) ? 
				       iright_addr_present_pipeline :
			               iright_ad;
  // Internal signal initialization      
  initial
  begin
    first_reset_complete         <= 1'b0;
    left_clk_last_event          <= 0;
    right_clk_last_event         <= 0;
    left_clk_event_next          <= 0;
    right_clk_event_next         <= 0;
    onleft_busy_1                <= 1'b1;
    onright_busy_1               <= 1'b1;
    onleft_busy_int              <= 1'b1;
    onright_busy_int             <= 1'b1;
    clock_period_l               <= 10;
    clock_period_r               <= 10;
    tCCS                         <= 0;
    nleft_busy_int               <= 1'b1;
    nright_busy_int              <= 1'b1;
    trigger_clk_left             <= 1'b0;
    trigger_clk_right            <= 1'b0;
    nleft_busy_1delay            <= 1'b1;
    nleft_busy_2delay            <= 1'b1;
    nleft_busy_3delay            <= 1'b1;
    nleft_busy_3delay_1          <= 1'b1;
    nleft_busy_4delay            <= 1'b1;
    nright_busy_1delay           <= 1'b1;
    nright_busy_2delay           <= 1'b1;
    nright_busy_3delay           <= 1'b1;
    nright_busy_3delay_1         <= 1'b1;
    nright_busy_4delay           <= 1'b1;
    left_process_flag            <= 1'b0;
    right_process_flag           <= 1'b0;
    nleft_busy_temp1             <= 1'b1;
    nleft_busy_temp2             <= 1'b1;
    nleft_busy_temp3             <= 1'b1;
    nleft_busy_temp4             <= 1'b1;
    nright_busy_temp1            <= 1'b1;
    nright_busy_temp2            <= 1'b1;
    nright_busy_temp3            <= 1'b1;
    nright_busy_temp4            <= 1'b1;
    left_read_en_latch           <= 1'b0;
    left_write_en_latch          <= 1'b0;
    left_read_en_latch_present   <= 1'b0;
    left_write_en_latch_present  <= 1'b0;
    right_read_en_latch          <= 1'b0;
    right_write_en_latch         <= 1'b0;
    right_read_en_latch_present  <= 1'b0;
    right_write_en_latch_present <= 1'b0;
    left_read_en_latch_prev      <= 1'b0;
    left_write_en_latch_prev     <= 1'b0;
    right_read_en_latch_prev     <= 1'b0;
    right_write_en_latch_prev    <= 1'b0;
    violate_tccs_flag_l     <= 1'b0;
    difference_low_flag_l   <= 1'b0;
    violate_tccs_flag_r     <= 1'b0;
    difference_low_flag_r   <= 1'b0;
    
    obusy_addr_left              <= {CYP_ADDRWIDTH{1'bZ}};
    obusy_addr_right             <= {CYP_ADDRWIDTH{1'bZ}};
    trigger_clk_left_update      <= 1'b1;
    trigger_clk_right_update     <= 1'b1;
    right_busy_change_request_array <= 32'b0;
    left_busy_change_request_array  <= 32'b0;
    right_request_not_done       <= 1'b0;
    left_request_not_done        <= 1'b0;
    left_clk_edge_count          <= 0;
    right_clk_edge_count         <= 0;
  end

  // Generating the delayed address bus for Left address
  always @(ileft_ad)
     left_ad_delayed <= #(clock_period_l) ileft_ad;

  // Generating the delayed address bus for Right address
  always @(iright_ad)
    right_ad_delayed <= #(clock_period_r) iright_ad; 

  // Left port control signals updation
  always @(posedge ileft_clk or inreset)
  begin

    left_request_not_done = 1'b0;
    left_clk_edge_count   = left_clk_edge_count + 1;
    right_clk_edge_count   = 0;

    if(inreset == 1'b0)
    begin 
      first_reset_complete          <= 1'b1;
      onleft_busy_1                 <= 1'b1;
      onleft_busy_int               <= 1'b1;
      tCCS                          <= 0;
      nleft_busy_int                <= 1'b1;
      right_busy_change_request_array <= 32'b0;
      nleft_busy_temp1              <= 1'b1;
      nleft_busy_temp2              <= 1'b1;
      nleft_busy_temp3              <= 1'b1;
      nleft_busy_temp4              <= 1'b1;
      nleft_busy_1delay             <= 1'b1;
      nleft_busy_2delay             <= 1'b1;
      nleft_busy_3delay             <= 1'b1;
      nleft_busy_3delay_1           <= 1'b1;
      nleft_busy_4delay             <= 1'b1;
      left_process_flag             <= 1'b0;
      left_read_en_latch            <= 1'b0;
      left_write_en_latch           <= 1'b0;
      left_read_en_latch_present    <= 1'b0;
      left_write_en_latch_present   <= 1'b0;
      left_read_en_latch_prev       <= 1'b0;
      left_write_en_latch_prev      <= 1'b0;
      violate_tccs_flag_l      <= 1'b0;
      difference_low_flag_l    <= 1'b0;
      violate_tccs_flag_r      <= 1'b0;
      difference_low_flag_r    <= 1'b0;

      obusy_addr_left               <= {CYP_ADDRWIDTH{1'bZ}};
    end
    else if(inreset == 1'b1)
    begin

      // Wait until right port process complete
      if(right_process_flag == 1'b1)
      begin
        wait(right_process_flag == 1'b0);
      end

      left_process_flag    = 1'b1;

      clock_period_l       = $realtime - left_clk_last_event;
      left_clk_last_event  = $realtime;
      right_clk_event_next = right_clk_last_event + clock_period_r;

      // tCCS Calculation
      if (ileft_ddron == 1'b0 && iright_ddron == 1'b0)
         tCCS = TP.tCYC_min - 1;
      else if (ileft_ddron == 1'b1 && iright_ddron == 1'b0)
         tCCS = 0.55 * TP.tCYC_min - 1;
      else if (ileft_ddron == 1'b0 && iright_ddron == 1'b1)
         tCCS = 1.55 * TP.tCYC_min - 1;
      else if (ileft_ddron == 1'b1 && iright_ddron == 1'b1)
         tCCS = TP.tCYC_min - 1;

      // latch the read and write enables
      left_read_en_latch_prev     = left_read_en_latch;
      left_write_en_latch_prev    = left_write_en_latch;

      left_read_en_latch          = ileft_read_en;
      left_write_en_latch         = ileft_write_en;

      left_read_en_latch_present  = ileft_read_en_present;
      left_write_en_latch_present = ileft_write_en_present;

      read_new_data_l_prev      = read_new_data_l;
      read_corrept_data_l_prev  = read_corrept_data_l;
      write_corrept_data_l_prev = write_corrept_data_l;
      write_new_data_l_prev     = write_new_data_l;

      // Check tCCS violation with respect to previous clock edge
      if(($realtime - right_clk_last_event) < tCCS)
         violate_tccs_flag_l = 1'b1;
      else
	 violate_tccs_flag_l = 1'b0;
 
      if (($realtime - right_clk_last_event) < (0.1 * TP.tCYC_min))
        difference_low_flag_l = 1'b1;
      else
	difference_low_flag_l = 1'b0;
	

      // Arbitration control for left port
      if($realtime > 0)
      begin
	      
      // Arbitration control when left port in pipeline mode
      // and right port in flow through mode.
      
        if(violate_tccs_flag_l == 1'b1)
        begin
          if(ileft_write_en_present == 1'b1 && right_read_en_latch_present == 1'b1)
          begin            
            nleft_busy_int       = 1'b1;
	    if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000001;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b1;
            read_new_data_l      = 1'b0;
            read_corrept_data_l  = 1'b0;
            write_corrept_data_l = 1'b0;
            write_new_data_l     = 1'b1;
          end

          else if(ileft_read_en_present == 1'b1 && right_write_en_latch_present == 1'b1)
          begin
            nleft_busy_int       = 1'b0;
	    if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000000;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b0; 
            read_new_data_l      = 1'b0;
            read_corrept_data_l  = 1'b1;
            write_corrept_data_l = 1'b0;
            write_new_data_l     = 1'b0;
          end
        
          else if(ileft_write_en_present == 1'b1 && right_write_en_latch_present == 1'b1)
          begin           
            if(difference_low_flag_l == 1'b1)
            begin
              // tCCS violation
	      // Memory holds corrupt data
	      // Flags to both the ports
	      nleft_busy_int            = 1'b0;
	      if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000001;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b1;
              read_new_data_l           = 1'b0;
              read_corrept_data_l       = 1'b0;
              write_corrept_data_l      = 1'b1;
              write_new_data_l          = 1'b0;
	    end
	    else
	    begin
              // tCCS violation
	      // Memory holds the left port data
	      // Flag to right ports
	      nleft_busy_int            = 1'b1;
	      if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000001;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b1;
              read_new_data_l           = 1'b0;
              read_corrept_data_l       = 1'b0;
              write_corrept_data_l      = 1'b0;
              write_new_data_l          = 1'b1;
            end
          end

          else if(ileft_read_en_present == 1'b1)
          begin
            nleft_busy_int            = 1'b1;
	    if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000000;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b0;
            read_new_data_l           = 1'b1;
            read_corrept_data_l       = 1'b0;
            write_corrept_data_l      = 1'b0;
            write_new_data_l          = 1'b0;
          end
           
          else if(ileft_write_en_present == 1'b1)
          begin
            nleft_busy_int            = 1'b1;
	    if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000000;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b0;
            read_new_data_l           = 1'b0;
            read_corrept_data_l       = 1'b0;
            write_corrept_data_l      = 1'b0;
            write_new_data_l          = 1'b1;
          end

          else
          begin
            nleft_busy_int            = 1'b1;
	    if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000000;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b0;
            read_new_data_l           = 1'b0;
            read_corrept_data_l       = 1'b0;
            write_corrept_data_l      = 1'b0;
            write_new_data_l          = 1'b0;
          end

        end


        // TCCS met for WRITE-WRITE
	// Memory data is updated
	// Flag for right port
        else if((violate_tccs_flag_l == 1'b0) &&
		(ileft_write_en_present == 1'b1 && right_write_en_latch_present == 1'b1)
	        )
        begin
          nleft_busy_int            = 1'b1;
	  if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000001;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b1;
          read_new_data_l           = 1'b0;
          read_corrept_data_l       = 1'b0;
          write_corrept_data_l      = 1'b0;
          write_new_data_l          = 1'b1;
        end
	  

        else if(ileft_read_en_present == 1'b1)
        begin
          nleft_busy_int            = 1'b1;
	  if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000000;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b0;
          read_new_data_l           = 1'b1;
          read_corrept_data_l       = 1'b0;
          write_corrept_data_l      = 1'b0;
          write_new_data_l          = 1'b0;
        end

        else if(ileft_write_en_present == 1'b1)
        begin
          nleft_busy_int            = 1'b1;
	  if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000000;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b0;
          read_new_data_l           = 1'b0;
          read_corrept_data_l       = 1'b0;
          write_corrept_data_l      = 1'b0;
          write_new_data_l          = 1'b1;
        end

        else
        begin
          nleft_busy_int            = 1'b1;
	  if(left_clk_edge_count == 1 )
	       right_busy_change_request_array = 32'h00000000;
            else
	       right_busy_change_request_array[left_clk_edge_count] = 1'b0;
          read_new_data_l           = 1'b0;
          read_corrept_data_l       = 1'b0;
          write_corrept_data_l      = 1'b0;
          write_new_data_l          = 1'b0;
        end
        #0;
        trigger_clk_left = !(trigger_clk_left);
      
      end
      
    end
  end


  // Right port control signals updation
  always @(posedge iright_clk or inreset)
  begin

    right_request_not_done = 1'b0;
    right_clk_edge_count   = right_clk_edge_count + 1;
    left_clk_edge_count    = 0;

    if(inreset == 1'b0)
    begin 
      onright_busy_1                <= 1'b1;
      onright_busy_int              <= 1'b1;
      tCCS                          <= 0;
      nright_busy_int               <= 1'b1;
      left_busy_change_request_array <= 9'b0;
      nright_busy_temp1             <= 1'b1;
      nright_busy_temp2             <= 1'b1;
      nright_busy_temp3             <= 1'b1;
      nright_busy_temp4             <= 1'b1;
      nright_busy_1delay            <= 1'b1;
      nright_busy_2delay            <= 1'b1;
      nright_busy_3delay            <= 1'b1;
      nright_busy_3delay_1          <= 1'b1;
      nright_busy_4delay            <= 1'b1;
      right_process_flag            <= 1'b0;
      right_read_en_latch           <= 1'b0;
      right_write_en_latch          <= 1'b0;
      right_read_en_latch_present   <= 1'b0;
      right_write_en_latch_present  <= 1'b0;
      right_read_en_latch_prev      <= 1'b0;
      right_write_en_latch_prev     <= 1'b0;
      violate_tccs_flag_r      <= 1'b0;
      difference_low_flag_r    <= 1'b0;
      violate_tccs_flag_l      <= 1'b0;
      difference_low_flag_l    <= 1'b0;

      obusy_addr_right              <= {CYP_ADDRWIDTH{1'bZ}};
    end
    else if(inreset == 1'b1)
    begin

      // Wait until left port process complete
      if(left_process_flag == 1'b1)
      begin
        wait(left_process_flag == 1'b0);
      end

      right_process_flag    = 1'b1;
      
      clock_period_r        = $realtime - right_clk_last_event;
      right_clk_last_event  = $realtime;
      left_clk_event_next   = right_clk_last_event + clock_period_l;

      // tCCS Calculation
      if (iright_ddron == 1'b0 && ileft_ddron == 1'b0)
         tCCS = TP.tCYC_min - 1;
      else if (iright_ddron == 1'b1 && ileft_ddron == 1'b0)
         tCCS = 0.55 * TP.tCYC_min - 1;
      else if (iright_ddron == 1'b0 && ileft_ddron == 1'b1)
         tCCS = 1.55 * TP.tCYC_min - 1;
      else if (iright_ddron == 1'b1 && ileft_ddron == 1'b1)
         tCCS = TP.tCYC_min - 1;

      // latch the read and write enables
      right_read_en_latch_prev     = right_read_en_latch;
      right_write_en_latch_prev    = right_write_en_latch;

      right_read_en_latch          = iright_read_en;
      right_write_en_latch         = iright_write_en;

      right_read_en_latch_present  = iright_read_en_present;
      right_write_en_latch_present = iright_write_en_present;

      read_new_data_r_prev      = read_new_data_r;
      read_corrept_data_r_prev  = read_corrept_data_r;
      write_corrept_data_r_prev = write_corrept_data_r;
      write_new_data_r_prev     = write_new_data_r;

      // Check tCCS violation with respect to previous clock edge
      if(($realtime - left_clk_last_event) < tCCS)
         violate_tccs_flag_r = 1'b1;
      else
	 violate_tccs_flag_r = 1'b0;
 
      if (($realtime - left_clk_last_event) < (0.1 * TP.tCYC_min))
        difference_low_flag_r = 1'b1;
      else
	difference_low_flag_r = 1'b0;


      // Arbitration control for right port
      
      if($realtime > 0 )
      begin
      
      // Arbitration control when right port in flow through mode
      // and left port in pipeline mode.
      // Update Right port arbitration control signals immediately

        if(violate_tccs_flag_r == 1'b1)
        begin
          if(iright_write_en_present == 1'b1 && left_read_en_latch_present == 1'b1)
          begin            
            nright_busy_int          = 1'b1;
	    if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000001;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b1;
            read_new_data_r          = 1'b0;
            read_corrept_data_r      = 1'b0;
            write_corrept_data_r     = 1'b0;
            write_new_data_r         = 1'b1;
          end

          else if(iright_read_en_present == 1'b1 && left_write_en_latch_present == 1'b1)
          begin
            nright_busy_int          = 1'b0;
	    if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000000;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b0;
            read_new_data_r          = 1'b0;
            read_corrept_data_r      = 1'b1;
            write_corrept_data_r     = 1'b0;
            write_new_data_r         = 1'b0;
          end
        
          else if(iright_write_en_present == 1'b1 && left_write_en_latch_present == 1'b1)
          begin           
            if(difference_low_flag_r == 1'b1)
            begin
              // tCCS violation
	      // Memory holds corrupt data
	      // Flags to both the ports
	      nright_busy_int          = 1'b0;
	      if(right_clk_edge_count == 1 )
	        left_busy_change_request_array = 32'h00000001;
              else
	        left_busy_change_request_array[right_clk_edge_count] = 1'b1;
              read_new_data_r          = 1'b0;
              read_corrept_data_r      = 1'b0;
              write_corrept_data_r     = 1'b1;
              write_new_data_r         = 1'b0;
	    end
	    else
	    begin
              // tCCS violation
	      // Memory holds the right port data
	      // Flag to left ports
	      nright_busy_int          = 1'b1;
	      if(right_clk_edge_count == 1 )
	        left_busy_change_request_array = 32'h00000001;
              else
	        left_busy_change_request_array[right_clk_edge_count] = 1'b1;
              read_new_data_r          = 1'b0;
              read_corrept_data_r      = 1'b0;
              write_corrept_data_r     = 1'b0;
              write_new_data_r         = 1'b1;
            end
          end

          else if(iright_read_en_present == 1'b1)
          begin
            nright_busy_int          = 1'b1;
	    if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000000;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b0;
            read_new_data_r          = 1'b1;
            read_corrept_data_r      = 1'b0;
            write_corrept_data_r     = 1'b0;
            write_new_data_r         = 1'b0;
          end
           
          else if(iright_write_en_present == 1'b1)
          begin
            nright_busy_int          = 1'b1;
	    if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000000;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b0;
            read_new_data_r          = 1'b0;
            read_corrept_data_r      = 1'b0;
            write_corrept_data_r     = 1'b0;
            write_new_data_r         = 1'b1;
          end

          else
          begin
            nright_busy_int          = 1'b1;
	    if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000000;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b0;
            read_new_data_r          = 1'b0;
            read_corrept_data_r      = 1'b0;
            write_corrept_data_r     = 1'b0;
            write_new_data_r         = 1'b0;
          end

        end


        // TCCS is met for WRITE-WRITE
	// Memory data is updated
	// Flag for left port
        else if((violate_tccs_flag_r == 1'b0) &&
		(iright_write_en_present == 1'b1 && left_write_en_latch_present == 1'b1)
	        )
        begin
          nright_busy_int          = 1'b1;
	  if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000001;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b1;
          read_new_data_r          = 1'b0;
          read_corrept_data_r      = 1'b0;
          write_corrept_data_r     = 1'b0;
          write_new_data_r         = 1'b1;
        end
	  

        else if(iright_read_en_present == 1'b1)
        begin
          nright_busy_int          = 1'b1;
	  if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000000;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b0;
          read_new_data_r          = 1'b1;
          read_corrept_data_r      = 1'b0;
          write_corrept_data_r     = 1'b0;
          write_new_data_r         = 1'b0;
        end

        else if(iright_write_en_present == 1'b1)
        begin
          nright_busy_int          = 1'b1;
	  if(right_clk_edge_count == 1 )
	       left_busy_change_request_array = 32'h00000000;
            else
	       left_busy_change_request_array[right_clk_edge_count] = 1'b0;
          read_new_data_r          = 1'b0;
          read_corrept_data_r      = 1'b0;
          write_corrept_data_r     = 1'b0;
          write_new_data_r         = 1'b1;
        end

        else
        begin
          nright_busy_int          = 1'b1;
	  if(right_clk_edge_count == 1 )
	     left_busy_change_request_array = 32'h00000000;
          else
	     left_busy_change_request_array[right_clk_edge_count] = 1'b0;
          read_new_data_r          = 1'b0;
          read_corrept_data_r      = 1'b0;
          write_corrept_data_r     = 1'b0;
          write_new_data_r         = 1'b0;
        end
        #0;
        trigger_clk_right = !(trigger_clk_right);
      
      end
      
    end
  end


  // Memory updation
  always @(trigger_clk_left or trigger_clk_right)
  begin

    // Memory update as per left port address and data
    if(trigger_clk_left !== trigger_clk_left_update)
    begin
      #0;

      onleft_busy_int = 1'b1;
      obusy_addr_left = {CYP_ADDRWIDTH{1'bZ}}; 

      // Left BUSY# output control signals
      if(left_busy_change_request == 1'b1)
      begin
          nleft_busy_3delay_1 = 1'b0;
	  left_busy_change_request_array = 32'h00000000;
      end
      else
      begin
        nleft_busy_3delay_1 = 1'b1;
      end

        if(ileft_addr_present_pipeline === iright_addr_present_pipeline)
        begin
	      
          if(right_busy_change_request_array[left_clk_edge_count] == 1'b1)
          begin
            onright_busy_int = 1'b0;
            obusy_addr_right = iright_addr_present_pipeline;
          end

          if(nleft_busy_int == 1'b0)
          begin
	    nleft_busy_4delay = 1'b0;
            onleft_busy_int      = 1'b0;
            obusy_addr_left      = ileft_addr_present_pipeline;
          end
          else
          begin
	    nleft_busy_4delay = 1'b1; 
          end

        end
        else
        begin
          right_busy_change_request_array[left_clk_edge_count] = 1'b0;
	  nleft_busy_4delay      = 1'b1;
	  
          read_corrept_data_l   = 1'b0;
          write_corrept_data_l  = 1'b0;
	  if(ileft_read_en_present == 1'b1)
	  begin
             read_new_data_l = 1'b1;
	  end
	  else
	  begin
             read_new_data_l = 1'b0;
	  end
	  if(ileft_write_en_present == 1'b1)
	  begin
             write_new_data_l = 1'b1;
	  end
	  else
	  begin
             write_new_data_l = 1'b0;
	  end
	  
        end

      // Read and Write operations
      if(ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)
      begin
         memory_read_value_actual_l = memory_read_value_l;
      end
      
      if(((ileft_ftsel == 1'b0 || (ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)) &&
	   ((ileft_ad === right_ad_active && read_new_data_l == 1'b1) ||
            (ileft_ad !== right_ad_active && read_new_data_l == 1'b1))
	 ) ||
         ((ileft_ftsel == 1'b1 && ileft_ddron == 1'b1) && (read_new_data_l_prev == 1'b1))
        ) 
      begin
        
	if(ileft_ftsel == 1'b0 || (ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)) 
           memory_read_value_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0]= dpsram[ileft_addr_present_pipeline];
        else
           memory_read_value_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0]= dpsram[ileft_ad];
        if(ileft_ddron == 1'b0)
        begin
          if(inleft_be[0] == 1'b1) memory_read_value_l[8:0]   = 9'bZ;
          if(inleft_be[1] == 1'b1) memory_read_value_l[17:9]  = 9'bZ;
          if(DW_36_72 == 1 && inleft_be[2 * DW_36_72] == 1'b1) 
		  memory_read_value_l[26 * DW_36_72:18 * DW_36_72] = 9'bZ;
          if(DW_36_72 == 1 && inleft_be[3 * DW_36_72] == 1'b1) 
		  memory_read_value_l[35 * DW_36_72:27 * DW_36_72] = 9'bZ;
          if(DW_72 == 1 && inleft_be[4 * DW_72] == 1'b1) 
		  memory_read_value_l[44 * DW_72:36 * DW_72] = 9'bZ;
          if(DW_72 == 1 && inleft_be[5 * DW_72] == 1'b1) 
		  memory_read_value_l[53 * DW_72:45 * DW_72] = 9'bZ;
          if(DW_72 == 1 && inleft_be[6 * DW_72] == 1'b1) 
		  memory_read_value_l[62 * DW_72:54 * DW_72] = 9'bZ;
          if(DW_72 == 1 && inleft_be[7 * DW_72] == 1'b1) 
		  memory_read_value_l[71 * DW_72:63 * DW_72] = 9'bZ;
        end
      end
      else if (((ileft_ftsel == 1'b0 || (ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)) && 
	        ((ileft_ad === right_ad_active) && (read_corrept_data_l == 1'b1))
	       ) ||
	       ((ileft_ftsel == 1'b1 && ileft_ddron == 1'b1) && (read_corrept_data_l_prev == 1'b1)))
      begin
        memory_read_value_l = 72'bX;
      end
      else if(((ileft_ftsel == 1'b0 || (ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)) &&
	       (((ileft_ad === right_ad_active) && (write_new_data_l == 1'b1)) ||
                ((ileft_ad !== right_ad_active) && (write_new_data_l == 1'b1)))
	      ) ||
	      ((ileft_ftsel == 1'b1 && ileft_ddron == 1'b1) && (write_new_data_l_prev == 1'b1)))
      begin
        memory_write_value_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] = ioleft_data;
	if(ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)
           memory_old_vlue_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] = dpsram[ileft_addr_present_pipeline];
        else
           memory_old_vlue_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] = dpsram[ileft_ad];

        if(inleft_be[0] == 1'b1) 
          memory_write_value_l[8:0]   = memory_old_vlue_l[8:0];
        if(inleft_be[1] == 1'b1) 
          memory_write_value_l[17:9]  = memory_old_vlue_l[17:9];
        if(DW_36_72 == 1 && inleft_be[2* DW_36_72] == 1'b1) 
          memory_write_value_l[26* DW_36_72:18* DW_36_72] = memory_old_vlue_l[26* DW_36_72:18* DW_36_72];
        if(DW_36_72 == 1 && inleft_be[3* DW_36_72] == 1'b1) 
          memory_write_value_l[35* DW_36_72:27* DW_36_72] = memory_old_vlue_l[35* DW_36_72:27* DW_36_72];
        if(DW_72 == 1 && inleft_be[4* DW_72] == 1'b1) 
          memory_write_value_l[44* DW_72:36* DW_72] = memory_old_vlue_l[44* DW_72:36* DW_72];
        if(DW_72 == 1 && inleft_be[5* DW_72] == 1'b1) 
          memory_write_value_l[53* DW_72:45* DW_72] = memory_old_vlue_l[53* DW_72:45* DW_72];
        if(DW_72 == 1 && inleft_be[6* DW_72] == 1'b1) 
          memory_write_value_l[62* DW_72:54* DW_72] = memory_old_vlue_l[62* DW_72:54* DW_72];
        if(DW_72 == 1 && inleft_be[7* DW_72] == 1'b1) 
          memory_write_value_l[71* DW_72:63* DW_72] = memory_old_vlue_l[71* DW_72:63* DW_72];
        if(ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)
           dpsram[ileft_addr_present_pipeline]= memory_write_value_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0];
	else
           dpsram[ileft_ad]= memory_write_value_l[CYP_DDR_MULT*CYP_DATAWIDTH -1:0];
      end
  
      else if(((ileft_ftsel == 1'b0 || (ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)) && 
	       ((ileft_ad === right_ad_active) &&  (write_corrept_data_l == 1'b1))
	      ) ||
	      ((ileft_ftsel == 1'b1 && ileft_ddron == 1'b1) && (write_corrept_data_l_prev == 1'b1)))
      begin
     
        if(ileft_ftsel == 1'b1 && ileft_ddron == 1'b0)
           dpsram[ileft_addr_present_pipeline]= {CYP_DDR_MULT*CYP_DATAWIDTH{1'bX}};
	else
           dpsram[ileft_ad]= {CYP_DDR_MULT*CYP_DATAWIDTH{1'bX}};
   
      end
      if(!(ileft_ftsel == 1'b1 && ileft_ddron == 1'b0))
      begin
         memory_read_value_actual_l = memory_read_value_l;
      end
      trigger_clk_left_update      = trigger_clk_left;
      right_request_not_done       = 1'b1;
      left_process_flag            = 1'b0;
    end


    // Memory update as per right port address and data 
    if(trigger_clk_right !== trigger_clk_right_update)
    begin
      #0;

      onright_busy_int = 1'b1;
      obusy_addr_right = {CYP_ADDRWIDTH{1'bZ}}; 

      // Right BUSY# output control signals
      if(right_busy_change_request == 1'b1)
      begin
	 nright_busy_3delay_1 = 1'b0;
	 right_busy_change_request_array = 32'h00000000;
      end
      else
      begin
         nright_busy_3delay_1 = 1'b1; 
      end

        if(iright_addr_present_pipeline === ileft_addr_present_pipeline)
        begin
          if(left_busy_change_request_array[right_clk_edge_count] == 1'b1)
          begin
            onleft_busy_int  = 1'b0;
            obusy_addr_left  = ileft_addr_present_pipeline;
          end

  
          if(nright_busy_int == 1'b0)
          begin
	    nright_busy_4delay = 1'b0; 
            onright_busy_int      = 1'b0;
            obusy_addr_right      = iright_addr_present_pipeline; 
          end
          else
          begin
	    nright_busy_4delay = 1'b1; 
          end
        end
        else 
        begin
          left_busy_change_request_array[right_clk_edge_count] = 1'b0;
	  nright_busy_4delay = 1'b1;
	  
	  read_corrept_data_r   = 1'b0;
          write_corrept_data_r  = 1'b0;
	  if(iright_read_en_present == 1'b1)
	  begin
             read_new_data_r = 1'b1;
	  end
	  else
	  begin
             read_new_data_r = 1'b0;
	  end
	  if(iright_write_en_present == 1'b1)
	  begin
             write_new_data_r = 1'b1;
	  end
	  else
	  begin
             write_new_data_r = 1'b0;
	  end 
        end

      // Memory read and write operation
      if(iright_ftsel == 1'b1 && iright_ddron == 1'b0)
      begin
         memory_read_value_actual_r = memory_read_value_r;
      end
      
      if(((iright_ftsel == 1'b0 || (iright_ftsel == 1'b1 && iright_ddron == 1'b0)) &&
	  ((iright_ad === left_ad_active && read_new_data_r == 1'b1) ||
           (iright_ad !== left_ad_active && read_new_data_r == 1'b1))) ||
	  ((iright_ftsel == 1'b1 && iright_ddron == 1'b1) && (read_new_data_r_prev == 1'b1)))
      begin

	if(iright_ftsel == 1'b0 || (iright_ftsel == 1'b1 && iright_ddron == 1'b0)) 
           memory_read_value_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0]= dpsram[iright_addr_present_pipeline];
        else
           memory_read_value_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0]= dpsram[iright_ad];
   
        if(iright_ddron == 1'b0)
        begin
          if(inright_be[0] == 1'b1) memory_read_value_r[8:0]   = 9'bZ;
          if(inright_be[1] == 1'b1) memory_read_value_r[17:9]  = 9'bZ;
          if(DW_36_72 == 1)
	  begin 
            if(inright_be[2* DW_36_72] == 1'b1) memory_read_value_r[26* DW_36_72:18* DW_36_72] = 9'bZ;
            if(inright_be[3* DW_36_72] == 1'b1) memory_read_value_r[35* DW_36_72:27* DW_36_72] = 9'bZ;
	  end
          if(DW_72 == 1)
	  begin
            if(inright_be[4* DW_72] == 1'b1) memory_read_value_r[44* DW_72:36* DW_72] = 9'bZ;
            if(inright_be[5* DW_72] == 1'b1) memory_read_value_r[53* DW_72:45* DW_72] = 9'bZ;
            if(inright_be[6* DW_72] == 1'b1) memory_read_value_r[62* DW_72:54* DW_72] = 9'bZ;
            if(inright_be[7* DW_72] == 1'b1) memory_read_value_r[71* DW_72:63* DW_72] = 9'bZ;
	  end
        end
      end
      else if(((iright_ftsel == 1'b0 || (iright_ftsel == 1'b1 && iright_ddron == 1'b0)) &&   
	       ((iright_ad === left_ad_active) && (read_corrept_data_r == 1'b1))) ||
	      ((iright_ftsel == 1'b1 && iright_ddron == 1'b1) && (read_corrept_data_r_prev == 1'b1)))
      begin
	      
        memory_read_value_r = 72'bX;
      end
      else if(((iright_ftsel == 1'b0 || (iright_ftsel == 1'b1 && iright_ddron == 1'b0)) &&
	        ((iright_ad === left_ad_active && write_new_data_r == 1'b1) ||
                 (iright_ad !== left_ad_active && write_new_data_r == 1'b1))) ||
	      ((iright_ftsel == 1'b1 && iright_ddron == 1'b1) && (write_new_data_r_prev == 1'b1)))
      begin
        memory_write_value_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] = ioright_data;
	if(iright_ftsel == 1'b1 && iright_ddron == 1'b0)
           memory_old_vlue_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] = dpsram[iright_addr_present_pipeline];
        else
	   memory_old_vlue_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0] = dpsram[iright_ad];

        if(inright_be[0] == 1'b1) 
          memory_write_value_r[8:0]   = memory_old_vlue_r[8:0];
        if(inright_be[1] == 1'b1) 
          memory_write_value_r[17:9]  = memory_old_vlue_r[17:9];

        if(DW_36_72 == 1)
	begin
          if(inright_be[2* DW_36_72] == 1'b1) 
            memory_write_value_r[26* DW_36_72:18* DW_36_72] = memory_old_vlue_r[26* DW_36_72:18* DW_36_72];
          if(inright_be[3* DW_36_72] == 1'b1) 
            memory_write_value_r[35* DW_36_72:27* DW_36_72] = memory_old_vlue_r[35* DW_36_72:27* DW_36_72];
        end
	if(DW_72 == 1)
	begin
          if(inright_be[4* DW_72] == 1'b1) 
            memory_write_value_r[44* DW_72:36* DW_72] = memory_old_vlue_r[44* DW_72:36* DW_72];
          if(inright_be[5* DW_72] == 1'b1) 
            memory_write_value_r[53* DW_72:45* DW_72] = memory_old_vlue_r[53* DW_72:45* DW_72];
          if(inright_be[6* DW_72] == 1'b1) 
            memory_write_value_r[62* DW_72:54* DW_72] = memory_old_vlue_r[62* DW_72:54* DW_72];
          if(inright_be[7* DW_72] == 1'b1) 
            memory_write_value_r[71* DW_72:63* DW_72] = memory_old_vlue_r[71* DW_72:63* DW_72];
        end
        if(iright_ftsel == 1'b1 && iright_ddron == 1'b0)
           dpsram[iright_addr_present_pipeline]= memory_write_value_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0];
	else
           dpsram[iright_ad]= memory_write_value_r[CYP_DDR_MULT*CYP_DATAWIDTH -1:0];
      end
      else if(((iright_ftsel == 1'b0 || (iright_ftsel == 1'b1 && iright_ddron == 1'b0)) &&
	       ((iright_ad === left_ad_active) && (write_corrept_data_r == 1'b1))) ||
	      ((iright_ftsel == 1'b1 && iright_ddron == 1'b1) && (write_corrept_data_r_prev == 1'b1)))
      begin

	if(iright_ftsel == 1'b1 && iright_ddron == 1'b0)
           dpsram[iright_addr_present_pipeline]= {CYP_DDR_MULT*CYP_DATAWIDTH{1'bX}};
	else
           dpsram[iright_ad] = {CYP_DDR_MULT*CYP_DATAWIDTH{1'bX}};
      end
      if(!(iright_ftsel == 1'b1 && iright_ddron == 1'b0))
      begin
         memory_read_value_actual_r = memory_read_value_r;
      end
      
      trigger_clk_right_update     = trigger_clk_right;
      left_request_not_done        = 1'b1;
      right_process_flag           = 1'b0;
    end

  end


  // BUSY# output generation for left port
  always @(posedge ileft_clk)
  begin
       nleft_busy_temp4 = nleft_busy_temp3;
       nleft_busy_temp3 = (nleft_busy_2delay == 1'b0)? 1'b0 : nleft_busy_temp2;
       nleft_busy_temp2 = (nleft_busy_3delay == 1'b0 || nleft_busy_3delay_1 == 1'b0)? 
	                  1'b0 : nleft_busy_temp1;
       nleft_busy_temp1 = nleft_busy_4delay;
       #(TP.tBSY_l);
       onleft_busy_1    = nleft_busy_temp4;
  end


  // BUSY# output generation for right port
  always @(posedge iright_clk)
  begin
       nright_busy_temp4 = nright_busy_temp3;
       nright_busy_temp3 = (nright_busy_2delay == 1'b0) ? 1'b0 : nright_busy_temp2;
       nright_busy_temp2 = (nright_busy_3delay == 1'b0 || nright_busy_3delay_1 == 1'b0)?
	                   1'b0 : nright_busy_temp1;
       nright_busy_temp1 = nright_busy_4delay;

       #(TP.tBSY_r);
       onright_busy_1    = nright_busy_temp4;
  end

endmodule



