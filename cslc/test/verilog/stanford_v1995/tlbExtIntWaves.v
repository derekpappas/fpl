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
//  Title: 	Waves for TLB external interface
//  Created:	Thu Mar 24 15:02:41 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  tlbExtIntWaves.v,v 7.9 1995/01/28 00:41:23 ricardog Exp
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
	    "ItlbMiss",		`PROCESSOR.ItlbMiss_v2e,
	    "ReqLen",		`PROCESSOR.ReqLength_s1,
	    "ExtDataValid",	`PROCESSOR.ExtDataValid_s2,
	    "ExtRead",		`PROCESSOR.ExtRead_s1,
	    "ExtRequest",	`PROCESSOR.ExtRequest_s1,
	    "BytesLeft",	`TLBC.bytesleft_s1,
	    "State1",		`TLBC.tlbState_s1, 
	    "State2",		`TLBC.tlbState_s2,
	    "Hit",		`TLB.TLBHit_v2m,
	    "Refill",		`TLB.TLBRefill_v2m,
	    "L2Miss",		`PROCESSOR.L2Miss_s2,
	    "InstrAddr",	`TLB.instrAddr_s1e,
	    "Offset1",		`TLBD.PhysicalOffset_s1,
	    "TLBProbe",		`TLB.TLBProbe_s1m,
	    "TLBRead",		`TLB.TLBRead_s1m,
	    "TLBWriteI",	`TLB.TLBWriteI_s1m, 
	    "TLBWriteR",	`TLB.TLBWriteR_s1m,
	    "MvToCop",		`PROCESSOR.MvToCop0_s1m,
	    "MvFromCop",	`PROCESSOR.MvFromCop0_s1m,
	    "PhysAddr",		`PROCESSOR.PhysAddr_v2m,
	    "PCPID",		`PROCESSOR.PCPID_v2r, 
	    "NonCacheable",	`PROCESSOR.NonCacheable_v2m,
	    "Refill",		`TLB.TLBRefill_v2m,
	    "Invalid",		`TLB.TLBInvalid_v2m,
	    "Modified",		`TLB.TLBModified_v2m
	);



	$define_group_waves(`TLBE_WAVES_GROUP, "TLBextInt",
	"Phi1",
	"Phi2",
	"ICMiss_s1",
	"ItlbMiss",
	"ExtDataValid",
	"ExtRequest",
	"State1",
	"State2",
	"Hit",
	"SharedMemAddr",
	"Offset1",
	"NonCacheable",
	"BytesLeft",
	"Mips_s2e",
	"L2Miss",

);

