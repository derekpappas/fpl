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
//  Title: 	Main Memory Module
//  Created:	Fri Mar 25 15:30:11 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  memory.v,v 7.6 1995/01/28 00:52:42 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: Simulates the main memory of the processor.
//
//	Hierarchy: 
//
//  Revision History:
//
`include "torch.h"

module memory(
    PadClock,
    Address_s1,
    Data_s1,
    enRead_s1,
    enWrite_s1,
    selMM_q1
    );

input		PadClock;
input [31:0]	Address_s1;
input [7:0]	enRead_s1;
input [7:0]	enWrite_s1;
inout [63:0]	Data_s1;
input		selMM_q1;

wire		Clock	= PadClock;
wire	[31:0]	Address_s1;
wire	[7:0]	enRead_s1;
wire	[7:0]	enWrite_s1;
wire	[63:0]	Data_s1;
wire		selMM_q1;


reg	[63:0]	data_s1;
assign Data_s1 = (|enWrite_s1) ? 64'bz : data_s1;

always @(Clock or Data_s1 or enWrite_s1) begin
    if (Clock == 1'b1)  begin		  // Phi1
	if (|enWrite_s1) begin
	    data_s1 = Data_s1;
	end
    end
end

initial begin
    $main_memory ("memory", Address_s1, data_s1, enRead_s1,
	enWrite_s1, selMM_q1);
end

endmodule				  // memory
