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
//  Title: 	Gate Array
//  Created:	Fri Mar 25 15:47:19 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  gateArray.v,v 7.11 1995/07/25 22:22:15 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//	    Handles NonCacheables, io, interrupts and syscalls
//	    This module handles all the "special" requests that the processor
//	    puts out on the buss. These consists of
//	    1 NonCacheable accesses. It generates a random delay until the data
//	      is ready. It ReqBus, and releases it when it is done.
//	    2 io calls. It calls the appropriate PLI routine to display stuff.
//	    3 interrupts. It generates random interrupts that the processor must
//	      service.
//	    4 syscal. The processor write to a magic memory location, and this
//	      is transformed into a complex syscall.
//
//	Hierarchy: 
//
//  Revision History:
//	Modified:	Sat Apr  9 18:00:32 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//
`include "torch.h"


module gateArray(
    PadAddress_s1,
    PadLength_s1,
    PadAddrValid_s1,
    PadWrite_s1,
    PadNonCacheable_s1,
    PadGrant_s1,
    PadData_w,
    PadL2Tag_v2,
    PadL2Valid_v2,
    PadBusError_v2,
    PadReqICache_s1,
    PadReqDCache_s1,
    PadReqBus_s1,
    PadClock,
    PadReset_ww,
    PadInterrupt_ww,
    Address_s1,
    enRead_s1,
    enWrite_s1,
    Data_s1,
    reqMM_s1
    );


inout	[31:0]	PadAddress_s1;
inout	[63:0]	PadData_w;
input	[5:0]	PadLength_s1;
input		PadAddrValid_s1;
input		PadWrite_s1;
input		PadNonCacheable_s1;
input		PadGrant_s1;
output		PadReqBus_s1;
input	[15:0]	PadL2Tag_v2;
output	[5:0]	PadInterrupt_ww;
input		PadL2Valid_v2;
output		PadBusError_v2;
output		PadReqICache_s1;
output		PadReqDCache_s1;
output		PadClock, PadReset_ww;

// To communicate with memory module
output	[31:0]	Address_s1;
inout	[63:0]	Data_s1;
output	[7:0]	enRead_s1;
output	[7:0]	enWrite_s1;
output		reqMM_s1;


reg	[31:0]	addr_s2a;
reg	[5:0]	length_s2a, length_s1b;
reg		valid_s2aq, valid_s2a, valid_s1bq, valid_s1b, valid_s2b;
reg		write_s2a, write_s1b, write_s2b;
reg	[28:0]	dwaddr_s1b;		  // double-word address of req
reg	[28:0]	dwaddr_s2b;
reg	[7:0]	enRead_s1b, enRead_s2b, enWrite_s1b, enWrite_s2b;
reg		selMM_s1b, selIO_s1b, selSC_s1b, selIC_s1b;
reg		selIO_s2b, selSC_s2b, selIC_s2b;
reg	[63:0]	data_s1b, data_s2b;
reg		Clock, Reset_ww;
reg		reqBus_s1, reqBus_s2;
reg	[5:0]	Interrupt_ww;

wire	[7:0]	enable_s2a;

wire	[5:0]	Length_s1	= PadLength_s1;
wire 		AddrValid_s1	= PadAddrValid_s1;
wire		Write_s1	= PadWrite_s1;
wire		NonCacheable_s1	= PadNonCacheable_s1;

wire		selIO_q2;
wire		selSC_q2;
wire		selIC_q1;

assign 		PadClock	= Clock;
assign 		PadReset_ww	= Reset_ww;
assign 		PadAddress_s1	= 32'bz;

assign		PadInterrupt_ww = Interrupt_ww;

initial begin
    Interrupt_ww[5:1] = 5'd0;
    reqBus_s1 = 1'b0; reqBus_s2 = 1'b0;
end

//
// ???? Is this to model contention at the cache????
//
always @(Clock or valid_s2a or write_s2a) begin
    if (Clock & valid_s2a & ~write_s2a) begin
	randomWait;
    end
end

//
// This is cycle a, where we input the data. These latches never close
// ????
always @(Clock or AddrValid_s1 or PadAddress_s1 or PadData_w or Length_s1 or
	Write_s1 or NonCacheable_s1 or dwaddr_s1b or length_s1b or
	valid_s1b or write_s1b or reqBus_s1) begin
    if (Clock & ~reqBus_s1) begin				  // Phi1
	`TICK
	if (AddrValid_s1 == 1'b1 && NonCacheable_s1 == 1'b1) begin
	    addr_s2a = PadAddress_s1;
	    length_s2a = Length_s1;
	    write_s2a = Write_s1;
	    valid_s2aq = `TRUE;
	end
	else begin
	    addr_s2a = 32'b0;
	    length_s2a = 6'b0;
	    write_s2a = 1'b0;
	    valid_s2aq = 1'b0;
	end
    end
end

//
// What are these latches for????
//
always @(Clock or AddrValid_s1 or NonCacheable_s1 or reqBus_s1) begin
    if (Clock == 1'b1) begin		  // unqualified phi1
	`TICK
	valid_s2a = AddrValid_s1 & ~reqBus_s1 & NonCacheable_s1;
	reqBus_s2 = reqBus_s1;
    end
end

always @(Clock or write_s2a or valid_s2a or addr_s2a or valid_s2aq or
	dwaddr_s2b or length_s2a or reqBus_s2 or PadData_w or
	enable_s2a) begin
    if (Clock == 1'b0)  begin		  // Phi2
	`TICK
	dwaddr_s1b[28:0] = addr_s2a[31:3];
	length_s1b = length_s2a;
	valid_s1bq = valid_s2aq;
	valid_s1b = valid_s2a;
	write_s1b = write_s2a;
	if (write_s2a & valid_s2a) begin
	    data_s1b = PadData_w;
	end

	enRead_s1b = (valid_s2aq & ~write_s2a) ? enable_s2a : 8'b0;
	enWrite_s1b = (valid_s2aq & write_s2a) ? enable_s2a : 8'b0;
//	reqBus_s1 = reqBus_s2;
	selMM_s1b	= 1'b0;
	selIO_s1b	= 1'b0;
	selSC_s1b	= 1'b0;
	selIC_s1b	= 1'b0;
	case ({dwaddr_s1b, 3'b0})
	    `IO_DWADDR: selIO_s1b = 1'b1;
	    `SC_DWADDR: selSC_s1b = 1'b1;
	    `IC_DWADDR: selIC_s1b = 1'b1;
	    default:    selMM_s1b = valid_s2a;
	endcase
    end					  // Phi2
end


assign enable_s2a = (( {8{length_s2a[5] | length_s2a[4] | length_s2a[3]}}) | (~(8'hFF << length_s2a[2:0]) << addr_s2a[2:0]));

assign reqMM_s1		= (reqBus_s1 | write_s1b) & selMM_s1b;
assign enRead_s1		= (reqMM_s1) ? enRead_s1b : 8'bz;
assign enWrite_s1	= (reqMM_s1) ? enWrite_s1b : 8'bz;
assign Data_s1 		= (reqMM_s1 & write_s1b) ? data_s1b : 64'bz;
assign Address_s1	= (reqMM_s1) ? {dwaddr_s1b,3'b0} : 32'bz;

always @(Clock or write_s1b or data_s1b or Data_s1) begin
    if (Clock == 1'b1 && valid_s1b == 1'b1) begin
	`TICK
	data_s2b =  (write_s1b == 1'b1) ? data_s1b : Data_s1;
    end
end

always @(Clock or dwaddr_s1b or enable_s2a or valid_s2a or write_s2a or
	enWrite_s2b or dwaddr_s1b or enWrite_s1b or write_s1b or
	valid_s1bq or valid_s1b or enRead_s1b or selMM_s1b or
	selIO_s1b or selSC_s1b or selSC_s1b or selIC_s1b or reqBus_s1) begin
    if (Clock == 1'b1 & reqBus_s1 != 1'b1) begin // Phi1
	`TICK
	dwaddr_s2b	= dwaddr_s1b;
	valid_s2b	= valid_s1bq;

	enRead_s2b	= enRead_s1b;
	enWrite_s2b	= enWrite_s1b;
	write_s2b	= write_s1b;

	selIO_s2b	= selIO_s1b;
	selSC_s2b	= selSC_s1b;
	selIC_s2b	= selIC_s1b;

    end
end

assign PadData_w = (write_s2b != 1'b1 & valid_s2b == 1'b1)? data_s2b : 64'bz;
assign selIO_q2 = selIO_s2b & ~Clock;
assign selSC_q2 = selSC_s2b & ~Clock;
assign selIC_q1 = selIC_s1b & Clock;
	
//---------------------------------------------------------------------------
//			   --- PLI Calls ---
//---------------------------------------------------------------------------
initial begin
    $io_handler ("iohandler", data_s2b[31:0], enRead_s2b[3:0],
	enWrite_s2b[3:0], selIO_q2);

    $sc_handler ("schandler", data_s2b[31:0], enRead_s2b[3:0],
	enWrite_s2b[3:0], selSC_q2);

    $intr_ctl ("intr", Interrupt_ww[0], selIC_q1, Clock);
end

//---------------------------------------------------------------------------
//			--- Reset Interrupt ---
//---------------------------------------------------------------------------
always @(Interrupt_ww) begin
    if (Interrupt_ww != 0) begin
	#5000
	Interrupt_ww = 0;
    end
end
//---------------------------------------------------------------------------
//			     ---- TBI ----
//---------------------------------------------------------------------------
assign PadBusError_v2 = 1'b0;
assign PadReqICache_s1 = 1'b0;
assign PadReqDCache_s1 = 1'b0;
assign PadReqBus_s1 = reqBus_s1;

initial begin
    if($test$plusargs("reset")) begin
	Clock = 1'b0;
	Reset_ww = 1'b0;
	`CYCLE
	Clock = 1'b1;
	Reset_ww = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	`PHASE
	Clock = 1'b1;
	`PHASE
	Clock = 1'b0;
	Reset_ww = 1'b0;
    end
    else begin
	Clock = 1'b0;
	Reset_ww = 1'b0;
    end
end

always begin
    `PHASE
    Clock = 1'b1;
    `PHASE
    Clock = 1'b0;
end

task randomWait;
    integer	randomValue;

begin
    @(negedge Clock) begin
	$display("%t\tRandom wait for data", $time);
	`TICK
	reqBus_s1 = 1'b1;
    end
    #100 
    @(negedge Clock) begin
	$display("%t\tRandom wait for data done", $time);
	`TICK
	reqBus_s1 = 1'b0;
    end
end

endtask

endmodule				  // gateArray
