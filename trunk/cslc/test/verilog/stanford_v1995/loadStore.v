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
//  Title: 	Load Store Unit
//  Created:	Thu Apr 21 13:15:36 1994
//  Author: 	Ricardo Gonzalez
//		<ricardog@bill>
//
//
//  loadStore.v,v 1.32 1995/02/14 01:24:27 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: 
//		This is the visible interface to the load/store/dcache
//		system, as far as the rest of the world is concerned.
//
//	Hierarchy: system.processor
//
//  Revision History:
//
`include "torch.h"

module loadStore(
    Phi1,
    Phi2,
    BTBus_s1e,
    BResultBus_v2e,
    MemAddr_s1m,
    PhysAddr_v2m,
    IStall_s1,
    IFetchStall_s1,
    InstrIsLoad_s1m,
    InstrIsStore_s1m,
    MemOp_s1m,
    BoostedInstr_s1m,
    NonCacheable_v2m,
    Commit_s1e,
    Squash_s1e,
    Reset_s1,
    Except_s1w,
    HLNotReady_s2e,
    ReqNextBlock_s2, 
    ExtDataValid_s2,
    L2Miss_s2,
    MemStall_s1,
    Stall_s1,
    Stall_s2,
    MemExcept_s2m,
    DExtRequest_s1, 
    DExtRead_s1,
    DNonCacheable_s1,
    ReqLength_s1,
    L1Hit_s1, 
    MemBus_v2m,
    SharedMemAddr_s1,
    SharedMemData_s2 
);

//
// Clocks
//
input           Phi1;
input           Phi2;
input		IStall_s1;
input		IFetchStall_s1;		 // De-asserted one cycle early
input		Reset_s1;

//
// External Interface Connections
//
input		ExtDataValid_s2;
input		L2Miss_s2;
input		ReqNextBlock_s2;
output	[5:0]	ReqLength_s1;
output		L1Hit_s1;
inout	[63:0]	SharedMemData_s2;
inout	[31:0]	SharedMemAddr_s1;
output		DExtRead_s1;
output          DExtRequest_s1;
output		DNonCacheable_s1;


//
// Datapath busses
//
input	[31:0]  BTBus_s1e;		  // Store Data
input	[31:0]  BResultBus_v2e;		  // Address of memory request (late)
input	[31:0]  MemAddr_s1m;		  // Address of L/S (early)
input	[31:2]	PhysAddr_v2m;		  // Translated address
output	[31:0]	MemBus_v2m;		  // Load data bus

//
// Control signals
//
input		InstrIsLoad_s1m;
input		InstrIsStore_s1m;
input	[2:0]	MemOp_s1m;		  // These come directly from the instr
input		BoostedInstr_s1m;
input		NonCacheable_v2m;
input		Commit_s1e;
input		Squash_s1e;
input		Except_s1w;
input		HLNotReady_s2e;

//
// Memory Generated Stalls and Exceptions
//
output          MemStall_s1;
output		Stall_s1;		  // Global stall (IStall or MemStall)
output		Stall_s2;		  // Delayed version (save power)
output          MemExcept_s2m;



//
// Internal Buses
//
wire	[12:0]	dTagAddr_s1m;
wire	[31:13]	dTagBusIn_v2;
wire	[31:13]	dTagData_v2m;
wire	[31:13]	dTagData_s1;
wire	[12:0]	dCacheAddr_s1m;
wire	[63:0]	dCacheBusIn_s1m;
wire	[63:0]	dCacheBusOut_v2m;
wire	[31:0]	storeData_s2m;
wire	[31:0]	storeData_s1;
wire	[34:0]	storeBufAddr_s1w;
wire	[31:0]	storeOrMissAddr_s1;
wire	[2:0]	storeOrMissOp_s1;
wire	[1:0]	dCacheStoreOp_s1m;
wire	[1:0]	byteOffset_s2m;
wire	[4:0]	lineOffset_s1w;
wire	[4:0]	lineOffset_s1;
wire	[2:0]	missOp_s1w;
wire	[2:0]	missOp_s1;
wire	[3:0]	AbufSel_s1w;
wire	[3:0]	BbufSel_s1w;
wire	[3:0]	AMatch_v1m;
wire	[3:0]	BMatch_v1m;
wire	[31:0]	BResultBus_s1m;
wire	[2:0]	MemOp_s2m;
wire	[2:0]	storeBufferOp_s1w;
wire	[31:0]	cacheData_v2m;
wire	[31:0]	storeBufData_s1w;

//
// 
//
wire		stoBufferStall_s1m;
wire		valid_s1m;
wire		dTagRead_s1m;
wire		dTagWrite_s1m;
wire		valid_v2m;
wire		match_v2m;
wire		latchStore_s1w;
wire		dTagIsLoad_s1m;
wire		dTagIsLoad_s2m;
wire		cacheConflict_v1m;
wire		dCacheRead_s1m;
wire		dCacheWrite_s1m;
wire		dirty_v2m;
wire		dirty_s1;
wire		latchExtData_s2;
wire		dCacheIsLoad_s1m;
wire		dCacheIsStore_s1;
wire		drvSharedMemData_q2;
wire		latchMissAddr_s2;
wire		drvSharedMemAddr_q1;
wire		selFastStore_s1m;
wire		selStoreAddr_s1;
wire		selMissAddr_s1;
wire		selProbeAddr_s1;
wire		selSpillAddr_s1;
wire		selAstore_s1w;
wire		doBufferStore_s1m;
wire		popStoreBuffer_s1;
wire		dCacheFill_s1;
wire		SeqConflict_v1m;
wire		stoBufferEmpty_s1;
wire		selByte1Pass_s2m;
wire		selByte1One_v2m;
wire		selByte1Zero_v2m;
wire		selByte23Pass_s2m;
wire		selByte23One_v2m;
wire		selByte23Zero_v2m;
wire		drvMemBusCD_q2m;
wire		drvMemBusSMD_q2m;
wire		drvNonCache_q2m;

//
// Clocks
//
wire	[3:0]	Alpha_q2;
wire	[3:0]	Beta_q2;

// synopsys translate_off
pullup	 (L1Hit_s1);
// synopsys translate_on

DTAG DTAG (
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.valid_s1m		(valid_s1m),
	.dTagRead_s1m		(dTagRead_s1m),
	.dTagWrite_s1m		(dTagWrite_s1m),
	.dTagAddr_s1m		(dTagAddr_s1m[12:5]),
	.dTagBusIn_v2		(dTagBusIn_v2),
	.dTagData_v2m		(dTagData_v2m),
	.valid_v2m		(valid_v2m),
	.match_v2m		(match_v2m)
    );

dTagDatapath dTagDatapath(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.MemAddr_s1m		(MemAddr_s1m[12:0]),
	.PhysAddr_v2m		(PhysAddr_v2m[31:13]),
	.storeOrMissAddr_s1	(storeOrMissAddr_s1),
	.dTagAddr_s1m		(dTagAddr_s1m),
	.dTagData_v2m		(dTagData_v2m[31:13]),
	.dTagBusIn_v2		(dTagBusIn_v2),
	.latchStore_s1w		(latchStore_s1w),
	.pendStore_s2		(pendStore_s2),
	.dTagIsLoad_s1m		(dTagIsLoad_s1m),
	.dTagIsLoad_s2m		(dTagIsLoad_s2m),
	.cacheConflict_v1m	(cacheConflict_v1m),
	.dTagData_s1		(dTagData_s1)
    );

DCACHE DCACHE(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.dCacheStoreOp_s1m	(dCacheStoreOp_s1m),
	.dCacheRead_s1m		(dCacheRead_s1m),
	.dCacheWrite_s1m	(dCacheWrite_s1m),
	.dCacheAddr_s1m		(dCacheAddr_s1m),
	.dCacheBusIn_s1m	(dCacheBusIn_s1m),
	.dCacheBusOut_v2m	(dCacheBusOut_v2m),
	.dirty_v2m		(dirty_v2m),
	.dirty_s1		(dirty_s1)
    );

dCacheDatapath dCacheDatapath (
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s2		(Stall_s2),
	.dCacheBusOut_v2m	(dCacheBusOut_v2m),
	.MemAddr_s1m		(MemAddr_s1m[12:0]),
	.storeOrMissAddr_s1	(storeOrMissAddr_s1[12:0]),
	.MemOp_s1m		(MemOp_s1m),
	.storeOrMissOp_s1	(storeOrMissOp_s1),
	.storeData_s1		(storeData_s1),
	.SharedMemData_s2	(SharedMemData_s2),
	.latchStore_s1w		(latchStore_s1w),
	.latchExtData_s2	(latchExtData_s2),
	.dCacheIsLoad_s1m	(dCacheIsLoad_s1m),
	.dCacheIsStore_s1	(dCacheIsStore_s1),
	.latchCacheData_s1	(latchCacheData_s1),
	.drvSharedMemData_q2	(drvSharedMemData_q2),
	.pendStore_s2		(pendStore_s2),
	.dCacheAddr_s1m		(dCacheAddr_s1m),
	.dCacheBusIn_s1m	(dCacheBusIn_s1m),
	.dCacheStoreOp_s1m	(dCacheStoreOp_s1m)
    );

addrDatapath addrDatapath (
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.latchMissAddr_s2	(latchMissAddr_s2),
	.MemAddr_s1m		(MemAddr_s1m),
	.PhysAddr_v2m		(PhysAddr_v2m),
	.storeBufAddr_s1w	(storeBufAddr_s1w),
	.dTagData_s1		(dTagData_s1),
	.drvSharedMemAddr_q1	(drvSharedMemAddr_q1),
	.selFastStore_s1m	(selFastStore_s1m),
	.selStoreAddr_s1	(selStoreAddr_s1),
	.selMissAddr_s1		(selMissAddr_s1),
	.selProbeAddr_s1	(selProbeAddr_s1),
	.selSpillAddr_s1	(selSpillAddr_s1),
	.selBuffMissAddr_s1	(selBuffMissAddr_s1),
	.popStoreBuffer_s1	(popStoreBuffer_s1),
	.MemOp_s1m		(MemOp_s1m),
	.MemOp_s2m		(MemOp_s2m),
	.byteOffset_s2m		(byteOffset_s2m),
	.lineOffset_s1		(lineOffset_s1),
	.missOp_s1		(missOp_s1),
	.storeOrMissAddr_s1	(storeOrMissAddr_s1),
	.storeOrMissOp_s1	(storeOrMissOp_s1),
	.lineOffset_s1w		(lineOffset_s1w),
	.missOp_s1w		(missOp_s1w),
	.SharedMemAddr_s1	(SharedMemAddr_s1)
    );

storeBufferAddr storeBufferAddr (
	.Alpha_q2		(Alpha_q2),
	.Beta_q2		(Beta_q2),
	.BResultBus_s1m		(BResultBus_s1m[12:2]),
	.PhysAddr_v2m		(PhysAddr_v2m),
	.byteOffset_s2m		(byteOffset_s2m),
	.MemOp_s2m		(MemOp_s2m),
	.AbufSel_s1w		(AbufSel_s1w),
	.BbufSel_s1w		(BbufSel_s1w),
	.selAstore_s1w		(selAstore_s1w),
	.storeBufAddr_s1w	(storeBufAddr_s1w),
	.AMatch_v1m		(AMatch_v1m),
	.BMatch_v1m		(BMatch_v1m)
    );

storeBufferCtrl storeBufferCtrl (
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Reset_s1		(Reset_s1),
	.Stall_s1		(Stall_s1),
	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
	.Except_s1w		(Except_s1w),
	.InstrIsLoad_s1m	(InstrIsLoad_s1m),
	.BoostedInstr_s1m	(BoostedInstr_s1m),
	.doBufferStore_s1m	(doBufferStore_s1m),
	.popStoreBuffer_s1	(popStoreBuffer_s1),
	.dCacheFill_s1		(dCacheFill_s1),
	.Alpha_q2		(Alpha_q2),
	.Beta_q2		(Beta_q2),
	.AMatch_v1m		(AMatch_v1m),
	.BMatch_v1m		(BMatch_v1m),
	.SeqConflict_v1m	(SeqConflict_v1m),
	.MemExcept_s2m		(MemExcept_s2m),
	.AbufSel_s1w		(AbufSel_s1w),
	.BbufSel_s1w		(BbufSel_s1w),
	.selAstore_s1w		(selAstore_s1w),
	.stoBufferEmpty_s1	(stoBufferEmpty_s1),
	.stoBufferStall_s1m	(stoBufferStall_s1m)
    );

ldStoCtrl ldStoCtrl(
// Clocks
	.Phi1			(Phi1),
	.Phi2			(Phi2),
// Inputs
	.MemOp_s1m		(MemOp_s1m),
	.byteOffset_s1m		(MemAddr_s1m[1:0]),
	.InstrIsLoad_s1m   (InstrIsLoad_s1m & ~ldStoDatapath.ioReadWrite_s1m),
	.InstrIsStore_s1m  (InstrIsStore_s1m & ~ldStoDatapath.ioReadWrite_s1m),
	.BoostedInstr_s1m	(BoostedInstr_s1m),
	.HLNotReady_s2e		(HLNotReady_s2e),
	.NonCacheable_v2m	(NonCacheable_v2m),
	.IStall_s1		(IStall_s1),
	.IFetchStall_s1		(IFetchStall_s1),
	.valid_v2m		(valid_v2m),
	.match_v2m		(match_v2m),
	.cacheConflict_v1m	(cacheConflict_v1m),
	.dirty_v2m		(dirty_v2m),
	.cacheBusSignBits_v2m	({dCacheBusOut_v2m[15], dCacheBusOut_v2m[7]}),
	.SeqConflict_v1m	(SeqConflict_v1m),
	.stoBufferEmpty_s1	(stoBufferEmpty_s1),
	.stoBufferStall_s1m	(stoBufferStall_s1m),
	.lineOffset_s1w		(lineOffset_s1w),
	.missOp_s1w		(missOp_s1w),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.L2Miss_s2		(L2Miss_s2),
	.Except_s1w		(Except_s1w),
	.Reset_s1		(Reset_s1),
// Outputs
	.Stall_s1		(Stall_s1),
	.Stall_s2		(Stall_s2),
	.MemStall_s1		(MemStall_s1),
	.valid_s1m		(valid_s1m),
	.dTagRead_s1m		(dTagRead_s1m),
	.dTagWrite_s1m		(dTagWrite_s1m),
	.latchStore_s1w		(latchStore_s1w),
	.dTagIsLoad_s1m		(dTagIsLoad_s1m),
	.dTagIsLoad_s2m		(dTagIsLoad_s2m),
	.dCacheRead_s1m		(dCacheRead_s1m),
	.dCacheWrite_s1m	(dCacheWrite_s1m),
	.dirty_s1		(dirty_s1),
	.latchExtData_s2	(latchExtData_s2),
	.dCacheIsLoad_s1m	(dCacheIsLoad_s1m),
	.dCacheIsStore_s1	(dCacheIsStore_s1),
	.selFastStore_s1m	(selFastStore_s1m),
	.latchCacheData_s1	(latchCacheData_s1),
	.drvSharedMemData_q2	(drvSharedMemData_q2),
	.byteOffset_s2m		(byteOffset_s2m),
	.lineOffset_s1		(lineOffset_s1),
	.missOp_s1		(missOp_s1),
	.latchMissAddr_s2	(latchMissAddr_s2),
	.doBufferStore_s1m	(doBufferStore_s1m),
	.popStoreBuffer_s1	(popStoreBuffer_s1),
	.dCacheFill_s1		(dCacheFill_s1),
	.MemOp_s2m		(MemOp_s2m),
	.drvSharedMemAddr_q1	(drvSharedMemAddr_q1),
	.pendStore_s2		(pendStore_s2),
	.selStoreAddr_s1	(selStoreAddr_s1),
	.selMissAddr_s1		(selMissAddr_s1),
	.selProbeAddr_s1	(selProbeAddr_s1),
	.selSpillAddr_s1	(selSpillAddr_s1),
	.selBuffMissAddr_s1	(selBuffMissAddr_s1),
	.selByte1Pass_s2m	(selByte1Pass_s2m),
	.selByte1One_v2m	(selByte1One_v2m),
	.selByte1Zero_v2m	(selByte1Zero_v2m),
	.selByte23Pass_s2m	(selByte23Pass_s2m),
	.selByte23One_v2m	(selByte23One_v2m),
	.selByte23Zero_v2m	(selByte23Zero_v2m),
	.drvMemBusCD_q2m	(drvMemBusCD_q2m),
	.drvMemBusSMD_q2m	(drvMemBusSMD_q2m),
	.drvNonCache_q2m	(drvNonCache_q2m),
	.DExtRequest_s1		(DExtRequest_s1),
	.DExtRead_s1		(DExtRead_s1),
	.DNonCacheable_s1	(DNonCacheable_s1),
	.ReqLength_s1		(ReqLength_s1)
    );

ldStoDatapath ldStoDatapath(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s1		(Stall_s1),
	.Stall_s2		(Stall_s2),
	.selFastStore_s1m	(selFastStore_s1m),
	.drvMemBusCD_q2m	(drvMemBusCD_q2m),
	.drvMemBusSMD_q2m	(drvMemBusSMD_q2m),
	.drvNonCache_q2m	(drvNonCache_q2m),
	.BResultBus_v2e		(BResultBus_v2e),
	.BTBus_s1e		(BTBus_s1e),
	.cacheData_v2m		(cacheData_v2m),
	.storeBufData_s1w	(storeBufData_s1w), 
	.storeData_s2m		(storeData_s2m), 
	.storeData_s1		(storeData_s1), 
	.MemBus_v2m		(MemBus_v2m),
	.BResultBus_s1m		(BResultBus_s1m),
	.SharedMemData_s2	(SharedMemData_s2[31:0])
    );

storeBufferData storeBufferData (
	.Alpha_q2		(Alpha_q2),
	.Beta_q2		(Beta_q2),
	.AbufSel_s1w		(AbufSel_s1w),
	.BbufSel_s1w		(BbufSel_s1w),
	.selAstore_s1w		(selAstore_s1w),
	.storeData_s2m		(storeData_s2m),
	.storeBufData_s1w	(storeBufData_s1w)
    );

signExtend signExtend (
	.dCacheBusOut_v2m	(dCacheBusOut_v2m[31:0]),
	.selByte1Pass_s2m	(selByte1Pass_s2m),
	.selByte1One_v2m	(selByte1One_v2m),
	.selByte1Zero_v2m	(selByte1Zero_v2m),	
	.selByte23Pass_s2m	(selByte23Pass_s2m),
	.selByte23One_v2m	(selByte23One_v2m),
	.selByte23Zero_v2m	(selByte23Zero_v2m),
	.cacheData_v2m		(cacheData_v2m)
    );

endmodule				  // loadStore
