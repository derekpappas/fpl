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
//  Title: 	PC Unit Datapath
//  Created:	Sat Mar 26 22:08:03 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  PCUnitDatapath.v,v 7.17 1995/01/28 00:48:03 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//		main sections:
//		    - Jump Mux
//		    - PC incrementer
//		    - PC Chain
//
//	Hierarchy: Torch.instrFetch.
//
//  Revision History:
//	Modified: Thu Dec  1 21:50:37 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified: Wed Nov 30 14:50:32 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed to explicit latch qualification.
//	Modified:	Sun May 22 16:34:11 1994	<ricardog@chroma>
//	* Changed Psi2_q2 to Phi2.
//	Modified:	Tue Apr 12 12:26:42 1994	<ricardog@chroma>
//	* Changed timing of HoldPC_v2r to be _s2r.
//	Modified:	Sat Apr  9 16:49:52 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Fri Apr  1 16:31:53 1994	<ricardog@chroma>
//	* Better implementation of jump mux.
//
`include "torch.h"
`include "torch.v"

module PCUnitDatapath(
    Phi1,
    Phi2,
    Stall_s1,
    Stall_s2,
    Gamma1_s1,
    PCUnitPsi2_s2,
    InstrAddr_s2i, 
    ASBus_s1e,
    PCImmedBus_s2r,
    HoldPC_s2r,
    HoldPC_s2e,
    MipsMode_s2e,
    MipsMode_b_s2e,
    AResultBus_v2e,
    PCDrvResult_s2e,
    RestoreIStallPC_s1,
    MemBus_v2m,
    EPCBufEnable_s2m,
    EPCMuxSel_s2m,
    latchEPC_s1w,
    ExceptVector_s1i,
    Jump0_s1e,
    Jump1_s1e,
    Jump2_s1e,
    Jump3_s1e,
    Jump4_s1e,
    Jump5_v1e
    );
//-----------------------------------------------------------------------------

input		Phi1;			// 
input		Phi2;
input		Stall_s1;
input		Stall_s2;
input		Gamma1_s1;		// Dont move on MemStall
input		PCUnitPsi2_s2;		// Delayed IStall
output	[29:0]	InstrAddr_s2i;		// Instruction Number from PC
					// used on a miss. 30 bits!!!
					// Bit 31 also goes to IFetchControl

// from Register File
input	[31:2]	ASBus_s1e;		// for jump-register

// from IFetch unit
input	[25:0]	PCImmedBus_s2r;		// for jump-immediate & branch offset
input		HoldPC_s2r;		// hold PC if dnop'ed packet
input		HoldPC_s2e;
input		MipsMode_s2e;		// MIPS mode bit from coprocessor
input		MipsMode_b_s2e;

output	[31:0]	AResultBus_v2e;		// for JAL/JALR
input		PCDrvResult_s2e;	// for JAL/JALR -- drive PC onto bus

input		RestoreIStallPC_s1;	// Restart from ICache stall

// Exceptions & Coprocessor 0 operations
output	[31:0]	MemBus_v2m;		// for MFCOP0 (from EPC/EPCN)
input		EPCBufEnable_s2m;	// from cop0, for MFC0 (from EPC/EPCN)
input		EPCMuxSel_s2m;	// originally


input		latchEPC_s1w;
input	[2:0]	ExceptVector_s1i;

input		Jump0_s1e;		// PC Select signals (mutually
input		Jump1_s1e;		// exclusive).
input		Jump2_s1e;
input		Jump3_s1e;
input		Jump4_s1e;
input		Jump5_v1e;

//
// Output type declarations
//
wire	[31:0]	AResultBus_v2e;
wire	[29:0]	EPC_s2, EPCN_s2;


//
// Local Declarations
//
wire	[29:0]	PCChain_s1r;
wire	[29:0]	PCChain_s2r;
wire	[29:0]	PCChain_s1e;
wire	[29:0]	PCChain_s2e;
wire	[29:0]	PCChain_s1m;
wire	[29:0]	PCChain_s2m;
wire	[29:0]	PCChain_s1w;
wire	[29:0]	PCPlus_s1r;
wire	[29:0]	PCPlus_s2r;
wire	[29:0]	PCPlus_v2r;
wire	[29:0]	BranchTarget_s1e;
wire	[29:0]	NewEarlyPC_s1r;
wire	[29:0]	NextPC_v1r;
wire	[25:0]	PCImmedBus_s1e;


wire	[29:0]	ExceptionPC_s1;
wire	[29:0]	IStallPC_s1;




//----------------------------------------------------------------------------
//		New Variables Created due to Partitioning
//----------------------------------------------------------------------------
wire	[29:0] PCImmBusSignExt_s2r;		// sign extended PCImmBus
wire	[29:0] SumBrhTar_v2r;			// output of ADD_30
wire	[29:0] PC_Original_s2i;			// contains PC #
wire	[29:0] Add_1_or_2_s2e;			// either 1 or 2 depending on
						//  mode
wire	[29:0] SumPC_v2i;			// output of the pc adder
wire	[29:0] OutMuxChain_s2r;
wire	[31:0] OutMuxMemBus_v2m;

//---------------------------------------------------------------------------
//			  --- Dummy Wires ---
//---------------------------------------------------------------------------
wire		cOut_v2r;
wire		incCout_v2i;

//----------------------------------------------------------------------------
//  	    	    	  Control Signals
//----------------------------------------------------------------------------

//----------------------------------------------------------------------------
//                        JUMP MUX Section
//----------------------------------------------------------------------------
// Increment PC -- JumpSelect = 0 -- default (see PC increment section)

// Jump to the Immediate Instr -- JumpSelect = 1
PHI2_LATCH_EN_26	LATCH_26_PCImmBus (PCImmedBus_s1e,
			PCImmedBus_s2r, Phi2, ~Stall_s2);

// Register PC -- JumpSelect = 2 (Use ASBus_s1e)

// Mux to Resore PC due to IStall -- JumpSelect = 3
MUX2_30		MUX2_30_RISPC (IStallPC_s1, PCChain_s1r, PCChain_s1e,
			RestoreIStallPC_s1);

// Calculate Exception PC -- JumpSelect = 4
assign ExceptionPC_s1[29:0] =
    { ExceptVector_s1i[2], ~ExceptVector_s1i[2], ~ExceptVector_s1i[2],
      1'b1, 18'b0, ExceptVector_s1i[1], ExceptVector_s1i[0], 6'b0 };

// Branch to the target instr -- JumpSelect = 5
assign PCImmBusSignExt_s2r = { {14{PCImmedBus_s2r[15]}},
				PCImmedBus_s2r[15:0] };
ADD_30	ADD_30_BrhTrg (SumBrhTar_v2r, cOut_v2r, PCImmBusSignExt_s2r,
			PCPlus_s2r, 1'b0);	// Ignore carry_out
PHI2_LATCH_EN_30    LATCH_30_BrhTrg (BranchTarget_s1e, SumBrhTar_v2r,
			Phi2, ~Stall_s2);

// 
// The PC select is done with a two-level MUX to speedup the branch path.
// I have made the assumtion that aside from the branch control signals
// all the other select signals will be available early, so we can use a
// large 5-1 MUX. If any of the other inputs is also late need to consider
// a 3-level MUX.
//
//	Jump0_s1e  if ~Except_s1w & ~IStall_s1 & ~ImmPC_s1e & ~RegPC_s1e
//	Jump1_s1e  if ~Except_s1w & ~IStall_s1 & ImmPC_s1e
//	Jump2_s1e  if ~Except_s1w & ~IStall_s1 & RegPC_s1e
//	Jump3_s1e  if  Except_s1w
//	Jump4_s1e  if ~Except_s1w & IStall_s1
//	Jump5_v1e  if (~Except_s1w & ~IStall_s1) & takenBranch_v1e 
//

MUX5_30	MUX5_30_EarlyPC (
	NewEarlyPC_s1r,
	PCPlus_s1r, {PCChain_s1e[29:26], PCImmedBus_s1e},
	ASBus_s1e[31:2], ExceptionPC_s1[29:0], IStallPC_s1,
	Jump0_s1e, Jump1_s1e, Jump2_s1e, Jump3_s1e, Jump4_s1e);

//--------------------------------------------------------------------------
//			---- Slect Next PC ----
//--------------------------------------------------------------------------
MUX2_30		NextPCMux(NextPC_v1r, BranchTarget_s1e, NewEarlyPC_s1r,
			Jump5_v1e);
PHI1_LATCH_EN_30 LATCH_30_PC (InstrAddr_s2i, NextPC_v1r, Phi1, Gamma1_s1);


//--------------------------------------------------------------------------
//		    ---- PC Incrementer Section ----
//--------------------------------------------------------------------------
assign PC_Original_s2i = {InstrAddr_s2i[29:1], InstrAddr_s2i[0] & MipsMode_s2e};
assign Add_1_or_2_s2e  = {28'b0, MipsMode_b_s2e, MipsMode_s2e };
ADD_30		ADD_30_PC (SumPC_v2i, incCout_v2i, PC_Original_s2i,
			Add_1_or_2_s2e, 1'b0);	// Ignore carry_out
MUX2_30		MUX2_30_HoldPC (PCPlus_v2r, PCPlus_s2r, SumPC_v2i,
			HoldPC_s2r);
PHI2_LATCH_30	LATCH_30_PCPlus_s1r (PCPlus_s1r, PCPlus_v2r,
			Phi2);
PHI1_LATCH_EN_30 LATCH_30_PCPlus_s2r (PCPlus_s2r, PCPlus_s1r, Phi1, Gamma1_s1);

//
// For JAL/JALR/BLTZAL/BGEZAL
//
TRIBUF_32 TRIBUF_32_PC(AResultBus_v2e, { PCPlus_s2r[29:0], 2'b0}, PCDrvResult_s2e);


//--------------------------------------------------------------------------
//			   ---- PC CHAIN ----
//--------------------------------------------------------------------------
//
// Phi2 latches stall (stay closed) on MemStall_s2
// Phi1 latches stall (stay closed) on IStall_s1, and Phi2 latch for IF2
//    also stays closed.
//

//----------------------------------- IF2-----------------------------------
PHI2_LATCH_EN_30 LATCH_30_ChainS1r (PCChain_s1r, InstrAddr_s2i, Phi2, PCUnitPsi2_s2);

//----------------------------------- RF1-----------------------------------
PHI1_LATCH_EN_30 LATCH_30_ChainS2r (PCChain_s2r, PCChain_s1r, Phi1, ~Stall_s1);

//----------------------------------- RF2-----------------------------------

// Here account for the "odd" address of an instruction issued on 2nd cycle
// of a dynamically nop'ed packet.
MUX2_30		MUX2_30_ODD (OutMuxChain_s2r,
			{ PCChain_s2e[29:1], 1'b1 }, PCChain_s2r,
			HoldPC_s2e);
PHI2_LATCH_EN_30	LATCH_30_ChainS1e (PCChain_s1e, OutMuxChain_s2r,
			Phi2, ~Stall_s2);

//----------------------------------- EX1-----------------------------------
PHI1_LATCH_EN_30	LATCH_30_ChainS2e (PCChain_s2e, PCChain_s1e,
			Phi1, ~Stall_s1);

//----------------------------------- EX2-----------------------------------
PHI2_LATCH_EN_30	LATCH_30_ChainS1m (PCChain_s1m, PCChain_s2e,
			Phi2, ~Stall_s2);

//----------------------------------- MEM1-----------------------------------
PHI1_LATCH_EN_30	LATCH_30_ChainS2m (PCChain_s2m, PCChain_s1m,
			Phi1, ~Stall_s1);

//----------------------------------- MEM2-----------------------------------
PHI2_LATCH_EN_30	LATCH_30_ChainS1w (PCChain_s1w, PCChain_s2m,
			Phi2, ~Stall_s2);

//------------------------------ EPC and EPCN---------------------------------
PHI1_LATCH_EN_30	LATCH_30_EPC (EPC_s2, PCChain_s1w, Phi1, latchEPC_s1w);
PHI1_LATCH_EN_30	LATCH_30_EPCN (EPCN_s2, PCChain_s1m, Phi1, latchEPC_s1w);

//
// For a Move-From-Cop0 instruction specifying EPC or EPCN
// I am assuming that either EPCSel or EPCNSel comes on and not both
//
MUX2_32		MUX2_32_EPC (OutMuxMemBus_v2m,
			{ EPC_s2[29:0],  2'b0 }, { EPCN_s2[29:0], 2'b0 },
			EPCMuxSel_s2m);
TRIBUF_32	TRIBUF_32_EPC (MemBus_v2m, OutMuxMemBus_v2m, EPCBufEnable_s2m);


endmodule				  // PCUnitDatapath
