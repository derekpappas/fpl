/******************************************************************************
*
*    File Name:  TEST.V
*
*       Author:  Son P. Huynh
*        Email:  sphuynh@micron.com
*        Phone:  (208) 368-3825
*      Company:  Micron Technology, Inc.
*
*  Description:  This is a testbench for MT18LSDT3272.V
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright © 1998 Micron Semiconductor Products, Inc.
*                All rights researved
*
******************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 100ps

module test;

reg          [3 : 0] dq;                            // SDRAM I/O
reg         [11 : 0] addr;                          // SDRAM Address
reg          [1 : 0] ba;                            // Bank Address
reg                  clk;                           // Clock
reg                  cke;                           // Synchronous Clock Enable
reg                  cs_n;                          // CS#
reg                  ras_n;                         // RAS#
reg                  cas_n;                         // CAS#
reg                  we_n;                          // WE#
reg                  dqm;                           // I/O Mask
reg                  Rege;

wire        [71 : 0] DQ = dq;
wire         [7 : 0] DQM = {7{dqm}};

parameter            hi_z = 72'bz;                   // Hi-Z

mt18lsdt3272 dimm (DQ, addr, ba, clk, cke, cs_n, cs_n, ras_n, cas_n, we_n, DQM, Rege);

initial begin
    clk = 1'b0;
    cke = 1'b0;
    cs_n = 1'b1;
    dq  = hi_z;
    Rege = 1'b1;
end

always #5 clk = ~clk;

/*
always @ (posedge clk) begin
    $strobe("at time %t clk=%b cke=%b CS#=%b RAS#=%b CAS#=%b WE#=%b dqm=%b addr=%b ba=%b DQ=%d",
            $time, clk, cke, cs_n, ras_n, cas_n, we_n, dqm, addr, ba, DQ);
end
*/

task active;
    input  [1 : 0] bank;
    input [11 : 0] row;
    input  [3 : 0] dq_in;
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
    input         dqm_in;
    input [3 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 1;
        we_n  = 1;
        dqm   = dqm_in;
        ba    = 0;
        addr  = 0;
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
    input          dqm_in;
    input  [3 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 0;
        addr  = 1024;            // A10 = 1
        dq    = dq_in;
    end
endtask

task read;
    input  [1 : 0] bank;
    input [11 : 0] column;
    input  [3 : 0] dq_in;
    input          dqm_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 1;
        cas_n = 0;
        we_n  = 1;
        dqm   = dqm_in;
        ba    = bank;
        addr  = column;
        dq    = dq_in;
    end
endtask

task write;
    input  [1 : 0] bank;
    input [11 : 0] column;
    input  [3 : 0] dq_in;
    input          dqm_in;
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

integer Case;

initial begin
    begin
            // ALTERNATE BANK WRITE / READ ACCESSES (CL = 2, BL = 4)
            #10; nop    (0, hi_z);                  // Nop
            #40; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
            #10; nop    (0, hi_z);                  // Nop
            #10; auto_refresh;                      // Auto Refresh
            #10; nop    (0, hi_z);                  // Nop
            #60; auto_refresh;                      // Auto Refresh
            #10; nop    (0, hi_z);                  // Nop
            #60; load_mode_reg (34);                // Load Mode: Lat = 2, BL = 4, Seq
            #10; nop    (0, hi_z);                  // Nop
            #10; active (0,    0, hi_z);            // Active: Bank = 0, Row = 0
            #10; nop    (0,       hi_z);            // Nop
            #10; write  (0, 1024, hi_z, 0);         // Write : Bank = 0, Col = 0, Dqm = 0, Auto Precharge
            #10; nop    (0,       1);               // Nop
            #10; active (1,    0, 2);               // Active: Bank = 1, Row = 0
            #10; nop    (0,       3);               // Nop
            #10; nop    (0,       4);               // Nop
            #10; write  (1, 1024, hi_z, 0);         // Write : Bank = 1, Col = 0, Dqm = 0, Auto Precharge
            #10; nop    (0,       5);               // Nop
            #10; active (0,    0, 6);               // Active: Bank = 0, Row = 0
            #10; nop    (0,       7);               // Nop
            #10; nop    (0,       8);               // Nop
            #10; read   (0, 1024, hi_z, 0);         // Read  : Bank = 0, Col = 0, Dqm = 0, Auto Precharge
            #10; nop    (0,       hi_z);            // Nop
            #10; active (1,    0, hi_z);            // Active: Bank = 1, Row = 0
            #10; nop    (0,       hi_z);            // Nop
            #10; nop    (0,       hi_z);            // Nop
            #10; read   (1, 1024, hi_z, 0);         // Read  : Bank = 1, Col = 0, Dqm = 0, Auto Precharge
            #10; nop    (0,       hi_z);            // Nop
            #10; nop    (0,       hi_z);            // Nop
            #10; nop    (0,       hi_z);            // Nop
            #10; nop    (0,       hi_z);            // Nop
            #10; nop    (0,       hi_z);            // Nop
            #10; nop    (0,       hi_z);            // Nop
            #10;
    end
$stop;
$finish;
end

endmodule

