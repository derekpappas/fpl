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
//  Title: 	Waves file for co-processor0
//  Created:	Thu Mar 24 13:58:52 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  exceptionWaves.v,v 7.11 1995/01/28 00:41:07 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: 
//
//
`include "torch.h"

	$gr_addwaves(
	    "EPCSel",		`COP0.EPCSel_s1m,
	    "EPCNSel",		`COP0.EPCNSel_s1m,
	    "BrSlt",		`CP0_C.BrDelaySlot_s1w,
	    "BExNoted_v2",	`CP0_C.BExNoted_v2,
	    "SetBEP_s1w",	`CP0_C.SetBEP_s1w,
	    "SEx_s1w",		`CP0_C.SEx_s1w,
	    "BExTaken_s1w",	`CP0_C.BExTaken_s1w,
	    "PushStatus_s1w",	`CP0_C.PushStatus_s1w,
	    "PopStatus_s1w",	`CP0_C.PopStatus_s1w,
	    "Except",		`CP0_C.Except_s1w,
	    "ExcVect",		`CP0_C.ExceptVector_s1i,
	    "Reset",		`CP0_INTENC.Reset_s1,
	    "ExcCause",		`CP0_INTENC.ExceptionCause_s1w,
	    "CauseSel",		`COP0.CauseSel_s2m,
	    "TLBExcFetch_v2",	`CP0_INTENC.TLBL1_v2,
	    "TLBExcLoad_v2",	`CP0_INTENC.TLBL2_v2,
	    "TLBExcStore_v2",	`CP0_INTENC.TLBS_v2,
	    "AddErrLd_v2",	`CP0_INTENC.AdEL_v2,
	    "AddErrStore_v2",	`CP0_INTENC.AdES_v2,
	    "ExExc",		`CP0_INTENC.ExtExcept_s2,
	    "BoExc",		`CP0_INTENC.BoostedExcept_v2,
	    "SeExc",		`CP0_INTENC.SeqExcept_v2
	 );

	$define_group_waves(`EXCEPT_WAVES_GROUP, "Exception",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "AInstr",
	    "BInstr",
	    "ExExc",
	    "SeExc",
	    "BoExc",
	    "Except",
	    "ExcVect",
	    "Reset",
	    "CauseSel",
	    "ExcCause",
	    "Context",
	    "BadVAddr",
	    "EPC_s2",
	    "EPCN_s2",
	    "IStall_s1",
	    "MemStall_s2",
	    "Membus"
	);

	$define_group_waves(`INT_WAVES_GROUP, "ExcSigs",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "AIns_s2r",
	    "BIns_s2r",
	    "Except",
	    "ExcCause",
	    "TLBExcFetch_v2",
	    "TLBExcLoad_v2",
	    "TLBExcStore_v2", 
	    "AddErrLd_v2",
	    "AddErrStore_v2",
	    "ExtExc_v2",
	    "",
	    "IStall_s1",
	    "MemStall_s2",
	    "Membus"
	);


