/****************************************************************************************
*
*    File Name:  CY7C1327F_PL_SCD.v
*      Version:  2.0
*         Date:  January 29th, 2004
*        Model:  BUS Functional
*    Simulator:  Verilog-XL (CADENCE) 
*
*
*       Author:  RKF
*        Email:  mpd_apps@cypress.com
*      Company:  Cypress Semiconductor
*       Part #:  CY7C1327F (256K x 18)
*
*  Description:  Cypress 4Mb Synburst SRAM (Pipelined SCD)
*
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND CYPRESS SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*	Copyright(c) Cypress Semiconductor, 2004
*	All rights reserved
*
* Rev  Author          Date        Changes
* ---  --------------  ----------  ---------------------------------------
* 2.0  RKF             01/29/2004  - New Model
*                                  - New Test Bench
*                                  - New Test Vectors
*
****************************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 10ps

// Timings for Different Speed Bins (sb):	250MHz, 225MHz, 200MHz, 167MHz, 133MHz


`ifdef sb250
        `define         tCO           	2.6	// Data Output Valid After CLK Rise

        `define         tCYC           	4.0	// Clock cycle time
        `define         tCH         	1.7	// Clock HIGH time
        `define         tCL           	1.7	// Clock LOW time

        `define         tCHZ           	2.6	// Clock to High-Z
        `define         tCLZ           	0.0	// Clock to Low-Z
        `define         tEOHZ           2.6	// OE# HIGH to Output High-Z
        `define         tEOLZ           0.0	// OE# LOW to Output Low-Z 
        `define         tEOV           	2.6	// OE# LOW to Output Valid 

        `define         tAS           	0.8	// Address Set-up Before CLK Rise
        `define         tADS           	0.8	// ADSC#, ADSP# Set-up Before CLK Rise
        `define         tADVS           0.8	// ADV# Set-up Before CLK Rise
        `define         tWES           	0.8	// BWx#, GW#, BWE# Set-up Before CLK Rise
        `define         tDS           	0.8	// Data Input Set-up Before CLK Rise
        `define         tCES           	0.8	// Chip Enable Set-up 

        `define         tAH           	0.4	// Address Hold After CLK Rise
        `define         tADH           	0.4	// ADSC#, ADSP# Hold After CLK Rise
        `define         tADVH           0.4	// ADV# Hold After CLK Rise
        `define         tWEH           	0.4	// BWx#, GW#, BWE# Hold After CLK Rise
        `define         tDH           	0.4	// Data Input Hold After CLK Rise
        `define         tCEH          	0.4	// Chip Enable Hold After CLK Rise
`endif

`ifdef sb225
        `define         tCO             2.6     // Data Output Valid After CLK Rise

        `define         tCYC            4.4     // Clock cycle time
        `define         tCH             2.0     // Clock HIGH time
        `define         tCL             2.0     // Clock LOW time

        `define         tCHZ            2.6     // Clock to High-Z
        `define         tCLZ            0.0     // Clock to Low-Z
        `define         tEOHZ           2.6     // OE# HIGH to Output High-Z
        `define         tEOLZ           0.0     // OE# LOW to Output Low-Z 
        `define         tEOV            2.6     // OE# LOW to Output Valid

        `define         tAS             1.2     // Address Set-up Before CLK Rise
        `define         tADS            1.2     // ADSC#, ADSP# Set-up Before CLK Rise
        `define         tADVS           1.2     // ADV# Set-up Before CLK Rise
        `define         tWES            1.2     // BWx#, GW#, BWE# Set-up Before CLK Rise
        `define         tDS             1.2     // Data Input Set-up Before CLK Rise
        `define         tCES            1.2     // Chip Enable Set-up

        `define         tAH             0.5     // Address Hold After CLK Rise
        `define         tADH            0.5     // ADSC#, ADSP# Hold After CLK Rise
        `define         tADVH           0.5     // ADV# Hold After CLK Rise
        `define         tWEH            0.5     // BWx#, GW#, BWE# Hold After CLK Rise
        `define         tDH             0.5     // Data Input Hold After CLK Rise
        `define         tCEH            0.5     // Chip Enable Hold After CLK Rise
`endif

`ifdef sb200
        `define         tCO             2.8	// Data Output Valid After CLK Rise

        `define         tCYC            5.0    // Clock cycle time
        `define         tCH             2.0     // Clock HIGH time
        `define         tCL             2.0     // Clock LOW time

        `define         tCHZ            2.8     // Clock to High-Z
        `define         tCLZ            0.0     // Clock to Low-Z
        `define         tEOHZ           2.8     // OE# HIGH to Output High-Z
        `define         tEOLZ           0.0     // OE# LOW to Output Low-Z 
        `define         tEOV            2.8     // OE# LOW to Output Valid

        `define         tAS             1.4     // Address Set-up Before CLK Rise
        `define         tADS            1.4     // ADSC#, ADSP# Set-up Before CLK Rise
        `define         tADVS           1.4     // ADV# Set-up Before CLK Rise
        `define         tWES            1.4     // BWx#, GW#, BWE# Set-up Before CLK Rise
        `define         tDS             1.4     // Data Input Set-up Before CLK Rise
        `define         tCES            1.4     // Chip Enable Set-up

        `define         tAH             0.4     // Address Hold After CLK Rise
        `define         tADH            0.4     // ADSC#, ADSP# Hold After CLK Rise
        `define         tADVH           0.4     // ADV# Hold After CLK Rise
        `define         tWEH            0.4     // BWx#, GW#, BWE# Hold After CLK Rise
        `define         tDH             0.4     // Data Input Hold After CLK Rise
        `define         tCEH            0.4     // Chip Enable Hold After CLK Rise
`endif

`ifdef sb166
        `define         tCO             3.5	// Data Output Valid After CLK Rise

        `define         tCYC            6.0    // Clock cycle time
        `define         tCH             2.5     // Clock HIGH time
        `define         tCL             2.5     // Clock LOW time

        `define         tCHZ            3.5     // Clock to High-Z
        `define         tCLZ            0.0     // Clock to Low-Z
        `define         tEOHZ           3.5     // OE# HIGH to Output High-Z
        `define         tEOLZ           0.0     // OE# LOW to Output Low-Z 
        `define         tEOV            3.5     // OE# LOW to Output Valid

        `define         tAS             1.5     // Address Set-up Before CLK Rise
        `define         tADS            1.5     // ADSC#, ADSP# Set-up Before CLK Rise
        `define         tADVS           1.5     // ADV# Set-up Before CLK Rise
        `define         tWES            1.5     // BWx#, GW#, BWE# Set-up Before CLK Rise
        `define         tDS             1.5     // Data Input Set-up Before CLK Rise
        `define         tCES            1.5     // Chip Enable Set-up

        `define         tAH             0.5     // Address Hold After CLK Rise
        `define         tADH            0.5     // ADSC#, ADSP# Hold After CLK Rise
        `define         tADVH           0.5     // ADV# Hold After CLK Rise
        `define         tWEH            0.5     // BWx#, GW#, BWE# Hold After CLK Rise
        `define         tDH             0.5     // Data Input Hold After CLK Rise
        `define         tCEH            0.5     // Chip Enable Hold After CLK Rise
`endif

`ifdef sb133
        `define         tCO             4.0     // Data Output Valid After CLK Rise

        `define         tCYC            7.5    // Clock cycle time
        `define         tCH             3.0     // Clock HIGH time
        `define         tCL             3.0     // Clock LOW time

        `define         tCHZ            4.0     // Clock to High-Z
        `define         tCLZ            0.0     // Clock to Low-Z
        `define         tEOHZ           4.0     // OE# HIGH to Output High-Z
        `define         tEOLZ           0.0     // OE# LOW to Output Low-Z
        `define         tEOV            4.5     // OE# LOW to Output Valid

        `define         tAS             1.5     // Address Set-up Before CLK Rise
        `define         tADS            1.5     // ADSC#, ADSP# Set-up Before CLK Rise
        `define         tADVS           1.5     // ADV# Set-up Before CLK Rise
        `define         tWES            1.5     // BWx#, GW#, BWE# Set-up Before CLK Rise
        `define         tDS             1.5     // Data Input Set-up Before CLK Rise
        `define         tCES            1.5     // Chip Enable Set-up

        `define         tAH             0.5     // Address Hold After CLK Rise
        `define         tADH            0.5     // ADSC#, ADSP# Hold After CLK Rise
        `define         tADVH           0.5     // ADV# Hold After CLK Rise
        `define         tWEH            0.5     // BWx#, GW#, BWE# Hold After CLK Rise
        `define         tDH             0.5     // Data Input Hold After CLK Rise
        `define         tCEH            0.5     // Chip Enable Hold After CLK Rise
`endif

`ifdef sb100
        `define         tCO             4.5     // Data Output Valid After CLK Rise

        `define         tCYC            10.0   // Clock cycle time
        `define         tCH             3.5     // Clock HIGH time
        `define         tCL             3.5     // Clock LOW time

        `define         tCHZ            4.5     // Clock to High-Z
        `define         tCLZ            0.0     // Clock to Low-Z
        `define         tEOHZ           4.5     // OE# HIGH to Output High-Z
        `define         tEOLZ           0.0     // OE# LOW to Output Low-Z
        `define         tEOV            4.5     // OE# LOW to Output Valid

        `define         tAS             1.5     // Address Set-up Before CLK Rise
        `define         tADS            1.5     // ADSC#, ADSP# Set-up Before CLK Rise
        `define         tADVS           1.5     // ADV# Set-up Before CLK Rise
        `define         tWES            1.5     // BWx#, GW#, BWE# Set-up Before CLK Rise
        `define         tDS             1.5     // Data Input Set-up Before CLK Rise
        `define         tCES            1.5     // Chip Enable Set-up

        `define         tAH             0.5     // Address Hold After CLK Rise
        `define         tADH            0.5     // ADSC#, ADSP# Hold After CLK Rise
        `define         tADVH           0.5     // ADV# Hold After CLK Rise
        `define         tWEH            0.5     // BWx#, GW#, BWE# Hold After CLK Rise
        `define         tDH             0.5     // Data Input Hold After CLK Rise
        `define         tCEH            0.5     // Chip Enable Hold After CLK Rise
`endif


module CY7C1327F_PLSCD (ZZ, Mode, ADDR, GW_N, BWE_N, BWb_N, BWa_N, CE1_N, CE2, CE3_N, ADSP_N, ADSC_N, ADV_N, OE_N, DQ, CLK);

    parameter                       addr_bits =     18;         //  	18 bits
    parameter                       data_bits =     18;         //  	18 bits
    parameter                       mem_sizes = 262144;         // 	256K

    inout     [(data_bits - 1) : 0] DQ;                         // Data IO
    input     [(addr_bits - 1) : 0] ADDR;                       // ADDRess
    input                           Mode;                       // Burst Mode
    input                           ADV_N;                      // Synchronous ADDRess Advance
    input                           CLK;                        // Clock
    input                           ADSC_N;                     // Synchronous ADDRess Status Controller
    input                           ADSP_N;                     // Synchronous ADDRess Status Processor
    input                           BWa_N;                      // Synchronous Byte Write Enables
    input                           BWb_N;                      // Synchronous Byte Write Enables
    input                           BWE_N;                      // Byte Write Enable
    input                           GW_N;                       // Global Write
    input                           CE1_N;                       // Synchronous Chip Enable
    input                           CE2;                        // Synchronous Chip Enable
    input                           CE3_N;                      // Synchronous Chip Enable
    input                           OE_N;                       // Output Enable
    input                           ZZ;                         // Snooze Mode

    reg [((data_bits / 2) - 1) : 0] bank0 [0 : mem_sizes];      // Memory Bank 0
    reg [((data_bits / 2) - 1) : 0] bank1 [0 : mem_sizes];      // Memory Bank 1

    reg       [(data_bits - 1) : 0] din;                        // Data In
    reg       [(data_bits - 1) : 0] dout;                       // Data Out

    reg       [(addr_bits - 1) : 0] addr_reg_in;                // ADDRess Register In
    reg       [(addr_bits - 1) : 0] addr_reg_read;                // ADDRess Register for Read
    reg       [(addr_bits - 1) : 0] addr_reg_write;               // ADDRess Register for Write
    reg                     [1 : 0] bcount;                     // 2-bit Burst Counter
    reg                     [1 : 0] first_addr;                     // 2-bit Burst Counter

    reg                             ce_reg;
    reg                             Read_reg;
    reg                             Read_reg_o;
    reg                             WrN_reg;
    reg                             ADSP_N_o;
    reg                             pipe_reg;
    reg                             bwa_reg;
    reg                             bwb_reg;
    reg                             Sys_clk;
    reg                             test;
    reg                             pcsr_write;
    reg                             ctlr_write;
    reg                             latch_addr_current;
    reg                             latch_addr_old;
    
    wire                            ce      = (~CE1_N & CE2 & ~CE3_N);
    wire                            Write_n   = ~(((~BWa_N | ~BWb_N ) & ~BWE_N) | ~GW_N ) ; 
    wire                            Read   = (((BWa_N & BWb_N ) & ~BWE_N) | (GW_N & BWE_N) | (~ADSP_N & ce)) ;

    wire                            bwa_n   = ~(~Write_n & (~GW_N | (~BWE_N & ~BWa_N )));		
    wire                            bwb_n   = ~(~Write_n & (~GW_N | (~BWE_N & ~BWb_N )));		

    wire                            latch_addr     = (~ADSC_N | (~ADSP_N & ~CE1_N));


    wire       #`tEOHZ 			OeN_HZ     = OE_N ? 1 : 0;
    wire       #`tEOV 			OeN_DataValid     = ~OE_N ? 0 : 1;
    wire       OeN_efct     = 		~OE_N ? OeN_DataValid : OeN_HZ;

    wire       #`tCHZ 			WR_HZ     = WrN_reg ? 1 : 0;
    wire       #`tCLZ 			WR_LZ     = ~WrN_reg ? 0 : 1;
    wire       WR_efct     = 		~WrN_reg ? WR_LZ : WR_HZ;

    wire       #`tCHZ			CE_HZ     = (~ce_reg | ~pipe_reg) ? 0 : 1 ;
    wire       #`tCLZ			CE_LZ     = pipe_reg ? 1 : 0 ;
    wire       Pipe_efct     = 		(ce_reg & pipe_reg) ? CE_LZ : CE_HZ ;

    wire       #`tCHZ			RD_HZ     = ~Read_reg_o ? 0 : 1 ;
    wire       #`tCLZ			RD_LZ     = Read_reg_o ? 1 : 0 ;
    wire       RD_efct     = 		Read_reg_o ? CE_LZ : CE_HZ ;


    // Initialize
    initial begin
        ce_reg = 1'b0;
        pipe_reg = 1'b0;
        Sys_clk = 1'b0;
        $timeformat (-9, 1, " ns", 10);                         // Format time unit
    end

    // System Clock Decode
    always begin
        @ (posedge CLK) begin
            Sys_clk = ~ZZ;
        end
        @ (negedge CLK) begin
            Sys_clk = 1'b0;
        end
    end

    always @ (posedge Sys_clk) begin

	// Read Register

        if (~Write_n) Read_reg_o = 1'b0;
        else Read_reg_o = Read_reg;

        if (~Write_n) Read_reg = 1'b0;
	else Read_reg = Read;


        if (Read_reg == 1'b1) begin

		pcsr_write     = 1'b0;
		ctlr_write     = 1'b0;
	end

	// Write Register

       	if (Read_reg_o == 1'b1)	WrN_reg = 1'b1;
       	else WrN_reg = Write_n;

	latch_addr_old = latch_addr_current;
	latch_addr_current = latch_addr;

        if (latch_addr_old == 1'b1 & ~Write_n & ADSP_N_o == 1'b0)
			pcsr_write     = 1'b1; //Ctlr Write = 0; Pcsr Write = 1;

        else if (latch_addr_current == 1'b1 & ~Write_n  & ADSP_N & ~ADSC_N)
			ctlr_write     = 1'b1; //Ctlr Write = 0; Pcsr Write = 1;

        // ADDRess Register
        if (latch_addr) 
		begin
			addr_reg_in = ADDR;
        		bcount = ADDR [1 : 0]; 
        		first_addr = ADDR [1 : 0]; 

		end

        // ADSP_N Previous-Cycle Register
        ADSP_N_o <= ADSP_N;

        // Binary Counter and Logic

		if (~Mode & ~ADV_N & ~latch_addr) 	// Linear Burst
        		bcount = (bcount + 1);         	// Advance Counter	

		else if (Mode & ~ADV_N & ~latch_addr) 	// Interleaved Burst
		begin
			if (first_addr % 2 == 0)
        			bcount = (bcount + 1);         // Increment Counter
			else if (first_addr % 2 == 1)
        			bcount = (bcount - 1);         // Decrement Counter 
		end

        // Read ADDRess
        addr_reg_read = addr_reg_write;


        // Write ADDRess
        addr_reg_write = {addr_reg_in [(addr_bits - 1) : 2], bcount[1], bcount[0]};

        // Byte Write Register    
        bwa_reg = ~bwa_n;
        bwb_reg = ~bwb_n;

        // Enable Register
        pipe_reg = ce_reg;
	
        // Enable Register
        if (latch_addr) ce_reg = ce;

        // Input Register
        if (ce_reg & (~bwa_n | ~bwb_n ) & (pcsr_write | ctlr_write)) begin
            din = DQ;
        end

        // Byte Write Driver
        if (ce_reg & bwa_reg) begin
            bank0 [addr_reg_write] = din [ 8 :  0];
        end
        if (ce_reg & bwb_reg) begin
            bank1 [addr_reg_write] = din [17 :  9];
        end

        // Output Registers

        if (~Write_n | pipe_reg == 1'b0) 
            dout [ 17 :  0] <= #`tCHZ 18'bZ;

        else if (Read_reg_o == 1'b1) begin
            dout [ 8 :  0] <= #`tCO bank0 [addr_reg_read];
            dout [17 :  9] <= #`tCO bank1 [addr_reg_read];
        end

    end

    // Output Buffers
    assign DQ =  (~OE_N & ~ZZ & Pipe_efct & RD_efct & WR_efct) ? dout : 18'bz;


    // Timing Check 
    specify
        $width      (negedge CLK, `tCL);
        $width      (posedge CLK, `tCH);
        $period     (negedge CLK, `tCYC);
        $period     (posedge CLK, `tCYC);
        $setuphold  (posedge CLK, ADSP_N, `tADS, `tADH);
        $setuphold  (posedge CLK, ADSC_N, `tADS, `tADH);
        $setuphold  (posedge CLK, ADDR,   `tAS,   `tAH);
        $setuphold  (posedge CLK, BWa_N,  `tWES,   `tWEH);
        $setuphold  (posedge CLK, BWb_N,  `tWES,   `tWEH);
        $setuphold  (posedge CLK, BWE_N,  `tWES,   `tWEH);
        $setuphold  (posedge CLK, GW_N,   `tWES,   `tWEH);
        $setuphold  (posedge CLK, CE1_N,   `tCES,  `tCEH);
        $setuphold  (posedge CLK, CE2,    `tCES,  `tCEH);
        $setuphold  (posedge CLK, CE3_N,  `tCES,  `tCEH);
        $setuphold  (posedge CLK, ADV_N,  `tADVS,  `tADVH);
    endspecify                        

endmodule

