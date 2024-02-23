// +----------------------------------------------------------------+
// |            Copyright (c) 1994 Stanford University.             |
// |                      All Rights Reserved.                      |
// |                                                                |
// |   This software is distributed with *ABSOLUTELY NO SUPPORT*    |
// |   and *NO WARRANTY*.   Use or reproduction of this code for    |
// |   commerical gains is strictly prohibited.   Otherwise, you    |
// |   are given permission to use or modify this code as long      |
// |   as you do not remove this notice.                            |
// +----------------------------------------------------------------+
//
//  Title: 	Verilog Waves File
//  Created:	Thu Mar 24 15:15:24 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  waves.v,v 7.9 1995/06/10 01:53:27 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: 
//
`include "torch.h"

module waves();

initial begin
`ifdef WAVES
    if(!$test$plusargs("nowaves")) begin
   	$gr_position("waves", 0, 0, 890, 700);     // what I suggest
	$gr_waves(
	    "Phi1",	`PROCESSOR.Phi1,
	    "Phi2",	`PROCESSOR.Phi2
	);
	$gr_addwaves(
	    "AInstr",	`PROCESSOR.AInstr_s2r,
	    "BInstr",	`PROCESSOR.BInstr_s2r,
	    "ASBus",	`PROCESSOR.ASBus_s1e,
	    "ATBus",	`PROCESSOR.ATBus_s1e,
	    "BSBus",	`PROCESSOR.BSBus_s1e,
	    "BTBus",	`PROCESSOR.BTBus_s1e,
	    "ARes",	`PROCESSOR.AResultBus_v2e,
	    "BRes",	`PROCESSOR.BResultBus_v2e,
	    "Membus",	`PROCESSOR.MemBus_v2m,
	    "PCBus",	`PROCESSOR.InstrAddr_s2i,
	    "RegPC",	`PROCESSOR.RegPC_s1e,
	    "ImmPC",	`PROCESSOR.ImmPC_s1e,
	    "BEQ",	`PROCESSOR.BEQnext_s1e,
	    "BNE",	`PROCESSOR.BNEnext_s1e,
	    "BLEZ",	`PROCESSOR.BLEZnext_s1e,
	    "BGTZ",	`PROCESSOR.BGTZnext_s1e,
	    "BLTZ",	`PROCESSOR.BLTZnext_s1e,
	    "BGEZ",	`PROCESSOR.BGEZnext_s1e
	);

//`include "ldstoWaves.v"
`include "regFileWaves.v"
`include "regTorchWaves.v"
`include "ALUWaves.v"
`include "instrFetchWaves.v"
`include "exceptionWaves.v"
`include "tlbWaves.v"
`include "extIntWaves.v"
`include "extWorldWaves.v"
`include "tlbExtIntWaves.v"
    end
`endif

    if ($test$plusargs("navsim")) begin
	$dumpvars;
    end

    if (!$test$plusargs("noregs")) begin
`include "TestCodeWaves.v"	
    end

    if ($test$plusargs("mini")) begin
	#10000
	$display("%c]50;nil2%c", 8'h1b, 8'h07);
    end
end

endmodule				 // waves
