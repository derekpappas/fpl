
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
// File          : testcase_timing_check.v
// Author        : 
// Author's Email: 
// Date          : 02 JUL 2004
// Revision      : 1.0
// *******************************************************************
// Description :
// Testcase for testing the timing parameters of the model
// *******************************************************************


  // Model Should not Show any timing Violation 
  // All inputs and outputs are with proper timing  
  // All Tests Should Pass

  task timing_check_sdr2_addr_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_DATAWIDTH - 1 : 0] data_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   integer count_loop;
   begin

    $display("-------------------------------------------------------");
    $display("--     Testcase for Timing parameter Verification    --");
    $display("--          for SDR pipeline mode operation          --");
    $display("--                For Left Port                      --");
    $display("-------------------------------------------------------");

    $display("-------------------------------------------------------");
    $display("--    Model Should not Show any timing Violation     --");
    $display("--   All inputs and outputs are with proper timing   --");
    $display("--          All Tests Should Pass                    --");
    $display("-------------------------------------------------------");

    configure_device_sdr2;
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l);
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    sdr_write_addr_l(0,data_l,byte_l);   
 
    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(TP.tHAC_l);
      a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};
      #(TP.tHD_l - TP.tHAC_l);
      dq_write_l = {`CYP_DATAWIDTH{1'bZ}};
      #(ileft_clk_period - TP.tSD_l -TP.tHD_l);
      sdr_write_addr_l(count_loop,data_l,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tHAC_l);
    a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};
    #(TP.tHD_l - TP.tHAC_l);
    dq_write_l = {`CYP_DATAWIDTH{1'bZ}};

    #(ileft_clk_period - TP.tSAC_l -TP.tHD_l);
    enable_read_op_l;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSD_l);
    inleft_ce0    = 1'b0;
    sdr_read_addr_l(0,byte_l);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tHAC_l);
       a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};
       #(TP.tDC_l - TP.tHAC_l);
       if(count_loop >= 3) sdr_compare_result_l((count_loop - 3),byte_l);
       #(ileft_clk_period - TP.tSAC_l -TP.tDC_l);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_loop,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tDC_l);
    inleft_ce0     = 1'b1;    
    ileft_ce1     = 1'b0;  


    $display("-------------------------------------------------------");
    $display("--  Model Should display timing Violation messages   --");
    $display("--   All inputs and outputs are with wrong timing    --");
    $display("--          All Tests Should FAIL                    --");
    $display("-------------------------------------------------------");


    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSAC_l +0.1);
    enable_write_op_l;
    byte_l = 8'b00000000;
    randomdata_72bit(data_l);
    sdr_write_addr_l(0,data_l,byte_l);   
 
    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      @(posedge ileft_clk);
      #(TP.tHAC_l - 0.1);
      a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};
       #(TP.tHD_l - TP.tHAC_l );
      dq_write_l = {`CYP_DATAWIDTH{1'bZ}};
      #(ileft_clk_period - TP.tSD_l -TP.tHD_l +0.1);
      sdr_write_addr_l(count_loop,data_l,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tHAC_l -0.1);
    a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};
    #(TP.tHD_l - TP.tHAC_l);
    dq_write_l = {`CYP_DATAWIDTH{1'bZ}};

    #(ileft_clk_period - TP.tSAC_l -TP.tHD_l+0.1);
    enable_read_op_l;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    #(ileft_clk_period - TP.tSD_l+0.1);
    inleft_ce0    = 1'b0;
    sdr_read_addr_l(0,byte_l);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk);
       #(TP.tHAC_l - 0.1);
       a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};
       #(TP.tDC_l - TP.tHAC_l +0.2);
       if(count_loop >= 3) sdr_compare_result_l((count_loop - 3),byte_l);
       #(ileft_clk_period - TP.tSAC_l -TP.tDC_l+0.1);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_l(count_loop,byte_l);
    end
    @(posedge ileft_clk);
    #(TP.tDC_l - 0.1);
    inleft_ce0     = 1'b1;    
    ileft_ce1     = 1'b0;  
      
   end
  endtask


  // Testcase for Timing parameter Verification  
  // For DDR mode 2.5 pipeline stage operation 
  // For Left Port

  task timing_check_ddr2_addr_l;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_l;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_l;
   `ifdef DDR
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH - 1 : 0] data_temp2_l;
     reg [2*`CYP_DATAWIDTH:0] memory_data_temp;
   `else
     reg [`CYP_DATAWIDTH - 1 : 0] data_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_l;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_l;
     reg [`CYP_DATAWIDTH:0] memory_data_temp;
   `endif
   integer count_loop;
   begin 

    $display("-------------------------------------------------------");
    $display("--     Testcase for Timing parameter Verification    --");
    $display("--     For DDR mode 2.5 pipeline stage operation     --");
    $display("--                For Left Port                      --");
    $display("-------------------------------------------------------");

    $display("-------------------------------------------------------");
    $display("--    Model Should not Show any timing Violation     --");
    $display("--   All inputs and outputs are with proper timing   --");
    $display("--           All Tests Should Pass                   --");
    $display("-------------------------------------------------------");

  `ifdef SDR
  `else
    configure_device_ddr2;
    inleft_ce0    = 1'b1;
    ileft_ce1     = 1'b0;
    counter_load_mode_l;
    master_reset;

    wait (onleft_ready == 1'b0);
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    enable_write_op_l;
    #(TP.tSAC_l - TP.tSBE_l);
    byte_l = 8'b00000000;
    a_rw_l  = {`CYP_ADDRWIDTH{1'b0}};
    #(TP.tSD_l - TP.tSBE_l); 
    randomdata_72bit(data_l);
    data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
    data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
    dq_write_l    = data_temp1_l;
    memory_data_temp = memory_data[0];
    memory_data_temp[71:63] = data_temp1_l[35:27];
    memory_data_temp[53:45] = data_temp1_l[26:18];
    memory_data_temp[35:27] = data_temp1_l[17:9];
    memory_data_temp[17:9]  = data_temp1_l[8:0];
    memory_data[0] = memory_data_temp;

    @(posedge ileft_clk);
    #(TP.tHD_l);
  `ifdef DDR
    dq_write_l    = {2*`CYP_DATAWIDTH{1'bZ}};
  `else
    dq_write_l    = {`CYP_DATAWIDTH{1'bZ}};  
  `endif
    
    #(TP.tHAC_l - TP.tHD_l);
    a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};

    #(ileft_clk_period/2.0 - TP.tSD_l -TP.tHAC_l);
    memory_data_temp = memory_data[0];
    dq_write_l    = data_temp2_l;
    memory_data_temp[62:54] = data_temp2_l[35:27];
    memory_data_temp[44:36] = data_temp2_l[26:18];
    memory_data_temp[26:18] = data_temp2_l[17:9];
    memory_data_temp[8:0]   = data_temp2_l[8:0];
    memory_data[0] = memory_data_temp;


    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      @(posedge ileft_clk_n);

      #(TP.tHD_l);
    `ifdef DDR
      dq_write_l    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_l    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
      #(ileft_clk_period/2.0 - TP.tSAC_l-TP.tHD_l);
      a_rw_l  = count_loop;
      #(TP.tSAC_l - TP.tSD_l); 
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      dq_write_l    = data_temp1_l;
      memory_data_temp = memory_data[count_loop];
      memory_data_temp[71:63] = data_temp1_l[35:27];
      memory_data_temp[53:45] = data_temp1_l[26:18];
      memory_data_temp[35:27] = data_temp1_l[17:9];
      memory_data_temp[17:9]  = data_temp1_l[8:0];
      memory_data[count_loop] = memory_data_temp;

      @(posedge ileft_clk);
      #(TP.tHD_l);
    `ifdef DDR
      dq_write_l    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_l    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
    
      #(TP.tHAC_l - TP.tHD_l);
      a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};

      #(ileft_clk_period/2.0 - TP.tSD_l -TP.tHAC_l);
      memory_data_temp = memory_data[count_loop];
      dq_write_l    = data_temp2_l;
      memory_data_temp[62:54] = data_temp2_l[35:27];
      memory_data_temp[44:36] = data_temp2_l[26:18];
      memory_data_temp[26:18] = data_temp2_l[17:9];
      memory_data_temp[8:0]   = data_temp2_l[8:0];
      memory_data[count_loop] = memory_data_temp;

    end
    @(posedge ileft_clk_n);
    #(TP.tHD_l);
    enable_read_op_l;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);

    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l);
    inleft_ce0    = 1'b0;
    ddr_read_addr_l(0);

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+2);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l);
      if(count_loop <= `CYP_LASTADDR_TEST) ddr_read_addr_l(count_loop);
      #(TP.tSAC_l- TP.tDC_l);
      if(count_loop >= 2) ddr_compare_result_l(count_loop - 2);

      @(posedge ileft_clk);
      #(ileft_clk_period/2.0 - TP.tDC_l);
      if(count_loop >= 2) ddr_compare_result_l(count_loop - 2);
    end
    inleft_ce0     = 1'b1;
    ileft_ce1     = 1'b0;


    $display("-------------------------------------------------------");
    $display("--  Model Should display timing Violation messages   --");
    $display("--   All inputs and outputs are with wrong timing    --");
    $display("--          All Tests Should FAIL                    --");
    $display("-------------------------------------------------------");

    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l+0.1);
    enable_write_op_l;
    #(TP.tSAC_l - TP.tSBE_l);
    byte_l = 8'b00000000;
    a_rw_l  = {`CYP_ADDRWIDTH{1'b0}};
    #(TP.tSD_l - TP.tSBE_l); 
    randomdata_72bit(data_l);
    data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
    data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
    dq_write_l    = data_temp1_l;
    memory_data_temp = memory_data[0];
    memory_data_temp[71:63] = data_temp1_l[35:27];
    memory_data_temp[53:45] = data_temp1_l[26:18];
    memory_data_temp[35:27] = data_temp1_l[17:9];
    memory_data_temp[17:9]  = data_temp1_l[8:0];
    memory_data[0] = memory_data_temp;

    @(posedge ileft_clk);
    #(TP.tHD_l-0.1);
  `ifdef DDR
    dq_write_l    = {2*`CYP_DATAWIDTH{1'bZ}};
  `else
    dq_write_l    = {`CYP_DATAWIDTH{1'bZ}};  
  `endif
    
    #(TP.tHAC_l - TP.tHD_l);
    a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};

    #(ileft_clk_period/2.0 - TP.tSD_l -TP.tHAC_l+0.2);
    memory_data_temp = memory_data[0];
    dq_write_l    = data_temp2_l;
    memory_data_temp[62:54] = data_temp2_l[35:27];
    memory_data_temp[44:36] = data_temp2_l[26:18];
    memory_data_temp[26:18] = data_temp2_l[17:9];
    memory_data_temp[8:0]   = data_temp2_l[8:0];
    memory_data[0] = memory_data_temp;


    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      @(posedge ileft_clk_n);

      #(TP.tHD_l-0.1);
    `ifdef DDR
      dq_write_l    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_l    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
      #(ileft_clk_period/2.0 - TP.tSAC_l-TP.tHD_l+0.2);
      a_rw_l  = count_loop;
      #(TP.tSAC_l - TP.tSD_l); 
      randomdata_72bit(data_l);
      data_temp1_l = {data_l[71:63],data_l[53:45],data_l[35:27],data_l[17:9]};
      data_temp2_l = {data_l[62:54],data_l[44:36],data_l[26:18],data_l[8:0]};
      dq_write_l    = data_temp1_l;
      memory_data_temp = memory_data[count_loop];
      memory_data_temp[71:63] = data_temp1_l[35:27];
      memory_data_temp[53:45] = data_temp1_l[26:18];
      memory_data_temp[35:27] = data_temp1_l[17:9];
      memory_data_temp[17:9]  = data_temp1_l[8:0];
      memory_data[count_loop] = memory_data_temp;

      @(posedge ileft_clk);
      #(TP.tHD_l-0.1);
    `ifdef DDR
      dq_write_l    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_l    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
    
      #(TP.tHAC_l - TP.tHD_l);
      a_rw_l        = {`CYP_ADDRWIDTH{1'bZ}};

      #(ileft_clk_period/2.0 - TP.tSD_l -TP.tHAC_l+0.2);
      memory_data_temp = memory_data[count_loop];
      dq_write_l    = data_temp2_l;
      memory_data_temp[62:54] = data_temp2_l[35:27];
      memory_data_temp[44:36] = data_temp2_l[26:18];
      memory_data_temp[26:18] = data_temp2_l[17:9];
      memory_data_temp[8:0]   = data_temp2_l[8:0];
      memory_data[count_loop] = memory_data_temp;

    end
    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l+0.1);
    enable_read_op_l;
    inleft_ce0    = 1'b1;
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);
    @(posedge ileft_clk);

    @(posedge ileft_clk_n);
    #(ileft_clk_period/2.0 - TP.tSAC_l+0.1);
    inleft_ce0    = 1'b0;
    ddr_read_addr_l(0);

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+2);count_loop = count_loop +1)
    begin
      @(posedge ileft_clk_n);
      #(ileft_clk_period/2.0 - TP.tSAC_l+0.1);
      if(count_loop <= `CYP_LASTADDR_TEST) ddr_read_addr_l(count_loop);
      #(TP.tSAC_l- TP.tDC_l);
      if(count_loop >= 2) ddr_compare_result_l(count_loop - 2);

      @(posedge ileft_clk);
      #(ileft_clk_period/2.0 - TP.tDC_l+0.1);
      if(count_loop >= 2) ddr_compare_result_l(count_loop - 2);
    end

  `endif
   end
  endtask

  
  // Testcase for Timing parameter Verification 
  // for SDR mode 2 pipeline stage operation  
  // For Right Port

  task timing_check_sdr2_addr_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_r;
   reg [`CYP_DATAWIDTH - 1 : 0] data_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   integer count_loop;
   begin

    $display("-------------------------------------------------------");
    $display("--     Testcase for Timing parameter Verification    --");
    $display("--       for SDR mode 2 pipeline stage operation     --");
    $display("--                For Right Port                     --");
    $display("-------------------------------------------------------");

    $display("-------------------------------------------------------");
    $display("--    Model Should not Show any timing Violation     --");
    $display("--   All inputs and outputs are with proper timing   --");
    $display("--          All Tests Should PASS                    --");
    $display("-------------------------------------------------------");

    configure_device_sdr2;
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;
    counter_load_mode_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r);
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    sdr_write_addr_r(0,data_r,byte_r);   
 
    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(TP.tHAC_r);
      a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};
      #(TP.tHD_r - TP.tHAC_r);
      dq_write_r = {`CYP_DATAWIDTH{1'bZ}};
      #(iright_clk_period - TP.tSD_r -TP.tHD_r);
      sdr_write_addr_r(count_loop,data_r,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tHAC_r);
    a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};
    #(TP.tHD_r - TP.tHAC_r);
    dq_write_r = {`CYP_DATAWIDTH{1'bZ}};

    #(iright_clk_period - TP.tSAC_r -TP.tHD_r);
    enable_read_op_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSD_r);
    inright_ce0    = 1'b0;
    sdr_read_addr_r(0,byte_r);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tHAC_r);
       a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};
       #(TP.tDC_r - TP.tHAC_r);
       if(count_loop >= 3) sdr_compare_result_r((count_loop - 3),byte_r);
       #(iright_clk_period - TP.tSAC_r -TP.tDC_r);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_r(count_loop,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tDC_r);
    inright_ce0     = 1'b1;    
    iright_ce1     = 1'b0;  


    $display("-------------------------------------------------------");
    $display("--  Model Should display timing Violation messages   --");
    $display("--   All inputs and outputs are with wrong timing    --");
    $display("--          All Tests Should FAIL                    --");
    $display("-------------------------------------------------------");


    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSAC_r +0.1);
    enable_write_op_r;
    byte_r = 8'b00000000;
    randomdata_72bit(data_r);
    sdr_write_addr_r(0,data_r,byte_r);   
 
    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      @(posedge iright_clk);
      #(TP.tHAC_r - 0.1);
      a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};
      #(TP.tHD_r - TP.tHAC_r );
      dq_write_r = {`CYP_DATAWIDTH{1'bZ}};
      #(iright_clk_period - TP.tSD_r -TP.tHD_r +0.1);
      sdr_write_addr_r(count_loop,data_r,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tHAC_r -0.1);
    a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};
    #(TP.tHD_r - TP.tHAC_r);
    dq_write_r = {`CYP_DATAWIDTH{1'bZ}};

    #(iright_clk_period - TP.tSAC_r -TP.tHD_r+0.1);
    enable_read_op_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    #(iright_clk_period - TP.tSD_r+0.1);
    inright_ce0    = 1'b0;
    sdr_read_addr_r(0,byte_r);
    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+3);count_loop = count_loop +1)
    begin
      @(posedge iright_clk);
       #(TP.tHAC_r - 0.1);
       a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};
       #(TP.tDC_r - TP.tHAC_r +0.2);
       if(count_loop >= 3) sdr_compare_result_r((count_loop - 3),byte_r);
       #(iright_clk_period - TP.tSAC_r -TP.tDC_r+0.1);
       if(count_loop <= `CYP_LASTADDR_TEST) sdr_read_addr_r(count_loop,byte_r);
    end
    @(posedge iright_clk);
    #(TP.tDC_r - 0.1);
    inright_ce0     = 1'b1;    
    iright_ce1     = 1'b0;  
      
   end
  endtask


  // Testcase for Timing parameter Verification 
  // For DDR mode 2.5 pipeline stage operation 
  // For Right Port 

  task timing_check_ddr2_addr_r;

   reg [`CYP_ADDRWIDTH - 1 : 0] address_r;
   reg [`CYP_BYTEWIDTH - 1 : 0] byte_r;
   `ifdef DDR
     reg [2*`CYP_DATAWIDTH - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH - 1 : 0] data_temp2_r;
     reg [2*`CYP_DATAWIDTH:0] memory_data_temp;
   `else
     reg [`CYP_DATAWIDTH - 1 : 0] data_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp1_r;
     reg [`CYP_DATAWIDTH/2 - 1 : 0] data_temp2_r;
     reg [`CYP_DATAWIDTH:0] memory_data_temp;
   `endif
   integer count_loop;
   begin 

    $display("-------------------------------------------------------");
    $display("--     Testcase for Timing parameter Verification    --");
    $display("--     For DDR mode 2.5 pipeline stage operation     --");
    $display("--                For Right Port                     --");
    $display("-------------------------------------------------------");

    $display("-------------------------------------------------------");
    $display("--    Model Should not Show any timing Violation     --");
    $display("--   All inputs and outputs are with proper timing   --");
    $display("--           All Tests Should PASS                   --");
    $display("-------------------------------------------------------");

  `ifdef SDR
  `else
    configure_device_ddr2;
    inright_ce0    = 1'b1;
    iright_ce1     = 1'b0;
    counter_load_mode_r;
    master_reset;

    wait (onright_ready == 1'b0);
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    enable_write_op_r;
    #(TP.tSAC_r - TP.tSBE_r);
    byte_r = 8'b00000000;
    a_rw_r  = {`CYP_ADDRWIDTH{1'b0}};
    #(TP.tSD_r - TP.tSBE_r); 
    randomdata_72bit(data_r);
    data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
    data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
    dq_write_r    = data_temp1_r;
    memory_data_temp = memory_data[0];
    memory_data_temp[71:63] = data_temp1_r[35:27];
    memory_data_temp[53:45] = data_temp1_r[26:18];
    memory_data_temp[35:27] = data_temp1_r[17:9];
    memory_data_temp[17:9]  = data_temp1_r[8:0];
    memory_data[0] = memory_data_temp;

    @(posedge iright_clk);
    #(TP.tHD_r);
  `ifdef DDR
    dq_write_r    = {2*`CYP_DATAWIDTH{1'bZ}};
  `else
    dq_write_r    = {`CYP_DATAWIDTH{1'bZ}};  
  `endif
    
    #(TP.tHAC_r - TP.tHD_r);
    a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};

    #(iright_clk_period/2.0 - TP.tSD_r -TP.tHAC_r);
    memory_data_temp = memory_data[0];
    dq_write_r    = data_temp2_r;
    memory_data_temp[62:54] = data_temp2_r[35:27];
    memory_data_temp[44:36] = data_temp2_r[26:18];
    memory_data_temp[26:18] = data_temp2_r[17:9];
    memory_data_temp[8:0]   = data_temp2_r[8:0];
    memory_data[0] = memory_data_temp;


    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      @(posedge iright_clk_n);

      #(TP.tHD_r);
    `ifdef DDR
      dq_write_r    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_r    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
      #(iright_clk_period/2.0 - TP.tSAC_r-TP.tHD_r);
      a_rw_r  = count_loop;
      #(TP.tSAC_r - TP.tSD_r); 
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      dq_write_r    = data_temp1_r;
      memory_data_temp = memory_data[count_loop];
      memory_data_temp[71:63] = data_temp1_r[35:27];
      memory_data_temp[53:45] = data_temp1_r[26:18];
      memory_data_temp[35:27] = data_temp1_r[17:9];
      memory_data_temp[17:9]  = data_temp1_r[8:0];
      memory_data[count_loop] = memory_data_temp;

      @(posedge iright_clk);
      #(TP.tHD_r);
    `ifdef DDR
      dq_write_r    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_r    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
    
      #(TP.tHAC_r - TP.tHD_r);
      a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};

      #(iright_clk_period/2.0 - TP.tSD_r -TP.tHAC_r);
      memory_data_temp = memory_data[count_loop];
      dq_write_r    = data_temp2_r;
      memory_data_temp[62:54] = data_temp2_r[35:27];
      memory_data_temp[44:36] = data_temp2_r[26:18];
      memory_data_temp[26:18] = data_temp2_r[17:9];
      memory_data_temp[8:0]   = data_temp2_r[8:0];
      memory_data[count_loop] = memory_data_temp;

    end
    @(posedge iright_clk_n);
    #(TP.tHD_r);
    enable_read_op_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);

    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r);
    inright_ce0    = 1'b0;
    ddr_read_addr_r(0);

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+2);count_loop = count_loop +1)
    begin
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r);
      if(count_loop <= `CYP_LASTADDR_TEST) ddr_read_addr_r(count_loop);
      #(TP.tSAC_r- TP.tDC_r);
      if(count_loop >= 2) ddr_compare_result_r(count_loop - 2);

      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tDC_r);
      if(count_loop >= 2) ddr_compare_result_r(count_loop - 2);
    end
    inright_ce0     = 1'b1;
    iright_ce1     = 1'b0;


    $display("-------------------------------------------------------");
    $display("--  Model Should display timing Violation messages   --");
    $display("--   All inputs and outputs are with wrong timing    --");
    $display("--          All Tests Should FAIL                    --");
    $display("-------------------------------------------------------");

    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r+0.1);
    enable_write_op_r;
    #(TP.tSAC_r - TP.tSBE_r);
    byte_r = 8'b00000000;
    a_rw_r  = {`CYP_ADDRWIDTH{1'b0}};
    #(TP.tSD_r - TP.tSBE_r); 
    randomdata_72bit(data_r);
    data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
    data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
    dq_write_r    = data_temp1_r;
    memory_data_temp = memory_data[0];
    memory_data_temp[71:63] = data_temp1_r[35:27];
    memory_data_temp[53:45] = data_temp1_r[26:18];
    memory_data_temp[35:27] = data_temp1_r[17:9];
    memory_data_temp[17:9]  = data_temp1_r[8:0];
    memory_data[0] = memory_data_temp;

    @(posedge iright_clk);
    #(TP.tHD_r-0.1);
  `ifdef DDR
    dq_write_r    = {2*`CYP_DATAWIDTH{1'bZ}};
  `else
    dq_write_r    = {`CYP_DATAWIDTH{1'bZ}};  
  `endif
    
    #(TP.tHAC_r - TP.tHD_r);
    a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};

    #(iright_clk_period/2.0 - TP.tSD_r -TP.tHAC_r+0.2);
    memory_data_temp = memory_data[0];
    dq_write_r    = data_temp2_r;
    memory_data_temp[62:54] = data_temp2_r[35:27];
    memory_data_temp[44:36] = data_temp2_r[26:18];
    memory_data_temp[26:18] = data_temp2_r[17:9];
    memory_data_temp[8:0]   = data_temp2_r[8:0];
    memory_data[0] = memory_data_temp;


    for (count_loop = 1; count_loop<= `CYP_LASTADDR_TEST;count_loop = count_loop +1)
    begin
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      @(posedge iright_clk_n);

      #(TP.tHD_r-0.1);
    `ifdef DDR
      dq_write_r    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_r    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
      #(iright_clk_period/2.0 - TP.tSAC_r-TP.tHD_r+0.2);
      a_rw_r  = count_loop;
      #(TP.tSAC_r - TP.tSD_r); 
      randomdata_72bit(data_r);
      data_temp1_r = {data_r[71:63],data_r[53:45],data_r[35:27],data_r[17:9]};
      data_temp2_r = {data_r[62:54],data_r[44:36],data_r[26:18],data_r[8:0]};
      dq_write_r    = data_temp1_r;
      memory_data_temp = memory_data[count_loop];
      memory_data_temp[71:63] = data_temp1_r[35:27];
      memory_data_temp[53:45] = data_temp1_r[26:18];
      memory_data_temp[35:27] = data_temp1_r[17:9];
      memory_data_temp[17:9]  = data_temp1_r[8:0];
      memory_data[count_loop] = memory_data_temp;

      @(posedge iright_clk);
      #(TP.tHD_r-0.1);
    `ifdef DDR
      dq_write_r    = {2*`CYP_DATAWIDTH{1'bZ}};
    `else
      dq_write_r    = {`CYP_DATAWIDTH{1'bZ}};  
    `endif
    
      #(TP.tHAC_r - TP.tHD_r);
      a_rw_r        = {`CYP_ADDRWIDTH{1'bZ}};

      #(iright_clk_period/2.0 - TP.tSD_r -TP.tHAC_r+0.2);
      memory_data_temp = memory_data[count_loop];
      dq_write_r    = data_temp2_r;
      memory_data_temp[62:54] = data_temp2_r[35:27];
      memory_data_temp[44:36] = data_temp2_r[26:18];
      memory_data_temp[26:18] = data_temp2_r[17:9];
      memory_data_temp[8:0]   = data_temp2_r[8:0];
      memory_data[count_loop] = memory_data_temp;

    end
    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r+0.1);
    enable_read_op_r;
    inright_ce0    = 1'b1;
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);
    @(posedge iright_clk);

    @(posedge iright_clk_n);
    #(iright_clk_period/2.0 - TP.tSAC_r+0.1);
    inright_ce0    = 1'b0;
    ddr_read_addr_r(0);

    for (count_loop = 1;count_loop <=(`CYP_LASTADDR_TEST+2);count_loop = count_loop +1)
    begin
      @(posedge iright_clk_n);
      #(iright_clk_period/2.0 - TP.tSAC_r+0.1);
      if(count_loop <= `CYP_LASTADDR_TEST) ddr_read_addr_r(count_loop);
      #(TP.tSAC_r- TP.tDC_r);
      if(count_loop >= 2) ddr_compare_result_r(count_loop - 2);

      @(posedge iright_clk);
      #(iright_clk_period/2.0 - TP.tDC_r+0.1);
      if(count_loop >= 2) ddr_compare_result_r(count_loop - 2);
    end

  `endif
   end
  endtask



