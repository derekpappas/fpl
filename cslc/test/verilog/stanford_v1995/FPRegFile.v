//
//  Title: 	Floating Point Register File
//  Created:	Tue Feb 23 18:05:54 1993
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  FPRegFile.v,v Version 1.4 Last Edit 1995/01/28 00:46:04
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This file contains the TORCH FP register file and bypass 
//  	    logic. Currently it does not bypass from the MemBus. Does not 
//  	    check for interlocks with instructions in pipe.
//
//	Hierarchy: system.processor.FPUnit
//

module FPRegFile(
    	Phi1,
    	Phi2,
    	IStall_s1,
    	MemStall_s2,
    	Except_s1w,
    	fpOpIsValid_v2r,
    	fsSpec_s2r,
    	ftSpec_s2r,
    	fdSpec_s2r,
    	fsBus_s1e,
    	ftBus_s1e,
    	resultBus_v2w,
    	MemBus_v2m
    	);

//
// Input declarations
//
input	    	Phi1;
input	    	Phi2;
input	    	IStall_s1;
input	    	MemStall_s2;
input	    	Except_s1w;
input	    	fpOpIsValid_v2r;
input [4:0] 	fsSpec_s2r;		  // Register specifier fields
input [4:0] 	ftSpec_s2r;
input [4:0] 	fdSpec_s2r;

input [63:0]	resultBus_v2w;		  // Result from MOA
inout [63:0]	MemBus_v2m;

//
// Output declarations
//
output [63:0]	fsBus_s1e;		  // Actual operands after bypass
output [63:0]	ftBus_s1e;

//
// Wire delarations
//
wire [63:0] 	fsBus_v2r;		  // Straight out of the register file.
wire [63:0] 	ftBus_v2r;
wire [63:0] 	resultBus_v2w;		  // From MOA.
wire	    	fsBypass_v2r;		  // 1 => bypass from result bus
wire	    	ftBypass_v2r;		  // 1 => bypass from result bus

//
// Register declarations
//
reg [63:0]  	FPregisters[15:0];	  // Array of registers
reg [4:0]   	fsSpec_s1e, fsSpec_s2e, fsSpec_s1m, fsSpec_s2m;
reg [4:0]   	fsSpec_s1w, fsSpec_s2w;
reg [4:0]   	ftSpec_s1e, ftSpec_s2e, ftSpec_s1m, ftSpec_s2m;
reg [4:0]   	ftSpec_s1w, ftSpec_s2w;
reg [5:0]   	fdSpec_s1e, fdSpec_s2e, fdSpec_s1m, fdSpec_s2m;
reg [5:0]   	fdSpec_s1w, fdSpec_s2w, fdSpec_s1f;

reg [63:0] 	rawfsBus_s1e;		  // Latched and buffered.
reg [63:0] 	rawftBus_s1e;

reg [63:0] 	resultBus_s1f;		  // Latched and buffered.
reg [52:0]  	temp;			  // Temporary storage to init regs

//
// Continious assignments
//
assign #1 fsBypass_v2r = (fsSpec_s2r == fdSpec_s2w);
assign #1 ftBypass_v2r = (ftSpec_s2r == fdSpec_s2w);

assign #1 fsBus_s1e = (fsBypass_v2r) ? resultBus_s1f : rawfsBus_s1e;
assign #1 ftBus_s1e = (ftBypass_v2r) ? resultBus_s1f : rawftBus_s1e;

assign #1 fsBus_v2r = (Phi2) ? FPregisters[fsSpec_s2r[4:1]] : 63'bx;
assign #1 ftBus_v2r = (Phi2) ? FPregisters[ftSpec_s2r[4:1]] : 63'bx;


//
// Initial block. Load up the regFile with standard values.
//
integer 	i;
initial begin
    if ($test$plusargs("regfile")) begin
    	$readmemh("fp.regs", FPregisters);
    end
    else begin
    	for (i = 0; i < 16; i = i + 1) begin
    	    temp = 1'b1 << (i * 2);
	    FPregisters[i] = {1'b0, 10'b1111100000, temp};
//    	    $display("%h    %h", temp, FPregisters[i]);
	end
    end
    fsSpec_s1e = 0; fsSpec_s2e = 0; fsSpec_s1m = 0; fsSpec_s2m = 0;
    fsSpec_s1w = 0; fsSpec_s2w = 0;

    ftSpec_s1e = 0; ftSpec_s2e = 0; ftSpec_s1m = 0; ftSpec_s2m = 0;
    ftSpec_s1w = 0; ftSpec_s2w = 0;

    fdSpec_s1e = 0; fdSpec_s2e = 0; fdSpec_s1m = 0; fdSpec_s2m = 0;
    fdSpec_s1w = 0; fdSpec_s2w = 0;

end // initial

//
// Always blocks
//
// Bypass chains
always @(Phi1 or IStall_s1 or
    fsSpec_s1e or ftSpec_s1e or fdSpec_s1e or
    fsSpec_s1m or ftSpec_s1m or fdSpec_s1m or
    fsSpec_s1w or ftSpec_s1w or fdSpec_s1w
) begin
    if (Phi1 && ~IStall_s1) begin
	fsSpec_s2e = fsSpec_s1e; ftSpec_s2e = ftSpec_s1e;
	fsSpec_s2m = fsSpec_s1m; ftSpec_s2m = ftSpec_s1m;
	fsSpec_s2w = fsSpec_s1w; ftSpec_s2w = ftSpec_s1w;

    	fdSpec_s2e = fdSpec_s1e;
    	fdSpec_s2m = fdSpec_s1m;
    	fdSpec_s2w = fdSpec_s1w;
    end
end

always @(Phi2 or MemStall_s2 or
    fsSpec_s2r or ftSpec_s2r or fdSpec_s2r or
    fsSpec_s2e or ftSpec_s2e or fdSpec_s2e or
    fsSpec_s2m or ftSpec_s2m or fdSpec_s2m or fdSpec_s2w
) begin
    if (Phi2 && ~MemStall_s2) begin
        fsSpec_s1e = fsSpec_s2r; ftSpec_s1e = ftSpec_s2r;
        fsSpec_s1m = fsSpec_s2e; ftSpec_s1m = ftSpec_s2e;
        fsSpec_s1w = fsSpec_s2m; ftSpec_s1w = ftSpec_s2m;
  	
        fdSpec_s1e = {fpOpIsValid_v2r, fdSpec_s2r};
        fdSpec_s1m = fdSpec_s2e;
        fdSpec_s1w = fdSpec_s2m;
        fdSpec_s1f = fdSpec_s2w;
    end
end

//
// Latch result and source busses.
//
always @(Phi2 or MemStall_s2 or resultBus_v2w or fsBus_v2r or ftBus_v2r) begin
    if (Phi2 && ~MemStall_s2) begin
    	resultBus_s1f = resultBus_v2w;
    	rawfsBus_s1e = fsBus_v2r;
    	rawftBus_s1e = ftBus_v2r;
    end
end

//
// Write Back
//
always @(Phi1 or fdSpec_s1f or resultBus_s1f) begin
    if (Phi1 && fdSpec_s1f[5]) begin
    	FPregisters[fdSpec_s1f[4:1]] = resultBus_s1f[63:0];
    end
end

/*
 *
 * This would be a more structural description. For now I will just implement
 * a behavioral model.
 *
FPregisters(
    	.Phi1	    	    	(Phi1),
    	.Phi2	    	    	(Phi2),
    	.fsSpec_s2r 	    	(fsSpec_s2r),
    	.ftSpec_s2r 	    	(ftSpec_s2r),
    	.fdSpec_s1f 	    	(fdSpec_s1f),
    	.fsBus_v2r  	    	(fsBus_v2r),
    	.ftBus_v2r  	    	(ftBus_v2r),
    	.resultBus_s1f	    	(resultBus_s1f)
    	);

FPbypass(
    	.Phi1	    	    	(Phi1),
    	.Phi2	    	    	(Phi2),
    	.IStall_s1  	    	(IStall_s1),
    	.MemStall_s2	    	(MemStall_s2),
    	.fsSpec_s2r 	    	(fsSpec_s2r),
    	.ftSpec_s2r 	    	(ftSpec_s2r),
    	.fdSpec_s2r 	    	(fdSpec_s2r),
    	.fsBus_v2r  	    	(fsBus_v2r),
    	.ftBus_v2r  	    	(ftBus_v2r),
    	.resultBus_v2w	    	(resultBus_v2w),
    	.fdSpec_s1f 	    	(fdSpec_s1f),
    	.fsBus_s1e  	    	(fsBus_s1e),
    	.ftBus_s1e  	    	(ftBus_s1e),
    	.resultBus_s1f	    	(resultBus_s1f)
    	);
 *
 * End of structural sections (NOT USED).
 *
 */

endmodule


