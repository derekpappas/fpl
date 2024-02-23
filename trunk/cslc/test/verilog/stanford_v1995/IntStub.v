//
//  Title: 	Integer Unit Stub
//  Created:	Thu Mar  4 15:12:32 1993
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  IntStub.v,v Version 1.7 Last Edit 1995/01/28 00:46:09
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This stub is used to test the TORCH FP stand-alone. It 
//  	    reads the file containing the instructions and sends them to 
//  	    FP unit. Also generates the clocks. In general tries to mimic
//  	    what the integer unit of TORCH does.
//
//	Hierarchy: 
//

//
// Stop when instruction matches LAST_INSTR
//
`define LAST_INSTR  	40'h00deadbeef

//
// Use macros to reference signals inside the FPUnit
//
`define FPUNIT	    	IntStub.FPUnit
`define	FUNCTION_R  	`FPUNIT.function_s2r
`define VALID_R	    	`FPUNIT.fpOpIsValid_v2r
//`define CSR_E	    	32'h0
`define CSR_E	    	`FPUNIT.FPCtrl.fpCSR_s1w
`define FS_E	    	`FPUNIT.fsBus_s1e
`define FT_E	    	`FPUNIT.ftBus_s1e
`define	RESULT_W    	`FPUNIT.resultBus_v2w
`define	CSR_W	    	`FPUNIT.FPCtrl.fpCSR_s1w
//`define CSR_W	    	32'h0


module IntStub ();

wire	    	IStall_s1;
wire	    	MemStall_s2;
wire	    	Except_s1w;
wire	    	FPExcept_v2m;
wire [63:0] 	MemBus_v2m;

reg	    	Phi1;
reg	    	Phi2;
reg  [40:0] 	AInstr_s2r;

reg  [39:0]	cacheData_s2[2047:0];	  // Store instruction stream
//reg  [39:0] 	cacheLoader[2047];
reg  [319:0]	cacheLine_s2;		  // Temp storage for line read from $$
reg  [31:0] 	PC_s2;
reg 	    	done;			  // All instructions executed flag

//
// Pipeline registers
//
reg [63:0]  	result_e, result_m, result_w;
reg [39:0]  	instr_e, instr_m, instr_w;
reg [31:0]  	csr_e, csr_m, csr_w;
reg 	    	valid_e, valid_m, valid_w;

integer	    	op, nocheck;


assign #1 IStall_s1 = 1'b0;
assign #1 MemStall_s2 = 1'b0;
assign #1 Except_s1w = 1'b0;

initial begin
    Phi1 = 1'b0;
    Phi2 = 1'b0;
    $readmemh("fp_instr.data", cacheData_s2, 0);
    PC_s2 = 0;
    done = 0;
end

always begin
    #100
    Phi1 = 1'b1;
    Phi2 = 1'b0;
    #100
    Phi1 = 1'b0;
    Phi2 = 1'b1;
end

always @(Phi1) begin
    if (Phi1) begin
    	AInstr_s2r = cacheData_s2[PC_s2[10:0]];
    	PC_s2 = PC_s2 + 1'b1;
    	if (AInstr_s2r == `LAST_INSTR) begin
    	    done = 1;
    	    #1000
    	    $stop;
	end
    end
end

FPUnit FPUnit(
		.Phi1  			(Phi1),
		.Phi2		    	(Phi2),
		.IStall_s1		(IStall_s1),
		.MemStall_s2		(MemStall_s2),
		.Except_s1w		(Except_s1w),
		.AInstr_s2r		(AInstr_s2r),
		.MemBus_v2m		(MemBus_v2m),
		.FPExcept_v2m		(FPExcept_v2m)
    	);


initial begin
    if ($test$plusargs("nocheck")) 
	nocheck = 1;
    else
	nocheck = 0;

    if (!$test$plusargs("nowaves")) begin
    	$gr_position("waves", 0, 0, 890, 700);
    	$gr_waves("Phi1", Phi1, "Phi2", Phi2);
    	$gr_addwaves(
    	    "Instr", AInstr_s2r,
    	    "fsBus", FPUnit.fsBus_s1e,
    	    "ftBus", FPUnit.ftBus_s1e,
    	    "result", FPUnit.resultBus_v2w
    	);
	$gr_addwaves(
	    "fs", FPUnit.fsSpec_s2r,
	    "ft", FPUnit.ftSpec_s2r,
	    "fd", FPUnit.fdSpec_s2r
	);
    	$gr_addwaves(
    	    "valid", FPUnit.fpOpIsValid_v2r,
    	    "add", FPUnit.fpOpIsAdd_s1e,
    	    "sub", FPUnit.fpOpIsSub_s1e,
    	    "mul", FPUnit.fpOpIsMul_s1e,
    	    "div", FPUnit.fpOpIsDiv_s1e
    	);
	$gr_addwaves(
	    "Except", FPUnit.FPExceptions_v2w
	);

    end
    if (!$test$plusargs("noregs")) begin
    	$gr_regs(" Reg     Value",
	     " r0      %h                   %g ",
		FPUnit.FPRegFile.FPregisters[0],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[0]),
	     " r2      %h                   %g ",
		FPUnit.FPRegFile.FPregisters[1],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[1]),
	     " r4      %h                   %g ",
		FPUnit.FPRegFile.FPregisters[2],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[2]),
	     " r6      %h                   %g ",
		FPUnit.FPRegFile.FPregisters[3],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[3]),
	     " r8      %h                   %g ",
		FPUnit.FPRegFile.FPregisters[4],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[4]),
	     " r10     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[5],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[5]),
	     " r12     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[6],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[6]),
	     " r14     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[7],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[7]),
	     " r16     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[8],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[8]),
	     " r18     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[9],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[9]),
	     " r20     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[10],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[10]),
	     " r22     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[11],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[11]),
	     " r24     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[12],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[12]),
	     " r26     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[13],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[13]),
	     " r28     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[14],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[14]),
	     " r30     %h                   %g ",
		FPUnit.FPRegFile.FPregisters[15],
		$bitstoreal(FPUnit.FPRegFile.FPregisters[15]),
	     "",
	     "    CSR       Except   Trap   Stick  RM ",
	     " %h           %b       %b     %b     %b ",
	     FPUnit.FPCtrl.fpCSR_s1w,
	     FPUnit.FPCtrl.fpCSR_s1w[17:12],
	     FPUnit.FPCtrl.fpCSR_s1w[11:7],
	     FPUnit.FPCtrl.fpCSR_s1w[6:2],
	     FPUnit.FPCtrl.fpCSR_s1w[1:0]

//	     " CSR     %h ", FPUnit.FPCtrl.fpCSR_s1w,
//	     " Except    %b ", FPUnit.FPCtrl.fpCSR_s1w[17:12],
//	     " Trap       %b ", FPUnit.FPCtrl.fpCSR_s1w[11:7],
//	     " Sticky     %b ", FPUnit.FPCtrl.fpCSR_s1w[6:2],
//	     " RM            %b ", FPUnit.FPCtrl.fpCSR_s1w[1:0]
    	);
    end
end // initial

always @(posedge Phi1) begin
    if (!nocheck) begin
	if (result_w != `RESULT_W && valid_w == 1'b1) begin
	    $display("Error: at time %t result mismatch.", $time);
	    $display("Error: result = 0x%x\tcomputed = 0x%x", `RESULT_W, result_w);
	    $display("Error: instr = 0x%x", instr_w);
	end

	if (csr_w != `CSR_W && valid_w == 1'b1) begin
	    $display("Error: at time %t csr mismatch.", $time);
	    $display("Error: csr = 0x%x\tcomputed = 0x%x", `CSR_W, csr_w);
	    $display("Error: instr = 0x%x", instr_w);
        end
    end

    // Pipe result to 1F
    result_w = result_m;
    result_m = result_e;

    // Pipe csr
    csr_w = csr_m;
    csr_m = csr_e;

    // Pipe valid bit
    valid_w = valid_m;
    valid_m = valid_e;

    // Keep instructions for easier debugging.
    instr_w = instr_m;
    instr_m = instr_e;
    instr_e = AInstr_s2r;

    if (done == 1'b0 && `VALID_R == 1'b1) begin
    	op = {26'b0, `FUNCTION_R};
    	$do_fp_op(`CSR_E, op, `FS_E, `FT_E, result_e, csr_e);

    end
    valid_e = ~done & `VALID_R;
    end

endmodule


