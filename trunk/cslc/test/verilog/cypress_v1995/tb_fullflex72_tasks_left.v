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
// File           : tb_fullflex72_tasks_left.v
// Author         : 
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
// This file contains all the testcase tasks for left port
//
// *******************************************************************


  // Task for Left Port SDR mode write operation using the address bus
  task sdr_write_addr_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   input [CYP_DDR_MULT* `CYP_DATAWIDTH - 1: 0] data_l;
   input [`CYP_BYTEWIDTH - 1: 0] byte_l;
   reg [CYP_DDR_MULT*`CYP_DATAWIDTH -1:0] memory_data_temp;

   begin

    //counter_hold_l;
    inleft_be     = byte_l;
    a_rw_l        = address_l;
    dq_write_l    = data_l;
    memory_data_temp = memory_data[address_l];
  `ifdef SDR
    if(byte_l[0] == 1'b0) memory_data_temp[8:0]   = data_l[8:0];
    if(byte_l[1] == 1'b0) memory_data_temp[17:9]  = data_l[17:9];
    if(byte_l[2] == 1'b0) memory_data_temp[26:18] = data_l[26:18];
    if(byte_l[3] == 1'b0) memory_data_temp[35:27] = data_l[35:27];
  `else 
    if(byte_l[0] == 1'b0) memory_data_temp[8:0]   = data_l[8:0];
    if(byte_l[1] == 1'b0) memory_data_temp[17:9]  = data_l[17:9];
    if(DW_36_72 == 1 && byte_l[2 * DW_36_72] == 1'b0) 
       memory_data_temp[26 * DW_36_72:18 * DW_36_72] = data_l[26 * DW_36_72:18 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[3 * DW_36_72] == 1'b0) 
       memory_data_temp[35 * DW_36_72:27 * DW_36_72] = data_l[35 * DW_36_72:27 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[4 * DW_36_72] == 1'b0) 
       memory_data_temp[44 * DW_36_72:36 * DW_36_72] = data_l[44 * DW_36_72:36 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[5 * DW_36_72] == 1'b0) 
       memory_data_temp[53 * DW_36_72:45 * DW_36_72] = data_l[53 * DW_36_72:45 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[6 * DW_36_72] == 1'b0) 
       memory_data_temp[62 * DW_36_72:54 * DW_36_72] = data_l[62 * DW_36_72:54 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[7 * DW_36_72] == 1'b0) 
       memory_data_temp[71 * DW_36_72:63 * DW_36_72] = data_l[71 * DW_36_72:63 * DW_36_72];
    
  `endif
    memory_data[address_l] = memory_data_temp;

   end
  endtask


  // Task for Left Port SDR mode write operation using the burst counter
  task sdr_write_counter_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   input [CYP_DDR_MULT* `CYP_DATAWIDTH - 1: 0] data_l;
   input [`CYP_BYTEWIDTH - 1: 0] byte_l;
   reg [71:0] memory_data_temp;

   begin

    inleft_be     = byte_l;
    dq_write_l    = data_l;
    memory_data_temp = memory_data[address_l];
    `ifdef SDR 
    if(byte_l[0] == 1'b0) memory_data_temp[8:0]   = data_l[8:0];
    if(byte_l[1] == 1'b0) memory_data_temp[17:9]  = data_l[17:9];
    if(byte_l[2] == 1'b0) memory_data_temp[26:18] = data_l[26:18];
    if(byte_l[3] == 1'b0) memory_data_temp[35:27] = data_l[35:27];
    `else 
    if(byte_l[0] == 1'b0) memory_data_temp[8:0]   = data_l[8:0];
    if(byte_l[1] == 1'b0) memory_data_temp[17:9]  = data_l[17:9];
    if(DW_36_72 == 1 && byte_l[2 * DW_36_72] == 1'b0) 
       memory_data_temp[26 * DW_36_72:18 * DW_36_72] = data_l[26 * DW_36_72:18 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[3 * DW_36_72] == 1'b0) 
       memory_data_temp[35 * DW_36_72:27 * DW_36_72] = data_l[35 * DW_36_72:27 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[4 * DW_36_72] == 1'b0) 
       memory_data_temp[44 * DW_36_72:36 * DW_36_72] = data_l[44 * DW_36_72:36 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[5 * DW_36_72] == 1'b0) 
       memory_data_temp[53 * DW_36_72:45 * DW_36_72] = data_l[53 * DW_36_72:45 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[6 * DW_36_72] == 1'b0) 
       memory_data_temp[62 * DW_36_72:54 * DW_36_72] = data_l[62 * DW_36_72:54 * DW_36_72];
    if(DW_36_72 == 1 && byte_l[7 * DW_36_72] == 1'b0) 
       memory_data_temp[71 * DW_36_72:63 * DW_36_72] = data_l[71 * DW_36_72:63 * DW_36_72];
    `endif

    memory_data[address_l] = memory_data_temp;

   end
  endtask


  // Task for Left Port DDR mode write operation using address bus
  task ddr_write_addr_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
     input [(CYP_DDR_MULT* `CYP_DATAWIDTH/2 - 1): 0] data_l;
     input [`CYP_BYTEWIDTH - 1: 0] byte_l;
     reg [CYP_DDR_MULT*`CYP_DATAWIDTH - 1:0] memory_data_temp;

   begin
    if(ileft_clk == 1'b0) a_rw_l  = address_l;
    inleft_be     = byte_l;
    if(`CYP_ISDDR == 1)
       dq_write_l         = data_l;
    else
    begin
       dq_write_l[08:00]  = data_l[08:00];
       dq_write_l[26:18]  = data_l[17:09];
       if(DW_36_72 == 1)
       begin
         dq_write_l[44:36]  = data_l[26:18];
         dq_write_l[62:54]  = data_l[35:27];
       end
    end
    memory_data_temp   = memory_data[address_l];
    if(ileft_clk == 1'b0) begin
      if(`CYP_ISDDR == 1)
      begin
	if(DW_36_72 == 1 && byte_l[3] == 1'b0) 
		memory_data_temp[71:63] = data_l[35:27];
	if(DW_36_72 == 1 && byte_l[2] == 1'b0) 
		memory_data_temp[53:45] = data_l[26:18];
        if(byte_l[1] == 1'b0) memory_data_temp[35:27] = data_l[17:09];
        if(byte_l[0] == 1'b0) memory_data_temp[17:09] = data_l[08:00];
      end
      else
      begin
	if(DW_36_72 == 1 && byte_l[6] == 1'b0) 
		memory_data_temp[71:63] = data_l[35:27];
        if(DW_36_72 == 1 && byte_l[4] == 1'b0) 
		memory_data_temp[53:45] = data_l[26:18];
	if(DW_36_72 == 1 && byte_l[2] == 1'b0) 
		memory_data_temp[35:27] = data_l[17:09];
        if(byte_l[0] == 1'b0) memory_data_temp[17:09] = data_l[08:00];
      end	
    end else begin
      if(`CYP_ISDDR == 1)
      begin
	 if(DW_36_72 == 1 && byte_l[3] == 1'b0) 
		memory_data_temp[62:54] = data_l[35:27];
	 if(DW_36_72 == 1 && byte_l[2] == 1'b0) 
		memory_data_temp[44:36] = data_l[26:18];
         if(byte_l[1] == 1'b0) memory_data_temp[26:18] = data_l[17:09];
         if(byte_l[0] == 1'b0) memory_data_temp[08:00] = data_l[08:00];
      end
      else
      begin
	 if(DW_36_72 == 1 && byte_l[6] == 1'b0) 
		memory_data_temp[62:54] = data_l[35:27];
	 if(DW_36_72 == 1 && byte_l[4] == 1'b0) 
		memory_data_temp[44:36] = data_l[26:18];
	 if(DW_36_72 == 1 && byte_l[2] == 1'b0) 
		memory_data_temp[26:18] = data_l[17:09];
         if(byte_l[0] == 1'b0) memory_data_temp[08:00] = data_l[08:00];
      end
    end
    memory_data[address_l] = memory_data_temp;
   end
  endtask


  // Task for Left Port DDR mode write operation using burst counter
  task ddr_write_counter_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   input [CYP_DDR_MULT* `CYP_DATAWIDTH/2 - 1: 0] data_l;
   reg [CYP_DDR_MULT* `CYP_DATAWIDTH -1 :0] memory_data_temp;
  
   begin
   `ifdef SDR  
    `else 
    if(`CYP_ISDDR == 1)
       dq_write_l         = data_l;
    else
    begin
       dq_write_l[08:00]  = data_l[08:00];
       dq_write_l[26:18]  = data_l[17:09];
       if(DW_36_72 == 1)
       begin
         dq_write_l[44:36]  = data_l[26:18];
         dq_write_l[62:54]  = data_l[35:27];
       end
    end
    memory_data_temp = memory_data[address_l];
    if(ileft_clk == 1'b0) begin
      if(DW_36_72 == 1)
      begin
        memory_data_temp[71:63] = data_l[35:27];
        memory_data_temp[53:45] = data_l[26:18];
      end
      memory_data_temp[35:27] = data_l[17:9];
      memory_data_temp[17:9]  = data_l[8:0];
    end else begin
      if(DW_36_72 == 1)
      begin
        memory_data_temp[62:54] = data_l[35:27];
        memory_data_temp[44:36] = data_l[26:18];
      end
      memory_data_temp[26:18] = data_l[17:9];
      memory_data_temp[8:0]   = data_l[8:0];
    end
    memory_data[address_l] = memory_data_temp;
    `endif
   end
  endtask


  // Task for Left Port SDR mode read operation using address bus
  task sdr_read_addr_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   input [`CYP_BYTEWIDTH - 1: 0] byte_l;

   begin

    //counter_hold_l;
    inleft_be     = byte_l;
    a_rw_l  = address_l;
   end
  endtask


  // Task for Left Port DDR mode read operation
  task ddr_read_addr_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;

   begin

    //counter_hold_l;
    a_rw_l  = address_l;
   end
  endtask



  // Result comparison operation for SDR mode, left port of the model
  task sdr_compare_result_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   input [`CYP_BYTEWIDTH - 1: 0] byte_enable_l;
   reg [`CYP_DATAWIDTH - 1: 0] expected_result_l;
   reg [`CYP_DATAWIDTH - 1: 0] actual_result_l;
   begin
   
    expected_result_l = memory_data[address_l];
    `ifdef SDR 
    if(byte_enable_l[0] == 1'b1) expected_result_l[8:0]   = 9'bZZZZZZZZZ;
    if(byte_enable_l[1] == 1'b1) expected_result_l[17:9]  = 9'bZZZZZZZZZ;
    if(byte_enable_l[2] == 1'b1) expected_result_l[26:18] = 9'bZZZZZZZZZ;
    if(byte_enable_l[3] == 1'b1) expected_result_l[35:27] = 9'bZZZZZZZZZ;
    `else
    if(byte_enable_l[0] == 1'b1) expected_result_l[8:0]   = 9'bZZZZZZZZZ;
    if(byte_enable_l[1] == 1'b1) expected_result_l[17:9]  = 9'bZZZZZZZZZ;
    if(byte_enable_l[2] == 1'b1) expected_result_l[26:18] = 9'bZZZZZZZZZ;
    if(byte_enable_l[3] == 1'b1) expected_result_l[35:27] = 9'bZZZZZZZZZ;
    if(byte_enable_l[4] == 1'b1) expected_result_l[44:36] = 9'bZZZZZZZZZ;
    if(byte_enable_l[5] == 1'b1) expected_result_l[53:45] = 9'bZZZZZZZZZ;
    if(byte_enable_l[6] == 1'b1) expected_result_l[62:54] = 9'bZZZZZZZZZ;
    if(byte_enable_l[7] == 1'b1) expected_result_l[71:63] = 9'bZZZZZZZZZ;
    `endif
    actual_result_l = ioleft_dq;
    if(actual_result_l === expected_result_l) begin
      if(nmsg == 1'b1)
      begin
        $display("%10.2f TEST PASSED:For memory location %h:",$realtime,address_l);
        $display("                     Ouput Data      = %h ",actual_result_l);
        $display("                     Expected Result = %h ",expected_result_l);
      end
    end else begin
     if(nmsg == 1'b1)
     begin
       $display("%10.2f TEST FAILED:For memory location %h:",$realtime,address_l);
       $display("                     Ouput Data      = %h ",actual_result_l);
       $display("                     Expected Result = %h ",expected_result_l);
     end
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
    end
   end
  endtask

  // Result comparison operation for DDR mode, left port of the model
  task ddr_compare_result_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   reg [CYP_DDR_MULT * `CYP_DATAWIDTH - 1: 0] expected_result_temp_l;
   reg [`CYP_DATAWIDTH   - 1: 0] expected_result_l;
   reg [`CYP_DATAWIDTH   - 1: 0] actual_result_l;
   begin
    `ifdef SDR
    `else
    expected_result_temp_l = memory_data[address_l];
    expected_result_l      = {`CYP_DATAWIDTH{1'bZ}};
    if(`CYP_ISDDR == 1)
    begin
      if(ileft_clk_n == 1'b1) begin
         expected_result_l[08:00] = expected_result_temp_l[17:09];
         expected_result_l[17:09] = expected_result_temp_l[35:27];
	 if(DW_36_72 == 1)
         begin
           expected_result_l[26:18] = expected_result_temp_l[53:45];
           expected_result_l[35:27] = expected_result_temp_l[71:63];
	 end
      end else if(ileft_clk == 1'b1) begin
         expected_result_l[08:00] = expected_result_temp_l[08:00];
         expected_result_l[17:09] = expected_result_temp_l[26:18];
	 if(DW_36_72 == 1)
         begin
           expected_result_l[26:18] = expected_result_temp_l[44:36];
           expected_result_l[35:27] = expected_result_temp_l[62:54];
	 end
      end
    end
    else
    begin
      if(ileft_clk_n == 1'b1) begin
         expected_result_l[08:00] = expected_result_temp_l[17:09];
         expected_result_l[26:18] = expected_result_temp_l[35:27];
	 if(DW_36_72 == 1)
         begin
           expected_result_l[44:36] = expected_result_temp_l[53:45];
           expected_result_l[62:54] = expected_result_temp_l[71:63];
	 end
      end else if(ileft_clk == 1'b1) begin
         expected_result_l[08:00] = expected_result_temp_l[08:00];
         expected_result_l[26:18] = expected_result_temp_l[26:18];
	 if(DW_36_72 == 1)
         begin
           expected_result_l[44:36] = expected_result_temp_l[44:36];
           expected_result_l[62:54] = expected_result_temp_l[62:54];
	 end
      end
    end    
    actual_result_l = ioleft_dq[`CYP_DATAWIDTH - 1: 0];
    if(actual_result_l === expected_result_l) begin
     if(nmsg == 1'b1)
     begin
       $display("%10.2f TEST PASSED:For memory location %b:",$realtime,address_l);
       $display("                     Ouput Data      = %b ",actual_result_l);
       $display("                     Expected Result = %b ",expected_result_l);
     end
    end else begin
     if(nmsg == 1'b1)
     begin
       $display("%10.2f TEST FAILED:For memory location %b:",$realtime,address_l);
       $display("                     Ouput Data      = %b ",actual_result_l);
       $display("                     Expected Result = %b ",expected_result_l);
     end
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
    end
    `endif
   end
  endtask


  // Comparing the result of Left Port Readback operation
  task compare_readback_result_l;

   input [`CYP_ADDRWIDTH - 1 : 0] expected_result;

   begin
     if(ioleft_a === expected_result) begin
       if(nmsg == 1'b1)
       begin
	 $display("%10.2f TEST PASSED: For Readback operation",$realtime);
         $display("                     Output Result = %h ",ioleft_a);
         $display("                     Expected Result = %h ",expected_result);
       end
     end
     else
     begin
       if(nmsg == 1'b1)
       begin
         $display("%10.2f TEST FAILED: For Readback operation",$realtime);
         $display("                     Output Result = %h ",ioleft_a);
         $display("                     Expected Result = %h ",expected_result);
       end
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
     end

     if(ioleft_dq === {`CYP_DATAWIDTH{1'bZ}}) begin
       if(nmsg == 1'b1)
         $display("TEST PASSED: Output Bus Tri-stated during Readback");
     end
     else
     begin
       if(nmsg == 1'b1) 
	 $display("TEST FAILED: Output Bus not Tri-stated during Readback");
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
     end
 
   end
  endtask

  // task for applying master reset to the device
  task master_reset;

   begin
    inmrst        = 1'b0;

    if(ileft_clk_period > iright_clk_period)
    begin
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
    end
    else
    begin
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
    end
    op_read_l     = 1'b0;
    op_read_r     = 1'b0;
    op_write_l    = 1'b0;
    op_write_r    = 1'b0;
    op_readback_l = 1'b0;
    op_readback_r = 1'b0;
    op_config_l   = 1'b1;
    op_config_r   = 1'b1;
    
    inmrst      = 1'b1;
    #10;
   end
  endtask

  // task for left port burst counter reset operation
  task counter_reset_l;

   begin
    ileft_cntrst = 1'b0;
    ileft_cntmsk= 1'b1;
   end
  endtask

  // task for left port mask register reset operation
  task mask_reset_l;

   begin
    ileft_cntrst = 1'b0;
    ileft_cntmsk= 1'b0;
   end
  endtask

  // task for left port burst counter load operation
  task counter_load_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   begin
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    op_config_l   = 1'b0;
    a_rw_l        = address_l;
    ileft_cntrst  = 1'b1;
    ileft_cntmsk  = 1'b1;
    ileft_cnten   = 1'b0;
    ileft_ads     = 1'b0;
   end
  endtask


  // task for keeping the left port burst counter in load mode operation
  task counter_load_mode_l;

   begin
    ileft_cntrst  = 1'b1;
    ileft_cntmsk  = 1'b1;
    ileft_cnten   = 1'b0;
    ileft_ads     = 1'b0;
   end
  endtask

  
  // task for left port mask register load operation
  task mask_load_l;

   input [`CYP_ADDRWIDTH - 1: 0] address_l;
   begin
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;   
    op_config_l   = 1'b0;
    a_rw_l    = address_l;
    ileft_cntrst  = 1'b1;
    ileft_cntmsk = 1'b0;
    ileft_cnten   = 1'b0;
    ileft_ads     = 1'b0;
   end
  endtask

  // task for left port retransmit#1 operation
  task retransmit_1_l;

   begin
    ileft_cntrst  = 1'b1;
    ileft_cntmsk = 1'b1;
    ileft_cnten   = 1'b0;
    ileft_ads     = 1'b1;
    ileft_ret     = 1'b0;
   end
  endtask

  // task for left port burst counter increment operation
  task counter_increment_l;

   begin
    ileft_cntrst  = 1'b1;
    ileft_cntmsk  = 1'b1;
    ileft_cnten   = 1'b0;
    ileft_ads     = 1'b1;
    ileft_ret     = 1'b1;
   end
  endtask


  // task for left port burst counter hold operation
  task counter_hold_l;

   begin
    ileft_cntrst  = 1'b1;
    ileft_cntmsk = 1'b1;
    ileft_cnten   = 1'b1;
    ileft_ads     = 1'b1;
    ileft_ret     = 1'b1;
   end
  endtask

  // task for left port burst counter readback to address bus operation
  task counter_readback_l;

   begin
    ileft_cntrst  = 1'b1;
    ileft_cntmsk = 1'b1;
    ileft_cnten   = 1'b1;
    ileft_ads     = 1'b0;
    ileft_ret     = 1'b1;
   end
  endtask

  // task for left port mask register readback to address bus operation
  task mask_readback_l;

   begin
    ileft_cntrst  = 1'b1;
    ileft_cntmsk = 1'b0;
    ileft_cnten   = 1'b1;
    ileft_ads     = 1'b0;
    ileft_ret     = 1'b1;
   end
  endtask

  // task for left port busy address readback to address bus operation
  task busy_address_readback_l;

   begin
    ileft_cntrst  = 1'b1;
    ileft_cntmsk =  1'b0;
    ileft_cnten   = 1'b1;
    ileft_ads     = 1'b1;
    ileft_ret     = 1'b0;
   end
  endtask


  // This task will drive all the enable pins to enable the
  // read operation
  task enable_read_op_l;

   begin
    inleft_ce0    = 1'b0;
    ileft_ce1     = 1'b1;
    inleft_rw     = 1'b1;
    op_read_l     = 1'b1;
    op_write_l    = 1'b0;
    op_readback_l = 1'b0;
    op_config_l   = 1'b0;
    inleft_oe     = 1'b0;
   end
  endtask


  // This task will drive all the enable pins to enable the
  // write operation
  task enable_write_op_l;

   begin
    inleft_ce0    = 1'b0;
    ileft_ce1     = 1'b1;
    inleft_rw     = 1'b0;
    op_read_l     = 1'b0;
    op_write_l    = 1'b1;
    op_readback_l = 1'b0;
    op_config_l   = 1'b0;
    inleft_oe     = 1'b0;
   end
  endtask


  // This task will drive all the enable pins to enable the
  // readback operation
  task enable_readback_op_l;

   begin
    //inleft_ce0    = 1'b0;
    //ileft_ce1     = 1'b1;
    op_read_l     = 1'b0;
    op_write_l    = 1'b0;
    op_readback_l = 1'b1;
    op_config_l   = 1'b0;
   end
  endtask

  // task for 72 bit random generator
  task randomdata_72bit;

   output [71:0] random_data;
   begin
    random_data  = mem_test[rnd_data_ptr];
    if(rnd_data_ptr >= 150) 
       rnd_data_ptr = 0;
    else
       rnd_data_ptr = rnd_data_ptr + 1;

   end
  endtask


  // This task will configure the model by giving appropriate values for
  // input control pins for SDR mode 2 pipeline stage operation
  task configure_device_sdr2;

   begin
    ileft_ftsel    = 1'b1;
    ileft_ddron    = 1'b0;
    ileft_portstd  = 2'b01;
    iright_ftsel   = 1'b1;
    iright_ddron   = 1'b0;
    iright_portstd = 2'b01;
    op_config_l    = 1'b1;
    op_config_r    = 1'b1;
    a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
    a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
   end
  endtask


  // This task will configure the model by giving appropriate values for
  // input control pins for Flow through mode stage operation
  task configure_device_flow_through;

   begin
    ileft_ftsel    = 1'b0;
    ileft_ddron    = 1'b0;
    ileft_portstd  = 2'b01;
    iright_ftsel   = 1'b0;
    iright_ddron   = 1'b0;
    iright_portstd = 2'b01;
    op_config_l    = 1'b1;
    op_config_r    = 1'b1;
    a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
    a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
   end
  endtask

  
  // This task will configure the model by giving appropriate values for
  // input control pins for DDR mode 2.5 pipeline stage operation
  task configure_device_ddr2;

   begin
    ileft_ftsel    = 1'b1;
    ileft_ddron    = 1'b1;
    ileft_portstd  = 2'b01;
    iright_ftsel   = 1'b1;
    iright_ddron   = 1'b1;
    iright_portstd = 2'b01;
    op_config_l    = 1'b1;
    op_config_r    = 1'b1;
    a_rw_l         = {`CYP_ADDRWIDTH{1'b0}};
    a_rw_r         = {`CYP_ADDRWIDTH{1'b0}};
   end
  endtask


  // This task will check the BUSY# signal for the left port is asserted
  // After four clock periods
  task busy_check_low_after_4_period_l;
    begin
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tBSY_l + offset);
      if(onleft_busy == 1'b0) begin
        if(nmsg == 1'b1)
          $display("%10.2f ARBITRATION TEST PASSED:Left Port BUSY# is asserted",$realtime);
      end 
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Left Port BUSY# is not asserted",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end

      @(posedge ileft_clk);
      #(TP.tBSY_l + offset);
      if(onleft_busy == 1'b1) begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST PASSED:Left Port BUSY# de-asserted after one clock cycle",$realtime);
      end 
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Left Port BUSY# is not de-asserted after one clock cycle",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end

    end
  endtask


  // This task will check the BUSY# signal for the left port is not asserted
  // After four clock periods
  task busy_check_high_after_4_period_l;
    begin
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      @(posedge ileft_clk);
      #(TP.tBSY_l + offset);
      if(onleft_busy == 1'b1) begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST PASSED:Left Port BUSY# is not asserted",$realtime);
      end 
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Left Port BUSY# is asserted",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
  endtask

 
  // This task will check the BUSY# signal for the left port is asserted
   always @(busy_check_low_l)
    begin
      #(TP.tBSY_l+ offset);
      if(onleft_busy == 1'b0) begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST PASSED:Left Port BUSY# is asserted",$realtime); 
      end
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Left Port BUSY# is not asserted",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
  //endtask


  // This task will report a PASS or FAIL message 
  // to the testcases. This task also reset the
  // local FAIL flag 
  task report_test_result;
    input [8*40:1] test_name;
    
    begin

      if(failed_flag_local == 1'b1)
      begin
        if(emsg == 1'b1) $display("TESTCASE %S FAILED", test_name);
      end
      else
      begin
	if(nmsg == 1'b1 || rmsg == 1'b1) $display("TESTCASE %S PASSED", test_name);
      end

      failed_flag_local = 1'b0;
    end
  endtask 
