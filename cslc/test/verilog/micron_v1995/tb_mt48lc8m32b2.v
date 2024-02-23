////////////////////////////////////////////////////////////////////////
//[Disclaimer]    
//This software code and all associated documentation, comments
//or other information (collectively "Software") is provided 
//"AS IS" without warranty of any kind. MICRON TECHNOLOGY, INC. 
//("MTI") EXPRESSLY DISCLAIMS ALL WARRANTIES EXPRESS OR IMPLIED,
//INCLUDING BUT NOT LIMITED TO, NONINFRINGEMENT OF THIRD PARTY
//RIGHTS, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS
//FOR ANY PARTICULAR PURPOSE. MTI DOES NOT WARRANT THAT THE
//SOFTWARE WILL MEET YOUR REQUIREMENTS, OR THAT THE OPERATION OF
//THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE. FURTHERMORE,
//MTI DOES NOT MAKE ANY REPRESENTATIONS REGARDING THE USE OR THE
//RESULTS OF THE USE OF THE SOFTWARE IN TERMS OF ITS CORRECTNESS,
//ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT
//OF USE OR PERFORMANCE OF THE SOFTWARE REMAINS WITH YOU. IN NO
//EVENT SHALL MTI, ITS AFFILIATED COMPANIES OR THEIR SUPPLIERS BE
//LIABLE FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL, OR
//SPECIAL DAMAGES (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS
//OF PROFITS, BUSINESS INTERRUPTION, OR LOSS OF INFORMATION)
//ARISING OUT OF YOUR USE OF OR INABILITY TO USE THE SOFTWARE,
//EVEN IF MTI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
//Because some jurisdictions prohibit the exclusion or limitation
//of liability for consequential or incidental damages, the above
//limitation may not apply to you.
//
//Copyright 2005 Micron Technology, Inc. All rights reserved.
////////////////////////////////////////////////////////////////////////

// Testbench for Micron SDR SDRAM Verilog models

`timescale 1ns / 1ps

module tb;

reg         [31 : 0] dq;                            // SDRAM I/O
reg         [11 : 0] addr;                          // SDRAM Address
reg          [1 : 0] ba;                            // Bank Address
reg                  clk;                           // Clock
reg                  cke;                           // Synchronous Clock Enable
reg                  cs_n;                          // CS#
reg                  ras_n;                         // RAS#
reg                  cas_n;                         // CAS#
reg                  we_n;                          // WE#
reg          [3 : 0] dqm;                          // I/O Mask

wire        [31 : 0] DQ = dq;

parameter            hi_z = 32'hzzzzzzzz;                   // Hi-Z

mt48lc8m32b2 sdram0 (DQ, addr, ba, clk, cke, cs_n, ras_n, cas_n, we_n, dqm);

initial begin
    clk = 1'b0;
    cke = 1'b0;
    cs_n = 1'b1;
    dq  = hi_z;
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
    input [31 : 0] dq_in;
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
    input [12 : 0] op_code;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 0;
        we_n  = 0;
        dqm   = 0;
        ba    = 0;
        addr  = op_code [12 :  0];
        dq    = hi_z;
    end
endtask

task load_ext_mode_reg;
    input [12 : 0] op_code;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 0;
        we_n  = 0;
        dqm   = 0;
        ba    = 2'b10;
        addr  = op_code [12 :  0];
        dq    = hi_z;
    end
endtask

task nop;
    input   [3:0] dqm_in;
    input [31 : 0] dq_in;
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
    input  [3 : 0] dqm_in;
    input  [31 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 0;
        addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_bank_1;
    input  [3 : 0] dqm_in;
    input  [31 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 1;
        addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_bank_2;
    input  [3 : 0] dqm_in;
    input  [31 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 2;
        addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_bank_3;
    input  [3 : 0] dqm_in;
    input  [31 : 0] dq_in;
    begin
        cke   = 1;
        cs_n  = 0;
        ras_n = 0;
        cas_n = 1;
        we_n  = 0;
        dqm   = dqm_in;
        ba    = 3;
        addr  = 0;
        dq    = dq_in;
    end
endtask

task precharge_all_bank;
    input    [3:0]  dqm_in;
    input  [31 : 0] dq_in;
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
    input  [31 : 0] dq_in;
    input    [3:0] dqm_in;
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
    input  [31 : 0] dq_in;
    input    [3:0] dqm_in;
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
        #10; nop    (0, hi_z);                  // DQM, Data
        #60; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
        #10; nop    (0, hi_z);                  // DQM, Data
        #20; auto_refresh;                      // Auto Refresh
        #10; nop    (0, hi_z);                  // DQM, Data
        #80; auto_refresh;                      // Auto Refresh
        #10; nop    (0, hi_z);                  // DQM, Data
        #80; load_mode_reg (51);                // Load Mode: Lat = 3, BL = 8, Seq
        #10; nop    (0, hi_z);                  // DQM, Data
        #80; load_ext_mode_reg (0);             // Load Mode: Lat = 3, BL = 8, Seq
        #10; nop    (0, hi_z);                  // DQM, Data

        // Test alternate bank write with auto precharge
        #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0, Data
        #10; nop    (0, hi_z);                  // DQM, Data
        #10; write  (0, 1024, 32'hFFFFFFFF, 0);            // Write : Bank = 0, Col = 0, Data, Dqm = 0, Auto precharge
        #10; nop    (4'b0000, 32'hFFFFFFFF);                     // DQM, Data
        #10; nop    (4'b0000, 32'hFFFFFFFF);                     // DQM, Data
        #10; nop    (4'b0000, 32'hFFFFFFFF);                     // DQM, Data
        #10; active (1, 0, 32'hFFFFFFFF);                  // Active: Bank = 1, Row = 0, Data
        #10; nop    (4'b0000, 32'hFFFFFFFF);                     // DQM, Data
        #10; nop    (4'b0000, 32'hFFFFFFFF);                     // DQM, Data
        #10; nop    (4'b0000, 32'hFFFFFFFF);                     // DQM, Data

        #10; write  (0, 1024, 32'h01010101, 0);            // Write : Bank = 0, Col = 0, Data, Dqm = 0, Auto precharge
        #10; nop    (4'b1111, 32'h02020202);                     // DQM, Data
        #10; nop    (4'b0100, 32'h04040404);                     // DQM, Data
        #10; nop    (4'b0010, 32'h08080808);                     // DQM, Data
        #10; active (1, 0, 32'h10101010);                  // Active: Bank = 1, Row = 0, Data
        #10; nop    (4'b0100, 32'h20202020);                     // DQM, Data
        #10; nop    (4'b0010, 32'h40404040);                     // DQM, Data
        #10; nop    (4'b0001, 32'h80808080);                     // DQM, Data

        #10; write  (1, 1024, 32'h00000000, 0);            // Write : Bank = 1, Col = 0, Data, Dqm = 0, Auto precharge
        #10; nop    (4'b0000, 32'h55555555);                     // DQM, Data
        #10; nop    (4'b0000, 32'hAAAAAAAA);                    // DQM, Data
        #10; nop    (4'b0000, 32'hFFFFFFFF);                    // DQM, Data
        #10; active (2, 0, 32'h00000000);                 // Active: Bank = 2, Row = 0, Data
        #10; nop    (4'b0000, 32'h55555555);                    // DQM, Data
        #10; nop    (4'b0000, 32'hAAAAAAAA);                    // DQM, Data
        #10; nop    (4'b0000, 32'hFFFFFFFF);                    // DQM, Data

        #10; write  (2, 1024, 32'h00000000, 0);          // Write : Bank = 2, Col = 0, Data, Dqm = 0, Auto precharge
        #10; nop    (4'b0000, 32'h01010101);                   // DQM, Data
        #10; nop    (4'b0000, 32'h02020202);                   // DQM, Data
        #10; nop    (4'b0000, 32'h03030303);                   // DQM, Data
        #10; active (3, 0, 32'h04040404);               // Active: Bank = 3, Row = 0, Data
        #10; nop    (4'b0000, 32'h05050505);                  // DQM, Data
        #10; nop    (4'b0000, 32'h06060606);                  // DQM, Data
        #10; nop    (4'b0000, 32'h07070707);                  // DQM, Data

        #10; write  (3, 1024, 32'h00000000, 0);          // Write : Bank = 3, Col = 0, Data, Dqm = 0, Auto precharge
        #10; nop    (0, 32'h10101010);                   // DQM, Data
        #10; nop    (0, 32'h20202020);                   // DQM, Data
        #10; nop    (0, 32'h30303030);                   // DQM, Data
        #10; active (0, 0, 32'h40404040);               // Active: Bank = 0, Row = 0, Data
        #10; nop    (0, 32'h50505050);                  // DQM, Data
        #10; nop    (0, 32'h60606060);                  // DQM, Data
        #10; nop    (0, 32'h70707070);                  // DQM, Data

        #10; read   (0, 1024, hi_z, 0);            // Read  : Bank = 0, Col = 0, Auto precharge
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; active (1, 0, hi_z);               // Active: Bank = 1, Row = 0
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop

        #10; read   (1, 1024, hi_z, 0);            // Read  : Bank = 1, Col = 0, Auto precharge
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; active (2, 0, hi_z);               // Active: Bank = 2, Row = 0
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop

        #10; read   (2, 1024, hi_z, 0);            // Read  : Bank = 2, Col = 0, Auto precharge
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; active (3, 0, hi_z);               // Active: Bank = 3, Row = 0
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop

        #10; read   (3, 1024, hi_z, 0);            // Read  : Bank = 3, Col = 0, Auto precharge
        #10; nop    (4'b1111, hi_z);                  // Nop
        #10; nop    (4'b1000, hi_z);                  // Nop
        #10; nop    (4'b0100, hi_z);                  // Nop
        #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
        #10; nop    (4'b0010, hi_z);                  // Nop
        #10; nop    (4'b0001, hi_z);                  // Nop
        #10; nop    (4'b1001, hi_z);                  // Nop

        #10; nop    (0, hi_z);                  // Nop
        #50;
    end
$stop;
$finish;
end

endmodule


