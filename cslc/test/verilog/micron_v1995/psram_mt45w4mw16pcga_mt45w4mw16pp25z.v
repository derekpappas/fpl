/**************************************************************************
*
*    File Name:  model.v
*        Model:  BUS Functional
*    Simulator:  Model Technology
*
* Dependencies:  parameters.v
*
*       Author:  Micron Technology, Inc.
*        Email:  modelsupport@micron.com
*  Part Number:  MT45W1MW16PDGA and MT45W1MW16PP23Z
*
*  Description:  Micron 64Mb CellularRAM 1.0 (Async / Page / Burst)
*
*   Limitation:  Need to add timing checks
*
*         Note:  
*
*   Disclaimer: This software code and all associated documentation, comments
*               or other information (collectively "Software") is provided 
*               "AS IS" without warranty of any kind. MICRON TECHNOLOGY, INC. 
*               ("MTI") EXPRESSLY DISCLAIMS ALL WARRANTIES EXPRESS OR IMPLIED,
*               INCLUDING BUT NOT LIMITED TO, NONINFRINGEMENT OF THIRD PARTY
*               RIGHTS, AND ANY IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS
*               FOR ANY PARTICULAR PURPOSE. MTI DOES NOT WARRANT THAT THE
*               SOFTWARE WILL MEET YOUR REQUIREMENTS, OR THAT THE OPERATION OF
*               THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE. FURTHERMORE,
*               MTI DOES NOT MAKE ANY REPRESENTATIONS REGARDING THE USE OR THE
*               RESULTS OF THE USE OF THE SOFTWARE IN TERMS OF ITS CORRECTNESS,
*               ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT
*               OF USE OR PERFORMANCE OF THE SOFTWARE REMAINS WITH YOU. IN NO
*               EVENT SHALL MTI, ITS AFFILIATED COMPANIES OR THEIR SUPPLIERS BE
*               LIABLE FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL, OR
*               SPECIAL DAMAGES (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS
*               OF PROFITS, BUSINESS INTERRUPTION, OR LOSS OF INFORMATION)
*               ARISING OUT OF YOUR USE OF OR INABILITY TO USE THE SOFTWARE,
*               EVEN IF MTI HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
*               Because some jurisdictions prohibit the exclusion or limitation
*               of liability for consequential or incidental damages, the above
*               limitation may not apply to you.
*               
*               Copyright 2005 Micron Technology, Inc. All rights reserved.
*               
* Rev  Author          Date        Changes
* ---  --------------------------  ----------------------------------------
* 1.0  SH              05/10/2003  - Initial release
*      
* 1.1  NB              06/15/2004  - Fixed problem with row crossing
*                                    functionality. 
*
* 1.2  PF              10/20/2004  - Changed default value of
*                                    operating_mode to match datasheet.
*                                    Conditioned sync operation on setting
*                                    operating_mode
*
* 1.3  dritz           01/20/2005  - Updated parameters, parameterized the model, corrected a few bugs.
*                                      populated BCR, RCR
*                                      added DIDR feature
*                                      fixed burst interrupt on ADV#
*                                      added CR1.0 1.5 features
*
* 1.4  dritz           05/13/2005  - added "delayed write" feature.
*                                    in params -> Addr bits 22 now, size now 64Meg
*
* 1.5  dritz           09/02/2005  - Reverted to CR1.0 
*                                         - Remove initial fixed latency
*                                         - Removed 1/2 drive strength
*                                         - Removed DIDR
*                                         - Added Clock Config Reg.
*                                         - Added Temp comp refresh
*                                         - Removed BCR Register
*                                         - Add ZZ# pin / remove CRE pin
*                                         - Speed grade now 70 not 701 or 708
*                                         - Removed pins: Adv_n, Clk, oWait
*
*
*
**************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USES "PS" RESOLUTION
`timescale 1ns / 1ps

module model_verilog (
              Addr, 
              Ce_n, 
              //Clk, 
              Dq, 
              Lb_n, 
              Oe_n, 
              //oWait, 
              Ub_n,
              We_n,
              ZZ_n 
              ); 

`include "parameters_mt45w4mw16pcga_mt45w4mw16pp25z.v"

    // Display debug message
    parameter debug          =    1;
    
    // Port declarations
    inout     [data_bits - 1 : 0] Dq;
    wire                          Clk =  1'b1;
    input     [addr_bits - 1 : 0] Addr;
    input                         Ce_n;
    input                         We_n;
    input                         Oe_n;
    input                         ZZ_n;
    input                         Ub_n;
    input                         Lb_n;

    // Memory arrays
    reg                   [7 : 0] Bank0 [0 : mem_sizes];
    reg                   [7 : 0] Bank1 [0 : mem_sizes];

    // System registers
    reg                           sys_clk, sys_reset;

    // Asynchronous registers
    reg                           async_data_out_enable;
    reg                           async_config_enable;
    reg                           async_data_in_enable;
    reg       [addr_bits - 1 : 0] async_addr_in;
    reg       [data_bits - 1 : 0] async_data_in;
    reg       [data_bits - 1 : 0] async_data_out;

    // Synchronous registers
    reg                           sync_data_in_enable;
    reg                           sync_data_out_enable;
    reg       [addr_bits - 1 : 0] sync_addr_in;
    reg       [data_bits - 1 : 0] sync_data_out;
    reg                           lb_reg, ub_reg;
    integer                       counter;

    // Continuous row end delay
    reg                           row_start;
    reg                           row_end;
    integer                       row_count;

    // Refresh Collision
    time                          ref_collision;

    // Output register
    reg       [data_bits - 1 : 0] data_out;

    // Latency counter pipeline
    // 00 = Write, 01 = Read, 10 = Mode, 11 = don't care
    reg                   [1 : 0] latency_counter_pipeline [0 : 13];
   
    // Flags 
    reg                           gender_neutral_initial_burst;

    reg  [addr_bits-1:0] latch_data_in_register;
    // Bus Configuration Register
    reg  [addr_bits-1:0] bus_conf_register;
    wire           [2:0] burst_length           = bus_conf_register [2:0];
    wire                 burst_wrap             = bus_conf_register [3];
    wire           [1:0] drive_strength         = bus_conf_register [5:4];
    wire                 delayed_write          = bus_conf_register [6]; 
    wire                 reserved_1             = bus_conf_register [7];
    wire                 wait_configuration     = bus_conf_register [8];   
    wire                 hold_data_out          = bus_conf_register [9];
    wire           [2:0] latency_counter        = bus_conf_register [13:11];
    wire                 initial_latency        = bus_conf_register [14];
    wire                 operating_mode         = bus_conf_register [15]; 
    wire           [2:0] reserved_2             = bus_conf_register [18:16];
    wire                 register_select_BCR    = bus_conf_register [19];

    // Refresh Configuration Register
    reg  [addr_bits-1:0] ref_conf_register;
    wire           [2:0] partial_array_refresh  = ref_conf_register [2:0];
    wire                 reserved_4             = ref_conf_register [3];
    wire                 deep_power_down        = ref_conf_register [4];
    wire           [1:0] temp_comp_refresh      = ref_conf_register [6:5];
    wire                 page_mode              = ref_conf_register [7];
    wire           [9:0] reserved_6             = ref_conf_register [17:8];
    wire                 register_select_RCR    = ref_conf_register [19];


    // Device ID Register READ ONLY
    reg  [addr_bits-1:0] didr_conf_register = 0;
    reg            [4:0] vendor_ID              = 5'b00011;    // Micron
    reg            [2:0] generation             = 3'b010;      // 010= *CR1.5*
    reg            [2:0] density                = 3'b011;      // 128Mb
    reg            [3:0] version                = 4'b0100;     // arbitary

    // Internal wires
    wire #1 last_ce_n  = Ce_n;
    wire #1 last_we_n  = We_n;
    wire #1 last_lb_n  = Lb_n;
    wire #1 last_ub_n  = Ub_n;
    wire #1 last_ZZ_n  = ZZ_n;

    // Output buffer
    assign Dq = async_data_out_enable ? data_out : 16'bz;

    // Initial condition
    initial begin
        sys_clk = 1'b0;
        sys_reset = 1'b0;
        async_data_out = 16'bz;
        async_data_out_enable = 1'b0;
        async_config_enable = 1'b0;
        async_data_in_enable = 1'b0;
        sync_data_out = 16'bz;
        sync_data_in_enable = 1'b0;
        sync_data_out_enable = 1'b0;
        row_end = 1'b0;
        ref_collision = 0;
        //  BUS CONF REGISTER   9_876 5 4 321 0 9 8 7 6 5_4 3 210 
        bus_conf_register = 20'b1_000_1_0_011_1_0_1_0_1_0_0_1_111;   //Default powerup values
        latch_data_in_register = 23'hzzzzzz;
        //  REF CONF REGISTER   9_87654321098 7 65 4 3 210 
        ref_conf_register = 20'b0_00000000000_0_00_1_0_000;   //Default powerup values
        //didr_conf_register = {version, density, generation, vendor_ID};
        gender_neutral_initial_burst <= 1'b0;
    end

    // Asynchronous data latch
    always @ (Dq) begin
        $display("Asynchronous data latch");
        async_data_in <= #1 Dq;
    end

    // Asynchronous address latch
    always @ (Ce_n) begin
        $display("Asynchronous address latch");
        if (~last_ce_n && Ce_n) begin
            async_addr_in <= #1 Addr;
        end
    end

    // Main Asynchronous block
    always @ (Addr or Ce_n or We_n or Oe_n or Lb_n or Ub_n or sys_reset) begin
        $display("Main Asynchronous Block");
        if (sys_reset) begin
            async_data_out_enable = 1'b0;
            async_config_enable = 1'b0;
            async_data_in_enable = 1'b0;
            async_data_out = 16'bz;
        end else begin
            // Read Burst (done)
            if (~last_ce_n && Ce_n && async_data_out_enable) begin
                async_data_out_enable = #tHZ 1'b0;
                async_data_out = 16'bz;
            end
            
        // Config Read 
        else if (~Ce_n && We_n && ~Oe_n  && async_config_enable) begin
            if (debug) $display ($time, "Caught Async Config Read");
            async_data_out = ref_conf_register;  // 00 = RCR
            if (debug) $display ($time, "   RCR read, RCR=%h", ref_conf_register);

            // Lower byte
            //if (Lb_n) async_data_out [7 : 0] = 8'bz;
            // Upper byte
            //if (Ub_n) async_data_out [15 : 8] = 8'bz;

            // Enable data out
            if (debug) $display ($time, "Enable async data_out_enable for Async Config Read");
            //async_data_out_enable =#tOE 1'b1;
            async_data_out_enable = 1'b1;

            async_config_enable = 1'b0;

            // Display debug message
            if (debug) $display ($time, " ns.  Note: Async - CONFIG Read, Addr = %h, Data = %h", latch_data_in_register, async_data_out);
        end

        // Read 
        else if (~Ce_n && (~Lb_n || ~Ub_n) && We_n && ~Oe_n && async_data_in_enable) begin
            if (debug) $display ($time, "Caught Async Read");

            // Lower byte
            case (Lb_n)
                1'b0    : async_data_out [7 : 0] = Bank0 [latch_data_in_register];
                default : async_data_out [7 : 0] = 8'bz;
            endcase

            // Upper byte
            case (Ub_n)
                1'b0    : async_data_out [15 : 8] = Bank1 [latch_data_in_register];
                default : async_data_out [15 : 8] = 8'bz;
            endcase

            // Enable data out
            if (debug) $display ($time, "Enable async data_out_enable for Async Read");
            //async_data_out_enable =#tOE 1'b1;
            async_data_out_enable = 1'b1;

            async_data_in_enable = 1'b0;

            // Display debug message
            if (debug) $display ($time, " ns.  Note: Async - Read, Addr = %h, Data = %h", latch_data_in_register, async_data_out);
        end

        // Initialize async access
        else if (~Ce_n && (~Lb_n || ~Ub_n) && ~ZZ_n && ~async_data_in_enable) begin
            // Display debug message
            if (debug) $display ($time, " ns.  Note: Async - Initiate Async Access");

            // Terminate Read
            async_data_out_enable = 1'b0;
            async_data_out = 16'bz;

            // Latch Data:
            latch_data_in_register = Addr;
            if (debug) $display ($time, " ns.  Latch data for config access=%h", latch_data_in_register);
            if (debug) $display ($time, " ns.  Async_addr_in=%h", Addr);

            async_data_in_enable = 1'b1;

        end

        // Write 
        else if (((~last_ce_n && Ce_n) || (~last_lb_n && Lb_n) || (~last_ub_n && Ub_n) || (~last_we_n && We_n)) && async_data_in_enable) begin
        //else if (0) begin
            // Lower Byte
            if (~last_lb_n && ~last_we_n) begin
                Bank0 [latch_data_in_register] = async_data_in [7 : 0];
                if (debug) $display ($time, 
                    " ns.  Note: Async - Write Bank0, Addr = %h, Data = %h", latch_data_in_register, async_data_in);
            end

            // Upper Byte
            if (~last_ub_n && ~last_we_n) begin
                Bank1 [latch_data_in_register] = async_data_in [15 : 8];
                if (debug) $display ($time, 
                    " ns.  Note: Async - Write Bank1, Addr = %h, Data = %h", latch_data_in_register, async_data_in);
            end


            async_data_in_enable = 1'b0;

        end

        // Initialize configuration register access
        else if (~Ce_n && Oe_n && ZZ_n && ~async_config_enable) begin
            // Display debug message
            if (debug) $display ($time, " ns.  Note: Async - Initiate Configuration Register Access");

            // Latch Data:
            latch_data_in_register = Addr;
            if (debug) $display ($time, " ns.  Latch data for config access=%h", latch_data_in_register);
            if (debug) $display ($time, " ns.  Async_addr_in=%h", Addr);

            // Init write burst
            async_config_enable = 1'b1;
        end

        // Write configuration register
        //if ((Ce_n ||  We_n || ~ZZ_n) && async_config_enable) begin
        else if (~Ce_n && ~We_n && async_config_enable) begin
            // BCR or RCR dependng on Addr[19]
            $display ("case for BSR RCR = 0x%d", async_addr_in[19] );
            case (latch_data_in_register[19])
                1'b0    : begin
                              ref_conf_register = latch_data_in_register;
                              $display ("  Programming Refresh Configuration Register");
                           end
                1'b1    : begin
                              bus_conf_register = latch_data_in_register;
                              $display ("  ERROR: Programming Bus Configuration Register");
                              $display ("  ERROR: THIS MODEL DOESNT DO BURST");
                           
                              // Bus Configuration Register error checking 
                              case (bus_conf_register[2:0])
                                 3'b001  : $display ("Param: Burst Length =  4 words");
                                 3'b010  : $display ("Param: Burst Length =  8 words");
                                 3'b011  : $display ("Param: Burst Length = 16 words");
                                 3'b111  : $display ("Param: Burst Length = continuous");  // default
                                 default : $display (" Error: Param: Burst Length used is not supported");
                              endcase
                  
                              case (bus_conf_register[3])
                                 1'b0    : $display ("Param: Burst Wrap = Wrap on ");
                                 1'b1    : $display ("Param: Burst Wrap = Wrap off ");  // default
                              endcase
                  
                              case (bus_conf_register[5:4])  // *CR1.0* Version here (no 1/2 drive)
                                 2'b00   : $display ("Param: Drive Strength= Full");  // default
                                 2'b10   : $display ("Param: Drive Strength= 1/4");  
                                 default : $display (" Error: Param: Drive Strength used is not supported");
                              endcase
                              
                              //case (bus_conf_register[6])
                                 //1'b0    :  begin 
                                                //$display (" Param: Delayed Burst WRITE disabled ");
                                            //end // do nothing
                                 //1'b1    :  begin 
                                                //$display (" Param: Delayed Burst WRITE enabled ");
                                            //end
                              //endcase

                              case (bus_conf_register[6])
                                 1'b0    :  begin 
                                                $display (" Error: Param: Clock Configuration: value not supported");
                                            end 
                                 1'b1    :  begin 
                                                $display (" Param: Clock Configuration: Rising edge");  // default
                                            end
                              endcase
                  
                              case (bus_conf_register[7])
                                 1'b0    :  begin end // do nothing
                                 default : $display (" Error: Param: Bus_Config_Reg[7] is resereved");
                              endcase
                  
                              case (bus_conf_register[8])
                                 1'b0    : $display ("Param: Wait Config = asserted during delay"); 
                                 1'b1    : $display ("Param: Wait Config = asserted one data cycle before delay ");  // default
                              endcase
                  
                              case (bus_conf_register[9])
                                 1'b0    :  begin end // do nothing
                                 default : $display (" Error: Param: Bus_Config_Reg[9] is resereved");
                              endcase
                  
                              case (bus_conf_register[10])
                                 1'b0    : $display ("Param: Wait Polarity = Active (low)"); 
                                 1'b1    : $display ("Param: Wait Polarity = Active (high)");  // default
                              endcase
                  
                              case (bus_conf_register[13:11])
                                 3'b010  : $display ("Param: Latency Counter =  Code 2");
                                 3'b011  : $display ("Param: Latency Counter =  Code 3");   // default
                                 default : $display (" Error: Param: Latency Counter = Value used is reserved");
                              endcase
                  
                              case (bus_conf_register[14])
                                 //1'b0    : $display ("Param: Initial Latency = Variable");  // default
                                 //1'b1    : $display ("Param: Initial Latency = Fixed");
                                 1'b0    :  begin end // do nothing
                                 default : $display (" Error: Param: BCR[14] Value used is reserved");
                              endcase
                  
                              case (bus_conf_register[15])
                                 1'b0    : $display ("ERROR: Param: Operating Mode = Syncronous burst access - This part cant do burst access");
                                 1'b1    : $display ("Param: Operating Mode = Asyncronous burst access");  //default
                              endcase
                  
                              case (bus_conf_register[18:16])
                                 3'b000  : begin end // do nothing
                                 default : $display (" Error: Param: Bus_Config_Reg[18:16] is resereved");
                              endcase
                  
                              case (bus_conf_register[19])
                                 1'b0    : $display ("Param: REG SELCT = RCR");
                                 1'b1    : $display ("Param: REG SELCT = BCR");
                              endcase
                  
                          end

                default  : $display ("   Error:  config_register reserved bits used [19]");
            endcase

            // Done configuration register write
            async_config_enable = 1'b0;

            // Display debug message
            if (debug) $display ($time, " ns.  Note: Async - Configuration Register Write Complete, Addr = %h", async_addr_in);
              // Refresh Configuration Register error checking
            case (partial_array_refresh [2:0])
               3'b000  : $display ("Param: Partial Array Refresh = Full array");  // default
               3'b001  : $display ("Param: Partial Array Refresh = Bottom 1/2 array");
               3'b010  : $display ("Param: Partial Array Refresh = Bottom 1/4 array");
               3'b011  : $display ("Param: Partial Array Refresh = Bottom 1/8 array");
               3'b100  : $display ("Param: Partial Array Refresh = None");
               3'b101  : $display ("Param: Partial Array Refresh = Top 1/2 array");
               3'b110  : $display ("Param: Partial Array Refresh = Top 1/4 array");
               3'b111  : $display ("Param: Partial Array Refresh = Top 1/8 array");
            endcase

            case (reserved_4)
               1'b0    : begin end // do nothing
               default : $display (" Error: Param: ref_conf_Reg[3] is resereved");
            endcase

            case (deep_power_down)
               1'b0    : $display ("Param: deep_power_down = ON");
               1'b1    : $display ("Param: deep_power_down = OFF");  // default
            endcase

            case (temp_comp_refresh [1:0])
               2'b00   : $display ("Param: temp comp refresh : Internal sensor");  // default
               2'b01   : $display ("Param: temp comp refresh : +45C");
               2'b10   : $display ("Param: temp comp refresh : +15C");
               2'b11   : $display ("Param: temp comp refresh : +85C");
            endcase

            case (page_mode)
               1'b0    : $display ("Param: page_mode = OFF");  // default
               1'b1    : $display ("Param: page_mode = ON");
            endcase

            case (reserved_6 [9:0])
               10'b0000000000 : begin end // do nothing
               default : $display (" Error: Param: ref_conf_Reg[17:8] is resereved");
            endcase
            case (register_select_RCR)
               1'b0   : $display ("Param: REG SELCT = RCR");
               1'b1   : $display ("ERROR: Param: REG SELCT = BCR");
            endcase

            end
        end
    end

    // System clock generator
    always @ (Clk) begin
       sys_clk =  Clk;
    end
    

    // Output buffer
    always @ (async_data_out) begin
        data_out = async_data_out;
    end

endmodule

