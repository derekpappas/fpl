/****************************************************************************************
*
*    File Name:  MT45W4MW16PFA.V  
*     Revision:  1.0
*         Date:  February 14th, 2002
*        Model:  BUS Functional
*    Simulator:  Model Technology
*
* Dependencies:  None
*
*        Email:  modelsupport@micron.com
*      Company:  Micron Technology, Inc.
*  Part Number:  MT45W4MW16PFA
*
*  Description:  Micron 64Mb CellularRAM
*
*   Limitation:  
*
*         Note:  - Doesn't check for tPU and tR
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright � 1998 Micron Semiconductor Products, Inc.
*                All rights researved
*
* Rev  Author          Date        Changes
* ---  --------------------------  ---------------------------------------
* 1.0  SH              02/14/2003  - Initial release
*      Micron Technology Inc.
*
**************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 100ps

module mt45w4mw16pfa (Dq, Addr, Ce_n, We_n, Oe_n, Lb_n, Ub_n, Zz_n); 

    // Constant parameters
    parameter addr_bits      =      22;
    parameter data_bits      =      16;
    parameter mem_sizes      = 4194303;

    // Timing parameters
    parameter tOLZ           =       5;

    // Port declarations
    inout     [data_bits - 1 : 0] Dq;
    input     [addr_bits - 1 : 0] Addr;
    input                         Ce_n;
    input                         We_n;
    input                         Oe_n;
    input                         Ub_n;
    input                         Lb_n;
    input                         Zz_n;

    // Memory arrays
    reg                   [7 : 0] Bank0 [0 : mem_sizes];
    reg                   [7 : 0] Bank1 [0 : mem_sizes];

    // Internal registers
    reg       [addr_bits - 1 : 0] lcr_in;
    reg       [data_bits - 1 : 0] data_out;

    reg                           lcr_enable;
    reg                           read_enable;
    reg                           write_enable;

    // Internal wires
    wire #1 last_ce_n = Ce_n;
    wire #1 last_we_n = We_n;
    wire #1 last_lb_n = Lb_n;
    wire #1 last_ub_n = Ub_n;
    wire #1 last_zz_n = Zz_n;

    wire [data_bits - 1 : 0] data_in;
    wire [addr_bits - 1 : 0] addr_in;

    assign #1 data_in = Dq;
    assign #1 addr_in = Addr;

    // Output buffer
    assign #(tOLZ) Dq = (~Oe_n && ~Ce_n && (~Lb_n || ~Ub_n) && We_n) ? data_out : {data_bits{1'bz}};

    // Initial conditions
    initial begin
        lcr_in = 'h70;
        lcr_enable = 1'b0;
        write_enable = 1'b0;
        read_enable = 1'b0;
        $timeformat (-9, 0, " ns", 12);
    end

    // Main asynchronous block
    always @ (Addr or Ce_n or We_n or Lb_n or Ub_n or Zz_n) begin
        // Read command (init)
        if (~Ce_n && We_n && (~Lb_n || ~Ub_n) && Zz_n) begin
            read_enable = 1'b1;

            // Lower byte
            case (Lb_n)
                1'b0    : data_out [7 : 0] = Bank0 [Addr];
                default : data_out [7 : 0] = 8'bz;
            endcase

            // Upper byte
            case (Ub_n)
                1'b0    : data_out [15 : 8] = Bank1 [Addr];
                default : data_out [15 : 8] = 8'bz;
            endcase

            // Display debug message
            $display ($time, " ns :  NOTE: Read Cycle, Addr = %d, Data = %d", Addr, data_out);
        end

        // Read command (done - stand by) 
        if ((~last_ce_n && Ce_n) && read_enable) begin
            read_enable = 1'b0;
            data_out = 16'bz;
        end

        // Write command (init)
        if (~Ce_n && ~We_n && (~Lb_n || ~Ub_n) && Zz_n && ~write_enable) begin
            read_enable = 1'b0;
            write_enable = 1'b1;
            data_out = 16'bz;
        end

        // Write command (done)
        if (((~last_ce_n && Ce_n) || (~last_we_n && We_n) || (~last_lb_n && Lb_n) || (~last_ub_n && Ub_n)) & Zz_n && write_enable) begin
            // Lower Byte
            if (~Lb_n) begin
                Bank0 [addr_in] = data_in [7 : 0];
            end

            // Upper Byte
            if (~Ub_n) begin
                Bank1 [addr_in] = data_in [15 : 8];
            end

            // Disable data_in
            write_enable = 1'b0;

            // Display debug message
            $display ($time, " ns :  NOTE: Write Cycle, Addr = %d, Data = %d", addr_in, data_in);
        end

        // LCR command (init)
        if (~Ce_n && ~We_n && ~Zz_n && ~lcr_enable) begin
            lcr_enable = 1'b1;
        end

        // LCR command (done)
        if (((~last_ce_n && Ce_n) || (~last_we_n && We_n)) && ~Zz_n && lcr_enable) begin
            lcr_in = addr_in;

            lcr_enable = 1'b0;

            // Display debug message
            $display ($time, " ns :  NOTE: LCR Cycle, Addr = %d", addr_in);
        end

        // Active or Standby
        if (Ce_n) begin
            lcr_enable = 1'b0;
            read_enable = 1'b0;
            write_enable = 1'b0;
            data_out = 16'bz;
        end
    end

endmodule
