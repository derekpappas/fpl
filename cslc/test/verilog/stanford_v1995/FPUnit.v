//
//  Title: 	Floating Point Unit
//  Created:	Tue Feb 23 11:25:01 1993
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  FPUnit.v,v Version 1.10 Last Edit 1995/01/28 00:46:06
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This is the top-level netlist for the TORCH floating point
//  	    unit. It currently contains three units, the control unit, the 
//  	    main datapath unit, and the FP register file. Later we might need
//  	    to add more stuff.
//
//	Hierarchy: system.processor.FPUnit
//

//
// Macro definitions
//
`define	OPCODE	    31:26		  // Bits where the opcode sits
`define COP1	    6'h11		  // Opcode for FP instructions

`define	FP_FUNC	    5:0			  // Bits where the function type is
`define	FP_ADD	    6'h0		  
`define FP_SUB	    6'h1
`define FP_MUL	    6'h2
`define FP_DIV	    6'h3
`define FP_ABS	    6'h5
`define FP_MOV	    6'h6
`define FP_NEG	    6'h7
`define FP_CVT_S    6'h20		  // Convert to single
`define	FP_CVT_D    6'h21		  // Convert to double
`define	FP_CVT_W    6'h24		  // Convert to fixed point
`define	FP_CMP	    6'b11xxxx		  // Bottom four bits specify cmp type

`define	FP_FORMAT   24:21		  // Bits that specify the format
`define FP_SINGLE   4'h0
`define	FP_DOUBLE   4'h1
`define	FP_FIXED    4'h4

`define	FP_FS_SPEC  15:11
`define FP_FT_SPEC  20:16
`define FP_FD_SPEC  10:6

`include "FPCtrl.v" // By Claudiu
`include "FPRegFile.v" // By Claudiu
`include "moa.v" // By Claudiu

module FPUnit (
    	Phi1,
    	Phi2,
    	IStall_s1,
    	MemStall_s2,
    	Except_s1w,
    	AInstr_s2r,
    	MemBus_v2m,
    	FPExcept_v2m
    	);


//
// Inputs
//
input	    	Phi1;			  // Global clock.
input	    	Phi2;			  // Global clock.
input	    	IStall_s1;		  // Global stall signal.
input	    	MemStall_s2;		  // Global stall signal.
input	    	Except_s1w;		  // Global except signal.
input [40:0]	AInstr_s2r;		  // Need to decode instruction.

//
// In-outs
//
inout [63:0]	MemBus_v2m;		  // Have direct mem op to FP reg file.

//
// Outputs
//
output	    	FPExcept_v2m;

//
// Wire declarations
//
wire [5:0]  	opcode_s2r;		  // Opcode of instruction
wire [5:0]  	function_s2r;		  // Function field of instruction
wire [3:0]  	format_s2r;		  // Format field of instruction

wire [4:0]  	fsSpec_s2r;
wire [4:0]  	ftSpec_s2r;
wire [4:0]  	fdSpec_s2r;

wire [63:0] 	fsBus_s1e;		  // S source operand bus
wire [63:0] 	ftBus_s1e;		  // T source operand bus
wire [63:0] 	resultBus_v2w;		  // F-stage?

wire [5:0]  	FPExceptions_v2w;	  // Exception flags from moa

//
// Assignment statements to pick-out parts of busses.
//
assign opcode_s2r = AInstr_s2r[`OPCODE];
assign function_s2r = AInstr_s2r[`FP_FUNC];
assign format_s2r = AInstr_s2r[`FP_FORMAT];

assign fsSpec_s2r = AInstr_s2r[`FP_FS_SPEC];
assign ftSpec_s2r = AInstr_s2r[`FP_FT_SPEC];
assign fdSpec_s2r = AInstr_s2r[`FP_FD_SPEC];

//
// This unit decodes the instruction and generates some various control signals
// that have to be sent to the integer section of the processor--namely 
// exceptions and stalls.
//
FPCtrl FPCtrl(
    	.Phi1	    	    	(Phi1),
    	.Phi2	    	    	(Phi2),
    	.IStall_s1  	    	(IStall_s1),
    	.MemStall_s2	    	(MemStall_s2),
    	.opcode_s2r 	    	(opcode_s2r),
    	.function_s2r	    	(function_s2r),
    	.format_s2r	    	(format_s2r),
    	.FPExceptions_v2w   	(FPExceptions_v2w),
    	.fpOpIsValid_v2r    	(fpOpIsValid_v2r),
    	.fpOpIsAdd_s1e	    	(fpOpIsAdd_s1e),
    	.fpOpIsSub_s1e	    	(fpOpIsSub_s1e),
    	.fpOpIsMul_s1e	    	(fpOpIsMul_s1e),
    	.fpOpIsDiv_s1e	    	(fpOpIsDiv_s1e),
    	.fpOpIsAbs_s1e	    	(fpOpIsAbs_s1e),
    	.fpOpIsMov_s1e	    	(fpOpIsMov_s1e),
    	.fpOpIsNeg_s1e	    	(fpOpIsNeg_s1e),
    	.fpOpIsCmp_s1e	    	(fpOpIsCmp_s1e),
    	.fpOpIsSingle_s1e   	(fpOpIsSingle_s1e),
    	.fpOpIsDouble_s1e   	(fpOpIsDouble_s1e),
    	.fpOpIsFixed_s1e    	(fpOpIsFixed_s1e),
    	.FPExcept_v2m	    	(FPExcept_v2m)
    	);

//
// This is the mnain datapath section. See the related documents. Designed and 
// implemented by Sam Naffziger <sdn@leland>.
//
MOAUnit MOAUnit(
    	.Phi1	    	    	(Phi1),
    	.Phi2	    	    	(Phi2),
    	.IStall_s1  	    	(IStall_s1),
    	.MemStall_s2	    	(MemStall_s2),
    	.fpOpIsAdd_s1e	    	(fpOpIsAdd_s1e),
    	.fpOpIsSub_s1e	    	(fpOpIsSub_s1e),
    	.fpOpIsMul_s1e	    	(fpOpIsMul_s1e),
    	.fpOpIsDiv_s1e	    	(fpOpIsDiv_s1e),
    	.fpOpIsAbs_s1e	    	(fpOpIsAbs_s1e),
    	.fpOpIsMov_s1e	    	(fpOpIsMov_s1e),
    	.fpOpIsNeg_s1e	    	(fpOpIsNeg_s1e),
    	.fpOpIsCmp_s1e	    	(fpOpIsCmp_s1e),
    	.fpOpIsSingle_s1e   	(fpOpIsSingle_s1e),
    	.fpOpIsDouble_s1e   	(fpOpIsDouble_s1e),
    	.fpOpIsFixed_s1e    	(fpOpIsFixed_s1e),
    	.fsBus_s1e  	    	(fsBus_s1e),
    	.ftBus_s1e  	    	(ftBus_s1e),
    	.resultBus_v2w	    	(resultBus_v2w),
    	.FPExceptions_v2w   	(FPExceptions_v2w)
    	);

//
// The TORCH FP register file. 
//
FPRegFile FPRegFile(
    	.Phi1	    	    	(Phi1),
    	.Phi2	    	    	(Phi2),
    	.IStall_s1  	    	(IStall_s1),
    	.MemStall_s2	    	(MemStall_s2),
    	.Except_s1w 	    	(Except_s1w),
    	.fpOpIsValid_v2r    	(fpOpIsValid_v2r),
    	.fsSpec_s2r	    	(fsSpec_s2r),
    	.ftSpec_s2r	    	(ftSpec_s2r),
    	.fdSpec_s2r	    	(fdSpec_s2r),
    	.fsBus_s1e  	    	(fsBus_s1e),
    	.ftBus_s1e  	    	(ftBus_s1e),
    	.resultBus_v2w	    	(resultBus_v2w),
    	.MemBus_v2m 	    	(MemBus_v2m)
    	);


endmodule
