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
//  Title: 	Top-level system module
//  Created:	Fri Mar 25 16:04:24 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  system.v,v 7.7 1995/01/28 00:52:45 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//	This is the new top level module that defines the entire system. It
//	contains the processor, the L2 cache and the gate array that services
//	non-cacheable requests and magical locations.
//
//	Hierarchy: 
//
//  Revision History:
//	Modified:	Sat Apr  9 18:02:28 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//
`include "torch.h"

module system ();

wire		PadBusError_v2;
wire		PadClock;
wire		PadReset_ww;
wire	[5:0]	PadInterrupt_ww;
wire	[15:0]	PadL2Tag_v2;
wire		PadL2Valid_v2;
wire		PadReqICache_s1;
wire		PadReqDCache_s1;
wire		PadReqBus_s1;
wire		PadConfigIn;
wire	[5:0]	PadLength_s1;
wire		PadAddrValid_s1;
wire		PadWrite_s1;
wire		PadNonCacheable_s1;
wire		PadL1Hit_s1;
wire		PadGrant_s1;
wire		PadConfigOut;
wire	[31:0]	PadAddress_s1;
wire	[63:0]	PadData_w;

wire	[31:0]	Address_s1;
wire	[7:0]	enRead_s1;
wire	[7:0]	enWrite_s1;
wire	[63:0]	Data_s1;
wire		selMM_q1;
wire		reqMM_s1;

//
// Processor module
//
Torch Torch(
	.PadBusError_v2		(PadBusError_v2),
	.PadClock		(PadClock),
	.PadReset_ww		(PadReset_ww),
	.PadInterrupt_ww	(PadInterrupt_ww),
	.PadL2Tag_v2		(PadL2Tag_v2),
	.PadL2Valid_v2		(PadL2Valid_v2),
	.PadReqICache_s1	(PadReqICache_s1),
	.PadReqDCache_s1	(PadReqDCache_s1),
	.PadReqBus_s1		(PadReqBus_s1),
	.PadConfigIn		(PadConfigIn),
	.PadLength_s1		(PadLength_s1),
	.PadAddrValid_s1	(PadAddrValid_s1),
	.PadWrite_s1		(PadWrite_s1),
	.PadNonCacheable_s1	(PadNonCacheable_s1),
	.PadL1Hit_s1		(PadL1Hit_s1),
	.PadGrant_s1		(PadGrant_s1),
	.PadConfigOut		(PadConfigOut),
	.PadAddress_s1		(PadAddress_s1),
	.PadData_w		(PadData_w)
    );

//
// Level-two cache (empty)
//
L2Cache L2Cache(
	.PadClock		(PadClock),
	.PadAddress_s1		(PadAddress_s1),
	.PadAddrValid_s1	(PadAddrValid_s1),
	.PadWrite_s1		(PadWrite_s1),
	.PadNonCacheable_s1	(PadNonCacheable_s1),
	.PadData_w		(PadData_w),
	.PadL2Tag_v2		(PadL2Tag_v2),
	.PadL2Valid_v2		(PadL2Valid_v2),
	.Address_s1		(Address_s1),
	.enRead_s1		(enRead_s1),
	.enWrite_s1		(enWrite_s1),
	.Data_s1		(Data_s1),
	.selMM_q1		(selMM_q1),
	.reqMM_s1		(reqMM_s1)
    );

//
// Main memory
//
memory memory(
	.PadClock		(PadClock),
	.Address_s1		(Address_s1),
	.Data_s1		(Data_s1),
	.enRead_s1		(enRead_s1),
	.enWrite_s1		(enWrite_s1),
	.selMM_q1		(selMM_q1)
    );

//
// Module to handle special requests (io, interrupts, syscalls, etc)
//
gateArray gateArray(
	.PadAddress_s1		(PadAddress_s1),
	.PadLength_s1		(PadLength_s1),
	.PadAddrValid_s1	(PadAddrValid_s1),
	.PadWrite_s1		(PadWrite_s1),
	.PadNonCacheable_s1	(PadNonCacheable_s1),
	.PadGrant_s1		(PadGrant_s1),
	.PadData_w		(PadData_w),
	.PadL2Tag_v2		(PadL2Tag_v2),
	.PadL2Valid_v2		(PadL2Valid_v2),
	.PadBusError_v2		(PadBusError_v2),
	.PadReqICache_s1	(PadReqICache_s1),
	.PadReqDCache_s1	(PadReqDCache_s1),
	.PadReqBus_s1		(PadReqBus_s1),
	.PadClock		(PadClock),
	.PadReset_ww		(PadReset_ww),
	.PadInterrupt_ww	(PadInterrupt_ww),
	.Address_s1		(Address_s1),
	.enRead_s1		(enRead_s1),
	.enWrite_s1		(enWrite_s1),
	.Data_s1		(Data_s1),
	.reqMM_s1		(reqMM_s1)
    );


endmodule				  // system
