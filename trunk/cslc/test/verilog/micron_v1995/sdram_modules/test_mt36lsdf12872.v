/******************************************************************************
*
*    File Name:  TEST.V
*
*  Description:  This is a testbench for MT36LSDF12872.V
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright (c) 2001 Micron Semiconductor Products, Inc.
*                All rights researved
*
******************************************************************************/

`timescale 1ns / 1ps

module test;

reg         [71 : 0] dq;                            // SDRAM I/O
reg         [12 : 0] addr;                          // SDRAM Address
reg                  clk;                           // Clock
reg                  cke;                           // Synchronous Clock Enable
reg                  cs_n;                          // CS#
reg                  ras_n;                         // RAS#
reg                  we_n;                          // WE#
reg                  cas_n;                         // CAS#
reg                  dqm;                           // I/O Mask
reg          [1 : 0] ba;                            // Bank Address
reg                  rege;

wire        [71 : 0] DQ = dq;
wire         [3 : 0] CLK = {4{clk}};
wire         [1 : 0] CKE = {2{cke}};
wire         [3 : 0] CS_N = {4{cs_n}};
wire         [7 : 0] DQM = {8{dqm}};

parameter            hi_z = 72'bz;                  // Hi-Z

mt36lsdf12872 module1 (DQ, addr, ba, CLK, CKE, CS_N, ras_n, cas_n, we_n, DQM, rege);

initial begin
    ba   = 1'b0;
    dq   = hi_z;
    rege = 1'b1;
    clk  = 1'b0;
end

always #5 clk = ~clk;
//
always @ (posedge clk) begin
    $strobe("at time %t, clk=%b cke=%b CS#=%b RAS#=%b CAS#=%b WE#=%b dqm=%b addr=%b ba=%b DQ=%h",
            $time, clk, cke, cs_n, ras_n, cas_n, we_n, dqm, addr, ba, DQ);
end
//
task active;
    input  [1 : 0] bank;
    input [11 : 0] row;
    input [71 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 1;
        dqm   = 0;
        ba    = bank;
        addr  = row;
        dq    = dq_in;
    end
endtask

task auto_refresh;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 0;
        we_n  = 1;
        dqm   = 0;
        ba    = 0;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task burst_term;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 1;
        we_n  = 0;
        dqm   = 0;
        ba    = 0;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task load_mode_reg;
    input [13 : 0] op_code;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 0;
        we_n  = 0;
        dqm   = 0;
        ba    = op_code [13 : 12];
        addr  = op_code [11 :  0];
        dq    = hi_z;
    end
endtask

task nop;
    input [71 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 1;
        we_n  = 1;
        dqm   = 0;
        //ba    = 0;
        //addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_bank_0;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = 0;
        ba    = 0;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task precharge_bank_1;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = 0;
        ba    = 1;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task precharge_bank_2;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = 0;
        ba    = 2;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task precharge_bank_3;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = 0;
        ba    = 3;
        addr  = 0;
        dq    = hi_z;
    end
endtask

task precharge_all_bank;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = 0;
        ba    = 0;
        addr  = 1024;            // A10 = 1
        dq    = hi_z;
    end
endtask

task read;
    input          dqm_in;
    input  [1 : 0] bank;
    input [11 : 0] column;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 0;
        we_n  = 1;
        dqm   = dqm_in;
        ba    = bank;
        addr  = column;
        dq    = hi_z;
    end
endtask

task write;
    input          dqm_in;
    input  [1 : 0] bank;
    input [11 : 0] column;
    input [71 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 0;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = bank;
        addr  = column;
        dq    = dq_in;
    end
endtask

initial begin
    begin
        #00; nop (hi_z);                        // Nop
        #50; precharge_all_bank;                // Precharge ALL Bank
        #10; nop (hi_z);                        // Nop
        #20; auto_refresh;                      // Auto Refresh
        #10; nop (hi_z);                        // Nop
        #80; auto_refresh;                      // Auto Refresh
        #10; nop (hi_z);                        // Nop
        #80; load_mode_reg (51);                // Load Mode: Lat = 3, BL = 8, Seq
        #10; nop (hi_z);                        // Nop
        #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
        #10; nop (hi_z);
        #10; active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
        #10; nop (hi_z);
        #10; active (2, 0, hi_z);               // Active: Bank = 2, Row = 0
        #10; nop (hi_z);
        #10; active (3, 0, hi_z);               // Active: Bank = 3, Row = 0
        #10; nop (hi_z);                        // Nop
        #10; nop (hi_z);                        // Nop
        #10; write (0, 0, 0, hi_z);             // Write: Bank = 0, Col = 0
        #10; nop (10);                          //                           Data = 10
        #10; nop (11);                          //        Continue Burst,    Data = 11
        #10; nop (12);                          //        Continue Burst,    Data = 12
        #10; nop (13);                          //        Continue Burst,    Data = 13
        #10; nop (14);                          //        Continue Burst,    Data = 14
        #10; nop (15);                          //        Continue Burst,    Data = 15
        #10; nop (16);                          //        Continue Burst,    Data = 16
        #10; nop (17);                          //        Continue Burst,    Data = 17
        #10; nop (hi_z);                        // Nop

        #10; write (0, 1, 0, hi_z);             // Write: Bank = 0, Col = 0
        #10; nop (20);                          //                           Data = 20
        #10; nop (21);                          //        Continue Burst,    Data = 21
        #10; nop (22);                          //        Continue Burst,    Data = 22
        #10; nop (23);                          //        Continue Burst,    Data = 23
        #10; nop (24);                          //        Continue Burst,    Data = 24
        #10; nop (25);                          //        Continue Burst,    Data = 25
        #10; nop (26);                          //        Continue Burst,    Data = 26
        #10; nop (27);                          //        Continue Burst,    Data = 27
        #10; nop (hi_z);                        // Nop
                                                                                    
        #10; write (0, 2, 0, hi_z);             // Write: Bank = 0, Col = 0
        #10; nop (30);                          //                           Data = 30
        #10; nop (31);                          //        Continue Burst,    Data = 31
        #10; nop (32);                          //        Continue Burst,    Data = 32
        #10; nop (33);                          //        Continue Burst,    Data = 33
        #10; nop (34);                          //        Continue Burst,    Data = 34
        #10; nop (35);                          //        Continue Burst,    Data = 35
        #10; nop (36);                          //        Continue Burst,    Data = 36
        #10; nop (37);                          //        Continue Burst,    Data = 37
        #10; nop (hi_z);                        // Nop

        #10; write (0, 3, 0, hi_z);             // Write: Bank = 0, Col = 0
        #10; nop (40);                          //                           Data = 40
        #10; nop (41);                          //        Continue Burst,    Data = 41
        #10; nop (42);                          //        Continue Burst,    Data = 42
        #10; nop (43);                          //        Continue Burst,    Data = 43
        #10; nop (44);                          //        Continue Burst,    Data = 44
        #10; nop (45);                          //        Continue Burst,    Data = 45
        #10; nop (46);                          //        Continue Burst,    Data = 46
        #10; nop (47);                          //        Continue Burst,    Data = 47
        #10; nop (hi_z);                        // Nop

        #10; nop (hi_z);                        // Nop
        #10; nop (hi_z);                        // Nop

        #10; read (0, 0, 0);                    // Read:  Bank = 0, Col = 0
        #10; nop (hi_z);                        // Nop
        #80;

        #10; read (0, 1, 0);                    // Read:  Bank = 1, Col = 0
        #10; nop (hi_z);                        // Nop
        #80;

        #10; read (0, 2, 0);                    // Read:  Bank = 2, Col = 0
        #10; nop (hi_z);                        // Nop
        #80;

        #10; read (0, 3, 0);                    // Read:  Bank = 3, Col = 0
        #10; nop (hi_z);                        // Nop
        #10; nop (hi_z);                        // Nop
        #10; nop (hi_z);                        // Nop
        #10; nop (hi_z);                        // Nop
        #90;
    end
$stop;
$finish;
end

endmodule

