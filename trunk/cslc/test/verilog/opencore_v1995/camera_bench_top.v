//////////////////////////////////////////////////////////////////////
////                                                              ////
////  camera_bench_top.v                                          ////
////                                                              ////
////  This file is part of the "camera" project                   ////
////  http://www.opencores.org/projects/camera/                   ////
////                                                              ////
////  Author(s):                                                  ////
////      - tadej@opencores.org                                   ////
////      - Tadej Markovic                                        ////
////                                                              ////
////  All additional information is avaliable in the README.txt   ////
////  file.                                                       ////
////                                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Tadej Markovic, tadej@opencores.org       ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: camera_bench_top.v,v $
// Revision 1.9  2003/10/16 08:09:29  tadejm
// Bug solved; counters for counting lines written in WB frame buffer didn't clear when frame finished. Added new file used in testbench, which does not cover full functionality yet.
//
// Revision 1.7  2003/10/06 07:12:54  tadejm
// Bug solved regarding some wrong RGB data. After optimization, sign of intermediate result for green color was not registered.
//
// Revision 1.3  2003/07/15 21:31:38  tadejm
// Added WISHBONE Rev. B3 state machine, additional logic to TestBench and verified the core.
//
// Revision 1.2  2003/07/04 23:34:40  tadejm
// Some changes in simulation files due to changes in RTL.
//
// Revision 1.1.1.1  2003/05/12 13:07:41  tadejm
// Camera IP Core
//
// Revision 1.2  2003/05/12 09:54:47  tadejm
// Heading changed
//
//
//
//


`include "camera_defines.v"
`include "wb_master_defines.v"
`ifdef REGR
`else
  `include "camera_bench_defines.v"
`endif
`include "timescale.v"

module camera_bench_top;


integer tb_log_file;

// INTERNAL signals
//#################
reg         cam_clock;
reg         wb_clock;
reg         reset;
reg [799:0] test_name;
integer     num_of_lines;
// base address of camera core WB B3 slave
reg [31:0]  camera_base_address;
// internal registers of camera core
reg [31:0]  dest_addr_register;
reg [31:0]  control_register;
reg [31:0]  int_status_register;
reg [31:0]  hsync_res_register;
reg [31:0]  vsync_res_register;


// Camera Wishbone Slave signals
wire        INT_O ;
wire [31:0] ADR_I ;
wire [31:0] SDAT_I ;
wire [31:0] SDAT_O ;
wire [3:0]  SEL_I ;
wire        CYC_I ;
wire        STB_I ;
wire        WE_I ;
wire        CAB_I ;
wire        ACK_O ;
wire        RTY_O = 1'b0;
wire        ERR_O = 1'b0;
// Camera Wishbone Master signals
wire [31:0] ADR_O ;
wire [31:0] MDAT_I ;
wire [31:0] MDAT_O ;
wire [3:0]  SEL_O ;
wire        CYC_O ;
wire        STB_O ;
wire [2:0]  CTI_O ;
wire [1:0]  BTE_O ;
wire        WE_O ;
wire        CAB_O = 1'b0;
wire        ACK_I ;
wire        RTY_I ;
wire        ERR_I ;
// Camera I/O signals
reg         camera_vsync;
reg         camera_hsync;
reg  [7:0]  camera_data;


camera_top              i_camera_top
(
    .wb_clk_i           (wb_clock),
    .wb_rst_i           (reset),
    .wb_int_o           (INT_O),
// WB slave signals - 2 address locations for two registers!
    .wbs_cyc_i          (CYC_I),
    .wbs_stb_i          (STB_I),
    .wbs_we_i           (WE_I),
    .wbs_sel_i          (SEL_I),
    .wbs_adr_i          (ADR_I[7:0]),
    .wbs_dat_i          (SDAT_I),
    .wbs_dat_o          (SDAT_O),
    .wbs_ack_o          (ACK_O),
// WB master signals
    .wbm_cyc_o          (CYC_O),
    .wbm_stb_o          (STB_O),
    .wbm_cti_o          (CTI_O),
    .wbm_bte_o          (BTE_O),
    .wbm_we_o           (WE_O), // always write     (1'b1)
    .wbm_sel_o          (SEL_O), // always all bytes (4'hF)
    .wbm_adr_o          (ADR_O),
    .wbm_dat_o          (MDAT_O),
    .wbm_dat_i          (MDAT_I), // NOT USED for now!
    .wbm_ack_i          (ACK_I),
    .wbm_rty_i          (RTY_I), // NOT USED for now!
    .wbm_err_i          (ERR_I), // NOT USED for now!
// Camera signals
    .camera_clock_pad_i (cam_clock),
    .camera_vsync_pad_i (camera_vsync),
    .camera_hsync_pad_i (camera_hsync),
    .camera_data_pad_i  (camera_data)
); 

WB_MASTER_BEHAVIORAL    wishbone_master
(
    .CLK_I              (wb_clock),
    .RST_I              (reset),
    .TAG_I              (4'b0000),
    .TAG_O              (),
    .ACK_I              (ACK_O),
    .ADR_O              (ADR_I),
    .CYC_O              (CYC_I),
    .DAT_I              (SDAT_O),
    .DAT_O              (SDAT_I),
    .ERR_I              (ERR_O), // inactive (1'b0)
    .RTY_I              (RTY_O), // inactive (1'b0)
    .SEL_O              (SEL_I),
    .STB_O              (STB_I),
    .WE_O               (WE_I),
    .CAB_O              (CAB_I) // NOT USED for now!
);
 
WB_SLAVE_BEHAVIORAL     wishbone_slave
(
    .CLK_I              (wb_clock),
    .RST_I              (reset),
    .ACK_O              (ACK_I),
    .ADR_I              (ADR_O),
    .CYC_I              (CYC_O),
    .DAT_O              (MDAT_I),
    .DAT_I              (MDAT_O),
    .ERR_O              (ERR_I),
    .RTY_O              (RTY_I),
    .SEL_I              (SEL_O),
    .STB_I              (STB_O),
    .WE_I               (WE_O),
    .CAB_I              (CAB_O) // inactive (1'b0)
);

// Clock generation
always
    #125 cam_clock = ~cam_clock;

always
    #20  wb_clock  = ~wb_clock;

// 8-bit memory for Cb12, Y1, Cr12, Y2,... data; 8-bit each data
reg  [7:0] cam_memory [0:127]; // 128 locations
reg  [6:0] cam_memory_index;
// 24-bit memory for R, G, B data; 8-bit each data
reg [23:0] rgb_memory [0:63]; // 64 locations
reg  [5:0] rgb_memory_index;

// variables for WB behavioral devices
 reg `WRITE_STIM_TYPE   write_data ;
 reg `READ_STIM_TYPE    read_data ;
 reg `READ_RETURN_TYPE  read_status ;
 reg `WRITE_RETURN_TYPE write_status ;
 reg `WB_TRANSFER_FLAGS write_flags ;

// GLOBAL ACK response counter when FIFO is flushed
integer global_ack_response_when_fifo_flushed_cnt;

initial
begin
    global_ack_response_when_fifo_flushed_cnt = 0;

    reset = 1'b1;
    cam_clock = 1'b0;
    wb_clock  = 1'b1;

    camera_vsync = 1'b1;
    camera_hsync = 1'b1;
    camera_data  = 8'h0;

    tb_log_file = $fopen("../log/cam_tb.log");
    if ( tb_log_file < 2 )
    begin
        $display("Could not open/create testbench log file in ../log/ directory!");
        $finish;
    end
    $fdisplay(tb_log_file, "############## CAMERA Core Testbench Test results ##############");
    $fdisplay(tb_log_file, "");

    load_memory;
    $display("Memories are loaded!");
    $fdisplay(tb_log_file, "Memories are loaded at time %t ", $time);
    run_tests;
end // initial

task load_memory;
    integer temp_index;
begin
    // load memory with 8-bit camera values (u12, y1, v12, y2,..) from file
    $readmemh("../../core_sw_simulator/uyvy_in.dat", cam_memory);
    // load memory with 24-bit calculated values (rgb1, rgb2,..) from file
    `ifdef CONVERSION_CASE_RAM
      $readmemh("../../core_sw_simulator/rgb_out.dat", rgb_memory);
    `else
      $readmemh("../../core_sw_simulator/rgb_scale_out.dat", rgb_memory);
    `endif
    // fill WB slave behavioral MEMORY - 4MB - 1M x 32-bit (20 address lines)
    for (temp_index = 0; temp_index <=1048575; temp_index = temp_index + 1)
    begin
        wishbone_slave.wb_memory[temp_index[19:0]] = 32'h0;
        # 1;
    end
end
endtask // load_memory

task run_tests;
begin
`ifdef HITACHI_CAM
    $display("=========================================");
    $display(" Camera module used: HAM49001 - Hitachi!");
    $display("=========================================");
    $fdisplay(tb_log_file, "=========================================");
    $fdisplay(tb_log_file, " Camera module used: HAM49001 - Hitachi!");
    $fdisplay(tb_log_file, "=========================================");
`else
  `ifdef OMNIVISION_CAM
    $display("============================================");
    $display(" Camera module used: OV7635FB - OmniVision!");
    $display("============================================");
    $fdisplay(tb_log_file, "============================================");
    $fdisplay(tb_log_file, " Camera module used: OV7635FB - OmniVision!");
    $fdisplay(tb_log_file, "============================================");
  `else
    $display("* ERROR: NO camera module defined!");
    $fdisplay(tb_log_file, "* ERROR: NO camera module defined!");
  `endif
`endif
    // first - reset logic
    $display("Reset logic!");
    $fdisplay(tb_log_file, "Reset logic at time %t ", $time);
    do_reset;
    // test calculation of RGB data and their transfer through WB
    $display("TEST calculation of camera interface!");
    $fdisplay(tb_log_file, "TEST calculation of camera interface at time %t ", $time);
//    test_rgb_calculation;
    // test camera interface functionality with data check
    $display("TEST functionality of camera interface!");
    $fdisplay(tb_log_file, "TEST functionality of camera interface at time %t ", $time);

    for (num_of_lines = 10; num_of_lines >= 0; num_of_lines = num_of_lines - 1)
    begin
        $display("###############################################");
        $display("#                                             #");
        if (num_of_lines < 8)
            $display("#     Hsync INT after 2^%0d number of lines     #", num_of_lines);
        else if (num_of_lines == 8)
            $display("#     Hsync INT after 2^0 number of lines     #");
        else if (num_of_lines == 9)
            $display("#     Hsync INT after 2^4 number of lines     #");
        else
            $display("#     Hsync INT after 2^6 number of lines     #");
        $display("#                                             #");
        if (num_of_lines < 8)
            $display("#     Vsync INT enabled                       #");
        else
            $display("#     Vsync INT disabled                      #");
        $display("#                                             #");
        $display("###############################################");
        test_camera_basic_func;
        @(posedge wb_clock);
    end
    test_camera_flush_func;
//    test_camera_flush_func;
//    test_camera_flush_func;
//    test_camera_flush_func;
//    test_camera_flush_func;
//    test_camera_flush_func;
//    test_camera_func;

    $display("\n\nSimulation stopped OK! \n");
    $fdisplay(tb_log_file, "");
    $fdisplay(tb_log_file, "");
    $fdisplay(tb_log_file, "Simulation stopped OK at time %t ", $time);
    $fdisplay(tb_log_file, "");
    # 10 $stop;
end
endtask

task do_reset;
begin
    reset = 1'b1;
    # 10;
    @(posedge wb_clock);
 
    reset = 1'b0;
    # 1;
end
endtask // do_reset
  
task test_rgb_calculation;
    integer cyc_cnt;
begin
    test_name   = "TEST RGB CALCULATION" ;
    // Deletting INT with reading INT_STATUS register
    write_flags`WB_TRANSFER_AUTO_RTY = 1;
    read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
    read_data`READ_SEL     = 4'hF;
    wishbone_master.wb_single_read( read_data, write_flags, read_status );

    $display(" Set WB SLAVE response to ACK with no WAIT cycles and no RTY!");
    $fdisplay(tb_log_file, " Set WB SLAVE response to ACK with no WAIT cycles and no RTY!");
    // set WB slave response         ACK noWAIT noRTY
    wishbone_slave.cycle_response(3'b100, 1'b0, 8'h0);
    // configure and enable camera interface
`ifdef HITACHI_CAM
    $display(" Set camera module parameters to 0x0000_0C07!");
    $fdisplay(tb_log_file, " Set camera module parameters to 0x0000_0C07!");
//    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0C07);
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h1C07);
`else
  `ifdef OMNIVISION_CAM
    $display(" Set camera module parameters to 0x0000_0C05!");
    $fdisplay(tb_log_file, " Set camera module parameters to 0x0000_0C05!");
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0C05);
  `endif
`endif
    cyc_cnt = 0;
        while (cyc_cnt <= 32)
        begin
     //$display("test_rgb_calculationi waiting for acknowledge");
          fork
            if (ACK_I)
            begin
                @(posedge wb_clock);
                cyc_cnt = cyc_cnt + 1;
                if (cyc_cnt == 16)
                begin
                    $display(" Set WB SLAVE response to ACK with 3 WAIT cycles and no RTY!");
                    $fdisplay(tb_log_file, " Set WB SLAVE response to ACK with 3 WAIT cycles and no RTY!");
                    // set WB slave response         ACK   WAIT noRTY
                    wishbone_slave.cycle_response(3'b100, 1'b1, 8'h0);
                end
            end
            else
                @(posedge wb_clock);
            if (INT_O)
            begin
              // Deletting INT with reading INT_STATUS register
              write_flags`WB_TRANSFER_AUTO_RTY = 1;
              read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
              read_data`READ_SEL     = 4'hF;
              wishbone_master.wb_single_read( read_data, write_flags, read_status );
            end
          join
        end
    // disable camera
    $display(" Set camera module parameters to 0x0000_0000!");
    $fdisplay(tb_log_file, " Set camera module parameters to 0x0000_0000!");
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0);
    $display(" Checking data ...");
    $fdisplay(tb_log_file, " Checking data ... at time %t ", $time);
    check_rgb_data(32'h0000_0000, 32'h0000_0080);
end
endtask // test_rgb_calculation

task test_camera_basic_func;
    integer cyc_cnt;
    integer clk_cnt;
    integer flush_cnt;
    integer flush_cnt_lim;
    integer line_cnt;
    integer pix_cnt;
    integer int_cnt;
    reg     ack_set;
    reg     int_set;
    reg [31:0] starting_chk_address;
    reg [31:0] ending_chk_address;
begin
    test_name   = "TEST CAMERA BASIC FUNCTIONALITY: configure_camera, force_camera" ;
    starting_chk_address = 32'h0;
    camera_base_address = 32'hAAAA_0000;
    dest_addr_register = 32'h0;
    ack_set = 1'b0;
    int_set = 1'b0;
    clk_cnt = 0;
    $display(" Set WB SLAVE response to ACK with no WAIT cycles and no RTY!");
    $fdisplay(tb_log_file, " Set WB SLAVE response to ACK with no WAIT cycles and no RTY!");
    // set WB slave response         ACK noWAIT noRTY
    wishbone_slave.cycle_response(3'b100, 1'b0, 8'h0);
    wait (~camera_vsync);
    wait (~camera_hsync);
    repeat (15) @(posedge cam_clock);
    // configure and enable camera interface
`ifdef HITACHI_CAM
    $display(" Set camera module parameters to 0x0000_0007!");
    $fdisplay(tb_log_file, " Set camera module parameters to 0x0000_0007!");
//    case(num_of_lines)
//    0: configure_camera(camera_base_address, dest_addr_register, 16'h1C07);
//    1: configure_camera(camera_base_address, dest_addr_register, 16'h3C07);
//    2: configure_camera(camera_base_address, dest_addr_register, 16'h5C07);
//    3: configure_camera(camera_base_address, dest_addr_register, 16'h7C07);
//    4: configure_camera(camera_base_address, dest_addr_register, 16'h9C07);
//    5: configure_camera(camera_base_address, dest_addr_register, 16'hBC07);
//    6: configure_camera(camera_base_address, dest_addr_register, 16'hDC07);
//    7: configure_camera(camera_base_address, dest_addr_register, 16'hFC07);
//    8: configure_camera(camera_base_address, dest_addr_register, 16'h1407);
//    9: configure_camera(camera_base_address, dest_addr_register, 16'h9407);
////    10:configure_camera(camera_base_address, dest_addr_register, 16'hD407);
//    10:configure_camera(camera_base_address, dest_addr_register, 16'hCC07);
//    endcase
    repeat (15) @(posedge cam_clock);
    if (num_of_lines == 10)
    begin
        configure_camera(camera_base_address, dest_addr_register, 16'hCC07);
        force_camera(16'd352, 16'd288);
        // Deletting INT with reading INT_STATUS register
        write_flags`WB_TRANSFER_AUTO_RTY = 1;
        read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
        read_data`READ_SEL     = 4'hF;
        wishbone_master.wb_single_read( read_data, write_flags, read_status );
    end
`else
  `ifdef OMNIVISION_CAM
    $display(" Set camera module parameters to 0x0000_0005!");
    $fdisplay(tb_log_file, " Set camera module parameters to 0x0000_0005!");
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0C05);
  `endif
`endif
    test_name   = "TEST CAMERA BASIC FUNCTIONALITY: NO frame" ;
    if (camera_vsync)
    begin
        $display(" Camera interface was disabled and enabled:");
        $display(" - camera interface should wait for current FRAME to finish!");
        $display(" - camera interface should not set interrupt INT!");
        $fdisplay(tb_log_file, " Camera interface was disabled and enabled:");
        $fdisplay(tb_log_file, " - camera interface should wait for current FRAME to finish!");
        $fdisplay(tb_log_file, " - camera interface should not set interrupt INT!");
        while (camera_vsync)
        begin
            @(posedge wb_clock);
            if (ACK_I)
                ack_set = 1'b1;
        end
        if (ack_set)
        begin
            $display("*Camera interface did not wait for current FRAME to finish!");
            $fdisplay(tb_log_file, "*Camera interface did not wait for current FRAME to finish at time %t ", $time);
        end
        else
        begin
            $display(" Camera interface did wait for current FRAME to finish!");
            $fdisplay(tb_log_file, " Camera interface did wait for current FRAME to finish at time %t ", $time);
        end
        while (clk_cnt < 100)
        begin
            @(posedge wb_clock);
            if (INT_O)
                int_set = 1'b1;
            clk_cnt = clk_cnt + 1;
        end
        if (int_set)
        begin
            $display("*Camera interface set the interrupt INT!");
            $fdisplay(tb_log_file, "*Camera interface set the interrupt INT at time %t ", $time);
        end
        else
        begin
            $display(" Camera interface did not set the interrupt INT!");
            $fdisplay(tb_log_file, " Camera interface did not set the interrupt INT!");
        end
    end
    $display(" Camera interface waits for FRAME to start!");
    $fdisplay(tb_log_file, " Camera interface waits for FRAME to start!");
    wait (camera_vsync);
    test_name   = "TEST CAMERA BASIC FUNCTIONALITY: frame" ;
    $display(" FRAME started!");
    $fdisplay(tb_log_file, " FRAME started at time %t ", $time);
    line_cnt = 0;
    pix_cnt = 0;
    int_cnt = 0;
    int_set = 0;
    while (camera_vsync)
    begin
        line_cnt = line_cnt + 1;
        cyc_cnt = 0;
        clk_cnt = 1; // must be different than cyc_cnt - this value is substracted
        wait (camera_hsync);
        fork
        begin
            if (line_cnt == 1)
            begin
                wait (ACK_I);
                // write destination address to camera
                starting_chk_address = 32'h0000_0000;
                case(num_of_lines)
                0: ending_chk_address = 32'h0000_02BC;
                1: ending_chk_address = 32'h0000_057C;
                2: ending_chk_address = 32'h0000_083C;
                3: ending_chk_address = 32'h0000_0AFC;
                4: ending_chk_address = 32'h0000_057C; //
                5: ending_chk_address = 32'h0000_057C;
                6: ending_chk_address = 32'h0000_057C;
                7: ending_chk_address = 32'h0000_057C;
                8: ending_chk_address = 32'h0000_057C;
                9: ending_chk_address = 32'h0000_057C;
                10:ending_chk_address = 32'h0000_057C;
                endcase
                write_data`WRITE_ADDRESS = camera_base_address;
                write_data`WRITE_DATA    = dest_addr_register + ending_chk_address + 4'h4;
                write_data`WRITE_SEL     = 4'hF;
                //$display("  Destination address of CAMERA MODULE is: %h!", dest_address);
                //$fdisplay(tb_log_file, "  Destination address of CAMERA MODULE is: %h!", dest_address);
                wishbone_master.wb_single_write(write_data, write_flags, write_status);
            end
        end
        begin
            if (INT_O)
            begin
                // Deletting INT with reading INT_STATUS register
                write_flags`WB_TRANSFER_AUTO_RTY = 1;
                read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
                read_data`READ_SEL     = 4'hF;
                wishbone_master.wb_single_read( read_data, write_flags, read_status );
                // write destination address to camera
                if ((camera_bench_top.i_camera_top.i_camera_wb_if.register_control_int_hsync_en) &&
                    (line_cnt > 1))
                begin
                    write_data`WRITE_ADDRESS = camera_base_address;
                    write_data`WRITE_DATA    = dest_addr_register + ((ending_chk_address + 4'h4) * line_cnt);
                    write_data`WRITE_SEL     = 4'hF;
                    //$display("  Destination address of CAMERA MODULE is: %h!", dest_address);
                    //$fdisplay(tb_log_file, "  Destination address of CAMERA MODULE is: %h!", dest_address);
                    wishbone_master.wb_single_write(write_data, write_flags, write_status);
                end
            end
        end
        begin
            while (camera_hsync)
            begin
                @(posedge cam_clock);
                @(posedge cam_clock);
                clk_cnt = clk_cnt + 1;
            end
            clk_cnt = clk_cnt - 2;
            // check data every time when Destination Address is going to change
//            if (~camera_bench_top.i_camera_top.i_camera_wb_if.register_control_int_hsync_en)
//            begin
                if (camera_bench_top.i_camera_top.i_camera_wb_if.all_lines_written)
                begin
                    @(posedge wb_clock);
                    starting_chk_address = 32'h0000_0000;
                    ending_chk_address   = 32'h0000_C5FC; // 10'h2C0 next line address
                    check_rgb_data(starting_chk_address, ending_chk_address);
                end
//            end
//            else
//            begin
//                if (camera_bench_top.i_camera_top.i_camera_wb_if.all_lines_written || 
//                    camera_bench_top.i_camera_top.i_camera_wb_if.num_of_lines_written)
//                begin
//                    case(num_of_lines)
//                    0: 
//                    1: 
//                    2: 
//                    3: 
//                    4: 
//                    5: 
//                    6: 
//                    7: 
//                    8: 
//                    9: 
//                    10: 
//                    endcase
//                    check_rgb_data(32'h0000_0000, 32'h0000_C5FC);
//                end
//            end
        end
        begin
            while (cyc_cnt != clk_cnt)
            begin
                @(posedge wb_clock);
                if (ACK_I)
                begin
                    cyc_cnt = cyc_cnt + 2;
                    pix_cnt = pix_cnt + 2;
                end
                if (INT_O)
                begin
                    int_set = 1'b1;
                    int_cnt = pix_cnt;
                end
            end
        end
        join
        //$display(" Line %0d with %0d pixels written!", line_cnt, cyc_cnt);
        $fdisplay(tb_log_file, " Line %0d with %0d pixels written at time %t ", line_cnt, cyc_cnt, $time);
    end
    $display(" FRAME ended with %0d pixels!", pix_cnt);
    $display(" Checking interrupt INT.");
    $fdisplay(tb_log_file, " FRAME ended with %0d pixels at time %t ", pix_cnt, $time);
    $fdisplay(tb_log_file, " Checking interrupt INT");
//    if (int_set)
//    begin
//        $display(" Interrupt set after %0d. pixel!", int_cnt);
//        $fdisplay(tb_log_file, " Interrupt set after %0d. pixel!", int_cnt);
//    end
//    else
//    begin
//        wait (INT_O);
//        $display(" Interrupt set after %0d. pixel!", pix_cnt);
//        $fdisplay(tb_log_file, " Interrupt set after %0d. pixel!", pix_cnt);
//    end
    test_name   = "End of TEST CAMERA BASIC FUNCTIONALITY" ;
    repeat (10) @(posedge cam_clock);
    repeat (10) @(posedge wb_clock);
    // Deletting INT with reading INT_STATUS register
    write_flags`WB_TRANSFER_AUTO_RTY = 1;
    read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
    read_data`READ_SEL     = 4'hF;
    wishbone_master.wb_single_read( read_data, write_flags, read_status );
    $display(" Checking whole FRAME data ...");
    $fdisplay(tb_log_file, " Checking whole FRAME data ... at time %t ", $time);
    check_rgb_data(32'h0000_0000, 32'h0000_C5FC);
end
endtask // test_camera_basic_func

task test_camera_flush_func;
    integer cyc_cnt;
    integer clk_cnt;
    integer flush_cnt;
    integer flush_cnt_lim;
    integer line_cnt;
    integer pix_cnt;
    integer int_cnt;
    reg     ack_set;
    reg     int_set;
begin
    wait (!camera_vsync);
    $display(" Set WB SLAVE response to ACK with random WAIT cycles and no RTY!");
    $fdisplay(tb_log_file, " Set WB SLAVE response to ACK with random WAIT cycles and no RTY!");
    // set WB slave response         ACK   randomWAIT    noRTY
    wishbone_slave.cycle_response(3'b100, ($random % 2), 8'h0);
    // configure and enable camera interface
`ifdef HITACHI_CAM
    $display(" Set camera module parameters!");
    $fdisplay(tb_log_file, " Set camera module parameters!");
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0C07);
`else
  `ifdef OMNIVISION_CAM
    $display(" Set camera module parameters!");
    $fdisplay(tb_log_file, " Set camera module parameters!");
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0C05);
  `endif
`endif
    // Deletting INT with reading INT_STATUS register
    write_flags`WB_TRANSFER_AUTO_RTY = 1;
    read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
    read_data`READ_SEL     = 4'hF;
    wishbone_master.wb_single_read( read_data, write_flags, read_status );
    $display(" Checking interrupt INT.");
    $fdisplay(tb_log_file, " Checking interrupt INT");
    wait (!INT_O)
    $display(" Interrupt INT is deactivated!");
    $fdisplay(tb_log_file, " Interrupt INT is deactivated at time %t ", $time);

    $display(" Set WB SLAVE response to no RESPONSE!");
    $fdisplay(tb_log_file, " Set WB SLAVE response to no RESPONSE!");
    // set WB slave response      noRESP noWAIT noRTY
    wishbone_slave.cycle_response(3'b000, 1'b0, 8'h0);
    $display(" Camera interface waits for FRAME to start!");
    $fdisplay(tb_log_file, " Camera interface waits for FRAME to start!");
    wait (camera_vsync);
    $display(" FRAME started!");
    $fdisplay(tb_log_file, " FRAME started at time %t ", $time);
    cyc_cnt = 0;
    clk_cnt = 0;
    flush_cnt = 0;
    flush_cnt_lim = 0;
    fork
    begin:watch_cam
        while (camera_hsync)
        begin
            @(posedge cam_clock);
            @(posedge cam_clock);
            clk_cnt = clk_cnt + 1;
        end
    end
    begin:set_wb
        wait (camera_bench_top.i_camera_top.i_camera_wb_if.fifo_flushed_i);
        #1;
        $display(" FIFO was flushed!");
        $fdisplay(tb_log_file, " FIFO was flushed at time %t! ", $time);
        case (global_ack_response_when_fifo_flushed_cnt)
        0,1:     flush_cnt_lim = 1;
        2,3:     flush_cnt_lim = 2;
        default: flush_cnt_lim = ($random % 3) + 4; // range from 2 to 6
        endcase
        #1;
        while ((flush_cnt != flush_cnt_lim) &&
               (camera_bench_top.i_camera_top.i_camera_wb_if.fifo_flushed))
        begin
            flush_cnt = flush_cnt + 1;
            if (flush_cnt == flush_cnt_lim)
            begin
                case (global_ack_response_when_fifo_flushed_cnt)
                         // set WB slave response         ACK noWAIT noRTY
                0,1,2,3: wishbone_slave.cycle_response(3'b100, 1'b0, 8'h0);
                         // set WB slave response         ACK   randomWAIT    noRTY
                default: wishbone_slave.cycle_response(3'b100, ($random % 2), 8'h0);
                endcase
                #1;
            end
            @(posedge wb_clock);
            #1;
        end
    end
    begin:watch_wb
        wait (CYC_O);
        $display(" Cycle on WB started, but there should not be any response until FIFO flush!");
        $fdisplay(tb_log_file, " Cycle on WB started at time %t, but there should not be any response until FIFO flush! ", $time);
        while (CYC_O)
        begin
            @(posedge wb_clock);
            if (ACK_I)
            begin
                if (camera_bench_top.i_camera_top.i_camera_wb_if.fifo_flushed)
                begin
                    global_ack_response_when_fifo_flushed_cnt = global_ack_response_when_fifo_flushed_cnt + 1;
                    $display(" WB SLAVE behavioral acknowledged the cycle %0d WB clocks after FIFO was flushed!", flush_cnt);
                    $fdisplay(tb_log_file, " WB SLAVE behavioral acknowledged the cycle after FIFO was flushed at time %t", $time);
                end
                else
                begin
                    cyc_cnt = cyc_cnt + 2;
                    $display("*WB SLAVE behavioral should not acknowledge the cycle before FIFO flush!");
                    $fdisplay(tb_log_file, "*WB SLAVE behavioral should not acknowledge the cycle before FIFO flush at time %t ", $time);
                end
            end
        end
        $display(" Cycle on WB ended and camera interface had overrun!");
        $fdisplay(tb_log_file, " Cycle on WB ended and camera interface had overrun at time %t ", $time);
        disable watch_cam;
        disable set_wb;
    end
    join
end
endtask // test_camera_flush_func

task test_camera_func;
    integer cyc_cnt;
    integer clk_cnt;
    integer flush_cnt;
    integer flush_cnt_lim;
    integer line_cnt;
    integer pix_cnt;
    integer int_cnt;
    reg     ack_set;
    reg     int_set;
begin
    ack_set = 1'b0;
    int_set = 1'b0;
    $display(" Set WB SLAVE response to ACK with random WAIT cycles and no RTY!");
    $fdisplay(tb_log_file, " Set WB SLAVE response to ACK with random WAIT cycles and no RTY!");
    // set WB slave response         ACK randomWAIT noRTY
    wishbone_slave.cycle_response(3'b100, ($random % 2), 8'h0);
    $display(" Camera interface had overrun and fifo was flushed:");
    $display(" - camera interface should wait for current FRAME to finish!");
    $display(" - camera interface should not set interrupt INT!");
    $fdisplay(tb_log_file, " Camera interface had overrun and fifo was flushed:");
    $fdisplay(tb_log_file, " - camera interface should wait for current FRAME to finish!");
    $fdisplay(tb_log_file, " - camera interface should not set interrupt INT!");
    while (camera_vsync)
    begin
        @(posedge wb_clock);
        if (ACK_I)
            ack_set = 1'b1;
    end
    if (ack_set)
    begin
        $display("*Camera interface did not wait for current FRAME to finish!");
        $fdisplay(tb_log_file, "*Camera interface did not wait for current FRAME to finish at time %t ", $time);
    end
    else
    begin
        $display(" Camera interface did wait for current FRAME to finish!");
        $fdisplay(tb_log_file, " Camera interface did wait for current FRAME to finish at time %t ", $time);
    end
    while (clk_cnt < 100)
    begin
        @(posedge wb_clock);
        if (INT_O)
            int_set = 1'b1;
        clk_cnt = clk_cnt + 1;
    end
    if (int_set)
    begin
        $display("*Camera interface set the interrupt INT!");
        $fdisplay(tb_log_file, "*Camera interface set the interrupt INT at time %t ", $time);
    end
    else
    begin
        $display(" Camera interface did not set the interrupt INT!");
        $fdisplay(tb_log_file, " Camera interface did not set the interrupt INT!");
    end
    
    $display(" Camera interface waits for FRAME to start!");
    $fdisplay(tb_log_file, " Camera interface waits for FRAME to start!");
    wait (camera_vsync);
    $display(" FRAME started!");
    $fdisplay(tb_log_file, " FRAME started at time %t ", $time);
    line_cnt = 0;
    pix_cnt = 0;
    int_cnt = 0;
    int_set = 0;
    while (camera_vsync)
    begin
        line_cnt = line_cnt + 1;
        cyc_cnt = 0;
        clk_cnt = 1; // must be different than cyc_cnt - this value is substracted
        wait (camera_hsync);
        fork
        begin
            while (camera_hsync)
            begin
                @(posedge cam_clock);
                @(posedge cam_clock);
                clk_cnt = clk_cnt + 1;
            end
            clk_cnt = clk_cnt - 2;
        end
        begin
            while (cyc_cnt != clk_cnt)
            begin
                @(posedge wb_clock);
                if (ACK_I)
                begin
                    cyc_cnt = cyc_cnt + 2;
                    pix_cnt = pix_cnt + 2;
                end
                if (INT_O)
                begin
                    int_set = 1'b1;
                    int_cnt = pix_cnt;
                end
            end
        end
        begin
            if (INT_O)
            begin
                // Deletting INT with reading INT_STATUS register
                write_flags`WB_TRANSFER_AUTO_RTY = 1;
                read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
                read_data`READ_SEL     = 4'hF;
                wishbone_master.wb_single_read( read_data, write_flags, read_status );
            end
        end
        join
        $write(".");
        cyc_cnt = 0;
        //$display(" Line %0d with %0d pixels written!", line_cnt, cyc_cnt);
        $fdisplay(tb_log_file, " Line %0d with %0d pixels written at time %t ", line_cnt, cyc_cnt, $time);
    end
    $display(" FRAME ended with %0d pixels!", pix_cnt);
    $display(" Checking interrupt INT.");
    $fdisplay(tb_log_file, " FRAME ended with %0d pixels at time %t ", pix_cnt, $time);
    $fdisplay(tb_log_file, " Checking interrupt INT.");
    if (int_set)
    begin
        $display(" Interrupt set after %0d. pixel!", int_cnt);
        $fdisplay(tb_log_file, " Interrupt set after %0d. pixel at time %t ", int_cnt, $time);
    end
    else
    begin
        wait (INT_O);
        $display(" Interrupt set after %0d. pixel!", pix_cnt);
        $fdisplay(tb_log_file, " Interrupt set after %0d. pixel at time %t ", pix_cnt, $time);
    end
    $display(" Checking whole FRAME data ...");
    $fdisplay(tb_log_file, " Checking whole FRAME data ... at time %t ", $time);
    check_rgb_data(32'h0000_0100, 32'h0000_C6FC);
    // configure and enable camera interface
`ifdef HITACHI_CAM
    $display(" Set camera module parameters to 0x0000_0007!");
    $fdisplay(tb_log_file, " Set camera module parameters to 0x0000_0007!");
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0C07);
`else
  `ifdef OMNIVISION_CAM
    $display(" Set camera module parameters to 0x0000_0005!");
    $fdisplay(tb_log_file, " Set camera module parameters to 0x0000_0005!");
    configure_camera(32'hAAAA_0000, 32'h0000_0000, 16'h0C05);
  `endif
`endif
    // Deletting INT with reading INT_STATUS register
    write_flags`WB_TRANSFER_AUTO_RTY = 1;
    read_data`READ_ADDRESS = 32'hAAAA_0008; // STATUS register
    read_data`READ_SEL     = 4'hF;
    wishbone_master.wb_single_read( read_data, write_flags, read_status );
    $display(" Checking interrupt INT.");
    $fdisplay(tb_log_file, " Checking interrupt INT.");
    wait (!INT_O)
    $display(" Interrupt INT is deactivated!");
    $fdisplay(tb_log_file, " Interrupt INT is deactivated at time %t ", $time);
end
endtask // test_camera_func

task configure_camera;
    input [31:0]  camera_address;
    input [31:0]  dest_address;
    input [15:0]  control;
begin
    repeat(4)
        @(posedge cam_clock);
    repeat(2)
        @(posedge wb_clock);
    // no need to handle retries
    write_flags`WB_TRANSFER_AUTO_RTY = 0;

    // write destination address to camera
    write_data`WRITE_ADDRESS = camera_address;
    write_data`WRITE_DATA    = dest_address;
    write_data`WRITE_SEL     = 4'hF;
    $display("  Destination address of CAMERA MODULE is: %h!", dest_address);
    $fdisplay(tb_log_file, "  Destination address of CAMERA MODULE is: %h!", dest_address);
    wishbone_master.wb_single_write(write_data, write_flags, write_status);
    
    // write enable bit to enable/disable camera
    write_data`WRITE_ADDRESS = camera_address + 3'h4;
    write_data`WRITE_DATA    = {16'h0, control};
    write_data`WRITE_SEL     = 4'hF;
    if (control[0])
    begin
        $display("  CAMERA MODULE is enabled!");
        $fdisplay(tb_log_file, "  CAMERA MODULE is enabled!");
    end
    else
    begin
        $display("  CAMERA MODULE is disabled!");
        $fdisplay(tb_log_file, "  CAMERA MODULE is disabled!");
    end
    wishbone_master.wb_single_write(write_data, write_flags, write_status);
end
endtask // configure_camera

task force_camera;
    input [15:0]  hsync;
    input [15:0]  vsync;
begin
    @(posedge wb_clock)
        camera_bench_top.i_camera_top.i_camera_wb_if.register_hsync_res[16:0] <= #1 17'h0_0160;
        camera_bench_top.i_camera_top.i_camera_wb_if.register_vsync_res[16:0] <= #1 17'h0_0120;
        camera_bench_top.i_camera_top.i_camera_wb_if.wait_for_start_of_frame  <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.wait_for_end_of_frame    <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.first_clean_frame_ended  <= #1  1'b1;
        camera_bench_top.i_camera_top.i_camera_wb_if.camera_en_o              <= #1  1'b1;
    @(posedge wb_clock)
        camera_bench_top.i_camera_top.i_camera_wb_if.register_hsync_res[16:0] <= #1 17'h0_0160;
        camera_bench_top.i_camera_top.i_camera_wb_if.register_vsync_res[16:0] <= #1 17'h0_0120;
        camera_bench_top.i_camera_top.i_camera_wb_if.wait_for_start_of_frame  <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.wait_for_end_of_frame    <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.first_clean_frame_ended  <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.camera_en_o              <= #1  1'b1;
    @(posedge wb_clock)
        camera_bench_top.i_camera_top.i_camera_wb_if.register_hsync_res[16:0] <= #1 17'h0_0160;
        camera_bench_top.i_camera_top.i_camera_wb_if.register_vsync_res[16:0] <= #1 17'h0_0120;
        camera_bench_top.i_camera_top.i_camera_wb_if.wait_for_start_of_frame  <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.wait_for_end_of_frame    <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.first_clean_frame_ended  <= #1  1'b0;
        camera_bench_top.i_camera_top.i_camera_wb_if.camera_en_o              <= #1  1'b1;
    $display("  Camera core was forced to pass first clean frame with HSYNC = %0d and VSYNC = %0d !", hsync, vsync);
    $fdisplay(tb_log_file, "  Camera core was forced to pass first clean frame with HSYNC = %0d and VSYNC = %0d !", hsync, vsync);
end
endtask // force_camera

task check_rgb_data;
    input [31:0]  dest_address;
    input [31:0]  end_address;
    reg   [31:0]  wb_mem_address;
    reg   [31:0]  wb_rgb_1_2_data;
    reg   [23:0]  cam_rgb_1_data;
    reg   [23:0]  cam_rgb_2_data;
    integer       data_ok_cnt;
    integer       data_fail_cnt;
    integer       data_cnt;
begin
    $fdisplay(tb_log_file, "  CHECKING DATA:");
    wb_mem_address   = dest_address;
    rgb_memory_index = 6'h0;
    data_ok_cnt      = 0;
    data_fail_cnt    = 0;
    data_cnt         = 0;
    while (wb_mem_address <= end_address)
    begin
        // rgb_memory values repeates through whole wb_memory space
        wb_rgb_1_2_data  = wishbone_slave.wb_memory[wb_mem_address[21:2]];
        // rgb_memory_index[5:0] covers all rgb_memory locations
        cam_rgb_1_data   = rgb_memory[rgb_memory_index]; 
        # 1;
        rgb_memory_index = rgb_memory_index + 1'b1;
        # 1;
        cam_rgb_2_data   = rgb_memory[rgb_memory_index];
        # 1;
        data_cnt         = data_cnt + 1'b1;
        # 1;

        if ((wb_rgb_1_2_data[15:0]) == ({cam_rgb_1_data[23:19], cam_rgb_1_data[15:10], cam_rgb_1_data[7:3]}))
        begin
            $fdisplay(tb_log_file, "  [ OK ] data on address %h is %h, rgb_mem_i:", 
                      wb_mem_address, wb_rgb_1_2_data[15:0], rgb_memory_index);
            data_ok_cnt = data_ok_cnt + 1;
        end
        else
        begin
            $fdisplay(tb_log_file, "* [FAIL] %0d. data on address %h is %h; it should be %h, rgb_mem_i:", 
                      data_cnt, wb_mem_address, wb_rgb_1_2_data[15:0], 
                      {cam_rgb_1_data[23:19], cam_rgb_1_data[15:10], cam_rgb_1_data[7:3]}, rgb_memory_index);
            data_fail_cnt = data_fail_cnt + 1;
        end

        data_cnt         = data_cnt + 1'b1;
        # 1;

        if ((wb_rgb_1_2_data[31:16]) == ({cam_rgb_2_data[23:19], cam_rgb_2_data[15:10], cam_rgb_2_data[7:3]}))
        begin
            $fdisplay(tb_log_file, "  [ OK ] data on address %h is %h, rgb_mem_i:", 
                      wb_mem_address + 2'h2, wb_rgb_1_2_data[31:16], rgb_memory_index);
            data_ok_cnt = data_ok_cnt + 1;
        end
        else
        begin
            $fdisplay(tb_log_file, "* [FAIL] %0d. data on address %h is %h; it should be %h, rgb_mem_i:", 
                      data_cnt, wb_mem_address + 2'h2, wb_rgb_1_2_data[31:16], 
                      {cam_rgb_2_data[23:19], cam_rgb_2_data[15:10], cam_rgb_2_data[7:3]}, rgb_memory_index);
            data_fail_cnt = data_fail_cnt + 1;
        end

        wb_mem_address   = wb_mem_address + 3'h4;
        rgb_memory_index = rgb_memory_index + 1'b1;
        # 1;
    end
    $display("  Number of calculated and written R G B data FAILED: %0d.", data_fail_cnt);
    $display("  Number of calculated and written R G B data PASSED: %0d.", data_ok_cnt);
    $display("");
    $fdisplay(tb_log_file, "  Number of calculated and written R G B data FAILED: %0d.", data_fail_cnt);
    $fdisplay(tb_log_file, "  Number of calculated and written R G B data PASSED: %0d.", data_ok_cnt);
    $fdisplay(tb_log_file, "");
end
endtask // check_rgb_data

`ifdef HITACHI_CAM

// CAMERA module: HAM49001 (Hitachi) - color camera
reg  [2:0] start_cnt;
reg  [9:0] hsync_cnt;
reg  [8:0] vsync_cnt;
always@(negedge cam_clock or posedge reset)
begin
    if (reset)
        start_cnt <= 3'h4;
    else
        if (start_cnt != 3'h0)
            start_cnt <= start_cnt - 1'b1;
end
always@(negedge cam_clock)
begin
    if (start_cnt != 3'h0)
        hsync_cnt <= 10'h0;
    else
    begin
        if (hsync_cnt < 800)
             hsync_cnt <= hsync_cnt + 1'b1;
        else
             hsync_cnt <= 10'h0;
    end
end
always@(start_cnt or hsync_cnt)
begin
    if (start_cnt != 3'h0)
        camera_hsync = 1'b1;
    else if (hsync_cnt <= 96)
    begin
        camera_hsync = 1'b0;
    end
    else
        camera_hsync = 1'b1;
end
always@(negedge camera_hsync)
begin
    if (start_cnt != 3'h0)
        vsync_cnt <= 9'h0;
    else
    begin
        if (vsync_cnt < 400)
             vsync_cnt <= vsync_cnt + 1'b1;
        else
             vsync_cnt <= 9'h0;
    end
end
always@(start_cnt or vsync_cnt)
begin
    if (start_cnt != 3'h0)
        camera_vsync = 1'b1;
    else if (vsync_cnt <= 112)
    begin
        camera_vsync = 1'b0;
    end
    else
        camera_vsync = 1'b1;
end
always@(negedge cam_clock)
begin
    if (start_cnt != 3'h0)
        cam_memory_index <= 7'h0;
    else
    begin
        if (camera_vsync && camera_hsync)
            cam_memory_index <= cam_memory_index + 1'b1;
        else if (camera_vsync)
            cam_memory_index <= cam_memory_index;
        else
            cam_memory_index <= 7'h0;
    end
end
always@(start_cnt or camera_vsync or camera_hsync or /*cam_memory or*/ cam_memory_index)
begin
    if (start_cnt != 3'h0)
        camera_data = 8'h5A;
    else if (camera_vsync && camera_hsync)
    begin
        camera_data = cam_memory[cam_memory_index];
    end
    else
        camera_data = 8'hA5;
end

`else
  `ifdef OMNIVISION_CAM

// CAMERA module: OV7635FB (OmniVision) - color camera
reg  [2:0] start_cnt;
reg  [9:0] hsync_cnt;
reg  [8:0] vsync_cnt;
reg        hsync;
reg        vsync;
always@(negedge cam_clock or posedge reset)
begin
    if (reset)
        start_cnt <= 3'h4;
    else
        if (start_cnt != 3'h0)
            start_cnt <= start_cnt - 1'b1;
end
always@(negedge cam_clock)
begin
    if (start_cnt != 3'h0)
        hsync_cnt <= 10'h0;
    else
    begin
        if (hsync_cnt < 800)
             hsync_cnt <= hsync_cnt + 1'b1;
        else
             hsync_cnt <= 10'h0;
    end
end
always@(start_cnt or hsync_cnt)
begin
    if (start_cnt != 3'h0)
        hsync = 1'b0;
    else if (hsync_cnt <= 96)
    begin
        hsync = 1'b0;
    end
    else
        hsync = 1'b1;
end
always@(negedge hsync)
begin
    if (start_cnt != 3'h0)
        vsync_cnt <= 9'h0;
    else
    begin
        if (vsync_cnt < 400)
             vsync_cnt <= vsync_cnt + 1'b1;
        else
             vsync_cnt <= 9'h0;
    end
end
always@(start_cnt or vsync_cnt)
begin
    if (start_cnt != 3'h0)
    begin
        vsync = 1'b0;
    end
    else if (vsync_cnt <= 112)
    begin
        vsync = 1'b0;
    end
    else
    begin
        vsync = 1'b1;
    end
end
always@(hsync or vsync)
begin
    if (vsync) // valid camera_hsync
        camera_hsync = hsync; // camera_hsync is active HI
    else
        camera_hsync = 1'b0;

    camera_vsync = !vsync; // camera_vsync is active LO
end
always@(negedge cam_clock)
begin
    if (start_cnt != 3'h0)
        cam_memory_index <= 7'h0;
    else
    begin
        if (vsync && hsync)
            cam_memory_index <= cam_memory_index + 1'b1;
        else if (vsync)
            cam_memory_index <= cam_memory_index;
        else
            cam_memory_index <= 7'h0;
    end
end
always@(start_cnt or vsync or hsync or /*cam_memory or*/ cam_memory_index)
begin
    if (start_cnt != 3'h0)
        camera_data = 8'h5A;
    else if (vsync && hsync)
    begin
        camera_data = cam_memory[cam_memory_index];
    end
    else
        camera_data = 8'hA5;
end

  `endif
`endif


endmodule
