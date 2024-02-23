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
//  Title: 	Waves file for TLB
//  Created:	Thu Mar 24 14:00:50 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  tlbWaves.v,v 7.6 1995/01/28 00:41:25 ricardog Exp
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
	    "MemAddr",		`TLB.MemAddr_s1m,
	    "tlbAddr",		`TLBD.tlbAddr_s2m,
	    "Cp0Bus",		`TLB.Cp0Bus_s2m,
	    "InstrAddr",	`TLB.InstrAddr_s2i,
	    "ICacheMiss",	`TLB.ICacheMiss_v2r,
	    "PFN_v2m",		`TLBD.pfn_v2m,
	    "Status_v2m",	`TLB.statusBits_v2m,
	    "EntryLo_s1w",	`TLBD.EntryLo_s1w,
	    "TLBProbe",		`TLB.TLBProbe_s1m,
	    "TLBWriteI",	`TLB.TLBWriteI_s1m,
	    "TLBWriteR",	`TLB.TLBWriteR_s1m,
	    "PCPID",		`TLB.PCPID_v2r, 
	    "PhysAddr",		`TLB.PhysAddr_v2m,
	    "Shared",		`TLB.SharedMemAddr_s1,
	    "NonCacheable",	`TLB.NonCacheable_v2m,
	    "Refill",		`TLB.TLBRefill_v2m,
	    "Invalid",		`TLB.TLBInvalid_v2m,
	    "Modified",		`TLB.TLBModified_v2m,
	    "tlbData",		`TLBD.tlbData_v2m,
	    "tlbDrive",		`TLB.tlbDrive_v2m
	);

	$define_group_waves(`TLB_WAVES_GROUP, "TLB",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "AIns_s2r",
	    "BIns_s2r",
	    "Except",
	    "MemAddr",
	    "InstrAddr",
	    "MvToCop",
	    "PhysAddr",
	    "Refill",
	    "Invalid",
	    "Modified",
	    "Membus"
	);

