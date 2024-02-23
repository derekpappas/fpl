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
//  Title: 	Cp0 Widget
//  Created:	May 1992
//  Modified:	Sun Mar 20 17:51:05 1994
//	* Cleanup up code.	<ricardog@chroma>
//  Modified:	Nov 22 1992
//	* Removed control logic.	<ricardog@bill>
//  Author: 	Stefanos Sidiropolo
//		<sidirop@chroma>
//
//
//  cp0Bus.v,v 7.9 1995/06/09 05:50:08 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This module contains latches and tri-state buffers to 
//  	    connect the datapath with cp0. Data from the B-TBus is put on the
//  	    cp0Bus (after being staged) and data from cp0 is put on the
//  	    MemBus.
//
//	Hierarchy: system.processor.decodeExec.DataPath.BExecuteUnit.cp0Bus
//

module cp0Bus (
// Clocks
    Phi1,
    Phi2,
    BenabCop0Latch_s1e,
    BenabCop0Latch_s2e,
    BenabCop0Latch_s1m,
// Inputs
    MvToCop0_s2m,
    cp0BusDrv_s2m,
    BTBus_s1e,
// Outputs
    MemBus_v2m,
// Inouts
    Cp0Bus_s2m
    );


//
// Clocks
//
input		Phi1;
input		Phi2;

//
// Latch enables
//
input		BenabCop0Latch_s1e;
input		BenabCop0Latch_s2e;
input		BenabCop0Latch_s1m;

//
// Inputs
//
input		MvToCop0_s2m;
input		cp0BusDrv_s2m;
input 	[31:0]	BTBus_s1e;		  // From the register file

//
// To the register file
//
output	[31:0]	MemBus_v2m;

//
// Inouts (from/to co-processor 0)
//
inout	[31:0]	Cp0Bus_s2m;

wire	[31:0]	cp0Bus_s2e, cp0Bus_s1m, cp0Bus_s2m;

//
// Stage the data until the right time (MEM stage)
//
PHI1_LATCH_EN_32 latCp0Bus_s2e (cp0Bus_s2e, BTBus_s1e, Phi1, BenabCop0Latch_s1e);
PHI2_LATCH_EN_32 latCp0Bus_s1m (cp0Bus_s1m, cp0Bus_s2e, Phi2, BenabCop0Latch_s2e);
PHI1_LATCH_EN_32 latCp0Bus_v2m (cp0Bus_s2m, cp0Bus_s1m, Phi1, BenabCop0Latch_s1m);

//
// Drive the busses
//
TRIBUF_32 Cp0BusBuf (Cp0Bus_s2m, cp0Bus_s2m, MvToCop0_s2m);
TRIBUF_32 MemBusBuf (MemBus_v2m, Cp0Bus_s2m, cp0BusDrv_s2m);

endmodule
