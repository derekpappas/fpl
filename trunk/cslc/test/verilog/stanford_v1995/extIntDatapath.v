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
//  Title: 	External Interface Datapath
//  Created:	Tue Oct 20 21:37:12 1992
//  Author: 	Ricardo Gonzalez
//		<ricardog@caddy>
//
//
//  extIntDatapath.v,v 7.11 1995/02/08 01:30:37 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: Datapath partion of the external interface. This section 
//  	is responsible for latching the addresses given to the external
//  	interface and then comparing with the tags returned from the L2 cache.
//	A miss on the second level cache is detected at the same time by the
//	external interface and some external agent (gate-array). The external
//	agent is responsible for refilling the secod level cache.
//
//	Hierarchy:
//
//  Revision History:
//	Modified: Thu Dec  1 21:47:32 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified:	Sat Apr  9 16:31:47 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//

module extIntDatapath (
    Clock,
    loadNewAddr_s1,
    Stall_s2,
    selShMemAddr_s1,
    drvShMemAddr_q1,
    ratio_s2,
    SharedMemAddr_s1,
    L2Tag_s2,
    Phi1,
    Phi2,
    tagMatch_v2
    );

//
// Clocks
//
input		Clock;
input		loadNewAddr_s1;

//
// Stalls
//
input		Stall_s2;

//
// Inputs
//
input		selShMemAddr_s1;
input		drvShMemAddr_q1;
input [3:0]	ratio_s2;
inout [31:0]	SharedMemAddr_s1;
input [15:0]	L2Tag_s2;

//
// Outputs
//
output		Phi1;
output		Phi2;
output		tagMatch_v2;


//------------------------------------------------------------------------
//		        ---- DATAPATH SECTION ----
//------------------------------------------------------------------------
// Assume that the processor get 16-bit tags. It is up to the
// outside world to decide how to do this. The 16-bit tags have to
// match what the processor kept.
//
// Assume that there will be at most 5 cycles latency.
wire [15:0] 	addr0Tag_s2;
wire [15:0] 	addr1Tag_s1, addr1Tag_s2;
wire [15:0] 	addr2Tag_s1, addr2Tag_s2;
wire [15:0] 	addr3Tag_s1, addr3Tag_s2;

// Wire for the tag used in the compare
wire [15:0] 	addrTags_s2;
wire	[31:0]	memAddr_s1;
wire	[31:0]	memAddr_s2;
wire	[31:0]	addrPlusOne_s1;
wire		cOut_s1;
wire	[31:0]	newAddr_s1;

// Theese latches hold the address tags
PHI1_LATCH_EN_16	addr0Tag_S2(addr0Tag_s2, SharedMemAddr_s1[31:16],
				Phi1, loadNewAddr_s1);
PHI2_LATCH_EN_16	addr1Tag_S1(addr1Tag_s1, addr0Tag_s2, Phi2, Stall_s2);
PHI1_LATCH_EN_16	addr1Tag_S2(addr1Tag_s2, addr1Tag_s1,
				Phi1, loadNewAddr_s1);
PHI2_LATCH_EN_16	addr2Tag_S1(addr2Tag_s1, addr1Tag_s2, Phi2, Stall_s2);
PHI1_LATCH_EN_16	addr2Tag_S2(addr2Tag_s2, addr2Tag_s1,
				Phi1, loadNewAddr_s1);
PHI2_LATCH_EN_16	addr3Tag_S1(addr3Tag_s1, addr2Tag_s2, Phi2, Stall_s2);
PHI1_LATCH_EN_16	addr3Tag_S2(addr3Tag_s2, addr3Tag_s1,
				Phi1, loadNewAddr_s1);

PHI1_LATCH_EN_32	MemAddr_S2(memAddr_s2, newAddr_s1,
				Phi1, loadNewAddr_s1);
PHI2_LATCH_EN_32	MemAddr_S1(memAddr_s1, memAddr_s2, Phi2, Stall_s2);
ADD_32		addrPlusOne(addrPlusOne_s1, cOut_s1, memAddr_s1, 32'd8, 1'b0);
MUX2_32		NewAddr(newAddr_s1,
			SharedMemAddr_s1, addrPlusOne_s1,
			selShMemAddr_s1);
TRIBUF_32	ShMemAddr(SharedMemAddr_s1, newAddr_s1, drvShMemAddr_q1);

// This mux select one of the four addresses to do the tag compare
// (which one gets selected depends on the latency and the ratio 
// programmed at boot-time).
MUX4_16 addrTags_S2(addrTags_s2, addr3Tag_s2, addr2Tag_s2, addr1Tag_s2,
	addr0Tag_s2, ratio_s2[3], ratio_s2[2], ratio_s2[1], ratio_s2[0]);

// Compare tags with what is returned from L2$.
COMP_16 tagMatch_V2(tagMatch_v2, addrTags_s2, L2Tag_s2);


//------------------------------------------------------------------------
//                       ---- Clock Buffer -----
//------------------------------------------------------------------------
// This is the equivalent of the clock generator and distribution
// network. I should really instantiate something called byClock.
assign Phi1 = Clock;
assign Phi2 = ~Clock;

endmodule				  // extIntDatapath

