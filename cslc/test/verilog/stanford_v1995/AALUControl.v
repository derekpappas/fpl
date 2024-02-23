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
//  Title: 	A-side ALU Control
//  Created:	Nov 22 1992
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  AALUControl.v,v 7.19 1995/08/07 22:38:47 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This module generates all the control signals for the
//  	    A-side ALU and the shifter. Most of the signals come from the
//  	    instruction decoder. Some are latched for a phase or cycle.
//  	    Some small ammount of logic is done to generate the signals.
//
//	Hierarchy: system.processor.decodeExec.AExecuteUnit.AALUControl.
//
//  Revision History:
//	Modified:	Sun May 22 16:20:16 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1.
//	Modified:	Fri Apr  8 15:47:44 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Sun Mar 20 17:49:46 1994	<ricardog@bill>
//	* Moved latches before adder.
//	Modified:	Dec 2 1992	<ricardog@bill>
//	* Added synopsys comments.
//
`include "torch.h"

module AALUControl(
// Clocks
    Phi1,
    Phi2,
// Inputs
    Stall_s1,
    AKill_s1e,
    AWrong_s1e,
    AALUDrv_s2e,
    AUseImm_s1e,
    AUseT_s1e,
    AAddOp_s2e,
    ASubOp_s2e,
    ASltOp_s2e,
    ASltUOp_s2e,
    AAndOp_s2e,
    AOrOp_s2e,
    AXorOp_s2e,
    ANorOp_s2e,
    AImm26Bit_s2r,
    AImmShift16_s2r,
    AImmSigned_s2r,
    AInstr_s2r,
    ASBus_s1e,
// synopsis translate_off
//`ifdef MULTIPLIER
    LoadHiLo_s2e,
    HiLo_s2e,
//`endif
// synopsis translate_on
    AAUopSigned_s2e,
    ATorImmMsb_s1e,
    ASBusMsb_s1e,
    AAddResMsb_v2e,
    AcarryOut_v2e,
    AdefaultImm_s2r,
    AImmSignEx_s2r,
    AselImm_s1e,
    AselImmBAR_s1e,
    AselT_s1e,
    AselTBAR_s1e,
    AcarryIn_s2e,
    AlogicInst_s2e,
//`ifdef MULTIPLIER
// synopsis translate_off
    ldHi_s2e,
    ldLo_s2e,
// synopsis translate_on
//`endif
    AALUDrv_q2e,
    AAddDrv_q2e,
    ASetDrv_q2e,
    ASetRes_v2e,
    AALUOvfl_v2e,
    ShiftAmt_s2e,
    ALatchInputs_s1e
    );

//
// Clock and Stalls
//
input 		Phi1;
input		Phi2;
input		Stall_s1;
input		AKill_s1e;
input		AWrong_s1e;

//
// ALU Controls from instrDecoder
//
input		AALUDrv_s2e;
input		AUseImm_s1e;
input		AUseT_s1e;
input		AAddOp_s2e;
input		ASubOp_s2e;
input		ASltOp_s2e;
input		ASltUOp_s2e;
input		AAndOp_s2e;
input		AOrOp_s2e;
input		AXorOp_s2e;
input		ANorOp_s2e;
input		AImm26Bit_s2r;
input		AImmShift16_s2r;
input		AImmSigned_s2r;
input	[15:6]	AInstr_s2r;
input	[4:0]	ASBus_s1e;
//`ifdef MULTIPLIER
// synopsis translate_off
input		LoadHiLo_s2e, HiLo_s2e;
// synopsis translate_on
//`endif
input		AAUopSigned_s2e;

//
// Frtom the ALU datapath
//
input		ATorImmMsb_s1e;
input		ASBusMsb_s1e;
input		AAddResMsb_v2e;
input		AcarryOut_v2e;

//
// ALU control signals
//
output		AdefaultImm_s2r;
output		AImmSignEx_s2r;
output		AselImm_s1e;
output		AselImmBAR_s1e;
output		AselT_s1e;
output		AselTBAR_s1e;
output		AcarryIn_s2e;
output		AlogicInst_s2e;
output		AALUDrv_q2e;
output		AAddDrv_q2e;
output		ASetDrv_q2e;
//`ifdef MULTIPLIER
// synopsis translate_off
output		ldHi_s2e, ldLo_s2e;
// synopsis translate_on
//`endif

//
// ALU Outputs
//
output 		ASetRes_v2e;
output		AALUOvfl_v2e;
output	[4:0]	ShiftAmt_s2e;
output		ALatchInputs_s1e;

//
// Register declarations
//
reg	[4:0]	ShiftAmt_s2e;
reg		ATorImmMsb_s2e;
reg		ASBusMsb_s2e;
reg		AKill_s2e;
reg	[10:6]	AInstr_s1e;
wire		overflow_v2e;
wire		AsetInst_s2e;

//
// OP type selector
//
assign AsetInst_s2e = ASltOp_s2e | ASltUOp_s2e;	// set instruction
//assign AauInst_s2e  = AAddOp_s2e | ASubOp_s2e;	// arith. unit istr.

//
// Default immediate slector
//
assign AdefaultImm_s2r = ~(AImm26Bit_s2r | AImmShift16_s2r);
assign AImmSignEx_s2r = AInstr_s2r[15] & AImmSigned_s2r;

// logic Unit instruction TO BE MOVED IN THE DECODER
assign AlogicInst_s2e = AAndOp_s2e | AOrOp_s2e | AXorOp_s2e | ANorOp_s2e;

//
// Prevent toggles on killed instructions
//
assign ALatchInputs_s1e = ~AKill_s1e & ~AWrong_s1e & ~Stall_s1;

//
// ALU input mux control
//
assign AselT_s1e      =  AUseT_s1e & ~AUseImm_s1e;
assign AselTBAR_s1e   = ~AUseT_s1e & ~AUseImm_s1e;
assign AselImm_s1e    =  AUseT_s1e &  AUseImm_s1e;
assign AselImmBAR_s1e = ~AUseT_s1e &  AUseImm_s1e;

//
// Carry In control
//
assign AcarryIn_s2e   = ASubOp_s2e | AsetInst_s2e;

//
// Load from Hi/Lo
//`ifdef MULTIPLIER
// synopsis translate_off
assign ldHi_s2e = LoadHiLo_s2e & HiLo_s2e;
assign ldLo_s2e = LoadHiLo_s2e & ~HiLo_s2e;
// synopsis translate_on
//`endif

// Should fix in the decoder --XXXX--
assign AALUDrv_q2e = (AALUDrv_s2e &
			~(AAddOp_s2e | ASubOp_s2e | AsetInst_s2e)) &
			~AKill_s2e & Phi2;
assign AAddDrv_q2e = (AAddOp_s2e | ASubOp_s2e) & ~AKill_s2e & Phi2;
assign ASetDrv_q2e = AsetInst_s2e  & ~AKill_s2e & Phi2;

//
// ALU outputs
// Overflow bit NOT YET COMPLETE
assign overflow_v2e	= ( ATorImmMsb_s2e &  ASBusMsb_s2e & ~AAddResMsb_v2e)|
			  (~ATorImmMsb_s2e & ~ASBusMsb_s2e &  AAddResMsb_v2e);
assign ASetRes_v2e	= ((AAddResMsb_v2e ^ overflow_v2e) & ASltOp_s2e) |
			  (~AcarryOut_v2e & ASltUOp_s2e);
assign AALUOvfl_v2e	= overflow_v2e & ~AKill_s2e & AAUopSigned_s2e;

//
// Latch stuff that needs to be kept until next phase
//
always @(Phi1 or Stall_s1 or AInstr_s1e or ASBus_s1e) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	ShiftAmt_s2e[4:0] = AInstr_s1e[10:6] | ASBus_s1e[4:0];
    end
end

always @(Phi1 or Stall_s1 or AKill_s1e or AWrong_s1e or ATorImmMsb_s1e or
	ASBusMsb_s1e) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	ATorImmMsb_s2e = ATorImmMsb_s1e;
	ASBusMsb_s2e = ASBusMsb_s1e;
	AKill_s2e = AKill_s1e | AWrong_s1e;
    end
end
always @(Phi2 or  AInstr_s2r) begin
    if (Phi2) begin
	`TICK
	AInstr_s1e[10:6] = AInstr_s2r[10:6];
    end
end
// DEBUG code
// synopsys translate_off
// vcheck_off
`ifdef CADENCE
always @(negedge Phi2)
	if (AALUOvfl_v2e == 1'b1) $display("DEBUG: AALU Overflow signalled");
`endif
// synopsys translate_on
// vcheck_on
endmodule

