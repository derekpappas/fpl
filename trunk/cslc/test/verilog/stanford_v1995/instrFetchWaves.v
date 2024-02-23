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
//  Title: 	Instruction Fetch Unit Waves
//  Created:	Wed Apr 13 14:32:01 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  instrFetchWaves.v,v 7.11 1995/01/28 00:48:10 ricardog Exp
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
//	Modified:	Wed Apr 13 17:29:48 1994	<ricardog@chroma>
//	* Changed signal names from _v2r to _s2r.
//

`include "torch.h"

// IFetch Unit signals
	$gr_addwaves(
	    "MMd_s1",		`IFC.MipsMode_s1,
	    "IMis_v2r",		`IFC.ICacheMiss_v2r,
	    "WrI$_s2",		`IFI.WriteData_s2,
	    "WrI$T_s2",		`IFI.WriteTag_s2,
	    "SMD_s1",		`IFD.SharedMemData_s1,
	    "I$InD_s2",		`IFD.ICacheInData_s2,
	    "IDReg_s2",		`IFD.DataReg_s2,
	    "ISReg_s2",		`IFD.ShiftReg_s2,
	    "NChPk_s1",		`IFD.NonCacheablePacket_s1,
	    "NonCh_s2",		`IFC.NonCacheable_s2,
	    "NonCh_s1",		`IFC.NonCacheable_s1,

	    "AD_v1r",		`IFC.ADynamicBit_v1r,
	    "BD_v1r",		`IFC.BDynamicBit_v1r,
	    "HoldPC_s2r",	`IFC.HoldPC_s2r,
	    "Hold_s2r",		`IFC.Hold_s2r,
	    "AIns_v1r",		`IFD.AInstr_v1r,
	    "BIns_v1r",		`IFD.BInstr_v1r,
	    "AInL_s2r",		`IFD.AInstrLatch_s2r,
	    "BInL_s2r",		`IFD.BInstrLatch_s2r,
	    "AIns_s2r",		`IFD.AInstr_s2r,
	    "BIns_s2r",		`IFD.BInstr_s2r,
	    "ADvB_v1r",		`IFC.ADrvB_v1r,
	    "BDvA_v1r",		`IFC.BDrvA_v1r,
	    "2Is_s2r",		`IFC.SecondIssue_s2r,
	    "AKill_s1e",	`IFC.AKill_s1e,
	    "BKill_s1e",	`IFC.BKill_s1e,
	    "KillOne_s1e",	`IFC.KillOne_s1e,
	    "PCO_s1r",		`IFC.PCOffset_s1r,
	    "PCO_s2r",		`IFC.PCOffset_s2r,
	    "Inc_s2e",		`IFC.IncPC_s2e,
	    "MemStall",		`IFC.MemStall_s1,
	    "IStall_s1",	`IFC.IStall_s1,
	    "RISPC_s1",		`IFC.RestoreIStallPC_s1,
	    "IFStall_s1",	`IFC.IFetchStall_s1,
	    "PresSt_s1",	`IFC.PresState_s1,
	    "PrevSt_s2",	`IFC.PrevState_s2,

// PC Unit signals 
	    "Mips_s2e",		`PCU.MipsMode_s2e,
	    "NxtPC_v1e",	`PCU.NextPC_v1r,
	    "PCImmBus_s2r",	`PCU.PCImmedBus_s2r,
	    "PCDrvRes",		`PCU.PCDrvResult_s2e,
	    "PCP_s1r",		`PCU.PCPlus_s1r,
	    "PCP_v2r",		`PCU.PCPlus_v2r,
	    "PCP_s2r",		`PCU.PCPlus_s2r,
	    "BrTarg_s1e",	`PCU.BranchTarget_s1e,
	    "PCC_s1r",		`PCU.PCChain_s1r,
	    "PCC_s2r",		`PCU.PCChain_s2r,
	    "PCC_s1e",		`PCU.PCChain_s1e,
	    "PCC_s2e",		`PCU.PCChain_s2e,
	    "PCC_s1m",		`PCU.PCChain_s1m,
	    "PCC_s2m",		`PCU.PCChain_s2m,
	    "PCC_s1w",		`PCU.PCChain_s1w,
	    "EPC_s2",		`PCU.EPC_s2,
	    "EPCN_s2",		`PCU.EPCN_s2,
	    "PCPsi2_s2",	`PCU.PCUnitPsi2_s2,
	    "IStPC_v1",		`PCU.IStallPC_s1,

	    "match_v2r",	`IFC.Match_v2r,
	    "ITag",		`IFD.ITagPid_s2r[23:1],
	    "PCTag",		`IFD.PCTagPid_v2r,
	    "XX", 0
	);

	$define_group_waves(`IMISS_WAVES_GROUP, "IFTest",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "AIns_s2r",
	    "BIns_s2r",
	    "match_v2r",
	    "PCTag",
	    ""
	);

	$define_group_waves(`IFETCH_WAVES_GROUP, "IFetch",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "AIns_v1r",
	    "BIns_v1r",
	    "AInL_s2r",
	    "BInL_s2r",
	    "AIns_s2r",
	    "BIns_s2r",
	    "Hold_s2r",
	    "ADvB_v1r",
	    "BDvA_v1r",
	    "2Is_s2r", 
	    "AKill_s1e",
	    "BKill_s1e",
	    "KillOne_s1e",
	    "IncPC",
	    "Inc_s2e",
	    "IStall_s1",
	    "MemStall"
	);


	$define_group_waves(`PCUNIT_WAVES_GROUP, "PCUnit",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "AIns_s2r",
	    "BIns_s2r",
	    "HoldPC_s2r",
	    "PCImmBus_s2r",
	    "NxtPC_v1e",
	    "PCP_s1r",
	    "PCP_s2r",
	    "BrTarg_s1e",
	    "ARes",
	    "PCDrvRes",
	    "ASBus",
	    "IncPC",
	    "ImmPC",
	    "RegPC",
	    "AddPC",
	    "MemStall",
	    "IStall_s1",
	    "RISPC_s1",
	    "RetPC_s2e",
	    ""
	);

	$define_group_waves(`PCCHAIN_WAVES_GROUP, "PCChain",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "HoldPC_s2r",
	    "PCC_s1r",
	    "PCC_s2r",
	    "PCC_s1e",
	    "PCC_s2e",
	    "PCC_s1m",
	    "PCC_s2m",
	    "PCC_s1w",
	    "EPC_s2",
	    "EPCN_s2",
	    "IStPC_v1",
	    "PCP_s1r",
	    "PCP_s2r",
	    "MemStall",
	    "IStall_s1",
	    "IncPC",
	    "ImmPC",
	    "RegPC",
	    "AddPC",
	    "RISPC_s1",
	    "Except",
	    "Mips_s2e",
	    ""
	);

	$define_group_waves(`IFILL_WAVES_GROUP, "IDebug",
	    "Phi1",
	    "Phi2",
	    "PCBus",
	    "AIns_s2r",
	    "BIns_s2r",
	    "IVal_v1r",
	    "PresSt_s1",
	    "PrevSt_s2",
	    "IMis_v2r",
	    "WrI$_s2",
	    "WrI$T_s2",
	    "SMD_s1",
	    "I$InD_s2",
	    "IDReg_s2",
	    "ISReg_s2",
	    "NChPk_s1",
	    "NonCh_s2",
	    "NonCh_s1",
	    "IStall_s1",
	    "IFStall_s1",
	    "RISPC_s1",
	    "MemStall",
	    "ARes",
	    "BRes",
	    "Membus",
	    "Except",
	    ""
	);

