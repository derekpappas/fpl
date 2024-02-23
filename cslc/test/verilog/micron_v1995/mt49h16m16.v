/**************************************************************************
*
*    File Name:  MT49H16M16.V  
*     Revision:  1.3
*         Date:  August 9th, 2002
*        Model:  BUS Functional
*    Simulator:  Model Technology
*
* Dependencies:  None
*
*        Email:  modelsupport@micron.com
*      Company:  Micron Technology, Inc.
*  Part Number:  MT49H16M16 (2Meg x 16 x 8 Banks)
*
*  Description:  Micron 256Mb RLDRAM (Reduced Latency DRAM)
*
*   Limitation:  - Doesn't check for 8192-cycle refresh
*
*         Note:  - Set simulator resolution to "ps" accuracy
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright © 1998 Micron Semiconductor Products, Inc.
*                All rights researved
*
* Rev  Author          Date        Changes
* ---  --------------------------  ---------------------------------------
* 1.3  Son Huynh       08/09/2002  - Update DVLD signal
*      Micron Technology Inc.
*
* 1.2  Son Huynh       01/23/2002  - Fix race condition problem
*      Micron Technology Inc.      - Improve signals skew handling
*
* 1.1  Son Huynh       10/29/2001  - Fix DVLD signal
*      Micron Technology Inc.      - Add Data Mask for Write
*
* 1.0  Son Huynh       06/18/2001  - Initial release
*      Micron Technology Inc.
*
**************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 1ps

module mt49h16m16 (Dq, Dvld, Dqs, Dqs_n, Clk, Clk_n, Cs_n, As_n, We_n, Ref_n, Addr, Bank, Dm);

    // Constant parameters
    parameter addr_bits =      20;          // This is external address
    parameter data_bits =      16;
    parameter bank_bits =       3;
    parameter mem_sizes = 2097151;
    
    // Timing parameters for -4 (250 Mhz)
    parameter tQSQ      =       0.3;        // -0.3 to 0.3
    parameter tQSVLD    =       0.0;        // -0.4 to 0.4
    parameter tCKDQS    =       3.7;        //  2.3 to 3.7
    parameter tMRSC     =       4.0;        //  tCK

    // Port declarations
    inout     [data_bits - 1 : 0] Dq;
    output                        Dvld;
    output                [1 : 0] Dqs;
    output                [1 : 0] Dqs_n;
    input                         Clk;
    input                         Clk_n;
    input                         Cs_n;
    input                         As_n;
    input                         We_n;
    input                         Ref_n;
    input     [addr_bits - 1 : 0] Addr;
    input     [bank_bits - 1 : 0] Bank;
    input                 [1 : 0] Dm;

    // Memory arrays
    reg       [data_bits - 1 : 0] Bank0 [0 : mem_sizes];
    reg       [data_bits - 1 : 0] Bank1 [0 : mem_sizes];
    reg       [data_bits - 1 : 0] Bank2 [0 : mem_sizes];
    reg       [data_bits - 1 : 0] Bank3 [0 : mem_sizes];
    reg       [data_bits - 1 : 0] Bank4 [0 : mem_sizes];
    reg       [data_bits - 1 : 0] Bank5 [0 : mem_sizes];
    reg       [data_bits - 1 : 0] Bank6 [0 : mem_sizes];
    reg       [data_bits - 1 : 0] Bank7 [0 : mem_sizes];

    // Declare connection variables
    reg                           Data_in_enable;
    reg                           Data_out_enable;
    reg                           Dvld_enable;
    reg                           Dvld_buf;

    reg                           Cmnd_pipe [0 : 16];
    reg                   [1 : 0] Dmsk_pipe [0 : 16];
    reg       [bank_bits - 1 : 0] Bank_pipe [0 : 16];
    reg       [addr_bits - 1 : 0] Addr_pipe [0 : 16];

    reg       [addr_bits - 1 : 0] Mode_reg;
    reg                   [1 : 0] Dmsk_temp;
    reg                           Dmsk_reg [0 : 3];
    reg       [bank_bits - 1 : 0] Bank_reg;
    reg       [addr_bits     : 0] Addr_reg;     // This is internal address
    reg       [data_bits - 1 : 0] Dq_reg, Dq_buf;

    // Counters
    integer                       Data_counter;
    
    // Dqs Generator
    reg                   [1 : 0] Dqs, Dqs_n;

    // Timing check variables
    integer                       tRC;
    integer                       tRC_chk [0 : 7];
    integer                       tMRSC_chk;

    // Command Decode
    wire      Aref_enable  = ~Cs_n &  As_n &  We_n & ~Ref_n;
    wire      Mrs_enable   = ~Cs_n & ~As_n & ~We_n & ~Ref_n;
    wire      Read_enable  = ~Cs_n & ~As_n &  We_n &  Ref_n;
    wire      Write_enable = ~Cs_n & ~As_n & ~We_n &  Ref_n;

    // Configuration Decode
    wire      Cfg1 =  ~Mode_reg[2] & ~Mode_reg[1] &  Mode_reg[0];
    wire      Cfg2 =  ~Mode_reg[2] &  Mode_reg[1] & ~Mode_reg[0];
    wire      Cfg4 =   Mode_reg[2] & ~Mode_reg[1] & ~Mode_reg[0];
    wire      Cfg5 =   Mode_reg[2] & ~Mode_reg[1] &  Mode_reg[0];
    wire      Cfg6 =   Mode_reg[2] &  Mode_reg[1] & ~Mode_reg[0];
    wire      Cfg3 = (~Mode_reg[2] & ~Mode_reg[1] & ~Mode_reg[0]) |
                     (~Mode_reg[2] &  Mode_reg[1] &  Mode_reg[0]) |
                     ( Mode_reg[2] &  Mode_reg[1] &  Mode_reg[0]);

    // Burst Length Decode
    wire      BL2  =  ~Mode_reg[3];
    wire      BL4  =   Mode_reg[3];

    // Read Latency Decode
    wire      RL5  =   (Cfg1 | Cfg2 | Cfg3);
    wire      RL6  =    Cfg4;
    wire      RL7  =    Cfg5;
    wire      RL8  =    Cfg6;
               
    // Write Latency Decode
    wire      WL1  =  ((Cfg1 | Cfg2 | Cfg3) & BL4);
    wire      WL2  =  ((Cfg1 | Cfg2 | Cfg3) & BL2) | (Cfg4 & BL4);
    wire      WL3  =   (Cfg4 & BL2) | (Cfg5 & BL4);
    wire      WL4  =   (Cfg5 & BL2) | (Cfg6 & BL4);
    wire      WL5  =   (Cfg6 & BL2);

    // Output Buffer
    assign    #tQSQ   Dq    = Dq_buf;

    // Dvld Buffer
    assign    #tQSVLD Dvld  = Dvld_buf;

    // Initial Conditions
    initial begin
        Data_in_enable = 1'b0;
        Data_out_enable = 1'b0;
        Dvld_enable = 1'b0;
        Dvld_buf = 1'b0;
        Dq_buf = {data_bits{1'bz}};
        Dq_reg = {data_bits{1'bz}};
        $timeformat (-9, 0, " ns", 12);
    end

    // tRC Decode
    always @ (Mode_reg) begin
        case (Mode_reg [2 : 0])
            3'd1    : tRC =  5;
            3'd2    : tRC =  6;
            3'd3    : tRC =  7;
            3'd4    : tRC =  8;
            3'd5    : tRC =  9;
            3'd6    : tRC = 10;
            default : tRC =  7;
        endcase
    end

    // Data IO Process
    task data_io_process;
    begin
        // Command Pipeline
        Cmnd_pipe [ 0] = Cmnd_pipe [ 1];
        Cmnd_pipe [ 1] = Cmnd_pipe [ 2];
        Cmnd_pipe [ 2] = Cmnd_pipe [ 3];
        Cmnd_pipe [ 3] = Cmnd_pipe [ 4];
        Cmnd_pipe [ 4] = Cmnd_pipe [ 5];
        Cmnd_pipe [ 5] = Cmnd_pipe [ 6];
        Cmnd_pipe [ 6] = Cmnd_pipe [ 7];
        Cmnd_pipe [ 7] = Cmnd_pipe [ 8];
        Cmnd_pipe [ 8] = Cmnd_pipe [ 9];
        Cmnd_pipe [ 9] = Cmnd_pipe [10];
        Cmnd_pipe [10] = Cmnd_pipe [11];
        Cmnd_pipe [11] = Cmnd_pipe [12];
        Cmnd_pipe [12] = Cmnd_pipe [13];
        Cmnd_pipe [13] = Cmnd_pipe [14];
        Cmnd_pipe [14] = Cmnd_pipe [15];
        Cmnd_pipe [15] = Cmnd_pipe [16];
        Cmnd_pipe [16] = 1'bx;

        // Bank Pipeline
        Bank_pipe [ 0] = Bank_pipe [ 1];
        Bank_pipe [ 1] = Bank_pipe [ 2];
        Bank_pipe [ 2] = Bank_pipe [ 3];
        Bank_pipe [ 3] = Bank_pipe [ 4];
        Bank_pipe [ 4] = Bank_pipe [ 5];
        Bank_pipe [ 5] = Bank_pipe [ 6];
        Bank_pipe [ 6] = Bank_pipe [ 7];
        Bank_pipe [ 7] = Bank_pipe [ 8];
        Bank_pipe [ 8] = Bank_pipe [ 9];
        Bank_pipe [ 9] = Bank_pipe [10];
        Bank_pipe [10] = Bank_pipe [11];
        Bank_pipe [11] = Bank_pipe [12];
        Bank_pipe [12] = Bank_pipe [13];
        Bank_pipe [13] = Bank_pipe [14];
        Bank_pipe [14] = Bank_pipe [15];
        Bank_pipe [15] = Bank_pipe [16];
        Bank_pipe [16] = {bank_bits{1'bx}};

        // Addr Pipeline
        Addr_pipe [ 0] = Addr_pipe [ 1];
        Addr_pipe [ 1] = Addr_pipe [ 2];
        Addr_pipe [ 2] = Addr_pipe [ 3];
        Addr_pipe [ 3] = Addr_pipe [ 4];
        Addr_pipe [ 4] = Addr_pipe [ 5];
        Addr_pipe [ 5] = Addr_pipe [ 6];
        Addr_pipe [ 6] = Addr_pipe [ 7];
        Addr_pipe [ 7] = Addr_pipe [ 8];
        Addr_pipe [ 8] = Addr_pipe [ 9];
        Addr_pipe [ 9] = Addr_pipe [10];
        Addr_pipe [10] = Addr_pipe [11];
        Addr_pipe [11] = Addr_pipe [12];
        Addr_pipe [12] = Addr_pipe [13];
        Addr_pipe [13] = Addr_pipe [14];
        Addr_pipe [14] = Addr_pipe [15];
        Addr_pipe [15] = Addr_pipe [16];
        Addr_pipe [16] = {addr_bits{1'bx}};

        // Data Mask Pipeline
        Dmsk_pipe [ 0] = Dmsk_pipe [ 1];
        Dmsk_pipe [ 1] = Dmsk_pipe [ 2];
        Dmsk_pipe [ 2] = Dmsk_pipe [ 3];
        Dmsk_pipe [ 3] = Dmsk_pipe [ 4];
        Dmsk_pipe [ 4] = Dmsk_pipe [ 5];
        Dmsk_pipe [ 5] = Dmsk_pipe [ 6];
        Dmsk_pipe [ 6] = Dmsk_pipe [ 7];
        Dmsk_pipe [ 7] = Dmsk_pipe [ 8];
        Dmsk_pipe [ 8] = Dmsk_pipe [ 9];
        Dmsk_pipe [ 9] = Dmsk_pipe [10];
        Dmsk_pipe [10] = Dmsk_pipe [11];
        Dmsk_pipe [11] = Dmsk_pipe [12];
        Dmsk_pipe [12] = Dmsk_pipe [13];
        Dmsk_pipe [13] = Dmsk_pipe [14];
        Dmsk_pipe [14] = Dmsk_pipe [15];
        Dmsk_pipe [15] = Dmsk_pipe [16];
        Dmsk_pipe [16] = 2'b0;

        // Internal read or write command
        if (Cmnd_pipe [0] === 1'b0 || Cmnd_pipe [0] === 1'b1) begin
            if (Cmnd_pipe [0] === 1'b0) begin
                Data_in_enable = 1'b1;
            end else if (Cmnd_pipe [0] === 1'b1) begin
                Data_out_enable = 1'b1;
                Dvld_enable <= 1'b1;
            end

            Dmsk_temp = Dmsk_pipe[0];

            if (BL2 === 1'b1) begin
                Addr_reg = {Addr_pipe [0], 1'b0};
                Dmsk_reg [0] = Dmsk_temp [0];
                Dmsk_reg [1] = Dmsk_temp [1];
            end else if (BL4 === 1'b1) begin
                Addr_reg = {Addr_pipe [0], 1'b0} << 1;
                Dmsk_reg [0] = Dmsk_temp [0];
                Dmsk_reg [1] = Dmsk_temp [0];
                Dmsk_reg [2] = Dmsk_temp [1];
                Dmsk_reg [3] = Dmsk_temp [1];
            end
            
            Data_counter = 0;
            Bank_reg = Bank_pipe [0];
        end

        // Data Register
        if (Data_in_enable === 1'b1 || Data_out_enable === 1'b1) begin
            if (Data_in_enable === 1'b1) begin
                if (Dmsk_reg [Data_counter] === 1'b0) begin
                    case (Bank_reg)
                        3'd0 : Bank0 [Addr_reg] = Dq;
                        3'd1 : Bank1 [Addr_reg] = Dq;
                        3'd2 : Bank2 [Addr_reg] = Dq;
                        3'd3 : Bank3 [Addr_reg] = Dq;
                        3'd4 : Bank4 [Addr_reg] = Dq;
                        3'd5 : Bank5 [Addr_reg] = Dq;
                        3'd6 : Bank6 [Addr_reg] = Dq;
                        3'd7 : Bank7 [Addr_reg] = Dq;
                    endcase
                end
            end else if (Data_out_enable === 1'b1) begin
                case (Bank_reg)
                    3'd0 : Dq_reg <= #tCKDQS Bank0 [Addr_reg];
                    3'd1 : Dq_reg <= #tCKDQS Bank1 [Addr_reg];
                    3'd2 : Dq_reg <= #tCKDQS Bank2 [Addr_reg];
                    3'd3 : Dq_reg <= #tCKDQS Bank3 [Addr_reg];
                    3'd4 : Dq_reg <= #tCKDQS Bank4 [Addr_reg];
                    3'd5 : Dq_reg <= #tCKDQS Bank5 [Addr_reg];
                    3'd6 : Dq_reg <= #tCKDQS Bank6 [Addr_reg];
                    3'd7 : Dq_reg <= #tCKDQS Bank7 [Addr_reg];
                endcase
            end

            // Increasement Counter
            Data_counter = Data_counter + 1;
            Addr_reg = Addr_reg + 1;

            // Reset
            if ((BL2 === 1'b1 && Data_counter >= 2) || (BL4 === 1'b1 && Data_counter >= 4)) begin
                if (Data_in_enable === 1'b1) begin
                    Data_in_enable = 1'b0;
                end else if (Data_out_enable === 1'b1) begin
                    Data_out_enable = 1'b0;
                end
            end

        end else begin
            Dq_reg <= #tCKDQS {data_bits{1'bz}};
            Dvld_enable <= 1'b0;
        end
    end
    endtask

    // Latch External Command Process
    task latch_external_command_process;
    begin
        // tMRSC Counter
        tMRSC_chk = tMRSC_chk + 1;

        // tRC Counter
        tRC_chk [0] = tRC_chk [0] + 1;
        tRC_chk [1] = tRC_chk [1] + 1;
        tRC_chk [2] = tRC_chk [2] + 1;
        tRC_chk [3] = tRC_chk [3] + 1;
        tRC_chk [4] = tRC_chk [4] + 1;
        tRC_chk [5] = tRC_chk [5] + 1;
        tRC_chk [6] = tRC_chk [6] + 1;
        tRC_chk [7] = tRC_chk [7] + 1;

        // Latch External Command
        if (Mrs_enable === 1'b1) begin
            // Display Debug Message
            $display("At time %t : LMR   : command detected.", $time);
            
            // Latch Mode Register
            Mode_reg = Addr;

            // Reset tMRSC counter
            tMRSC_chk = 0;
        end else if (Aref_enable === 1'b1) begin
            // Display Debug Message
            $display("At time %t : Aref  : command detected.", $time);

            // Check for tMRSC violation
            if (tMRSC_chk < tMRSC) begin
                $display ("At time %t : Error : tMRSC violation during Auto Refresh to bank %d.",
                           $time, Bank);
            end

            // Check for tRC violation
            if (tRC_chk [Bank] < tRC) begin
                $display ("At time %t : Error : tRC violation during Auto Refresh to bank %d.", $time, Bank);
            end

            // Reset tRC Counter
            tRC_chk [Bank] = 0;
        end else if (Read_enable === 1'b1) begin
            // Display Debug Message
            $display("At time %t : Read  : command detected.", $time);

            // Check for tMRSC violation
            if (tMRSC_chk < tMRSC) begin
                $display ("At time %t : Error : tMRSC violation during Read to bank %d.", $time, Bank);
            end

            // Check for tRC violation
            if (tRC_chk [Bank] < tRC) begin
                $display ("At time %t : Error : tRC violation during Read to bank %d.", $time, Bank);
            end

            // Reset tRC Counter
            tRC_chk [Bank] = 0;

            // Latch Read Info
            if (RL5 === 1'b1) begin
                Cmnd_pipe [10] = 1'b1;
                Bank_pipe [10] = Bank;
                Addr_pipe [10] = Addr;
            end else if (RL6 === 1'b1) begin
                Cmnd_pipe [12] = 1'b1;
                Bank_pipe [12] = Bank;
                Addr_pipe [12] = Addr;
            end else if (RL7 === 1'b1) begin
                Cmnd_pipe [14] = 1'b1;
                Bank_pipe [14] = Bank;
                Addr_pipe [14] = Addr;
            end else if (RL8 === 1'b1) begin
                Cmnd_pipe [16] = 1'b1;
                Bank_pipe [16] = Bank;
                Addr_pipe [16] = Addr;
            end
        end else if (Write_enable === 1'b1) begin
            // Display Debug Message
            $display("At time %t : Write : command detected.", $time);

            // Check for tMRSC violation
            if (tMRSC_chk < tMRSC) begin
                $display ("At time %t : Error : tMRSC violation during Write to bank %d.", $time, Bank);
            end

            // Check for tRC violation
            if (tRC_chk [Bank] < tRC) begin
                $display ("At time %t : Error : tRC violation during Write to bank %d.", $time, Bank);
            end

            // Reset tRC Counter
            tRC_chk [Bank] = 0;

            // Latch Write Info
            if (WL1 === 1'b1) begin
                Cmnd_pipe [ 2] = 1'b0;
                Bank_pipe [ 2] = Bank;
                Addr_pipe [ 2] = Addr;
                Dmsk_pipe [ 2] = Dm;
            end else if (WL2 === 1'b1) begin
                Cmnd_pipe [ 4] = 1'b0;
                Bank_pipe [ 4] = Bank;
                Addr_pipe [ 4] = Addr;
                Dmsk_pipe [ 4] = Dm;
            end else if (WL3 === 1'b1) begin
                Cmnd_pipe [ 6] = 1'b0;
                Bank_pipe [ 6] = Bank;
                Addr_pipe [ 6] = Addr;
                Dmsk_pipe [ 6] = Dm;
            end else if (WL4 === 1'b1) begin
                Cmnd_pipe [ 8] = 1'b0;
                Bank_pipe [ 8] = Bank;
                Addr_pipe [ 8] = Addr;
                Dmsk_pipe [ 8] = Dm;
            end else if (WL5 === 1'b1) begin
                Cmnd_pipe [10] = 1'b0;
                Bank_pipe [10] = Bank;
                Addr_pipe [10] = Addr;
                Dmsk_pipe [10] = Dm;
            end
        end
    end
    endtask

    // Posedge Clk
    always @ (posedge Clk) begin
        data_io_process;

        latch_external_command_process;

        Dqs <= #tCKDQS 2'b11;

        Dqs_n <= #tCKDQS 2'b00;
    end

    // Posedge Clk_n
    always @ (posedge Clk_n) begin
        data_io_process;

        Dqs <= #tCKDQS 2'b00;

        Dqs_n <= #tCKDQS 2'b11;
    end

    // Posedge Dqs
    always @ (posedge Dqs) begin
        // Output Buffer
        Dq_buf = Dq_reg;
    end

    // Posedge Dqs_n
    always @ (posedge Dqs_n) begin
        // Output Buffer
        Dq_buf = Dq_reg;

        // Dlvd Buffer
        if (Dvld === 1'b0 && Dvld_enable === 1'b1) begin
            Dvld_buf = 1'b1;

        end else if (Dvld_buf === 1'b1 && Dvld_enable === 1'b0) begin
            Dvld_buf = 1'b0;
        end
    end

    // Timing check for -4 (250 Mhz)
    specify
        specparam
            // Clock
            tCK   =  4.00,
            tCKH  =  1.80,      // 0.45 tCK
            tCKL  =  1.80,      // 0.45 tCK
            
            // Setup Times
            tAS   =  1.00,
            tCS   =  1.00,
            tDS   =  0.50,
            
            // Hold Times
            tAH   =  1.00,
            tCH   =  1.00,
            tDH   =  0.50;

        $width    (posedge Clk,          tCKH);
        $width    (negedge Clk,          tCKL);
        $width    (posedge Clk_n,        tCKH);
        $width    (negedge Clk_n,        tCKL);
        $period   (posedge Clk,          tCK);
        $period   (negedge Clk,          tCK);
        $period   (posedge Clk_n,        tCK);
        $period   (negedge Clk_n,        tCK);
        $setuphold(posedge Clk,    Addr, tAS, tAH);
        $setuphold(posedge Clk,    Bank, tAS, tAH);
        $setuphold(posedge Clk,    Cs_n, tCS, tCH);
        $setuphold(posedge Clk,    As_n, tCS, tCH);
        $setuphold(posedge Clk,    We_n, tCS, tCH);
        $setuphold(posedge Clk,   Ref_n, tCS, tCH);
        $setuphold(posedge Clk,      Dm, tCS, tCH);
        //$setuphold(posedge Clk,      Dq, tDS, tDH);
        //$setuphold(posedge Clk_n,    Dq, tDS, tDH);
    endspecify
endmodule
