/****************************************************************************************
 *
 *      Author:  Son P. Huynh
 *     Company:  Micron Technology, Inc.
 *       Email:  sphuynh@micron.com
 *       Phone:  (208) 368-3825
 *
 *   File Name:  TEST.V (testbench for RLDRAM)
 *
 ***************************************************************************************/

`timescale 1ns / 1ps

module test;

    parameter addr_bits =    19;
    parameter data_bits =    32;
    parameter bank_bits =     3;
    parameter HiZ       = 32'bz;

    parameter full_clk  =     4;
    parameter half_clk  =     2;
    parameter quar_clk  =     1;

    reg  [data_bits - 1 : 0] Dq;
    wire                     Dvld;
    wire             [3 : 0] Dqs;
    wire             [3 : 0] Dqs_n;
    reg                      Clk;
    reg                      Clk_n;
    reg                      Cs_n;
    reg                      As_n;
    reg                      We_n;
    reg                      Ref_n;
    reg  [addr_bits - 1 : 0] Addr;
    reg  [bank_bits - 1 : 0] Bank;
    reg              [1 : 0] Dm;

    wire [data_bits - 1 : 0] DQ = Dq;

    mt49h8m32 rldram (DQ, Dvld, Dqs, Dqs_n, Clk, Clk_n, Cs_n, As_n, We_n, Ref_n, Addr, Bank, Dm);

    initial begin
        Clk   = 0;
        Clk_n = 1;
        Addr  = 0;
        Bank  = 0;
        Dq    = HiZ;
        Dm    = 2'b0;
    end

    always begin
        #half_clk;
        Clk   = ~Clk;
        Clk_n = ~Clk;
    end

    // NOP
    task nop;
        begin
            Cs_n  = 0;
            As_n  = 1;
            We_n  = 1;
            Ref_n = 1;
            #full_clk;
        end
    endtask

    // Mode Register Set
    task mrs;
        input [addr_bits - 1 : 0] addr;
        begin
            Cs_n  = 0;
            As_n  = 0;
            We_n  = 0;
            Ref_n = 0;
            Dq    = HiZ;
            Addr  = addr;
            #full_clk;
        end
    endtask
    
    // WL2 BL4
    task wl2bl4;
        input [bank_bits - 1 : 0] bank;
        input [addr_bits - 1 : 0] addr;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;
        input [data_bits - 1 : 0] data2;
        input [data_bits - 1 : 0] data3;
        begin
            Cs_n  = 0;
            As_n  = 0;
            We_n  = 0;
            Ref_n = 1;
            Dm    = 2'b00;
            Bank  = bank;
            Addr  = addr;
            Dq    = HiZ;
            #full_clk;
            As_n  = 1;
            We_n  = 1;
            #full_clk;
            #quar_clk;
            Dq = data0;
            #half_clk;
            Dq = data1;
            #half_clk;
            Dq = data2;
            #half_clk;
            Dq = data3;
            #half_clk;
            Dq = HiZ;
            #quar_clk;
            #half_clk;
        end
    endtask

    // WL3 BL2
    task wl3bl2;
        input [bank_bits - 1 : 0] bank;
        input [addr_bits - 1 : 0] addr;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;
        begin
            Cs_n  = 0;
            As_n  = 0;
            We_n  = 0;
            Ref_n = 1;
            Dm    = 2'b00;
            Bank  = bank;
            Addr  = addr;
            Dq    = HiZ;
            #full_clk;
            As_n  = 1;
            We_n  = 1;
            #full_clk;
            #full_clk;
            #quar_clk;
            Dq = data0;
            #half_clk;
            Dq = data1;
            #half_clk;
            Dq = HiZ;
            #quar_clk;
            #half_clk;
        end
    endtask

    // Read Command
    task read;
        input [bank_bits - 1 : 0] bank;
        input [addr_bits - 1 : 0] addr;
        begin
            Cs_n  = 0;
            As_n  = 0;
            We_n  = 1;
            Ref_n = 1;
            Bank  = bank;
            Addr  = addr;
            Dq    = HiZ;
            #full_clk;
            As_n  = 1;
            We_n  = 1;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
        end
    endtask
    
    // Back-to-back Read Command
    task read2;
        input [bank_bits - 1 : 0] bank1;
        input [addr_bits - 1 : 0] addr1;
        input [bank_bits - 1 : 0] bank2;
        input [addr_bits - 1 : 0] addr2;
        begin
            Cs_n  = 0;
            As_n  = 0;
            We_n  = 1;
            Ref_n = 1;
            Bank  = bank1;
            Addr  = addr1;
            Dq    = HiZ;
            #full_clk;
            As_n  = 1;
            We_n  = 1;
            #full_clk;
            As_n  = 0;
            Bank  = bank2;
            Addr  = addr2;
            #full_clk;
            As_n  = 1;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
            #full_clk;
        end
    endtask

    // Test Vectors
    initial begin
        begin
            nop;
            //mrs (4);        // Configuration #4, BL2, RL6, WL3, tRC8
            mrs (12);        // Configuration #4, BL4, RL6, WL2, tRC8
            nop;
            nop;
            nop;
            //wl3bl2(0,0,0,1);
            wl2bl4(0,0,0,1,2,3);
            wl2bl4(1,0,10,11,12,13);
            read (0, 0);
            read (1, 0);
            read2 (0,0,1,0);
            nop;
        end
        $stop;
        $finish;
    end

endmodule
