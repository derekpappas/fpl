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
//  Title: 	B-side Execute Unit
//  Created:	Nov 24 1991
//  Author: 	David Glasco
//
//
//  BExecuteUnit.v,v 7.14 1995/02/08 01:30:22 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description:
//	    This module contains the control and datapath sections of
//  	    the B-side execute unit. Control signals are generated in
//  	    BALUControl. Datapath sections are completely structural. This
//  	    module also contains the cp0widget that communicates the datapath
//  	    with cp0.
//
//	Hierarchy: system.processor.decodeExec.BExecuteUnit.
//
//  Revision History:
//	Modified:	Sun May 22 16:23:47 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1.
//	Modified:	Fri Apr  8 17:23:04 1994	<ricardog@chroma>
//	* Removed unused inputs from BALUControl.
//	Modified:	Fri Apr  8 15:25:48 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Sun Mar 20 17:50:37 1994	<ricardog@chroma>
//	* Changed module instantiation & cleaned code.
//
`include "torch.h"

module BExecuteUnit(
// Clocks
    Phi1,
    Phi2,
// Stalls
    Stall_s1,
    Stall_s2,
// Inputs
    BKill_s1e,
    BWrong_s1e,
    BSBus_s1e,
    BTBus_s1e, 
    MemAddr_s1m,
    BUseT_s1e,
    BUseImm_s1e,
    BInstr_s2r,
    BImmShift16_s2r,
    BImm26Bit_s2r,
    BImmSigned_s2r,
    BAddOp_s2e,
    BSubOp_s2e,
    BSltOp_s2e,
    BSltUOp_s2e,
    BAndOp_s2e,
    BOrOp_s2e,
    BXorOp_s2e,
    BNorOp_s2e,
    BALUDrv_s2e,
    BAUopSigned_s2e,
    MvToCop0_s1e,
    MvToCop0_s1m,
    MvFromCop0_s1m,
    EPCSel_s1m,
    EPCNSel_s1m,
// Outputs
    BALUOvfl_v2e,
    BResultBus_v2e,
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
// Stalls
//
input		Stall_s1;
input		Stall_s2;

//
// ALU Controls
//
input		BKill_s1e;
input		BWrong_s1e;
input		BUseT_s1e;
input		BUseImm_s1e;
input		BALUDrv_s2e;
input		BAddOp_s2e;
input		BSubOp_s2e;
input		BSltOp_s2e;
input		BSltUOp_s2e;
input		BAndOp_s2e;
input		BOrOp_s2e;
input		BXorOp_s2e;
input		BNorOp_s2e;
input		BAUopSigned_s2e;

//
// immUnit Controls
//
input	[39:0]	BInstr_s2r;
input		BImmShift16_s2r;
input		BImm26Bit_s2r;
input		BImmSigned_s2r;
input		MvToCop0_s1e;
input		MvToCop0_s1m;
input		MvFromCop0_s1m;

//
// Source Values
//
input	[31:0]	BSBus_s1e;
input	[31:0]	BTBus_s1e;
inout	[31:0]	Cp0Bus_s2m;
output	[31:0]	MemBus_v2m;

//
// Cp0 Bus Controls
//
input		EPCSel_s1m;
input		EPCNSel_s1m;

//
// Output Value
//
output	[31:0]	BResultBus_v2e;
output	[31:0]	MemAddr_s1m;
output		BALUOvfl_v2e;

//
// Wires between units
//

//
// ALU control signals
//
wire		MvToCop0_s1e;
wire		MvToCop0_s1m;
wire		BdefaultImm_s2r;
wire		BImmSignExt_s2r;
wire		BselImm_s1e;
wire		BselImmBAR_s1e;
wire		BselT_s1e;
wire		BselTBAR_s1e;
wire		BcarryIn_s2e;
wire		BALUDrv_q2e;
wire		BAddDrv_q2e;
wire		BSetDrv_q2e;
wire		cp0BusDrv_s2m;
wire		BTorImmMsb_s1e;
wire		BAddResMsb_v2e;
wire		BSetRes_v2e;
wire		BcarryOut_v2e;

//
// Control section
//
BALUControl BALUControl(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s1			(Stall_s1),
	.Stall_s2			(Stall_s2),
	.BKill_s1e			(BKill_s1e),
	.BWrong_s1e			(BWrong_s1e),
	.MvToCop0_s1e			(MvToCop0_s1e),
	.MvToCop0_s1m			(MvToCop0_s1m),
	.MvFromCop0_s1m			(MvFromCop0_s1m),
	.EPCSel_s1m			(EPCSel_s1m),
	.EPCNSel_s1m			(EPCNSel_s1m),
	.BALUDrv_s2e			(BALUDrv_s2e),
	.BUseT_s1e			(BUseT_s1e),
	.BUseImm_s1e			(BUseImm_s1e),
	.BAddOp_s2e			(BAddOp_s2e),
	.BSubOp_s2e			(BSubOp_s2e),
	.BSltOp_s2e			(BSltOp_s2e),
	.BSltUOp_s2e			(BSltUOp_s2e),
	.BImm26Bit_s2r			(BImm26Bit_s2r),
	.BImmShift16_s2r		(BImmShift16_s2r),
	.BImmSigned_s2r			(BImmSigned_s2r),
	.BInstr_s2r			(BInstr_s2r[15]),
	.BAUopSigned_s2e		(BAUopSigned_s2e),
	.BSBusMsb_s1e			(BSBus_s1e[31]),
	.BTorImmMsb_s1e			(BTorImmMsb_s1e),
	.BAddResMsb_v2e			(BAddResMsb_v2e),
	.BcarryOut_v2e			(BcarryOut_v2e),
	.MvToCop0_s2m			(MvToCop0_s2m),
	.cp0BusDrv_s2m			(cp0BusDrv_s2m),
	.BdefaultImm_s2r		(BdefaultImm_s2r),
	.BImmSignExt_s2r		(BImmSignExt_s2r),
	.BselImm_s1e			(BselImm_s1e),
	.BselImmBAR_s1e			(BselImmBAR_s1e),
	.BselT_s1e			(BselT_s1e),
	.BselTBAR_s1e			(BselTBAR_s1e),
	.BcarryIn_s2e			(BcarryIn_s2e),
	.BALUDrv_q2e			(BALUDrv_q2e),
	.BAddDrv_q2e			(BAddDrv_q2e),
	.BSetDrv_q2e			(BSetDrv_q2e),
	.BSetRes_v2e			(BSetRes_v2e),
	.BALUOvfl_v2e			(BALUOvfl_v2e),
	.BLatchInputs_s1e		(BLatchInputs_s1e),
	.BenabMemAddrLatch_s2e		(BenabMemAddrLatch_s2e),
	.BenabCop0Latch_s1e		(BenabCop0Latch_s1e),
	.BenabCop0Latch_s2e		(BenabCop0Latch_s2e),
	.BenabCop0Latch_s1m		(BenabCop0Latch_s1m)
	);


//
// ALU
//
BALU BALU(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.Stall_s2			(Stall_s2),
	.BLatchInputs_s1e		(BLatchInputs_s1e),
	.BenabMemAddrLatch_s2e		(BenabMemAddrLatch_s2e),
	.BInstr_s2r			(BInstr_s2r[31:0]),
	.BSBus_s1e			(BSBus_s1e),
	.BTBus_s1e			(BTBus_s1e),
	.BselT_s1e			(BselT_s1e),
	.BselTBAR_s1e			(BselTBAR_s1e),
	.BselImm_s1e			(BselImm_s1e),
	.BselImmBAR_s1e			(BselImmBAR_s1e),
	.BImm26Bit_s2r			(BImm26Bit_s2r),
	.BImmShift16_s2r		(BImmShift16_s2r),
	.BdefaultImm_s2r		(BdefaultImm_s2r),
	.BImmSignExt_s2r		(BImmSignExt_s2r),
	.BcarryIn_s2e			(BcarryIn_s2e),
	.BSetRes_v2e			(BSetRes_v2e),
	.BAndOp_s2e			(BAndOp_s2e),
	.BOrOp_s2e			(BOrOp_s2e),
	.BXorOp_s2e			(BXorOp_s2e),
	.BNorOp_s2e			(BNorOp_s2e),
	.BALUDrv_q2e			(BALUDrv_q2e),
	.BAddDrv_q2e			(BAddDrv_q2e),
	.BSetDrv_q2e			(BSetDrv_q2e),
	.BResultBus_v2e			(BResultBus_v2e),
	.MemAddr_s1m			(MemAddr_s1m),
	.BcarryOut_v2e			(BcarryOut_v2e),
	.BTorImmMsb_s1e			(BTorImmMsb_s1e),
	.BAddResMsb_v2e			(BAddResMsb_v2e)
	);

//
// Co-processor 0 Bus
//
cp0Bus cp0Bus(
	.Phi1				(Phi1),
	.Phi2				(Phi2),
	.BenabCop0Latch_s1e		(BenabCop0Latch_s1e),
	.BenabCop0Latch_s2e		(BenabCop0Latch_s2e),
	.BenabCop0Latch_s1m		(BenabCop0Latch_s1m),
	.MvToCop0_s2m			(MvToCop0_s2m),
	.cp0BusDrv_s2m			(cp0BusDrv_s2m),
	.BTBus_s1e			(BTBus_s1e),
	.MemBus_v2m			(MemBus_v2m),
	.Cp0Bus_s2m			(Cp0Bus_s2m)
	);

endmodule
