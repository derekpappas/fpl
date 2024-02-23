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
//  Title: 	A-side Bypass
//  Created:	Nov 11 1991
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  ABypass.v,v 7.18 1995/01/28 00:50:19 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This is the top level modul for bypass.
//
//	Hierarchy: system.processor.regFile
//
//  Revision History:
//	Modified:	Sat May 28 15:52:22 1994	<ricardog@chroma>
//	* Qualified load data latch with IStall.
//	Modified:	Sun May 22 16:42:43 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1.
//	Modified:	Sun Apr 10 15:25:11 1994	<ricardog@chroma>
//	* New file for A-side only (derived from bypass.v)
//	Modified:	Sat Apr  9 17:38:50 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Tue Mar 29 18:59:19 1994	<ricardog@chroma>
//	* Changed signal names and removed macros.
//	Modified:	Feb 20 1992	<ricardog@bill>
//	* This module is now connectivity only.
//
`include "torch.h"


module ABypass(
    Phi1,
    Phi2,
    ARSSpec_s2r,
    ARTSpec_s2r,
    ARDSpec_s2r,
    BRTSpec_s2r,
    BRDSpec_s2r,
    AResultBus_v2e,
    BResultBus_v2e,
    MemBus_v2m,
    ASData_v2r,
    ATData_v2r,
    ADestIsRD_s1e,
    ADestIsRT_s1e,
    ADestIs31_s1e,
    BDestIsRD_s1e,
    BDestIsRT_s1e,
    BIsLoad_s1e,
    ADestPtr_v1e,
    ADestBoostValid_v1e,
    AKill_s1e,
    AIgnore_s2e,
    BDestPtr_v1e,
    BDestBoostValid_v1e,
    BKill_s1e,
    BIgnore_s2e,
    Commit_s1e,
    Squash_s1e,
    Except_s1w,
    Stall_s1,
    Stall_s2,
    IStall_s1,
    MemStall_s1,
    ASDSpec_w,
    ATRSpec_w,
    ASBus_s1e,
    ATBus_s1e,
    AWBData_s1w,
    SEqualsT_v1e,
    SIsNegative_v1e
    );


//
// Clocks & Stalls
//
input		Phi1;
input		Phi2;
input		Stall_s1;
input		Stall_s2;
input		IStall_s1; 
input		MemStall_s1; 

//
// Register specifiers
//
input	[5:0]	ARSSpec_s2r;
input	[5:0]	ARTSpec_s2r;
input	[5:0]	ARDSpec_s2r;
input	[5:0]	BRTSpec_s2r;
input	[5:0]	BRDSpec_s2r;

//
// Result Busses
//
input	[31:0]	AResultBus_v2e;
input	[31:0]	BResultBus_v2e;
input	[31:0]	MemBus_v2m;

//
// Source data busses
//
input	[31:0]	ASData_v2r;		  // Before bypass
input	[31:0]	ATData_v2r;		  // Raw data from RF read

//
// Control signals
//
input		ADestIsRD_s1e;
input		ADestIsRT_s1e;
input		ADestIs31_s1e;
input		BDestIsRD_s1e;
input		BDestIsRT_s1e;
input		BIsLoad_s1e;
input		ADestPtr_v1e;
input		ADestBoostValid_v1e;
input		AKill_s1e;
input		AIgnore_s2e;
input		BDestPtr_v1e;
input		BDestBoostValid_v1e;
input		BKill_s1e;
input		BIgnore_s2e;

//
// Branch Control Signals
//
input		Commit_s1e;		  // Branch taken: predicted ok
input		Squash_s1e;		  // Branch taken: not ok
input		Except_s1w;		  // Disable WB

//
// Condition Codes
//
output		SEqualsT_v1e;		  // 
output		SIsNegative_v1e;	  // 


//
// Specifiers for RF read/write
//
output	[7:0]	ASDSpec_w;
output	[6:0]	ATRSpec_w;

//
// Source Operand Busses (to EXE units)
//
output	[31:0]	ASBus_s1e, ATBus_s1e;

//
// WB Data busses
//
output	[31:0]	AWBData_s1w;		  // Data to be written back to RF

//
// Bypass Mux control signals
//
wire	[4:0]	ASBypassSel_s1e, ATBypassSel_s1e; // Mux control signals

//
// wires between units
//
wire		Alpha2_s2e;
wire		Alpha1_s1m;
wire		Alpha2_s2m;
wire		Beta2_s2e;
wire		Beta1_s1m;
wire		Beta2_s2m;
wire		Delta2_q2;
wire		ASBypassLoad_s1e;
wire		ASBypassLoad_b_s1e;
wire		ATBypassLoad_s1e;
wire		ATBypassLoad_b_s1e;

ABypassSpec ABypassSpec(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.ARSSpec_s2r		(ARSSpec_s2r),
	.ARTSpec_s2r		(ARTSpec_s2r),
	.ARDSpec_s2r		(ARDSpec_s2r),
	.BRTSpec_s2r		(BRTSpec_s2r),
	.BRDSpec_s2r		(BRDSpec_s2r),
	.ADestIsRD_s1e		(ADestIsRD_s1e),
	.ADestIsRT_s1e		(ADestIsRT_s1e),
	.ADestIs31_s1e		(ADestIs31_s1e),
	.BDestIsRD_s1e		(BDestIsRD_s1e),
	.BDestIsRT_s1e		(BDestIsRT_s1e),
	.BIsLoad_s1e		(BIsLoad_s1e),
	.ADestPtr_v1e		(ADestPtr_v1e),
	.ADestBoostValid_v1e	(ADestBoostValid_v1e),
	.AKill_s1e		(AKill_s1e),
	.AIgnore_s2e		(AIgnore_s2e),
	.BDestPtr_v1e		(BDestPtr_v1e),
	.BDestBoostValid_v1e	(BDestBoostValid_v1e),
	.BKill_s1e		(BKill_s1e),
	.BIgnore_s2e		(BIgnore_s2e),
	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
	.Except_s1w		(Except_s1w),
	.Stall_s1		(Stall_s1),
	.Stall_s2		(Stall_s2),
	.IStall_s1		(IStall_s1),
	.MemStall_s1		(MemStall_s1),
	.Alpha2_s2e		(Alpha2_s2e),
	.Alpha1_s1m		(Alpha1_s1m),
	.Alpha2_s2m		(Alpha2_s2m),
	.Beta2_s2e		(Beta2_s2e),
	.Beta1_s1m		(Beta1_s1m),
	.Beta2_s2m		(Beta2_s2m),
	.Delta2_q2		(Delta2_q2),
	.ASDSpec_w		(ASDSpec_w),
	.ATRSpec_w		(ATRSpec_w),
	.ASBypassLoad_s1e	(ASBypassLoad_s1e),
	.ATBypassLoad_s1e	(ATBypassLoad_s1e),
	.ASBypassLoad_b_s1e	(ASBypassLoad_b_s1e),
	.ATBypassLoad_b_s1e	(ATBypassLoad_b_s1e),
	.ASBypassSel_s1e	(ASBypassSel_s1e),
	.ATBypassSel_s1e	(ATBypassSel_s1e)
    );


ABypassData ABypassData(
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Stall_s2		(Stall_s2),
	.Alpha2_s2e		(Alpha2_s2e),
	.Alpha1_s1m		(Alpha1_s1m),
	.Alpha2_s2m		(Alpha2_s2m),
	.Beta2_s2e		(Beta2_s2e),
	.Beta1_s1m		(Beta1_s1m),
	.Beta2_s2m		(Beta2_s2m),
	.Delta2_q2		(Delta2_q2),
	.ASBypassLoad_s1e	(ASBypassLoad_s1e),
	.ATBypassLoad_s1e	(ATBypassLoad_s1e),
    	.ASBypassLoad_b_s1e	(ASBypassLoad_b_s1e),
	.ATBypassLoad_b_s1e	(ATBypassLoad_b_s1e),
	.ASBypassSel_s1e	(ASBypassSel_s1e),
	.ATBypassSel_s1e	(ATBypassSel_s1e),
	.ASData_v2r		(ASData_v2r),
	.ATData_v2r		(ATData_v2r), 
	.AResultBus_v2e		(AResultBus_v2e),
	.BResultBus_v2e		(BResultBus_v2e),
	.MemBus_v2m		(MemBus_v2m), 
	.SEqualsT_v1e		(SEqualsT_v1e),
	.SIsNegative_v1e	(SIsNegative_v1e),
	.AWBData_s1w		(AWBData_s1w), 
	.ASBus_s1e		(ASBus_s1e),
	.ATBus_s1e		(ATBus_s1e));

endmodule




