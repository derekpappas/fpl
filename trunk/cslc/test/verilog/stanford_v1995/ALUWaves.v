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
//  Title: 	ALU Waves File
//  Created:	Wed Apr 13 14:27:10 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  ALUWaves.v,v 7.4 1995/01/28 00:42:51 ricardog Exp
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

	$gr_addwaves(
	    "Lo_s1w", `AALU.Lo_s2w,
	    "Hi_s1w", `AALU.Hi_s2w
	);

	$define_group_waves(`ALU_WAVES_GROUP, "ALU",
	    "Phi1",
	    "Phi2",
	    "AInstr",
	    "BInstr", 
	    "ASBus",
	    "ATBus", 
	    "BSBus",
	    "BTBus",
	    "ARes",
	    "BRes",
	    "",
	    "Hi_s1w",
	    "Lo_s1w",
	);

