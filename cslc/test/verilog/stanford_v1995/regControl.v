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
//  Title: 	Register Control
//  Created:	Sun May 23 16:36:34 1993
//  Author: 	Ricardo Gonzalez
//		<ricardog@bill>
//
//
//  regControl.v,v 7.10 1995/01/28 00:50:52 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: Control section for the register file. Generates some
//  	    control signals needed by the register file. It deal mainly
//  	    with boosting and eception type stuff.
//
//	Hierarchy: 
//
//  Revision History:
//	Modified:	Sun May 22 16:48:12 1994	<ricardog@chroma>
//	* Changed IStall_s1 to Stall_s1.
//	Modified:	Sat Apr  9 17:40:29 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Tue Mar 29 19:13:37 1994	<ricardog@chroma>
//	* Added comments, moved macros.
//
`include "torch.h"

module regControl(
    Phi1,
    Phi2,
    Except_s1w,
    Stall_s1,
    Commit_s1e,
    Squash_s1e,
    ASeqPtr_v1e,
    BSeqPtr_v1e,
    ASDSpec_w,
    BSDSpec_w,
    ATRSpec_w,
    BTRSpec_w,
    AWBen_v1w,
    BWBen_v1w,
    ADestPtr_v1e,
    BDestPtr_v1e,
    ABnValid_v1e,
    BBnValid_v1e,
    Commit_v1e,
    SeqDefault_v1e,
    AfterBr_v1e,
    SlotExcept_v1w,
    BrExcept_v1w
    );


//
// Clocks & Stalls
//
input		Phi1;
input		Phi2;

input	    	Except_s1w, Stall_s1;

//
// Inputs
//
input	    	Commit_s1e, Squash_s1e;
input 		ASeqPtr_v1e, BSeqPtr_v1e;
input	[`VALID_BIT:`VALID_BIT] ASDSpec_w, BSDSpec_w;
input	[`VALID_BIT:`BOOST_BIT] ATRSpec_w, BTRSpec_w;

//
// Outputs
//
output		AWBen_v1w;		  // Write enable for register file
output		BWBen_v1w;
output	    	ADestPtr_v1e;		  // Destination pointer for WB
output		BDestPtr_v1e;
output		ABnValid_v1e;		  // Write back is valid & boosted
output		BBnValid_v1e;
output	    	Commit_v1e;		  // Qualified commit signal
output		SeqDefault_v1e;		  // 
output		AfterBr_v1e;		  // Just did a branch
output	    	SlotExcept_v1w;		  // Exception in branch slot
output		BrExcept_v1w;		  // Exception on a branch

//
// Register Declarations
//
reg 	[1:0]	PrevCommit_s1e;
reg 	[1:0]	PrevCommit_s2e;


//
// Write Pulse Generation AWDelayPulse_v1w, BWDelayPulse_v1w;
//
assign AWBen_v1w = Phi1 & ASDSpec_w[`VALID_BIT] & (~Except_s1w);
assign BWBen_v1w = Phi1 & BSDSpec_w[`VALID_BIT] & (~Except_s1w);

//------------------------------------------------------------------------
// Logic -- Boosted valid logic
//------------------------------------------------------------------------
assign ABnValid_v1e = ATRSpec_w[`VALID_BIT] & ATRSpec_w[`BOOST_BIT];
assign BBnValid_v1e = BTRSpec_w[`VALID_BIT] & BTRSpec_w[`BOOST_BIT];

//------------------------------------------------------------------------
//		       ---- Sequential Logic ----
//------------------------------------------------------------------------
// Note: Want to generate a mux here
assign ADestPtr_v1e = 
		(ATRSpec_w[`BOOST_BIT]) ? (~ASeqPtr_v1e) : ASeqPtr_v1e;
assign BDestPtr_v1e = 
		(BTRSpec_w[`BOOST_BIT]) ? (~BSeqPtr_v1e) : BSeqPtr_v1e;

//------------------------------------------------------------------------
// Commit/Squash Logic -- Commit/pong sequential register pointer
//------------------------------------------------------------------------
assign Commit_v1e = Phi1 & ~Except_s1w & ~Stall_s1 & Commit_s1e;
// Default case for non-branch instructions and regular exception cases
assign SeqDefault_v1e = ~Commit_v1e & ~BrExcept_v1w & ~SlotExcept_v1w;

//------------------------------------------------------------------------
//		      ---- Boosted Valid Bit ----
//------------------------------------------------------------------------

//
// After the Branch - need to reset the boosted valid structure;
//
assign AfterBr_v1e = ((Commit_s1e | Squash_s1e) & ~Stall_s1) | Except_s1w;

//------------------------------------------------------------------------
//		      ---- Exception Handling ----
//------------------------------------------------------------------------

//
// Exception Recovery - slot exception and back to back branch exception
//
assign SlotExcept_v1w = Phi1 & Except_s1w & PrevCommit_s1e[1];

//
// Exception Recovery - branch exception
//
assign BrExcept_v1w = Phi1 & Except_s1w & PrevCommit_s1e[0] 
		& ~PrevCommit_s1e[1];

//
// Exception Signal Chain -- Save Commit signal into PrevCommit every cycle
//
always @(Phi1 or Commit_s1e or PrevCommit_s1e) begin
    if (Phi1) `TICK PrevCommit_s2e = {PrevCommit_s1e[0], Commit_s1e};
end

always @(Phi2 or PrevCommit_s2e) begin
    if (Phi2) `TICK PrevCommit_s1e = PrevCommit_s2e;
end
endmodule
