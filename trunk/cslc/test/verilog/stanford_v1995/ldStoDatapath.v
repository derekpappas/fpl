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
//  Title: 	Load Store Unit Datapath
//  Created:	Fri May 13 15:24:49 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  ldStoDatapath.v,v 1.24 1995/06/09 05:50:18 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: Logic for load Store Unit that sits on the main 
//		     integer datapath.
//
//	Hierarchy: 
//
//  Revision History:
//	Modified: Thu Dec  1 21:56:58 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//
`include "torch.h"

module ldStoDatapath (
    Phi1,
    Phi2,
    Stall_s1,
    Stall_s2,
    selFastStore_s1m,
    drvMemBusCD_q2m,
    drvMemBusSMD_q2m,
    drvNonCache_q2m,
    BResultBus_v2e,
    BTBus_s1e,
    cacheData_v2m,
    storeBufData_s1w,
    storeData_s2m,
    storeData_s1,
    MemBus_v2m,
    BResultBus_s1m,
    SharedMemData_s2
    );

//
// Clocks & Stalls
//
input		Phi1;
input		Phi2;
input		Stall_s1;
input		Stall_s2;

//
// Control inputs
//
input		selFastStore_s1m;	  // Use un-buffered addr and data
input		drvMemBusCD_q2m;	  // drv memBus w/ data from cache
input		drvMemBusSMD_q2m;	  // drv MemBus w/ non-$-able data
input		drvNonCache_q2m;	  // drv store data from non-$-able

//
// Bus inputs
//
input	[31:0]	BResultBus_v2e;		  // Store address
input	[31:0]	BTBus_s1e;		  // Store data
input	[31:0]	cacheData_v2m;		  // Data from cache after sign ext
input	[31:0]	storeBufData_s1w;	  // Store data from store buffer
inout	[31:0]	SharedMemData_s2;

//
// Bus outputs
//
output	[31:0]	storeData_s2m;		  // Store data to store buffer
output	[31:0]	storeData_s1;		  // Store data to dCache
output	[31:0]	MemBus_v2m;		  // Rerturn load data to datapath
output	[31:0]	BResultBus_s1m;		  // Store Address for conflict comp

//
// Local Wires
//
wire	[31:0]	storeData_s2e;		  // pipeline store data until s1w
wire	[31:0]	storeData_s1m;		  // when the store goes into the 
wire	[31:0]	storeData_s2m;		  // store buffer.

//---------------------------------------------------------------------------
//			 --- Store Address ---
//---------------------------------------------------------------------------
PHI2_LATCH_EN_32 StoreAddr_S1M(BResultBus_s1m, BResultBus_v2e,
			Phi2, ~Stall_s2);

//---------------------------------------------------------------------------
//			   --- Store Data ---
//---------------------------------------------------------------------------
PHI1_LATCH_EN_32 StoreData_S2E(storeData_s2e, BTBus_s1e, Phi1, ~Stall_s1);
PHI2_LATCH_EN_32 StoreData_S1M(storeData_s1m, storeData_s2e, Phi2, ~Stall_s2);
PHI1_LATCH_EN_32 StoreData_S2M(storeData_s2m, storeData_s1m, Phi1, ~Stall_s1);

//---------------------------------------------------------------------------
//			  --- Store Buffer ---
//---------------------------------------------------------------------------
MUX2_32		storeData_S1(storeData_s1,
			storeData_s1m,
			storeBufData_s1w,
			selFastStore_s1m);

//---------------------------------------------------------------------------
//			     --- MemBus ---
//---------------------------------------------------------------------------
TRIBUF_32	MemBus1(MemBus_v2m, cacheData_v2m, drvMemBusCD_q2m);

//---------------------------------------------------------------------------
//			 --- Non Cacheable ---
//---------------------------------------------------------------------------
TRIBUF_32	SharedMemData(SharedMemData_s2[31:0], storeData_s2m,
			drvNonCache_q2m);
TRIBUF_32	MemBus2(MemBus_v2m, SharedMemData_s2, drvMemBusSMD_q2m);

//---------------------------------------------------------------------------
//			   --- I/O Writes ---
//---------------------------------------------------------------------------
// synopsys translate_off
// vcheck_off
wire		InstrIsLoad_s1m = loadStore.InstrIsLoad_s1m;
reg		InstrIsLoad_s2m;
wire		InstrIsStore_s1m = loadStore.InstrIsStore_s1m;
reg		InstrIsStore_s2m;
reg		ioReadWrite_s1m;
reg		ioReadWrite_s2m;

wire		Except_s1w = loadStore.Except_s1w;
wire		ioWrite_s1m;
wire		ioRead_s1m;
wire		ioEnable_s1m;
wire		ioEnable_q1m;

reg	[31:0]	loadData_s2m;
reg	[31:0]	ioData_s1;

always @(Phi2 or BResultBus_v2e)  begin
    if (Phi2) begin
	`TICK
	ioReadWrite_s1m = BResultBus_v2e[31:0] === `COM_ADDR;
    end
end

assign ioWrite_s1m = InstrIsStore_s1m;
assign ioRead_s1m = InstrIsLoad_s1m;
assign ioEnable_s1m = ioReadWrite_s1m & (InstrIsStore_s1m | InstrIsLoad_s1m);
assign ioEnable_q1m = ioEnable_s1m & ~Except_s1w & ~Stall_s1 & Phi1;

always @(InstrIsStore_s1m or ioReadWrite_s1m or storeData_s1m) begin
    if (InstrIsStore_s1m & ioReadWrite_s1m) begin
	`TICK
	ioData_s1 = storeData_s1m;
    end
end

always @(Phi1 or Stall_s1 or ioData_s1) begin
    if (Phi1 & ~Stall_s1) `TICK loadData_s2m = ioData_s1;
end

always @(Phi1 or Stall_s1 or InstrIsLoad_s1m or ioReadWrite_s1m) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	ioReadWrite_s2m = ioReadWrite_s1m;
	InstrIsLoad_s2m = InstrIsLoad_s1m;
    end
end

initial begin
    $io_handler("io", ioData_s1, {4{ioRead_s1m}}, {4{ioWrite_s1m}},
		ioEnable_q1m);
end

assign MemBus_v2m = (ioReadWrite_s2m & InstrIsLoad_s2m & Phi2) ?
			loadData_s2m : 32'bz;

`ifdef CADENCE
always @(posedge ioEnable_q1m) begin
    if (ioWrite_s1m) begin
	$display($time, "\tMagical Output --> %h", ioData_s1);
    end
    else if (ioRead_s1m) begin
	`TICK
	$display($time, "\tMagical Input  --> %h", ioData_s1);
    end
    else begin
	$display($time, "\tMagical I/O error");
    end
end
`endif
// vcheck_on
// synopsys translate_on

endmodule				  // loadStoreUnit
