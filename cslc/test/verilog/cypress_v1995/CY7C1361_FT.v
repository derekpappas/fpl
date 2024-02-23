/****************************************************************************************
*
*    File Name:  CY7C1361_FT.v
*      Version:  1.0
*         Date:  August 03, 2004
*        MODEl:  BUS Functional
*    Simulator:  Verilog XL (CADENCE)
*
*
*      Queries:  MPD Applications
*      Website:  www.cypress.com/support
*      Company:  Cypress Semiconductor
*       Part #:  CY7C1361_FT 
*
*  Description:  Cypress 9Mb Synburst SRAM (Flow-through)
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND CYPRESS SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*		 Copyright (c) Cypress Semiconductor
*                All rights reserved
*
* Rev    Date        Changes
* ---    ----------  ---------------------------------------
* 1.0    08/03/2004  - New Model
*                    - New Test Bench
*                    - New Test Vectors
*
****************************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 10ps

// Timings for Different Speed Bins (sb):	133MHz, 117MHz, 100MHz

`ifdef sb133
        `define         tCO           	6.5	// Data Output Valid After CLK Rise

        `define         tCYC           	7.5	// Clock cycle time
        `define         tCH         	3.0	// Clock HIGH time
        `define         tCL           	3.0	// Clock LOW time

        `define         tCHZ           	3.5	// Clock to High-Z
        `define         tCLZ           	0.0	// Clock to Low-Z

        `define         tOEHZ           3.5	// OE# HIGH to Output High-Z
        `define         tOELZ           0.0	// OE# LOW to Output Low-Z 
        `define         tOEV           	3.5	// OE# LOW to Output Valid 

        `define         tAS           	1.5	// Address Set-up Before CLK Rise
        `define         tADS           	1.5	// ADSC#, ADSP# Set-up Before CLK Rise
        `define         tADVS           1.5	// ADV# Set-up Before CLK Rise
        `define         tWES           	1.5	// BWx#, GW#, BWE# Set-up Before CLK Rise
        `define         tDS           	1.5	// Data Input Set-up Before CLK Rise
        `define         tCES           	1.5	// Chip Enable Set-up 

        `define         tAH           	0.5	// Address Hold After CLK Rise
        `define         tADH           	0.5	// ADSC#, ADSP# Hold After CLK Rise
        `define         tADVH           0.5	// ADV# Hold After CLK Rise
        `define         tWEH           	0.5	// BWx#, GW#, BWE# Hold After CLK Rise
        `define         tDH           	0.5	// Data Input Hold After CLK Rise
        `define         tCEH          	0.5	// Chip Enable Hold After CLK Rise
`endif

`ifdef sb117
        `define         tCO             7.5     // Data Output Valid After CLK Rise

        `define         tCYC            8.5     // Clock cycle time
        `define         tCH             3.2     // Clock HIGH time
        `define         tCL             3.2     // Clock LOW time

        `define         tCHZ            3.5     // Clock to High-Z
        `define         tCLZ            0.0     // Clock to Low-Z
        `define         tOEHZ           3.5     // OE# HIGH to Output High-Z
        `define         tOELZ           0.0     // OE# LOW to Output Low-Z 
        `define         tOEV            3.5     // OE# LOW to Output Valid

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
        `define         tCO             8.5	// Data Output Valid After CLK Rise

        `define         tCYC            10.0    // Clock cycle time
        `define         tCH             4.0     // Clock HIGH time
        `define         tCL             4.0     // Clock LOW time

        `define         tCHZ            3.5     // Clock to High-Z
        `define         tCLZ            0.0     // Clock to Low-Z
        `define         tOEHZ           3.5     // OE# HIGH to Output High-Z
        `define         tOELZ           0.0     // OE# LOW to Output Low-Z 
        `define         tOEV            3.5     // OE# LOW to Output Valid

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


module CY7C1361_FT (ZZ, MODE, ADDR, GW_N, BWE_N, BWd_N, BWc_N, BWb_N, BWa_N, CE1_N, CE2, CE3_N, ADSP_N, ADSC_N, ADV_N, OE_N, DQ, CLK);

    parameter                       addr_bits =     18;         //  18 bits
    parameter                       data_bits =     36;         //  36 bits
    parameter                       mem_sizes = 524288;         // 512K 

    inout     [(data_bits - 1) : 0] DQ;                         // Data IO
    input     [(addr_bits - 1) : 0] ADDR;                       // ADDRess
    input                           MODE;                       // Burst MODE
    input                           ADV_N;                      // Synchronous ADDRess Advance
    input                           CLK;                        // Clock
    input                           ADSC_N;                     // Synchronous ADDRess Status Controller
    input                           ADSP_N;                     // Synchronous ADDRess Status Processor
    input                           BWa_N;                      // Synchronous Byte Write Enables
    input                           BWb_N;                      // Synchronous Byte Write Enables
    input                           BWc_N;                      // Synchronous Byte Write Enables
    input                           BWd_N;                      // Synchronous Byte Write Enables
    input                           BWE_N;                      // Byte Write Enable
    input                           GW_N;                       // Global Write
    input                           CE1_N;                       // Synchronous Chip Enable
    input                           CE2;                        // Synchronous Chip Enable
    input                           CE3_N;                      // Synchronous Chip Enable
    input                           OE_N;                       // Output Enable
    input                           ZZ;                         // Snooze MODE

    reg [((data_bits / 4) - 1) : 0] bank0 [0 : mem_sizes];      // Memory Bank 0
    reg [((data_bits / 4) - 1) : 0] bank1 [0 : mem_sizes];      // Memory Bank 1
    reg [((data_bits / 4) - 1) : 0] bank2 [0 : mem_sizes];      // Memory Bank 2
    reg [((data_bits / 4) - 1) : 0] bank3 [0 : mem_sizes];      // Memory Bank 3

    reg       [(data_bits - 1) : 0] din;                        // Data In
    reg       [(data_bits - 1) : 0] dout;                       // Data Out

    reg       [(addr_bits - 1) : 0] addr_reg_in;                // ADDRess Register In
    reg       [(addr_bits - 1) : 0] addr_reg_out;               // ADDRess Register Out
    reg                     [1 : 0] bcount;                     // 2-bit Burst Counter
    reg                     [1 : 0] first_addr;                     // 2-bit Burst Counter

    reg                             ce_reg;
    reg                             Read_reg;
    reg                             WrN_reg;
    reg                             ADSP_N_o;
    reg                             bwa_reg;
    reg                             bwb_reg;
    reg                             bwc_reg;
    reg                             bwd_reg;
    reg                             Sys_clk;
    reg                             test;
    reg                             pcsr_write;
    reg                             ctlr_write;
    reg                             latch_addr_current;
    reg                             latch_addr_old;

    wire                            ce      = (~CE1_N & CE2 & ~CE3_N);
    wire                            Write_n   = ~(((~BWa_N | ~BWb_N | ~BWc_N | ~BWd_N) & ~BWE_N) | ~GW_N ) ; 
    wire                            Read   = (((BWa_N & BWb_N & BWc_N & BWd_N) & ~BWE_N) | (GW_N & BWE_N) | (~ADSP_N & ce)) ;

    wire                            bwa_n   = ~(~Write_n & (~GW_N | (~BWE_N & ~BWa_N )));		
    wire                            bwb_n   = ~(~Write_n & (~GW_N | (~BWE_N & ~BWb_N )));		
    wire                            bwc_n   = ~(~Write_n & (~GW_N | (~BWE_N & ~BWc_N )));		
    wire                            bwd_n   = ~(~Write_n & (~GW_N | (~BWE_N & ~BWd_N )));		

    wire                            latch_addr     = (~ADSC_N | (~ADSP_N & ~CE1_N));

    wire       #`tOEHZ 			OeN_HZ     = OE_N ? 1 : 0;
    wire       #`tOEV 			OeN_DataValid     = ~OE_N ? 0 : 1;
    wire       OeN_efct     = 		~OE_N ? OeN_DataValid : OeN_HZ;

    wire       #`tCHZ 			WR_HZ     = WrN_reg ? 1 : 0;
    wire       #`tCLZ 			WR_LZ     = ~WrN_reg ? 0 : 1;
    wire       WR_efct     = 		~WrN_reg ? WR_LZ : WR_HZ;

    wire       #`tCHZ			CE_HZ     = ~ce_reg ? 0 : 1 ;
    wire       #`tCLZ			CE_LZ     = ce_reg ? 1 : 0 ;
    wire       CeN_efct     = 		ce_reg ? CE_LZ : CE_HZ ;

    wire       #`tCHZ			RD_HZ     = ~Read_reg ? 0 : 1 ;
    wire       #`tCLZ			RD_LZ     = Read_reg ? 1 : 0 ;
    wire       RD_efct     = 		Read_reg ? CE_LZ : CE_HZ ;


    // Initialize
    initial begin
        ce_reg = 1'b0;
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

        if (Read === 1'bX) Read_reg = 1'b0;
        else Read_reg = Read;

        if (Read_reg == 1'b1) begin

		pcsr_write     = 1'b0;
		ctlr_write     = 1'b0;
	end

	// Write Register

       	if (Write_n === 1'bX) WrN_reg = 1'b1;
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

		if (~MODE & ~ADV_N & ~latch_addr) 	// Linear Burst
        		bcount = (bcount + 1);         	// Advance Counter	

		else if (MODE & ~ADV_N & ~latch_addr) 	// Interleaved Burst
		begin
			if (first_addr % 2 == 0)
        			bcount = (bcount + 1);         // Increment Counter
			else if (first_addr % 2 == 1)
        			bcount = (bcount - 1);         // Decrement Counter 
		end

        // Output ADDRess
        addr_reg_out = {addr_reg_in [(addr_bits - 1) : 2], bcount[1], bcount[0]};

        // Byte Write Register    
        bwa_reg = ~bwa_n;
        bwb_reg = ~bwb_n;
        bwc_reg = ~bwc_n;
        bwd_reg = ~bwd_n;

	
        // Enable Register
        if (latch_addr) begin 
		ce_reg = ce;
	end


        // Input Register
        if (ce_reg & (~bwa_n | ~bwb_n | ~bwc_n | ~bwd_n) & (pcsr_write | ctlr_write)) begin
            din = DQ;
        end

        // Byte Write Driver
        if (ce_reg & bwa_reg) begin
            bank0 [addr_reg_out] = din [ 8 :  0];
        end
        if (ce_reg & bwb_reg) begin
            bank1 [addr_reg_out] = din [17 :  9];
        end
        if (ce_reg & bwc_reg) begin
            bank2 [addr_reg_out] = din [26 : 18];
        end
        if (ce_reg & bwd_reg) begin
            bank3 [addr_reg_out] = din [35 : 27];
        end

        // Output Registers

        if (~Write_n | ce_reg == 1'b0) 
            dout [ 35 :  0] = #`tCHZ 36'bZ;

        else if (Read_reg == 1'b1) begin
            dout [ 8 :  0] <= #`tCO bank0 [addr_reg_out];
            dout [17 :  9] <= #`tCO bank1 [addr_reg_out];
            dout [26 : 18] <= #`tCO bank2 [addr_reg_out];
            dout [35 : 27] <= #`tCO bank3 [addr_reg_out];

        end

    end


    // Output Buffers

    assign DQ =  (~OeN_efct & ~ZZ & CeN_efct & RD_efct & WR_efct) ? dout : 36'bz;


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
        	$setuphold  (posedge CLK, BWc_N,  `tWES,   `tWEH);
        	$setuphold  (posedge CLK, BWd_N,  `tWES,   `tWEH);
        	$setuphold  (posedge CLK, BWE_N,  `tWES,   `tWEH);
        	$setuphold  (posedge CLK, GW_N,   `tWES,   `tWEH);
        	$setuphold  (posedge CLK, CE1_N,  `tCES,  `tCEH);
        	$setuphold  (posedge CLK, CE2,    `tCES,  `tCEH);
        	$setuphold  (posedge CLK, CE3_N,  `tCES,  `tCEH);
        	$setuphold  (posedge CLK, ADV_N,  `tADVS,  `tADVH);
                       
	endspecify

endmodule

