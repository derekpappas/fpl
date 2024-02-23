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
//  Title: 	Register Boosted Valid Loop
//  Created:	Mon Aug 22 15:33:16 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma.Stanford.EDU>
//
//
//  regBoostLoop.v,v 1.5 1995/01/28 00:50:49 ricardog Exp
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

module regBoostLoop(
    Phi1,
    Phi2, 
    ADestBoostValid_v1e,
    BDestBoostValid_v1e,
    BoostedValid_v1e,
    AResDecoded_v1e,
    BResDecoded_v1e,
    ABnValid_v1e,
    BBnValid_v1e,
    AfterBr_v1e
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
		AfterBr_v1e);
PHI1_LATCH_32 BVALID_phi1 (nextboostvalid_s2e, nextboostvalid_v1e, Phi1);

endmodule				  // regBoostLoop
