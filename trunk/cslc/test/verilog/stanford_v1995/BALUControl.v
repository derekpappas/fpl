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
//  Title: 	B-side ALU Control
//  Created:	Nov 22 1992
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  BALUControl.v,v 7.18 1995/08/07 22:38:51 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This module generates all the control signals for the
//  	    B-side ALU. Most of the signals come from the instruction
//  	    decoder. Some are latched for a phase or cycle.
//  	    Some small ammount of logic is done to generate the signals.
//
//	Hierarchy: system.processor.decodeExec.BExecuteUnit.BALUControl
//
//  Revision History:
//	Modified:	Sun May 22 16:22:57 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1.
//	Modified:	Fri Apr  8 17:22:45 1994	<ricardog@chroma>
//	* Removed unused inputs.
//	Modified:	Fri Apr  8 17:17:08 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Sun Mar 20 16:44:49 1994	<ricardog@chroma>
//	* Moved latches before the adder.
//
`include "torch.h"

module BALUControl(
// Clocks
    Phi1,
    Phi2,
// Inputs
    Stall_s1,
    Stall_s2,
    BKill_s1e,
    BWrong_s1e,
    MvToCop0_s1e,
    MvToCop0_s1m,
    MvFromCop0_s1m,
    EPCSel_s1m,
    EPCNSel_s1m,
    BALUDrv_s2e,
    BUseT_s1e,
    BUseImm_s1e,
    BAddOp_s2e,
    BSubOp_s2e,
    BSltOp_s2e,
    BSltUOp_s2e,
    BImm26Bit_s2r,
    BImmShift16_s2r,
    BImmSigned_s2r,
    BInstr_s2r,
    BAUopSigned_s2e,
    BSBusMsb_s1e,
    BTorImmMsb_s1e,
    BAddResMsb_v2e,
    BcarryOut_v2e,
// Outputs
    MvToCop0_s2m,
    cp0BusDrv_s2m,
    BdefaultImm_s2r,
    BImmSignExt_s2r,
    BselImm_s1e,
    BselImmBAR_s1e,
    BselT_s1e,
    BselTBAR_s1e,
    BcarryIn_s2e,
    BALUDrv_q2e,
    BAddDrv_q2e,
    BSetDrv_q2e,
    BSetRes_v2e,
    BALUOvfl_v2e,
    BLatchInputs_s1e,
    BenabMemAddrLatch_s2e,
    BenabCop0Latch_s1e,
    BenabCop0Latch_s2e,
    BenabCop0Latch_s1m
    );

//
// Clock and Stalls
//
input 		Phi1; 
input		Phi2;
input		Stall_s1;
input		Stall_s2;

//
// Cancel instruction
//
input		BKill_s1e;
input		BWrong_s1e;

//
// Control for moving stuff from cp0
//
input		MvToCop0_s1e;
input		MvToCop0_s1m;
input		MvFromCop0_s1m;
input		EPCSel_s1m;
input		EPCNSel_s1m;

//
// ALU Controls from instruction decoder
//
input		BALUDrv_s2e;
input		BUseT_s1e;
input		BUseImm_s1e;
input		BAddOp_s2e;
input		BSubOp_s2e;
input		BSltOp_s2e;
input		BSltUOp_s2e;
input		BImm26Bit_s2r;
input		BImmShift16_s2r;
input		BImmSigned_s2r;
input	[15:15]	BInstr_s2r;
input		BAUopSigned_s2e;

//
// Frtom the ALU datapath
//
input		BTorImmMsb_s1e;
input		BSBusMsb_s1e;
input		BAddResMsb_v2e;
input		BcarryOut_v2e;

// ALU control signals
output		MvToCop0_s2m;
output		cp0BusDrv_s2m;
output		BdefaultImm_s2r;
output		BImmSignExt_s2r;
output		BselImm_s1e;
output		BselImmBAR_s1e;
output		BselT_s1e;
output		BselTBAR_s1e;
output		BcarryIn_s2e;
output		BALUDrv_q2e;
output		BAddDrv_q2e;
output		BSetDrv_q2e;


//
// Latch enables (prevent toggles)
//
output		BLatchInputs_s1e;
output		BenabMemAddrLatch_s2e;
output		BenabCop0Latch_s1e;
output		BenabCop0Latch_s2e;
output		BenabCop0Latch_s1m;

//
// ALU Outputs
//
output 		BSetRes_v2e;
output		BALUOvfl_v2e;

//
// Register declarations
//
reg		BTorImmMsb_s2e;
reg		BSBusMsb_s2e;
reg		BKill_s2e;
reg		EPCSel_s2m;
reg		EPCNSel_s2m;
reg		MvToCop0_s2e;
reg		MvToCop0_s2m;
reg		MvFromCop0_s2m;
wire		overflow_v2e;
wire		BsetInst_s2e;

//
// Control section
//
assign BsetInst_s2e = BSltOp_s2e | BSltUOp_s2e;	// set instruction
//assign BauInst_s2e  = BAddOp_s2e | BSubOp_s2e;	// arith. unit istr.

//
// Default immediate slector
//
assign BdefaultImm_s2r = ~(BImm26Bit_s2r | BImmShift16_s2r);
assign BImmSignExt_s2r = BInstr_s2r[15] & BImmSigned_s2r;

//
// Prevent toggles on killed instructions
//
assign BLatchInputs_s1e = ~(BKill_s1e | BWrong_s1e | Stall_s1);
assign BenabMemAddrLatch_s2e = ~BKill_s2e & ~Stall_s2;
assign BenabCop0Latch_s1e = MvToCop0_s1e & BLatchInputs_s1e;
assign BenabCop0Latch_s2e = MvToCop0_s2e;
assign BenabCop0Latch_s1m = MvToCop0_s1m & ~Stall_s1;

//
// ALU input mux control
//
assign BselT_s1e      =  BUseT_s1e & ~BUseImm_s1e;
assign BselTBAR_s1e   = ~BUseT_s1e & ~BUseImm_s1e;
assign BselImm_s1e    =  BUseT_s1e &  BUseImm_s1e;
assign BselImmBAR_s1e = ~BUseT_s1e &  BUseImm_s1e;

// Carry In control
assign BcarryIn_s2e   = BSubOp_s2e | BsetInst_s2e;

//
// select one of the output drivers
//
assign BALUDrv_q2e = (BALUDrv_s2e &
			~(BAddOp_s2e | BSubOp_s2e | BsetInst_s2e)) &
			~BKill_s2e & Phi2;
assign BAddDrv_q2e = (BAddOp_s2e | BSubOp_s2e) & ~BKill_s2e & Phi2;
assign BSetDrv_q2e = BsetInst_s2e & ~BKill_s2e & Phi2;

//
// ALU outputs
// This will eventually be moved into the datapath. There is probably not
// enough time to drive the signal to the control block and then drive it
// back.
// Overflow bit NOT YET COMPLETE
assign overflow_v2e	= ( BTorImmMsb_s2e &  BSBusMsb_s2e & ~BAddResMsb_v2e)|
			  (~BTorImmMsb_s2e & ~BSBusMsb_s2e &  BAddResMsb_v2e);
assign BSetRes_v2e	= ((BAddResMsb_v2e ^ overflow_v2e) & BSltOp_s2e) |
			  (~BcarryOut_v2e & BSltUOp_s2e);
assign BALUOvfl_v2e	= overflow_v2e & ~BKill_s2e & BAUopSigned_s2e;

//
// Do we need to move something to/from cp0?
//
assign cp0BusDrv_s2m = MvFromCop0_s2m && ~EPCSel_s2m && ~EPCNSel_s2m;

//
// Latch stuff that needs to be kept until next phase
//
always @(Phi1 or Stall_s1 or BTorImmMsb_s1e or BSBusMsb_s1e or
	EPCSel_s1m or EPCNSel_s1m or MvToCop0_s1m or MvFromCop0_s1m or
	BKill_s1e or BWrong_s1e) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	BTorImmMsb_s2e = BTorImmMsb_s1e;
	BSBusMsb_s2e = BSBusMsb_s1e;
	BKill_s2e = BKill_s1e | BWrong_s1e;
	MvToCop0_s2e = MvToCop0_s1e;
	//
	// These signals where not qualified with Stall_s1 before.
	// Is there a reason for this????
	//
	MvToCop0_s2m = MvToCop0_s1m;
	MvFromCop0_s2m = MvFromCop0_s1m;
	EPCSel_s2m = EPCSel_s1m;
	EPCNSel_s2m = EPCNSel_s1m;
    end
end

// DEBUG code
// synopsys translate_off
// vcheck_off
`ifdef CADENCE
always @(negedge Phi2)
	if (BALUOvfl_v2e) $display("DEBUG: BALU Overflow signalled");
`endif
// synopsys translate_on
// vcheck_on
endmodule				  // BALUControl
