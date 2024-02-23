/****************************************************************************************
 *
 *      Author:  Son P. Huynh
 *     Company:  Micron Technology, Inc.
 *       Email:  sphuynh@micron.com
 *       Phone:  (208) 368-3825
 *
 *   File Name:  TEST.V (testbench for RLDRAM II)
 *
 ***************************************************************************************/

`timescale 1ns / 1ps

module test;

    // Constant parameters
    parameter addr_bits =    21;
    parameter data_bits =     9;
    parameter bank_bits =     3;
    parameter HiZ       =  9'bz;

    // Timing parameters for -3.3 (300 Mhz)
    parameter tCK    =  3.300;
    parameter tCK2   =  1.650;  // tCK/2
    parameter tCK4   =  0.825;  // tCK/4
    parameter tCKDK  =  0.300;

    reg  [data_bits - 1 : 0] Dq;
    wire                     Qvld;
    wire                     Qk;
    wire                     Qk_n;
    reg                      Ck;
    reg                      Ck_n;
    reg                      Dk;
    reg                      Dk_n;
    reg                      Cs_n;
    reg                      We_n;
    reg                      Ref_n;
    reg  [addr_bits - 1 : 0] Addr;
    reg  [bank_bits - 1 : 0] Bank;
    reg                      Dm;

    reg  [addr_bits - 1 : 0] Addr_x, Addr_y;

    wire [data_bits - 1 : 0] DQ = Dq;

    mt49h32m9 rldram (DQ, Qvld, Qk, Qk_n, Ck, Ck_n, Dk, Dk_n, Cs_n, We_n, Ref_n, Addr, Bank, Dm);

    initial begin
        Ck   = 0;
        Ck_n = 1;
        Cs_n = 1;
        Addr  = 0;
        Addr_x = 0;
        Addr_y = 0;
        Bank  = 0;
        Dq    = HiZ;
        Dm    = 2'b0;
    end

    // Master Clock
    always begin
        #tCK2;
        Ck   = ~Ck;
        Ck_n = ~Ck;
    end

    // Data Clock
    always @ (Ck) begin
        #tCKDK
        Dk   = Ck;
        Dk_n = ~Ck;
    end

    // Address Mux
    task addr_mux;
        input [addr_bits - 1 : 0] Addr;
    begin
        Addr_x = 0;
        Addr_y = 0;

        Addr_x [ 0] = Addr [ 0];
        Addr_x [ 3] = Addr [ 3];
        Addr_x [ 4] = Addr [ 4];
        Addr_x [ 5] = Addr [ 5];
        Addr_x [ 8] = Addr [ 8];
        Addr_x [ 9] = Addr [ 9];
        Addr_x [10] = Addr [10];
        Addr_x [13] = Addr [13];
        Addr_x [14] = Addr [14];
        Addr_x [17] = Addr [17];
        Addr_x [18] = Addr [18];

        Addr_y [ 0] = Addr [20];
        Addr_y [ 3] = Addr [ 1];
        Addr_y [ 4] = Addr [ 2];
        //Addr_y [ 5] = Addr [21];
        Addr_y [ 8] = Addr [ 6];
        Addr_y [ 9] = Addr [ 7];
        Addr_y [10] = Addr [19];
        Addr_y [13] = Addr [11];
        Addr_y [14] = Addr [12];
        Addr_y [17] = Addr [16];
        Addr_y [18] = Addr [15];
    end
    endtask

    // Nop
    task nop;
        begin
            Cs_n = 1;
            We_n = 0;
            Ref_n = 0;
            #tCK;
        end
    endtask

    // Auto Refresh
    task aref;
        input [bank_bits - 1 : 0] BA;
        begin
            Cs_n  = 0;
            We_n  = 1;
            Ref_n = 0;
            Dq    = HiZ;
            Bank  = BA;
            #tCK;
            Cs_n  = 1;
            #tCK;
        end
    endtask

    // Mode Register Set
    task mrs;
        input [addr_bits - 1 : 0] addr;
        begin
            Cs_n  = 0;
            We_n  = 0;
            Ref_n = 0;
            Dq    = HiZ;
            Addr  = addr;
            #tCK;
            Cs_n  = 1;
            #tCK;
        end
    endtask

    // Mode Register Set (mux)
    task mrs_mux;
        input [addr_bits - 1 : 0] addr;
        begin
            addr_mux (addr);
            Cs_n  = 0;
            We_n  = 0;
            Ref_n = 0;
            Dq    = HiZ;
            Addr  = Addr_x;
            #tCK;
            Cs_n  = 1;
            Addr  = Addr_y;
            #tCK;
        end
    endtask

    // B2B Read with CFG1 RL4 WL5 BL4
    task B2B_RL4_BL4;
        input [bank_bits - 1 : 0] bank0_0;
        input [addr_bits - 1 : 0] addr0_0;
        input [bank_bits - 1 : 0] bank1_0;
        input [addr_bits - 1 : 0] addr1_0;
        begin
            Cs_n  = 0;
            We_n  = 1;
            Ref_n = 1;
            Bank  = bank0_0;
            Addr  = addr0_0;
            Dq    = HiZ;
            #tCK;
            Cs_n  = 1;
            #tCK;
            Cs_n  = 0;
            Bank  = bank1_0;
            Addr  = addr1_0;
            #tCK;
            Cs_n  = 1;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
        end
    endtask

    // B2B Read with CFG2 tRC6 RL6 WL7 BL4
    task B2B_RL6_BL4;
        input [bank_bits - 1 : 0] bank0_0;
        input [addr_bits - 1 : 0] addr0_0;
        input [bank_bits - 1 : 0] bank1_0;
        input [addr_bits - 1 : 0] addr1_0;
        begin
            Cs_n  = 0;
            We_n  = 1;
            Ref_n = 1;
            Bank  = bank0_0;
            Addr  = addr0_0;
            Dq    = HiZ;
            #tCK;
            Cs_n  = 1;
            #tCK;
            Cs_n  = 0;
            Bank  = bank1_0;
            Addr  = addr1_0;
            #tCK;
            Cs_n  = 1;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
        end
    endtask

    // B2B Read with CFG1 RL5 BL4 (MUX)
    task B2B_RL5_BL4_mux;
        input [bank_bits - 1 : 0] bank0_0;
        input [addr_bits - 1 : 0] addr0_0;
        input [bank_bits - 1 : 0] bank1_0;
        input [addr_bits - 1 : 0] addr1_0;
        begin
            addr_mux (addr0_0);
            Cs_n  = 0;
            We_n  = 1;
            Ref_n = 1;
            Bank  = bank0_0;
            Addr  = Addr_x;
            Dq    = HiZ;
            #tCK;
            Cs_n  = 1;
            Addr  = Addr_y;
            #tCK;
            addr_mux (addr1_0);
            Cs_n  = 0;
            Bank  = bank1_0;
            Addr  = Addr_x;
            #tCK;
            Cs_n  = 1;
            Addr  = Addr_y;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
        end
    endtask

    // Back-to-back Write with CFG1 RL4 WL5 BL4
    task B2B_WL5_BL4;
        input [bank_bits - 1 : 0] bank0_0;
        input [addr_bits - 1 : 0] addr0_0;
        input [data_bits - 1 : 0] data0_0;
        input [data_bits - 1 : 0] data0_1;
        input [data_bits - 1 : 0] data0_2;
        input [data_bits - 1 : 0] data0_3;

        input [bank_bits - 1 : 0] bank1_0;
        input [addr_bits - 1 : 0] addr1_0;
        input [data_bits - 1 : 0] data1_0;
        input [data_bits - 1 : 0] data1_1;
        input [data_bits - 1 : 0] data1_2;
        input [data_bits - 1 : 0] data1_3;
        begin
            Cs_n  = 0;
            We_n  = 0;
            Ref_n = 1;
            Dm    = 0;
            Bank  = bank0_0;
            Addr  = addr0_0;
            Dq    = HiZ;
            #tCK;
            Cs_n  = 1;
            #tCK;
            Cs_n  = 0;
            Bank  = bank1_0;
            Addr  = addr1_0;
            #tCK;
            Cs_n  = 1;
            #tCK;
            #tCK;
            #tCK4;
            Dq = data0_0;
            #tCK2;
            Dq = data0_1;
            #tCK2;
            Dq = data0_2;
            #tCK2;
            Dq = data0_3;
            #tCK2;
            Dq = data1_0;
            #tCK2;
            Dq = data1_1;
            #tCK2;
            Dq = data1_2;
            #tCK2;
            Dq = data1_3;
            #tCK2;
            Dq = HiZ;
            #tCK4;
            #tCK2;
        end
    endtask

    // Back-to-back Write with CFG2 tRC6 RL6 WL7 BL4
    task B2B_WL7_BL4;
        input [bank_bits - 1 : 0] bank0_0;
        input [addr_bits - 1 : 0] addr0_0;
        input [data_bits - 1 : 0] data0_0;
        input [data_bits - 1 : 0] data0_1;
        input [data_bits - 1 : 0] data0_2;
        input [data_bits - 1 : 0] data0_3;

        input [bank_bits - 1 : 0] bank1_0;
        input [addr_bits - 1 : 0] addr1_0;
        input [data_bits - 1 : 0] data1_0;
        input [data_bits - 1 : 0] data1_1;
        input [data_bits - 1 : 0] data1_2;
        input [data_bits - 1 : 0] data1_3;
        begin
            Cs_n  = 0;
            We_n  = 0;
            Ref_n = 1;
            Dm    = 0;
            Bank  = bank0_0;
            Addr  = addr0_0;
            Dq    = HiZ;
            #tCK;
            Cs_n  = 1;
            #tCK;
            Cs_n  = 0;
            Bank  = bank1_0;
            Addr  = addr1_0;
            #tCK;
            Cs_n  = 1;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
            #tCK4;
            Dq = data0_0;
            #tCK2;
            Dq = data0_1;
            #tCK2;
            Dq = data0_2;
            #tCK2;
            Dq = data0_3;
            #tCK2;
            Dq = data1_0;
            #tCK2;
            Dq = data1_1;
            #tCK2;
            Dq = data1_2;
            #tCK2;
            Dq = data1_3;
            #tCK2;
            Dq = HiZ;
            #tCK4;
            #tCK2;
        end
    endtask

    // Back-to-back Write with CFG1 WL6 BL4 (MUX)
    task B2B_WL6_BL4_mux;
        input [bank_bits - 1 : 0] bank0_0;
        input [addr_bits - 1 : 0] addr0_0;
        input [data_bits - 1 : 0] data0_0;
        input [data_bits - 1 : 0] data0_1;
        input [data_bits - 1 : 0] data0_2;
        input [data_bits - 1 : 0] data0_3;

        input [bank_bits - 1 : 0] bank1_0;
        input [addr_bits - 1 : 0] addr1_0;
        input [data_bits - 1 : 0] data1_0;
        input [data_bits - 1 : 0] data1_1;
        input [data_bits - 1 : 0] data1_2;
        input [data_bits - 1 : 0] data1_3;
        begin
            addr_mux (addr0_0);
            Cs_n  = 0;
            We_n  = 0;
            Ref_n = 1;
            Dm    = 0;
            Bank  = bank0_0;
            Addr  = Addr_x;
            Dq    = HiZ;
            #tCK2;              // T0
            #tCK2;
            Cs_n  = 1;
            Addr  = Addr_y;
            #tCK2;              // T1
            #tCK2;
            addr_mux (addr1_0);
            Cs_n  = 0;
            Bank  = bank1_0;
            Addr  = Addr_x;
            #tCK2;              // T2
            #tCK2;
            Cs_n  = 1;
            Addr  = Addr_y;
            #tCK2;              // T3
            #tCK2;
            #tCK2;              // T4
            #tCK2;
            #tCK2;              // T5
            #tCK2;
            #tCK4;
            Dq = data0_0;
            #tCK4;              // T6
            #tCK4;
            Dq = data0_1;
            #tCK4;
            #tCK4;
            Dq = data0_2;
            #tCK2;
            Dq = data0_3;
            #tCK2;
            Dq = data1_0;
            #tCK2;
            Dq = data1_1;
            #tCK2;
            Dq = data1_2;
            #tCK2;
            Dq = data1_3;
            #tCK2;
            Dq = HiZ;
            #tCK4;
            #tCK2;
            #tCK;
            #tCK;
        end
    endtask

    // WRWR CFG1 RL4 WL5 BL4
    task WRWR_RL4_WL5_BL4;
        input [bank_bits - 1 : 0] wbank0;
        input [addr_bits - 1 : 0] waddr0;
        input [data_bits - 1 : 0] data00;
        input [data_bits - 1 : 0] data01;
        input [data_bits - 1 : 0] data02;
        input [data_bits - 1 : 0] data03;

        input [bank_bits - 1 : 0] rbank0;
        input [addr_bits - 1 : 0] raddr0;

        input [bank_bits - 1 : 0] wbank1;
        input [addr_bits - 1 : 0] waddr1;
        input [data_bits - 1 : 0] data10;
        input [data_bits - 1 : 0] data11;
        input [data_bits - 1 : 0] data12;
        input [data_bits - 1 : 0] data13;

        input [bank_bits - 1 : 0] rbank1;
        input [addr_bits - 1 : 0] raddr1;

        begin
            Cs_n  = 0;
            We_n  = 0;
            Ref_n = 1;
            Dm    = 2'b00;
            Bank  = wbank0;
            Addr  = waddr0;
            Dq    = HiZ;
            #tCK;
            Cs_n  = 1;
            #tCK;
            #tCK;
            Cs_n  = 0;
            We_n  = 1;
            Bank  = rbank0;
            Addr  = raddr0;
            #tCK;
            Cs_n  = 1;
            #tCK4;
            #tCK2;
            #tCK4;
            Cs_n = 0;
            We_n = 0;
            Bank  = wbank1;
            Addr  = waddr1;
            #tCK4;
            Dq = data00;
            #tCK4;
            #tCK4;
            Dq = data01;
            #tCK4;
            Cs_n = 1;
            #tCK4;
            Dq = data02;
            #tCK4;
            #tCK4;
            Dq = data03;
            #tCK4;
            #tCK4;
            Dq = HiZ;
            #tCK4;
            #tCK4;
            #tCK4;
            Cs_n  = 0;
            We_n  = 1;
            Bank  = rbank1;
            Addr  = raddr1;
            #tCK;
            Cs_n  = 1;
            #tCK;
            #tCK4;
            Dq = data10;
            #tCK2;
            Dq = data11;
            #tCK2;
            Dq = data12;
            #tCK2;
            Dq = data13;
            #tCK4;
            #tCK4;
            Dq = HiZ;
            #tCK4;
            #tCK2;
            #tCK;
            #tCK;
            #tCK;
            #tCK;
        end
    endtask

    initial begin
        begin
            // Non-multiplex address test case: CFG1 tRC4 RL4 WL5 BL4
            repeat (100) nop;                       // This should be 200 uS
            mrs ('b0000000_0_0_1_0_0_0_01_001);     // Dummy
            mrs ('b0000000_0_0_1_0_0_0_01_001);     // Dummy
            mrs ('b0000000_0_0_1_0_0_0_01_001);     // CFG1
            repeat (8) nop;                         // This should be tMRSC
            aref (0);                               // Auto Refresh Bank 0
            repeat (8) nop;                         // This should be 2048
            aref (1);                               // Auto Refresh Bank 1
            repeat (8) nop;                         // This should be 2048
            aref (2);                               // Auto Refresh Bank 2
            repeat (8) nop;                         // This should be 2048
            aref (3);                               // Auto Refresh Bank 3
            repeat (8) nop;                         // This should be 2048
            aref (4);                               // Auto Refresh Bank 4
            repeat (8) nop;                         // This should be 2048
            aref (5);                               // Auto Refresh Bank 5
            repeat (8) nop;                         // This should be 2048
            aref (6);                               // Auto Refresh Bank 6
            repeat (8) nop;                         // This should be 2048
            aref (7);                               // Auto Refresh Bank 7
            repeat (8) nop;                         // This should be tRC
            B2B_WL5_BL4 (0, 0, 10, 11, 12, 13,
                         1, 0, 20, 21, 22, 23);
            B2B_RL4_BL4 (0, 0,
                         1, 0);
            WRWR_RL4_WL5_BL4 (2, 0, 30, 31, 32, 33,
                              0, 0,
                              3, 0, 40, 41, 42, 43,
                              1, 0);
            B2B_RL4_BL4 (2, 0,
                         3, 0);
        end
        $stop;
        $finish;
    end

endmodule
