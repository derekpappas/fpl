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
//  Title: 	Instruction Fetch Datapath
//  Created:	Thu Mar 24 15:50:57 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  IFetchDatapath.v,v 7.25 1995/01/28 00:47:59 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//	    Instruction Fetcher/Instruction Cache unit.  This Section
//	    contains all the Datapath Modules and Components All it's
//	    control signals will come from IFetchControl.v Three main
//	    Sections
//		1) ICache Refill
//		2) ICache Instruction Fetch
//		3) Tag/PID Comparator
//
//	Hierarchy:  Torch.instrFetch
//
//  Revision History:
//	Modified: Thu Dec  1 21:48:31 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified: Wed Nov 30 14:49:05 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed to explicit latch qualification.
//	Modified: Wed Nov 30 13:16:00 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed the disasm code.
//	Modified: Sun Aug  7 22:17:35 1994	<ricardog@chroma.Stanford.EDU>
//	* Moved ICACHE outside of IFetchDatapath.
//	Modified:	Sun May 22 16:33:21 1994	<ricardog@chroma>
//	* Changed Psi2_q2 to Phi2.
//	Modified:	Sat Apr  9 16:48:48 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//
`include "torch.h"

module IFetchDatapath(
    Phi1,
    Phi2,
    Stall_s2,
    InstrAddr_s2i,
    MipsMode_s2e,
    SharedMemData_s2,
    SharedMemAddr_s1,
    NonCacheableHeld_s1,
    ExtDataValid_s2,
    LatchShiftReg_s1,
    LatchDataReg_s1,
    ExtMuxSelect_s1,
    ICacheOutData_v1r,
    ICacheOutTag_v1r,
    PCPID_v2r,
    LatchNonCachePkt_s2,
    LatchTags_s1r,
    ADrvB_s2r,
    BDrvA_s2r,
    LatchInstrs_s1r,
    ADynamicBit_v1r,
    BDynamicBit_v1r,
    AInstr_s2r,
    BInstr_s2r,
    Match_v2r,
    ICacheLineValid_s2r,
    ICacheInData_s2,
    ICacheInTag_s2,
    L1Hit_s1
    );

//----------------------------------------------------------------------------
input		Phi1;			// clocks
input		Phi2;			// 
input		Stall_s2;
input	[29:13]	InstrAddr_s2i;		// PC from PC Unit
input		MipsMode_s2e;		// MIPS mode bit from coprocessor
// SharedMemData_s2 must be bidirectional (inout) for cache testing
input	[63:0]	SharedMemData_s2;	// 64 bit data bus from external mem
input	[31:0]	SharedMemAddr_s1;	// for external requests/tests
input		NonCacheableHeld_s1;	// instruction access is non-cachabl
input		ExtDataValid_s2;	// phi2 & ExtDataVaild_s2
input		LatchShiftReg_s1;	// qualified with phi1
input		LatchDataReg_s1;
input		ExtMuxSelect_s1;        // from IFetchFSM
input	[5:0]	PCPID_v2r;		// PID from coprocessor
input		LatchNonCachePkt_s2;	// latch in nonCacheable
input		ADrvB_s2r, BDrvA_s2r;	// routing muxes
input		LatchInstrs_s1r;			
input		LatchTags_s1r;		// 
output		ADynamicBit_v1r, BDynamicBit_v1r;
output	[39:0]	AInstr_s2r, BInstr_s2r; // A,B Instruction Registers
output		Match_v2r;		// output of the comparator
output		ICacheLineValid_s2r;
output		L1Hit_s1;		// For cache testing (NOT IMPLEMENTED)

wire	[23:0]	ITagPid_s2r;		// combine tag and pid and valid bit
wire	[22:0]	PCTagPid_v2r;		//combine tag and pid
wire		Match_v2r;		//output of comparator
wire	[63:0]	SharedMemData_s1;	// latched of s2
wire	[63:0]	DataReg_s2;		// 64 bit register for incoming instr
wire	[63:0]  ExtMuxOut_s1;		// mux going into shift register
wire	[63:0]  ShiftReg_s2;		// shift register containing ext bytes
wire	[63:16]	ShiftReg_s1;		// phase later for shifting purposes
output	[79:0]	ICacheInData_s2;	// 80 bit wide path write to cache
output	[23:0]	ICacheInTag_s2;
input	[79:0]	ICacheOutData_v1r;	// Internal MUX which spits out 2 pkts
input	[23:0]	ICacheOutTag_v1r;	
wire	[79:0]	NonCacheablePacket_s1;	// contains non-cacheable instr
wire	[39:0]	AInstr_v1r, BInstr_v1r;	// instructions out of ICache
wire		ADynamicBit_v1r;	// dynamic NOOP bit out of cache
wire		BDynamicBit_v1r;	// dynamic NOOP bit out of cache
wire	[39:0]	AInstrLatch_s2r, BInstrLatch_s2r; // instruction latches
wire	[39:0]	AInstr_s2r, BInstr_s2r;	// instruction buses
wire	[16:0]	PCTag_s1r;		// latched PC Tag (MSB 17 bits of PC)
wire	[16:0]	PCTag_s2r;		// delayed PC Tag (MSB 17 bits of PC)
wire		L1Hit_s1;		// For cache testing (NOT IMPLEMENTED)

//---------------------------------------------------------------------------
//			Initialization
//---------------------------------------------------------------------------
// vcheck_off
// synopsys translate_off
//`ifdef ALL
integer	    disasm, last;
reg	    MipsMode_s1;
initial begin
    if ($test$plusargs("disasm")) begin
    	$tdis_init("", "", 2, 1);
    	disasm = 1;
    end
    else
    	disasm = 0;
end

//---------------------------------------------------------------------------
//			Print disassembled instructions
//---------------------------------------------------------------------------
// Living dangerously
always @(Phi2 or MipsMode_s2e) begin
    if (Phi2) `TICK MipsMode_s1 = MipsMode_s2e;
end

always @(posedge Phi1) begin
    if (disasm) begin
    	if (`PROCESSOR.IStall_s1) begin
    	    if (last != 0) begin
    	    	$display("%t\tIStall", $time);
	    end
    	    last = 0;
	end
    	else if (`PROCESSOR.MemStall_s1) begin   
    	    if (last != 1) begin
    	    	$display("%t\tMemStall", $time);
    	    end
    	    last = 1;
	end
    	else if (`IFC.HoldPC_s2e) begin
    	    $display("%t\t", $time);
	end
	else begin
    	    $write("%t\t", $time);
	    if (MipsMode_s1) begin
		if (`PCU.PCChain_s2r[0] == 1'b1)
		    $tdis(AInstr_s2r, {2'b0, `PCU.PCChain_s2r});
		else
		    $tdis(BInstr_s2r, {2'b0, `PCU.PCChain_s2r});
	    end
	    else begin
		$tdis(AInstr_s2r, {2'b0, `PCU.PCChain_s2r});
		$display("");
		$write("                    \t");
		$tdis(BInstr_s2r, {2'b0, `PCU.PCChain_s2r} | 32'b1);
	    end
	    $display("");
	    last = 2;
	end
    end
end
// synopsys translate_on
// vcheck_on
//`endif

//---------------------------------------------------------------------------
//			Refill Section
//---------------------------------------------------------------------------
// Latch SharedMemData_s2 bus; delay one phase; data actually written
// Phi2 of next cycle.

PHI2_LATCH_EN_64 LATCH_64_SharedMem(SharedMemData_s1, SharedMemData_s2,
			Phi2, ExtDataValid_s2);

// THIS LATCH THE DATA PART FROM SharedMemData_s1

PHI1_LATCH_EN_64 LATCH_64_DATA (DataReg_s2, SharedMemData_s1,
			Phi1, LatchDataReg_s1);

// This section breaks up the extension bytes and shift Ext Bytes to the
// right
//
// Three set of 2-1 mux's. WHen we get the ext bytes load the contents
// of SharedMemData_s1. Otherwise shift left the contesnts of ShiftReg_s2
MUX2_16	MUX2_16_ExtMuxOut1 (ExtMuxOut_s1[15:0],
			SharedMemData_s1[15:0], ShiftReg_s1[31:16],
			ExtMuxSelect_s1);
MUX2_16	MUX2_16_ExtMuxOut2 (ExtMuxOut_s1[31:16],
			SharedMemData_s1[31:16], ShiftReg_s1[47:32],
			ExtMuxSelect_s1);
MUX2_16	MUX2_16_ExtMuxOut3 (ExtMuxOut_s1[47:32],
			SharedMemData_s1[47:32], ShiftReg_s1[63:48],
			ExtMuxSelect_s1);

// Four latches 16-bits wide each for ShiftReg_s2
PHI1_LATCH_EN_64 LATCH_SHFTREG_S2 (ShiftReg_s2,
			{SharedMemData_s1[63:48], ExtMuxOut_s1[47:0]},
			Phi1, LatchShiftReg_s1);

// Three latches for ShiftReg_s1. The low order bits are lost
PHI2_LATCH_EN_48	LATCH_SHFTREG_S1 (ShiftReg_s1[63:16],
			ShiftReg_s2[63:16], Phi2, Stall_s2);

//  the following gets the ext bytes and data into icache
//  If it's Mipsmode then the ext bytes are all zeros
MUX2_8	MUX2_8_MipsMode2 (ICacheInData_s2[79:72], 8'b0, ShiftReg_s2[15:8],
			MipsMode_s2e);

MUX2_8	MUX2_8_MipsMode1 (ICacheInData_s2[39:32], 8'b0, ShiftReg_s2[7:0],
			MipsMode_s2e);

assign ICacheInData_s2[31:0]  = DataReg_s2[31:0];
assign ICacheInData_s2[71:40]  = DataReg_s2[63:32];

//  should have PCTag_s2r, PCPID_v2r, 1 (for Valid bit) as inputs for this
//  file from PCunitDatapath.v so that these data can be written into
//  ICache
assign ICacheInTag_s2 = {PCTagPid_v2r,1'b1};

// ICache Module
// It should consist of:
//		1) 10 bits of index address -- WordLineDecode_s1r
//		2) 2 bits of address to select which 80bits of ICache to write
//		   into -- WritePack_s2
//		3) 2 bits of address to select which 80 bits of ICache to read
//			-- PCPacketNum_s1r
//		4) 80 bit write bus -- ICacheInData_s2
//		5) 80 bit read bus  -- ICacheOutData_v1r
//		6) 24 bit write bus for Tag, PID, and Valid bit 
//			-- PCTag_s2r, PCPID_v2r, 1 (for Valid bit)
//			-- it's combined as ICacheInTag
//		6) 24 bit read bus for Tag, PID, and Valid bit
//		  -- ICacheLineTag_v1r, ICacheLinePID_v1r, ICacheLineValid_v1r
//		  -- it's combined as ICacheOutTag
//		7) Control signal input WriteDataValid_q2 for writing data into
//			cache
//		8) Control signal input WriteTagValid_q2 for writing tag and
//			PID and Valid bit into cache (necessary?)

// ICacheInData_s2 also will write into nonCacheablePacket latch

PHI2_LATCH_EN_80 LATCH_80_NonCacheable (NonCacheablePacket_s1, ICacheInData_s2,
			Phi2, LatchNonCachePkt_s2);

//----------------------------------------------------------------------------
//			ICache Instruction Fetch
//----------------------------------------------------------------------------

MUX2_40		MUX2_40_Non$A	(AInstr_v1r, NonCacheablePacket_s1[39:00],
			ICacheOutData_v1r[39:00], NonCacheableHeld_s1);

MUX2_40		MUX2_40_Non$B	(BInstr_v1r, NonCacheablePacket_s1[79:40],
			ICacheOutData_v1r[79:40], NonCacheableHeld_s1);


assign ADynamicBit_v1r = AInstr_v1r[38];
assign BDynamicBit_v1r = BInstr_v1r[38];


PHI1_LATCH_EN_40 LATCH_40_InstrA (AInstrLatch_s2r, AInstr_v1r, Phi1,
			LatchInstrs_s1r);
PHI1_LATCH_EN_40 LATCH_40_InstrB (BInstrLatch_s2r, BInstr_v1r, Phi1,
			LatchInstrs_s1r);

MUX2_40		MUX2_40_BDrvA	(AInstr_s2r, BInstrLatch_s2r, AInstrLatch_s2r,
			  BDrvA_s2r);
MUX2_40		MUX2_40_ADrvB	 (BInstr_s2r, AInstrLatch_s2r, BInstrLatch_s2r,
			  ADrvB_s2r);

//----------------------------------------------------------------------------
//			Comparator Section
//----------------------------------------------------------------------------

// It's possible to put these in one 29 bit wide latch
//	Phi1 latches
PHI2_LATCH_EN_17	LATCH_17_Tag_s1 (PCTag_s1r, InstrAddr_s2i[29:13],
			Phi2, ~Stall_s2);

PHI1_LATCH_EN_24 LATCH_24_OutTag (ITagPid_s2r, ICacheOutTag_v1r,
			Phi1, LatchTags_s1r);
PHI1_LATCH_EN_17 LATCH_17_Tag_s2 (PCTag_s2r, PCTag_s1r,
			Phi1, LatchTags_s1r);
//
//	output the valid bit as control signal to IFetchControl.v
assign ICacheLineValid_s2r = ITagPid_s2r[0];

//	Combine tag with pid and input into the 23 bits comparator

assign PCTagPid_v2r = {PCTag_s2r, PCPID_v2r};

COMP_23		COMP_23_CacheMiss(Match_v2r, ITagPid_s2r[23:1], PCTagPid_v2r);


endmodule				  // IFetchDatapath
