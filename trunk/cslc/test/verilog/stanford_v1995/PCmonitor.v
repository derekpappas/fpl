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
//  Title: 	PC Monitor Task
//  Created:	Thu Mar 24 15:47:46 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma.Stanford.EDU>
//
//
//  PCmonitor.v,v 7.6 1995/02/08 01:32:56 ricardog Exp
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
//	Modified: Wed Nov 30 12:57:26 1994	<ricardog@chroma.Stanford.EDU>
//	* Added support to display instructions.
//
`include "torch.h"

module PCmon;

integer outChannel;
wire		Phi1 = `PROCESSOR.Phi1;
wire		Phi2 = `PROCESSOR.Phi2;
wire		Psi1_q1 = Phi1 & ~`PROCESSOR.Stall_s1; 

wire		Reset_s1 = `PROCESSOR.Reset_s1;
wire		Except_s1w = `PROCESSOR.Except_s1w;

wire		AKill_s1e = `PROCESSOR.AKill_s1e;
wire		AIgnore_s2e = `PROCESSOR.AIgnore_s2e;
wire		BKill_s1e = `PROCESSOR.BKill_s1e;
wire		BIgnore_s2e = `PROCESSOR.BIgnore_s2e;

wire	[39:0]	AInstr_s2r = `PROCESSOR.AInstr_s2r;
wire	[39:0]	BInstr_s2r = `PROCESSOR.BInstr_s2r;

wire		Avalid_s1w = `A_BPS.ADest_s1w[`VALID_BIT];
wire		Bvalid_s1w = `B_BPS.BDest_s1w[`VALID_BIT];
wire	[31:0]	AWBData_s1w = `REG_FILE.AWBData_s1w;
wire	[31:0]	BWBData_s1w = `REG_FILE.BWBData_s1w;

reg		Except_s2w;
reg		Except_s1a;
reg		Except_s2a;
reg		Except_s1b;
reg		Except_s2b;
reg		Except_s1c;
reg		Except_s2c;

reg		AKill_s2e;
reg		AKill_s1m;
reg		AKill_s2m;
reg		AKill_s1w;
reg		BKill_s2e;
reg		BKill_s1m;
reg		BKill_s2m;
reg		BKill_s1w;

reg	[39:0]	AInstr_s1e;
reg	[39:0]	AInstr_s2e;
reg	[39:0]	AInstr_s1m;
reg	[39:0]	AInstr_s2m;
reg	[39:0]	AInstr_s1w;
reg	[39:0]	BInstr_s1e;
reg	[39:0]	BInstr_s2e;
reg	[39:0]	BInstr_s1m;
reg	[39:0]	BInstr_s2m;
reg	[39:0]	BInstr_s1w;

reg	[31:0]	cycles;

initial begin
    if($test$plusargs("pcmon")) begin
	outChannel = $fopen("pcmon.log");
	PCmonitor;
    end
    cycles = 0;
end

always @(posedge Phi1) begin
    if (Reset_s1)
	cycles = 0;
    else
	cycles = cycles + 1;
end

always @(Psi1_q1 or Except_s1w or Except_s1a or Except_s1b or
	Except_s1c) begin
    if (Psi1_q1) begin
	`TICK
	Except_s2w = Except_s1w;
	Except_s2a = Except_s1a;
	Except_s2b = Except_s1b;
	Except_s2c = Except_s1c;
    end
end

always @(Phi2 or Except_s2w or Except_s2a or Except_s2b) begin
    if (Phi2) begin
	`TICK
	Except_s1a = Except_s2w;
	Except_s1b = Except_s2a;
	Except_s1c = Except_s2b;
    end
end

always @(Phi2 or
	AIgnore_s2e or AKill_s2e or AKill_s2m or
	BIgnore_s2e or BKill_s2e or BKill_s2m) begin
    if (Phi2) begin
	`TICK
	AKill_s1m = AKill_s2e | AIgnore_s2e;
	AKill_s1w = AKill_s2m;
	BKill_s1m = BKill_s2e | BIgnore_s2e;
	BKill_s1w = BKill_s2m;
    end
end

always @(Psi1_q1 or AKill_s1e or AKill_s1m or
	BKill_s1e or BKill_s1m) begin
    if(Psi1_q1) begin
	`TICK
	AKill_s2e = AKill_s1e;
	AKill_s2m = AKill_s1m;
	BKill_s2e = BKill_s1e;
	BKill_s2m = BKill_s1m;
    end
end

always @(Psi1_q1 or AInstr_s1e or AInstr_s1m or BInstr_s1e or BInstr_s1m) begin
    if (Psi1_q1) begin
	`TICK
	AInstr_s2e = AInstr_s1e;
	AInstr_s2m = AInstr_s1m;
	BInstr_s2e = BInstr_s1e;
	BInstr_s2m = BInstr_s1m;
    end
end

always @(Phi2 or AInstr_s2r or AInstr_s2e or AInstr_s2m or
	BInstr_s2r or BInstr_s2e or BInstr_s2m) begin
    if (Phi2) begin
	`TICK
	AInstr_s1e = AInstr_s2r;
	AInstr_s1m = AInstr_s2e;
	AInstr_s1w = AInstr_s2m;
	BInstr_s1e = BInstr_s2r;
	BInstr_s1m = BInstr_s2e;
	BInstr_s1w = BInstr_s2m;
    end
end

task PCmonitor;
begin
    @(posedge Psi1_q1) begin
	if (~Except_s1w & ~Except_s1a & ~Except_s1b & ~Except_s1c) begin
	    $fwrite(outChannel, "%d:  PC  %h", cycles, `PCU.PCChain_s1w);
	    if (AKill_s1w)
		$fwrite(outChannel, "\t-- --------");
	    else if (AInstr_s1w[31:0] == `NOP || AInstr_s2r[31:0] == 32'h0)
		$fwrite(outChannel, "\t-- ---NOP--");
	    else
		$fwrite(outChannel, "\t%h %h", AInstr_s1w[39:32], AInstr_s1w[31:0]);
	    if (BKill_s1w)
		$fwrite(outChannel, "\t-- --------\n");
	    else if (BInstr_s1w[31:0] == `NOP || BInstr_s2r[31:0] == 32'h0)
		$fwrite(outChannel, "\t-- ---NOP--\n");
	    else
		$fwrite(outChannel, "\t%h %h\n", BInstr_s1w[39:32], BInstr_s1w[31:0]);
	    if (AKill_s1w || ~Avalid_s1w ||
		    AInstr_s1w[31:0] == `NOP || AInstr_s2r[31:0] == 32'h0)
		$fwrite(outChannel, "\t\t\t\t   xxxxxxxx");
	    else
		$fwrite(outChannel, "\t\t\t\t   %h", AWBData_s1w);
	    if (BKill_s1w || ~Bvalid_s1w ||
		    BInstr_s1w[31:0] == `NOP || BInstr_s2r[31:0] == 32'h0)
		$fwrite(outChannel, "\t   xxxxxxxx\n");
	    else
		$fwrite(outChannel, "\t   %h\n", BWBData_s1w);
	end
	PCmonitor;
    end
end
endtask

endmodule
