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
//  Title: 	Register Sequential Loop
//  Created:	Mon Aug 22 15:34:25 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma.Stanford.EDU>
//
//
//  regSeqLoop.v,v 1.3 1995/01/28 00:51:01 ricardog Exp
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
//
`include "torch.h"

module regSeqLoop(
    Phi1,
    Phi2,
    sequential_s1e,
    ASeqPtr_v1e,
    BSeqPtr_v1e,
    AResDecoded_v1e,
    BResDecoded_v1e,
    BoostedValid_v1e,
    SlotExcept_v1w,
    BrExcept_v1w,
    Commit_v1e,
    SeqDefault_v1e
    );

//
// Clocks
//
input		Phi1;
input		Phi2;

//
// Inputs
//
input   [31:0]	AResDecoded_v1e;	  // Decoded 5-bit specifier
input	[31:0]	BResDecoded_v1e;
input 	[31:0]	BoostedValid_v1e;
input		SlotExcept_v1w;		  // Exception in delay slot
input		BrExcept_v1w;		  // Exception in branch
input		Commit_v1e;		  // 
input		SeqDefault_v1e;		  // ????

//
// Outputs
//
output	[31:0]	sequential_s1e;
output      	ASeqPtr_v1e;		  // Which register is the sequential
output		BSeqPtr_v1e;		  // register right now

//
// Wire declarations
//
wire 	[31:0]	sequential_s1e;		  // Pipeline chain of the state
wire	[31:0]	sequential_s2e;		  // of the register pointers
wire	[31:0]	sequential_s1m;		  // Needed in case there is an
wire	[31:0]	sequential_s2m;		  // exception
wire	[31:0]	sequential_s1w;
wire	[31:0]	nextsequential_v1e;	  // Updated value of pointers
wire	[31:0]	nextsequential_s2e;
wire 	[31:0]	pong_v1e;

//------------------------------------------------------------------------
//			---- Initialization ----
//------------------------------------------------------------------------
// synopsys translate_off
// vcheck_off
// The following code is to get the machine to come out of reset in Verilog.
// The problem is that we don't really care what boostvalid_s1e and
// nextboostvalid_s2e are initialized to. In the actual hardware they can be
// either 1 or 0. In Verilog, however, they come up as X's. To solve this I've
// added this hack.
always @(`PROCESSOR.Reset_s1) begin
    if (`PROCESSOR.Reset_s1) begin
	$display("Initializing register file pointers.");
    	force sequential_s1e = 0;
    	force nextsequential_s2e = 0;
    end
    else begin
    	release sequential_s1e;
    	release nextsequential_s2e;
    end
end
// synopsys translate_on
// vcheck_on

//
// Logic
//
XOR2_32 PONG (pong_v1e, sequential_s1e, BoostedValid_v1e);
//special use of TRISTATE BUFFER: 32X buffers driving a Word-Line structure
BITLINE_32 ASEQPTR(ASeqPtr_v1e, sequential_s1e, AResDecoded_v1e);
BITLINE_32 BSEQPTR(BSeqPtr_v1e, sequential_s1e, BResDecoded_v1e);

//
// Sequential Chain
//
PHI1_LATCH_32 seq_s2e (sequential_s2e, sequential_s1e, Phi1);
PHI2_LATCH_32 seq_s1m (sequential_s1m, sequential_s2e, Phi2);
PHI1_LATCH_32 seq_s2m (sequential_s2m, sequential_s1m, Phi1);
PHI2_LATCH_32 seq_s1w (sequential_s1w, sequential_s2m, Phi2);

//
// Sequential Loop
//
PHI2_LATCH_32 SEQ_phi2 (sequential_s1e, nextsequential_s2e, Phi2);
MUX4_32 SEQ (nextsequential_v1e, 
		sequential_s1w, sequential_s1m, pong_v1e, sequential_s1e,
		SlotExcept_v1w, BrExcept_v1w, Commit_v1e, SeqDefault_v1e);
PHI1_LATCH_32 SEQ_phi1 (nextsequential_s2e, nextsequential_v1e, Phi1);

endmodule				  // regSeqLoop
