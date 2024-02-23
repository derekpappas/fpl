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
//  Title: 	B-side Bypass Logic.
//  Created:	Nov 11 1991module 
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  BBypassData.v,v 7.18 1995/01/28 00:50:38 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This module contains the latches and muxes neede to bypass
//  	    data from the EX and MEM stages. It does not contain the logic
//  	    needed to detect bypass. All control signals are sent from
//  	    bypassSpec.
//
//	Hierarchy: system.processor.regFile.BBpass.BBypassData
//
//  Revision History:
//	Modified: Thu Dec  1 22:00:24 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified:	Sat May 28 15:51:11 1994	<ricardog@chroma>
//	* Qualify load data latch with IStall_s2.
//	Modified:	Sun May 22 16:46:15 1994	<ricardog@chroma>
//	* Changed Psi2_q2 to Phi2.
//	Modified:	Sun Apr 10 15:27:32 1994	<ricardog@chroma>
//	* New file for B-side only (derived from bypassData).
//	Modified:	Sat Apr  9 17:37:37 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Tue Mar 29 19:00:40 1994	<ricardog@chroma>
//	* Changed signal names and moved macros.
//	Modified:	Feb 20 1992	<ricardog@bill>
//	* Implemented as datapath components.
//
`include "torch.h"

module BBypassData(
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
    BSBypassLoad_s1e,
    BTBypassLoad_s1e,
    BSBypassLoad_b_s1e,
    BTBypassLoad_b_s1e,
    BSBypassSel_s1e,
    BTBypassSel_s1e,
    BWasLoad_s1w,
    BWasLoad_b_s1w,
    AResultBus_v2e,
    BResultBus_v2e,
    MemBus_v2m,
    BSData_v2r,
    BTData_v2r,
    BWBData_s1w,
    BSBus_s1e,
    BTBus_s1e
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
// Bypass select control signals
//
input		BSBypassLoad_s1e;
input		BTBypassLoad_s1e;
input		BSBypassLoad_b_s1e;
input		BTBypassLoad_b_s1e;
input	[4:0]	BSBypassSel_s1e;
input	[4:0]	BTBypassSel_s1e;

//
// Determine if need to select data from MemBus for WB
//
input		BWasLoad_s1w;
input		BWasLoad_b_s1w;

//
// Result buses
//
input	[31:0]	AResultBus_v2e;
input	[31:0]	BResultBus_v2e;
input	[31:0]	MemBus_v2m;

//
// From the RF read
//
input	[31:0]	BSData_v2r;
input	[31:0]	BTData_v2r;

//
// To the RF write back
//
output	[31:0] BWBData_s1w;

//
// B-side operand buses
//
output [31:0] BSBus_s1e, BTBus_s1e;


//
// Wire Declarations
//
wire	[31:0]	AData_s1m, AData_s2m, AData_s1w;
wire	[31:0]	BData_s1m, BData_s2m, BData_s1w;
wire	[31:0]	BLoadData_s1w;
wire	[31:0]	BSData_s1e, BTData_s1e;

wire	[31:0]	BSbus_s1e, BTbus_s1e;


//------------------------------------------------------------------------
//			 ---- Bypass Muxes ----
//------------------------------------------------------------------------
// The bypass is done in a two-level mux.  Since the load data will be
// late there is a 2-1 mux to select between the load data and the
// pipeline data.
//
MUX5_32 BSBypassMux (BSbus_s1e,
	AData_s1m, BData_s1m,
	AData_s1w, BData_s1w,
	BSData_s1e,
	BSBypassSel_s1e[`BYPASS_AEX_BIT], BSBypassSel_s1e[`BYPASS_BEX_BIT],
	BSBypassSel_s1e[`BYPASS_AMEM_BIT], BSBypassSel_s1e[`BYPASS_BMEM_BIT],
	BSBypassSel_s1e[`NO_BYPASS_BIT]);

TRIBUF_32   BSBus(BSBus_s1e, BSbus_s1e, BSBypassLoad_b_s1e);
TRIBUF_32   BSBusLoad(BSBus_s1e, BLoadData_s1w, BSBypassLoad_s1e);
//MUX2_32 BSLoadBypassMux (BSBus_s1e, BLoadData_s1w, BSbus_s1e,
//	BSBypassLoad_s1e);


MUX5_32 BTBypassMux (BTbus_s1e,
	AData_s1m, BData_s1m,
	AData_s1w, BData_s1w,
	BTData_s1e,
	BTBypassSel_s1e[`BYPASS_AEX_BIT], BTBypassSel_s1e[`BYPASS_BEX_BIT],
	BTBypassSel_s1e[`BYPASS_AMEM_BIT], BTBypassSel_s1e[`BYPASS_BMEM_BIT],
	BTBypassSel_s1e[`NO_BYPASS_BIT]);

TRIBUF_32   BTBus(BTBus_s1e, BTbus_s1e, BTBypassLoad_b_s1e);
TRIBUF_32   BTBusLoad(BTBus_s1e, BLoadData_s1w, BTBypassLoad_s1e);
//MUX2_32 BTLoadBypassMux (BTBus_s1e, BLoadData_s1w, BTbus_s1e,
//	BTBypassLoad_s1e);



//
// Select data for RF write-back
//
MUX2_32 BWBData_S1W (BWBData_s1w, BLoadData_s1w, BData_s1w,
	BWasLoad_s1w);


//------------------------------------------------------------------------
//		    ---- A-side Pipeline Chain ----
//------------------------------------------------------------------------
// The bypass mux is after the latch. Latch the data read from the RF
PHI2_LATCH_EN_32 AData_S1M (AData_s1m, AResultBus_v2e, Phi2, Alpha2_s2e);
PHI1_LATCH_EN_32 AData_S2M (AData_s2m, AData_s1m, Phi1, Alpha1_s1m);
PHI2_LATCH_EN_32 AData_S1W (AData_s1w, AData_s2m, Phi2, Alpha2_s2m);


//------------------------------------------------------------------------
//		    ---- B-side Pipeline Chain ----
//------------------------------------------------------------------------
// Need to keep the value read from register file for one phase
// so that we can do compare AFTER the latch, since we stall in Phi2
PHI2_LATCH_EN_32 BSData_S1E (BSData_s1e, BSData_v2r, Phi2, ~Stall_s2);
PHI2_LATCH_EN_32 BTData_S1E (BTData_s1e, BTData_v2r, Phi2, ~Stall_s2);

//
// Hold values until Write Back
//
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

endmodule			// BsideBypassData
