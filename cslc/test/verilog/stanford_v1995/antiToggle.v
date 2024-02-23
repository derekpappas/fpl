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
//  Title: 	Toggle Prevention Module
//  Created:	Wed Nov 23 10:09:11 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma.Stanford.EDU>
//
//
//  antiToggle.v,v 7.2 1995/02/08 01:32:58 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: 
//
//	Hierarchy: 
//
//  Revision History:
//
`include "torch.h"

module antiToggle ();

`ifdef NOTOGGLE
//---------------------------------------------------------------------------
//			--- Awrong or BWrong ---
//---------------------------------------------------------------------------
wire	[39:0]	AInstr_s2r = `PROCESSOR.AInstr_s2r;
wire	[39:0]	BInstr_s2r = `PROCESSOR.BInstr_s2r;

wire		AIgnore_s2r;
wire		BIgnore_s2r;

wire		AWrong_s2r;
wire		BWrong_s2r;

reg		AWrong_s1e;
reg		AWrong_s2e;
reg		AWrong_s1m;
reg		AWrong_s2m;
reg		AWrong_s1w;

reg		BWrong_s1e;
reg		BWrong_s2e;
reg		BWrong_s1m;
reg		BWrong_s2m;
reg		BWrong_s1w;

wire		Phi1 = `PROCESSOR.Phi1;
wire		Phi2 = `PROCESSOR.Phi2;

wire		MemStall_s1 = `PROCESSOR.MemStall_s1;
wire		IStall_s1 = `PROCESSOR.IStall_s1;
wire		Psi1_q1 = Phi1 & ~MemStall_s1;
wire		MipsMode_s2e = `PROCESSOR.MipsMode_s2e;

reg	[31:0]	ASBus_s1e;
reg	[31:0]	ATBus_s1e;

reg	[31:0]	BSBus_s1e;
reg	[31:0]	BTBus_s1e;

reg	[8:0]	ADest_s1e;
reg	[9:0]	BDest_s1e;

reg		Aflag;
reg		Bflag;

assign AIgnore_s2r = (AInstr_s2r[31]==1'd1  |		// Ld, Store
		      AInstr_s2r[31:28]==4'd4 | 	// coprocessor
		      (AInstr_s2r[`OPCODE]==`SPECIAL & AInstr_s2r[5:2]==4'd3));
							// Syscall & break
assign BIgnore_s2r = ((BInstr_s2r[31:28]==4'd5) || // Branch
	    ((BInstr_s2r[31:29]==3'd0) && (BInstr_s2r[28:26]!=3'd0)) ||
	    // Branch & jumps
	    ((BInstr_s2r[31:26]==6'd0) &&
		((BInstr_s2r[5:3]==3'd0) || // Shifts
		    (BInstr_s2r[5:4]==2'd1) || // Mult/Div
		    (BInstr_s2r[5:2]==4'd2)))); // Jr/Jalr

assign AWrong_s2r = AIgnore_s2r;
assign BWrong_s2r = BIgnore_s2r | (~AWrong_s2r & MipsMode_s2e);

always @(negedge Psi1_q1) begin
    if (~AWrong_s2r & AWrong_s2e) begin
	release `A_BPD.ASBus_s1e;
	release `A_BPD.ATBus_s1e;
	Aflag = 1'b0;
//	$display("\t\t    Releasing A-side busses");
    end
    else if (AWrong_s2r & ~AWrong_s2e) begin
	ASBus_s1e = `A_BPD.ASBus_s1e;
	ATBus_s1e = `A_BPD.ATBus_s1e;
	force `A_BPD.ASBus_s1e = ASBus_s1e;
	force `A_BPD.ATBus_s1e = ATBus_s1e;
	Aflag = 1'b1;
//	$display("\t\t    Forcing A-side busses");
    end

    if (~BWrong_s2r & BWrong_s2e) begin
	release `B_BPD.BSBus_s1e;
	release `B_BPD.BTBus_s1e;
	Bflag = 1'b0;
//	$display("\t\t    Releasing B-side busses");
    end

    if (BWrong_s2r & ~BWrong_s2e) begin
	BSBus_s1e = `B_BPD.BSBus_s1e;
	BTBus_s1e = `B_BPD.BTBus_s1e;
	force `B_BPD.BSBus_s1e = BSBus_s1e;
	force `B_BPD.BTBus_s1e = BTBus_s1e;
	Bflag = 1'b1;
//	$display("\t\t    Forcing B-side busses");
    end
end

always @(negedge Psi1_q1) begin
    if (AWrong_s2e) begin
//	release `A_BPS.ADest_s1e;
//	$display("\t\t    Releasing A-side destination");
    end

    if (AWrong_s2r) begin
//	ADest_s1e = `A_BPS.ADest_s1e;
//	force `A_BPS.ADest_s1e = {ADest_s1e[8:7], 1'b0, ADest_s1e[5:0]};
//	$display("\t\t    Forcing A-side destination");
    end

    if (BWrong_s2e) begin
//	release `B_BPS.BDest_s1e;
//	$display("\t\t    Releasing B-side destination");
    end

    if (BWrong_s2r) begin
//	BDest_s1e = `B_BPS.BDest_s1e;
//	force `B_BPS.BDest_s1e = {BDest_s1e[9:7], 1'b0, BDest_s1e[5:0]};
//	$display("\t\t    Forcing B-side destination");
    end
end


always @(Psi1_q1 or AWrong_s1e or AWrong_s1m or BWrong_s1e or BWrong_s1m) begin
    if (Psi1_q1) begin
	`TICK
	AWrong_s2e = AWrong_s1e;
	AWrong_s2m = AWrong_s1m;
	BWrong_s2e = BWrong_s1e;
	BWrong_s2m = BWrong_s1m;
    end
end

always @(Phi2 or AWrong_s2r or AWrong_s2e or AWrong_s2m or
	BWrong_s2r or BWrong_s2e or BWrong_s2m) begin
    if (Phi2) begin
	`TICK
	AWrong_s1e = AWrong_s2r;
	AWrong_s1m = AWrong_s2e;
	AWrong_s1w = AWrong_s2m;
	BWrong_s1e = BWrong_s2r;
	BWrong_s1m = BWrong_s2e;
	BWrong_s1w = BWrong_s2m;
    end
end
`endif

endmodule				 // antiToggle
