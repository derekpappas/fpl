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
//  Title: 	Register File Waves
//  Created:	Wed Apr 13 14:37:20 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  regFileWaves.v,v 7.6 1995/01/28 00:50:58 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: 
//
//	Hierarchy: 
//
//  Revision History:
//
`include "torch.h"

    	$gr_addwaves(
    	    "ARS",	`REG_FILE.ARSSpec_s2r,
    	    "ART",	`REG_FILE.ARTSpec_s2r,
    	    "ARD",	`REG_FILE.ARDSpec_s2r,
    	    "BRS",	`REG_FILE.BRSSpec_s2r,
    	    "BRT",	`REG_FILE.BRTSpec_s2r,
    	    "BRD",	`REG_FILE.BRDSpec_s2r,
	    "ASBSel",	`A_BYPASS.ASBypassSel_s1e,
	    "ATBSel",	`A_BYPASS.ATBypassSel_s1e,
	    "BSBSel",	`B_BYPASS.BSBypassSel_s1e,
	    "BTBSel",	`B_BYPASS.BTBypassSel_s1e,
	    "BWasL",	`B_BYPASS.BWasLoad_s1w,

	    "ADt_s1m",	`A_BPD.AData_s1m,
	    "ADt_s2m",	`A_BPD.AData_s2m,
	    "ADt_s1w",	`A_BPD.AWBData_s1w,

	    "BDt_s1m",	`B_BPD.BData_s1m,
	    "BDt_s2m",	`B_BPD.BData_s2m,
	    "BDt_s1w",	`B_BPD.BData_s1w,

	    "ASDSpec",	`A_BPS.ASDSpec_w,
	    "ATRSpec",	`A_BPS.ATRSpec_w,
	    "BSDSpec",	`B_BPS.BSDSpec_w,
	    "BTRSpec",	`B_BPS.BTRSpec_w,

	    "AD_s1e",	`A_BPS.ADest_s1e,
	    "AD_s2e",	`A_BPS.ADest_s2e,
	    "AD_s1m",	`A_BPS.ADest_s1m,
	    "AD_s2m",	`A_BPS.ADest_s2m,
	    "AD_s1w",	`A_BPS.ADest_s1w,

	    "BD_s1e",	`B_BPS.BDest_s1e,
	    "BD_s2e",	`B_BPS.BDest_s2e,
	    "BD_s1m",	`B_BPS.BDest_s1m,
	    "BD_s2m",	`B_BPS.BDest_s2m,
	    "BD_s1w",	`B_BPS.BDest_s1w
	);



   $define_group_waves(`BYPASS_WAVES_GROUP, "Bypass",
	"Phi1",
	"Phi2",
	"AInstr",
	"BInstr", 
	"ASBus",
	"ATBus", 
	"BSBus",
	"BTBus",
	"Membus",
	"PCBus",
	"ARS",
	"ART",
	"ARD",
	"BRS",
	"BRT",
	"BRD",
	"BWasL",
	"ASBSel",
	"ATBSel",
	"BSBSel",
	"BTBSel",
	"ADt_s1m",
	"ADt_s2m",
	"ADt_s1w",
	"BDt_s1m",
	"BDt_s2m",
	"BDt_s1w",
	"AD_s1e",
	"AD_s2e",
	"AD_s1m",
	"AD_s2m",
	"AD_s1w",
	"BD_s1e",
	"BD_s2e",
	"BD_s1m",
	"BD_s2m",
	"BD_s1w"
    	);
