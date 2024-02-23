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
//  Title: 	Instruction Fetch & PC Unit
//  Created:	Fri Apr  1 14:24:33 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  instrFetch.v,v 7.22 1995/01/28 00:48:06 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
// Contains the Instruction Fetcher/Instruction Cache unit and the PC unit.
// This is the top level and only contains wire connectivities
//
//	Hierarchy: 
//
//  Revision History:
//	Modified: Sun Aug  7 22:17:50 1994	<ricardog@chroma.Stanford.EDU>
//	* Moved ICACHE outside of IFetchDatapath.
//	Modified: Mon Jun 27 15:20:16 1994	<ricardog@chroma.Stanford.EDU>
//	* Renamed Reset to Reset_s1.
//	Modified:	Sun May 22 16:35:25 1994	<ricardog@chroma>
//	* Changed MemStall_s2 to MemStall_s1.
//	Modified:	Tue Apr 12 12:27:05 1994	<ricardog@chroma>
//	* Changed timing of HoldPC_v2r to be _s2r.
//	Modified:	Sat Apr  9 16:37:57 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Fri Apr  1 16:32:30 1994	<ricardog@chroma>
//	* Better implementation of jump mux.
//	Modified:	Fri Apr  1 16:32:21 1994	<ricardog@chroma>
//	* Moved branch logic to IFetchControl.
//
`include "torch.h"

module instrFetch(
    Phi1,
    Phi2,
    ASBus_s1e, 
    BEQnext_s1e,
    BNEnext_s1e,
    BLEZnext_s1e,
    BGTZnext_s1e,
    BLTZnext_s1e,
    BGEZnext_s1e,
    RegPC_s1e,
    ImmPC_s1e,
    SEqualsT_v1e,
    SIsNegative_v1e,
    TakenBranch_s2e,
    PCDrvResult_s2e,
    MipsMode_s2e,
    MemStall_s1,
    Stall_s1,
    Stall_s2,
    Reset_s1,
    ExceptVector_s1i, 
    Except_s1w,
    PCPID_v2r,
    SystemBit_s2e, 
    EPCSel_s1m,
    EPCNSel_s1m,
    ItlbMiss_v2e,
    NonCacheable_s1,
    SharedMemAddr_s1,
    ReqNextBlock_s2,
    SharedMemData_s2,
    ExtDataValid_s2, L2Miss_s2,
    AResultBus_v2e,
    MemBus_v2m,
    InstrAddr_s2i, 
    AInstr_s2r,
    BInstr_s2r,
    ICacheMiss_v2r, 
    AKill_s1e,
    BKill_s1e,
    KillOne_s1e, 
    IStall_s1,
    IFetchStall_s1,
    IAddrError_v2i,
    L1Hit_s1
    );




//
// Clocks & Stalls
//
input   	Phi1;
input   	Phi2;
output  	IStall_s1;
output		IFetchStall_s1;
input   	MemStall_s1;
input		Stall_s1;
input		Stall_s2;
input   	Reset_s1;

input   [31:0]	ASBus_s1e;

//
// PC control signals
//
input		BEQnext_s1e;		  // Decoded branch signals from the
input		BNEnext_s1e;		  // instruction decoder
input		BLEZnext_s1e;		  // the branch condition is evaluated
input		BGTZnext_s1e;		  // in the IFetchControl module
input		BLTZnext_s1e;
input		BGEZnext_s1e;
input		ImmPC_s1e;		  // Jump instruction
input		RegPC_s1e;		  // Jump register
input		SEqualsT_v1e;		  // Condition codes from RF
input		SIsNegative_v1e;
output		TakenBranch_s2e;	  // Set if Br/J taken prev phase
input   	PCDrvResult_s2e;

//
// Control signals
//
input   	MipsMode_s2e;
input   [2:0]	ExceptVector_s1i;
input   	Except_s1w;
input   [5:0]	PCPID_v2r;
input   	SystemBit_s2e;
input   	EPCSel_s1m;
input   	EPCNSel_s1m;
input   [63:0]	SharedMemData_s2;
input   	ExtDataValid_s2;
input   	L2Miss_s2;
input   	ReqNextBlock_s2;	// not implemented yet
input   	ItlbMiss_v2e;
input   [31:0]	SharedMemAddr_s1;	// not implemented yet
input   	NonCacheable_s1;

output  [31:0]	AResultBus_v2e;
output  [31:0]	MemBus_v2m;
output  [29:0]	InstrAddr_s2i;		// this is same as PC_s2i
output  [39:0]	AInstr_s2r;
output  [39:0]	BInstr_s2r;
output  	ICacheMiss_v2r;
output  	AKill_s1e;
output  	BKill_s1e;
output  	KillOne_s1e;
output  	IAddrError_v2i;
output  	L1Hit_s1;		// not implemented yet

//
// between PCUnit and IFetch
//
wire		HoldPC_s2r;
wire		RestoreIStallPC_s1;
wire		IStall_s1;
wire		IFetchStall_s1;
wire	[1:0]	WritePack_s2;
wire		BDynamicBit_v1r;

//
// Wire between IFetchDatapath and IFetchControl
//

//---------------------------------------------------------------------------
//		      ---- Wires Betwen Units ----
//---------------------------------------------------------------------------
wire		MipsMode_b_s2e;
wire		NonCacheableHeld_s1;
wire		ExtDataValid_s2;
wire		LatchShiftReg_s1;
wire		LatchDataReg_s1;
wire		ExtMuxSelect_s1;
wire		WriteData_s2;
wire		WriteTag_s2;
wire		DataEnable_s2;
wire		TagEnable_s2;
wire		LatchNonCachePkt_s2;
wire		ADrvB_s2r;
wire		BDrvA_s2r;
wire		LatchInstrs_s1r;
wire		LatchTags_s1r;
wire		ADynamicBit_v1r;
wire		Match_v2r;
wire		ICacheLineValid_s2r;
wire		PCUnitPsi2_s2;
wire		HoldPC_s2e;
wire		EPCBufEnable_s2m;
wire		EPCMuxSel_s2m;
wire		Jump0_s1e;
wire		Jump1_s1e;
wire		Jump2_s1e;
wire		Jump3_s1e;
wire		Jump4_s1e;
wire		Jump5_v1e;

wire	[79:0]	ICacheInData_s2;
wire	[23:0]	ICacheInTag_s2;
wire	[79:0]	ICacheOutData_v1r;
wire	[23:0]	ICacheOutTag_v1r;

wire		Gamma1_s1;
wire		latchEPC_s1w;


ICACHE	 ICACHE (
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s1		(Stall_s1),
	.ICacheOutData_v1r	(ICacheOutData_v1r),
	.ICacheOutTag_v1r	(ICacheOutTag_v1r),
	.ICacheInData_s2	(ICacheInData_s2), 
	.ICacheInTag_s2		(ICacheInTag_s2),
	.Address_s2i		(InstrAddr_s2i[12:3]),
	.PCPacketNum_s2i	(InstrAddr_s2i[2:1]),
	.WritePack_s2		(WritePack_s2), 
	.WriteData_s2		(WriteData_s2),
	.WriteTag_s2		(WriteTag_s2),
	.DataEnable_s2		(DataEnable_s2),
	.TagEnable_s2		(TagEnable_s2)
    );

IFetchDatapath	 IFetchDatapath(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s2		(Stall_s2),
	.InstrAddr_s2i		(InstrAddr_s2i[29:13]),
	.MipsMode_s2e		(MipsMode_s2e), 
	.SharedMemData_s2	(SharedMemData_s2),
	.SharedMemAddr_s1	(SharedMemAddr_s1),
	.NonCacheableHeld_s1	(NonCacheableHeld_s1),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.LatchShiftReg_s1	(LatchShiftReg_s1),
	.LatchDataReg_s1	(LatchDataReg_s1),
	.ExtMuxSelect_s1	(ExtMuxSelect_s1),
	.ICacheOutData_v1r	(ICacheOutData_v1r),
	.ICacheOutTag_v1r	(ICacheOutTag_v1r),
	.PCPID_v2r		(PCPID_v2r),
	.LatchNonCachePkt_s2	(LatchNonCachePkt_s2),
	.ADrvB_s2r		(ADrvB_s2r),
	.BDrvA_s2r		(BDrvA_s2r),
	.LatchInstrs_s1r	(LatchInstrs_s1r),
	.LatchTags_s1r		(LatchTags_s1r),
	.ADynamicBit_v1r	(ADynamicBit_v1r),
	.BDynamicBit_v1r	(BDynamicBit_v1r),
	.AInstr_s2r		(AInstr_s2r),
	.BInstr_s2r		(BInstr_s2r),
	.Match_v2r		(Match_v2r),
	.ICacheLineValid_s2r	(ICacheLineValid_s2r),
	.ICacheInData_s2	(ICacheInData_s2), 
	.ICacheInTag_s2		(ICacheInTag_s2),
	.L1Hit_s1		(L1Hit_s1)
    );


IFetchControl IFetchControl(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Gamma1_s1		(Gamma1_s1),
	.MemStall_s1		(MemStall_s1),
	.Stall_s1		(Stall_s1),
	.Reset_s1		(Reset_s1),
	.MipsMode_s2e		(MipsMode_s2e),
	.MipsMode_b_s2e		(MipsMode_b_s2e),
	.ItlbMiss_v2e		(ItlbMiss_v2e),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.L2Miss_s2		(L2Miss_s2),
	.IStall_s1		(IStall_s1),
	.IFetchStall_s1		(IFetchStall_s1),
	.AKill_s1e		(AKill_s1e),
	.BKill_s1e		(BKill_s1e),
	.KillOne_s1e		(KillOne_s1e),
	.LatchShiftReg_s1	(LatchShiftReg_s1),
	.WriteData_s2		(WriteData_s2),
	.WriteTag_s2		(WriteTag_s2),
	.DataEnable_s2		(DataEnable_s2),
	.TagEnable_s2		(TagEnable_s2),
	.LatchDataReg_s1	(LatchDataReg_s1),
	.ExtMuxSelect_s1	(ExtMuxSelect_s1),
	.WritePack_s2		(WritePack_s2),
	.ADynamicBit_v1r	(ADynamicBit_v1r),
	.BDynamicBit_v1r	(BDynamicBit_v1r),
	.ADrvB_s2r		(ADrvB_s2r),
	.BDrvA_s2r		(BDrvA_s2r),
	.LatchInstrs_s1r	(LatchInstrs_s1r),
	.LatchTags_s1r		(LatchTags_s1r),
	.PCOffset_s2i		(InstrAddr_s2i[0]),
	.Match_v2r		(Match_v2r),
	.ICacheLineValid_s2r	(ICacheLineValid_s2r),
	.ICacheMiss_v2r		(ICacheMiss_v2r),
	.NonCacheable_s1	(NonCacheable_s1),
	.LatchNonCachePkt_s2	(LatchNonCachePkt_s2),
	.NonCacheableHeld_s1	(NonCacheableHeld_s1),
	.Except_s1w		(Except_s1w),
	.BEQnext_s1e		(BEQnext_s1e),
	.BNEnext_s1e		(BNEnext_s1e),
	.BLEZnext_s1e		(BLEZnext_s1e),
	.BGTZnext_s1e		(BGTZnext_s1e),
	.BLTZnext_s1e		(BLTZnext_s1e),
	.BGEZnext_s1e		(BGEZnext_s1e),
	.ImmPC_s1e		(ImmPC_s1e),
	.RegPC_s1e		(RegPC_s1e),
	.SEqualsT_v1e		(SEqualsT_v1e),
	.SIsNegative_v1e	(SIsNegative_v1e),
	.EPCSel_s1m		(EPCSel_s1m),
	.EPCNSel_s1m		(EPCNSel_s1m),
	.SystemBit_s2e		(SystemBit_s2e),
	.PC_bit31_s2i		(InstrAddr_s2i[29]),
	.PCPacketNum_s2i	(InstrAddr_s2i[2:1]),
	.IAddrError_v2i		(IAddrError_v2i),
       	.PCUnitPsi2_s2	    	(PCUnitPsi2_s2),
	.latchEPC_s1w		(latchEPC_s1w),
	.RestoreIStallPC_s1	(RestoreIStallPC_s1),
	.HoldPC_s2r		(HoldPC_s2r),
	.HoldPC_s2e		(HoldPC_s2e),
	.EPCBufEnable_s2m	(EPCBufEnable_s2m),
	.EPCMuxSel_s2m		(EPCMuxSel_s2m),
	.TakenBranch_s2e	(TakenBranch_s2e),
	.Jump0_s1e		(Jump0_s1e),
	.Jump1_s1e		(Jump1_s1e),
	.Jump2_s1e		(Jump2_s1e),
	.Jump3_s1e		(Jump3_s1e),
	.Jump4_s1e		(Jump4_s1e),
	.Jump5_v1e		(Jump5_v1e)
    );


PCUnitDatapath PCUnitDatapath(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s1		(Stall_s1),
	.Stall_s2		(Stall_s2),
	.Gamma1_s1		(Gamma1_s1),
    	.PCUnitPsi2_s2	    	(PCUnitPsi2_s2),
	.InstrAddr_s2i		(InstrAddr_s2i[29:0]),
	.ASBus_s1e		(ASBus_s1e[31:2]),
	.PCImmedBus_s2r		(AInstr_s2r[25:0]),
	.HoldPC_s2r		(HoldPC_s2r),
	.HoldPC_s2e		(HoldPC_s2e),
	.MipsMode_s2e		(MipsMode_s2e),
	.MipsMode_b_s2e		(MipsMode_b_s2e),
	.AResultBus_v2e		(AResultBus_v2e),
	.PCDrvResult_s2e	(PCDrvResult_s2e),
	.RestoreIStallPC_s1	(RestoreIStallPC_s1),
	.MemBus_v2m		(MemBus_v2m),
	.EPCBufEnable_s2m	(EPCBufEnable_s2m),
	.EPCMuxSel_s2m		(EPCMuxSel_s2m),
	.latchEPC_s1w		(latchEPC_s1w),
	.ExceptVector_s1i	(ExceptVector_s1i),
	.Jump0_s1e		(Jump0_s1e),
	.Jump1_s1e		(Jump1_s1e),
	.Jump2_s1e		(Jump2_s1e),
	.Jump3_s1e		(Jump3_s1e),
	.Jump4_s1e		(Jump4_s1e),
	.Jump5_v1e		(Jump5_v1e)
    );


endmodule				  // instrFetch
