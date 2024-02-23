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
//  Title: 	A-side ALU
//  Created:	Nov 1991
//  Author: 	Dave Glasco
//
//
//  AALU.v,v 7.15 1995/01/28 00:42:41 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This module contains the datapath blocks that constitute
//  	    the A-side ALU. It includes the  adder, the logic unit and
//  	    the multiplier. This file contains all the code for the multiplier
//  	    (which remains in behavioral form). All the control signals are
//  	    generated in AALUControl. Signals between synopsys translate_on/off
//	    are for the multiplier and would not be part of our
//	    implementation. Some of the outputs have a tri-state driver
//	    while other are muxed and then driven on the output bus. This is
//	    to make the critical paths fast and reduce the capacitance on 
//	    the bus.
//
//	Hierarchy: system.processor.decodeExec.DataPath.AExecuteUnit.AALU.
//
//  Revision History:
//	Modified:	Sun May 22 16:20:59 1994	<ricardog@chroma>
//	* Removed Psi2_q2.
//	Modified:	Fri Apr  8 15:33:02 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Wed Mar 23 17:38:13 1994	<ricardog@chroma>
//	* Changed ADBus_v2e to AResultBus_v2e.
//	Modified:	Sun Mar 20 16:10:25 1994	<ricardog@chroma>
//	* Moved latches before adder.
//	Modified:	Dec 2 1992	<ricardog@bill>
//	* Added synopsys comments.
//	Modified:	Nov 22 1992	<ricardog@bill>
//	* Removed control logic.
//
`include "torch.h"

module AALU(
// Inputs
    Phi1,
    Phi2,
    Stall_s2,
    ALatchInputs_s1e,
`ifdef MULTIPLIER
// synopsys translate_off
    AKill_s1e,
    MultOp_s2e,
    DivOp_s2e,
    SignedMDOp_s2e,
    StoreHiLo_s2e,
    LoadHiLo_s2e,
    HiLo_s2e,
// synopsys translate_on
`endif
    AInstr_s2r,
    ASBus_s1e,
    ATBus_s1e,
    AselT_s1e,
    AselTBAR_s1e,
    AselImm_s1e,
    AselImmBAR_s1e,
    AImm26Bit_s2r,
    AImmShift16_s2r,
    AdefaultImm_s2r,
    AImmSignEx_s2r,
    AcarryIn_s2e,
    ASetRes_v2e,
    AAndOp_s2e,
    AOrOp_s2e,
    AXorOp_s2e,
    ANorOp_s2e,
    AlogicInst_s2e,
`ifdef MULTIPLIER
// synopsys translate_off
    ldHi_s2e,
    ldLo_s2e,
    HLNotReady_s2e,
// synopsys translate_on
`endif
// Outputs
    AALUDrv_q2e,
    AAddDrv_q2e,
    ASetDrv_q2e,
    AResultBus_v2e,
    AcarryOut_v2e,
    ATorImmMsb_s1e,
    AAddResMsb_v2e
    );

//
// Clocks
//
input		Phi1;
input		Phi2;


//
// Stalls & enables
//
input		Stall_s2;
input		ALatchInputs_s1e;

`ifdef MULTIPLIER
// synopsys translate_off
input		AKill_s1e, MultOp_s2e, DivOp_s2e, SignedMDOp_s2e;
input		StoreHiLo_s2e, LoadHiLo_s2e, HiLo_s2e;
// synopsys translate_on
`endif

//
// ALU sources
//
input	[31:0]	ASBus_s1e;
input	[31:0]	ATBus_s1e;

//
// A-side instructions needed to get immediate value
//
input	[31:0]	AInstr_s2r;
	    
//
// ALU Controls
//
input		AselT_s1e;
input		AselTBAR_s1e;
input		AselImm_s1e;
input		AselImmBAR_s1e;
input		AImm26Bit_s2r;
input		AImmShift16_s2r;
input		AdefaultImm_s2r;
input		AImmSignEx_s2r;
input		AcarryIn_s2e;
input		ASetRes_v2e;
input		AAndOp_s2e;
input		AOrOp_s2e;
input		AXorOp_s2e;
input		ANorOp_s2e;
input		AlogicInst_s2e;
`ifdef MULTIPLIER
// synopsys translate_off
input		ldHi_s2e, ldLo_s2e;
// synopsys translate_on
`endif
input		AALUDrv_q2e;
input		AAddDrv_q2e;
input		ASetDrv_q2e;

//
// ALU Output
//
output	[31:0]	AResultBus_v2e;
output 		AcarryOut_v2e;
output		ATorImmMsb_s1e;
output		AAddResMsb_v2e;
`ifdef MULTIPLIER
// synopsys translate_off
output		HLNotReady_s2e;
// synopsys translate_on
`endif

wire	[31:0]	torImm_s1e,		// Mux TBus or ImmBus for ALU input
		TBAR_s1e,		// Tbus complement
		ImmBAR_s1e,		// Immediate Complement
		tempRes_v2e,		// temporary bus
		LURes_v2e,		// logic unit result
		Hi_s2w,
		Lo_s2w,
		addRes_v2e;		// Adder Output

wire	[31:0]	src1Bus_s2e;
wire	[31:0]	src2Bus_s2e;

wire	[31:0]	ImmBus_s2r, Imm_s1e;

assign ATorImmMsb_s1e = torImm_s1e[31];
assign AAddResMsb_v2e = addRes_v2e[31];

//
// Get immediate value and latch it.
//
MUX3_32 AImmMux(ImmBus_s2r,
		{{6{AInstr_s2r[25]}}, AInstr_s2r[25:0]},
		{{AInstr_s2r[15:0]}, {16'b0}},
		{{16{AImmSignEx_s2r}},AInstr_s2r[15:0]},
		AImm26Bit_s2r, AImmShift16_s2r, AdefaultImm_s2r);
PHI2_LATCH_EN_32 immLatch(Imm_s1e, ImmBus_s2r, Phi2, ~Stall_s2);

//
// Complements the adder inputs
//
INV_32_4X	ImmBAR(ImmBAR_s1e, Imm_s1e);
INV_32_4X	TBAR(TBAR_s1e, ATBus_s1e);

//
// Select one of the possible imm or T bus values
//
MUX4_32		TorImm(torImm_s1e,
			ATBus_s1e, TBAR_s1e,
			Imm_s1e, ImmBAR_s1e,
			AselT_s1e, AselTBAR_s1e,
			AselImm_s1e, AselImmBAR_s1e);

//
// Latch the inputs before they go into the FU's
//
PHI1_LATCH_EN_32	Src1Bus(src1Bus_s2e, ASBus_s1e, Phi1, ALatchInputs_s1e);
PHI1_LATCH_EN_32	Src2Bus(src2Bus_s2e, torImm_s1e, Phi1, ALatchInputs_s1e);

//
// Adder
//
ADD_32		AadderU(addRes_v2e, AcarryOut_v2e, src1Bus_s2e, 
			src2Bus_s2e, AcarryIn_s2e);

//
// Logic Unit
//
LUNIT_32 	AlogicU(LURes_v2e, src1Bus_s2e, src2Bus_s2e,
			AAndOp_s2e, AOrOp_s2e, AXorOp_s2e, 
			ANorOp_s2e);

//
// Multiply and Divide Unit
//
`ifdef MULTIPLIER
// synopsys translate_off
muldiv		muldiv(Phi1, Phi2, AKill_s1e, src1Bus_s2e, src2Bus_s2e,
			MultOp_s2e, DivOp_s2e, SignedMDOp_s2e,
			StoreHiLo_s2e, LoadHiLo_s2e, HiLo_s2e,
			Hi_s2w, Lo_s2w, HLNotReady_s2e);
// synopsys translate_on
`endif

`ifdef MULTIPLIER
MUX3_32		outMUX(tempRes_v2e,
			LURes_v2e, Hi_s2w, Lo_s2w,
			AlogicInst_s2e, ldHi_s2e, ldLo_s2e);
`else
INV_32_4X	outBUF(tempRes_v2e, LURes_v2e);
`endif

//
// Tri-state drivers for outputs
//
TRIBUF_32	addBuf(AResultBus_v2e, addRes_v2e, AAddDrv_q2e);
TRIBUF_32	setBuf(AResultBus_v2e, {31'b0, ASetRes_v2e}, ASetDrv_q2e);
TRIBUF_32	outBuf(AResultBus_v2e, tempRes_v2e, AALUDrv_q2e);


endmodule				  // AALU

`ifdef MULTIPLIER
// synopsys translate_off
// vcheck_off
// 
// A perfect example of yucky verilog code!!!
// Dont blame me please...
//
module muldiv(
// Clocks
    Phi1,
    Phi2,
// Inputs
    AKill_s1e,
    src1Bus_s2e,
    src2Bus_s2e,
    MultOp_s2e, 
    DivOp_s2e,
    SignedMDOp_s2e,
    StoreHiLo_s2e,
    LoadHiLo_s2e,
    HiLo_s2e,
// Outputs
    Hi_s2m,
    Lo_s2m,
    HLNotReady_s2e
    );

//
// Clocks
//
input		Phi1;
input		Phi2;

//
// Inputs
//
input		AKill_s1e;
input		MultOp_s2e;
input		DivOp_s2e;
input		SignedMDOp_s2e;
input		StoreHiLo_s2e;
input		LoadHiLo_s2e;
input		HiLo_s2e;

input	[31:0]	src1Bus_s2e, src2Bus_s2e;

output	[31:0]	Hi_s2m, Lo_s2m;
output		HLNotReady_s2e;



reg		AKill_s2e;
reg	[31:0]	Hi_s1;
reg	[31:0]	Hi_s2m;
reg	[31:0]	Lo_s1;
reg	[31:0]	Lo_s2m;
reg	[63:0]	mdResult_s1;
reg	[63:0]	mdRemind_s1;
reg	[63:0]	mdSrc1_s1;
reg	[63:0]	mdSrc2_s1;

muldivFSM muldivFSM(Phi1, Phi2, MultOp_s2e, DivOp_s2e, LoadHiLo_s2e,
		    HLNotReady_s2e);

initial begin
    Hi_s1 = 32'd0;
    Lo_s1 = 32'd0;
end
			
// Mult/Div and Store Hi/Lo during Phi2
always @(Phi2 or AKill_s2e or src1Bus_s2e or src2Bus_s2e or HiLo_s2e or 
	MultOp_s2e or DivOp_s2e or SignedMDOp_s2e or StoreHiLo_s2e) begin
    // Dont do if stall cycle or not valid instruction
    if (Phi2 & ~AKill_s2e) begin
	// Multipy
        if (MultOp_s2e) begin
	    // Signed
	    if (SignedMDOp_s2e) begin
		// Sign extend to 64 bits
		mdSrc1_s1 = {{32{src1Bus_s2e[31]}}, src1Bus_s2e};
		mdSrc2_s1 = {{32{src2Bus_s2e[31]}}, src2Bus_s2e};
		// Absolute value
		if (mdSrc1_s1[63])
		    mdSrc1_s1 = - mdSrc1_s1;
		if (mdSrc2_s1[63])
		    mdSrc2_s1 = - mdSrc2_s1; 
		// Do multiplication (64 bit)
		mdResult_s1 = mdSrc1_s1 * mdSrc2_s1;
		// Fix sign ?
		if (src1Bus_s2e[31] ^ src2Bus_s2e[31])
		    mdResult_s1 = - mdResult_s1;
	    end
	    // Unsigned
	    else begin
		// Extend with 0
		mdSrc1_s1 = {{32'b0}, src1Bus_s2e[31:0]};
		mdSrc2_s1 = {{32'b0}, src2Bus_s2e[31:0]};
		// Do multiplication
 	        mdResult_s1 = mdSrc1_s1 * mdSrc2_s1;
	    end
	// Store results into Hi/Lo
	Hi_s1 = mdResult_s1[63:32];
	Lo_s1 = mdResult_s1[31:0];
	end
        else if (DivOp_s2e) begin
    	    // Divide
	    if (SignedMDOp_s2e) begin
		// Signed
		// Sign extend to 64 bits
		mdSrc1_s1 = {{32{src1Bus_s2e[31]}}, src1Bus_s2e};
		mdSrc2_s1 = {{32{src2Bus_s2e[31]}}, src2Bus_s2e};
		// Absolute value
		if (mdSrc1_s1[63])
		    mdSrc1_s1 = - mdSrc1_s1;
		if (mdSrc2_s1[63])
		    mdSrc2_s1 = - mdSrc2_s1; 
		// Do divide (64 bits)
		mdResult_s1 = mdSrc1_s1 / mdSrc2_s1;
	        mdRemind_s1 = mdSrc1_s1 % mdSrc2_s1;
		// Fix sign ?
		if ((src1Bus_s2e[31]) ^ (src2Bus_s2e[31])) begin
		    mdRemind_s1 = -mdRemind_s1;
		    mdResult_s1 = - mdResult_s1;
		end
	    end
	    else begin
		// Unsigned
		// Extend with 0
		mdSrc1_s1 = {{32'b0}, src1Bus_s2e[31:0]};
		mdSrc2_s1 = {{32'b0}, src2Bus_s2e[31:0]};
		// Do divide
 	        mdResult_s1 = mdSrc1_s1 / mdSrc2_s1;
 	        mdRemind_s1 = mdSrc1_s1 % mdSrc2_s1;
	    end
	    // Store results into Hi/Lo
            Lo_s1 = mdResult_s1[31:0];
	    Hi_s1 = mdRemind_s1[31:0];
	end
        else if (StoreHiLo_s2e) begin 
	    // Store HiLo
	    if (HiLo_s2e)
		Hi_s1 = src2Bus_s2e;	  // Store hi
	    else
		Lo_s1 = src2Bus_s2e;	  // Store Lo
        end
    end
end

//
// Keep values of Hi and Lo during Phi2 so they can be read out
//
always @(Phi1 or Hi_s1 or Lo_s1 or AKill_s1e) begin
    if (Phi1) begin
	`TICK
	Hi_s2m = Hi_s1;
	Lo_s2m = Lo_s1;
	AKill_s2e = AKill_s1e;
    end
end
endmodule


`define DIVDLY	6'd30 // delay for DIV 30 cycles
`define MULDLY	6'd10 // delay for MUL 10 cycles

module muldivFSM(
    Phi1,
    Phi2,
    MultOp_s2e, 
    DivOp_s2e,
    LoadHiLo_s2e,
    HLNotReady_s2e
    );

//
// Clocks
//
input		Phi1;
input		Phi2;

//
// Inputs
//
input		MultOp_s2e;		  // Start a multiply
input		DivOp_s2e;		  // Start a divide
input		LoadHiLo_s2e;		  // Load contents of Hi/Lo

//
// Outputs
//
output		HLNotReady_s2e;

reg	[5:0]	state_s1;
reg	[5:0]	state_s2 ;

wire		HLNotReady_s2e;

assign HLNotReady_s2e = (state_s2 != 6'd0) & LoadHiLo_s2e;

always @(Phi1 or state_s1)
    if (Phi1) state_s2 = state_s1;

always @(Phi2 or MultOp_s2e or DivOp_s2e or state_s2) begin
    if (Phi2) begin
	state_s1 = (MultOp_s2e) ? `MULDLY : (DivOp_s2e) ? `DIVDLY :
				(state_s2 == 6'd0) ? 6'd0 : state_s2 - 6'd1;
    end
end

initial begin
    state_s1 = 6'd0;
end

endmodule
// synopsys translate_on
// vcheck_on
`endif
