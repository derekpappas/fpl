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
//  Title: 	dTag Interface Datapath
//  Created:	Sun Apr 24 18:01:48 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  dTagDatapath.v,v 1.10 1995/02/08 01:30:59 ricardog Exp
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
//	Modified: Thu Dec  1 21:56:28 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified:	Mon Apr 25 15:22:16 1994	<ricardog@chroma>
//	* Made stores pipelined.
//
`include "torch.h"

module dTagDatapath(
    Phi1,
    Phi2,
    MemAddr_s1m,
    PhysAddr_v2m,
    storeOrMissAddr_s1,
    dTagAddr_s1m,
    dTagData_v2m,
    dTagBusIn_v2,
    latchStore_s1w,
    pendStore_s2,
    dTagIsLoad_s1m,
    dTagIsLoad_s2m,
    cacheConflict_v1m,
    dTagData_s1
    );

//
// Clocks
//
input		Phi1;
input		Phi2;

//
// Three possible source for the Addr input of the dTags
//
input	[12:0]	MemAddr_s1m;		  // Unstranslated addr for tag index
input	[31:13]	PhysAddr_v2m;		  // translated addr for comparison
input	[31:0]	storeOrMissAddr_s1;

//
// The input addr that will be checked in the tags
//
output	[12:0]	dTagAddr_s1m;
output	[31:13]	dTagBusIn_v2;

//
// The output from the last query into the tags (from the dTag and latched)
//
input	[31:13]	dTagData_v2m;		  // straight from the tags
output	[31:13]	dTagData_s1;		  // and latched

//
// Finally the control wires
//
input		latchStore_s1w;		  // Keep addr of store probe
input		pendStore_s2;		  // Store pending so clock latch
input		dTagIsLoad_s1m;		  // Check tags for a load
input		dTagIsLoad_s2m;		  // Delay for a phase to do the 
output		cacheConflict_v1m;

//
// Local Tag busses
//
wire	[31:13]	dTagBusIn_v2;
wire	[31:13]	dTagData_s1;
wire	[31:13]	storeOrMissAddr_s2;	  // Delayed for tag compare

//
// Local Index busses
//
wire	[12:0]	dTagAddr_s1m;
wire	[12:0]	pendStoreAddr_s2;
wire	[12:0]	pendStoreAddr_s1s;

//---------------------------------------------------------------------------
//			 --- Pipeline Store ---
//---------------------------------------------------------------------------
// NOTE: _s1s => s1 of Store cycle
//
PHI1_LATCH_EN_13	pendStoreAddr_S2W(pendStoreAddr_s2,
			    storeOrMissAddr_s1[12:0], Phi1, latchStore_s1w);
PHI2_LATCH_EN_13	pendStoreAddr_S1S(pendStoreAddr_s1s, pendStoreAddr_s2,
			    Phi2, pendStore_s2);
COMP_10		cacheConflict(cacheConflict_v1m, MemAddr_s1m[12:3],
		    pendStoreAddr_s1s[12:3]);

//---------------------------------------------------------------------------
//			   --- Index Mux ---
//---------------------------------------------------------------------------
MUX2_13		dTagIndex(dTagAddr_s1m,
		    MemAddr_s1m[12:0],
		    storeOrMissAddr_s1[12:0],
		    dTagIsLoad_s1m);

//---------------------------------------------------------------------------
//			    --- Tag Mux ---
//---------------------------------------------------------------------------
// Select whether to do a probe for a load or a dirty probe on a miss or refill
//
PHI1_LATCH_19	dTagBus_S2(storeOrMissAddr_s2, storeOrMissAddr_s1[31:13],
		    Phi1);
MUX2_19		dTagBus(dTagBusIn_v2,
		    PhysAddr_v2m[31:13],
		    storeOrMissAddr_s2[31:13],
		    dTagIsLoad_s2m);

//
// Latch the output of the probe (if need to drive the membus)
//
PHI2_LATCH_19	dTagData(dTagData_s1, dTagData_v2m, Phi2);

endmodule				  // dTagDatapath
