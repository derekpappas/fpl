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
//  Title: 	Decode and Execution Units
//  Created:	Sun Mar 20 17:51:54 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  decodeExec.v,v 7.15 1995/01/28 00:43:16 ricardog Exp
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
//	Modified: Thu Jul 21 16:23:32 1994	<ricardog@chroma.Stanford.EDU>
//	* Added Squahs regeneration on RFE.
//	Modified:	Sun May 22 16:17:04 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1.
//	Modified:	Fri Apr  8 15:29:59 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//
`include "torch.h"

module decodeExec(
// Clocks
    Phi1,
    Phi2,
// Stalls & Exceptions
    Stall_s1,
    Stall_s2,
    Except_s1w,
// Inputs Busses
    ASBus_s1e,
    ATBus_s1e,
    BSBus_s1e,
    BTBus_s1e,
// Instructions
    AInstr_s2r,
    BInstr_s2r,
// Inputs
    AKill_s1e,
    BKill_s1e,
    KillOne_s1e,
    TakenBranch_s2e,
    EPCSel_s1m,
    EPCNSel_s1m,
    SquashBit_s1,
// Result Busses
    AResultBus_v2e,
    BResultBus_v2e,
    MemAddr_s1m,
    MemBus_v2m,
// Outputs
    BEQnext_s1e,
    BNEnext_s1e,
    BLEZnext_s1e,
    BGTZnext_s1e,
    BLTZnext_s1e,
    BGEZnext_s1e,
    ImmPC_s1e,
    RegPC_s1e,
    PCDrvResult_s2e,
    ADestIsRD_s1e,
    ADestIsRT_s1e,
    ADestIs31_s1e,
    BDestIsRD_s1e,
    BDestIsRT_s1e,
    BIsLoad_s1e,
    AIgnore_s2e,
    BIgnore_s2e,
    InstrIsLoad_s1m,
    InstrIsStore_s1m,
    MemOp_s1m,
    BoostedInstr_s1m,
    Commit_s1e,
    Squash_s1e,
    MvToCop0_s1m,
    MvFromCop0_s1m,
    Syscall_s2m,
    Break_s2m,
    TLBProbe_s1m,
    TLBRead_s1m,
    TLBWriteI_s1m,
    TLBWriteR_s1m,
    RetFromExcept_s2e,
    AALUOvfl_v2e,
    BALUOvfl_v2e,
    CopRegNum_s1m,
    AIsBoosted_s2e,
    BIsBoosted_s2e,
    HLNotReady_s2e,
// Inouts
    Cp0Bus_s2m
    );

//
// Clocks
//
input   	Phi1;
input   	Phi2;

//
// Stalls & Exceptions
//
input   	Stall_s1;
input   	Stall_s2;
input   	Except_s1w;

//
// Source operand busses (from register file)
//
input   [31:0]	ASBus_s1e;
input   [31:0]	ATBus_s1e;
input   [31:0]	BSBus_s1e;
input   [31:0]	BTBus_s1e;

//
// Instructions (from instruction fetcher)
//
input   [39:0]	AInstr_s2r;
input   [39:0]	BInstr_s2r;

//
// Pipeline control signals (from instruction fetcher)
//
input   	AKill_s1e;
input   	BKill_s1e;
input   	KillOne_s1e;
input		TakenBranch_s2e;	  // Used to compute Commit & Squash
input		EPCSel_s1m;
input		EPCNSel_s1m;
input		SquashBit_s1;		 // Squash bit from previous context

//
// result Busses
//
output  [31:0]	AResultBus_v2e;
output  [31:0]	BResultBus_v2e;
output  [31:0]	MemAddr_s1m;		  // Cache access address
output  [31:0]	MemBus_v2m;		  // Fro move from coproc0

//
// Outputs (mostly decoded signals)
//
output		BEQnext_s1e;		  // Decoded branch signals to the
output		BNEnext_s1e;		  // instruction fetch unit where
output		BLEZnext_s1e;		  // the branch condition is evaluated
output		BGTZnext_s1e;
output		BLTZnext_s1e;
output		BGEZnext_s1e;
output  	ImmPC_s1e;
output  	RegPC_s1e;
output  	PCDrvResult_s2e;
output  	ADestIsRD_s1e;
output  	ADestIsRT_s1e;
output  	ADestIs31_s1e;
output  	BDestIsRD_s1e;
output  	BDestIsRT_s1e;
output  	BIsLoad_s1e;
output  	AIgnore_s2e;
output  	BIgnore_s2e;
output  	InstrIsLoad_s1m;
output  	InstrIsStore_s1m;
output  [2:0]	MemOp_s1m;		  // From opcode bits
output  	BoostedInstr_s1m;
output  	Commit_s1e;
output  	Squash_s1e;
output  	MvToCop0_s1m;
output  	MvFromCop0_s1m;
output  	Syscall_s2m;
output  	Break_s2m;
output  	TLBProbe_s1m;
output  	TLBRead_s1m;
output  	TLBWriteI_s1m;
output  	TLBWriteR_s1m;
output  	RetFromExcept_s2e;
output  	AALUOvfl_v2e;
output  	BALUOvfl_v2e;
output [3:0] 	CopRegNum_s1m;
output  	AIsBoosted_s2e;
output  	BIsBoosted_s2e;
output  	HLNotReady_s2e;

//
// Inouts (bus to co-processor 0)
//
inout	[31:0]	Cp0Bus_s2m;

//
// 
//
wire		AWrong_s1e;
wire		BWrong_s1e;

//
// Temporary wires
//

//---------------------------------------------------------------------------
//		       ---- Intra-Unit Wires ----
//---------------------------------------------------------------------------
wire		AImmShift16_s2r;
wire		AImm26Bit_s2r;
wire		AImmSigned_s2r;
wire		MvToCop0_s1e;
wire		AAddOp_s2e;
wire		ASubOp_s2e;
wire		ASltOp_s2e;
wire		ASltUOp_s2e;
wire		AAndOp_s2e;
wire		AOrOp_s2e;
wire		AXorOp_s2e;
wire		ANorOp_s2e;
wire		MultOp_s2e;
wire		DivOp_s2e;
wire		SignedMDOp_s2e;
wire		AUseT_s1e;
wire		AUseImm_s1e;
wire		LoadHiLo_s2e;
wire		StoreHiLo_s2e;
wire		HiLo_s2e;
wire		AALUDrv_s2e;
wire		ShiftLeft_s2e;
wire		ShiftArithmetic_s2e;
wire		ShifterDrv_s2e;
wire		AAUopSigned_s2e;
wire		BImmShift16_s2r;
wire		BImm26Bit_s2r;
wire		BImmSigned_s2r;
wire		BAddOp_s2e;
wire		BSubOp_s2e;
wire		BSltOp_s2e;
wire		BSltUOp_s2e;
wire		BAndOp_s2e;
wire		BOrOp_s2e;
wire		BXorOp_s2e;
wire		BNorOp_s2e;
wire		BUseT_s1e;
wire		BUseImm_s1e;
wire		BALUDrv_s2e;
wire		BAUopSigned_s2e;

//---------------------------------------------------------------------------
//		     ---- Instruction Decoders ----
//---------------------------------------------------------------------------
AdecSE1 AdecSE1(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s1			(Stall_s1),
	.Except_s1w			(Except_s1w),
	.AInstr_s2r			(AInstr_s2r),
	.AKill_s1e			(AKill_s1e),
	.TakenBranch_s2e		(TakenBranch_s2e),
	.RetFromExcept_s2e		(RetFromExcept_s2e),
	.SquashBit_s1			(SquashBit_s1),
	.AImmShift16_s2r		(AImmShift16_s2r),
	.AImm26Bit_s2r			(AImm26Bit_s2r),
	.AImmSigned_s2r			(AImmSigned_s2r),
	.ADestIsRT_s1e			(ADestIsRT_s1e),
	.ADestIsRD_s1e			(ADestIsRD_s1e),
	.ADestIs31_s1e			(ADestIs31_s1e),
	.AAddOp_s2e			(AAddOp_s2e),
	.ASubOp_s2e			(ASubOp_s2e),
	.ASltOp_s2e			(ASltOp_s2e),
	.ASltUOp_s2e			(ASltUOp_s2e),
	.AAndOp_s2e			(AAndOp_s2e),
	.AOrOp_s2e			(AOrOp_s2e),
	.AXorOp_s2e			(AXorOp_s2e),
	.ANorOp_s2e			(ANorOp_s2e),
	.MultOp_s2e			(MultOp_s2e),
	.DivOp_s2e			(DivOp_s2e),
	.SignedMDOp_s2e			(SignedMDOp_s2e),
	.AUseT_s1e			(AUseT_s1e),
	.AUseImm_s1e			(AUseImm_s1e),
	.LoadHiLo_s2e			(LoadHiLo_s2e),
	.StoreHiLo_s2e			(StoreHiLo_s2e),
	.HiLo_s2e			(HiLo_s2e),
	.AALUDrv_s2e			(AALUDrv_s2e),
	.ShiftLeft_s2e			(ShiftLeft_s2e),
	.ShiftArithmetic_s2e		(ShiftArithmetic_s2e),
	.ShifterDrv_s2e			(ShifterDrv_s2e),
	.PCDrvResult_s2e		(PCDrvResult_s2e),
	.BEQnext_s1e			(BEQnext_s1e),
	.BNEnext_s1e			(BNEnext_s1e),
	.BLEZnext_s1e			(BLEZnext_s1e),
	.BGTZnext_s1e			(BGTZnext_s1e),
	.BLTZnext_s1e			(BLTZnext_s1e),
	.BGEZnext_s1e			(BGEZnext_s1e),
	.ImmPC_s1e			(ImmPC_s1e),
	.RegPC_s1e			(RegPC_s1e),
	.Commit_s1e			(Commit_s1e),
	.Squash_s1e			(Squash_s1e),
	.AIsBoosted_s2e			(AIsBoosted_s2e),
	.AWrong_s1e			(AWrong_s1e),
	.AAUopSigned_s2e		(AAUopSigned_s2e)
	);

BdecSE1 BdecSE1(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.BInstr_s2r			(BInstr_s2r),
	.Stall_s1			(Stall_s1),
	.Except_s1w			(Except_s1w),
	.BKill_s1e			(BKill_s1e),
	.BImmShift16_s2r		(BImmShift16_s2r),
	.BImm26Bit_s2r			(BImm26Bit_s2r),
	.BImmSigned_s2r			(BImmSigned_s2r),
	.BDestIsRT_s1e			(BDestIsRT_s1e),
	.BDestIsRD_s1e			(BDestIsRD_s1e),
	.BIsLoad_s1e			(BIsLoad_s1e),
	.InstrIsStore_s1m		(InstrIsStore_s1m),
	.InstrIsLoad_s1m		(InstrIsLoad_s1m),
	.MemOp_s1m			(MemOp_s1m),
	.BAddOp_s2e			(BAddOp_s2e),
	.BSubOp_s2e			(BSubOp_s2e),
	.BSltOp_s2e			(BSltOp_s2e),
	.BSltUOp_s2e			(BSltUOp_s2e),
	.BAndOp_s2e			(BAndOp_s2e),
	.BOrOp_s2e			(BOrOp_s2e),
	.BXorOp_s2e			(BXorOp_s2e),
	.BNorOp_s2e			(BNorOp_s2e),
	.BUseT_s1e			(BUseT_s1e),
	.BUseImm_s1e			(BUseImm_s1e),
	.Syscall_s2m			(Syscall_s2m),
	.Break_s2m			(Break_s2m),
	.MvFromCop0_s1m			(MvFromCop0_s1m),
	.MvToCop0_s1e			(MvToCop0_s1e),
	.MvToCop0_s1m			(MvToCop0_s1m),
	.TLBRead_s1m			(TLBRead_s1m),
	.TLBWriteI_s1m			(TLBWriteI_s1m),
	.TLBWriteR_s1m			(TLBWriteR_s1m),
	.TLBProbe_s1m			(TLBProbe_s1m),			
	.RetFromExcept_s2e		(RetFromExcept_s2e),
	.BALUDrv_s2e			(BALUDrv_s2e),
	.BoostedInstr_s1m		(BoostedInstr_s1m),
	.BIsBoosted_s2e			(BIsBoosted_s2e),
	.BAUopSigned_s2e		(BAUopSigned_s2e),
	.BWrong_s1e			(BWrong_s1e),
	.CopRegNum_s1m			(CopRegNum_s1m)
	);

killUnit killUnit(
	.Phi1				(Phi1),
	.Stall_s1			(Stall_s1),
	.KillOne_s1e			(KillOne_s1e),
	.AWrong_s1e			(AWrong_s1e),
	.BWrong_s1e			(BWrong_s1e),
	.AIgnore_s2e			(AIgnore_s2e),
	.BIgnore_s2e			(BIgnore_s2e)
	);


//--------------------------------------------------------------------------
//                      --  Datapath  --
//--------------------------------------------------------------------------
AExecuteUnit AExecuteUnit(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s1			(Stall_s1),
	.Stall_s2			(Stall_s2),
	.AKill_s1e			(AKill_s1e),
	.AWrong_s1e			(AWrong_s1e),
	.ASBus_s1e			(ASBus_s1e),
	.ATBus_s1e			(ATBus_s1e),
	.AUseT_s1e			(AUseT_s1e),
	.AUseImm_s1e			(AUseImm_s1e),
	.AInstr_s2r			(AInstr_s2r),
	.AImmShift16_s2r		(AImmShift16_s2r),
	.AImm26Bit_s2r			(AImm26Bit_s2r),
	.AImmSigned_s2r			(AImmSigned_s2r),
	.AAddOp_s2e			(AAddOp_s2e),
	.ASubOp_s2e			(ASubOp_s2e),
	.ASltOp_s2e			(ASltOp_s2e),
	.ASltUOp_s2e			(ASltUOp_s2e),
	.AAndOp_s2e			(AAndOp_s2e),
	.AOrOp_s2e			(AOrOp_s2e),
	.AXorOp_s2e			(AXorOp_s2e),
	.ANorOp_s2e			(ANorOp_s2e),
	.AALUDrv_s2e			(AALUDrv_s2e),
	.ShiftLeft_s2e			(ShiftLeft_s2e),
	.ShiftArithmetic_s2e		(ShiftArithmetic_s2e),
	.ShifterDrv_s2e			(ShifterDrv_s2e),
	.AAUopSigned_s2e		(AAUopSigned_s2e),
	.MultOp_s2e			(MultOp_s2e),
	.DivOp_s2e			(DivOp_s2e),
	.SignedMDOp_s2e			(SignedMDOp_s2e),
	.LoadHiLo_s2e			(LoadHiLo_s2e),
	.StoreHiLo_s2e			(StoreHiLo_s2e),
	.HiLo_s2e			(HiLo_s2e),
	.HLNotReady_s2e			(HLNotReady_s2e),
	.AResultBus_v2e			(AResultBus_v2e),
	.AALUOvfl_v2e			(AALUOvfl_v2e)
	);


BExecuteUnit BExecuteUnit(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s1			(Stall_s1),
	.Stall_s2			(Stall_s2),
	.BKill_s1e			(BKill_s1e),
	.BWrong_s1e			(BWrong_s1e),
	.BSBus_s1e			(BSBus_s1e),
	.BTBus_s1e			(BTBus_s1e),
	.MemAddr_s1m			(MemAddr_s1m),
	.BUseT_s1e			(BUseT_s1e),
	.BUseImm_s1e			(BUseImm_s1e),
	.BInstr_s2r			(BInstr_s2r),
	.BImmShift16_s2r		(BImmShift16_s2r),
	.BImm26Bit_s2r			(BImm26Bit_s2r),
	.BImmSigned_s2r			(BImmSigned_s2r),
	.BAddOp_s2e			(BAddOp_s2e),
	.BSubOp_s2e			(BSubOp_s2e),
	.BSltOp_s2e			(BSltOp_s2e),
	.BSltUOp_s2e			(BSltUOp_s2e),
	.BAndOp_s2e			(BAndOp_s2e),
	.BOrOp_s2e			(BOrOp_s2e),
	.BXorOp_s2e			(BXorOp_s2e),
	.BNorOp_s2e			(BNorOp_s2e),
	.BALUDrv_s2e			(BALUDrv_s2e),
	.BAUopSigned_s2e		(BAUopSigned_s2e),
	.MvToCop0_s1e			(MvToCop0_s1e),
	.MvToCop0_s1m			(MvToCop0_s1m),
	.MvFromCop0_s1m			(MvFromCop0_s1m),
	.EPCSel_s1m			(EPCSel_s1m),
	.EPCNSel_s1m			(EPCNSel_s1m),
	.BALUOvfl_v2e			(BALUOvfl_v2e),
	.BResultBus_v2e			(BResultBus_v2e),
	.MemBus_v2m			(MemBus_v2m),
	.Cp0Bus_s2m			(Cp0Bus_s2m)
	);

endmodule

