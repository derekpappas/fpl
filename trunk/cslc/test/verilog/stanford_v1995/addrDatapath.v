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
//  Title: 	Address Datapath for Load/Stores
//  Created:	Mon Apr 25 17:21:42 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  addrDatapath.v,v 1.18 1995/02/08 01:30:54 ricardog Exp
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
//	Modified: Thu Dec  1 21:54:43 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//
`include "torch.h"

module addrDatapath (
    Phi1,
    Phi2,
    latchMissAddr_s2,
    MemAddr_s1m,
    PhysAddr_v2m,
    storeBufAddr_s1w,
    dTagData_s1,
    drvSharedMemAddr_q1,
    selFastStore_s1m,
    selStoreAddr_s1,
    selMissAddr_s1,
    selProbeAddr_s1,
    selSpillAddr_s1,
    selBuffMissAddr_s1,
    popStoreBuffer_s1,
    MemOp_s1m,
    MemOp_s2m,
    lineOffset_s1,
    byteOffset_s2m,
    missOp_s1,
    storeOrMissAddr_s1,
    storeOrMissOp_s1,
    lineOffset_s1w,
    missOp_s1w,
    SharedMemAddr_s1
    );

//---------------------------------------------------------------------------
//			     --- Ports ---
//---------------------------------------------------------------------------
//
// Clocks
//
input		Phi1;
input		Phi2;
input		latchMissAddr_s2;

//
// Address inputs
//
input	[31:0]	MemAddr_s1m;		 // arrggg!!!
input	[31:2]	PhysAddr_v2m;		 // Translated address
input	[34:0]	storeBufAddr_s1w;
input	[31:13]	dTagData_s1;		 // Tag from probe (spill addr)

//
// Control signals
//
input		drvSharedMemAddr_q1;	 // drv addr of spill/fill to ext-int
input		selFastStore_s1m;	 // Use un-buffered addr and data
input		selStoreAddr_s1;	 // select addr of store
input		selMissAddr_s1;		 // select addr of miss
input		selProbeAddr_s1;	 // select shMemAddr (for probe)
input		selSpillAddr_s1;	 // drv spill addr on shMemAddr
input		selBuffMissAddr_s1;	 // select btw buf & phys miss addr
input		popStoreBuffer_s1;	 // Latch addr from sto buffer
input	[2:0]	MemOp_s1m;		 // Type of load store (lb, lh, lw)
input	[2:0]	MemOp_s2m;
input	[4:0]	lineOffset_s1;		 // Offset into the cache line (word)
input	[1:0]	byteOffset_s2m;
input	[2:0]	missOp_s1;		 // Need to make sure it is 2'b00 on
					 // a cache spill/fill

//
// External Interface Connections
//
inout	[31:0]	SharedMemAddr_s1;	  // Address of external request

//
// dTag and dCache busses
//
output	[31:0]	storeOrMissAddr_s1;	  // Addr of store or miss
output	[2:0]	storeOrMissOp_s1;
output	[4:0]	lineOffset_s1w;
output	[2:0]	missOp_s1w;

//
// Wires
//
wire	[31:0]	sharedMemAddr_s1;
wire	[34:0]	storeAddr_s1;
wire	[34:0]	missAddr_s1w;
wire	[34:0]	missAddr_v2m;
wire	[34:0]	storeBufAddr_s2;
wire	[34:0]	stoBufMissAddr_s1;
wire	[34:0]	physMissAddr_s1w;

assign lineOffset_s1w = missAddr_s1w[4:0];
assign missOp_s1w = missAddr_s1w[34:32];

//---------------------------------------------------------------------------
//			 --- Store Or Miss ---
//---------------------------------------------------------------------------
MUX2_35		storeAddr(storeAddr_s1,
		    {MemOp_s1m, MemAddr_s1m}, storeBufAddr_s1w,
		    selFastStore_s1m);

PHI1_LATCH_EN_35	storeBAddr(storeBufAddr_s2, storeBufAddr_s1w,
		    Phi1, popStoreBuffer_s1);
PHI2_LATCH_35	storeBAddr2(stoBufMissAddr_s1, storeBufAddr_s2, Phi2);

assign missAddr_v2m = {MemOp_s2m, PhysAddr_v2m, byteOffset_s2m};
PHI2_LATCH_EN_35	physAddr(physMissAddr_s1w, missAddr_v2m,
			    Phi2, latchMissAddr_s2);

MUX2_35		missAddr(missAddr_s1w,
		    stoBufMissAddr_s1,
		    physMissAddr_s1w,
		    selBuffMissAddr_s1);

MUX3_35		storeOrMiss({storeOrMissOp_s1, storeOrMissAddr_s1},
		    {missOp_s1, missAddr_s1w[31:5], lineOffset_s1},
		    storeAddr_s1,
		    {3'b010, SharedMemAddr_s1},
		    selMissAddr_s1, selStoreAddr_s1, selProbeAddr_s1);

MUX2_32		sharedMemAddr(sharedMemAddr_s1,
		    {dTagData_s1[31:13], storeOrMissAddr_s1[12:0]},
		    storeOrMissAddr_s1,
		    selSpillAddr_s1);
TRIBUF_32	ShMemSdrv(SharedMemAddr_s1, {sharedMemAddr_s1[31:5], 5'b0},
		    drvSharedMemAddr_q1);

endmodule				  // addrDatapath
