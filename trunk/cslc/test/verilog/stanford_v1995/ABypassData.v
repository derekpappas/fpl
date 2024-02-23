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
//  Title: 	A-side Bypass Logic.
//  Created:	Nov 11 1991module 
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  ABypassData.v,v 7.17 1995/01/28 00:50:26 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This modul contains the latches and muxes neede to bypass
//  	    data from the EX and MEM stages. It does not contain the logic
//  	    needed to detect bypass. All control signals are sent from
//  	    bypassSpec.
//
//	Hierarchy: system.processor.regFile.ABypass
//
//  Revision History:
//	Modified: Thu Dec  1 21:58:47 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified:	Sat May 28 15:52:45 1994	<ricardog@chroma>
//	* Qualified load data latch with IStall.
//	Modified:	Sun May 22 16:42:26 1994	<ricardog@chroma>
//	* Changed Psi2_q2 to Phi2.
//	Modified:	Sun Apr 10 15:25:48 1994	<ricardog@chroma>
//	* New file for A-side only derived from bypassData.
//	Modified:	Sat Apr  9 17:37:37 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Tue Mar 29 19:00:40 1994	<ricardog@chroma>
//	* Changed signal names and moved macros.
//	Modified:	Feb 20 1992	<ricardog@bill>
//	* Implemented as datapath components.
//
`include "torch.h"

module ABypassData(
    Phi1,
    Phi2, 
    Stall_s2,
    Alpha2_s2e,
    Alpha1_s1m,
    Alpha2_s2m,
    Beta2_s2e,
    Beta1_s1m,
    Beta2_s2m,
    Delta2_q2,
    ASBypassLoad_s1e,
    ATBypassLoad_s1e, 
    ASBypassLoad_b_s1e,
    ATBypassLoad_b_s1e,
    ASBypassSel_s1e,
    ATBypassSel_s1e, 
    ASData_v2r,
    ATData_v2r, 
    AResultBus_v2e,
    BResultBus_v2e,
    MemBus_v2m, 
    SEqualsT_v1e,
    SIsNegative_v1e,
    AWBData_s1w,
    ASBus_s1e,
    ATBus_s1e
    );

//
// Clocks
//
input		Phi1;
input		Phi2;
input		Stall_s2;
input		Alpha2_s2e;
input		Alpha1_s1m;
input		Alpha2_s2m;
input		Beta2_s2e;
input		Beta1_s1m;
input		Beta2_s2m;
input		Delta2_q2;

//
// Bypass select inputs
//
input		ASBypassLoad_s1e, ATBypassLoad_s1e;
input		ASBypassLoad_b_s1e, ATBypassLoad_b_s1e;
input	[4:0]	ASBypassSel_s1e, ATBypassSel_s1e;


//
// Data from RF read
//
input	[31:0]	ASData_v2r, ATData_v2r;

//
// Result buses
//
input	[31:0]	AResultBus_v2e, BResultBus_v2e, MemBus_v2m;

//
// Fast Compare Outputs (branch condition codes)
//
output		SEqualsT_v1e, SIsNegative_v1e;

//
// Data for RF write back
//
output	[31:0]	AWBData_s1w;

//
// A-side operand busses
//
output	[31:0]	ASBus_s1e, ATBus_s1e;

//
// Wire Declarations
//
wire	[31:0]	AData_s1m, AData_s2m;
wire	[31:0]	BData_s1m, BData_s2m, BData_s1w;
wire	[31:0]	BLoadData_s1w;
wire	[31:0]	ASData_s1e, ATData_s1e;
wire	[31:0]	ASbus_s1e, ATbus_s1e;

//
// Fast branch compare (determine if S and T busses are the same)
//
COMP_32 SEqualsT_V1E(SEqualsT_v1e, ASBus_s1e, ATBus_s1e);
assign SIsNegative_v1e = ASBus_s1e[`MSB];


//------------------------------------------------------------------------
//			 ---- Bypass Muxes ----
//------------------------------------------------------------------------
// The bypass is done in a two-level mux.  Since the load data will be
// late there is a 2-1 mux to select between the load data and the
// pipeline data.
//
MUX5_32	ASBypassMux (ASbus_s1e,
	AData_s1m, BData_s1m,
	AWBData_s1w, BData_s1w,
	ASData_s1e,
	ASBypassSel_s1e[`BYPASS_AEX_BIT], ASBypassSel_s1e[`BYPASS_BEX_BIT],
	ASBypassSel_s1e[`BYPASS_AMEM_BIT], ASBypassSel_s1e[`BYPASS_BMEM_BIT],
	ASBypassSel_s1e[`NO_BYPASS_BIT]);

TRIBUF_32   ASBus(ASBus_s1e, ASbus_s1e, ASBypassLoad_b_s1e);
TRIBUF_32   ASBusLoad(ASBus_s1e, BLoadData_s1w, ASBypassLoad_s1e);
//MUX2_32 ASLoadBypassMux (ASBus_s1e, BLoadData_s1w, ASbus_s1e,
//	ASBypassLoad_s1e);

MUX5_32 ATBypassMux (ATbus_s1e,
	AData_s1m, BData_s1m,
	AWBData_s1w, BData_s1w,
	ATData_s1e,
	ATBypassSel_s1e[`BYPASS_AEX_BIT], ATBypassSel_s1e[`BYPASS_BEX_BIT],
	ATBypassSel_s1e[`BYPASS_AMEM_BIT], ATBypassSel_s1e[`BYPASS_BMEM_BIT],
	ATBypassSel_s1e[`NO_BYPASS_BIT]);

TRIBUF_32   ATBus(ATBus_s1e, ATbus_s1e, ATBypassLoad_b_s1e);
TRIBUF_32   ATBusLoad(ATBus_s1e, BLoadData_s1w, ATBypassLoad_s1e);
//MUX2_32 ATLoadBypassMux (ATBus_s1e, BLoadData_s1w, ATbus_s1e,
//	ATBypassLoad_s1e);

//------------------------------------------------------------------------
//		    ---- A-side Pipeline Chain ----
//------------------------------------------------------------------------
// The bypass mux is after the latch. Latch the data read from the RF
// 
PHI2_LATCH_EN_32 ASData_S1E (ASData_s1e, ASData_v2r, Phi2, ~Stall_s2);
PHI2_LATCH_EN_32 ATData_S1E (ATData_s1e, ATData_v2r, Phi2, ~Stall_s2);

//
// Hold value until Write Back. WB data will always come from the
// datapath. In the B-side there is a mux to select between the
// datapath and the load data.
//
PHI2_LATCH_EN_32 AData_S1M (AData_s1m, AResultBus_v2e, Phi2, Alpha2_s2e);
PHI1_LATCH_EN_32 AData_S2M (AData_s2m, AData_s1m, Phi1, Alpha1_s1m);
PHI2_LATCH_EN_32 AData_S1W (AWBData_s1w, AData_s2m, Phi2, Alpha2_s2m);

//------------------------------------------------------------------------
//		    ---- B-side Pipeline Chain ----
//------------------------------------------------------------------------
// The bypass mux is after the latch. Latch the data read from the RF
PHI2_LATCH_EN_32 BData_S1M (BData_s1m, BResultBus_v2e, Phi2, Beta2_s2e);
PHI1_LATCH_EN_32 BData_S2M (BData_s2m, BData_s1m, Phi1, Beta1_s1m);

//
// One latch is for the regular case where the result is produced in EX2.
// The output of this latch goes into the 5-1 bypass Mux.
// The second latch is for loads only. It is always open (waste some 
// power, but make control logic simpler). The output then goes into a 2-1
// mux for bypassing.
//
PHI2_LATCH_EN_32 BData_S1W (BData_s1w, BData_s2m, Phi2, Beta2_s2m);
PHI2_LATCH_32 BLoadData_S1W(BLoadData_s1w, MemBus_v2m, Delta2_q2);

endmodule		// AsideBypassData


