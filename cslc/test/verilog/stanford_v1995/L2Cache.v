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
//  Title: 	Second-Level Cache Model
//  Created:	Wed Mar 30 13:42:13 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  L2Cache.v,v 7.6 1995/06/09 05:50:45 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
// This module simmulates the L2 cache. Whenever AddrValid_s1 goes high it
// will start a request, and MEM_LATENCY later it will put the data on the bus.
// I have not yet implemented store.
// The module is smart enough to know that it should not handle nonCacheable
// requests. That is handled by the gateArray
//
//
//	Hierarchy: 
//
//  Revision History:
//	Modified:	Sat Apr  9 17:45:27 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//
`include "torch.h"

module L2Cache(
// Chip Signals
    PadClock,
    PadAddress_s1,
    PadAddrValid_s1,
    PadWrite_s1,
    PadNonCacheable_s1,
    PadData_w,
    PadL2Tag_v2,
    PadL2Valid_v2,
// System Signals
    Address_s1,
    enRead_s1,
    enWrite_s1,
    Data_s1,
    selMM_q1,
    reqMM_s1
    );

//
// Chip Signals
//
input		PadClock;		  // Chip Clocks
input	[31:0]	PadAddress_s1;		  // Request address from processor
input		PadAddrValid_s1;	  // Inidates a valid request
input		PadWrite_s1;		  // 1 => Write, 0=> Read
input		PadNonCacheable_s1;	  // Non-cacheable request
inout	[63:0]	PadData_w;		  // Bidirectional data bus
output	[15:0]	PadL2Tag_v2;		  // Tag is sent directly to processor
output		PadL2Valid_v2;		  // Valid bit from tags

//
// Board -level signals
//
input		reqMM_s1;		  // Indicates when to read the mem
output [31:0]	Address_s1;		  // Address
output [7:0]	enRead_s1;		  // 1 => Read
output [7:0]	enWrite_s1;		  // 1 => Write
output [63:0]	Data_s1;		  // Data bus
output		selMM_q1;



//
// Internal signals (delay request for a certain ammount of time)
//
reg	[63:0]	data_s1[0:`MEM_LATENCY], data_s2[0:`MEM_LATENCY];
reg	[31:0]	addr_s1[0:`MEM_LATENCY], addr_s2[0:`MEM_LATENCY];
reg 		dataValid_s1[0:`MEM_LATENCY], dataValid_s2[0:`MEM_LATENCY];
reg		write_s1, write_s2;
reg		addrValid_s1, addrValid_s2;
reg		nonCacheable_s1, nonCacheable_s2;


//
// To Communicate with the memory module
//
wire		reqMM_s1;
wire	[31:0]	Address_s1;
wire	[7:0]	enRead_s1;
wire	[7:0]	enWrite_s1;
wire	[63:0]	Data_s1;
wire		selMM_q1;

wire	[31:0]	l2Tag_v2;		  // This is a hack. In verilog it
					  // is not possible to perform a
					  //  bit-select on a register array
wire	[15:0]	L2Tag_v2;		  // Assume tag is 16 bits (indp of
wire		L2Valid_v2;		  // cache size)
wire		accessValid_s1;

//
// Convenience signals
//
wire		Clock = PadClock;	  // Module clock
wire		Write_s1 = PadWrite_s1;
wire		AddrValid_s1 = PadAddrValid_s1;
wire		NonCacheable_s1 = PadNonCacheable_s1;

integer	i;

always @(Clock or Write_s1 or PadData_w or AddrValid_s1 or PadAddress_s1 or
	NonCacheable_s1 or Data_s1 or AddrValid_s1 or
	write_s2 or addrValid_s2 or nonCacheable_s2 or addrValid_s1 or
	NonCacheable_s1 or write_s1 or
	data_s1[0] or data_s1[1] or data_s1[2] or data_s1[3] or
	data_s2[0] or data_s2[1] or data_s2[2] or data_s2[3] or
	addr_s1[0] or addr_s1[1] or addr_s1[2] or data_s1[3] or
	addr_s2[0] or addr_s2[1] or addr_s2[2] or addr_s2[3] or
	dataValid_s1[0] or dataValid_s1[1] or dataValid_s1[2] or
	dataValid_s1[3] or
	dataValid_s2[0] or dataValid_s2[1] or dataValid_s2[2] or
	dataValid_s2[3]) begin
    if (Clock == 1'b1)  begin		  // Phi1
	`TICK
	for (i=1; i <= `MEM_LATENCY; i = i + 1) begin
	    data_s2[i] = data_s1[i];
	    addr_s2[i] = addr_s1[i];
	    dataValid_s2[i] = dataValid_s1[i];
	end

	if (addrValid_s1 == 1'b1) begin
	    data_s2[1] = (write_s1 == 1'b1) ? data_s1[1] : Data_s1;
	end

	data_s2[0] = 64'bz;
	if (AddrValid_s1 == 1'b1) begin
	    addr_s2[0] = PadAddress_s1;
	end

	dataValid_s2[0] = AddrValid_s1 & ~NonCacheable_s1 & ~Write_s1;

	write_s2 = Write_s1;
	addrValid_s2 = AddrValid_s1;
	nonCacheable_s2 = NonCacheable_s1;
    end

    if (Clock == 1'b0) begin		  // Phi2
	`TICK
	for (i = 1; i <= `MEM_LATENCY; i = i + 1) begin
	    data_s1[i] = data_s2[i-1];
	    addr_s1[i] = addr_s2[i-1];
	    dataValid_s1[i] = dataValid_s2[i-1];
	end
	// If we are doing a write then latch holds data from processor.
	//  Otherwise it is tri-stated.
	data_s1[0] = 64'bz;
	if (addrValid_s2 == 1'b1) begin
	    data_s1[1] =  (write_s2 == 1'b1) ? PadData_w : 64'bz;
	end
	else begin
	    data_s1[1] = 64'd0;
	end

	write_s1 = write_s2;
	addrValid_s1 = addrValid_s2;
	nonCacheable_s1 = nonCacheable_s2;
	end
    end

assign PadData_w = (dataValid_s2[`MEM_LATENCY] == 1'b1) ?
		data_s2[`MEM_LATENCY] : 64'bz;
assign l2Tag_v2 = addr_s1[`MEM_LATENCY];
assign L2Tag_v2 = l2Tag_v2[31:16];
assign L2Valid_v2 = 1'b1;

assign accessValid_s1 = addrValid_s1 & ~nonCacheable_s1;

//
// To communicate with the memory module
//
assign Address_s1 = (accessValid_s1 == 1'b1) ? addr_s1[1] : 32'bz;
assign Data_s1 = (accessValid_s1 == 1'b1) ? data_s1[1] : 64'bz;
assign enRead_s1 = (accessValid_s1 == 1'b1) ? {8{~write_s1}} : 8'bz;
assign enWrite_s1 = (accessValid_s1 == 1'b1) ? {8{write_s1}} : 8'bz;
assign selMM_q1 = (accessValid_s1 | reqMM_s1) & Clock;

assign PadL2Tag_v2 = L2Tag_v2;
assign PadL2Valid_v2 = L2Valid_v2;

endmodule				  // L2Cache
