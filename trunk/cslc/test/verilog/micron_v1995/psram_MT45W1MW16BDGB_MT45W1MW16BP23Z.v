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
*  Part Number:  mt45w1mw16bdgb and mt45w1mw16bp23z
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
*
*
**************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USES "PS" RESOLUTION
`timescale 1ns / 1ps

module model_verilog (
              Addr, 
              Adv_n, 
              Ce_n, 
              Clk, 
              Cre, 
              Dq, 
              Lb_n, 
              Oe_n, 
              oWait, 
              Ub_n,
              We_n 
              ); 

`include "parameters_MT45W1MW16BDGB_MT45W1MW16BP23Z.v"

    // Display debug message
//    parameter debug          =    1;
//    
//    // Port declarations
//    inout     [data_bits - 1 : 0] Dq;
//    output                        oWait; // Wait is a keyword in HDL
//    input                         Clk;
//    input     [addr_bits - 1 : 0] Addr;
//    input                         Ce_n;
//    input                         We_n;
//    input                         Adv_n;
//    input                         Oe_n;
//    input                         Cre;
//    input                         Ub_n;
//    input                         Lb_n;
//
//    // Memory arrays
//    reg                   [7 : 0] Bank0 [0 : mem_sizes];
//    reg                   [7 : 0] Bank1 [0 : mem_sizes];
//
//    // System registers
//    reg                           sys_clk, sys_reset;
//
//    // Asynchronous registers
//    reg                           async_data_out_enable;
//    reg                           async_config_enable;
//    reg                           async_data_enable;
//    reg       [addr_bits - 1 : 0] async_addr_in;
//    reg       [data_bits - 1 : 0] async_data_in;
//    reg       [data_bits - 1 : 0] async_data_out;
//
//    // Synchronous registers
//    reg                           sync_data_in_enable;
//    reg                           sync_data_out_enable;
//    reg       [addr_bits - 1 : 0] sync_addr_in;
//    reg       [data_bits - 1 : 0] sync_data_out;
//    reg                           bwait, rwait;
//    reg                           lb_reg, ub_reg;
//    integer                       counter;
//
//    // Continuous row end delay
//    reg                           row_start;
//    reg                           row_end;
//    reg                           row_wait;
//    integer                       row_count;
//
//    // Refresh Collision
//    time                          ref_collision;
//
//    // Output register
//    reg       [data_bits - 1 : 0] data_out;
//
//    // Latency counter pipeline
//    // 00 = Write, 01 = Read, 10 = Mode, 11 = don't care
//    reg                   [1 : 0] latency_counter_pipeline [0 : 13];
//   
//    // Flags 
//    reg                           gender_neutral_initial_burst;
//
//    reg  [addr_bits-1:0] latch_data_in_register;
//    // Bus Configuration Register
//    reg  [addr_bits-1:0] bus_conf_register;
//    wire           [2:0] burst_length           = bus_conf_register [2:0];
//    wire                 burst_wrap             = bus_conf_register [3];
//    wire           [1:0] drive_strength         = bus_conf_register [5:4];
//    wire                 delayed_write          = bus_conf_register [6]; 
//    wire                 reserved_1             = bus_conf_register [7];
//    wire                 wait_configuration     = bus_conf_register [8];   
//    wire                 hold_data_out          = bus_conf_register [9];
//    wire                 wait_polarity          = bus_conf_register [10];
//    wire           [2:0] latency_counter        = bus_conf_register [13:11];
//    wire                 initial_latency        = bus_conf_register [14];
//    wire                 operating_mode         = bus_conf_register [15]; 
//    wire           [2:0] reserved_2             = bus_conf_register [18:16];
//    wire                 register_select_BCR    = bus_conf_register [19];
//
//    // Refresh Configuration Register
//    reg  [addr_bits-1:0] ref_conf_register;
//    wire           [2:0] partial_array_refresh  = ref_conf_register [2:0];
//    wire                 reserved_4             = ref_conf_register [3];
//    wire                 deep_power_down        = ref_conf_register [4];
//    wire           [1:0] temp_comp_refresh      = ref_conf_register [6:5];
//    wire                 page_mode              = ref_conf_register [7];
//    wire           [9:0] reserved_6             = ref_conf_register [17:8];
//    wire                 register_select_RCR    = ref_conf_register [19];
//
//
//    // Device ID Register READ ONLY
//    reg  [addr_bits-1:0] didr_conf_register = 0;
//    reg            [4:0] vendor_ID              = 5'b00011;    // Micron
//    reg            [2:0] generation             = 3'b010;      // 010= *CR1.5*
//    reg            [2:0] density                = 3'b011;      // 128Mb
//    reg            [3:0] version                = 4'b0100;     // arbitary
//
//    // Internal wires
//    wire #1 last_adv_n = Adv_n;
//    wire #1 last_ce_n  = Ce_n;
//    wire #1 last_we_n  = We_n;
//    wire #1 last_lb_n  = Lb_n;
//    wire #1 last_ub_n  = Ub_n;
//    wire #1 last_cre   = Cre;
//
//    // Wait buffer
//    assign  oWait = bwait;
//
//    // Output buffer
//    assign Dq = (sync_data_out_enable || async_data_out_enable) ? data_out : 16'bz;
//    //assign #tACLK Dq = (~Ce_n && ~Oe_n && (sync_data_out_enable || async_data_out_enable)) ? data_out : 16'bz;
//
//    // Initial condition
//    initial begin
//        sys_clk = 1'b0;
//        sys_reset = 1'b0;
//        async_data_out = 16'bz;
//        async_data_out_enable = 1'b0;
//        async_config_enable = 1'b0;
//        async_data_enable = 1'b0;
//        sync_data_out = 16'bz;
//        sync_data_in_enable = 1'b0;
//        sync_data_out_enable = 1'b0;
//        row_end = 1'b0;
//        bwait = 1'bz;
//        rwait = 1'bz;
//        ref_collision = 0;
//        //  BUS CONF REGISTER   9_876 5 4 321 0 9 8 7 6 5_4 3 210 
//        bus_conf_register = 20'b1_000_1_0_011_1_0_1_0_1_0_0_1_111;   //Default powerup values
//        latch_data_in_register = 23'hzzzzzz;
//        //  REF CONF REGISTER   9_87654321098 7 65 4 3 210 
//        ref_conf_register = 20'b0_00000000000_0_00_1_0_000;   //Default powerup values
//        //didr_conf_register = {version, density, generation, vendor_ID};
//        gender_neutral_initial_burst <= 1'b0;
//    end
//
//    // Asynchronous Wait signal
//    always @ (posedge Ce_n or negedge Ce_n) begin
//        $display("Edge detected on ce_n");
//        if (~Ce_n) begin
//            if (debug) $display ($time, "  oWait Trigger1");
//            rwait = wait_polarity;
//        end else begin
//            if (debug) $display ($time, "  oWait Trigger2");
//            if (Adv_n == 1'b0) begin
//               rwait = 1'bx;
//            end else begin
//               rwait = 1'bz;
//            end
//            sync_data_out = 16'bz;
//            sync_data_in_enable = 1'b0;
//            sync_data_out_enable = 1'b0;
//        end
//    end
//
//    // Asynchronous data latch
//    always @ (Dq) begin
//        $display("Asynchronous data latch");
//        async_data_in <= #1 Dq;
//    end
//
//    // Asynchronous address latch
//    always @ (Adv_n or Addr) begin
//        $display("Asynchronous address latch");
//        if (~last_adv_n && Adv_n) begin
//            async_addr_in <= #1 Addr;
//        end else if (~Adv_n) begin
//            async_addr_in <= #1 Addr;
//        end
//    end
//
//    // Main Asynchronous block
//    always @ (Addr or Ce_n or We_n or Oe_n or Lb_n or Ub_n or Adv_n or sys_reset) begin
//        $display("Main Asynchronous Block");
//        if (sys_reset) begin
//            async_data_out_enable = 1'b0;
//            async_config_enable = 1'b0;
//            async_data_enable = 1'b0;
//            async_data_out = 16'bz;
//        end else begin
//            // Read Burst (done)
//            if (~last_ce_n && Ce_n && async_data_out_enable) begin
//                async_data_out_enable = #tHZ 1'b0;
//                async_data_out = 16'bz;
//            end
//            
//        // Config Read 
//        //else if (~Adv_n && ~Ce_n && (~Lb_n || ~Ub_n) && We_n && Cre && async_config_enable) begin
//        else if (~Ce_n && We_n && ~Oe_n  && async_config_enable) begin
//            if (debug) $display ($time, "Caught Async Config Read");
//
//            case (latch_data_in_register[19])
//                1'b0    : begin
//                               async_data_out = ref_conf_register;  // 00 = RCR
//                               if (debug) $display ($time, "   RCR read, RCR=%h", ref_conf_register);
//                           end
//                1'b1    : begin
//                               async_data_out = bus_conf_register;  // 10 = BCR
//                               if (debug) $display ($time, "   BCR read, BCR=%h", bus_conf_register);
//                           end
//                default  : begin
//                               async_data_out = {data_bits{1'bx}};
//                               if (debug) $display ($time, "   Error: while reading conf regs ADDR[19] not valid");
//                           end
//            endcase
//
//            // Lower byte
//            //if (Lb_n) async_data_out [7 : 0] = 8'bz;
//            // Upper byte
//            //if (Ub_n) async_data_out [15 : 8] = 8'bz;
//
//            // Enable data out
//            if (debug) $display ($time, "Enable async data_out_enable for Async Config Read");
//            //async_data_out_enable =#tOE 1'b1;
//            async_data_out_enable = 1'b1;
//
//            async_config_enable = 1'b0;
//
//            // Display debug message
//            if (debug) $display ($time, " ns.  Note: Async - CONFIG Read, Addr = %h, Data = %h", latch_data_in_register, async_data_out);
//        end
//
//        // Read Burst
//        //else if ((~Adv_n && ~Ce_n && (~Lb_n || ~Ub_n) && We_n && ~Cre) || (~last_adv_n && Adv_n && async_data_out_enable)) begin
//        else if (~Ce_n && (~Lb_n || ~Ub_n) && We_n && ~Oe_n && async_data_enable) begin
//            if (debug) $display ($time, "Caught Async Read");
//
//            // Lower byte
//            case (Lb_n)
//                1'b0    : async_data_out [7 : 0] = Bank0 [latch_data_in_register];
//                default : async_data_out [7 : 0] = 8'bz;
//            endcase
//
//            // Upper byte
//            case (Ub_n)
//                1'b0    : async_data_out [15 : 8] = Bank1 [latch_data_in_register];
//                default : async_data_out [15 : 8] = 8'bz;
//            endcase
//
//            // Enable data out
//            if (debug) $display ($time, "Enable async data_out_enable for Async Read");
//            //async_data_out_enable =#tOE 1'b1;
//            async_data_out_enable = 1'b1;
//
//            async_data_enable = 1'b0;
//
//            // Display debug message
//            if (debug) $display ($time, " ns.  Note: Async - Read, Addr = %h, Data = %h", latch_data_in_register, async_data_out);
//        end
//
//        // Initialize async access
//        else if (~Adv_n && ~Ce_n && (~Lb_n || ~Ub_n) && ~Cre && ~async_data_enable) begin
//            // Display debug message
//            if (debug) $display ($time, " ns.  Note: Async - Initiate Async Access");
//
//            // Terminate Read
//            async_data_out_enable = 1'b0;
//            async_data_out = 16'bz;
//
//            // Latch Data:
//            latch_data_in_register = Addr;
//            if (debug) $display ($time, " ns.  Latch data for config access=%h", latch_data_in_register);
//            if (debug) $display ($time, " ns.  Async_addr_in=%h", Addr);
//
//            async_data_enable = 1'b1;
//
//        end
//
//        // Write burst
//        else if (((~last_ce_n && Ce_n) || (~last_lb_n && Lb_n) || (~last_ub_n && Ub_n) || (~last_we_n && We_n)) && async_data_enable) begin
//            // Lower Byte
//            if (~Lb_n) begin
//                Bank0 [async_addr_in] = async_data_in [7 : 0];
//            end
//
//            // Upper Byte
//            if (~Ub_n) begin
//                Bank1 [async_addr_in] = async_data_in [15 : 8];
//            end
//
//            // Display debug message
//            if (debug) $display ($time, 
//                " ns.  Note: Async - Write, Addr = %h, Data = %h",
//                async_addr_in, async_data_in);
//
//            async_data_enable = 1'b0;
//
//        end
//
//        // Initialize configuration register access
//        else if (~Adv_n && ~Ce_n && Oe_n && Cre && ~async_config_enable) begin
//            // Display debug message
//            if (debug) $display ($time, " ns.  Note: Async - Initiate Configuration Register Access");
//
//            // Latch Data:
//            latch_data_in_register = Addr;
//            if (debug) $display ($time, " ns.  Latch data for config access=%h", latch_data_in_register);
//            if (debug) $display ($time, " ns.  Async_addr_in=%h", Addr);
//
//            // Init write burst
//            async_config_enable = 1'b1;
//        end
//
//        // Write configuration register
//        //if ((Ce_n ||  We_n || ~Cre) && async_config_enable) begin
//        else if (~Ce_n && ~We_n && async_config_enable) begin
//            // BCR or RCR dependng on Addr[19]
//            $display ("case for BSR RCR = 0x%d", async_addr_in[19] );
//            case (latch_data_in_register[19])
//                1'b0    : begin
//                              ref_conf_register = latch_data_in_register;
//                              $display ("  Programming Refresh Configuration Register");
//                           end
//                1'b1    : begin
//                              bus_conf_register = latch_data_in_register;
//                              $display ("  Programming Bus Configuration Register");
//                           
//                              // Bus Configuration Register error checking 
//                              case (bus_conf_register[2:0])
//                                 3'b001  : $display ("Param: Burst Length =  4 words");
//                                 3'b010  : $display ("Param: Burst Length =  8 words");
//                                 3'b011  : $display ("Param: Burst Length = 16 words");
//                                 3'b111  : $display ("Param: Burst Length = continuous");  // default
//                                 default : $display (" Error: Param: Burst Length used is not supported");
//                              endcase
//                  
//                              case (bus_conf_register[3])
//                                 1'b0    : $display ("Param: Burst Wrap = Wrap on ");
//                                 1'b1    : $display ("Param: Burst Wrap = Wrap off ");  // default
//                              endcase
//                  
//                              case (bus_conf_register[5:4])  // *CR1.0* Version here (no 1/2 drive)
//                                 2'b00   : $display ("Param: Drive Strength= Full");  // default
//                                 2'b10   : $display ("Param: Drive Strength= 1/4");  
//                                 default : $display (" Error: Param: Drive Strength used is not supported");
//                              endcase
//                              
//                              //case (bus_conf_register[6])
//                                 //1'b0    :  begin 
//                                                //$display (" Param: Delayed Burst WRITE disabled ");
//                                            //end // do nothing
//                                 //1'b1    :  begin 
//                                                //$display (" Param: Delayed Burst WRITE enabled ");
//                                            //end
//                              //endcase
//
//                              case (bus_conf_register[6])
//                                 1'b0    :  begin 
//                                                $display (" Error: Param: Clock Configuration: value not supported");
//                                            end 
//                                 1'b1    :  begin 
//                                                $display (" Param: Clock Configuration: Rising edge");  // default
//                                            end
//                              endcase
//                  
//                              case (bus_conf_register[7])
//                                 1'b0    :  begin end // do nothing
//                                 default : $display (" Error: Param: Bus_Config_Reg[7] is resereved");
//                              endcase
//                  
//                              case (bus_conf_register[8])
//                                 1'b0    : $display ("Param: Wait Config = asserted during delay"); 
//                                 1'b1    : $display ("Param: Wait Config = asserted one data cycle before delay ");  // default
//                              endcase
//                  
//                              case (bus_conf_register[9])
//                                 1'b0    :  begin end // do nothing
//                                 default : $display (" Error: Param: Bus_Config_Reg[9] is resereved");
//                              endcase
//                  
//                              case (bus_conf_register[10])
//                                 1'b0    : $display ("Param: Wait Polarity = Active (low)"); 
//                                 1'b1    : $display ("Param: Wait Polarity = Active (high)");  // default
//                              endcase
//                  
//                              case (bus_conf_register[13:11])
//                                 3'b010  : $display ("Param: Latency Counter =  Code 2");
//                                 3'b011  : $display ("Param: Latency Counter =  Code 3");   // default
//                                 default : $display (" Error: Param: Latency Counter = Value used is reserved");
//                              endcase
//                  
//                              case (bus_conf_register[14])
//                                 //1'b0    : $display ("Param: Initial Latency = Variable");  // default
//                                 //1'b1    : $display ("Param: Initial Latency = Fixed");
//                                 1'b0    :  begin end // do nothing
//                                 default : $display (" Error: Param: BCR[14] Value used is reserved");
//                              endcase
//                  
//                              case (bus_conf_register[15])
//                                 1'b0    : $display ("Param: Operating Mode = Syncronous burst access");
//                                 1'b1    : $display ("Param: Operating Mode = Asyncronous burst access");  //default
//                              endcase
//                  
//                              case (bus_conf_register[18:16])
//                                 3'b000  : begin end // do nothing
//                                 default : $display (" Error: Param: Bus_Config_Reg[18:16] is resereved");
//                              endcase
//                  
//                              case (bus_conf_register[19])
//                                 1'b0    : $display ("Param: REG SELCT = RCR");
//                                 1'b1    : $display ("Param: REG SELCT = BCR");
//                              endcase
//                  
//                          end
//
//                default  : $display ("   Error:  config_register reserved bits used [19]");
//            endcase
//
//            // Done configuration register write
//            async_config_enable = 1'b0;
//
//            // Display debug message
//            if (debug) $display ($time, " ns.  Note: Async - Configuration Register Write Complete, Addr = %h", async_addr_in);
//              // Refresh Configuration Register error checking
//            case (partial_array_refresh [2:0])
//               3'b000  : $display ("Param: Partial Array Refresh = Full array");  // default
//               3'b001  : $display ("Param: Partial Array Refresh = Bottom 1/2 array");
//               3'b010  : $display ("Param: Partial Array Refresh = Bottom 1/4 array");
//               3'b011  : $display ("Param: Partial Array Refresh = Bottom 1/8 array");
//               3'b100  : $display ("Param: Partial Array Refresh = None");
//               3'b101  : $display ("Param: Partial Array Refresh = Top 1/2 array");
//               3'b110  : $display ("Param: Partial Array Refresh = Top 1/4 array");
//               3'b111  : $display ("Param: Partial Array Refresh = Top 1/8 array");
//            endcase
//
//            case (reserved_4)
//               1'b0    : begin end // do nothing
//               default : $display (" Error: Param: ref_conf_Reg[3] is resereved");
//            endcase
//
//            case (deep_power_down)
//               1'b0    : $display ("Param: deep_power_down = ON");
//               1'b1    : $display ("Param: deep_power_down = OFF");  // default
//            endcase
//
//            case (temp_comp_refresh [1:0])
//               2'b00   : $display ("Param: temp comp refresh : Internal sensor");  // default
//               2'b01   : $display ("Param: temp comp refresh : +45C");
//               2'b10   : $display ("Param: temp comp refresh : +15C");
//               2'b11   : $display ("Param: temp comp refresh : +85C");
//            endcase
//
//            case (page_mode)
//               1'b0    : $display ("Param: page_mode = OFF");  // default
//               1'b1    : $display ("Param: page_mode = ON");
//            endcase
//
//            case (reserved_6 [9:0])
//               10'b0000000000 : begin end // do nothing
//               default : $display (" Error: Param: ref_conf_Reg[17:8] is resereved");
//            endcase
//            case (register_select_RCR)
//               1'b0   : $display ("Param: REG SELCT = RCR");
//               1'b1   : $display ("Param: REG SELCT = BCR");
//               default : $display (" Error: Param: REG SELCT value used is resereved");
//            endcase
//
//            end
//        end
//    end
//
//    // Synchronous internal command pipeline
//    task synchronous_internal_command_pipeline;
//        integer counter;
//    begin
//        $display("synchronous_internal_command_pipeline");
//        // Latency counter pipeline
//        for (counter = 0; counter < 13; counter = counter + 1) begin
//            latency_counter_pipeline[counter] = latency_counter_pipeline[counter+1];
//        end
//        
//        latency_counter_pipeline [13] = 2'b11;
//
//        // Internal command ready
//        case (latency_counter_pipeline [0])
//            2'b00 : sync_data_in_enable = 1'b1;
//            2'b01 : sync_data_out_enable = 1'b1;
//        endcase
//    end
//    endtask
//
//    // Synchronous gender neutral burst
//    task synchronous_gender_neutral_burst;
//    begin
//        $display("synchronous_gender_neutral_pipeline");
//        //if (~Adv_n && ~Ce_n &&  We_n && ~Cre && (~Lb_n || ~Ub_n)) begin // synchronous_internal_burst_read
//        //if (~Adv_n && ~Ce_n && ~We_n && ~Cre && Oe_n) begin             // synchronous_initial_burst_write
//        //if (~Adv_n && ~Ce_n && ~We_n &&  Cre && Oe_n) begin             // synchronous_configuration_register
//
//          if (~Adv_n && ~Ce_n) begin   // gender neutral
//             gender_neutral_initial_burst <= 1'b1;
//          end
//    end
//    endtask
//
//    // Synchronous initial burst read delayed
//    task synchronous_initial_burst_read_delayed;
//        integer random_delay;
//    begin
//        $display("synchronous_internal_burst_read");
//        if (~Ce_n && We_n && ~Cre && (~Lb_n || ~Ub_n)) begin
//            // Initialize random delay
//            random_delay = 0;
//            
//            // Clear row crossing with a new access
//            if (row_end == 1'b1) begin
//                row_end = 1'b0;
//            end
//            
//            // This should only be evaluated when in variable latency mode.
//            // Random refresh cycle collision generator
//            if (~initial_latency & (($time - ref_collision) >= tCEM)) begin
//                ref_collision = $time;
//                random_delay = latency_counter;
//
//                if (debug) $display ($time, 
//                " ns. Note: Synch - Initialize Read, Wait = %d",random_delay);
//            end
//
//            // Set wait state
//            if (debug) $display ($time, "  oWait Trigger3");
//            rwait = wait_polarity;
//
//            // Latch address
//            sync_addr_in = Addr;
//
//            // Reset counter
//            counter = 0;
//
//            // Register byte write
//            lb_reg = Lb_n;
//            ub_reg = Ub_n;
//
//// should be different for variable and fixed
//            // Latency counter
//            case (latency_counter)
//                3'b010 : latency_counter_pipeline [2 + random_delay] = 2'b01;
//                3'b011 : latency_counter_pipeline [3 + random_delay] = 2'b01;
//                3'b100 : latency_counter_pipeline [4 + random_delay] = 2'b01;
//                3'b101 : latency_counter_pipeline [5 + random_delay] = 2'b01;
//                3'b110 : latency_counter_pipeline [6 + random_delay] = 2'b01;
//            endcase
//
//            // Display debug message
//            if (debug) $display ($time,
//                " ns.  Note: Synch - Initialize Read, Addr = %h",Addr);
//        end
//    gender_neutral_initial_burst <= 1'b0;
//    end
//    endtask
//
//
//    // Synchronous initial burst read
//    task synchronous_initial_burst_read;
//        integer random_delay;
//    begin
//        $display("synchronous_internal_burst_read");
//        if (~Adv_n && ~Ce_n && We_n && ~Cre && (~Lb_n || ~Ub_n)) begin
//            // Initialize random delay
//            random_delay = 0;
//            
//            // Clear row crossing with a new access
//            if (row_end == 1'b1) begin
//                row_end = 1'b0;
//            end
//            
//            // This should only be evaluated when in variable latency mode.
//            // Random refresh cycle collision generator
//            if (~initial_latency & (($time - ref_collision) >= tCEM)) begin
//                ref_collision = $time;
//                random_delay = latency_counter;
//
//                if (debug) $display ($time, 
//                " ns. Note: Synch - Initialize Read, Wait = %d",random_delay);
//            end
//
//            // Set wait state
//            if (debug) $display ($time, "  oWait Trigger3");
//            rwait = wait_polarity;
//
//            // Latch address
//            sync_addr_in = Addr;
//
//            // Reset counter
//            counter = 0;
//
//            // Register byte write
//            lb_reg = Lb_n;
//            ub_reg = Ub_n;
//
//// should be different for variable and fixed
//            // Latency counter
//            case (latency_counter)
//                3'b010 : latency_counter_pipeline [2 + random_delay] = 2'b01;
//                3'b011 : latency_counter_pipeline [3 + random_delay] = 2'b01;
//                3'b100 : latency_counter_pipeline [4 + random_delay] = 2'b01;
//                3'b101 : latency_counter_pipeline [5 + random_delay] = 2'b01;
//                3'b110 : latency_counter_pipeline [6 + random_delay] = 2'b01;
//            endcase
//
//            // Display debug message
//            if (debug) $display ($time,
//                " ns.  Note: Synch - Initialize Read, Addr = %h",Addr);
//        end
//    gender_neutral_initial_burst <= 1'b0;
//    end
//    endtask
//
//    // Synchronous initial burst writ delayed
//    task synchronous_initial_burst_write_delayed;
//        integer random_delay;
//    begin
//        $display("synchronous_initial_burst_write");
//        if (~Ce_n && Oe_n && ~We_n && ~Cre) begin
//            // Initialize random delay
//            random_delay = 0;
//
//            // Clear row crossing with a new access
//            if (row_end == 1'b1) begin
//                row_end = 1'b0;
//            end
//
//            // CR1.5 writes are always fixed latency
//            // CR1.0 has variable latency during initial writes
//            `ifdef CR10
//                // Random refresh cycle collision generator
//                if (($time - ref_collision) >= tCEM) begin
//                    ref_collision = $time;
//                    random_delay = latency_counter;
//                    if (debug) $display ($time, " ns.  Note: Sync - Initialize Write, Wait fixed latency, thus always zero = %d",random_delay);
//                end
//            `endif
//
//            // Set wait state
//            if (debug) $display ($time, "  oWait Trigger4");
//            rwait = wait_polarity;
//
//            // Latch address
//            sync_addr_in = Addr;
//            row_start = Addr[7];
//
//            // Reset counter
//            counter = 0;
//
//            // Latency counter
//            case (latency_counter)
//                3'b010 : latency_counter_pipeline [3 + random_delay] = 2'b00;
//                3'b011 : latency_counter_pipeline [4 + random_delay] = 2'b00;
//                3'b100 : latency_counter_pipeline [5 + random_delay] = 2'b00;
//                3'b101 : latency_counter_pipeline [6 + random_delay] = 2'b00;
//                3'b110 : latency_counter_pipeline [7 + random_delay] = 2'b00;
//            endcase
//
//            // Display debug message
//            if (debug) $display ($time, 
//                " ns.  Note: Sync - Initialize Write, Addr = %h", Addr);
//        end
//    gender_neutral_initial_burst <= 1'b0;
//    end
//    endtask
//
//
//    // Synchronous initial burst write
//    task synchronous_initial_burst_write;
//        integer random_delay;
//    begin
//        $display("synchronous_initial_burst_write");
//        if (~Adv_n && ~Ce_n && Oe_n && ~We_n && ~Cre) begin
//            // Initialize random delay
//            random_delay = 0;
//
//            // Clear row crossing with a new access
//            if (row_end == 1'b1) begin
//                row_end = 1'b0;
//            end
//
//            // CR1.5 writes are always fixed latency
//            // CR1.0 has variable latency during initial writes
//            `ifdef CR10
//                // Random refresh cycle collision generator
//                if (($time - ref_collision) >= tCEM) begin
//                    ref_collision = $time;
//                    random_delay = latency_counter;
//                    if (debug) $display ($time, " ns.  Note: 
//                       Sync - Initialize Write, Wait fixed 
//                       latency, thus always zero = %d",random_delay);
//                end
//            `endif
//
//            // Set wait state
//            if (debug) $display ($time, "  oWait Trigger4");
//            rwait = wait_polarity;
//
//            // Latch address
//            sync_addr_in = Addr;
//            row_start = Addr[7];
//
//            // Reset counter
//            counter = 0;
//
//            // Latency counter
//            case (latency_counter)
//                3'b010 : latency_counter_pipeline [3 + random_delay] = 2'b00;
//                3'b011 : latency_counter_pipeline [4 + random_delay] = 2'b00;
//                3'b100 : latency_counter_pipeline [5 + random_delay] = 2'b00;
//                3'b101 : latency_counter_pipeline [6 + random_delay] = 2'b00;
//                3'b110 : latency_counter_pipeline [7 + random_delay] = 2'b00;
//            endcase
//
//            // Display debug message
//            if (debug) $display ($time, 
//                " ns.  Note: Sync - Initialize Write, Addr = %h", Addr);
//        end
//    gender_neutral_initial_burst <= 1'b0;
//    end
//    endtask
//
//    // Synchronous configuration register
//    task synchronous_configuration_register;
//        begin
//        $display("synchronous_configuration_register");
//            if (~Adv_n && ~Ce_n && Oe_n && ~We_n && Cre) begin
//                // Set wait state
//            if (debug) $display ($time, "  oWait Trigger5");
//                rwait = wait_polarity;
//
//                // Latency counter
//                case (latency_counter)
//                    3'b010 : latency_counter_pipeline [3] = 2'b10;
//                    3'b011 : latency_counter_pipeline [4] = 2'b10;
//                    3'b100 : latency_counter_pipeline [5] = 2'b10;
//                    3'b101 : latency_counter_pipeline [6] = 2'b10;
//                    3'b110 : latency_counter_pipeline [7] = 2'b10;
//                endcase
//
//                // Write configuration register
//                if (Addr [19]) begin
//                    bus_conf_register = Addr;
//                end else begin
//                    ref_conf_register = Addr;
//                end
//
//                // Display debug message
//                if (debug) $display ($time, 
//                " ns.  Note: Sync - Configuration Register Write, Addr = %h",
//                Addr);
//            end
//        end
//    endtask
//
//    // Synchronous wait controller
//    task synchronous_wait_controller;
//        begin
//            $display("synchronous_wait_controller");
//            if (~wait_configuration) begin
//                if ((latency_counter_pipeline [1] === 2'b00) ||
//                    (latency_counter_pipeline [0] === 2'b01) ||
//                    (latency_counter_pipeline [1] === 2'b10)) begin
//                    if (debug) $display ($time, "  oWait Trigger6");
//                    rwait = ~wait_polarity;
//                end
//            end else begin
//                if ((latency_counter_pipeline [2] === 2'b00) ||
//                    (latency_counter_pipeline [1] === 2'b01) ||
//                    (latency_counter_pipeline [2] === 2'b10)) begin
//                    if (debug) $display ($time, "  oWait Trigger7");
//                    rwait = ~rwait;
//                end
//            end
//        end
//    endtask
//
//    // Synchronous CE# termination
    task synchronous_ce_termination;
        begin
            $display("synchronous_ce_termination");
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
                    if (debug) $display ($time, "  oWait Trigger8");
                rwait = 1'bz;
            end
            if (Adv_n==1'b0) begin
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
                //    if (debug) $display ($time, "  oWait Trigger8");
                //rwait = 1'bz;
            end
        end
    endtask

    // Synchronous read burst
    task synchronous_read_burst;
        begin
            $display("synchronous_read_burst");
            if (sync_data_out_enable === 1'b1 && row_end === 1'b0) begin
                // Set Wait
                    if (debug) $display ($time, "  oWait Trigger9");
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

                // Advance counter
                counter = counter + 1;

                // Register new byte write
                if (counter >= 1) begin
                    lb_reg = Lb_n;
                    ub_reg = Ub_n;
                end

                // Terminate write depending on burst length
                if (((counter >  4) && (burst_length === 3'b001)) ||
                    ((counter >  8) && (burst_length === 3'b010)) ||
                    ((counter > 16) && (burst_length === 3'b011)) ||
                    ((counter > 32) && (burst_length === 3'b100))) begin
                    sync_data_out_enable = 1'b0;
                end

                // Display debug message
                if (~lb_reg && ~ub_reg && sync_data_out_enable) begin
                    if (debug) 
                       $display ($time, " ns.  ** Note: Sync - Read, Addr = %h, Data = %h", sync_addr_in, sync_data_out);
                end

                // Advance address
                if (burst_wrap === 1'b0) begin
                    // Wrap within the burst length
                    case (burst_length)
                        3'b001  : sync_addr_in [1 : 0] = sync_addr_in [1 : 0] + 1;
                        3'b010  : sync_addr_in [2 : 0] = sync_addr_in [2 : 0] + 1;
                        3'b011  : sync_addr_in [3 : 0] = sync_addr_in [3 : 0] + 1;
                        3'b100  : sync_addr_in [4 : 0] = sync_addr_in [4 : 0] + 1;
                        default : sync_addr_in         = sync_addr_in         + 1;
                    endcase
                end else begin
                    // Row end
                    if ((sync_data_out_enable === 1'b1) &&
                        (sync_addr_in [6 : 0] === 127) && 
                        (burst_wrap === 1'b1)) begin
                        if (wait_configuration) begin
                            if (debug) $display ($time, "  oWait Trigger10");
                            rwait = wait_polarity;
                        end
                        row_end = 1'b1;
                        row_count = latency_counter;
                    end

                    // Burst no wrap
                    sync_addr_in = sync_addr_in + 1;
                end

            end else if (sync_data_out_enable === 1'b1 && row_end === 1'b1) begin
                sync_data_out = 16'bz;
                if (debug) $display ($time, "  oWait Trigger11");
                rwait = wait_polarity;
                row_count = row_count - 1;

                if (row_count <= 0) begin
                    if (wait_configuration) begin
                        if (debug) $display ($time, "  oWait Trigger12");
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
            $display("synchronous_write_burst");
            if (sync_data_in_enable && (wait_polarity === ~oWait) && 
                (row_end === 1'b0)) begin
                // Lower Byte
                if (~Lb_n) begin
                    Bank0 [sync_addr_in] = Dq [7 : 0];
                end

                // Upper Byte
                if (~Ub_n) begin
                    Bank1 [sync_addr_in] = Dq [15 : 8];
                end

                // Display debug message
                if (debug && (~Lb_n || ~Ub_n)) $display ($time, 
                    " ns.  ## Note: Sync - Write, Addr = %h, Data = %h", 
                    sync_addr_in, Dq);

                // Advance address
                if (burst_wrap === 1'b0) begin
                    // Wrap within the burst length
                    case (burst_length)
                        3'b001  : sync_addr_in [1 : 0] = sync_addr_in [1 : 0] + 1;
                        3'b010  : sync_addr_in [2 : 0] = sync_addr_in [2 : 0] + 1;
                        3'b011  : sync_addr_in [3 : 0] = sync_addr_in [3 : 0] + 1;
                        3'b100  : sync_addr_in [4 : 0] = sync_addr_in [4 : 0] + 1;
                        default : sync_addr_in         = sync_addr_in         + 1;
                    endcase
                end else begin
                    // Row end
                    if ((sync_data_in_enable === 1'b1) &&
                        (sync_addr_in [6 : 0] === 127) && 
                        (burst_wrap === 1'b1)) begin
                        if (wait_configuration) begin
                            if (debug) $display ($time, "  oWait Trigger13");
                            rwait = wait_polarity;
                        end
                        row_end = 1'b1;
                        row_count = latency_counter;
                    end

                    // Burst no wrap
                    sync_addr_in = sync_addr_in + 1;
                end
                // Row end
                //if (row_start !== sync_addr_in [7]) begin
                    //row_start = sync_addr_in [7];
                    //row_end = 1'b1;
                    //rwait = wait_polarity;
                    //row_count = latency_counter;
                    //$display ($time, " ns.  Note: Sync - Write - End of Row Detected");
                //end

                // Advance address
                //sync_addr_in = sync_addr_in + 1;

            end else if (sync_data_in_enable === 1'b1 && row_end === 1'b1) begin
                sync_data_out = 16'bz;
                if (debug) $display ($time, "  oWait Trigger14");
                rwait = wait_polarity;
                row_count = row_count - 1;

                if (row_count <= 0) begin
                    row_end = 1'b0;
                    if (debug) $display ($time, "  oWait Trigger15");
                    rwait = ~wait_polarity;
                end
            end
        end
    endtask

    // Main Synchronous block
    always @ (posedge sys_clk) begin
            if (~operating_mode) begin   // Sync
                $display ("Main Synchronous Block");

       	 	synchronous_internal_command_pipeline;

                if (delayed_write && initial_latency) begin
                   if (~gender_neutral_initial_burst) begin
        	      synchronous_gender_neutral_burst;
                   end else begin
        	      synchronous_initial_burst_read_delayed;
        	      synchronous_initial_burst_write_delayed;
                   end
                end else begin
        	   synchronous_initial_burst_read;
        	   synchronous_initial_burst_write;
                end

        	synchronous_configuration_register;

        	synchronous_wait_controller;

        	synchronous_ce_termination;

        	synchronous_read_burst;

        	synchronous_write_burst;
	end

        sys_reset = ~Ce_n;
    end

    // System clock generator
    always @ (Clk) begin
       sys_clk =  Clk;
    end
    
    // Wait buffer
    always @ (rwait) begin
        bwait <= #tCEW rwait;
        //bwait <= rwait;
    end

    // Output buffer
    always @ (async_data_out or sync_data_out) begin
        case (sys_reset)
            1'b0    : data_out = async_data_out;
            default : data_out = sync_data_out;
        endcase
    end

endmodule

