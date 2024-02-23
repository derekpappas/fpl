`timescale 1ns / 1ps

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

wire         [3 : 0] DQ = dq;

parameter            hi_z = 4'bz;                   // Hi-Z

mt48lc32m4a2 sdram0 (DQ, addr, ba, clk, cke, cs_n, ras_n, cas_n, we_n, dqm);

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
    input [11 : 0] op_code;
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
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
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
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
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
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
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
    input  [1 : 0] dqm_in;
    input [15 : 0] dq_in;
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

initial begin
    begin
        #10; nop    (0, hi_z);                  // Nop
        #60; precharge_all_bank(0, hi_z);       // Precharge ALL Bank
        #10; nop    (0, hi_z);                  // Nop
        #20; auto_refresh;                      // Auto Refresh
        #10; nop    (0, hi_z);                  // Nop
        #80; auto_refresh;                      // Auto Refresh
        #10; nop    (0, hi_z);                  // Nop
        #80; load_mode_reg (51);                // Load Mode: Lat = 3, BL = 8, Seq
        #10; nop    (0, hi_z);                  // Nop

        // Test alternate bank write with auto precharge
        #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
        #10; nop    (0, hi_z);                  // Nop
        #10; write  (0, 1024, 0, 0);          // Write : Bank = 0, Col = 0, Dqm = 0, Auto precharge
        #10; nop    (0, 1);                   // Nop
        #10; nop    (0, 2);                   // Nop
        #10; nop    (0, 3);                   // Nop
        #10; active (1, 0, 4);               // Active: Bank = 1, Row = 0
        #10; nop    (0, 5);                  // Nop
        #10; nop    (0, 6);                  // Nop
        #10; nop    (0, 7);                  // Nop

        #10; write  (1, 1024, 8, 0);          // Write : Bank = 1, Col = 0, Dqm = 0, Auto precharge
        #10; nop    (0, 9);                   // Nop
        #10; nop    (0, 10);                   // Nop
        #10; nop    (0, 11);                   // Nop
        #10; active (2, 0, 12);               // Active: Bank = 2, Row = 0
        #10; nop    (0, 13);                  // Nop
        #10; nop    (0, 14);                  // Nop
        #10; nop    (0, 15);                  // Nop

        #10; write  (2, 1024, 16, 0);          // Write : Bank = 2, Col = 0, Dqm = 0, Auto precharge
        #10; nop    (0, 17);                   // Nop
        #10; nop    (0, 18);                   // Nop
        #10; nop    (0, 19);                   // Nop
        #10; active (3, 0, 20);               // Active: Bank = 3, Row = 0
        #10; nop    (0, 21);                  // Nop
        #10; nop    (0, 22);                  // Nop
        #10; nop    (0, 23);                  // Nop

        #10; write  (3, 1024, 24, 0);          // Write : Bank = 3, Col = 0, Dqm = 0, Auto precharge
        #10; nop    (0, 25);                   // Nop
        #10; nop    (0, 26);                   // Nop
        #10; nop    (0, 27);                   // Nop
        #10; active (0, 0, 28);               // Active: Bank = 0, Row = 0
        #10; nop    (0, 29);                  // Nop
        #10; nop    (0, 30);                  // Nop
        #10; nop    (0, 31);                  // Nop

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
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; active (0, 0, hi_z);               // Active: Bank = 0, Row = 0
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop
        #10; nop    (0, hi_z);                  // Nop

        #10; nop    (0, hi_z);                  // Nop
        #50;
    end
$stop;
$finish;
end

endmodule
