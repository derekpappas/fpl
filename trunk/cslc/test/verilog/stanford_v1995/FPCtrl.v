//
//  Title: 	Floating Point Control Unit
//  Created:	Tue Feb 23 12:27:12 1993
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  FPCtrl.v,v Version 1.5 Last Edit 1995/01/28 00:46:01
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This units currently decodes the instructions and 
//  	    generates control signals for the datapath. In the future it
//  	    will also deal with exceptions and stalls.
//
//	Hierarchy: system.processor.FPUnit.FPCtrl
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



module FPCtrl(
    	Phi1,
    	Phi2,
    	IStall_s1,
    	MemStall_s2,
    	opcode_s2r,
    	function_s2r,
    	format_s2r,
    	FPExceptions_v2w,
    	fpOpIsValid_v2r,
    	fpOpIsAdd_s1e,
    	fpOpIsSub_s1e,
    	fpOpIsMul_s1e,
    	fpOpIsDiv_s1e,
    	fpOpIsAbs_s1e,
    	fpOpIsMov_s1e,
    	fpOpIsNeg_s1e,
    	fpOpIsCmp_s1e,
    	fpOpIsSingle_s1e,
    	fpOpIsDouble_s1e,
    	fpOpIsFixed_s1e,
    	FPExcept_v2m
    	);

//
// Inputs
//
input	    	Phi1;
input	    	Phi2;
input	    	IStall_s1;
input	    	MemStall_s2;
input [5:0]	opcode_s2r;		  // Opcode field from A-side instr
input [5:0] 	function_s2r;		  // Function field. These fields are
input [3:0] 	format_s2r;		  // picked-out FPUnit. Format field.
input [5:0] 	FPExceptions_v2w;	  // Exception flags from datapath

//
// Outputs
//
output	    	fpOpIsValid_v2r;
output	    	fpOpIsAdd_s1e;
output	    	fpOpIsSub_s1e;
output	    	fpOpIsMul_s1e;
output 	    	fpOpIsDiv_s1e;
output 	    	fpOpIsAbs_s1e;
output 	    	fpOpIsMov_s1e;
output 	    	fpOpIsNeg_s1e;
output 	    	fpOpIsCmp_s1e;
output 	    	fpOpIsSingle_s1e;
output 	    	fpOpIsDouble_s1e;
output 	    	fpOpIsFixed_s1e;
output	    	FPExcept_v2m;

//
// Register declarations
//
reg 	    	fpOpIsAdd_s1e;
reg 	    	fpOpIsSub_s1e;
reg 	    	fpOpIsMul_s1e;
reg 	    	fpOpIsDiv_s1e;
reg 	    	fpOpIsAbs_s1e;
reg 	    	fpOpIsMov_s1e;
reg 	    	fpOpIsNeg_s1e;
reg 	    	fpOpIsCmp_s1e;

reg 	    	fpOpIsSingle_s1e;
reg 	    	fpOpIsDouble_s1e;
reg 	    	fpOpIsFixed_s1e;

reg 	    	fpOpIsUnim_s1e;
reg 	    	fpOpIsUnim_s2e;
reg 	    	fpOpIsUnim_s1m;
reg 	    	fpOpIsUnim_s2m;

reg 	    	fpOpIsValid_s1e;
reg 	    	fpOpIsValid_s2e;
reg 	    	fpOpIsValid_s1m;
reg 	    	fpOpIsValid_s2m;
reg 	    	fpOpIsValid_s1w;
reg 	    	fpOpIsValid_s2w;



//
// Control and Status Register (CSR)
//
reg [31:0]  	fpCSR_s2m, fpCSR_s1w;

//
// Temporary assignment statement
//
assign #1 FPExcept_v2m = fpOpIsUnim_s2e | FPExceptions_v2w[5] | 
    	(|(FPExceptions_v2w[4:0] & fpCSR_s2m[11:7]));

//
// This signal goes to the register file. No nead to latch it here.
//
assign #1 fpOpIsValid_v2r = (opcode_s2r == `COP1);

//
// Initial bloack
//
initial begin
    fpCSR_s2m = 0; 
    fpCSR_s1w = 0;
end

//
// Decode the instruction and latch control signals
//
always @(Phi2 or opcode_s2r or function_s2r or format_s2r) begin
    if (Phi2 == 1'b1) begin
	fpOpIsAdd_s1e = 1'b0; fpOpIsSub_s1e = 0; fpOpIsMul_s1e = 1'b0;
	fpOpIsDiv_s1e = 1'b0; fpOpIsAbs_s1e = 0; fpOpIsMov_s1e = 1'b0;
	fpOpIsNeg_s1e = 1'b0; fpOpIsCmp_s1e = 0;
    	if (opcode_s2r == `COP1)
	    casex (function_s2r)    	  // synopsys full_case parallel_case
	    	`FP_ADD: fpOpIsAdd_s1e = 1'b1;
    	    	`FP_SUB: fpOpIsSub_s1e = 1'b1;
    	    	`FP_MUL: fpOpIsMul_s1e = 1'b1;
    	    	`FP_DIV: fpOpIsDiv_s1e = 1'b1;
    	    	`FP_ABS: fpOpIsAbs_s1e = 1'b1;
    	    	`FP_MOV: fpOpIsMov_s1e = 1'b1;
    	    	`FP_NEG: fpOpIsNeg_s1e = 1'b1;
    	    	`FP_CVT_S: fpOpIsUnim_s1e = 1'b1;
    	    	`FP_CVT_D: fpOpIsUnim_s1e = 1'b1;
    	    	`FP_CVT_W: fpOpIsUnim_s1e = 1'b1;
    	    	`FP_CMP: fpOpIsCmp_s1e = 1'b1;
    	    	default: begin
    	    	    fpOpIsAdd_s1e = 1'bx;
    	    	    fpOpIsSub_s1e = 1'bx;
    	    	    fpOpIsMul_s1e = 1'bx;
    	    	    fpOpIsDiv_s1e = 1'bx;
    	    	    fpOpIsAbs_s1e = 1'bx;
    	    	    fpOpIsMov_s1e = 1'bx;
    	    	    fpOpIsNeg_s1e = 1'bx;
    	    	    fpOpIsCmp_s1e = 1'bx;
    	    	    fpOpIsUnim_s1e = 1'b1;
    	    	end
	    endcase
    	else
	    fpOpIsUnim_s1e = 1'b1;

//
// Always decode the format type
//
    	case (format_s2r)	         // synopsys full_case parallel_case
    	    `FP_SINGLE: begin
    	    	fpOpIsSingle_s1e = 1'b1;
    	    	fpOpIsDouble_s1e = 1'b0;
    	    	fpOpIsFixed_s1e = 1'b0;
    	    end
    	    `FP_DOUBLE: begin
    	    	fpOpIsSingle_s1e = 1'b0;
    	    	fpOpIsDouble_s1e = 1'b1;
    	    	fpOpIsFixed_s1e = 1'b0;
    	    end
   	    `FP_FIXED: begin
    	    	fpOpIsSingle_s1e = 1'b0;
    	    	fpOpIsDouble_s1e = 1'b0;
    	    	fpOpIsFixed_s1e = 1'b1;
    	    end
    	    default: begin
    	    	fpOpIsSingle_s1e = 1'bx;
    	    	fpOpIsDouble_s1e = 1'bx;
    	    	fpOpIsFixed_s1e = 1'bx;
    	    end
    	endcase
    end					  // Of Phi2 latches
end

always @(Phi2 or FPExceptions_v2w or fpCSR_s2m) begin
    if (Phi2) begin
    	#10 
    	fpCSR_s1w = fpCSR_s2m;
    	if (fpOpIsValid_s2w) begin
	    fpCSR_s1w[17:12] = FPExceptions_v2w[5:0];
    	    if (FPExceptions_v2w) begin
	    	fpCSR_s1w[6:2] = FPExceptions_v2w[4:0];
	    end
	end
    end
end

always @(Phi1 or fpCSR_s1w) begin
    if (Phi1) begin
    	fpCSR_s2m = fpCSR_s1w;
    end
end

always @(Phi1 or fpOpIsUnim_s1e or fpOpIsUnim_s1m or fpOpIsValid_s1e or
    fpOpIsValid_s1m or fpOpIsValid_s1w) begin
    if (Phi1 == 1'b1) begin
    	#10
    	fpOpIsUnim_s2e = fpOpIsUnim_s1e;
    	fpOpIsUnim_s2m = fpOpIsUnim_s1m;
    	fpOpIsValid_s2e = fpOpIsValid_s1e;
    	fpOpIsValid_s2m = fpOpIsValid_s1m;
    	fpOpIsValid_s2w = fpOpIsValid_s1w;
    end
end
always @(Phi2 or fpOpIsUnim_s2e or fpOpIsValid_v2r or fpOpIsValid_s2e or
    fpOpIsValid_s2m) begin

    if (Phi2 == 1'b1) begin
    	#10
    	fpOpIsUnim_s1m = fpOpIsUnim_s2e;
    	fpOpIsValid_s1e = fpOpIsValid_v2r;
    	fpOpIsValid_s1m = fpOpIsValid_s2e;
    	fpOpIsValid_s1w = fpOpIsValid_s2m;
    end
end

endmodule


