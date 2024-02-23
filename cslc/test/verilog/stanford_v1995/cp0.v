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
//  Title: 	Co-processor 0
//  Created:	Thu Mar 24 16:38:14 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  cp0.v,v 7.20 1995/01/28 00:40:52 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: 
//
//  Revision History:
//	Modified: Thu Dec  1 21:26:17 1994	<ricardog@chroma.Stanford.EDU>
//	* Added explicit latch enables.
//	Modified: Mon Jun 27 15:16:19 1994	<ricardog@chroma.Stanford.EDU>
//	* Renamed Reset to Reset_s1 and added MemStall_s1.
//	Modified:	Sun May 22 15:57:16 1994	<ricardog@chroma>
//	* Changed MemStall_s2 to Stall_s1.
//	Modified:	Fri Apr  8 15:09:25 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	06-02-92
//	* changed interface to cp0IntEncoder, cp0control, cp0regdpath.
//	Modified:	05-25-92
//	* MemBus_v2m --> Cp0Bus_v2m
//	Modified:	04-13-92
//	* added MemStall_s2 to interface
//	Modified:	04-08-92
//	* integrate tlb with rest of cp0
//	Modified:	04-03-92
//	* add external interface support; add IStall_s1, 
//	* ExtDataValid_s2, L2Miss_s2, ItlbMiss_v2e, 
//	* SharedMemAddr_s1, ReqLength_s1, ExtRead_s1, 
//	* ExtRequest_s1, NonCacheable_s1
//	Modified:	03-24-92
//	* Use MemExcept_s2m instead of s1w
//	Modified:	03-13-91
//	* boosted exceptions added
//
`include "torch.h"
`include "tlb.v" // By Claudiu
`include "cp0IntEncoder.v" // By Claudiu
`include "cp0regdpath.v" // By Claudiu
`include "cp0control.v" // By Claudiu
`include "tlbDatapath.v" // By Claudiu
`include "tlbControl.v" // By Claudiu

module coproc0(
// Clocks
    Phi1,
    Phi2,
    MemAddr_s1m,
    InstrAddr_s2i,
    ICacheMiss_v2r,
    Stall_s1,
    Stall_s2,
    IStall_s1,
    MemStall_s1,
    IAddrError_v2i,
    MemExcept_s2m,
    InstrIsLoad_s1m,
    InstrIsStore_s1m,
    Commit_s1e,
    Squash_s1e,
    Reset_s1,
    Interrupt_w,
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
    ExtDataValid_s2,
    L2Miss_s2,
    PhysAddr_v2m,
    MipsMode_s2e,
    NonCacheable_v2m,
    ExceptVector_s1i,
    Except_s1w,
    PCPID_v2r,
    SystemBit_s2e,
    EPCSel_s1m,
    EPCNSel_s1m,
    SquashBit_s1,
    ItlbMiss_v2e,
    ExtRead_s1,
    ExtRequest_s1,
    NonCacheable_s1,
    SharedMemAddr_s1,
    ReqLength_s1,
    Cp0Bus_s2m
    );

//
// Clocks & Stalls
//
input		Phi1;
input		Phi2;
input		MemStall_s1;
input		Stall_s1;
input		Stall_s2;

//
// I-Cache Miss Handling
//
input		ICacheMiss_v2r;
input		IAddrError_v2i;


//
// Buses
//
inout	[31:0]	Cp0Bus_s2m;		  // Interface w/ EXE datapath
input	[29:0]	InstrAddr_s2i;		  // Instr Addr that missed in I$
input	[31:0]	MemAddr_s1m;		  // Mem Address of ld/st
input	[3:0]	CopRegNum_s1m;		  // For move to/from cp0
output	[31:0]	SharedMemAddr_s1;	  // Addr to external interface

//
// Signals between IFetcher and External Interface
//
input		IStall_s1;
output		ItlbMiss_v2e;
output	[5:0]	ReqLength_s1;
wire	[5:0]	ReqLength_s1;
output		NonCacheable_s1;
output		ExtRead_s1;
output		ExtRequest_s1;
input		ExtDataValid_s2;
input		L2Miss_s2;


//
// Exception signals
//
input		Reset_s1;		  // External Reset signal
wire		TLBRefill_v2m;		  // Type of TLB error
wire		TLBInvalid_v2m;
wire		TLBModified_v2m;
input		MemExcept_s2m;		  // Store buffer boosted conflict
input		AALUOvfl_v2e;		  // Arith overflow (A-side)
input		BALUOvfl_v2e;		  // Arith overflow (B-side)
input	[5:0]	Interrupt_w;		  // External interrupt lines


//
// Other info needed to process exceptions
//
input		Squash_s1e;		  // Branch delay slot
input		Commit_s1e;
input		AIsBoosted_s2e;		  // A instruction is boosted
input		BIsBoosted_s2e;		  // B instruction is boosted


//
// Decoded instructions (come from BdecSE1)
//
input		InstrIsStore_s1m;
input		InstrIsLoad_s1m;
input		MvToCop0_s1m;
input		MvFromCop0_s1m;
input		Syscall_s2m;
input		Break_s2m;
input		TLBProbe_s1m;
input		TLBRead_s1m;
input		TLBWriteI_s1m;
input		TLBWriteR_s1m;
input		RetFromExcept_s2e;


//
// Outputs 
//
output		EPCSel_s1m;		 // EPC and EPCN actually live in
output		EPCNSel_s1m;		 // PC unit.
output		SquashBit_s1;		 // Squash Bit  from previous context
output		Except_s1w;		 // Except signal for entire chip (HOT)
output	[2:0]	ExceptVector_s1i;	 // PC of exception vector to jump tp
output		MipsMode_s2e;		 // 1- or 2-way super-scalar
output	[31:2]	PhysAddr_v2m;		 // Translated address to D$
output	[5:0]	PCPID_v2r;		 // For I$ access (cirtual tags)
output		NonCacheable_v2m;	 // Type of external req to mem sys
output		SystemBit_s2e;		 // User/Kernel mode (also for I$ accs)


//
// Internal nodes
//
wire	[5:0]	Int_s1;			  // Interrupt lines
wire	[1:0]	IntPending_s2;
wire	[7:0]	IntMask_s2;		  // Interrupt mask
wire	[4:0]	ExceptionCause_s1w;	  // Type of exception
wire	[31:2]	tlbAddr_s1w;		  // address for tlb translation
wire	[31:0]	Cp0Bus_s1w;		  // Delayed for one phase
wire		IndexSel_s1m;		  // Decoded cp0 register number for
wire		RandomSel_s1m;		  // transfer (move from/to)
wire		EntryHiSel_s1m;
wire		EntryLoSel_s1m;
wire		ContextSel_s2m;
wire		BadVAddrSel_s2m;
wire		StatusSel_s2m;
wire		CauseSel_s2m;
wire		SetBoost_s1w;		  // Mark boosted excpetion
wire		BrDelaySlot_s1w;		  // Branch instr executed
wire		BoostedExcept_v2;	  // ????
wire		SeqExcept_v2;		  // Sequential exception taken
wire		BExTaken_s1w;		  // Boosted exception taken
wire		TLBL1_s1w;		  // TLB miss on instr translation
wire		Reset_s2;
wire		MPc_s2, MPp_s2, MPo_s2;	  // Mips mode (current, previous, old)
wire		KUc_s2, KUp_s2, KUo_s2;	  // User bit (current, previous, old)
wire		BEP_s2, BEV_s1;		  // ????
wire		BSp_s2, BSc_s2;		  // ????
wire		IEc_s2;			  // Interrupt enable flag
wire		PushStatus_s1w;		  // Exception taken
wire		PopStatus_s1w;		  // Return from exception (restore)

wire		drvCp0Bus_q2m;
wire		writeContext_s1w;
wire		defContext_s1w;
wire		writeCause_s1w;
wire		defCause_s1w;
wire		writeStatus_s1w;
wire		defStatus_s1w;
wire		newBSc_s1;
wire		newBEP_s1;
wire		Squash_s1w;


//---------------------------------------------------------------------------
//			      --- TBI ---
//---------------------------------------------------------------------------

//
// modules
//

tlb tlb(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s1		(Stall_s1),
	.Stall_s2		(Stall_s2),
	.IStall_s1		(IStall_s1),
	.MemStall_s1		(MemStall_s1),
	.MemAddr_s1m		(MemAddr_s1m),
	.Cp0Bus_s2m		(Cp0Bus_s2m),
	.Cp0Bus_s1w		(Cp0Bus_s1w),
	.tlbAddr_s1w		(tlbAddr_s1w),
	.IndexSel_s1m		(IndexSel_s1m),
	.RandomSel_s1m		(RandomSel_s1m),
	.EntryHiSel_s1m		(EntryHiSel_s1m),
	.EntryLoSel_s1m		(EntryLoSel_s1m),
	.InstrAddr_s2i		(InstrAddr_s2i),
	.ICacheMiss_v2r		(ICacheMiss_v2r),
	.Except_s1w		(Except_s1w),
	.TLBProbe_s1m		(TLBProbe_s1m),
	.TLBRead_s1m		(TLBRead_s1m),
	.TLBWriteI_s1m		(TLBWriteI_s1m),
	.TLBWriteR_s1m		(TLBWriteR_s1m),
	.MvToCop0_s1m		(MvToCop0_s1m),
	.MvFromCop0_s1m		(MvFromCop0_s1m),
	.InstrIsStore_s1m	(InstrIsStore_s1m),
	.InstrIsLoad_s1m	(InstrIsLoad_s1m),
	.PhysAddr_v2m		(PhysAddr_v2m),
	.PCPID_v2r		(PCPID_v2r),
	.NonCacheable_v2m	(NonCacheable_v2m),
	.Reset_s1		(Reset_s1),
	.TLBRefill_v2m		(TLBRefill_v2m),
	.TLBInvalid_v2m		(TLBInvalid_v2m),
	.TLBModified_v2m	(TLBModified_v2m),
	.SharedMemAddr_s1	(SharedMemAddr_s1),
	.ItlbMiss_v2e		(ItlbMiss_v2e),
	.ReqLength_s1		(ReqLength_s1),
	.MipsMode_s2e		(MipsMode_s2e),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.L2Miss_s2		(L2Miss_s2),
	.NonCacheable_s1	(NonCacheable_s1),
	.ExtRead_s1		(ExtRead_s1),
	.ExtRequest_s1		(ExtRequest_s1)
    );


cp0IntEncoder cp0IntEncoder(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s1		(Stall_s1),
	.Except_s1w		(Except_s1w),
	.IEc_s2			(IEc_s2),
	.BExTaken_s1w		(BExTaken_s1w),
	.Reset_s1		(Reset_s1),
	.AALUOvfl_v2e		(AALUOvfl_v2e),
	.BALUOvfl_v2e		(BALUOvfl_v2e),
	.Syscall_s2m		(Syscall_s2m),
	.Break_s2m		(Break_s2m),
	.TLBRefill_v2m		(TLBRefill_v2m),
	.TLBInvalid_v2m		(TLBInvalid_v2m),
	.TLBModified_v2m	(TLBModified_v2m),
	.MemExcept_s2m		(MemExcept_s2m),
	.Interrupt_w		(Interrupt_w),
	.IntPending_s2		(IntPending_s2),
	.IntMask_s2		(IntMask_s2),
	.InstrIsLoad_s1m	(InstrIsLoad_s1m),
	.InstrIsStore_s1m	(InstrIsStore_s1m),
	.AIsBoosted_s2e		(AIsBoosted_s2e),
	.BIsBoosted_s2e		(BIsBoosted_s2e),
	.SetBoost_s1w		(SetBoost_s1w),
	.BoostedExcept_v2	(BoostedExcept_v2),
	.SeqExcept_v2		(SeqExcept_v2),
	.ExceptionCause_s1w	(ExceptionCause_s1w),
	.Int_s1			(Int_s1),
	.Reset_s2		(Reset_s2),
	.TLBL1_s1w		(TLBL1_s1w)
    );

cp0regdpath cp0regdpath(
	.Phi2			(Phi2),
	.Phi1			(Phi1),
	.Stall_s1		(Stall_s1),
	.Stall_s2		(Stall_s2),
	.Cp0Bus_s2m		(Cp0Bus_s2m),
	.Cp0Bus_s1w		(Cp0Bus_s1w),
	.tlbAddr_s1w		(tlbAddr_s1w),
	.ContextSel_s2m		(ContextSel_s2m),
	.BadVAddrSel_s2m	(BadVAddrSel_s2m),
	.StatusSel_s2m		(StatusSel_s2m),
	.CauseSel_s2m		(CauseSel_s2m),
	.drvCp0Bus_q2m		(drvCp0Bus_q2m),
	.writeContext_s1w	(writeContext_s1w),
	.defContext_s1w		(defContext_s1w),
	.writeCause_s1w		(writeCause_s1w),
	.defCause_s1w		(defCause_s1w),
	.writeStatus_s1w	(writeStatus_s1w),
	.defStatus_s1w		(defStatus_s1w),
	.newBSc_s1		(newBSc_s1),
	.newBEP_s1		(newBEP_s1),
	.ExceptionCause_s1w	(ExceptionCause_s1w),
	.Int_s1			(Int_s1),
	.Reset_s1		(Reset_s1),
	.Squash_s1w		(Squash_s1w),
	.PushStatus_s1w		(PushStatus_s1w),
	.PopStatus_s1w		(PopStatus_s1w),
	.BrDelaySlot_s1w	(BrDelaySlot_s1w),
	.Except_s1w		(Except_s1w),
	.MPc_s2			(MPc_s2),
	.MPp_s2			(MPp_s2),
	.MPo_s2			(MPo_s2),
	.KUc_s2			(KUc_s2),
	.KUp_s2			(KUp_s2),
	.KUo_s2			(KUo_s2),
	.IEc_s2			(IEc_s2),
	.BEP_s2			(BEP_s2),
	.BEV_s1			(BEV_s1),
	.BSp_s2			(BSp_s2),
	.BSc_s2			(BSc_s2),
	.SquashBit_s1		(SquashBit_s1),
	.IntPending_s2		(IntPending_s2),
	.IntMask_s2		(IntMask_s2)
    );

cp0control cp0control(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s1		(Stall_s1),
	.Reset_s1		(Reset_s1),
	.Reset_s2		(Reset_s2),
	.BoostedExcept_v2	(BoostedExcept_v2),
	.SeqExcept_v2		(SeqExcept_v2),
	.TLBL1_s1w		(TLBL1_s1w),
	.RetFromExcept_s2e	(RetFromExcept_s2e),
	.BEP_s2			(BEP_s2),
	.BEV_s1			(BEV_s1),
	.BSp_s2			(BSp_s2),
	.BSc_s2			(BSc_s2),
	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
	.MvToCop0_s1m		(MvToCop0_s1m),
	.MvFromCop0_s1m		(MvFromCop0_s1m),
	.SetBoost_s1w		(SetBoost_s1w),
	.CopRegNum_s1m		(CopRegNum_s1m),
	.MPc_s2			(MPc_s2),
	.MPp_s2			(MPp_s2),
	.MPo_s2			(MPo_s2),
	.KUc_s2			(KUc_s2),
	.KUp_s2			(KUp_s2),
	.KUo_s2			(KUo_s2),
	.Squash_s1w		(Squash_s1w),
	.PushStatus_s1w		(PushStatus_s1w),
	.PopStatus_s1w		(PopStatus_s1w),
	.BrDelaySlot_s1w	(BrDelaySlot_s1w),
	.Except_s1w		(Except_s1w),
	.ExceptVector_s1i	(ExceptVector_s1i),
	.BExTaken_s1w		(BExTaken_s1w),
	.MipsMode_s2e		(MipsMode_s2e),
	.SystemBit_s2e		(SystemBit_s2e),
	.drvCp0Bus_q2m		(drvCp0Bus_q2m),
	.writeContext_s1w	(writeContext_s1w),
	.defContext_s1w		(defContext_s1w),
	.writeCause_s1w		(writeCause_s1w),
	.defCause_s1w		(defCause_s1w),
	.writeStatus_s1w	(writeStatus_s1w),
	.defStatus_s1w		(defStatus_s1w),
	.newBSc_s1		(newBSc_s1),
	.newBEP_s1		(newBEP_s1),
	.IndexSel_s1m		(IndexSel_s1m),
	.RandomSel_s1m		(RandomSel_s1m),
	.EntryLoSel_s1m		(EntryLoSel_s1m),
	.EntryHiSel_s1m		(EntryHiSel_s1m),
	.ContextSel_s2m		(ContextSel_s2m),
	.BadVAddrSel_s2m	(BadVAddrSel_s2m),
	.StatusSel_s2m		(StatusSel_s2m),
	.CauseSel_s2m		(CauseSel_s2m),
	.EPCSel_s1m		(EPCSel_s1m),
	.EPCNSel_s1m		(EPCNSel_s1m)
    );

endmodule				  // coproc0
