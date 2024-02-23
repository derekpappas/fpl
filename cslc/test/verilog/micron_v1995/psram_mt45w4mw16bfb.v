/****************************************************************************************
*
*    File Name:  MT45W4MW16BFB.V  
*        Model:  BUS Functional
*    Simulator:  Model Technology
*
* Dependencies:  None
*
*       Author:  Micron Technology, Inc.
*        Email:  modelsupport@micron.com
*  Part Number:  MT45W4MW16
*
*  Description:  Micron 64Mb CellularRAM 1.0 (Async / Page / Burst)
*
*   Limitation:  Need to add timing checks
*
*         Note:  
*
*   Disclaimer: 
* This software code and all associated documentation, comments or other 
* information (collectively "Software") is provided "AS IS" without 
* warranty of any kind. MICRON TECHNOLOGY, INC. ("MTI") EXPRESSLY 
* DISCLAIMS ALL WARRANTIES EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
* TO, NONINFRINGEMENT OF THIRD PARTY RIGHTS, AND ANY IMPLIED WARRANTIES 
* OF MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE. MTI DOES NOT 
* WARRANT THAT THE SOFTWARE WILL MEET YOUR REQUIREMENTS, OR THAT THE 
* OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE. 
* FURTHERMORE, MTI DOES NOT MAKE ANY REPRESENTATIONS REGARDING THE USE OR 
* THE RESULTS OF THE USE OF THE SOFTWARE IN TERMS OF ITS CORRECTNESS, 
* ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT OF USE 
* OR PERFORMANCE OF THE SOFTWARE REMAINS WITH YOU. IN NO EVENT SHALL MTI, 
* ITS AFFILIATED COMPANIES OR THEIR SUPPLIERS BE LIABLE FOR ANY DIRECT, 
* INDIRECT, CONSEQUENTIAL, INCIDENTAL, OR SPECIAL DAMAGES (INCLUDING, 
* WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, BUSINESS INTERRUPTION, 
* OR LOSS OF INFORMATION) ARISING OUT OF YOUR USE OF OR INABILITY TO USE 
* THE SOFTWARE, EVEN IF MTI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH 
* DAMAGES. Because some jurisdictions prohibit the exclusion or 
* limitation of liability for consequential or incidental damages, the 
* above limitation may not apply to you.
* 
* Copyright 2005 Micron Technology, Inc. All rights reserved.
* 
*
* Rev  Author          Date        Changes
* ---  --------------------------  ---------------------------------------
* 1.0  SH              05/10/2003  - Initial release
*      
* 1.1  NB              06/15/2004  - Fixed problem with row crossing
*                                    functionality. 
*
* 1.2  NB              06/15/2004  - Fixed problem with read/write wait
*                                    when wait is asserted once clock 
*                                    before the delay
* 1.3  PF              09/15/2004  - Added note about wait bug
*                                    
* 1.4  PF              10/20/2004  - Changed default value of
*                                    operation_mode to match datasheet.
*                                    Conditioned sync operation on setting
*                                    operation_mode
*
* 1.5  dritz           02/16/2006  - Fixed row boundary crossing for BCR[8]=1 and BCR[3] wrap 
**************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 1ps

module mt45w4mw16bfb (Dq, oWait, Clk, Addr, Ce_n, We_n, Adv_n, Oe_n, Cre, Lb_n, Ub_n); 

    // Constant parameters
    parameter addr_bits      =      22;
    parameter data_bits      =      16;
    parameter mem_sizes      = 4194303;

    // Display debug message
    parameter debug          =       0;
    
    // Timing parameters
    parameter tACLK          =       6.5;
    parameter tCEM           =   10000.0;
    parameter tCEW           =       6.5;

    // Port declarations
    inout     [data_bits - 1 : 0] Dq;
    output                        oWait;            // Wait is a keyword in HDL
    input                         Clk;
    input     [addr_bits - 1 : 0] Addr;
    input                         Ce_n;
    input                         We_n;
    input                         Adv_n;
    input                         Oe_n;
    input                         Cre;
    input                         Ub_n;
    input                         Lb_n;

    // Memory arrays
    reg                   [7 : 0] Bank0 [0 : mem_sizes];
    reg                   [7 : 0] Bank1 [0 : mem_sizes];

    // System registers
    reg                           sys_clk, sys_reset;

    // Asynchronous registers
    reg                           async_data_in_enable;
    reg                           async_data_out_enable;
    reg                           async_config_enable;
    reg       [addr_bits - 1 : 0] async_addr_in;
    reg       [data_bits - 1 : 0] async_data_in;
    reg       [data_bits - 1 : 0] async_data_out;

    // Synchronous registers
    reg                           sync_data_in_enable;
    reg                           sync_data_out_enable;
    reg                           last_sync_data_out_enable;
    reg       [addr_bits - 1 : 0] sync_addr_in;
    reg       [data_bits - 1 : 0] sync_data_out;
    reg                           bwait, rwait;
    reg                           lb_reg, ub_reg;
    integer                       counter;

    // Continuous row end delay
    reg                           row_start;
    reg                           row_end;
    reg                           last_row_end1;
    reg                           last_row_end;
    reg                           row_wait;
    integer                       row_count;

    // Flags for row boundary
    reg                    [16:0] sync_row_bndry_clk_count;
    reg                           sync_saw_row_boundary;
    reg                           sync_read; 
    reg                           sync_write;
    reg       [data_bits - 1 : 0] latch_last_row_byte;
    reg                           latch_Ub_n;
    reg                           latch_Lb_n;
    reg                           LastWordCornerCase;
    reg                    [16:0] LastWordCornerCaseCount;

    // Refresh Collision
    time                          ref_collision;

    // Output register
    reg       [data_bits - 1 : 0] data_out;

    // Latency counter pipeline
    reg                   [1 : 0] latency_counter_pipeline [0 : 8];     // 00 = Write, 01 = Read, 10 = Mode, 11 = don't care
    
    // Bus Configuration Register
    reg       [addr_bits - 1 : 0] bus_configuration_register;
    wire                  [2 : 0] burst_length          = bus_configuration_register [2 : 0];
    wire                          burst_wrap            = bus_configuration_register [3];
    wire                          clock_configuration   = bus_configuration_register [6];
    wire                          wait_configuration    = bus_configuration_register [8];
    wire                          hold_data_out         = bus_configuration_register [9];
    wire                          wait_polarity         = bus_configuration_register [10];
    wire                  [2 : 0] latency_counter       = bus_configuration_register [13 : 11];
    wire                          operation_mode        = bus_configuration_register [15];

    // Refresh Configuration Register
    reg       [addr_bits - 1 : 0] refresh_configuration_register;
    wire                  [2 : 0] partial_array_refresh = refresh_configuration_register [2 : 0];
    wire                          deep_power_down       = refresh_configuration_register [4];
    wire                          page_mode             = refresh_configuration_register [7];

    // Internal wires
    wire #1 last_adv_n   = Adv_n;
    wire #1 last_ce_n    = Ce_n;
    wire #1 last_we_n    = We_n;
    wire #1 last_lb_n    = Lb_n;
    wire #1 last_ub_n    = Ub_n;
    wire #1 last_cre     = Cre;

    // Wait buffer
    assign  oWait = bwait;
    //assign  oWait = rwait ? wait_configuration : bwait;


    // Output buffer
    assign #tACLK Dq = ~Ce_n && ~Oe_n && (sync_data_out_enable || async_data_out_enable) ? data_out : 16'bz;

    // Initial condition
    initial begin
        LastWordCornerCase = 1'b0;
        LastWordCornerCaseCount = 'b0;
        latch_Ub_n = 'bz;
        latch_Lb_n = 'bz;
        latch_last_row_byte = 'bz;
        sync_read = 1'b0;
        sync_saw_row_boundary = 1'b0;
        sync_row_bndry_clk_count = 'b0;
        sync_write = 1'b0;
        sys_clk = 1'b0;
        sys_reset = 1'b0;
        async_data_out = 16'bz;
        async_data_in_enable = 1'b0;
        async_data_out_enable = 1'b0;
        async_config_enable = 1'b0;
        sync_data_out = 16'bz;
        sync_data_in_enable = 1'b0;
        sync_data_out_enable = 1'b0;
        row_end = 1'b0;
        last_row_end1 = 1'b0;
        last_row_end = 1'b0;
        bwait = 1'bz;
        rwait = 1'bz;
        ref_collision = 0;
        bus_configuration_register = 'b00_0_000_1_0_011_1_0_1_0_1_0_0_1_111;
        refresh_configuration_register = 'h0070;
    end

    // Asynchronous Wait signal
    always @ (posedge Ce_n or negedge Ce_n) begin
        if (~Ce_n) begin
            rwait = wait_polarity;
        end else begin
            rwait = 1'bz;
            sync_data_out = 16'bz;
            sync_data_in_enable = 1'b0;
            sync_data_out_enable = 1'b0;
        end
    end

    // Asynchronous data latch
    always @ (Dq) begin
        async_data_in <= #1 Dq;
    end

    // Asynchronous address latch
    always @ (Adv_n or Addr) begin
        if (~last_adv_n && Adv_n) begin
            async_addr_in <= #1 Addr;
        end else if (~Adv_n) begin
            async_addr_in <= #1 Addr;
        end
    end

    // Main Asynchronous block
    always @ (Addr or Ce_n or We_n or Lb_n or Ub_n or Adv_n or sys_reset) begin
        if (sys_reset) begin
            async_data_in_enable = 1'b0;
            async_data_out_enable = 1'b0;
            async_config_enable = 1'b0;
            async_data_out = 16'bz;
        end else begin
            // Read Burst (done)
            if (~last_ce_n && Ce_n && async_data_out_enable) begin
                async_data_out_enable = 1'b0;
                async_data_out = 16'bz;
            end
            
            // Read Burst (init)
            else if ((~Adv_n && ~Ce_n && (~Lb_n || ~Ub_n) && We_n && ~Cre) || (~last_adv_n && Adv_n && async_data_out_enable)) begin
                // Lower byte
                case (Lb_n)
                    1'b0    : async_data_out [ 7 : 0] = Bank0 [Addr];
                    default : async_data_out [ 7 : 0] = 8'bz;
                endcase

                // Upper byte
                case (Ub_n)
                    1'b0    : async_data_out [15 : 8] = Bank1 [Addr];
                    default : async_data_out [15 : 8] = 8'bz;
                endcase

                // Enable data out
                async_data_out_enable = 1'b1;

                // Display debug message
                if (debug) $display ($time, " ns.  Note: Asynchronous - Read, Addr = %h, Data = %h", Addr, async_data_out);
            end

            // Initialize write burst
            if (~Ce_n && (~Lb_n || ~Ub_n) && ~We_n && ~Cre && ~async_data_in_enable) begin
                // Display debug message
                if (debug) $display ($time, " ns.  Note: Asynchronous - Initiate Write Access");

                // Init write burst
                async_data_in_enable = 1'b1;
                
                // Terminate Read
                async_data_out_enable = 1'b0;
                async_data_out = 16'bz;
            end

            // Write burst
            if (((~last_ce_n && Ce_n) || (~last_lb_n && Lb_n) || (~last_ub_n && Ub_n) || (~last_we_n && We_n)) && async_data_in_enable) begin
                // Lower Byte
                if (~Lb_n) begin
                    Bank0 [async_addr_in] = async_data_in [7 : 0];
                end

                // Upper Byte
                if (~Ub_n) begin
                    Bank1 [async_addr_in] = async_data_in [15 : 8];
                end

                // Done write
                async_data_in_enable = 1'b0;

                // Display debug message
                if (debug) $display ($time, " ns.  Note: Asynchronous - Write, Addr = %h, Data = %h",
                                            async_addr_in, async_data_in);
            end

            // Initialize configuration register
            if (~Adv_n && ~Ce_n && Oe_n && ~We_n && Cre && ~async_config_enable) begin
                // Display debug message
                if (debug) $display ($time, " ns.  Note: Asynchronous - Initiate Configuration Register Access");

                // Init write burst
                async_config_enable = 1'b1;
            end

            // Write configuration register
            if ((Ce_n ||  We_n || ~Cre) && async_config_enable) begin
                // BCR or RCR depend on Addr[19]
                case (async_addr_in[19])
                    1'b0    : refresh_configuration_register = async_addr_in;
                    default : bus_configuration_register = async_addr_in;
                endcase

                // Done configuration register write
                async_config_enable = 1'b0;

                // Display debug message
                if (debug) $display ($time, " ns.  Note: Asynchronous - Configuration Register Write, Addr = %h", async_addr_in);
            end
        end
    end

    // Synchronous internal command pipeline
    task synchronous_internal_command_pipeline;
        integer counter;
    begin
        // Latency counter pipeline
        for (counter = 0; counter < 8; counter = counter + 1) begin
            latency_counter_pipeline [counter] = latency_counter_pipeline [counter + 1];
        end
        
        latency_counter_pipeline [8] = 2'b11;

        // Internal command ready
        case (latency_counter_pipeline [0])
            2'b00 : sync_data_in_enable = 1'b1;
            2'b01 : sync_data_out_enable = 1'b1;
        endcase
    end
    endtask

    // Synchronous initial burst read
    task synchronous_initial_burst_read;
        integer random_delay;
    begin
        if (~Adv_n && ~Ce_n && We_n && ~Cre && (~Lb_n || ~Ub_n)) begin
            // Initialize random delay
            random_delay = 0;
            
            // Clear row crossing with a new access
            if (row_end == 1'b1) begin
                row_end = 1'b0;
            end

            // Random refresh cycle collision generator
            if (($time - ref_collision) >= tCEM) begin
                ref_collision = $time;
                random_delay = latency_counter;

                if (debug) $display ("==========================READ===========================");
                if (debug) $display ($time, " ns.  Note: Synchronous - Initialize Read, Wait = %d", random_delay);
            end

            // Set wait state
            if (debug) $display ($time, " ns.  rWait Trigger 0");
            rwait = wait_polarity;

            // Latch address
            sync_addr_in = Addr;

            // Reset counter
            counter = 0;

            // Register byte write
            lb_reg = Lb_n;
            ub_reg = Ub_n;

            // Latency counter
            case (latency_counter)
                3'b010 : latency_counter_pipeline [2 + random_delay] = 2'b01;
                3'b011 : latency_counter_pipeline [3 + random_delay] = 2'b01;
            endcase

            // Display debug message
            if (debug) $display ("==========================READ===========================");
            if (debug) $display ($time, " ns.  Note: Synchronous - Initialize Read, Addr = %h", Addr);
        end
    end
    endtask

    // Synchronous initial burst write
    task synchronous_initial_burst_write;
        integer random_delay;
    begin
        if (~Adv_n && ~Ce_n && Oe_n && ~We_n && ~Cre) begin
            // Initialize random delay
            random_delay = 0;

            // Clear row crossing with a new access
            if (row_end == 1'b1) begin
                row_end = 1'b0;
            end

            // Random refresh cycle collision generator
            if (($time - ref_collision) >= tCEM) begin
                ref_collision = $time;
                random_delay = latency_counter;

                if (debug) $display ($time, " ns.  Note: Synchronous - Initialize Write, Wait = %d", random_delay);
            end

            // Set wait state
            if (debug) $display ($time, " ns.  rWait Trigger 1");
            rwait = wait_polarity;

            // Latch address
            sync_addr_in = Addr;
    
            //Handle corner case where first addr latched is 7F or FF
            if (Addr [6 : 0] === 127) begin
                LastWordCornerCase = 1'b1;
                LastWordCornerCaseCount = 'b0;
            end

            row_start = Addr[7];

            // Reset counter
            counter = 0;

            // Latency counter
            case (latency_counter)
                3'b010 : latency_counter_pipeline [3 + random_delay] = 2'b00;
                3'b011 : latency_counter_pipeline [4 + random_delay] = 2'b00;
            endcase

            // Display debug message
            if (debug) $display ("==========================WRITE==========================");
            if (debug) $display ($time, " ns.  Note: Synchronous - Initialize Write, Addr = %h", Addr);

            sync_write <= 1'b1;

        end
    end
    endtask

    // Synchronous configuration register
    task synchronous_configuration_register;
        begin
            if (~Adv_n && ~Ce_n && Oe_n && ~We_n && Cre) begin
                // Set wait state
                if (debug) $display ($time, " ns.  rWait Trigger 2");
                rwait = wait_polarity;

                // Latency counter
                case (latency_counter)
                    3'b010 : latency_counter_pipeline [3] = 2'b10;
                    3'b011 : latency_counter_pipeline [4] = 2'b10;
                endcase

                // Write configuration register
                if (~Addr [19]) begin
                    refresh_configuration_register = Addr;
                end else begin
                    bus_configuration_register = Addr;
                end

                // Display debug message
                if (debug) $display ($time, " ns.  Note: Synchronous - Configuration Register Write, Addr = %h", Addr);
            end
        end
    endtask

    // Synchronous wait controller
    task synchronous_wait_controller;
        begin
            if (~wait_configuration) begin
                if ((latency_counter_pipeline [1] === 2'b00) ||
                    (latency_counter_pipeline [0] === 2'b01) ||
                    (latency_counter_pipeline [1] === 2'b10)) begin
                    if (debug) $display ($time, " ns.  rWait Trigger 3");
                    rwait = ~wait_polarity;
                end
            end else begin
                if ((latency_counter_pipeline [2] === 2'b00) ||
                    (latency_counter_pipeline [1] === 2'b01) ||
                    (latency_counter_pipeline [2] === 2'b10)) begin
                    if (debug) $display ($time, " ns.  rWait Trigger 4");
                    rwait = ~rwait;
                end
            end
        end
    endtask

    // Synchronous CE# termination
    task synchronous_ce_termination;
        begin
            if (Ce_n) begin
                // Terminate read
                if (sync_data_out_enable) begin
                    sync_data_out_enable = 1'b0;
                end

                // Terminate write
                if (sync_data_in_enable) begin
                    sync_data_in_enable = 1'b0;
                end

                // Clear row end, since access is complete
                if (row_end == 1'b1) begin
                    row_end = 1'b0;
                end

                // Terminate wait
                if (debug) $display ($time, " ns.  rWait Trigger 5");
                rwait = 1'bz;
            end
        end
    endtask

    // Synchronous read burst
    task synchronous_read_burst;
        begin
            if( 
               (last_sync_data_out_enable === 1'b0  && sync_data_out_enable === 1'b1 && wait_configuration && row_end === 1'b0) 
                ||
               (last_sync_data_out_enable === 1'b0  && sync_data_out_enable === 1'b1 && ~wait_configuration && row_end === 1'b0) 
                ||
               (last_sync_data_out_enable === 1'b1  && sync_data_out_enable === 1'b1 && row_end === 1'b0) 
              ) begin 

                sync_read <= 1'b1;

                // Set Wait
                //if (debug) $display ($time, " ns.  rWait Trigger 6a");
                rwait = ~wait_polarity;

                // Lower byte
                case (lb_reg)
                    1'b0    : sync_data_out [7 : 0] = Bank0 [sync_addr_in];
                    default : sync_data_out [7 : 0] = 8'bz;
                endcase

                // Upper byte
                case (ub_reg)
                    1'b0    : sync_data_out [15 : 8] = Bank1 [sync_addr_in];
                    default : sync_data_out [15 : 8] = 8'bz;
                endcase

                // Display debug message
                if (~lb_reg && ~ub_reg && sync_data_out_enable) begin
                    if (debug) $display ($time, " ns.  Note: Synchronous - Read, Addr = %h, Data = %h", sync_addr_in, sync_data_out);
                end

                // Advance counter
                counter = counter + 1;

                // Register new byte write
                if (counter >= 1) begin
                    lb_reg = Lb_n;
                    ub_reg = Ub_n;
                end

                //// Terminate write depend on burst length
                //if (((counter >  4) && (burst_length === 3'b001)) ||
                    //((counter >  8) && (burst_length === 3'b010)) ||
                    //((counter > 16) && (burst_length === 3'b011))) begin
                    //sync_data_out_enable = 1'b0;
                //end

                // Advance address
                if (burst_wrap === 1'b0) begin
                    // Wrap within the burst length
                    case (burst_length)
                        3'b001  : sync_addr_in [1 : 0] = sync_addr_in [1 : 0] + 1;
                        3'b010  : sync_addr_in [2 : 0] = sync_addr_in [2 : 0] + 1;
                        3'b011  : sync_addr_in [3 : 0] = sync_addr_in [3 : 0] + 1;
                        default : sync_addr_in         = sync_addr_in         + 1;
                    endcase
                end else begin
                    // Row end
                    if ((sync_data_out_enable === 1'b1) &&(sync_addr_in [6 : 0] === 127) && (burst_wrap === 1'b1)) begin
                        if (wait_configuration) begin
                            if (debug) $display ($time, " ns.  rWait Trigger 7a");
                            rwait = wait_polarity;
                        end
                        row_end = 1'b1;
                        row_count = (2*latency_counter);
                    end

                    // Burst no wrap
                    sync_addr_in = sync_addr_in + 1;
                end
            end else if (sync_data_out_enable === 1'b1 && row_end === 1'b1) begin
                sync_data_out = 16'bz;
                if (debug) $display ($time, " ns.  rWait Trigger 8");
                rwait = wait_polarity;
                row_count = row_count - 1;

                if (row_count <= 0) begin
                    if (wait_configuration) begin
                        if (debug) $display ($time, " ns.  rWait Trigger 9");
                        rwait = ~wait_polarity;
                    end
                    row_end = 1'b0;
                end
            end
        end
    endtask

    // Synchronous Write burst
    task synchronous_write_burst;
        begin
            if (    
               sync_data_in_enable && 
                (
                 ((wait_polarity === ~oWait) && (~sync_saw_row_boundary)) 
                  || 
                 //((wait_polarity ===  oWait) && wait_configuration && row_end && ~last_row_end && ~LastWordCornerCase)
                  //|| 
                 ((wait_polarity ===  ~oWait) && wait_configuration && row_end && LastWordCornerCase && (LastWordCornerCaseCount === 16'h0004))
                  || 
                 ((wait_polarity ===  ~oWait) && ~wait_configuration && row_end && LastWordCornerCase && (LastWordCornerCaseCount === 16'h0004))
                )
               ) begin

               sync_write <= 1'b1;

                // Lower Byte
                if (~Lb_n) begin
                    Bank0 [sync_addr_in] = Dq [7 : 0];
                end

                // Upper Byte
                if (~Ub_n) begin
                    Bank1 [sync_addr_in] = Dq [15 : 8];
                end

                // Display debug message
                if (~Lb_n || ~Ub_n) 
                    begin
                        if (debug) $display ($time, " ns.  Note: Synchronous - Write, Addr = %h, Data = %h", sync_addr_in, Dq);
                    end

                // Row end
                if ((sync_data_in_enable === 1'b1) && ((sync_addr_in [6 : 0] === 127) || (LastWordCornerCase)) && (burst_wrap === 1'b1)) begin
                    if (wait_configuration) begin
                        if (debug) $display ($time, " ns.  rWait Trigger 10");
                        rwait = wait_polarity;
                    end
                    row_end = 1'b1;
                    //if (~LastWordCornerCase) begin 
                        row_count = ((2*latency_counter)+2);
                    //end else begin
                        //row_count = row_count - 1;
                    //end
                                             
                end
            sync_addr_in = sync_addr_in + 1; // Advance address  XXX
            end else if (sync_data_in_enable === 1'b1 && row_end === 1'b1) begin
                sync_data_out = 16'bz;
                if (debug) $display ($time, " ns.  rWait Trigger 11");
                rwait = wait_polarity;

                row_count = row_count - 1;

                if ( 
                    (((row_count === 1) &&( wait_configuration))) 
                     ||
                    (((row_count === 0) &&(~wait_configuration))) 
                   )
                    begin
                    row_end = 1'b0;
                    if (debug) $display ($time, " ns.  rWait Trigger 12");
                    rwait = ~wait_polarity;
                end else if ((row_count === 1) && LastWordCornerCase) begin
                end
            end
        end
    endtask

    // Main Synchronous block
    always @ (posedge sys_clk) begin
        if (~operation_mode) begin
       	    synchronous_internal_command_pipeline;

            synchronous_initial_burst_read;

            synchronous_initial_burst_write;

            synchronous_configuration_register;

            synchronous_wait_controller;
    
            synchronous_ce_termination;

            synchronous_read_burst;

            synchronous_write_burst;
	end
        sys_reset = ~Ce_n;
    end

    always @ (posedge Ce_n) begin
        sync_row_bndry_clk_count   =  'b0;
        sync_read                  = 1'b0;
        sync_write                 = 1'b0;
        sync_saw_row_boundary      = 1'b0;
        latch_last_row_byte        =  'bz;
        LastWordCornerCase         = 1'b0;
        LastWordCornerCaseCount    =  'b0;
    end

    always @ (posedge sys_clk) begin 
        if (sync_write) begin
            if (row_end && ~last_row_end && ~Ce_n) begin
                sync_saw_row_boundary <= 1'b1;
            end
            if ((sync_saw_row_boundary || row_end) && ~Ce_n) begin
                sync_row_bndry_clk_count <= sync_row_bndry_clk_count + 1 ; 
                if ((sync_row_bndry_clk_count === 16'h0001) && (wait_configuration === 1'b0)) begin
                    //latch "last row byte + 1"
                    latch_last_row_byte <= Dq; 
                    latch_Ub_n <= Ub_n;
                    latch_Lb_n <= Lb_n;
                end else if ((sync_row_bndry_clk_count === 16'h0001) && (wait_configuration === 1'b1)) begin
                    //latch "last row byte + 1"
                    latch_last_row_byte <= Dq; 
                    latch_Ub_n <= Ub_n;
                    latch_Lb_n <= Lb_n;
                end
    
                if (sync_row_bndry_clk_count === (2*(latency_counter+1))) begin
                        //Write "last row byte + 1" to "Next row Addr 0"
                        if (~latch_Lb_n) begin
                            Bank0 [sync_addr_in] = latch_last_row_byte [ 7:0];
                        end
                        if (~latch_Ub_n) begin
                            Bank1 [sync_addr_in] = latch_last_row_byte [16:8];
                        end
                        // Display debug message
                        if (~latch_Lb_n || ~latch_Ub_n) 
                            begin
                                if (debug) $display ($time, " ns.  Note: [Row Boundary Corner Case] Sync - Write, Addr = %h, Data = %h", 
                                                                                                    sync_addr_in, latch_last_row_byte);
                        end


                    //Start next sync row operation at addr 1, rather than 0
                    sync_addr_in = sync_addr_in + 1;
    
                    //Reset row end state machine
                    sync_row_bndry_clk_count <=  'b0;
                    sync_read                 = 1'b0;
                    sync_write                = 1'b0;
                    sync_saw_row_boundary     = 1'b0;
                    latch_last_row_byte       =  'bz;
                    LastWordCornerCase        = 1'b0;
                    LastWordCornerCaseCount   =  'b0;
                end
            end
        end
    end

    // System clock generator
    always @ (Clk) begin
        case (clock_configuration)
            1'b0    : sys_clk = ~Clk;
            1'b1    : sys_clk =  Clk;
            default : sys_clk =  Clk;
        endcase
        last_sync_data_out_enable = sync_data_out_enable;
    end

    // Wait buffer
    always @ (rwait) begin
        bwait <= #tCEW rwait;
    end

    // Output buffer
    always @ (async_data_out or sync_data_out) begin
        case (sys_reset)
            1'b0    : data_out = async_data_out;
            default : data_out = sync_data_out;
        endcase
    end

    always @ (posedge sys_clk) begin 
        if (LastWordCornerCase) begin
            LastWordCornerCaseCount   = LastWordCornerCaseCount + 1;
        end
     
        //if (LastWordCornerCaseCount === 16'h0004) begin
            //row_end = 1'b1;
            //row_count = ((2*latency_counter)+2);
            //sync_saw_row_boundary <= 1'b1;
        //end
        last_row_end1 <= #1 row_end;
        last_row_end  <=    last_row_end1;
    end

endmodule
