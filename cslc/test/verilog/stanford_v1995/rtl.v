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
//  Title: 	Signals for RTL-Spreadsheet
//  Created:	Sun Aug  7 17:39:52 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma.Stanford.EDU>
//
//
//  rtl.v,v 1.7 1995/08/12 00:13:08 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: Misc. signals that I use to create a nice RTL 
// spreadsheet for TORCH.
//
//	Hierarchy: 
//
//  Revision History:
//
`include "torch.h"

module RTL ();

//
// Instructions
//
reg	[39:0]	AInstr_s1E;
reg	[39:0]	AInstr_s2e;
reg	[39:0]	AInstr_s1m;
reg	[39:0]	AInstr_s2m;
reg	[39:0]	AInstr_s1w;

reg	[39:0]	BInstr_s1E;
reg	[39:0]	BInstr_s2e;
reg	[39:0]	BInstr_s1m;
reg	[39:0]	BInstr_s2m;
reg	[39:0]	BInstr_s1w;

//
// Source operands
//
reg	[31:0]	ASBus_s2e;
reg	[31:0]	ASBus_s1m;
reg	[31:0]	ASBus_s2m;
reg	[31:0]	ASBus_s1w;

reg	[31:0]	ATBus_s2e;
reg	[31:0]	ATBus_s1m;
reg	[31:0]	ATBus_s2m;
reg	[31:0]	ATBus_s1w;

reg	[31:0]	BSBus_s2e;
reg	[31:0]	BSBus_s1m;
reg	[31:0]	BSBus_s2m;
reg	[31:0]	BSBus_s1w;

reg	[31:0]	BTBus_s2e;
reg	[31:0]	BTBus_s1m;
reg	[31:0]	BTBus_s2m;
reg	[31:0]	BTBus_s1w;

//
// Result busses
//
reg	[31:0]	AResultBus_s1m;
reg	[31:0]	AResultBus_s2m;
reg	[31:0]	AResultBus_s1w;

reg	[31:0]	BResultBus_s1m;
reg	[31:0]	BResultBus_s2m;
reg	[31:0]	BResultBus_s1w;

reg	[31:0]	MemBus_s1w;

/*
reg	[4:0]	ASSpec_s1e;
reg	[4:0]	ASSpec_s2e;
reg	[4:0]	ASSpec_s1m;
reg	[4:0]	ASSpec_s2m;
reg	[4:0]	ASSpec_s1w;

reg	[4:0]	ATSpec_s1e;
reg	[4:0]	ATSpec_s2e;
reg	[4:0]	ATSpec_s1m;
reg	[4:0]	ATSpec_s2m;
reg	[4:0]	ATSpec_s1w;

reg	[5:0]	ADest_s2e;
reg	[5:0]	ADest_s1m;
reg	[5:0]	ADest_s2m;
reg	[5:0]	ADest_s1w;

reg	[4:0]	BSSpec_s1e;
reg	[4:0]	BSSpec_s2e;
reg	[4:0]	BSSpec_s1m;
reg	[4:0]	BSSpec_s2m;
reg	[4:0]	BSSpec_s1w;

reg	[4:0]	BTSpec_s1e;
reg	[4:0]	BTSpec_s2e;
reg	[4:0]	BTSpec_s1m;
reg	[4:0]	BTSpec_s2m;
reg	[4:0]	BTSpec_s1w;

reg	[4:0]	BDest_s2e;
reg	[4:0]	BDest_s1m;
reg	[4:0]	BDest_s2m;
reg	[4:0]	BDest_s1w;
*/

//---------------------------------------------------------------------------
//			     --- Wires ---
//---------------------------------------------------------------------------
wire		Phi1	= `PROCESSOR.Phi1;
wire		Phi2	= `PROCESSOR.Phi2;
wire		Stall_s1= `PROCESSOR.Stall_s1;
wire	[31:0]	PC_s1r	= `PCU.PCChain_s1r;
wire	[31:0]	PC_s1e	= `PCU.PCChain_s1e;
wire	[31:0]	PC_s1m	= `PCU.PCChain_s1m;
wire	[31:0]	PC_s1w	= `PCU.PCChain_s1w;
wire		AWBValid_s1w = `RFC.AWBen_v1w;
wire		BWBValid_s1w = `RFC.BWBen_v1w;
//wire	[31:0]	AInstr	= AInstr_s1w;
//wire	[31:0]	BInstr	= BInstr_s1w;
//wire	[31:0]	ASBus	= ASBus_s1w;
//wire	[31:0]	ATBus	= ATBus_s1w;
//wire	[31:0]	AResult	= AResultBus_s1w;
//wire	[31:0]	BSBus	= BSBus_s1w;
//wire	[31:0]	BTBus	= BTBus_s1w;
//wire	[31:0]	BResult = BResultBus_s1w;
//wire	[31:0]	MemBus	= MemBus_s1w;
//wire	[4:0]	ASSpec	= ASSpec_s1w[4:0];
//wire	[4:0]	ATSpec	= ATSpec_s1w[4:0];
//wire	[4:0]	ADSpec	= ADSpec_s1w[4:0];
//wire	[4:0]	BSSpec	= BSSpec_s1w[4:0];
//wire	[4:0]	BTSpec	= BTSpec_s1w[4:0];
//wire	[4:0]	BDSpec	= BDSpec_s1w[4:0];


//---------------------------------------------------------------------------
//			   --- Registers ---
//---------------------------------------------------------------------------
wire	[31:0]	seq_s1e = `RSEQ.sequential_s1e;
wire	[31:0]	register;
assign register[0] = (seq_s1e[0]) ? `REG.register[0] : `REG.register[32];
assign register[1] = (seq_s1e[1]) ? `REG.register[1] : `REG.register[33];
assign register[2] = (seq_s1e[2]) ? `REG.register[2] : `REG.register[34];
assign register[3] = (seq_s1e[3]) ? `REG.register[3] : `REG.register[35];
assign register[4] = (seq_s1e[4]) ? `REG.register[4] : `REG.register[36];
assign register[5] = (seq_s1e[5]) ? `REG.register[5] : `REG.register[37];
assign register[6] = (seq_s1e[6]) ? `REG.register[6] : `REG.register[38];
assign register[7] = (seq_s1e[7]) ? `REG.register[7] : `REG.register[39];
assign register[8] = (seq_s1e[8]) ? `REG.register[8] : `REG.register[40];
assign register[9] = (seq_s1e[9]) ? `REG.register[9] : `REG.register[41];
assign register[10] = (seq_s1e[10]) ? `REG.register[10] : `REG.register[42];
assign register[11] = (seq_s1e[11]) ? `REG.register[11] : `REG.register[43];
assign register[12] = (seq_s1e[12]) ? `REG.register[12] : `REG.register[44];
assign register[13] = (seq_s1e[13]) ? `REG.register[13] : `REG.register[45];
assign register[14] = (seq_s1e[14]) ? `REG.register[14] : `REG.register[46];
assign register[15] = (seq_s1e[15]) ? `REG.register[15] : `REG.register[47];
assign register[16] = (seq_s1e[16]) ? `REG.register[16] : `REG.register[48];
assign register[17] = (seq_s1e[17]) ? `REG.register[17] : `REG.register[49];
assign register[18] = (seq_s1e[18]) ? `REG.register[18] : `REG.register[50];
assign register[19] = (seq_s1e[19]) ? `REG.register[19] : `REG.register[51];
assign register[20] = (seq_s1e[20]) ? `REG.register[20] : `REG.register[52];
assign register[21] = (seq_s1e[21]) ? `REG.register[21] : `REG.register[53];
assign register[22] = (seq_s1e[22]) ? `REG.register[22] : `REG.register[54];
assign register[23] = (seq_s1e[23]) ? `REG.register[23] : `REG.register[55];
assign register[24] = (seq_s1e[24]) ? `REG.register[24] : `REG.register[56];
assign register[25] = (seq_s1e[25]) ? `REG.register[25] : `REG.register[57];
assign register[26] = (seq_s1e[26]) ? `REG.register[26] : `REG.register[58];
assign register[27] = (seq_s1e[27]) ? `REG.register[27] : `REG.register[59];
assign register[28] = (seq_s1e[28]) ? `REG.register[28] : `REG.register[60];
assign register[29] = (seq_s1e[29]) ? `REG.register[29] : `REG.register[61];
assign register[30] = (seq_s1e[30]) ? `REG.register[30] : `REG.register[62];
assign register[31] = (seq_s1e[31]) ? `REG.register[31] : `REG.register[63];


//---------------------------------------------------------------------------
//			  --- Dynamic NOP ---
//---------------------------------------------------------------------------
wire [39:0]	AInstr_s1e = 
	(`PROCESSOR.AKill_s1e) ? 39'hdeadbeef : AInstr_s1E;
wire [31:0]	ASBus_s1e  =
	(`PROCESSOR.AKill_s1e) ? 32'hdeadbeef : `PROCESSOR.ASBus_s1e;
wire [31:0]	ATBus_s1e  =
	(`PROCESSOR.AKill_s1e) ? 32'hdeadbeef : `PROCESSOR.ATBus_s1e;
wire [39:0]	BInstr_s1e =
	(`PROCESSOR.BKill_s1e) ? 39'hdeadbeef : BInstr_s1E;
wire [31:0]	BSBus_s1e  =
	(`PROCESSOR.BKill_s1e) ? 32'hdeadbeef : `PROCESSOR.BSBus_s1e;
wire [31:0]	BTBus_s1e  =
	(`PROCESSOR.BKill_s1e) ? 32'hdeadbeef : `PROCESSOR.BTBus_s1e;

//---------------------------------------------------------------------------
//			   --- Exceptions ---
//---------------------------------------------------------------------------
wire [8*6:1] Except_s1w;
assign Except_s1w = (`PROCESSOR.Except_s1w) ?
    "Except" : "------";

//---------------------------------------------------------------------------
//			--- Delay Pipelines ---
//---------------------------------------------------------------------------
always @(Phi1 or Stall_s1 or 
	AInstr_s1e or BInstr_s1e or
	AInstr_s1m or BInstr_s1m
	) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	AInstr_s2e = AInstr_s1e;
	BInstr_s2e = BInstr_s1e;
	AInstr_s2m = AInstr_s1m;
	BInstr_s2m = BInstr_s1m;
    end
end

always @(Phi2 or
	`PROCESSOR.AInstr_s2r or `PROCESSOR.BInstr_s2r or
	AInstr_s2e or BInstr_s2e or
	AInstr_s2m or BInstr_s2m
	) begin
    if (Phi2) begin
	`TICK
	AInstr_s1E = `PROCESSOR.AInstr_s2r;
	BInstr_s1E = `PROCESSOR.BInstr_s2r;
	AInstr_s1m = AInstr_s2e;
	BInstr_s1m = BInstr_s2e;
	AInstr_s1w = AInstr_s2m;
	BInstr_s1w = BInstr_s2m;
    end
end

//
// Source operands
//
always @(Phi1 or Stall_s1 or 
	ASBus_s1e or ATBus_s1e or
	BSBus_s1e or BTBus_s1e or
	ASBus_s1m or ATBus_s1m or
	BSBus_s1m or BTBus_s1m
	) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	ASBus_s2e = ASBus_s1e;
	ATBus_s2e = ATBus_s1e;
	BSBus_s2e = BSBus_s1e;
	BTBus_s2e = BTBus_s1e;
//
	ASBus_s2m = ASBus_s1m;
	ATBus_s2m = ASBus_s1m;
	BSBus_s2m = BSBus_s1m;
	BTBus_s2m = BTBus_s1m;
	
    end
end

always @(Phi2 or
	ASBus_s2e or ATBus_s2e or
	BSBus_s2e or BTBus_s2e or
	ASBus_s2m or ATBus_s2m or
	BSBus_s2m or BTBus_s2m
	) begin
    if (Phi2) begin
	`TICK
	ASBus_s1m = ASBus_s2e;
	ATBus_s1m = ATBus_s2e;
	BSBus_s1m = BSBus_s2e;
	BTBus_s1m = BTBus_s2e;
//
	ASBus_s1w = ASBus_s2m;
	ATBus_s1w = ATBus_s2m;
	BSBus_s1w = BSBus_s2m;
	BTBus_s1w = BTBus_s2m;
    end
end


//
// Result busses
//
always @(Phi1 or Stall_s1 or 
	AResultBus_s1m or BResultBus_s1m
	) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	AResultBus_s2m = AResultBus_s1m;
	BResultBus_s2m = BResultBus_s1m;
    end
end

always @(Phi2 or
	`PROCESSOR.AResultBus_v2e or `PROCESSOR.BResultBus_v2e or
	AResultBus_s2m or BResultBus_s2m
	) begin
    if (Phi2) begin
	`TICK
	AResultBus_s1m = `PROCESSOR.AResultBus_v2e;
	BResultBus_s1m = `PROCESSOR.BResultBus_v2e;
	AResultBus_s1w = AResultBus_s2m;
	BResultBus_s1w = BResultBus_s2m;
    end
end

//
// MemBus
//
always @(Phi2 or
	`PROCESSOR.MemBus_v2m
	) begin
    if (Phi2) begin
	`TICK
	MemBus_s1w = `PROCESSOR.MemBus_v2m;
    end
end

//---------------------------------------------------------------------------
//		      --- Navigator Interface ---
//---------------------------------------------------------------------------
initial begin
`ifdef CADENCE
    if ($test$plusargs("dumpvars")) begin
	$dumpvars;
    end
`endif
`ifdef SSI
    if ($test$plusargs("navdump")) begin
	$ssi_navconfigure("-dumpsize 10", 
	    "-dumpname /tmp/torch.dump0,/tmp/torch.dump1");
	$ssi_navdbase;
	$ssi_navdump(0, system);
    end
    if ($test$plusargs("navsim")) begin
	$ssi_navigator;
	$ssi_navconfigure("-recname /tmp/torch.dump");
	$ssi_navrecord(3, system);
    end
`endif
end

endmodule				 // RTL
