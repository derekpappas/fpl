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
//  Title: 	Waves for External Interface
//  Created:	Thu Mar 24 14:05:37 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  extIntWaves.v,v 7.5 1995/01/28 00:45:11 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: 
//
`include "torch.h"

	$gr_addwaves(
	    "main_s1",	`EIC.mainState_s1,
    	    "main_s2",	`EIC.mainState_s2,
	    "Reset",	`PROCESSOR.Reset_ww,
	    "nAddr",	`EIC.nextAddr_s1,
	    "nData",	`EIC.nextData_s1,
	    "DA",	`EIC.driveAddr_s1,
    	    "DH",	`EIC.dataHere_s2,
	    "rwSt",	`EIC.rwState_s1,
	    "busSt",	`EIC.busState_s1,
	    "ReqBus",	`EIC.ReqBus_s1,
	    "Tag",	`PROCESSOR.L2Tag_s2,
	    "Tags",	`EID.addrTags_s2,
	    "Ratio",	`EID.ratio_s2,
	    "SMAddr",	`PROCESSOR.SharedMemAddr_s1,
	    "R_len",	`PROCESSOR.ReqLength_s1,
	    "E_Req",	`PROCESSOR.ExtRequest_s1,
	    "l2_Miss",	`EIC.L2Miss_s2,
	    "ExtDV",	`PROCESSOR.ExtDataValid_s2,
	    "DrvPA",	`EIC.DrivePadAddr_s1,
	    "NonC",	`EIC.NonCacheable_s1,
	    "addr1",	`EID.addr1Tag_s1,
	    "addr2",	`EID.addr2Tag_s1,
	    "addr3",	`EID.addr3Tag_s1
	);

	$define_group_waves(`EID_WAVES_GROUP, "extInt",
	    "Phi1",
	    "Phi2",
	    "E_Req",
	    "SMAddr",
	    "NonC",
	    "rwSt",
	    "ExtDV",
	    "DrvPA"
	);

	$define_group_waves(`EIC_WAVES_GROUP, "extInt",
	    "Phi1",
	    "Phi2",
	    "main",
	    "busSt",
	    "nAddr",
	    "nData",
	    "R_len",
	    "r_len",
	    "Dleft",
	    "Aleft",
	    "l2_Miss",
	    "Tag",
	    "Tags",
	    "Ratio"
	);

