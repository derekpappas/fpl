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
//  Title: 	Explicit Pads Module
//  Created:	Thu Mar 24 16:48:21 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  pads.v,v 7.5 1995/06/10 02:03:39 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: 
//
//  Revision History:
//	Modified:	Sat Apr  9 18:22:08 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Sat Mar 26 15:38:41 1994	<ricardog@chroma>
//	* Added TICK to all latches.
//
`include "torch.h"

module pads(
//
    Phi1,
    Phi2,
    ReqLength_s1,
    ExternRead_s1,
    NonCacheableOp_s1,
    Grant_s1,
    L1Hit_s1,
    ConfigOut,
    DrivePadAddr_s1,
    DrivePadData_s2,
    DriveSharedMemAddr_s1,
    DriveSharedMemData_s2,
// 
    Interrupt_w,
    ReqNextBlock_s2,
    Clock,
    ReqICache_s1,
    ReqDCache_s1,
    ReqBus_s1,
    BusError_s2,
    L2Valid_s2,
    Reset_ww,
    ConfigIn,
    L2Tag_s2,
//
    SharedMemAddr_s1,
    SharedMemData_s2,
//
    PadBusError_v2,
    PadClock,
    PadReset_ww,
    PadInterrupt_ww,
    PadL2Tag_v2,
    PadL2Valid_v2,
    PadReqICache_s1,
    PadReqDCache_s1,
    PadReqBus_s1,
    PadConfigIn,
//
    PadLength_s1,
    PadAddrValid_s1,
    PadWrite_s1,
    PadNonCacheable_s1,
    PadL1Hit_s1,
    PadGrant_s1,
    PadConfigOut,
//
    PadAddress_s1,
    PadData_w
    );


// External world side

output 	[31:0]	PadAddress_s1;		// Byte address
output 	[5:0]	PadLength_s1;		// # of bytes to transfer
output 		PadAddrValid_s1;	// Initiate bus transaction(s)
output		PadWrite_s1;		// Write if 1, otherwise read
output		PadNonCacheable_s1;	// This request is non-cacheable
inout	[63:0]	PadData_w;		// Read/Write data
input		PadBusError_v2;		// Outstanding cycle failed
input		PadClock;		// System clock
input		PadReset_ww;		// Reset pin
input	[5:0]	PadInterrupt_ww;	// Interrupt enables
input	[15:0]	PadL2Tag_v2;		// Secondary cache tag
input		PadL2Valid_v2;		// Secondary cache valid bit
output		PadL1Hit_s1;		// Primary cache hit signal
input		PadReqICache_s1;	// Outside request to diddle ICache
input		PadReqDCache_s1;	// Outside request to diddle DCache
input		PadReqBus_s1;		// Outside request to grab bus
output		PadGrant_s1;		// Bus grant
input		PadConfigIn;		// For configuring the bus cycles
output		PadConfigOut;

// Chip side

inout 	[31:0]	SharedMemAddr_s1;
inout	[63:0]	SharedMemData_s2;
input		ExternRead_s1;		// 1 => op is load, 0 => op is write
input		DrivePadAddr_s1;	// 1 => SharedMemAddr_s1 has valid addr
					// and an external request should start
input	[5:0]	ReqLength_s1;		// Number of bytes in transaction
input		NonCacheableOp_s1;
input		L1Hit_s1;
input		Phi1;
input		Phi2;
input		DriveSharedMemAddr_s1;
input		DrivePadData_s2;
input		DriveSharedMemData_s2;
output		ReqNextBlock_s2;	// Send next block of data on
					//  SharedMemData_s2 on the next cycle
output	[15:0]	L2Tag_s2;
output		L2Valid_s2;
output 		BusError_s2;
output		ReqICache_s1;
output		ReqDCache_s1;
output		ReqBus_s1;
output		ConfigIn;
input		ConfigOut;
output		Clock;
output		Reset_ww;
output	[5:0]	Interrupt_w;
input		Grant_s1;

reg	[31:0]	padAddress_s1;
reg	[5:0]	padLength_s1;
reg		padAddrValid_s1, padWrite_s1, padNonCacheable_s1;

wire	[31:0]	PadAddress_s1;
wire	[5:0]	PadLength_s1;
wire		PadAddrValid_s1, PadWrite_s1, PadNonCacheable_s1;
wire	[5:0]	Interrupt_w;

reg		PadGrant_s1, grant_s2;
wire	[63:0]	PadData_w;
reg	[15:0]	L2Tag_s2;
reg		L2Valid_s2;
reg		BusError_s2;
reg		busError_s1;
reg		ReqICache_s1, reqICache_s2;
reg		ReqDCache_s1, reqDCache_s2;
reg		ReqBus_s1, reqBus_s2;
wire	[31:0]	SharedMemAddr_s1;
wire	[63:0]	SharedMemData_s2;
wire	[31:0]	padAddress_s2;
wire	[5:0]	padLength_s2;
wire		padNonCacheable_s2, padWrite_s2;
reg 	[31:0]	sharedMemAddr_s2;
reg	[5:0]	reqLength_s2;
reg		nonCacheable_s2, extRead_s2;
reg		drivePadAddr_s2;
wire		DrivePadData_s2;
reg	[63:0]	padDataOut_s1, padDataOut_s2;
reg	[63:0]	data_s2, padData_s1;
reg	[15:0]	l2Tag_s1;
reg		l2Valid_s1;


//---------------------------------------------------------------------------
//			     ---- TBI ----
//---------------------------------------------------------------------------
assign ReqNextBlock_s2 = 1'b0;
assign SharedMemAddr_s1 = (DriveSharedMemAddr_s1) ? 32'd0 : 32'bz;
assign PadL1Hit_s1 = L1Hit_s1;

//
// Pass Pad signals straight through to external interface 
//
assign Clock		= PadClock;
assign Reset_ww		= PadReset_ww;
assign Interrupt_w	= PadInterrupt_ww;
assign ConfigIn		= PadConfigIn;
assign PadConfigOut	= ConfigOut;

//
// Isolation of internal buses (driven early) and pad latches -- may need
// AND gates instead of tri-state drivers
//
assign padAddress_s2	    = {32{drivePadAddr_s2}} & sharedMemAddr_s2 ;
assign padLength_s2	    = {6{drivePadAddr_s2}} & reqLength_s2 ;
assign padNonCacheable_s2   = drivePadAddr_s2 & nonCacheable_s2 ;
assign padWrite_s2	    = drivePadAddr_s2 & ~extRead_s2 ;

//
// Drivers for getting data off the SMD Bus to the Pads and off chip.
//
assign PadData_w	     = DrivePadData_s2 ? padDataOut_s2 : 64'bz;

//
// Tri-state driver for putting incoming data on SharedMemData_s2 bus
//
assign SharedMemData_s2   = DriveSharedMemData_s2 ? data_s2  : 64'bz;

//
// Phi1 latches to set up address, length, r/w before tri-state driver 
//
always @(Phi1 or SharedMemAddr_s1 or ReqLength_s1 or NonCacheableOp_s1
	or ExternRead_s1 or DrivePadAddr_s1
	or padDataOut_s1) begin
    if (Phi1) begin
	`TICK
	sharedMemAddr_s2 = SharedMemAddr_s1;
	reqLength_s2     = ReqLength_s1;
	nonCacheable_s2  = NonCacheableOp_s1;
	extRead_s2       = ExternRead_s1;
	drivePadAddr_s2  = DrivePadAddr_s1;
	padDataOut_s2    = padDataOut_s1;
    end
end

//
// Phi2 latches to provide outgoing _s1 signals on pads
//
always @(Phi2 or drivePadAddr_s2 or padAddress_s2 or padLength_s2 or
	padNonCacheable_s2 or padWrite_s2
	or SharedMemData_s2 ) begin
    if (Phi2) begin
	`TICK
	padAddrValid_s1	= drivePadAddr_s2;
	padAddress_s1	= padAddress_s2;
	padLength_s1	= padLength_s2;
	padNonCacheable_s1	= padNonCacheable_s2;
	padWrite_s1		= padWrite_s2;

	// does the following need to be gated? 
	padDataOut_s1       = SharedMemData_s2;
    end
end

//
// Pad signals
//
assign PadAddrValid_s1		= padAddrValid_s1;
assign PadAddress_s1		= padAddrValid_s1 ? padAddress_s1 : 32'bz;
assign PadLength_s1		= padAddrValid_s1 ? padLength_s1  : 6'bz;
assign PadNonCacheable_s1	= padAddrValid_s1 ? padNonCacheable_s1 : 1'bz;
assign PadWrite_s1		= padAddrValid_s1 ? padWrite_s1 : 1'bz;


//
// Incoming Signals 
//
always @(Phi1 or padData_s1 or PadReqICache_s1 or PadReqDCache_s1
	or PadReqBus_s1 or Grant_s1 or l2Tag_s1 or l2Valid_s1
	or busError_s1 ) begin
    if (Phi1) begin
	`TICK
	data_s2 = padData_s1;
	reqICache_s2 = PadReqICache_s1;
	reqDCache_s2 = PadReqDCache_s1;
	reqBus_s2 = PadReqBus_s1;
	grant_s2 = Grant_s1;
	L2Tag_s2 = l2Tag_s1;
	L2Valid_s2 = l2Valid_s1;
	BusError_s2 = busError_s1;
    end
end

always @(Phi2 or PadData_w or PadL2Tag_v2 or PadL2Valid_v2
	or PadBusError_v2 or reqICache_s2 or reqDCache_s2
	or reqBus_s2 or grant_s2 ) begin
    if (Phi2) begin
	`TICK
	padData_s1 = PadData_w;
	l2Tag_s1 = PadL2Tag_v2;
	l2Valid_s1 = PadL2Valid_v2;
	busError_s1 = PadBusError_v2;
	ReqICache_s1 = reqICache_s2;
	ReqDCache_s1 = reqDCache_s2;
	ReqBus_s1 = reqBus_s2;
	PadGrant_s1 = grant_s2;
    end
end


endmodule				  // pads
