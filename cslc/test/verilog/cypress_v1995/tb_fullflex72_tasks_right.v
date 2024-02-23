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
// File           :  tb_fullflex72_tasks_right.v
// Author         : 
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
// This file contains the testcase tasks for right port
//
// *******************************************************************


  // Task for Right Port SDR mode write operation using the address bus
  task sdr_write_addr_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   input [`CYP_DATAWIDTH - 1: 0] data_r;
   input [`CYP_BYTEWIDTH - 1: 0] byte_r;
   reg [`CYP_DATAWIDTH -1:0] memory_data_temp;

   begin

    //counter_hold_r;
    inright_be    = byte_r;
    a_rw_r        = address_r;
    dq_write_r    = data_r;
    memory_data_temp = memory_data[address_r];
    `ifdef SDR 
    if(byte_r[0] == 1'b0) memory_data_temp[8:0]   = data_r[8:0];
    if(byte_r[1] == 1'b0) memory_data_temp[17:9]  = data_r[17:9];
    if(byte_r[2] == 1'b0) memory_data_temp[26:18] = data_r[26:18];
    if(byte_r[3] == 1'b0) memory_data_temp[35:27] = data_r[35:27];
    `else
    if(byte_r[0] == 1'b0) memory_data_temp[8:0]   = data_r[8:0];
    if(byte_r[1] == 1'b0) memory_data_temp[17:9]  = data_r[17:9];
    if(DW_36_72 == 1 && byte_r[2 * DW_36_72] == 1'b0) 
       memory_data_temp[26 * DW_36_72:18 * DW_36_72] = data_r[26 * DW_36_72:18 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[3 * DW_36_72] == 1'b0) 
       memory_data_temp[35 * DW_36_72:27 * DW_36_72] = data_r[35 * DW_36_72:27 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[4 * DW_36_72] == 1'b0) 
       memory_data_temp[44 * DW_36_72:36 * DW_36_72] = data_r[44 * DW_36_72:36 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[5 * DW_36_72] == 1'b0) 
       memory_data_temp[53 * DW_36_72:45 * DW_36_72] = data_r[53 * DW_36_72:45 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[6 * DW_36_72] == 1'b0) 
       memory_data_temp[62 * DW_36_72:54 * DW_36_72] = data_r[62 * DW_36_72:54 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[7 * DW_36_72] == 1'b0) 
       memory_data_temp[71 * DW_36_72:63 * DW_36_72] = data_r[71 * DW_36_72:63 * DW_36_72];
    `endif
    memory_data[address_r] = memory_data_temp;

   end
  endtask


  // Task for Right Port SDR mode write operation using the burst counter
  task sdr_write_counter_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   input [`CYP_DATAWIDTH - 1: 0] data_r;
   input [`CYP_BYTEWIDTH - 1: 0] byte_r;
   reg [`CYP_DATAWIDTH -1:0] memory_data_temp;

   begin

    inright_be          = byte_r;
    dq_write_r    = data_r;
    memory_data_temp = memory_data[address_r];
    `ifdef SDR 
    if(byte_r[0] == 1'b0) memory_data_temp[8:0]   = data_r[8:0];
    if(byte_r[1] == 1'b0) memory_data_temp[17:9]  = data_r[17:9];
    if(byte_r[2] == 1'b0) memory_data_temp[26:18] = data_r[26:18];
    if(byte_r[3] == 1'b0) memory_data_temp[35:27] = data_r[35:27];
    `else
    if(byte_r[0] == 1'b0) memory_data_temp[8:0]   = data_r[8:0];
    if(byte_r[1] == 1'b0) memory_data_temp[17:9]  = data_r[17:9];
    if(DW_36_72 == 1 && byte_r[2 * DW_36_72] == 1'b0) 
       memory_data_temp[26 * DW_36_72:18 * DW_36_72] = data_r[26 * DW_36_72:18 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[3 * DW_36_72] == 1'b0) 
       memory_data_temp[35 * DW_36_72:27 * DW_36_72] = data_r[35 * DW_36_72:27 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[4 * DW_36_72] == 1'b0) 
       memory_data_temp[44 * DW_36_72:36 * DW_36_72] = data_r[44 * DW_36_72:36 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[5 * DW_36_72] == 1'b0) 
       memory_data_temp[53 * DW_36_72:45 * DW_36_72] = data_r[53 * DW_36_72:45 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[6 * DW_36_72] == 1'b0) 
       memory_data_temp[62 * DW_36_72:54 * DW_36_72] = data_r[62 * DW_36_72:54 * DW_36_72];
    if(DW_36_72 == 1 && byte_r[7 * DW_36_72] == 1'b0) 
       memory_data_temp[71 * DW_36_72:63 * DW_36_72] = data_r[71 * DW_36_72:63 * DW_36_72];
    `endif
    memory_data[address_r] = memory_data_temp;

   end
  endtask


  // Task for Right Port DDR mode write operation using address bus
  task ddr_write_addr_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
     input [CYP_DDR_MULT * `CYP_DATAWIDTH/2 - 1: 0] data_r;
     input [`CYP_BYTEWIDTH - 1: 0] byte_r;
     reg [CYP_DDR_MULT * `CYP_DATAWIDTH:0] memory_data_temp;

   begin
   `ifdef SDR  
    `else 
    if(iright_clk == 1'b0) a_rw_r  = address_r;
    inright_be     = byte_r;
    if(`CYP_ISDDR == 1)
       dq_write_r         = data_r;
    else
    begin
       dq_write_r[08:00]  = data_r[08:00];
       dq_write_r[26:18]  = data_r[17:09];
       if(DW_36_72 == 1)
       begin
         dq_write_r[44:36]  = data_r[26:18];
         dq_write_r[62:54]  = data_r[35:27];
       end
    end
    memory_data_temp   = memory_data[address_r];
    if(iright_clk == 1'b0) begin
      if(`CYP_ISDDR == 1)
      begin
	if(DW_36_72 == 1 && byte_r[3 * DW_36_72] == 1'b0) 
		memory_data_temp[71 * DW_36_72:63 * DW_36_72] = data_r[35 * DW_36_72:27 * DW_36_72];
	if(DW_36_72 == 1 && byte_r[2 * DW_36_72] == 1'b0) 
		memory_data_temp[53 * DW_36_72:45 * DW_36_72] = data_r[26 * DW_36_72:18 * DW_36_72];
        if(byte_r[1] == 1'b0) memory_data_temp[35:27] = data_r[17:09];
        if(byte_r[0] == 1'b0) memory_data_temp[17:09] = data_r[08:00];
      end
      else
      begin
	if(DW_36_72 == 1 && byte_r[6 * DW_36_72] == 1'b0) 
		memory_data_temp[71 * DW_36_72:63 * DW_36_72] = data_r[35 * DW_36_72:27 * DW_36_72];
        if(DW_36_72 == 1 && byte_r[4 * DW_36_72] == 1'b0) 
		memory_data_temp[53 * DW_36_72:45 * DW_36_72] = data_r[26 * DW_36_72:18 * DW_36_72];
	if(DW_36_72 == 1 && byte_r[2 * DW_36_72] == 1'b0) 
		memory_data_temp[35 * DW_36_72:27 * DW_36_72] = data_r[17 * DW_36_72:09 * DW_36_72];
        if(byte_r[0] == 1'b0) memory_data_temp[17:09] = data_r[08:00];
      end	
    end else begin
      if(`CYP_ISDDR == 1)
      begin
	 if(DW_36_72 == 1 && byte_r[3 * DW_36_72] == 1'b0) 
		memory_data_temp[62 * DW_36_72:54 * DW_36_72] = data_r[35 * DW_36_72:27 * DW_36_72];
	 if(DW_36_72 == 1 && byte_r[2 * DW_36_72] == 1'b0) 
		memory_data_temp[44 * DW_36_72:36 * DW_36_72] = data_r[26 * DW_36_72:18 * DW_36_72];
         if(byte_r[1] == 1'b0) memory_data_temp[26:18] = data_r[17:09];
         if(byte_r[0] == 1'b0) memory_data_temp[08:00] = data_r[08:00];
      end
      else
      begin
	 if(DW_36_72 == 1 && byte_r[6 * DW_36_72] == 1'b0) 
		memory_data_temp[62 * DW_36_72:54 * DW_36_72] = data_r[35 * DW_36_72:27 * DW_36_72];
	 if(DW_36_72 == 1 && byte_r[4 * DW_36_72] == 1'b0) 
		memory_data_temp[44 * DW_36_72:36 * DW_36_72] = data_r[26 * DW_36_72:18 * DW_36_72];
	 if(DW_36_72 == 1 && byte_r[2 * DW_36_72] == 1'b0) 
		memory_data_temp[26 * DW_36_72:18 * DW_36_72] = data_r[17 * DW_36_72:09 * DW_36_72];
         if(byte_r[0] == 1'b0) memory_data_temp[08:00] = data_r[08:00];
      end
    end
    memory_data[address_r] = memory_data_temp;
    `endif
   end
  endtask
  
  
  // Task for Right Port DDR mode write operation using burst counter
  task ddr_write_counter_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   input [CYP_DDR_MULT* `CYP_DATAWIDTH/2 - 1: 0] data_r;
   reg [CYP_DDR_MULT *`CYP_DATAWIDTH -1:0] memory_data_temp;

   begin
    `ifdef SDR 
    `else
    if(`CYP_ISDDR == 1)
       dq_write_r         = data_r;
    else
    begin
       dq_write_r[08:00]  = data_r[08:00];
       dq_write_r[26:18]  = data_r[17:09];
       if(DW_36_72 == 1)
       begin
         dq_write_r[44:36]  = data_r[26:18];
         dq_write_r[62:54]  = data_r[35:27];
       end
    end
    memory_data_temp = memory_data[address_r];
    if(iright_clk == 1'b0) begin
      if(DW_36_72 == 1)
      begin
        memory_data_temp[71:63] = data_r[35:27];
        memory_data_temp[53:45] = data_r[26:18];
      end
      memory_data_temp[35:27] = data_r[17:9];
      memory_data_temp[17:9]  = data_r[8:0];
    end else begin
      if(DW_36_72 == 1)
      begin
        memory_data_temp[62:54] = data_r[35:27];
        memory_data_temp[44:36] = data_r[26:18];
      end
      memory_data_temp[26:18] = data_r[17:9];
      memory_data_temp[8:0]   = data_r[8:0];
    end
    memory_data[address_r] = memory_data_temp;
    `endif
   end
  endtask


  // Task for Right Port SDR mode read operation using address bus
  task sdr_read_addr_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   input [`CYP_BYTEWIDTH - 1: 0] byte_r;

   begin

    //counter_hold_r;
    inright_be     = byte_r;
    a_rw_r  = address_r;
   end
  endtask


  // Task for Right Port DDR mode read operation
  task ddr_read_addr_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;

   begin

    //counter_hold_r;
    a_rw_r  = address_r;
   end
  endtask



  // Result comparison operation for SDR mode, right port of the model
  task sdr_compare_result_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   input [`CYP_BYTEWIDTH - 1: 0] byte_enable_r;
   reg [`CYP_DATAWIDTH - 1: 0] expected_result_r;
   reg [`CYP_DATAWIDTH - 1: 0] actual_result_r;
   begin
    expected_result_r = memory_data[address_r]; 
    `ifdef SDR 
    if(byte_enable_r[0] == 1'b1) expected_result_r[8:0]   = 9'bZZZZZZZZZ;
    if(byte_enable_r[1] == 1'b1) expected_result_r[17:9]  = 9'bZZZZZZZZZ;
    if(byte_enable_r[2] == 1'b1) expected_result_r[26:18] = 9'bZZZZZZZZZ;
    if(byte_enable_r[3] == 1'b1) expected_result_r[35:27] = 9'bZZZZZZZZZ;
    `else
    if(byte_enable_r[4] == 1'b1) expected_result_r[44:36] = 9'bZZZZZZZZZ;
    if(byte_enable_r[5] == 1'b1) expected_result_r[53:45] = 9'bZZZZZZZZZ;
    if(byte_enable_r[6] == 1'b1) expected_result_r[62:54] = 9'bZZZZZZZZZ;
    if(byte_enable_r[7] == 1'b1) expected_result_r[71:63] = 9'bZZZZZZZZZ;
    `endif
    actual_result_r = ioright_dq;
    if(actual_result_r === expected_result_r) begin
     if(nmsg == 1'b1)
     begin
       $display("%10.2f TEST PASSED:For memory location %h:",$realtime,address_r);
       $display("                     Ouput Data      = %h ",actual_result_r);
       $display("                     Expected Result = %h ",expected_result_r);
     end
    end else begin
     if(nmsg == 1'b1)
     begin
       $display("%10.2f TEST FAILED:For memory location %h:",$realtime,address_r);
       $display("                     Ouput Data      = %h ",actual_result_r);
       $display("                     Expected Result = %h ",expected_result_r);
     end
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
    end
   end
  endtask

  // Result comparison operation for DDR mode, right port of the model
  task ddr_compare_result_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   reg [CYP_DDR_MULT*`CYP_DATAWIDTH - 1: 0] expected_result_temp_r;
   reg [`CYP_DATAWIDTH   - 1: 0] expected_result_r;
   reg [`CYP_DATAWIDTH   - 1: 0] actual_result_r;
   begin
    `ifdef SDR
    `else
    expected_result_temp_r = memory_data[address_r];
    expected_result_r      = {`CYP_DATAWIDTH{1'bZ}};
    if(`CYP_ISDDR == 1)
    begin
      if(iright_clk_n == 1'b1) begin
         expected_result_r[08:00] = expected_result_temp_r[17:09];
         expected_result_r[17:09] = expected_result_temp_r[35:27];
	 if(DW_36_72 == 1)
         begin
           expected_result_r[26:18] = expected_result_temp_r[53:45];
           expected_result_r[35:27] = expected_result_temp_r[71:63];
	 end
      end else if(iright_clk == 1'b1) begin
         expected_result_r[08:00] = expected_result_temp_r[08:00];
         expected_result_r[17:09] = expected_result_temp_r[26:18];
         if(DW_36_72 == 1)
         begin
	   expected_result_r[26:18] = expected_result_temp_r[44:36];
           expected_result_r[35:27] = expected_result_temp_r[62:54];
	 end
      end
    end
    else
    begin
      if(iright_clk_n == 1'b1) begin
         expected_result_r[08:00] = expected_result_temp_r[17:09];
         expected_result_r[26:18] = expected_result_temp_r[35:27];
	 if(DW_36_72 == 1)
         begin
           expected_result_r[44:36] = expected_result_temp_r[53:45];
           expected_result_r[62:54] = expected_result_temp_r[71:63];
	 end
      end else if(iright_clk == 1'b1) begin
         expected_result_r[08:00] = expected_result_temp_r[08:00];
         expected_result_r[26:18] = expected_result_temp_r[26:18];
	 if(DW_36_72 == 1)
         begin
           expected_result_r[44:36] = expected_result_temp_r[44:36];
           expected_result_r[62:54] = expected_result_temp_r[62:54];
	 end
      end
    end    
    actual_result_r = ioright_dq[`CYP_DATAWIDTH - 1: 0];
    if(actual_result_r === expected_result_r) begin
     if(nmsg == 1'b1)
     begin
       $display("%10.2f TEST PASSED:For memory location %b:",$realtime,address_r);
       $display("                     Ouput Data      = %b ",actual_result_r);
       $display("                     Expected Result = %b ",expected_result_r);
     end
    end else begin
     if(nmsg == 1'b1)
     begin
       $display("%10.2f TEST FAILED:For memory location %b:",$realtime,address_r);
       $display("                     Ouput Data      = %b ",actual_result_r);
       $display("                     Expected Result = %b ",expected_result_r);
     end
     failed_flag       = 1'b1;
     failed_flag_local = 1'b1;
    end
    `endif
   end
  endtask
  
  
  // Comparing the result of Right Port Readback operation
  task compare_readback_result_r;

   input [`CYP_ADDRWIDTH - 1: 0] expected_result;

   begin
     if(ioright_a === expected_result) begin
       if(nmsg == 1'b1)
       begin
	 $display("%10.2f TEST PASSED: For Readback operation",$realtime);
         $display("                     Output Result = %h ",ioright_a);
         $display("                     Expected Result = %h ",expected_result);
       end
     end
     else
     begin
       if(nmsg == 1'b1)
       begin
	 $display("%10.2f TEST FAILED: For Readback operation",$realtime);
         $display("                     Output Result = %h ",ioright_a);
         $display("                     Expected Result = %h ",expected_result);
       end
       failed_flag       = 1'b1;
       failed_flag_local = 1'b1;
     end

     if(ioright_dq === {`CYP_DATAWIDTH{1'bZ}}) begin
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

  
  // task for right port burst counter reset operation
  task counter_reset_r;

   begin
    iright_cntrst = 1'b0;
    iright_cntmsk= 1'b1;
   end
  endtask

  // task for right port mask register reset operation
  task mask_reset_r;

   begin
    iright_cntrst = 1'b0;
    iright_cntmsk= 1'b0;
   end
  endtask

  // task for right port burst counter load operation
  task counter_load_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   begin
    op_read_r     = 1'b1;
    op_write_r    = 1'b0;
    op_readback_r = 1'b0;  
    op_config_r   = 1'b0; 
    a_rw_r        = address_r;
    iright_cntrst  = 1'b1;
    iright_cntmsk  = 1'b1;
    iright_cnten   = 1'b0;
    iright_ads     = 1'b0;
   end
  endtask


  // task for keeping the right port burst counter in load mode 

  task counter_load_mode_r;

   begin
    iright_cntrst  = 1'b1;
    iright_cntmsk  = 1'b1;
    iright_cnten   = 1'b0;
    iright_ads     = 1'b0;
   end
  endtask

  
  
  // task for right port mask register load operation
  task mask_load_r;

   input [`CYP_ADDRWIDTH - 1: 0] address_r;
   begin
    op_read_r     = 1'b1;    
    op_write_r    = 1'b0;    
    op_readback_r = 1'b0;      
    op_config_r   = 1'b0; 
    a_rw_r        = address_r;
    iright_cntrst = 1'b1;
    iright_cntmsk = 1'b0;
    iright_cnten  = 1'b0;
    iright_ads    = 1'b0;
   end
  endtask

  // task for right port retransmit#1 operation
  task retransmit_1_r;

   begin
    iright_cntrst  = 1'b1;
    iright_cntmsk = 1'b1;
    iright_cnten   = 1'b0;
    iright_ads     = 1'b1;
    iright_ret     = 1'b0;
   end
  endtask

  // task for right port burst counter increment operation
  task counter_increment_r;

   begin
    iright_cntrst  = 1'b1;
    iright_cntmsk  = 1'b1;
    iright_cnten   = 1'b0;
    iright_ads     = 1'b1;
    iright_ret     = 1'b1;
   end
  endtask


  // task for right port burst counter hold operation
  task counter_hold_r;

   begin
    iright_cntrst  = 1'b1;
    iright_cntmsk = 1'b1;
    iright_cnten   = 1'b1;
    iright_ads     = 1'b1;
    iright_ret     = 1'b1;
   end
  endtask

  // task for right port burst counter readback to address bus operation
  task counter_readback_r;

   begin
    iright_cntrst  = 1'b1;
    iright_cntmsk = 1'b1;
    iright_cnten   = 1'b1;
    iright_ads     = 1'b0;
    iright_ret     = 1'b1;
   end
  endtask

  // task for right port mask register readback to address bus operation
  task mask_readback_r;

   begin
    iright_cntrst  = 1'b1;
    iright_cntmsk = 1'b0;
    iright_cnten   = 1'b1;
    iright_ads     = 1'b0;
    iright_ret     = 1'b1;
   end
  endtask

  // task for right port busy address readback to address bus operation
  task busy_address_readback_r;

   begin
    iright_cntrst  = 1'b1;
    iright_cntmsk  = 1'b0;
    iright_cnten   = 1'b1;
    iright_ads     = 1'b1;
    iright_ret     = 1'b0;
   end
  endtask


  // This task will drive all the enable pins to enable the
  // read operation
  task enable_read_op_r;

   begin
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b1;
    inright_rw     = 1'b1;
    op_read_r      = 1'b1;
    op_write_r     = 1'b0;
    op_readback_r  = 1'b0;
    op_config_r    = 1'b0;
    inright_oe     = 1'b0;
   end
  endtask


  // This task will drive all the enable pins to enable the
  // write operation
  task enable_write_op_r;

   begin
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b1;
    inright_rw     = 1'b0;
    op_read_r      = 1'b0;
    op_write_r     = 1'b1;
    op_readback_r  = 1'b0;
    op_config_r    = 1'b0;
    inright_oe     = 1'b0;
   end
  endtask


  // This task will drive all the enable pins to enable the
  // readback operation
  task enable_readback_op_r;

   begin
    inright_ce0    = 1'b0;
    iright_ce1     = 1'b1;
    op_read_r      = 1'b0;
    op_write_r     = 1'b0;
    op_readback_r  = 1'b1;
    op_config_r    = 1'b0;
   end
  endtask


  // This task will check the BUSY# signal for the right port is asserted
  // After four clock periods
  task busy_check_low_after_4_period_r;
    begin
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tBSY_r + offset);
      if(onright_busy == 1'b0) begin
        if(nmsg == 1'b1)
          $display("%10.2f ARBITRATION TEST PASSED:Right Port BUSY# is asserted",$realtime);
      end 
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Right Port BUSY# is not asserted",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end

      @(posedge iright_clk);
      #(TP.tBSY_r + offset);
      if(onright_busy == 1'b1) begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST PASSED:Right Port BUSY# de-asserted after one clock cycle",$realtime);
      end 
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Right Port BUSY# is not de-asserted after one clock cycle",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end

    end
  endtask


  // This task will check the BUSY# signal for the right port is not asserted
  // After four clock periods
  task busy_check_high_after_4_period_r;
    begin
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      @(posedge iright_clk);
      #(TP.tBSY_r + offset);
      if(onright_busy == 1'b1) begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST PASSED:Right Port BUSY# is not asserted",$realtime);
      end 
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Right Port BUSY# is asserted",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
  endtask

  // This task will check the BUSY# signal for the right port is not asserted
  always @(busy_check_low_r)
    begin
      //#(TP.tBSY_r - TP.tHAC_r + offset);
      #(TP.tBSY_r + offset);
      if(onright_busy == 1'b0) begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST PASSED:Right Port BUSY# is asserted",$realtime);
      end
      else
      begin
        if(nmsg == 1'b1)
	  $display("%10.2f ARBITRATION TEST FAILED:Right Port BUSY# is not asserted",$realtime);
        failed_flag       = 1'b1;
	failed_flag_local = 1'b1;
      end
    end
 // endtask 
