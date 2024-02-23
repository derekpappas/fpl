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
//  Title: 	TLB Control Module
//  Created:	Wed Apr  6 19:00:48 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  tlb.v,v 7.21 1995/01/28 00:41:11 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: system.processor.cp0.tlb.
//
//  Revision History:
//	Modified: Thu Dec  1 21:27:36 1994	<ricardog@chroma.Stanford.EDU>
//	* Added explicit latch enables.
//	Modified: Mon Jun 27 15:15:16 1994	<ricardog@chroma.Stanford.EDU>
//	* Added MemStall to qualify latches in control module.
//	Modified: Mon Jun 27 15:14:56 1994	<ricardog@chroma.Stanford.EDU>
//	* Renamed Reset to Reset_s1
//	Modified:	Sun May 22 15:58:42 1994	<ricardog@chroma>
//	* Removed MemStall_s2 for Stall_s1.
//	* Modified:	Thu Apr  7 10:21:46 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	* Modified:	4/5/92
//	* ICache miss code added
//	Modified:   4/12/92 
//	* CacheRequest_s2
//	Modified:   5/07/92 
//	* emoved DCacheRequest_s2
//	Modified:   6/11/92 
//	* artitioned into DataPath & Control (TNI)
//
`include "torch.h"

module tlb(
    Phi1,
    Phi2,
    Stall_s1,
    Stall_s2,
    IStall_s1,
    MemStall_s1,
    MemAddr_s1m,
    Cp0Bus_s2m,
    Cp0Bus_s1w,
    tlbAddr_s1w,
    IndexSel_s1m,
    RandomSel_s1m,
    EntryHiSel_s1m,
    EntryLoSel_s1m,
    InstrAddr_s2i,
    ICacheMiss_v2r,
    Except_s1w,
    TLBProbe_s1m,
    TLBRead_s1m,
    TLBWriteI_s1m,
    TLBWriteR_s1m,
    MvToCop0_s1m,
    MvFromCop0_s1m,
    InstrIsStore_s1m,
    InstrIsLoad_s1m,
    PhysAddr_v2m,
    PCPID_v2r,
    NonCacheable_v2m,
    Reset_s1,
    TLBRefill_v2m,
    TLBInvalid_v2m,
    TLBModified_v2m,
    SharedMemAddr_s1,
    ItlbMiss_v2e,
    ReqLength_s1,
    MipsMode_s2e,
    ExtDataValid_s2,
    L2Miss_s2,
    NonCacheable_s1,
    ExtRead_s1,
    ExtRequest_s1
    );

//---------------------------------------------------------------------------
// Clocks
//---------------------------------------------------------------------------
input		Phi1;
input		Phi2;
input		Stall_s1;
input		Stall_s2;
input		MemStall_s1;
input		Reset_s1;

//---------------------------------------------------------------------------
// Busses : Address from PC Unit, and to Load/Store Unit
//---------------------------------------------------------------------------
input 	[31:0] 	MemAddr_s1m;
output	[31:0]	SharedMemAddr_s1;
input 	[29:0] 	InstrAddr_s2i;
wire	[31:29]	instrAddr_s1e;
output 	[31:0] 	Cp0Bus_s2m;
input 	[31:0] 	Cp0Bus_s1w;
output	[31:2]	tlbAddr_s1w;

//---------------------------------------------------------------------------
// TLB Register Select Signals
//---------------------------------------------------------------------------
input 		IndexSel_s1m, RandomSel_s1m, EntryHiSel_s1m, EntryLoSel_s1m;
wire 		IndexSel_s2m, RandomSel_s2m, EntryHiSel_s2m, EntryLoSel_s2m;

//---------------------------------------------------------------------------
// ICache Miss Signals (from IFetcher, to External Interface)
//---------------------------------------------------------------------------
input		IStall_s1;
input		ICacheMiss_v2r;
wire		ICacheMiss_s1e;
wire		drvSharedMemAddr_s1;
wire		ICMiss_s1;
wire		selMemAddr_s1m;
output	[5:0]	ReqLength_s1;

output		NonCacheable_s1;
output		ExtRead_s1;
output		ExtRequest_s1;
input		ExtDataValid_s2;
input		L2Miss_s2;
input		MipsMode_s2e;

//---------------------------------------------------------------------------
// DCache Miss Request
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// TLB Miss on ICache Miss 
//---------------------------------------------------------------------------
output		ItlbMiss_v2e;

//---------------------------------------------------------------------------
// Decoded Op Codes - TLB Instructions
//---------------------------------------------------------------------------
input 		MvToCop0_s1m, MvFromCop0_s1m;
input 		TLBProbe_s1m, TLBRead_s1m, TLBWriteI_s1m, TLBWriteR_s1m;
wire 		TLBWrite_s1m, TLBWriteOrProbe_s1m, TLBProbe_s1w, TLBRead_s1w;
input 		InstrIsLoad_s1m, InstrIsStore_s1m;

//---------------------------------------------------------------------------
// TLB Outputs - Physical Tag, Not_Cacheable bit of entry
//---------------------------------------------------------------------------
output 	[31:2] 	PhysAddr_v2m;			// Used for tag comp in LSU
output 	[5:0] 	PCPID_v2r;		        // Used for I$ access
output 		NonCacheable_v2m;	        // To LSU unit

//---------------------------------------------------------------------------
// TLB Exception signals
//---------------------------------------------------------------------------
output 		TLBRefill_v2m, TLBInvalid_v2m, TLBModified_v2m;
input		Except_s1w;

//---------------------------------------------------------------------------
// CP0 Internal Registers/Signals
//---------------------------------------------------------------------------
wire	[31:6]	EntryHiIn_s1m;
wire	[31:6]	EntryHiOut_v2m;
wire	[31:6]	EntryHi_s2w;
wire	[31:8]	EntryLoIn_s1m;
wire	[31:8]	EntryLoOut_v2m;
wire 		tlbDrive_v2m;			// output enabled
wire	[11:6]	pid_v2m;			// PID read from tlb
wire	[3:0]	statusBits_v2m;			// Status Bits from tlb
wire	[5:0]	IndexIn_s1m;
wire	[6:0]	IndexOut_v2m;
wire 		TLBHit_v2m;			// Flag to indicate a hit
wire		selSaveInstr_s1;
wire		enabSaveInstrLatch_s1;
wire		unCacheOrMap_s2e;	// Instr in uncached or umapped space

//--------------------------------------------------------------------------
// Wires added for partitioning
//--------------------------------------------------------------------------
wire		enabIndexLatch_s1w; 
wire		enabEntryHiLatch_s1w; 
wire		enabEntryLoLatch_s1w;
wire		TLBTranslation_s1m;
wire		enabPOLatch_s2m;

wire		randomEqual8_v1;
wire		resetRandom_v1;

//---------------------------------------------------------------------------
// TLB 
//---------------------------------------------------------------------------
TLB TorchTLB(
	.Phi1			(Phi1),
	.TLBHit_v2m		(TLBHit_v2m),
	.EntryHiOut_v2m		(EntryHiOut_v2m[31:6]),
	.EntryLoOut_v2m		(EntryLoOut_v2m[31:8]),
	.IndexOut_v2m		(IndexOut_v2m[5:0]),
	.ProbeFailure_v2m	(IndexOut_v2m[6]),
	.EntryHiIn_s1m		(EntryHiIn_s1m[31:6]),
	.EntryLoIn_s1m		(EntryLoIn_s1m[31:8]),
	.IndexIn_s1m		(IndexIn_s1m),
	.TLBRead_s1m		(TLBRead_s1m),
	.TLBWrite_s1m		(TLBWrite_s1m),
	.TLBProbe_s1m		(TLBProbe_s1m),
	.TLBTranslation_s1m	(TLBTranslation_s1m)
    );
assign pid_v2m[11:6] = EntryHiOut_v2m[11:6];
assign statusBits_v2m[3:0] = EntryLoOut_v2m[11:8];

//
// TLB datapath
//
tlbDatapath tlbDatapath(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s1			(Stall_s1),
	.Stall_s2			(Stall_s2),
	.Cp0Bus_s2m			(Cp0Bus_s2m),
	.Cp0Bus_s1w			(Cp0Bus_s1w),
	.MemAddr_s1m			(MemAddr_s1m),
	.InstrAddr_s2i			(InstrAddr_s2i),
	.instrAddr_s1e			(instrAddr_s1e[31:29]),
	.SharedMemAddr_s1		(SharedMemAddr_s1),
	.tlbAddr_s1w			(tlbAddr_s1w),
	.ICacheMiss_s1e			(ICacheMiss_s1e),
	.MipsMode_s2e			(MipsMode_s2e),
	.drvSharedMemAddr_s1		(drvSharedMemAddr_s1),
	.ICMiss_s1			(ICMiss_s1),
	.selMemAddr_s1m			(selMemAddr_s1m),
	.TLBWriteR_s1m			(TLBWriteR_s1m),
	.TLBWriteOrProbe_s1m		(TLBWriteOrProbe_s1m),
	.TLBProbe_s1w			(TLBProbe_s1w),
	.TLBRead_s1w			(TLBRead_s1w),
	.IndexSel_s2m			(IndexSel_s2m),
	.RandomSel_s2m			(RandomSel_s2m),
	.EntryHiSel_s2m			(EntryHiSel_s2m),
	.EntryLoSel_s2m			(EntryLoSel_s2m),
	.PhysAddr_v2m			(PhysAddr_v2m),
	.PCPID_v2r			(PCPID_v2r),
	.EntryHiIn_s1m			(EntryHiIn_s1m),
	.EntryLoIn_s1m			(EntryLoIn_s1m),
	.EntryHiOut_v2m			(EntryHiOut_v2m),
	.EntryLoOut_v2m			(EntryLoOut_v2m),
	.EntryHi_s2w			(EntryHi_s2w),
	.enabIndexLatch_s1w		(enabIndexLatch_s1w),
	.enabEntryHiLatch_s1w		(enabEntryHiLatch_s1w),
	.enabEntryLoLatch_s1w		(enabEntryLoLatch_s1w),
	.enabPOLatch_s2m		(enabPOLatch_s2m),
	.tlbDrive_v2m			(tlbDrive_v2m),
	.unCacheOrMap_s2e		(unCacheOrMap_s2e),
	.selSaveInstr_s1		(selSaveInstr_s1),
	.enabSaveInstrLatch_s1		(enabSaveInstrLatch_s1),
	.randomEqual8_v1		(randomEqual8_v1),
	.resetRandom_v1			(resetRandom_v1),
	.IndexIn_s1m			(IndexIn_s1m),
	.IndexOut_v2m			(IndexOut_v2m)
    );

//
// Control Module
//
tlbControl tlbControl(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.MemAddr_s1m			(MemAddr_s1m[31:29]),
	.instrAddr_s1e			(instrAddr_s1e[31:29]),
	.IndexSel_s1m			(IndexSel_s1m),
	.RandomSel_s1m			(RandomSel_s1m),
	.EntryHiSel_s1m			(EntryHiSel_s1m),
	.EntryLoSel_s1m			(EntryLoSel_s1m),
	.IndexSel_s2m			(IndexSel_s2m),
	.RandomSel_s2m			(RandomSel_s2m),
	.EntryHiSel_s2m			(EntryHiSel_s2m),
	.EntryLoSel_s2m			(EntryLoSel_s2m),
	.ICacheMiss_v2r			(ICacheMiss_v2r),
	.ICacheMiss_s1e			(ICacheMiss_s1e),
	.drvSharedMemAddr_s1		(drvSharedMemAddr_s1),
	.ICMiss_s1			(ICMiss_s1),
	.selMemAddr_s1m			(selMemAddr_s1m),
	.Except_s1w			(Except_s1w),
	.TLBProbe_s1m			(TLBProbe_s1m),
	.TLBRead_s1m			(TLBRead_s1m),
	.TLBWriteI_s1m			(TLBWriteI_s1m),
	.TLBWriteR_s1m			(TLBWriteR_s1m),
	.TLBWrite_s1m			(TLBWrite_s1m),
	.TLBWriteOrProbe_s1m		(TLBWriteOrProbe_s1m),
	.TLBProbe_s1w			(TLBProbe_s1w),
	.TLBRead_s1w			(TLBRead_s1w),
	.MvToCop0_s1m			(MvToCop0_s1m),
	.MvFromCop0_s1m			(MvFromCop0_s1m),
	.InstrIsStore_s1m		(InstrIsStore_s1m),
	.InstrIsLoad_s1m		(InstrIsLoad_s1m),
	.NonCacheable_v2m		(NonCacheable_v2m),
	.Reset_s1			(Reset_s1),
	.TLBRefill_v2m			(TLBRefill_v2m),
	.TLBInvalid_v2m			(TLBInvalid_v2m),
	.TLBModified_v2m		(TLBModified_v2m),
	.ItlbMiss_v2e			(ItlbMiss_v2e),
	.ReqLength_s1			(ReqLength_s1),
	.MipsMode_s2e			(MipsMode_s2e),
	.ExtDataValid_s2		(ExtDataValid_s2),
	.L2Miss_s2			(L2Miss_s2),
	.Stall_s1			(Stall_s1),
	.IStall_s1			(IStall_s1),
	.MemStall_s1			(MemStall_s1),
	.NonCacheable_s1		(NonCacheable_s1),
	.ExtRead_s1			(ExtRead_s1),
	.ExtRequest_s1			(ExtRequest_s1),
	.EntryHi_s2w			(EntryHi_s2w[11:6]),
	.pid_v2m			(pid_v2m),
	.statusBits_v2m			(statusBits_v2m),
	.enabIndexLatch_s1w		(enabIndexLatch_s1w),
	.enabEntryHiLatch_s1w		(enabEntryHiLatch_s1w),
	.enabEntryLoLatch_s1w		(enabEntryLoLatch_s1w),
	.TLBTranslation_s1m		(TLBTranslation_s1m),
	.enabPOLatch_s2m		(enabPOLatch_s2m),
	.TLBHit_v2m			(TLBHit_v2m),
	.unCacheOrMap_s2e		(unCacheOrMap_s2e),
	.selSaveInstr_s1		(selSaveInstr_s1),
	.enabSaveInstrLatch_s1		(enabSaveInstrLatch_s1),
	.tlbDrive_v2m			(tlbDrive_v2m),
	.randomEqual8_v1		(randomEqual8_v1),
	.resetRandom_v1			(resetRandom_v1)
    );

endmodule				        // tlb

module TLB;
endmodule
