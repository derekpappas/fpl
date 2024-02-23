/**************************************************************************
*
*    File Name:  mt49h64m9.v  
*      Version:  1.1
*         Date:  August 30th, 2004
*        Model:  BUS Functional
*    Simulator:  Model Technology
*
* Dependencies:  None
*
*        Email:  modelsupport@micron.com
*      Company:  Micron Technology, Inc.
*  Part Number:  mt49h64m9 (8Meg x 9 x 8 Banks)
*
*  Description:  Micron 576Mb RLDRAM II CIO (Reduced Latency DRAM)
*
*   Limitation:  - Doesn't check for initialization
*                - Doesn't check for 8K cycle refresh
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
* 1.1  PF              08/30/2004  - Added initialization of Qvld
*      Micron Technology Inc.                      
*
* 1.0  SH              03/05/2003  - Add support for negative timing
*      Micron Technology Inc.                      parameters
*
**************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 1ps

module mt49h64m9 (Dq, Qvld, Qk, Qk_n, Ck, Ck_n, Dk, Dk_n, Cs_n, We_n, Ref_n, Addr, Bank, Dm);

    // Constant parameters
    parameter addr_bits =      22;          // This is external address
    parameter data_bits =       9;
    parameter bank_bits =       3;
    parameter mem_sizes = 8388607;
    
    // Timing parameters for -3.3 (300 Mhz)
    parameter tCKQK     =       0.30;
    parameter tQKQ      =       0.35;
    parameter tQKVLD    =       0.35;
    parameter tMRSC     =       6.00;       // tCK

    // Port declarations
    inout     [data_bits - 1 : 0] Dq;
    output                        Qvld;
    output                [1 : 0] Qk;
    output                [1 : 0] Qk_n;
    input                         Ck;
    input                         Ck_n;
    input                         Dk;       // DK1
    input                         Dk_n;     // DK1#
    input                         Cs_n;
    input                         We_n;
    input                         Ref_n;
    input     [addr_bits - 1 : 0] Addr;
    input     [bank_bits - 1 : 0] Bank;
    input                         Dm;

    // Port registers
    reg                   [1 : 0] Qk;
    reg                   [1 : 0] Qk_n;
    reg                           Qvld;

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
    reg                           Qvld_buf;

    reg                           Cmnd_pipe [0 : 20];
    reg       [bank_bits - 1 : 0] Bank_pipe [0 : 20];
    reg       [addr_bits - 1 : 0] Addr_pipe [0 : 20];

    reg       [bank_bits - 1 : 0] Read_bank_reg, Write_bank_reg;
    reg       [addr_bits     : 0] Read_addr_reg, Write_addr_reg;     // This is internal address
    reg       [data_bits - 1 : 0] Q_reg, Q_buf;

    // Data buffer for DK signals
    reg                           Dm_pos;
    reg                   [1 : 0] Dm_neg;

    reg       [data_bits - 1 : 0] D_pos;
    reg   [2 * data_bits - 1 : 0] D_neg;

    // Multiplexed Address Variables
    reg                           Mrs_in, Read_in, Write_in;
    reg       [addr_bits - 1 : 0] Addr_Axy;
    reg       [bank_bits - 1 : 0] Bank_mux;

    // Mode Register Set variables
    reg                           Addr_mux;
    integer                       Cfg, BL, RL, WL;

    // Data Counters
    integer                       Read_data_counter, Write_data_counter;

    // Interrupt Counters
    integer                       Read_interrupt_counter, Write_interrupt_counter;

    // Clock variables
    realtime                      avg_CK, last_CK;

    // Timing check variables
    integer                       tRC;
    integer                       tRC_chk [0 : 7];
    integer                       tMRSC_chk, Mrs_counter;

    // Command Decode
    wire      Mrs_enable    = ~Cs_n & ~We_n & ~Ref_n;
    wire      Read_enable   = ~Cs_n &  We_n &  Ref_n;
    wire      Write_enable  = ~Cs_n & ~We_n &  Ref_n;
    wire      Aref_enable   = ~Cs_n &  We_n & ~Ref_n;

    // Output Buffer
    assign    Dq            = Q_buf;

    // Initial Conditions
    initial begin
        Cfg = 1; tRC = 4; RL = 4; WL = 5; BL = 2; Addr_mux = 0;
        avg_CK = 5.7;
        last_CK = $realtime;
        tMRSC_chk = 0;
        Mrs_counter = 0;
        Data_in_enable = 1'b0;
        Data_out_enable = 1'b0;
        Qvld = 1'b0;
        Qvld_buf = 1'b0;
        Q_buf = {data_bits{1'bz}};
        Q_reg = {data_bits{1'bz}};
        $timeformat (-9, 0, " ns", 12);
    end

    // Decode Ax
    task Decode_Ax;
    begin
        Addr_Axy [ 0] = Addr [ 0];
        Addr_Axy [ 3] = Addr [ 3];
        Addr_Axy [ 4] = Addr [ 4];
        Addr_Axy [ 5] = Addr [ 5];
        Addr_Axy [ 8] = Addr [ 8];
        Addr_Axy [ 9] = Addr [ 9];
        Addr_Axy [10] = Addr [10];
        Addr_Axy [13] = Addr [13];
        Addr_Axy [14] = Addr [14];
        Addr_Axy [17] = Addr [17];
        Addr_Axy [18] = Addr [18];
    end
    endtask

    // Decode Ay
    task Decode_Ay;
    begin
        //Addr_Axy [20] = Addr [ 0];
        Addr_Axy [ 1] = Addr [ 3];
        Addr_Axy [ 2] = Addr [ 4];
        //Addr_Axy [21] = Addr [ 5];
        Addr_Axy [ 6] = Addr [ 8];
        Addr_Axy [ 7] = Addr [ 9];
        Addr_Axy [19] = Addr [10];
        Addr_Axy [11] = Addr [13];
        Addr_Axy [12] = Addr [14];
        Addr_Axy [16] = Addr [17];
        Addr_Axy [15] = Addr [18];
    end
    endtask

    // Mode Register Mux
    task Mode_register_mux;
        input [addr_bits - 1 : 0] Addr;
    begin
        // Configuration, tRC, RL, WL
        case (Addr [2 : 0])
            3'd1    : begin Cfg = 1; tRC = 4; RL = 4; WL = 5; end
            3'd2    : begin Cfg = 2; tRC = 6; RL = 6; WL = 7; end
            3'd3    : begin Cfg = 3; tRC = 8; RL = 8; WL = 9; end
            3'd4    : begin Cfg = 4; tRC = 3; RL = 3; WL = 4; end
            3'd5    : begin Cfg = 5; tRC = 5; RL = 5; WL = 6; end
            3'd6    : begin Cfg = 6; tRC = 7; RL = 7; WL = 8; end
            default : begin Cfg = 1; tRC = 4; RL = 4; WL = 5; end
        endcase

        // Burst Length
        case (Addr [4 : 3])
            2'd0    : BL = 2;
            2'd1    : BL = 4;
            2'd2    : BL = 8;
            default : BL = 2;
        endcase

        // Check for illegal modes
        if (Cfg === 1 && BL=== 8) begin
            $display ("At time %t : BL = 8 is not available for configuration 1", $time);
        end
    end
    endtask
    
    // Read Address Mux
    task Read_addr_mux;
        input [addr_bits - 1 : 0] Addr;
        input [bank_bits - 1 : 0] Bank;
    begin
        // Latch Read Info
        if (RL === 3) begin
            Cmnd_pipe [ 5] = 1'b1;
            Bank_pipe [ 5] = Bank;
            Addr_pipe [ 5] = Addr;
        end else if (RL === 4) begin
            Cmnd_pipe [7] = 1'b1;
            Bank_pipe [7] = Bank;
            Addr_pipe [7] = Addr;
        end else if (RL === 5) begin
            Cmnd_pipe [9] = 1'b1;
            Bank_pipe [9] = Bank;
            Addr_pipe [9] = Addr;
        end else if (RL === 6) begin
            Cmnd_pipe [11] = 1'b1;
            Bank_pipe [11] = Bank;
            Addr_pipe [11] = Addr;
        end else if (RL === 7) begin
            Cmnd_pipe [13] = 1'b1;
            Bank_pipe [13] = Bank;
            Addr_pipe [13] = Addr;
        end else if (RL === 8) begin
            Cmnd_pipe [15] = 1'b1;
            Bank_pipe [15] = Bank;
            Addr_pipe [15] = Addr;
        end
    end
    endtask

    // Write Address Mux
    task Write_addr_mux;
        input [addr_bits - 1 : 0] Addr;
        input [bank_bits - 1 : 0] Bank;
    begin
        // Latch Write Info
        if (WL === 4) begin
            Cmnd_pipe [10] = 1'b0;
            Bank_pipe [10] = Bank;
            Addr_pipe [10] = Addr;
        end else if (WL === 5) begin
            Cmnd_pipe [12] = 1'b0;
            Bank_pipe [12] = Bank;
            Addr_pipe [12] = Addr;
        end else if (WL === 6) begin
            Cmnd_pipe [14] = 1'b0;
            Bank_pipe [14] = Bank;
            Addr_pipe [14] = Addr;
        end else if (WL === 7) begin
            Cmnd_pipe [16] = 1'b0;
            Bank_pipe [16] = Bank;
            Addr_pipe [16] = Addr;
        end else if (WL === 8) begin
            Cmnd_pipe [18] = 1'b0;
            Bank_pipe [18] = Bank;
            Addr_pipe [18] = Addr;
        end else if (WL === 9) begin
            Cmnd_pipe [20] = 1'b0;
            Bank_pipe [20] = Bank;
            Addr_pipe [20] = Addr;
        end
    end
    endtask

    // Data IO Process
    task Data_io_process;
        integer index;
    begin
        // Advance interrupt counter
        Read_interrupt_counter = Read_interrupt_counter + 1;
        Write_interrupt_counter = Write_interrupt_counter + 1;

        // Internal pipeline
        for (index = 0; index < 20; index = index + 1) begin
            Cmnd_pipe [index] = Cmnd_pipe [index + 1];
            Bank_pipe [index] = Bank_pipe [index + 1];
            Addr_pipe [index] = Addr_pipe [index + 1];
        end

        Cmnd_pipe [20] = 1'bx;
        Bank_pipe [20] = {bank_bits{1'bx}};
        Addr_pipe [20] = {addr_bits{1'bx}};

        // Internal read command
        if (Cmnd_pipe [0] === 1'b1) begin
            Data_out_enable = 1'b1;
            Read_data_counter = 0;
            Read_bank_reg = Bank_pipe [0];
            if (BL === 2) begin
                Read_addr_reg = {Addr_pipe [0], 1'b0};
            end else if (BL === 4) begin
                Read_addr_reg = {Addr_pipe [0], 1'b0} << 1;
            end else if (BL === 8) begin
                Read_addr_reg = {Addr_pipe [0], 1'b0} << 2;
            end
        end

        // Internal write command
        if (Cmnd_pipe [0] === 1'b0) begin
            Data_in_enable = 1'b1;
            Write_data_counter = 0;
            Write_bank_reg = Bank_pipe [0];
            if (BL === 2) begin
                Write_addr_reg = {Addr_pipe [0], 1'b0};
            end else if (BL === 4) begin
                Write_addr_reg = {Addr_pipe [0], 1'b0} << 1;
            end else if (BL === 8) begin
                Write_addr_reg = {Addr_pipe [0], 1'b0} << 2;
            end
        end
    end
    endtask

    // Read Data Process
    task Read_data_process;
    begin
        // Read Data
        if (Data_out_enable === 1'b1) begin
            case (Read_bank_reg)
                3'd0 : Q_reg = Bank0 [Read_addr_reg];
                3'd1 : Q_reg = Bank1 [Read_addr_reg];
                3'd2 : Q_reg = Bank2 [Read_addr_reg];
                3'd3 : Q_reg = Bank3 [Read_addr_reg];
                3'd4 : Q_reg = Bank4 [Read_addr_reg];
                3'd5 : Q_reg = Bank5 [Read_addr_reg];
                3'd6 : Q_reg = Bank6 [Read_addr_reg];
                3'd7 : Q_reg = Bank7 [Read_addr_reg];
            endcase

            $display ("At time %t : Read  : bank = %d, addr = %d, data = %d",
                       $time, Read_bank_reg, Read_addr_reg, Q_reg);

            // Increasement Counter
            Read_data_counter = Read_data_counter + 1;
            Read_addr_reg = Read_addr_reg + 1;

            // Reset
            if ((BL === 2 && Read_data_counter >= 2) ||
                (BL === 4 && Read_data_counter >= 4) ||
                (BL === 8 && Read_data_counter >= 8)) begin
                if (Data_out_enable === 1'b1) begin
                    Data_out_enable = 1'b0;
                end
            end
        end else begin
            Q_reg = {data_bits{1'bz}};
        end
    end
    endtask

    // Write Data Process
    task Write_data_process;
    begin
        // Write Data
        if (Data_in_enable === 1'b1) begin
            // Write data from posedge of Dk
            if (Dm_neg [0] === 1'b0) begin
                case (Write_bank_reg)
                    3'd0 : Bank0 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                    3'd1 : Bank1 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                    3'd2 : Bank2 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                    3'd3 : Bank3 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                    3'd4 : Bank4 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                    3'd5 : Bank5 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                    3'd6 : Bank6 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                    3'd7 : Bank7 [Write_addr_reg] = D_neg [data_bits - 1 : 0];
                endcase

                $display ("At time %t : Write : bank = %d, addr = %d, data = %d",
                           $time, Write_bank_reg, Write_addr_reg, D_neg [data_bits - 1 : 0]);
            end
            
            // Increasement Counter
            Write_data_counter = Write_data_counter + 1;
            Write_addr_reg = Write_addr_reg + 1;

            // Write data from posedge of Dk_n
            if (Dm_neg [1] === 1'b0) begin
                case (Write_bank_reg)
                    3'd0 : Bank0 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                    3'd1 : Bank1 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                    3'd2 : Bank2 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                    3'd3 : Bank3 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                    3'd4 : Bank4 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                    3'd5 : Bank5 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                    3'd6 : Bank6 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                    3'd7 : Bank7 [Write_addr_reg] = D_neg [2 * data_bits - 1 : data_bits];
                endcase

                $display ("At time %t : Write : bank = %d, addr = %d, data = %d",
                           $time, Write_bank_reg, Write_addr_reg, D_neg [2 * data_bits - 1 : data_bits]);
            end

            // Increasement Counter
            Write_data_counter = Write_data_counter + 1;
            Write_addr_reg = Write_addr_reg + 1;

            // Reset
            if ((BL === 2 && Write_data_counter >= 2) ||
                (BL === 4 && Write_data_counter >= 4) ||
                (BL === 8 && Write_data_counter >= 8)) begin
                if (Data_in_enable === 1'b1) begin
                    Data_in_enable = 1'b0;
                end
            end
        end
    end
    endtask

    // Latch External Command Process
    task Latch_external_command_process;
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

        // Latch Ay for MRS
        if (Mrs_in === 1'b1) begin
            Decode_Ay;
            Mode_register_mux (Addr_Axy);
            Mrs_in = 1'b0;
            $display("At time %t : Mrs   : latch Ay.", $time);
        end

        // Latch Ay for Read
        else if (Read_in === 1'b1) begin
            Decode_Ay;
            Read_addr_mux (Addr_Axy, Bank_mux);
            Read_in = 1'b0;
            $display("At time %t : Read  : latch Ay.", $time);
        end

        // Latch Ay for Write
        else if (Write_in === 1'b1) begin
            Decode_Ay;
            Write_addr_mux (Addr_Axy, Bank_mux);
            Write_in = 1'b0;
            $display("At time %t : Write : latch Ay.", $time);
        end

        // Mode Register Set
        if (Mrs_enable === 1'b1) begin
            // Dummies MRS counter
            Mrs_counter = Mrs_counter + 1;

            // Display Debug Message
            $display("At time %t : Mrs   : command detected.", $time);

            // Address Mux
            if (Mrs_counter >= 3 && Addr_mux === 1'b0 && Addr [5] === 1'b1) begin
                Addr_mux = 1'b1;
                $display("At time %t : Mrs   : multiplexed address mode.", $time);

            end else if (Mrs_counter >= 3 && Addr_mux === 1'b1 && Addr [5] === 1'b1) begin
                Decode_Ax;
                Mrs_in = 1'b1;
                $display("At time %t : Mrs   : latch Ax.", $time);

            end else if (Mrs_counter >= 3) begin
                Addr_mux = 1'b0;
                Mode_register_mux (Addr);
                $display("At time %t : Mrs   : non-multiplexed address mode.", $time);
            end

            // Check for tMRSC violation
            if (Mrs_counter >= 4 && tMRSC_chk < tMRSC) begin
                $display ("At time %t : Error : tMRSC violation during Mode Register Set.", $time);
            end

            // Reset tMRSC Counter
            tMRSC_chk = 0;
        end

        // Auto Refresh
        else if (Aref_enable === 1'b1) begin
            // Display Debug Message
            $display("At time %t : Aref  : command detected.", $time);

            // Check for tMRSC violation
            if (tMRSC_chk < tMRSC) begin
                $display ("At time %t : Error : tMRSC violation during Auto Refresh to bank %d.", $time, Bank);
            end

            // Check for tRC violation
            if (tRC_chk [Bank] < tRC) begin
                $display ("At time %t : Error : tRC violation during Auto Refresh to bank %d.", $time, Bank);
            end

            // Reset tRC Counter
            tRC_chk [Bank] = 0;
        end

        // Read Command
        else if (Read_enable === 1'b1) begin
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

            // Check for illegal interrupt
            if ((Read_interrupt_counter < BL) || (Write_interrupt_counter <= BL)) begin
                $display ("At time %t : ERROR : It's illegal to interrupt a previous burst.", $time);
            end

            // Latch Read Info
            if (Addr_mux === 1'b1) begin
                Decode_Ax;
                Bank_mux = Bank;
                Read_in = 1'b1;
                $display("At time %t : Read  : latch Ax.", $time);
            end else begin
                Read_addr_mux (Addr, Bank);
            end

            // Reset tRC Counter
            tRC_chk [Bank] = 0;

            // Reset Read Interrupt Counter
            Read_interrupt_counter = 0;
        end

        // Write Command
        else if (Write_enable === 1'b1) begin
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

            // Check for illegal interrupt
            if ((Read_interrupt_counter < BL) || (Write_interrupt_counter < BL)) begin
                $display ("At time %t : ERROR : It's illegal to interrupt a previous burst.", $time);
            end

            // Latch Write Info
            if (Addr_mux === 1'b1) begin
                Decode_Ax;
                Bank_mux = Bank;
                Write_in = 1'b1;
                $display("At time %t : Write : latch Ax.", $time);
            end else begin
                Write_addr_mux (Addr, Bank);
            end

            // Reset tRC Counter
            tRC_chk [Bank] = 0;

            // Reset Write Interrupt Counter
            Write_interrupt_counter = 0;
        end
    end
    endtask

    // Posedge Ck
    always @ (posedge Ck) begin
        Data_io_process;

        Read_data_process;

        Write_data_process;

        Latch_external_command_process;

        // Dlvd Buffer
        if (Cmnd_pipe [1] === 1'b1) begin
            Qvld_buf = 1'b1;
        end else if (Qvld_buf === 1'b1 && Data_out_enable === 1'b0) begin
            Qvld_buf = 1'b0;
        end

        // Internal clock generators
        if ($realtime - last_CK > 2 * avg_CK) begin
            $display ("At time %t : Note  : Clock Interrupt.", $time);
        end else begin
            avg_CK = 0.1 * (9 * avg_CK + ($realtime - last_CK));
        end

        last_CK = $realtime;

        // QK Generator
        Qk   <= #(avg_CK + tCKQK) {Ck, Ck};
        Qk_n <= #(avg_CK + tCKQK) {Ck_n, Ck_n};
    end

    // Posedge Ck#
    always @ (posedge Ck_n) begin
        Data_io_process;

        Read_data_process;

        // QK Generator
        Qk   <= #(avg_CK + tCKQK) {Ck, Ck};
        Qk_n <= #(avg_CK + tCKQK) {Ck_n, Ck_n};
    end

    // Posedge Dk
    always @ (posedge Dk) begin
        // Dm Register
        Dm_pos = Dm;

        // Input Register
        D_pos = Dq;
    end

    // Posedge Dk_n
    always @ (posedge Dk_n) begin
        // Dm Register
        Dm_neg = {Dm, Dm_pos};

        // Input Register
        D_neg = {Dq, D_pos};
    end

    // Dvld buffer
    always @ (Qvld_buf) begin
        Qvld  <= #(avg_CK / 2 + tCKQK + tQKVLD) Qvld_buf;
    end

    // Output buffer
    always @ (Q_reg) begin
        fork
            Q_buf <= #(avg_CK / 2 + tCKQK) {data_bits{1'bx}};
            Q_buf <= #(avg_CK / 2 + tCKQK + tQKQ) Q_reg;
        join
    end

endmodule
