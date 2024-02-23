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
//  Title: 	TLB Datapath Module
//  Created:	Wed Apr  6 19:22:23 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  tlbDatapath.v,v 7.28 1995/08/03 22:29:19 ricardog Exp
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
//	Modified: Thu Dec  1 21:46:19 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified: Thu Dec  1 21:27:51 1994	<ricardog@chroma.Stanford.EDU>
//	* Added explicit latch enables.
//	Modified: Mon Jun 27 15:16:49 1994	<ricardog@chroma.Stanford.EDU>
//	* Renamed Reset to Reset_s1
//	Modified:	Sun May 22 16:12:42 1994	<ricardog@chroma>
//	* Removed MemStall_s2.
//	Modified:	Fri Apr  8 15:15:27 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//
`include "torch.h"

module tlbDatapath(
    Phi1,
    Phi2,
    Stall_s1,
    Stall_s2,
    Cp0Bus_s2m,
    Cp0Bus_s1w,
    MemAddr_s1m, 
    InstrAddr_s2i,
    instrAddr_s1e,
    SharedMemAddr_s1,
    tlbAddr_s1w, 
    ICacheMiss_s1e,
    MipsMode_s2e,
    drvSharedMemAddr_s1,
    ICMiss_s1,
    selMemAddr_s1m,
    TLBWriteR_s1m,
    TLBWriteOrProbe_s1m,
    TLBProbe_s1w,
    TLBRead_s1w,
    IndexSel_s2m, 
    RandomSel_s2m,
    EntryHiSel_s2m,
    EntryLoSel_s2m,
    EntryHiIn_s1m,
    EntryLoIn_s1m,
    EntryHiOut_v2m,
    EntryLoOut_v2m,
    PhysAddr_v2m, 
    PCPID_v2r,
    EntryHi_s2w,
    enabIndexLatch_s1w,
    enabEntryHiLatch_s1w, 
    enabEntryLoLatch_s1w,
    enabPOLatch_s2m,
    tlbDrive_v2m,
    unCacheOrMap_s2e,
    selSaveInstr_s1,
    enabSaveInstrLatch_s1, 
    resetRandom_v1,
    randomEqual8_v1,
    IndexIn_s1m,
    IndexOut_v2m
    );

//---------------------------------------------------------------------------
// Clocks
//---------------------------------------------------------------------------
input		Phi1;
input		Phi2;
input		Stall_s1;
input		Stall_s2;

//---------------------------------------------------------------------------
// Busses : Address from PC Unit, and to Load/Store Unit
//---------------------------------------------------------------------------
output 	[31:0] 	Cp0Bus_s2m;
input	[31:0]	Cp0Bus_s1w;
input 	[31:0] 	MemAddr_s1m;
input 	[29:0] 	InstrAddr_s2i;
wire	[31:2] 	InstrAddr_s1r;
wire	[31:2]  InstrAddr_s1e;
wire	[31:2] 	InstrAddr_s2r;
output	[31:29]	instrAddr_s1e;
wire	[31:2]	preInstrAddr_s1e;
wire	[31:2]	saveInstrAddr_s1;
wire	[31:2]	saveInstrAddr_s2;
output	[31:0]	SharedMemAddr_s1;
output	[31:2]	tlbAddr_s1w;

//---------------------------------------------------------------------------
// TLB Register Select Signals
//---------------------------------------------------------------------------
input 		IndexSel_s2m;
input		RandomSel_s2m;
input		EntryHiSel_s2m;
input		EntryLoSel_s2m;

//---------------------------------------------------------------------------
// ICache Miss Signals (from IFetcher, to External Interface)
//---------------------------------------------------------------------------
input		ICacheMiss_s1e;
input		ICMiss_s1; 
input		selMemAddr_s1m;
input		drvSharedMemAddr_s1;
input		MipsMode_s2e;

//---------------------------------------------------------------------------
// Decoded Op Codes - TLB Instructions
//---------------------------------------------------------------------------
input		TLBWriteR_s1m;
input		TLBWriteOrProbe_s1m;
input		TLBProbe_s1w;
input		TLBRead_s1w;

//---------------------------------------------------------------------------
// TLB Outputs - Physical Tag, Not_Cacheable bit of entry
//---------------------------------------------------------------------------
output 	[31:2] 	PhysAddr_v2m;
output 	[5:0] 	PCPID_v2r;
wire 	[31:12]	PhysicalTag_v2m;		// Physical Tag of Address
wire	[11:2]	PhysicalOffset_s2m;		// Physical Offset of Address
wire 	[31:12]	PhysicalTag_s1;			// Physical Tag of Address s1
wire	[11:2]	PhysicalOffset_s1;		// Physical Offset of Address

//---------------------------------------------------------------------------
// CP0 Internal Registers/Signals
//---------------------------------------------------------------------------
input	[6:0]	IndexOut_v2m;
wire 	[6:0] 	Index_s2w;			// TLB Index Register
wire 	[6:0] 	index_s1;
wire	[6:0]	Index_s1w;
wire	[6:0]	preIndex_s1w;
wire 	[5:0] 	Random_s2, random_s1;		// TLB Random Register
output		randomEqual8_v1;
wire		randomCout_v1;
input		resetRandom_v1;
output	[31:6]	EntryHi_s2w;			// TLB EntryHi Register
output	[31:6]	EntryHiIn_s1m;
input	[31:6]	EntryHiOut_v2m;
wire	[31:6]	entryHi_s1;
wire	[31:6]	EntryHi_s1w;
wire	[31:6]	preEntryHi_s1w;
output	[31:8]	EntryLoIn_s1m;
input	[31:8]	EntryLoOut_v2m;
wire	[31:8]	EntryLo_s2w;			// TLB EntryLo Register
wire	[31:8]	EntryLo_s1w;
wire	[31:8]	preEntryLo_s1w;

wire	[31:0]	tlbData_v2m;			// Cp0Bus data out
input 		tlbDrive_v2m;			// Cp0Bus output enabled

wire 	[29:0]	tlbAddr_s2m;			// Address used to probe
wire	[31:12]	pfn_v2m;			// PFN read from tlb
input		enabSaveInstrLatch_s1;
input		selSaveInstr_s1;
input		unCacheOrMap_s2e;

input		enabIndexLatch_s1w; 
input		enabEntryHiLatch_s1w; 
input		enabEntryLoLatch_s1w;
wire	[5:0]	randomMinusOne_v1,randomNext_v1;
output	[5:0]	IndexIn_s1m;
wire	[29:0]	InstrNumber_v2i;
wire	[31:2]	InstrAddr_v2i;
wire		InstrNumberCout_v2i;
wire	[29:0]	tlbAddr_s1m;
wire	[9:0]	prePhysicalOffset_s2m;
input		enabPOLatch_s2m;

//---------------------------------------------------------------------------
//		     --- Continious Assignments ---
//---------------------------------------------------------------------------
assign instrAddr_s1e[31:29] = preInstrAddr_s1e[31:29];
assign PhysAddr_v2m = {PhysicalTag_v2m, PhysicalOffset_s2m};
assign PCPID_v2r = EntryHi_s2w[11:6];
assign pfn_v2m = EntryLoOut_v2m[31:12];
assign EntryHiIn_s1m[31:12] = tlbAddr_s1m[29:10];
assign EntryHiIn_s1m[11:6] = entryHi_s1[11:6];

//---------------------------------------------------------------------------
// Cp0Bus tristate driver
//---------------------------------------------------------------------------
MUX4_32		Cp0BusMux (tlbData_v2m,
			{Index_s2w[6],17'b0,Index_s2w[5:0],8'b0},
			{EntryHi_s2w,6'b0},{EntryLo_s2w,8'b0},
			{18'b0,Random_s2,8'b0},
			IndexSel_s2m, EntryHiSel_s2m, EntryLoSel_s2m,
			RandomSel_s2m);
TRIBUF_32	Cp0BusTri (Cp0Bus_s2m, tlbData_v2m, tlbDrive_v2m);

//---------------------------------------------------------------------------
// Random Register
//---------------------------------------------------------------------------
COMP_6		randomResetComp (randomEqual8_v1, random_s1, 6'd8);
ADD_6		randomAdder (randomMinusOne_v1, randomCout_v1, random_s1,
			6'b111111,1'b0);
MUX2_6		randomMux (randomNext_v1, 6'd63, randomMinusOne_v1,
			resetRandom_v1);
PHI1_LATCH_6	randomPhi1Latch (Random_s2, randomNext_v1, Phi1);
PHI2_LATCH_6	randomPhi2Latch (random_s1, Random_s2, Phi2);

//---------------------------------------------------------------------------
// Index Register
//---------------------------------------------------------------------------
PHI2_LATCH_7	IndexLatch(Index_s1w, IndexOut_v2m, Phi2);
MUX2_7		IndexMux (preIndex_s1w,
			Index_s1w, {Cp0Bus_s1w[31],Cp0Bus_s1w[13:8]},
			TLBProbe_s1w);
PHI1_LATCH_EN_7	IndexPhi1Latch (Index_s2w, preIndex_s1w, Phi1,
			enabIndexLatch_s1w);
PHI2_LATCH_EN_7	IndexPhi2Latch(index_s1, Index_s2w, Phi2, ~Stall_s2);

//---------------------------------------------------------------------------
// Mux to select index for tlb read/write
//---------------------------------------------------------------------------
MUX2_6		TLBIndexMux (IndexIn_s1m,
			random_s1, index_s1[5:0],
			TLBWriteR_s1m);

//---------------------------------------------------------------------------
// EntryHi Register
//---------------------------------------------------------------------------
PHI2_LATCH_26	EntryHiLatch (EntryHi_s1w, EntryHiOut_v2m[31:6], Phi2);
MUX2_26		EntryHiMux (preEntryHi_s1w, EntryHi_s1w, Cp0Bus_s1w[31:6],
			TLBRead_s1w);
PHI1_LATCH_EN_26	EntryHiPhi1Latch (EntryHi_s2w, preEntryHi_s1w, Phi1,
			enabEntryHiLatch_s1w);
PHI2_LATCH_EN_26	EntryHiPhi2Latch (entryHi_s1, EntryHi_s2w,
			Phi2, ~Stall_s2);

//---------------------------------------------------------------------------
// EntryLo Register
//---------------------------------------------------------------------------
PHI2_LATCH_24	EntryLoLatch (EntryLo_s1w, EntryLoOut_v2m[31:8], Phi2);
MUX2_24		EntryLoMux (preEntryLo_s1w, EntryLo_s1w, Cp0Bus_s1w[31:8],
			TLBRead_s1w);
PHI1_LATCH_EN_24	EntryLoPhi1Latch (EntryLo_s2w, preEntryLo_s1w, Phi1,
			enabEntryLoLatch_s1w);
PHI2_LATCH_EN_24	EntryLoPhi2Latch (EntryLoIn_s1m, EntryLo_s2w,
			Phi2, ~Stall_s2);

//---------------------------------------------------------------------------
// Setting up the address for translation
// WARNING: InstrAddr_s2i from PC unit is a 29:0 bus. From this point
// on addresses are 31:2.
//---------------------------------------------------------------------------
ADD_30		InstrNumber_v2Adder (InstrNumber_v2i, InstrNumberCout_v2i,
			{2'b0, InstrAddr_s2i[29:3], 1'b0},
			{InstrAddr_s2i[29:3], 3'b0}, 1'b0);
MUX2_30		MipsMux (InstrAddr_v2i,
			{InstrAddr_s2i[29:3], 3'b0},
			InstrNumber_v2i,
			MipsMode_s2e);
PHI2_LATCH_EN_30	InstrAddr_s1rLatch (InstrAddr_s1r, InstrAddr_v2i,
			Phi2, ~Stall_s2);
PHI1_LATCH_EN_30	InstrAddr_s2rLatch (InstrAddr_s2r, InstrAddr_s1r,
			Phi1, ~Stall_s1);
PHI2_LATCH_EN_30	InstrAddr_s1eLatch (InstrAddr_s1e, InstrAddr_s2r,
			Phi2, ~Stall_s2);
PHI1_LATCH_EN_30	saveInstrAddr_s2Latch (saveInstrAddr_s2, InstrAddr_s1e,
			 Phi1, enabSaveInstrLatch_s1);
PHI2_LATCH_EN_30	saveInstrAddr_s1Latch (saveInstrAddr_s1, saveInstrAddr_s2,
			Phi2, ~Stall_s2);
MUX2_30		instrAddrMux (preInstrAddr_s1e[31:2],
			saveInstrAddr_s1, InstrAddr_s1e,
			selSaveInstr_s1);
MUX3_30		tlbAddr_s2mMux (tlbAddr_s1m,
			preInstrAddr_s1e, MemAddr_s1m[31:2],{entryHi_s1, 4'b0},
			ICMiss_s1, selMemAddr_s1m, TLBWriteOrProbe_s1m);
PHI1_LATCH_30	tlbAddr_s2mLatch (tlbAddr_s2m, tlbAddr_s1m, Phi1);
PHI2_LATCH_EN_30	tlbAddr_s1wLatch (tlbAddr_s1w[31:2], tlbAddr_s2m,
			Phi2, ~Stall_s2);
MUX2_10		PhysicalOffset_s2mMux (prePhysicalOffset_s2m,
			InstrAddr_s1e[11:2], MemAddr_s1m[11:2],
			ICacheMiss_s1e);
PHI1_LATCH_10	PhysicalOffset_s2mLatch (PhysicalOffset_s2m,
			prePhysicalOffset_s2m, Phi1);

//---------------------------------------------------------------------------
// ICache Miss Request
//---------------------------------------------------------------------------

// Will have to change later to be:
//
// MUX2_20 PhysicalTag_v2mMux(PhysicalTag_v2m,{3'b0,tlbAddr_s2m[28:12]},
//	pfn_v2m,unCacheOrMap_s2e,!unCacheOrMap_s2e);
//
// so that the pages will map to the first .5Meg of memory
// as stated in MIPS book

MUX2_20		PhysicalTag_v2mMux (PhysicalTag_v2m,
			tlbAddr_s2m[29:10], pfn_v2m,
			unCacheOrMap_s2e);
PHI2_LATCH_20	PhysicalTag_s1Latch (PhysicalTag_s1, PhysicalTag_v2m, Phi2);

PHI2_LATCH_EN_10	PhysicalOffset_s1Latch (PhysicalOffset_s1,
			PhysicalOffset_s2m, Phi2, enabPOLatch_s2m);
TRIBUF_32	SharedMemAddrTri (SharedMemAddr_s1,
			{PhysicalTag_s1, PhysicalOffset_s1, 2'b0},
			drvSharedMemAddr_s1);

endmodule
