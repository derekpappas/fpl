                 ============================
                 =====     Read  Me     =====
                 ============================
*=============================================================
 * Verilog HDL Behavioral Modeling
 * 16M NT X32 SRAM : K7M163225A         
 * Copyright(c) Samsung Electronics, 2001
 * All rights reserved.
 *=============================================================
 
============================================================================

This is 16M NT X32 SRAM(K7M163225A) Verilog HDL Behavioral Modeling model 
under VERILOG-XL (CADENCE).
The version number of VERILOG-XL(CADENCE) is 2.6.19 .

The Speed Code Information :
	hc65 <== K7M163225A-HC65 (Frequency=7.5ns , Access Time=6.5ns)
	hc75 <== K7M163225A-HC75 (Frequency=8.5ns , Access Time=7.5ns)
	hc85 <== K7M163225A-HC85 (Frequency=10ns  , Access Time=8.5ns)

File List :
        k7m163225a_R01.v
        k7m163225a_test_R01.v (input file for speed code "hc65, hc75, hc85")
        k7m163225a_readme_R01.txt

Compiling method :
        verilog  +define+<speed_code>  <verilog input file>
        ex) verilog  +define+hc65  k7m163225a_R01.v  k7m163225a_test_R01.v

Input File Format :
##################################################################################
`timescale 1ns/1ps

/************************************************
 ****   16M NT RAM(K7M163225A, X32)          ****
 ****             INPUT TIMING VECTOR        ****
 ****                                        ****
 ****   SRAM DESIGN TEAM  : Byong-kwon, LEE  ****
 ************************************************/

module test;

    parameter                   add_bit = 19;
    parameter                   data_bit = 32;
    parameter                   full_clk  =  `tCYC   ;
    parameter                   half_clk  =  `tCYC/2  ;
    parameter                   qurd_clk  =  `tCYC/4  ;
    parameter                   hcycle  =  `tCYC/2 ;

reg	[add_bit-1:0] addr;
reg	web, clk, ckeb  ;
reg	adv,  oeb, cs1b, cs2, cs2b, zz, lbob;
reg	[data_bit-1:0] DQ_reg;
wire    [data_bit-1:0] DQ = DQ_reg ;

reg     bwa_n, bwb_n, bwc_n, bwd_n;

integer i;

K7M163225A NtRAM(.Addr(addr),
	.Bwa_n(bwa_n),
	.Bwb_n(bwb_n),
	.Bwc_n(bwc_n),
	.Bwd_n(bwd_n),
	.WEb(web),
	.CKEb(ckeb),
	.CS1b(cs1b),
	.CS2(cs2),
	.CS2b(cs2b),
	.CLK(clk),
	.ADV(adv),
	.Dq(DQ),
	.OEb(oeb),
	.ZZ(zz),
	.LBOb(lbob));


initial
	begin
	    $dumpvars;
            $dumpfile("K7M163225A.dump");
	end

initial
	begin                    // YOU must be setting for pow-up condition
            addr = {add_bit{1'bz}};
	    web = 0 ;
	    ckeb = 0 ;
	    lbob = 0 ;
            cs1b = 0 ;
            cs2 = 1 ;
            cs2b = 0 ;
            oeb = 0 ;
            zz = 0 ;
            adv = 1'bx ;
            clk = 1'b0;
            DQ_reg = {data_bit{1'bz}};
            bwa_n = 1 ;
            bwb_n = 1 ;
            bwc_n = 1 ;
            bwd_n = 1 ;
	end  

////////////////////////////////////
//    Internal NT SRAM Clock   //
////////////////////////////////////

always 
    begin
        #half_clk clk = ~clk;
    end

///////////////////////////////////////
          
task read_s; 		

         --------------------------------------------------
         --------------------------------------------------
         --------------------------------------------------
endtask

task cont_read; 		

         --------------------------------------------------
         --------------------------------------------------
         --------------------------------------------------
endtask

task write; 		

         --------------------------------------------------
         --------------------------------------------------
         --------------------------------------------------
endtask

task cont_write; 		

         --------------------------------------------------
         --------------------------------------------------
         --------------------------------------------------
endtask

task control; 		

         --------------------------------------------------
         --------------------------------------------------
         --------------------------------------------------
endtask

initial
    begin
         #full_clk ;
         #(half_clk -`tAS) ;
	 write (19'b1100011100011100101, 32'hf, 0, 0);
	 control(0, 0, 0, 0, 1, 0, 0, 0) ; 	// control (ckeb , zz, oeb, cs1b, cs2, cs2b, lbob, adv)

        	#full_clk ;

	 cont_write ( 32'h1f, 0, 0);
	 control(0, 0, 0, 0, 1, 0, 0, 0) ; 	// control (ckeb , zz, oeb, cs1b, cs2, cs2b, lbob, adv)

        	#full_clk ;

         --------------------------------------------------
         --------------------------------------------------
         --------------------------------------------------

         #full_clk ;
         #full_clk ;
	$finish;
    end

endmodule

##################################################################################

AC Parameter :


`ifdef hc65
	`define		tCYC		7.5		// Cycle Time
	`define		tCD		6.5		// Clock Acess Time 
	`define		tOE		3.5		// Output Enable to Data Valid
	`define		tLZC		2.5		// Clock High to Output Low-Z
	`define		tOH		2.5		// Output Hold from Clock High
	`define		tLZOE		0		// Output Enable Low to Output Low-Z
	`define		tHZOE		3.5		// Output Enable High to Output High-Z
	`define		tHZC		3.8		// Clock High to Output High-Z
	`define		tCH		2.5		// Clock High Pulse Width
	`define		tCL		2.5		// Clock Low Pulse Width
	`define		tAS		1.5		// Address Setup to Clock High
	`define		tCES		1.5		// CKE_B Setup to Clock High
	`define		tDS		1.5		// Data Setup to Clock High
	`define		tWS		1.5		// Write Setup to Clock High
	`define		tADVS		1.5		// Address Advance Setup to Clock High
	`define		tCSS		1.5		// Chip Select Setup to Clock High
	`define		tAH		0.5		// Address Hold from Clock High
	`define		tCEH		0.5		// CKE_B Hold from Clock High
	`define		tDH		0.5		// Data Hold from Clock High
	`define		tWH		0.5		// Write Hold from clock High
	`define		tADVH		0.5		// Address Advance Hold from Clock High
	`define		tCSH		0.5		// Chip SElect Hold from Clock High
	`define		tPDS		2		// ZZ High to Power Down
	`define		tPUS		2		// ZZ Low to Power Up 
`endif



`ifdef hc75
	`define		tCYC		8.5		// Cycle Time
	`define		tCD		7.5		// Clock Acess Time 
	`define		tOE		3.5		// Output Enable to Data Valid
	`define		tLZC		2.5		// Clock High to Output Low-Z
	`define		tOH		2.5		// Output Hold from Clock High
	`define		tLZOE		0		// Output Enable Low to Output Low-Z
	`define		tHZOE		3.5		// Output Enable High to Output High-Z
	`define		tHZC		4.0		// Clock High to Output High-Z
	`define		tCH		2.8		// Clock High Pulse Width
	`define		tCL		2.8		// Clock Low Pulse Width
	`define		tAS		2.0		// Address Setup to Clock High
	`define		tCES		2.0		// CKE_B Setup to Clock High
	`define		tDS		2.0		// Data Setup to Clock High
	`define		tWS		2.0		// Write Setup to Clock High
	`define		tADVS		2.0		// Address Advance Setup to Clock High
	`define		tCSS		2.0		// Chip Select Setup to Clock High
	`define		tAH		0.5		// Address Hold from Clock High
	`define		tCEH		0.5		// CKE_B Hold from Clock High
	`define		tDH		0.5		// Data Hold from Clock High
	`define		tWH		0.5		// Write Hold from clock High
	`define		tADVH		0.5		// Address Advance Hold from Clock High
	`define		tCSH		0.5		// Chip SElect Hold from Clock High
	`define		tPDS		2		// ZZ High to Power Down
	`define		tPUS		2		// ZZ Low to Power Up 
`endif



`ifdef hc85
	`define		tCYC		10 		// Cycle Time
	`define		tCD		8.5		// Clock Acess Time 
	`define		tOE		4.0		// Output Enable to Data Valid
	`define		tLZC		2.5		// Clock High to Output Low-Z
	`define		tOH		2.5		// Output Hold from Clock High
	`define		tLZOE		0		// Output Enable Low to Output Low-Z
	`define		tHZOE		4.0		// Output Enable High to Output High-Z
	`define		tHZC		5.0		// Clock High to Output High-Z
	`define		tCH		3.0		// Clock High Pulse Width
	`define		tCL		3.0		// Clock Low Pulse Width
	`define		tAS		2.0		// Address Setup to Clock High
	`define		tCES		2.0		// CKE_B Setup to Clock High
	`define		tDS		2.0		// Data Setup to Clock High
	`define		tWS		2.0		// Write Setup to Clock High
	`define		tADVS		2.0		// Address Advance Setup to Clock High
	`define		tCSS		2.0		// Chip Select Setup to Clock High
	`define		tAH		0.5		// Address Hold from Clock High
	`define		tCEH		0.5		// CKE_B Hold from Clock High
	`define		tDH		0.5		// Data Hold from Clock High
	`define		tWH		0.5		// Write Hold from clock High
	`define		tADVH		0.5		// Address Advance Hold from Clock High
	`define		tCSH		0.5		// Chip SElect Hold from Clock High
	`define		tPDS		2		// ZZ High to Power Down
	`define		tPUS		2		// ZZ Low to Power Up 
`endif
