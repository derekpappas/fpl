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
//  Title: 	Kill Unit
//  Created:	Sun May 22 16:26:50 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  killUnit.v,v 7.5 1995/01/28 00:43:23 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: 
// This module takes the Kill signals and the AWrong, BWrong signals and 
// generates the Ignore signals for the A and B side.  If an instruction
// is valid on both sides, then it executes on the A side.
//
//	Hierarchy: system.processor.decodeExec.
//
//  Revision History:
//	Modified:	Sun May 22 16:27:28 1994	<ricardog@chroma>
//	* Changed IStall_s1 to Stall_s1.
//
//
`include "torch.h"

module killUnit(
    Phi1,
    Stall_s1,
    KillOne_s1e,
    AWrong_s1e,
    BWrong_s1e,
    AIgnore_s2e,
    BIgnore_s2e
    );

//
// Clocks & Stalls
//
input		Phi1;
input		Stall_s1;

//
// Control signals from instruction fetch unit.
//
input		KillOne_s1e;
input		AWrong_s1e;
input		BWrong_s1e;

//
// Outputs
//
output		AIgnore_s2e;
output		BIgnore_s2e;

//
// Local registers
//
reg		AIgnore_s2e;
reg		BIgnore_s2e;

always @(Phi1 or KillOne_s1e or AWrong_s1e or BWrong_s1e or Stall_s1) begin
    if (Phi1 & ~Stall_s1) begin
	AIgnore_s2e = AWrong_s1e;
	BIgnore_s2e = BWrong_s1e | (~AWrong_s1e & KillOne_s1e);
    end
end

endmodule

