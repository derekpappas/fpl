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
//  Title: 	Waves for modules outside the processor
//  Created:	Thu Mar 24 14:13:24 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  extWorldWaves.v,v 7.4 1995/01/28 00:45:14 ricardog Exp
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
	    "PadClock",	`SYSTEM.PadClock,
	    "Clock",	`L2C.Clock,
	    "Addr0",	`L2C.addr_s1[0],
	    "Addr1",	`L2C.addr_s1[1],
	    "Addr2",	`L2C.addr_s1[2],
	    "Addr3",	`L2C.addr_s1[3],
	    "data0",	`L2C.data_s1[0],
	    "data1",	`L2C.data_s1[1],
	    "data2",	`L2C.data_s1[2],
	    "data3",	`L2C.data_s1[3],
	    "dValid0",	`L2C.dataValid_s1[0],
	    "dValid1",	`L2C.dataValid_s1[1],
	    "dValid2",	`L2C.dataValid_s1[2],
	    "dValid3",	`L2C.dataValid_s1[3],
	    "write_s1",	`L2C.write_s1,

	    "LnS2a",	`GA.length_s2a,
	    "LnS1b",	`GA.length_s1b,
	    "VS2a",	`GA.valid_s2a,
	    "VS1b",	`GA.valid_s1b,
	    "VS2b",	`GA.valid_s2b,
	    "WS2a",	`GA.write_s2a,
	    "WS1b",	`GA.write_s1b,
	    "WS2b",	`GA.write_s2b,
	    "reqMM",	`GA.reqMM_s1,
	    "reqBus",	`GA.reqBus_s1,

	    "Int_ww",	`GA.Interrupt_ww,

	    "MAddr",	`SYSTEM.Address_s1,
	    "Data",	`SYSTEM.Data_s1,
	    "enRead",	`SYSTEM.enRead_s1,
	    "enWrite",	`SYSTEM.enWrite_s1,
	    "selMM",	`SYSTEM.selMM_q1,
	    "NonCv2",	`TLB.NonCacheable_v2m,
	    "NonCs1",	`TLB.NonCacheable_s1,
	    "NonCs2",	`TLB.tlbControl.NonCacheable_s2
	);

	$define_group_waves(`EW_WAVES_GROUP, "extWorld",
	    "PadClock",
	    "Clock",
	    "Addr0",
	    "Addr1",
	    "Addr2",
	    "Addr3",
	    "data0",
	    "data1",
	    "data2",
	    "data3",
	    "dValid0",
	    "dValid1",
	    "dValid2",
	    "dValid3",
	    "MAddr",
	    "Data",
	    "enRead",
	    "enWrite",
	    "selMM",
	    "write_s1"
	);

	$define_group_waves(`GA_WAVES_GROUP, "GA",
	    "LnS2a",
	    "LnS1b",
	    "VS2a",
	    "VS1b",
	    "VS2b",
	    "WS2a",
	    "WS1b",
	    "WS2b",
	    "Int_ww",
	    "reqMM",
	    "reqBus"
	);

