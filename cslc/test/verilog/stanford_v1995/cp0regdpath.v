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
//  Title: 	CP0 Register Datapath
//  Created:	Thu Mar 24 16:44:21 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  cp0regdpath.v,v 7.18 1995/01/28 00:41:04 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: 
//
//  Revision History:
//	Modified: Thu Dec  1 21:42:09 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified: Thu Dec  1 21:27:29 1994	<ricardog@chroma.Stanford.EDU>
//	* Added explicit latch enables.
//	Modified: Thu Jul 21 16:23:15 1994	<ricardog@chroma.Stanford.EDU>
//	* Added Squahs bits to Status reg.
//	Modified:	Sun May 22 17:30:58 1994	<ricardog@chroma>
//	* Removed MemStall_s2.
//	Modified:	Fri Apr  8 15:12:17 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:   07-14-92
//	* corrected Cause register bug (rho)
//	Modified:   06-02-92
//	* send IEc_s2 to cp0IntEncoder; 
//	* Initialize Status/Cause on Reset_s2.
//	Modified:   05-25-92
//	* changed MemBus_v2m --> Cp0Bus_v2m, send Cp0Bus_s1w to tlb
//	Modified:   05-05-92
//	* used new structural elements
//	Modified:   04-29-92
//	* used structural latches/muxes.
//	Modified:   04-17-92
//	* fixed StatusStack, current/old bits reversed - R. Ho
//	Modified:   04-13-92
//	* cleaned-up with vcheck; added MemStall_s2 support; 
//	* SetBoost_s1w qualified with ~BrDelaySlot_s1w
//	Modified:   03-24-92
//	* fix status write priority 
//	Modified:   03-19-92
//	* change registers to M-S recirculating latches;
//	* prioritize register writes; change status stack
//	* to read Phi2-MEM/write Phi1-WB; add timing types
//	* to all registers 
//	Modified:   03-05-92
//	* kill register move on exception; interlock @ BSc write;
//	* changed Status Stack shifter to read Phi1/write Phi2 
//
`include "torch.h"
`include "torch.v"

module cp0regdpath(
// Clocks
    Phi2,
    Phi1,
    Stall_s1,
    Stall_s2,
// Inputs
    Cp0Bus_s2m,
    Cp0Bus_s1w,
    tlbAddr_s1w,
    ContextSel_s2m,
    BadVAddrSel_s2m,
    StatusSel_s2m,
    CauseSel_s2m,
    drvCp0Bus_q2m,
    writeContext_s1w,
    defContext_s1w,
    writeCause_s1w,
    defCause_s1w,
    writeStatus_s1w,
    defStatus_s1w,
    newBSc_s1,
    newBEP_s1,
    ExceptionCause_s1w,
    Int_s1,
    Reset_s1,
    Squash_s1w,
    PushStatus_s1w,
    PopStatus_s1w,
    BrDelaySlot_s1w,
    Except_s1w,
    MPc_s2,
    MPp_s2,
    MPo_s2,
    KUc_s2,
    KUp_s2,
    KUo_s2,
    IEc_s2,
    BEP_s2,
    BEV_s1,
    BSp_s2,
    BSc_s2,
    SquashBit_s1,
    IntPending_s2,
    IntMask_s2
    );

//
// Clocks & Stalls
//
input		Phi2;
input		Phi1;
input		Stall_s1;
input		Stall_s2;

//
// Buses
//
inout	[31:0]	Cp0Bus_s2m;		  // Interface w/ exe datapath
output	[31:0]	Cp0Bus_s1w;		  // Interface w/ TLB
input	[31:2]	tlbAddr_s1w;		  // Translated address???

//
// Exception signals
//
input		Reset_s1;
input		Except_s1w;
input	[4:0]	ExceptionCause_s1w;	  // What caused the exception
input	[5:0]	Int_s1;			  // External interrupts

//
// Decoded instructions
//
input		writeContext_s1w;
input		defContext_s1w;
input		writeCause_s1w;
input		defCause_s1w;
input		writeStatus_s1w;
input		defStatus_s1w;
input		newBSc_s1;
input		newBEP_s1;

//
// Other inputs 
//
input		Squash_s1w;		 // Branch wrongly predicted
input		PushStatus_s1w;		 // Exception taken
input		PopStatus_s1w;		 // Return from exception
input		ContextSel_s2m;		 // Drive context reg on cp0 bus
input		BadVAddrSel_s2m;	 // drive the BadVAddr on cp0 bus
input		StatusSel_s2m;		 // drive status reg on cp0 bus
input		CauseSel_s2m;		 // drive cause reg on cp0 bus
input		drvCp0Bus_q2m;		 // 
input		BrDelaySlot_s1w;	 // WB stage of branch delay slot

//
// Outputs
//
output	[1:0]	IntPending_s2;		 // Interrupt pending
output	[7:0]	IntMask_s2;		 // Interrupt mask (turn-off ints)
output		BEV_s1;			 // Boosted exception vector
output		BEP_s2;			 // Boosted exception pending
output		BSp_s2;			 // Boosted code in previous context
output		BSc_s2;			 // Boosted code in current  context
output		MPc_s2;			 // Mips/Torch mode current  context
output		MPp_s2;			 // Mips/Torch mode previous context
output		MPo_s2;			 // Mips/Torch mode old      context
output		KUc_s2;			 // Kernel/User mode current  context
output		KUp_s2;			 // Kernel/User mode previous context
output		KUo_s2;			 // Kernel/User mode old      context
output		SquashBit_s1;		 // Squash bit from previous context
output		IEc_s2;			 // Interrupt Enable Flag

//---------------------------------------------------------------------------
//			     --- Macros ---
//---------------------------------------------------------------------------
//
// Context
//
`define BadVPN	20:2			// Bad Virtual Page Number
`define PTEBase 31:21			// Base address for page table entry

//
// Cause
//
`define BD	31			// branch delay slot
`define CE	29:28			// CopZ number 
`define IPEx	15:10			// external Interrupt
`define IP	9:8			// software Interrupt
`define ExcCode 6:2			// exception cause

//
// Status
//
`define CU	31:28			// CopZ usability 
`define BEP	27			// boosted exception pending 
`define MPo	26			// Mips/Torch mode old context
`define MPp	25			// Mips/Torch mode previous context
`define MPc	24			// Mips/Torch mode current context
`define BEV	23			// use bootstrap exception vectors
`define TS	22			// TLB shutdown
`define SBo	21			// Squash bit in old  context
`define SBp	20			// Squash bit in prev context
`define SBc	19			// Squash bit in curr context
`define BSo	18			// boosted instructs in old context 
`define BSp	17			// boosted instructs in prev context 
`define BSc	16			// boosted instructs in curr context 
`define Hw	15:10			// Hardware interrupt enable mask
`define Sw	9:8			// Software interrupt enable mask
`define KUo	5			// Kernel/User mode in old context 
`define IEo	4			// Interrupts enabled in old context 
`define KUp	3			// Kernel/User mode in prev context 
`define IEp	2			// Interrupts enabled in prev context 
`define KUc	1			// Kernel/User mode in curr context 
`define IEc	0			// Interrupts enabled in curr context 

//
// Reset values
//
`define IStatus	32'hff13		// Initial value for Status register
`define ICause  32'd48			// Initial value for Cause register

//
// internal nodes/variables
//
wire	[31:2]	Context_s1;
wire	[31:2]	Context_s2;
wire	[31:2]	nextContext_s1;
wire	[31:0]	BadVAddr_s1;
wire	[31:0]	BadVAddr_s2; 
wire	[31:0]	nextBadVAddr_s1;

wire	[31:0]	Status_s1;
wire	[31:0]	Status_s2;
wire	[31:0]	nextStatus_s1;
wire	[31:0]	resetStatus_s1;
wire	[31:0]	Cause_s1;
wire	[31:0]	Cause_s2;
wire	[31:0]	nextCause_s1;
wire	[31:0]	resetCause_s1;

wire	[31:0]	MemDrive_s2m; 
wire	[31:0]	Cp0Bus_s1w;

wire	[31:0]	popStatus_s1;
wire	[31:0]	pushStatus_s1;
wire	[31:0]	miscStatus_s1;
wire	[31:0]	writeStatus_s1;

//
// Interrupts
//
assign IntPending_s2  = Cause_s2[`IP];
assign IntMask_s2 = {Status_s2[`Hw], Status_s2[`Sw]};

//
// Contents of status registers needed in control block
//
assign BEV_s1 = Status_s1[`BEV];
assign BEP_s2 = Status_s2[`BEP];
assign BSp_s2 = Status_s2[`BSp];
assign BSc_s2 = Status_s2[`BSc];
assign MPc_s2 = Status_s2[`MPc];
assign MPp_s2 = Status_s2[`MPp]; 
assign MPo_s2 = Status_s2[`MPo];
assign KUc_s2 = Status_s2[`KUc]; 
assign KUp_s2 = Status_s2[`KUp]; 
assign KUo_s2 = Status_s2[`KUo];
assign IEc_s2 = Status_s2[`IEc];
assign SquashBit_s1 = Status_s1[`SBp];

//
// Delay contents of interface bus till next phase for TLB
//
PHI2_LATCH_EN_32	Cp0Bus_1(Cp0Bus_s1w, Cp0Bus_s2m, Phi2, ~Stall_s2);

//
// Move From CP0 registers to GP registers
//
MUX4_32		Memmux(MemDrive_s2m,
			{Context_s2, 2'b0}, BadVAddr_s2,
			Status_s2, Cause_s2,
			ContextSel_s2m, BadVAddrSel_s2m,
			StatusSel_s2m, CauseSel_s2m); 
TRIBUF_32	MemBuf(Cp0Bus_s2m, MemDrive_s2m, drvCp0Bus_q2m);


//
// Bad Virtual Address Register - Read Only  
//
PHI1_LATCH_EN_32	BVAddr_2(BadVAddr_s2, nextBadVAddr_s1, Phi1, ~Stall_s1);
PHI2_LATCH_EN_32	BVAddr_1(BadVAddr_s1, BadVAddr_s2, Phi2, ~Stall_s2);

MUX2_32		BVMux2(nextBadVAddr_s1,
			{tlbAddr_s1w, 2'b0}, BadVAddr_s1,
			Except_s1w); 

//
// Context Register
//
PHI1_LATCH_EN_30	Context_2(Context_s2, nextContext_s1, Phi1, ~Stall_s1);
PHI2_LATCH_EN_30	Context_1(Context_s1, Context_s2, Phi2, ~Stall_s2);

MUX3_30		ContextMux1(nextContext_s1, 
			{Context_s1[`PTEBase], tlbAddr_s1w[30:12]},
			{Cp0Bus_s1w[`PTEBase], Context_s1[`BadVPN]},
			{Context_s1[31:2]},
			Except_s1w, writeContext_s1w, defContext_s1w);

//
// Cause Register
//
PHI1_LATCH_EN_32	CauseLatch_s2(Cause_s2, resetCause_s1, Phi1, ~Stall_s1);
PHI2_LATCH_EN_32	CauseLatch_s1(Cause_s1, Cause_s2, Phi2, ~Stall_s2);

MUX3_32		CauseMux(nextCause_s1,
			{BrDelaySlot_s1w, 15'b0, Int_s1, Cause_s1[9:8], 1'b0, 
			    ExceptionCause_s1w[4:0], 2'b0},
			{Cause_s1[31], 15'b0, Int_s1, Cause_s1[9:8], 1'b0,
			    Cause_s1[6:2], 2'b0},
			{Cause_s1[31:10], Cp0Bus_s1w[9:8], Cause_s1[7:0]},
			Except_s1w, defCause_s1w, writeCause_s1w);

MUX2_32		CauseReset(resetCause_s1,
			`ICause, nextCause_s1,
			Reset_s1);
			
//
// Status Register
//
PHI1_LATCH_EN_32	Status_2(Status_s2, resetStatus_s1, Phi1, ~Stall_s1);
PHI2_LATCH_EN_32	Status_1(Status_s1, Status_s2, Phi2, ~Stall_s2);
MUX4_32		StatusMux(nextStatus_s1,
			popStatus_s1, pushStatus_s1,
			writeStatus_s1, miscStatus_s1,
			PopStatus_s1w, PushStatus_s1w,
			writeStatus_s1w, defStatus_s1w);
MUX2_32		StatusReset(resetStatus_s1,
			`IStatus, nextStatus_s1,
			Reset_s1);

assign popStatus_s1 = {Status_s1[`CU],
			Status_s1[`BSp],		// BEP
			1'b0, Status_s1[`MPo:`MPp],	// MP bits
			Status_s1[`BEV],		// BEV and TS
			Status_s1[`TS],			// BEV and TS
			1'b0, Status_s1[`SBo:`SBp],		// Squash bits
			1'b0, Status_s1[`BSo:`BSp],	// BS bits
			Status_s1[`Hw],			// HW interrupt mask
			Status_s1[`Sw],			// SW interrupt mask
			Status_s1[7:6],			// Unused
			2'b0, Status_s1[`KUo:`IEp]	// KU and Ep bits
			};

assign pushStatus_s1 = {Status_s1[`CU],
			Status_s1[`BEP],		// BEP
			Status_s1[`MPp:`MPc], 1'b0,	// MP bits
			Status_s1[`BEV],		// BEV
			Status_s1[`TS],			// TS
			Status_s1[`SBp], Squash_s1w, 1'b0,	// Unused
			Status_s1[`BSp], newBSc_s1, 1'b0,	// BS bits
			Status_s1[`Hw],			// HW interrupt mask
			Status_s1[`Sw],			// SW interrupt mask
			Status_s1[7:6],			// Unused
			Status_s1[`KUp:`IEc], 2'b00	// KU and Ep bits
			};

assign writeStatus_s1 = {Status_s1[`CU],
			Cp0Bus_s1w[27:8],
			Status_s1[7:6],			// Unused
			Cp0Bus_s1w[5:0]
			};

assign miscStatus_s1 = {Status_s1[`CU],
			newBEP_s1,			// BEP
			Status_s1[`MPo:`MPc],		// MP bits
			Status_s1[`BEV],		// BEV
			Status_s1[`TS],			// TS
			Status_s1[`SBo:`SBc],		// Squash bits
			Status_s1[`BSo:`BSp], newBSc_s1,// BS bits
			Status_s1[`Hw],			// HW interrupt mask
			Status_s1[`Sw],			// SW interrupt mask
			Status_s1[7:6],			// Unused
			Status_s1[`KUo:`IEc]		// KU and Ep bits
			};

endmodule				  // cp0regdpath
