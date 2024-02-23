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
//  Title: 	Register File Megacell
//  Created:	Tue Mar 29 18:43:13 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  register.v,v 7.15 1995/01/28 00:51:08 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//	    WARNING: This file contains more than one module.  register
//	    contains the 32 general purpose registers.  Register 0 is
//	    always zero. Writes to it are ignored.  Write is during Phi1
//	    of WB, reads are during Phi2 of RD.  register 29 is the
//	    stack pointer, which may want to be initialized specially -
//	    watch out.  REGFILE is a megacell to be implemented. To
//	    verilog and synopsys it looks like a black box.
//
//	Hierarchy: 
//
//  Revision History:
//	Modified:	Sun May 22 16:49:41 1994	<ricardog@chroma>
//	* Changed IStall_s1 to Stall_s1.
//	Modified:	Sat Apr  9 17:33:53 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Tue Mar 29 19:15:38 1994	<ricardog@chroma>
//	* Cleanup and moved macros.
//
`include "torch.h"

module register(
    Phi1,
    Phi2, 
    Commit_s1e,
    Squash_s1e,
    Stall_s1,
    Except_s1w,
    ASDSpec_w,
    BSDSpec_w,
    ATRSpec_w,
    BTRSpec_w,
    AWBData_s1w,
    BWBData_s1w,
    ASData_v2r,
    BSData_v2r,
    ATData_v2r,
    BTData_v2r,
    ADestBoostValid_v1e,
    BDestBoostValid_v1e,
    ADestPtr_v1e,
    BDestPtr_v1e
    );

//
// Clocks & Stalls
//
input 		Phi1;
input		Phi2;
input		Stall_s1;
input		Except_s1w;

//
// Inputs
//
input 		Commit_s1e, Squash_s1e;
input	[7:0]	ASDSpec_w, BSDSpec_w;
input	[6:0]	ATRSpec_w, BTRSpec_w;
input	[31:0]	AWBData_s1w, BWBData_s1w;

//
// Output Data busses
//
output	[31:0]	ASData_v2r;
output	[31:0]	ATData_v2r;
output	[31:0]	BSData_v2r;
output	[31:0]	BTData_v2r;

//
// Destination Pointer
//
output		ADestBoostValid_v1e;
output		BDestBoostValid_v1e;
output		ADestPtr_v1e;
output		BDestPtr_v1e;

//
// Wire declarations
//
wire	[31:0]	AResDecoded_v1e, BResDecoded_v1e;
wire	    	AWBen_v1w, BWBen_v1w;
wire	[31:0]	sequential_s1e;
wire	    	ASeqPtr_v1e, BSeqPtr_v1e;
wire	[31:0]	BoostedValid_v1e;
wire	    	SlotExcept_v1w, BrExcept_v1w, Commit_v1e, SeqDefault_v1e;
wire	    	AfterBr_v1e;
wire		ABnValid_v1e;
wire		BBnValid_v1e;
wire		ValidDefault_v1e;

//
// Torch Register File
//
REGFILE REGFILE(
	.Phi1			(Phi1),
	.ASData_v2r		(ASData_v2r),
	.ATData_v2r		(ATData_v2r),
	.BSData_v2r		(BSData_v2r),
	.BTData_v2r		(BTData_v2r),
	.AResDecoded_v1e	(AResDecoded_v1e),
	.BResDecoded_v1e	(BResDecoded_v1e),
	.AWBData_s1w		(AWBData_s1w),
	.BWBData_s1w		(BWBData_s1w),
	.ASDSpec_w		(ASDSpec_w),
	.ATRSpec_w		(ATRSpec_w),
	.BSDSpec_w		(BSDSpec_w),
	.BTRSpec_w		(BTRSpec_w),
	.sequential_s1e		(sequential_s1e),
	.AWBen_v1w		(AWBen_v1w),
	.BWBen_v1w		(BWBen_v1w)
    ); 

regSeqLoop regSeqLoop(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.sequential_s1e		(sequential_s1e),
	.ASeqPtr_v1e		(ASeqPtr_v1e),
	.BSeqPtr_v1e		(BSeqPtr_v1e),
	.AResDecoded_v1e	(AResDecoded_v1e),
	.BResDecoded_v1e	(BResDecoded_v1e),
	.BoostedValid_v1e	(BoostedValid_v1e),
	.SlotExcept_v1w		(SlotExcept_v1w),
	.BrExcept_v1w		(BrExcept_v1w),
	.Commit_v1e		(Commit_v1e),
	.SeqDefault_v1e		(SeqDefault_v1e)
    );

regBoostedValidLoop regBoostedValidLoop(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.ADestBoostValid_v1e	(ADestBoostValid_v1e),
	.BDestBoostValid_v1e	(BDestBoostValid_v1e),
	.BoostedValid_v1e	(BoostedValid_v1e),
       	.AResDecoded_v1e	(AResDecoded_v1e),
	.BResDecoded_v1e	(BResDecoded_v1e),
       	.ABnValid_v1e		(ABnValid_v1e),
	.BBnValid_v1e		(BBnValid_v1e),
	.AfterBr_v1e		(AfterBr_v1e),
	.ValidDefault_v1e	(ValidDefault_v1e)
	);

regControl regControl(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
       	.Except_s1w		(Except_s1w),
	.Stall_s1		(Stall_s1),
      	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
       	.ASeqPtr_v1e		(ASeqPtr_v1e),
	.BSeqPtr_v1e		(BSeqPtr_v1e),
       	.ASDSpec_w		(ASDSpec_w[`VALID_BIT]),
	.BSDSpec_w		(BSDSpec_w[`VALID_BIT]),
       	.ATRSpec_w		(ATRSpec_w[`VALID_BIT:`BOOST_BIT]),
	.BTRSpec_w		(BTRSpec_w[`VALID_BIT:`BOOST_BIT]),
       	.AWBen_v1w		(AWBen_v1w),
	.BWBen_v1w		(BWBen_v1w),
       	.ADestPtr_v1e		(ADestPtr_v1e),
	.BDestPtr_v1e		(BDestPtr_v1e),
       	.ABnValid_v1e		(ABnValid_v1e),
	.BBnValid_v1e		(BBnValid_v1e),
       	.Commit_v1e		(Commit_v1e),
	.SeqDefault_v1e		(SeqDefault_v1e),
	.AfterBr_v1e		(AfterBr_v1e),
	.ValidDefault_v1e	(ValidDefault_v1e),
       	.SlotExcept_v1w		(SlotExcept_v1w),
	.BrExcept_v1w		(BrExcept_v1w)
    );

endmodule				  // register


//------------------------------------------------------------------------
//		      ---- Register Seq. Loop ----
//------------------------------------------------------------------------
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


//------------------------------------------------------------------------
//		       ---- Reg Boosted Loop ----
//------------------------------------------------------------------------
module regBoostedValidLoop(
    Phi1,
    Phi2, 
    ADestBoostValid_v1e,
    BDestBoostValid_v1e,
    BoostedValid_v1e,
    AResDecoded_v1e,
    BResDecoded_v1e,
    ABnValid_v1e,
    BBnValid_v1e,
    AfterBr_v1e,
    ValidDefault_v1e
    );

//
// Clocks
//
input		Phi1, Phi2;

//
// Inputs
//
input	[31:0]	AResDecoded_v1e;
input	[31:0]	BResDecoded_v1e;
input		ABnValid_v1e;
input		BBnValid_v1e;
input		AfterBr_v1e;
input		ValidDefault_v1e;

//
// Outputs
//
output		ADestBoostValid_v1e;
output		BDestBoostValid_v1e;
output	[31:0]	BoostedValid_v1e;

//
// Wire declarations
//
wire	[31:0]	boostvalid_s1e;
wire	[31:0]	nextboostvalid_v1e;
wire	[31:0]	nextboostvalid_s2e;
wire	[31:0]	ASetBoostValid_v1e;
wire	[31:0]	BSetBoostValid_v1e;

//
// Logic -- Result Update
//  One very Phi1 mark registers as boosted (if the dest reg is boosted).
AND2_32 ASETBV (ASetBoostValid_v1e, {32{ABnValid_v1e}}, AResDecoded_v1e);
AND2_32 BSETBV (BSetBoostValid_v1e, {32{BBnValid_v1e}}, BResDecoded_v1e);
OR3_32 UBOOSTEDVALID (BoostedValid_v1e, 
		ASetBoostValid_v1e, BSetBoostValid_v1e, boostvalid_s1e);

//
// Logic -- Result Read
//  Determine whether the dest register has been written as boosted yet.
BITLINE_32 ABVALIDPTR(ADestBoostValid_v1e,
			BoostedValid_v1e, AResDecoded_v1e);
BITLINE_32 BBVALIDPTR(BDestBoostValid_v1e,
			BoostedValid_v1e, BResDecoded_v1e);

//
// Valid Loop
//
PHI2_LATCH_32 BVALID_phi2 (boostvalid_s1e, nextboostvalid_s2e, Phi2);
MUX2_32 BVALID (nextboostvalid_v1e, 
		`ZERO, BoostedValid_v1e,
		AfterBr_v1e, ValidDefault_v1e);
PHI1_LATCH_32 BVALID_phi1 (nextboostvalid_s2e, nextboostvalid_v1e, Phi1);

endmodule				  // regBoostedValidLoop
