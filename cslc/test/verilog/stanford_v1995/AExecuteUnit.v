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
//  Title: 	A-side Execute Unit
//  Created:	Nov 24 1991
//  Author: 	David Glasco
//
//
//  AExecuteUnit.v,v 7.14 1995/01/28 00:42:48 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This module contains the control and datapath sections of
//  	    the A-side execute unit. Control signals are generated in
//  	    BALUControl. Datapath sections are completely structural. The
//  	    shift ammount is generated in AALU so that we will not have to 
//  	    route the AInstr to the control block (has to go to AALU anyway
//  	    for the immediate).
//
//	Hierarchy: system.processor.decodeExec.DataPath.AExecuteUnit.
//
//  Revision History:
//	Modified:	Sun May 22 16:19:05 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1
//	Modified:	Fri Apr  8 15:50:03 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Sun Mar 20 17:50:04 1994	<ricardog@chroma>
//	* Changed module instantiation & cleanup code.
//	Modified:	Dec 2  1992	<ricardog@bill>
//	* Added synopsys comments.
//	Modified:	Nov 22 1992	<ricardog@bill>
//	* Create new module AALUControl.
//

module AExecuteUnit(
// Clocks
    Phi1,
    Phi2,
// Inputs
    Stall_s1,
    Stall_s2,
    AKill_s1e,
    AWrong_s1e,
    ASBus_s1e,
    ATBus_s1e,
    AUseT_s1e,
    AUseImm_s1e,
    AInstr_s2r,
    AImmShift16_s2r, 
    AImm26Bit_s2r,
    AImmSigned_s2r,
    AAddOp_s2e,
    ASubOp_s2e,
    ASltOp_s2e,
    ASltUOp_s2e,
    AAndOp_s2e,
    AOrOp_s2e,
    AXorOp_s2e,
    ANorOp_s2e,
    AALUDrv_s2e,
    ShiftLeft_s2e,
    ShiftArithmetic_s2e,
    ShifterDrv_s2e,
    AAUopSigned_s2e,
    MultOp_s2e,
    DivOp_s2e,
    SignedMDOp_s2e,
    LoadHiLo_s2e,
    StoreHiLo_s2e, 
    HiLo_s2e,
// Outputs
    HLNotReady_s2e,
    AResultBus_v2e,
    AALUOvfl_v2e
    );

//
// Clocks
//
input		Phi1;
input		Phi2;

//
// Stall
//
input		Stall_s1;
input		Stall_s2;

//
// Instruction kill
//
input		AKill_s1e;
input		AWrong_s1e;

//
// ALU Controls From the instruction decoder
//
input		AUseT_s1e;
input		AUseImm_s1e;
input		AALUDrv_s2e;
input		AAddOp_s2e;
input		ASubOp_s2e;
input		ASltOp_s2e;
input		ASltUOp_s2e;
input		AAndOp_s2e;
input		AOrOp_s2e;
input		AXorOp_s2e;
input		ANorOp_s2e;
input		AAUopSigned_s2e;
// Multiply/divide controls
input		MultOp_s2e;
input		DivOp_s2e; 
input		SignedMDOp_s2e;
input		LoadHiLo_s2e;
input		StoreHiLo_s2e;
input		HiLo_s2e;

//
// Shifter Controls
//
input		ShiftLeft_s2e;
input		ShiftArithmetic_s2e;
input		ShifterDrv_s2e;

//
// immUnit Controls
//
input	[39:0]	AInstr_s2r;
input		AImmShift16_s2r;
input		AImm26Bit_s2r;
input		AImmSigned_s2r;

//
// Source Values
//
input	[31:0]	ASBus_s1e;
input	[31:0]	ATBus_s1e;

//
// Output Value
//
output	[31:0]	AResultBus_v2e;
output		AALUOvfl_v2e;		  // ALU op overflowed
output		HLNotReady_s2e;		  // Mult/Div in progress

//
// Wires between units
//
wire	[4:0]	ShiftAmt_s2e;
wire		AImmSignEx_s2r;
wire		AdefaultImm_s2r;
wire		AselImm_s1e;
wire		AselImmBAR_s1e;
wire		AselT_s1e;
wire		AselTBAR_s1e;
wire		AcarryIn_s2e;
wire		AcarryOut_v2e;
wire		AlogicInst_s2e;
wire		ldHi_s2e;
wire		ldLo_s2e;
wire		AALUDrv_q2e;
wire		AAddDrv_q2e;
wire		ASetDrv_q2e;
wire		ASetRes_v2e;
wire		ATorImmMsb_s1e;
wire		AAddResMsb_v2e;

//
// ALU control
//
AALUControl AALUControl(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s1			(Stall_s1),
	.AKill_s1e			(AKill_s1e),
	.AWrong_s1e			(AWrong_s1e),
	.AALUDrv_s2e			(AALUDrv_s2e),
	.AUseT_s1e			(AUseT_s1e),
	.AUseImm_s1e			(AUseImm_s1e),
	.AAddOp_s2e			(AAddOp_s2e),
	.ASubOp_s2e			(ASubOp_s2e),
	.ASltOp_s2e			(ASltOp_s2e),
	.ASltUOp_s2e			(ASltUOp_s2e),
	.AAndOp_s2e			(AAndOp_s2e),
	.AOrOp_s2e			(AOrOp_s2e),
	.AXorOp_s2e			(AXorOp_s2e),
	.ANorOp_s2e			(ANorOp_s2e),
	.AImm26Bit_s2r			(AImm26Bit_s2r),
	.AImmShift16_s2r		(AImmShift16_s2r),
	.AImmSigned_s2r			(AImmSigned_s2r),
	.AInstr_s2r			(AInstr_s2r[15:6]),
	.ASBus_s1e			(ASBus_s1e[4:0]),
`ifdef MULTIPLIER
// synopsys translate_off
	.LoadHiLo_s2e			(LoadHiLo_s2e),
	.HiLo_s2e			(HiLo_s2e),
// synopsys translate_on
`endif
	.AAUopSigned_s2e		(AAUopSigned_s2e),
	.ATorImmMsb_s1e			(ATorImmMsb_s1e),
	.ASBusMsb_s1e			(ASBus_s1e[31]),
	.AAddResMsb_v2e			(AAddResMsb_v2e),
	.AcarryOut_v2e			(AcarryOut_v2e),
	.AdefaultImm_s2r		(AdefaultImm_s2r),
	.AImmSignEx_s2r			(AImmSignEx_s2r),
	.AselImm_s1e			(AselImm_s1e),
	.AselImmBAR_s1e			(AselImmBAR_s1e),
	.AselT_s1e			(AselT_s1e),
	.AselTBAR_s1e			(AselTBAR_s1e),
	.AcarryIn_s2e			(AcarryIn_s2e),
	.AlogicInst_s2e			(AlogicInst_s2e),
`ifdef MULTIPLIER
// synopsys translate_off
	.ldHi_s2e			(ldHi_s2e),
	.ldLo_s2e			(ldLo_s2e),
// synopsys translate_on
`endif
	.AALUDrv_q2e			(AALUDrv_q2e),
	.AAddDrv_q2e			(AAddDrv_q2e),
	.ASetDrv_q2e			(ASetDrv_q2e),
	.ASetRes_v2e			(ASetRes_v2e),
	.AALUOvfl_v2e			(AALUOvfl_v2e),
	.ShiftAmt_s2e			(ShiftAmt_s2e),
	.ALatchInputs_s1e		(ALatchInputs_s1e)
	);

//
// ALU datapath
//
AALU AALU(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s2			(Stall_s2),
	.ALatchInputs_s1e		(ALatchInputs_s1e),
`ifdef MULTIPLIER
// synopsys translate_off
	.AKill_s1e			(AKill_s1e),
	.MultOp_s2e			(MultOp_s2e),
	.DivOp_s2e			(DivOp_s2e),
	.SignedMDOp_s2e			(SignedMDOp_s2e),
	.StoreHiLo_s2e			(StoreHiLo_s2e),
	.LoadHiLo_s2e			(LoadHiLo_s2e),
	.HiLo_s2e			(HiLo_s2e),
// synopsys translate_on
`endif
	.AInstr_s2r			(AInstr_s2r[31:0]),
	.ASBus_s1e			(ASBus_s1e),
	.ATBus_s1e			(ATBus_s1e),
	.AselT_s1e			(AselT_s1e),
	.AselTBAR_s1e			(AselTBAR_s1e),
	.AselImm_s1e			(AselImm_s1e),
	.AselImmBAR_s1e			(AselImmBAR_s1e),
	.AImm26Bit_s2r			(AImm26Bit_s2r),
	.AImmShift16_s2r		(AImmShift16_s2r),
	.AdefaultImm_s2r		(AdefaultImm_s2r),
	.AImmSignEx_s2r			(AImmSignEx_s2r),
	.AcarryIn_s2e			(AcarryIn_s2e),
	.ASetRes_v2e			(ASetRes_v2e),
	.AAndOp_s2e			(AAndOp_s2e),
	.AOrOp_s2e			(AOrOp_s2e),
	.AXorOp_s2e			(AXorOp_s2e),
	.ANorOp_s2e			(ANorOp_s2e),
	.AlogicInst_s2e			(AlogicInst_s2e),
`ifdef MULTIPLIER
// synopsys translate_off
	.ldHi_s2e			(ldHi_s2e),
	.ldLo_s2e			(ldLo_s2e),
	.HLNotReady_s2e			(HLNotReady_s2e),
// synopsys translate_on
`endif
	.AALUDrv_q2e			(AALUDrv_q2e),
	.AAddDrv_q2e			(AAddDrv_q2e),
	.ASetDrv_q2e			(ASetDrv_q2e),
	.AResultBus_v2e			(AResultBus_v2e),
	.AcarryOut_v2e			(AcarryOut_v2e),
	.ATorImmMsb_s1e			(ATorImmMsb_s1e),
	.AAddResMsb_v2e			(AAddResMsb_v2e)
	);

//
// Shifter
//
shifter shifter(
	.Phi1				(Phi1),
	.ALatchInputs_s1e		(ALatchInputs_s1e),
	.ATBus_s1e			(ATBus_s1e),
	.AResultBus_v2e			(AResultBus_v2e),
	.ShiftAmt_s2e			(ShiftAmt_s2e),
	.ShiftLeft_s2e			(ShiftLeft_s2e),
	.ShiftArithmetic_s2e		(ShiftArithmetic_s2e),
	.ShifterDrv_s2e			(ShifterDrv_s2e)
	);

endmodule				  // AExecuteUnit
