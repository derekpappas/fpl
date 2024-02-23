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
//  Title: 	dCache Interface Datapath
//  Created:	Sun Apr 24 18:25:06 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  dCacheDatapath.v,v 1.12 1995/02/14 01:24:16 ricardog Exp
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
//	Modified: Thu Dec  1 21:55:39 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//
`include "torch.h"

module dCacheDatapath (
    Phi1,
    Phi2,
    Stall_s2,
    dCacheBusOut_v2m,
    MemAddr_s1m,
    MemOp_s1m,
    storeOrMissAddr_s1,
    storeOrMissOp_s1,
    storeData_s1,
    SharedMemData_s2,
    latchStore_s1w,
    latchExtData_s2,
    dCacheIsLoad_s1m,
    dCacheIsStore_s1,
    latchCacheData_s1,
    drvSharedMemData_q2,
    pendStore_s2,
    dCacheAddr_s1m,
    dCacheBusIn_s1m,
    dCacheStoreOp_s1m
    );

//
// Clocks
//
input		Phi1;
input		Phi2;
input		Stall_s2;

//
// Interface w/ dCache megacell
//
output	[63:0]	dCacheBusIn_s1m;	  // Input into the dCache
input	[63:0]	dCacheBusOut_v2m;	  // Output from the dCache
output	[12:0]	dCacheAddr_s1m;		  // Line index into dCache
output	[1:0]	dCacheStoreOp_s1m;	  // Type of store (sb, sh, sw)

//
// Possible sources of addr intput into the dCache
//
input	[12:0]	MemAddr_s1m;		  // Addr out of the adder
input	[12:0]	storeOrMissAddr_s1;	  // Addr of a store (pipelined)
input	[2:0]	MemOp_s1m;
input	[2:0]	storeOrMissOp_s1;

//
// Possible sources of data input into the dCache
//
input	[31:0]	storeData_s1;		  // Store data (pipelined)
inout	[63:0]	SharedMemData_s2;	  // For spills/refills. Bus to ext-int

//
// Control inputs
//
input		latchCacheData_s1;	  // Latch data read from cache (spill)
input		latchExtData_s2;	  // Latch the data on ext-int bus
input		latchStore_s1w;		  // Allow a store into half-completed
					  // latch
input		drvSharedMemData_q2;	  // Drive spill data onto ext-int bus
input		pendStore_s2;		  // Store pending so clock latches
input		dCacheIsLoad_s1m;	  // Do a read access into the dCache
input		dCacheIsStore_s1;	  // Do a write access into the dCache

//
// Local data busses
//
wire	[63:0]	dCacheBusIn_s1m;
wire	[63:0]	dCacheData_s1;
wire	[63:0]	dCacheData_s2;
wire	[63:0]	sharedMemData_s1;
wire	[31:0]	pendStoreData_s2;	  // Delay store data for one cycle
wire	[31:0]	pendStoreData_s1s;	  // While the tag check happens
					  // commit on following cycle if no
					  // cnflict
//
// Local address busses (index only)
//
wire	[15:0]	pendStoreAddr_s2;	  // see above
wire	[15:0]	pendStoreAddr_s1s;	  // 
wire	[15:0]	storeOrMissAddr_s1s;	  // pipelined store or miss addr

//---------------------------------------------------------------------------
//			--- Pipeline Store ---
//---------------------------------------------------------------------------
// Latch store addr to pipeline access, and select one of store or miss addr
// NOTE: s1s => s1 of Store cycle
//
PHI1_LATCH_EN_16	pendStoreAddr_S2W(pendStoreAddr_s2,
			    {storeOrMissOp_s1, storeOrMissAddr_s1},
			    Phi1, latchStore_s1w);
PHI2_LATCH_EN_16	pendStoreAddr_S1S(pendStoreAddr_s1s, pendStoreAddr_s2,
			    Phi2, pendStore_s2);

//
// Select the store or miss addr
//
MUX2_16		storeOrMissAddr_S1S(storeOrMissAddr_s1s,
		    pendStoreAddr_s1s,
		    {storeOrMissOp_s1, storeOrMissAddr_s1},
		    dCacheIsStore_s1);

//
// Latch store data to pipeline access
// NOTE: s1s => s1 of Store cycle
//
PHI1_LATCH_EN_32	pendStoreData_S2(pendStoreData_s2, storeData_s1,
			    Phi1, latchStore_s1w);
PHI2_LATCH_EN_32	pendStoreData_S1S(pendStoreData_s1s, pendStoreData_s2,
			    Phi2, pendStore_s2);

//---------------------------------------------------------------------------
//			  --- Pipeline Mux ---
//---------------------------------------------------------------------------
// Select an addr into the dCache,
//  - load
//  - store or miss (cast-out).
// Implemented as a two level-mux since MemAddr_s1m is 
// critical
//
MUX2_15		dCacheAddr_S1M({dCacheStoreOp_s1m, dCacheAddr_s1m},
		    {MemOp_s1m[1:0], MemAddr_s1m},
		    storeOrMissAddr_s1s[14:0],
		    dCacheIsLoad_s1m);

//
// Select one of two possible data inputs into the cache
//
MUX2_64		dCacheBusIn_S1M(dCacheBusIn_s1m,
		    {pendStoreData_s1s, pendStoreData_s1s},
		    sharedMemData_s1,
		    dCacheIsStore_s1);

//---------------------------------------------------------------------------
//			--- Shared Mem Data ---
//---------------------------------------------------------------------------
//
// Latch data output of dCache and drive it onto SharedMemData
//
PHI2_LATCH_EN_64	dCacheData_S1(dCacheData_s1, dCacheBusOut_v2m,
			    Phi2, Stall_s2);
PHI1_LATCH_EN_64	dCacheData_S2(dCacheData_s2, dCacheData_s1,
			    Phi1, latchCacheData_s1);
TRIBUF_64	SharedMemData_S2(SharedMemData_s2, dCacheData_s2,
		    drvSharedMemData_q2);
		    
//
// Latch SharedMemData to write back into the dCache
//
PHI2_LATCH_EN_64	shMemData_S1(sharedMemData_s1, SharedMemData_s2,
			    Phi2, latchExtData_s2);

endmodule				  // dCacheDatapath
