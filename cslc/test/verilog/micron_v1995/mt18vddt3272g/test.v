/****************************************************************************************
 *
 *      Author:  Son P. Huynh
 *     Company:  Micron Technology, Inc.
 *       Email:  sphuynh@micron.com
 *       Phone:  (208) 368-3825
 *
 *   File Name:  TEST.V (testbench for MT18LDDT1672.V)
 *
 ***************************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 1ps

module test;

    parameter addr_bits =    12;
    parameter data_bits =    72;
    parameter HiZ       = 72'bz;

    reg  [data_bits - 1 : 0] Dq;
    reg                      Dqs;
    reg  [addr_bits - 1 : 0] Addr;
    reg              [1 : 0] Ba;
    reg                      Clk;
    reg                      Clk_n;
    reg                      Cke;
    reg                      Cs_n;
    reg                      Ras_n;
    reg                      Cas_n;
    reg                      We_n;
    reg                      Dm;

    wire [data_bits - 1 : 0] DQ  = Dq;
    wire                     DQS = Dqs;
    wire                     Reset_n = 1'b1;

    mt18vddt3272 dimm (DQ, {18{DQS}}, Addr, Ba, Clk, Clk_n, Cke, Cs_n, Ras_n, Cas_n, We_n, Reset_n);

    always begin
        #5;
        Clk_n = ~Clk_n;
        Clk   = ~Clk_n;
    end

    initial begin
        Clk   =  1'b0;
        Clk_n =  1'b1;
        Cke   =  1'b0;
        Cs_n  =  1'b0;
        Ras_n =  1'b1;
        Cas_n =  1'b1;
        We_n  =  1'b1;
        Dm    =  1'b0;
        Addr  = 12'b0;
        Ba    =  2'b0;
        Dq    = 72'bz;
        Dqs   =  1'bz;
        // Verilog-XL Wave-form display
        //$shm_open ("waves.shm");
        //$shm_probe(test, "AC");
    end

task active;
    input             [1 : 0] ba;
    input [addr_bits - 1 : 0] addr;
    input [data_bits - 1 : 0] dq;
    input                     dqs;
    input                     dm;
    begin
        Cke   = 1'b1;
        Cs_n  = 1'b0;
        Ras_n = 1'b0;
        Cas_n = 1'b1;
        We_n  = 1'b1;
        Dm    =   dm;
        Ba    =   ba;
        Addr  = addr;
        Dq    =   dq;
        Dqs   =  dqs;
    end
endtask

task auto_refresh;
    begin
        Cke   =  1'b1;
        Cs_n  =  1'b0;
        Ras_n =  1'b0;
        Cas_n =  1'b0;
        We_n  =  1'b1;
        Dm    =  1'b0;
        //Ba    =  2'b0;
        //Addr  = 12'b0;
        Dq    =   HiZ;
        Dqs   =  1'bz;
    end
endtask

task burst_term;
    input                     dm;
    begin
        Cke   =  1'b1;
        Cs_n  =  1'b0;
        Ras_n =  1'b1;
        Cas_n =  1'b1;
        We_n  =  1'b0;
        Dm    =    dm;
        //Ba    =  2'b0;
        //Addr  = 12'b0;
        Dq    =   HiZ;
        Dqs   =  1'bz;
    end
endtask

task precharge;
    input             [1 : 0] ba;
    input [addr_bits - 1 : 0] addr;
    begin
        Cke   = 1'b1;
        Cs_n  = 1'b0;
        Ras_n = 1'b0;
        Cas_n = 1'b1;
        We_n  = 1'b0;
        Dm    = 1'b0;
        Ba    =   ba;
        Addr  = addr;
        Dq    =  HiZ;
        Dqs   = 1'bz;
    end
endtask


task load_mode_reg;
    input             [1 : 0] ba;
    input [addr_bits - 1 : 0] addr;
    begin
        Cke   = 1'b1;
        Cs_n  = 1'b0;
        Ras_n = 1'b0;
        Cas_n = 1'b0;
        We_n  = 1'b0;
        Dm    = 1'b0;
        Ba    =   ba;
        Addr  = addr;
        Dq    =  HiZ;
        Dqs   = 1'bz;
    end
endtask

task nop;
    input [data_bits - 1 : 0] dq;
    input                     dqs;
    input                     dm;
    begin
        Cke   =  1'b1;
        Cs_n  =  1'b0;
        Ras_n =  1'b1;
        Cas_n =  1'b1;
        We_n  =  1'b1;
        Dm    =    dm;
        //Ba    =  2'b0;
        //Addr  = 12'b0;
        Dq    =    dq;
        Dqs   =   dqs;
    end
endtask

task read;
    input             [1 : 0] ba;
    input [addr_bits - 1 : 0] addr;
    begin
        Cke   = 1'b1;
        Cs_n  = 1'b0;
        Ras_n = 1'b1;
        Cas_n = 1'b0;
        We_n  = 1'b1;
        Dm    = 1'b0;
        Ba    =   ba;
        Addr  = addr;
        Dq    =  HiZ;
        Dqs   = 1'bz;
    end
endtask

// Write Burst Length = 2
task write_2;
    input             [1 : 0] ba;       // Bank
    input [addr_bits - 1 : 0] addr;     // Column
    input [data_bits - 1 : 0] dq0;      // First Data
    input [data_bits - 1 : 0] dq1;      // Last Data
    begin
              Cke   = 1'b1;
              Cs_n  = 1'b0;
              Ras_n = 1'b1;
              Cas_n = 1'b0;
              We_n  = 1'b0;
              Dm    = 1'b0;
              Ba    =   ba;
              Addr  = addr;
              Dq    =  HiZ;
              Dqs   = 1'bz;
        #5;
        #5;   Cas_n = 1'b1;
              We_n  = 1'b1;
              //Addr  = 0;
        #5;   Dqs   = 1'b0;
        #5;
        #2.5; Dq    = dq0;
        #2.5; Dqs   = 1'b1;
        #2.5; Dq    = dq1;
        #2.5; Dqs   = 1'b0;
        #2.5; Dq    = HiZ;
        #2.5; Dqs   = 1'bz;
        #5;
    end
endtask

// Write Burst Length = 4
task write_4;
    input             [1 : 0] ba;       // Bank
    input [addr_bits - 1 : 0] addr;     // Column
    input [data_bits - 1 : 0] dq0;      // First Data
    input [data_bits - 1 : 0] dq1;
    input [data_bits - 1 : 0] dq2;
    input [data_bits - 1 : 0] dq3;      // Last Data
    begin
              Cke   = 1'b1;
              Cs_n  = 1'b0;
              Ras_n = 1'b1;
              Cas_n = 1'b0;
              We_n  = 1'b0;
              Dm    = 1'b0;
              Ba    =   ba;
              Addr  = addr;
              Dq    =  HiZ;
              Dqs   = 1'bz;
        #5;
        #5;   Cas_n = 1'b1;
              We_n  = 1'b1;
              //Addr  = 0;
        #5;   Dqs   = 1'b0;
        #5;
        #2.5; Dq    = dq0;
        #2.5; Dqs   = 1'b1;
        #2.5; Dq    = dq1;
        #2.5; Dqs   = 1'b0;
        #2.5; Dq    = dq2;
        #2.5; Dqs   = 1'b1;
        #2.5; Dq    = dq3;
        #2.5; Dqs   = 1'b0;
        #2.5; Dq    = HiZ;
        #2.5; Dqs   = 1'bz;
        #5;
    end
endtask

// Write Burst Length = 8
task write_8;
    input             [1 : 0] ba;       // Bank
    input [addr_bits - 1 : 0] addr;     // Column
    input [data_bits - 1 : 0] dq0;      // First Data
    input [data_bits - 1 : 0] dq1;
    input [data_bits - 1 : 0] dq2;
    input [data_bits - 1 : 0] dq3;
    input [data_bits - 1 : 0] dq4;
    input [data_bits - 1 : 0] dq5;
    input [data_bits - 1 : 0] dq6;
    input [data_bits - 1 : 0] dq7;      // Last Data
    begin
              Cke   = 1'b1;
              Cs_n  = 1'b0;
              Ras_n = 1'b1;
              Cas_n = 1'b0;
              We_n  = 1'b0;
              Dm    = 1'b0;
              Ba    =   ba;
              Addr  = addr;
              Dq    =  HiZ;
              Dqs   = 1'bz;
        #5;
        #5;   Cas_n = 1'b1;
              We_n  = 1'b1;
              //Addr  = 0;
        #5;   Dqs   = 1'b0;
        #5;
        #2.5; Dq    = dq0;
        #2.5; Dqs   = 1'b1;
        #2.5; Dq    = dq1;
        #2.5; Dqs   = 1'b0;
        #2.5; Dq    = dq2;
        #2.5; Dqs   = 1'b1;
        #2.5; Dq    = dq3;
        #2.5; Dqs   = 1'b0;

        #2.5; Dq    = dq4;
        #2.5; Dqs   = 1'b1;
        #2.5; Dq    = dq5;
        #2.5; Dqs   = 1'b0;
        #2.5; Dq    = dq6;
        #2.5; Dqs   = 1'b1;
        #2.5; Dq    = dq7;
        #2.5; Dqs   = 1'b0;

        #2.5; Dq    = HiZ;
        #2.5; Dqs   = 1'bz;
        #5;
    end
endtask

initial begin
    begin
        #10; nop          (HiZ, 1'bz, 1'b0);            // Nop
        #50; precharge    (2'b00, 1024);                // Precharge all banks
        #10; load_mode_reg(2'b01, 12'b00000_000_0_000); // Extended Mode Register (Enable DLL)
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; load_mode_reg(2'b00, 12'b00000_010_0_010); // Load Mode Register (CAS=2 BL=4)
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; precharge (2'b00, 1024);                   // Precharge all banks
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #20; auto_refresh;                              // AutoRefresh
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #70; auto_refresh;                              // AutoRefresh
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #70; active(2'b00, 0, HiZ, 1'bz, 1'b0);         // Active Bank 0, Row 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; active(2'b01, 0, HiZ, 1'bz, 1'b0);         // Active Bank 1, Row 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; active(2'b10, 0, HiZ, 1'bz, 1'b0);         // Active Bank 2, Row 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; active(2'b11, 0, HiZ, 1'bz, 1'b0);         // Active Bank 3, Row 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop

        #10; write_4(2'b00, 0, 10, 11, 12, 13);
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; write_4(2'b01, 0, 20, 21, 22, 23);
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; write_4(2'b10, 0, 30, 31, 32, 33);
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; write_4(2'b11, 0, 40, 41, 42, 43);
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop

        #10; read (2'b00, 0);                           // Read   Bank 0, Col 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; read (2'b01, 0);                           // Read   Bank 1, Col 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; read (2'b10, 0);                           // Read   Bank 2, Col 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; read (2'b11, 0);                           // Read   Bank 3, Col 0
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10; precharge (2'b00, 1024);                   // Precharge all banks
        #10; nop (HiZ, 1'bz, 1'b0);                     // Nop
        #10;
    end
    $stop;
    $finish;
end

endmodule
