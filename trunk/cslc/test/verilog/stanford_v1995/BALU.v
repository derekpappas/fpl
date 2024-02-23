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
//  Title: 	B-side ALU
//  Created:	Nov 1991
//  Author: 	Dave Glasco
//
//
//  BALU.v,v 7.12 1995/02/08 01:30:15 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This module contains the datapath blocks that constitute
//  	    the B-side ALU. It includes the adder and the logic unit.
//	    The result from the adder is sent on a dedicated bus to the 
//	    ld/st unit to prevent having to drive the heavily loaded
//	    BResultBus_v2e.
//
//	Hierarchy: system.processor.decodeExec.BExecuteUnit.BALU.
//
//  Revision History:
//	Modified:	Sun May 22 16:21:57 1994	<ricardog@chroma>
//	* Removed Psi2_q2.
//	Modified:	Fri Apr  8 17:19:54 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Sun Mar 20 16:10:01 1994	<ricardog@chroma>
//	* Moved latches before adder.
//	Modified:	Nov 22 1992	<ricardog@bill>
//	* Removed control logic.
//

module BALU(
// Clocks
    Phi1,
    Phi2,
    Stall_s2,
    BLatchInputs_s1e,
    BenabMemAddrLatch_s2e,
// Inputs
    BInstr_s2r,
    BSBus_s1e,
    BTBus_s1e,
    BselT_s1e,
    BselTBAR_s1e,
    BselImm_s1e,
    BselImmBAR_s1e,
    BImm26Bit_s2r,
    BImmShift16_s2r,
    BdefaultImm_s2r,
    BImmSignExt_s2r,
    BcarryIn_s2e,
    BSetRes_v2e,
    BAndOp_s2e,
    BOrOp_s2e,
    BXorOp_s2e,
    BNorOp_s2e,
    BALUDrv_q2e,
    BAddDrv_q2e,
    BSetDrv_q2e,
// Outputs
    BResultBus_v2e,
    MemAddr_s1m,
    BcarryOut_v2e,
    BTorImmMsb_s1e,
    BAddResMsb_v2e
    );

//
// Clocks
//
input		Phi1;
input		Phi2;

//
// Stalls & Enables
//
input		Stall_s2;
input		BLatchInputs_s1e;
input		BenabMemAddrLatch_s2e;

//
// ALU sources
//
input	[31:0] 	BSBus_s1e;
input	[31:0]	BTBus_s1e;

//
// B-side instructions needed to get immediate value
//
input	[31:0]	BInstr_s2r;
	    
//
// ALU Controls
//
input		BselT_s1e;
input		BselTBAR_s1e;
input		BselImm_s1e;
input		BselImmBAR_s1e;
input		BImm26Bit_s2r;
input		BImmShift16_s2r;
input		BdefaultImm_s2r;
input		BImmSignExt_s2r;
input		BcarryIn_s2e;
input		BSetRes_v2e;
input		BAndOp_s2e;
input		BOrOp_s2e;
input		BXorOp_s2e;
input		BNorOp_s2e;
input		BALUDrv_q2e;
input		BAddDrv_q2e;
input		BSetDrv_q2e;

//
// ALU Output
//
output	[31:0]	BResultBus_v2e;
output	[31:0]	MemAddr_s1m;
output 		BcarryOut_v2e;
output		BTorImmMsb_s1e;
output		BAddResMsb_v2e;


//
// Local wires
//
wire	[31:0]	torImm_s1e;		// Mux TBus or ImmBus for ALU input
wire	[31:0]	TBAR_s1e;		// Tbus complement
wire	[31:0]	ImmBAR_s1e;		// Immediate Complement
wire	[31:0]	LURes_v2e;		// logic unit result
wire	[31:0]	addRes_v2e;		// Adder Output

//
// These are the inputs to the FU's
//
wire	[31:0]	src1Bus_s2e;
wire	[31:0]	src2Bus_s2e;

//
// Immediate value extracted from instructions
//
wire [31:0]	ImmBus_s2r, Imm_s1e;

//
// Result of adder to the data cache
//
wire	[31:0]	MemAddr_s1m;

//
// Used to compute overflow and set bits
//
assign BTorImmMsb_s1e = torImm_s1e[31];
assign BAddResMsb_v2e = addRes_v2e[31];

//
// Get immediate value and latch it.
//
MUX3_32 BImmMux(ImmBus_s2r,
		{{6{BInstr_s2r[25]}}, BInstr_s2r[25:0]},
		{{BInstr_s2r[15:0]}, {16'b0}},
		{{16{BImmSignExt_s2r}}, BInstr_s2r[15:0]},
		BImm26Bit_s2r, BImmShift16_s2r, BdefaultImm_s2r);
PHI2_LATCH_EN_32 immLatch(Imm_s1e, ImmBus_s2r, Phi2, ~Stall_s2);

//
// Complement the adder inputs
//
INV_32_4X	ImmBAR(ImmBAR_s1e, Imm_s1e);
INV_32_4X	TBAR(TBAR_s1e, BTBus_s1e);

//
// Select one of the possible imm or T bus values
//
MUX4_32		TorImm(torImm_s1e,
			BTBus_s1e, TBAR_s1e,
			Imm_s1e, ImmBAR_s1e,
			BselT_s1e, BselTBAR_s1e,
			BselImm_s1e, BselImmBAR_s1e);

//
// Latch the inputs before they go into teh FU's
//
PHI1_LATCH_EN_32	Src1Bus(src1Bus_s2e, BSBus_s1e, Phi1, BLatchInputs_s1e);
PHI1_LATCH_EN_32	Src2Bus(src2Bus_s2e, torImm_s1e, Phi1, BLatchInputs_s1e);

//
// Adder
//
ADD_32		BadderU(addRes_v2e, BcarryOut_v2e, src1Bus_s2e, 
			src2Bus_s2e, BcarryIn_s2e);

//
// Logic Unit
//
LUNIT_32 	BlogicU(LURes_v2e, src1Bus_s2e, src2Bus_s2e,
			BAndOp_s2e, BOrOp_s2e, BXorOp_s2e, 
			BNorOp_s2e);

//
// Drive Memory Address
//
PHI2_LATCH_EN_32	memAddr(MemAddr_s1m, addRes_v2e,
				Phi2, BenabMemAddrLatch_s2e);

//
// Tri-state drivers for outputs
//
TRIBUF_32	addBuf(BResultBus_v2e, addRes_v2e, BAddDrv_q2e);
TRIBUF_32	setBuf(BResultBus_v2e, {31'b0, BSetRes_v2e}, BSetDrv_q2e);
TRIBUF_32	outBuf(BResultBus_v2e, LURes_v2e, BALUDrv_q2e);

endmodule				  // BALU
