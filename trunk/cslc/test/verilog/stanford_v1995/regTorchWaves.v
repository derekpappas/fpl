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
//  Title: 	Register File Waves II
//  Created:	Wed Apr 13 14:37:56 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  regTorchWaves.v,v 7.8 1995/01/28 00:51:04 ricardog Exp
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

// Specifier
	$gr_addwaves(
	    "ASDSp",	`REG_FILE.ASDSpec_w,
	    "ATRSp",	`REG_FILE.ATRSpec_w,
	    "BSDSp",	`REG_FILE.BSDSpec_w,
	    "BTRSp",	`REG_FILE.BTRSpec_w,
// Read Data
	    "ASData",	`REG_FILE.ASData_v2r,
	    "ATData",	`REG_FILE.ATData_v2r,
	    "BSData",	`REG_FILE.BSData_v2r,
	    "BTData",	`REG_FILE.BTData_v2r,
// Write Data
	    "AWBDat",	`REG_FILE.AWBData_s1w,
	    "BWBDat",	`REG_FILE.BWBData_s1w,
// WB and Result update input
	    "ADVlid",	`REG_FILE.ASDSpec_w[6],
	    "ARVlid",	`REG_FILE.ATRSpec_w[6],
	    "ARBost",	`REG_FILE.ATRSpec_w[5],
	    "BDVlid",	`REG_FILE.BSDSpec_w[6],
	    "BRValid",	`REG_FILE.BTRSpec_w[6],
	    "BRBost",	`REG_FILE.BTRSpec_w[5],
// Status
	    "ADstBV",	`REG_FILE.ADestBoostValid_v1e,
	    "ASqPtr",	`REG_FILE.ASeqPtr_v1e,
	    "BDstBV",	`REG_FILE.BDestBoostValid_v1e,
	    "BSqPtr",	`REG_FILE.BSeqPtr_v1e,
// Commands
	    "AWBen",	`REG_FILE.AWBen_v1w,
	    "BWBen",	`REG_FILE.AWBen_v1w,
// Address decoder output
	    "AResDc",	`REG_FILE.AResDecoded_v1e,
	    "BResDc",	`REG_FILE.BResDecoded_v1e,
// Shadow Structure
	    "valid",	`REG_FILE.regBoostLoop.boostvalid_s1e,
	    "nextv",	`REG_FILE.regBoostLoop.nextboostvalid_s2e,
	    "BVMUX",	`REG_FILE.regBoostLoop.nextboostvalid_v1e,
	    "update",	`REG_FILE.regBoostLoop.BoostedValid_v1e,
	    "PrvCm1",	`REG_FILE.regControl.PrevCommit_s1e,
	    "PrvCm2",	`REG_FILE.regControl.PrevCommit_s2e,
	    "SlotEx",	`REG_FILE.SlotExcept_v1w, 
	    "BrEx",	`REG_FILE.BrExcept_v1w, 
	    "AfterBr",	`REG_FILE.AfterBr_v1e, 
	    "seque",	`REG_FILE.regSeqLoop.sequential_s1e,
	    "nextsq",	`REG_FILE.regSeqLoop.nextsequential_s2e,
	    "SEQMUX",	`REG_FILE.regSeqLoop.nextsequential_v1e,
	    "pong",	`REG_FILE.regSeqLoop.pong_v1e,
	    "SlotEx",	`REG_FILE.SlotExcept_v1w, 
	    "BrEx",	`REG_FILE.BrExcept_v1w, 
	    "Comm",	`REG_FILE.Commit_v1e, 
	    "SeqDef",	`REG_FILE.SeqDefault_v1e
	);

    $define_group_waves(`REG_WAVES_GROUP, "TorReg",
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
	    "Membus",
	    "PCBus",
	    "ASDSp",
	    "ATRSp",
	    "BSDSp",
	    "BTRSp",
	    "ASData",
	    "ATData",
	    "BSData",
	    "BTData",
	    "AWBDat",
	    "BWBDat",
	    "ADVlid",
	    "ARVlid", 
	    "ARBost", 
	    "BDVlid", 
	    "BRVlid", 
	    "BRBost", 
	    "ABooV", 
	    "ADstBV",
	    "ASqPtr", 
	    "BBooV", 
	    "BDstBV",
	    "BSqPtr", 
	    "AWBen", 
	    "BWBen",
	    "AResDc",
	    "BResDc",
	    "valid", 
	    "nextv",
	    "updatev",
	    "PrvCm1",
	    "PrvCm2",
	    "SlotEx",
	    "BrEx",
	    "AfterBr",
	    "BVMUX", 
	    "seque",
	    "nextsq",
	    "pong",
	    "SlotEx",
	    "BrEx",
	    "Comm",
	    "SeqDef",
	    "SEQMUX"
	);

