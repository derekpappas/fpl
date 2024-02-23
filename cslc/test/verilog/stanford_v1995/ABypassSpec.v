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
//  Title: 	A-side Register Specifier Bypass
//  Created:	Feb 20 1992
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@bill>
//
//
//  ABypassSpec.v,v 7.21 1995/08/07 22:40:36 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1992.
//
//	Description: This modul contains the hardware needed to do bypass
//  	    detection. It also contains some random logic needed to deal 
//  	    with ponging, exceptions and such stuff. Anything related to the
//  	    register specifiers should be in here. The modul compare conatins
//  	    a set of four specifier comparators.
//
//  	Hierarchy: system.processor.regFile.ABypass
//
//  Revision History:
//	Modified: Thu Dec  1 21:59:50 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//	Modified:	Sat May 28 15:49:52 1994	<ricardog@chroma>
//	* Qualify load data latch with IStall_s2.
//	Modified:	Sun May 22 16:44:18 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1.
//	Modified:	Sun Apr 10 15:26:33 1994	<ricardog@chroma>
//	* New file for A-side only (derived from bypassSpec).
//	Modified:	Sat Apr  9 17:20:42 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//	Modified:	Tue Mar 29 19:01:36 1994	<ricardog@chroma>
//	* Changed signal names and moved macros.
//
`include "torch.h"

module ABypassSpec(
    Phi1,
    Phi2, 
    ARSSpec_s2r,
    ARTSpec_s2r,
    ARDSpec_s2r,
    BRTSpec_s2r,
    BRDSpec_s2r,
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
    Alpha2_s2e,
    Alpha1_s1m,
    Alpha2_s2m,
    Beta2_s2e,
    Beta1_s1m,
    Beta2_s2m,
    Delta2_q2,
    ASDSpec_w,
    ATRSpec_w,
    ASBypassLoad_s1e,
    ATBypassLoad_s1e,
    ASBypassLoad_b_s1e,
    ATBypassLoad_b_s1e,
    ASBypassSel_s1e,
    ATBypassSel_s1e
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
// Register specifiers (from instruction)
//
input	[5:0]	ARSSpec_s2r;
input	[5:0]	ARTSpec_s2r;
input	[5:0]	ARDSpec_s2r;
input	[5:0]	BRTSpec_s2r;
input	[5:0]	BRDSpec_s2r;

//
// Destination register specifier selector
//
input		ADestIsRD_s1e, ADestIsRT_s1e, ADestIs31_s1e;
input		BDestIsRD_s1e, BDestIsRT_s1e, BIsLoad_s1e;

//
// Boosting information
//
input		ADestPtr_v1e;		 // which phys reg to WB to
input		ADestBoostValid_v1e;	 // this reg has been written as boost
input		BDestPtr_v1e;		 // which phys reg to WB to
input		BDestBoostValid_v1e;	 // this reg has been written as boost

//
// Instruction WB cancell
//
input		AKill_s1e;		 // A-side instruction is bogus
input		AIgnore_s2e;		 // inst issued to both sides, A is bad
input		BKill_s1e;		 // B-side instruction is bogus
input		BIgnore_s2e;		 // inst issued to both sides, B is bad

//
// Branches & Exceptions
//
input		Commit_s1e;
input		Squash_s1e;
input		Except_s1w;


//--------------------------------------------------------------------------
//                      ---- Outputs ----
//--------------------------------------------------------------------------
output		Alpha2_s2e;		 // Qualified clock for A datapath
output		Alpha1_s1m;		 // Qualified clock for A datapath
output		Alpha2_s2m;		 // Qualified clock for A datapath
output		Beta2_s2e;		 // Qualified clock for B datapath
output		Beta1_s1m;		 // Qualified clock for B datapath
output		Beta2_s2m;		 // Qualified clock for B datapath
output		Delta2_q2;		 // Qualified clock Phi2 & ~IStall
output	[7:0]	ASDSpec_w;		 // specifiers for RF read/write
output	[6:0]	ATRSpec_w;		 // specifiers for RF read/read
output		ASBypassLoad_s1e;	 // select for load bypass fast mux
output		ASBypassLoad_b_s1e;	 // same but opposite polarity
output		ATBypassLoad_s1e;	 // Same again but now for T bus
output		ATBypassLoad_b_s1e;	 // 
output	[4:0]	ASBypassSel_s1e;	 // 5-bit bypass mux control lines
output	[4:0]	ATBypassSel_s1e;	 // S & T buses (A-side)


//
// Destination register specifier chains
//
wire	[5:0]	ARTSpec_s1e;
wire	[5:0]	ARDSpec_s1e;

wire	[8:0]	ADest_s1e;
wire	[8:0]	ADest_s2e;
wire	[8:0]	ADest_s1m;
wire	[8:0]	ADest_s2m;
wire	[8:0]	ADest_s1w;

wire	[5:0]	BRTSpec_s1e;
wire	[5:0]	BRDSpec_s1e;

wire	[9:0]	BDest_s1e;
wire	[9:0]	BDest_s2e;
wire	[9:0]	BDest_s1m;
wire	[9:0]	BDest_s2m;
wire	[9:0]	BDest_s1w;

//
// These registers are used to behaviorally model "random" logic needed.
//
reg	[8:0]	ADest_v1e;
reg	[8:0]	ADest_v2e;
reg	[8:0]	ADest_v1m;
reg	[9:0]	BDest_v1e;
reg	[9:0]	BDest_v2e;
reg	[9:0]	BDest_v1m;

//
// Delayed version of Stall
//
reg		IStall_s2;
reg		MemStall_s2;

wire	[4:0]	ASBypassSel_v2r;
wire	[4:0]	ATBypassSel_v2r;

wire	[4:0]	ASBypassSel_s1e;
wire	[4:0]	ATBypassSel_s1e;

//
// For clock qualification
//
wire		Delta2_q2;

//
// random logic signals
//
wire	    ANoDest_s1e;		 // No destination for WB. Should
wire	    BNoDest_s1e;		 // really be in the decoders
wire	    ADestValid_s1e;		 // Valid bit for WB to register file
wire	    BDestValid_s1e;
wire	    ADestIsZero_v1e;
wire	    BDestIsZero_v1e;
wire	    BWasLoad_s1w;

//
// Kill Chain
//
reg	    AKill_s2e;
reg	    AKill_s1m;
reg	    BKill_s2e;
reg	    BKill_s1m;

//--------------------------------------------------------------------------
//                    ---- Control Logic ----
//--------------------------------------------------------------------------
//
// Qualify the clocks
//
assign Delta2_q2 = (~IStall_s2 & BDest_s2m[`LOAD_BIT]) & Phi2;

//
// If no source set BNoDest_s1e and ANoDest_s1e;
//
assign ANoDest_s1e = ~(ADestIsRD_s1e | ADestIsRT_s1e | ADestIs31_s1e);
assign BNoDest_s1e = ~(BDestIsRD_s1e | BDestIsRT_s1e);

//
// Kill WB if instr is bogus or no destination (more reasons later)
//
assign ADestValid_s1e = ~(AKill_s1e | ANoDest_s1e);
assign BDestValid_s1e = ~(BKill_s1e | BNoDest_s1e);

//
// If B-side instr was a load do some special processing. Also don't
// drive the source operand busses if the instruction is being killed.
//
assign BWasLoad_s1w = BDest_s1w[`LOAD_BIT];

assign ASBypassLoad_s1e = ASBypassSel_s1e[`BYPASS_BMEM_BIT] & BWasLoad_s1w
			& ~AKill_s1e;
assign ATBypassLoad_s1e = ATBypassSel_s1e[`BYPASS_BMEM_BIT] & BWasLoad_s1w
			& ~AKill_s1e;
assign ASBypassLoad_b_s1e = ~(ASBypassSel_s1e[`BYPASS_BMEM_BIT] & BWasLoad_s1w)
			& ~AKill_s1e;
assign ATBypassLoad_b_s1e = ~(ATBypassSel_s1e[`BYPASS_BMEM_BIT] & BWasLoad_s1w)
			& ~AKill_s1e;

//--------------------------------------------------------------------------
//                   ---- Bypass Compares ----
//--------------------------------------------------------------------------
//
// Do all the bypass compares The module will return a 1-hot signal used to
// drive the bypass mux
//
compares ARSCompare ({`VALID, ARSSpec_s2r},
                ADest_s2e[`VALID_BIT:0], ADest_s2m[`VALID_BIT:0],
    	    	BDest_s2e[`VALID_BIT:0], BDest_s2m[`VALID_BIT:0],
                ASBypassSel_v2r);

compares ARTCompare ({`VALID, ARTSpec_s2r},
                ADest_s2e[`VALID_BIT:0], ADest_s2m[`VALID_BIT:0],
    	    	BDest_s2e[`VALID_BIT:0], BDest_s2m[`VALID_BIT:0],
                ATBypassSel_v2r);

//
// Now latch the control signals so they can be used in the beginning of
// next phase.
//
PHI2_LATCH_EN_5 ASBypassSel_S1E(ASBypassSel_s1e, ASBypassSel_v2r,
			Phi2, ~Stall_s2);
PHI2_LATCH_EN_5 ATBypassSel_S1E(ATBypassSel_s1e, ATBypassSel_v2r,
			Phi2, ~Stall_s2);


//--------------------------------------------------------------------------
//                  ---- Register File Signals ----
//--------------------------------------------------------------------------
//  On phi1 the decoders are used for the WB and the result read/write
//  On phi2 they are used for the register file acces
//
MUX2_8 ASDSpec_W(ASDSpec_w, ADest_s1w[7:0],
			{`DONT_CARE, `NOT_VALID, ARSSpec_s2r}, Phi1);

MUX2_7 ATRSpec_W(ATRSpec_w, {ADestValid_s1e, ADest_s1e[5:0]},
			{`NOT_VALID, ARTSpec_s2r}, Phi1);

//--------------------------------------------------------------------------
//                    ---- Destination Chain ----
// I am trying to mix a structural and behavioral definitions. The 
// latches are all explicitly declared, but all the good stuff, i.e. 
// all the logic between stages is contained in always blocks.
// This way I can keep the behavioral definition of the logic, and have a
// more strutural file.
//--------------------------------------------------------------------------


//--------------------------------------------------------------------------
//                          ---- A-side ----
//--------------------------------------------------------------------------
//
// From RF-2 to EX-1
//
PHI2_LATCH_EN_6	ARTSpec_S1E(ARTSpec_s1e, ARTSpec_s2r, Phi2, ~Stall_s2);
PHI2_LATCH_EN_6	ARDSpec_S1E(ARDSpec_s1e, ARDSpec_s2r, Phi2, ~Stall_s2);
MUX4_9 ADest_V2R(ADest_s1e,
		9'b0,
		{`DONT_CARE, `DONT_CARE, `VALID, 1'b0, 5'd31},
		{`DONT_CARE, `DONT_CARE, `VALID, ARTSpec_s1e},
		{`DONT_CARE, `DONT_CARE, `VALID, ARDSpec_s1e},
		ANoDest_s1e, ADestIs31_s1e, ADestIsRT_s1e, ADestIsRD_s1e);
//
// From EX-1 to EX-2
//
COMP_5 ADestIsZero(ADestIsZero_v1e, ADest_s1e[`SPEC_BIT:0], 5'b0);
PHI1_LATCH_EN_9 ADest_S2E(ADest_s2e, ADest_v1e, Phi1, ~Stall_s1);

//
// From EX-2 to MEM-1
//
PHI2_LATCH_EN_9 ADest_S1M(ADest_s1m, ADest_v2e, Phi2, ~Stall_s2);

//
// From MEM-1 to MEM-2
//
PHI1_LATCH_EN_9 ADest_S2M(ADest_s2m, ADest_v1m, Phi1, ~Stall_s1);

//
// From MEM-2 to WB-1
//
PHI2_LATCH_EN_9 ADest_S1W(ADest_s1w, ADest_s2m, Phi2, ~Stall_s2);


//--------------------------------------------------------------------------
//                        ---- B-side ----
//--------------------------------------------------------------------------
//
// From RF-2 to EX-1
//
PHI2_LATCH_EN_6	BRTSpec_S1E(BRTSpec_s1e, BRTSpec_s2r, Phi2, ~Stall_s2);
PHI2_LATCH_EN_6	BRSSpec_S1E(BRDSpec_s1e, BRDSpec_s2r, Phi2, ~Stall_s2);
MUX3_10	BDest_V2R(BDest_s1e,
		10'b0,
		{`DONT_CARE, `DONT_CARE, `DONT_CARE, `VALID, BRTSpec_s1e},
		{`DONT_CARE, `DONT_CARE, `DONT_CARE, `VALID, BRDSpec_s1e},
		BNoDest_s1e, BDestIsRT_s1e, BDestIsRD_s1e);
//
// From EX-1 to EX-2
//
COMP_5 BDestIsZero(BDestIsZero_v1e, BDest_s1e[`SPEC_BIT:0], 5'b0);
PHI1_LATCH_EN_10 BDest_S2E(BDest_s2e, BDest_v1e, Phi1, ~Stall_s1);

//
// From EX-2 to MEM-1
//
PHI2_LATCH_EN_10 BDest_S1M(BDest_s1m, BDest_v2e, Phi2, ~Stall_s2);

//
// From MEM-1 to MEM-2
//
PHI1_LATCH_EN_10 BDest_S2M(BDest_s2m, BDest_v1m, Phi1, ~Stall_s1);

//
// From MEM-2 to WB-1
//
PHI2_LATCH_EN_10 BDest_S1W(BDest_s1w, BDest_s2m, Phi2, ~Stall_s2);


//--------------------------------------------------------------------------
//			 ---- Delay IStall ----
//--------------------------------------------------------------------------
always @(Phi1 or IStall_s1 or MemStall_s1) begin
    if (Phi1) begin
	`TICK
	IStall_s2 = IStall_s1;
	MemStall_s2 = MemStall_s1;
    end
end

//--------------------------------------------------------------------------
//			 ---- Random Logic ----
//--------------------------------------------------------------------------

always @(ADest_s1e or ADestIsZero_v1e or ADestValid_s1e or ADestPtr_v1e or
	ADestBoostValid_v1e or Except_s1w or Commit_s1e or
	Squash_s1e) begin
    ADest_v1e[`SPEC_BIT:0]	= ADest_s1e[`SPEC_BIT:0];
    ADest_v1e[`HARD_DEST_BIT]	= ADestPtr_v1e;
    ADest_v1e[`VALID_BIT] = ADestValid_s1e & ~(ADestIsZero_v1e | Except_s1w);
    ADest_v1e[`BOOST_BIT] = ADest_s1e[`BOOST_BIT] & ~Commit_s1e;
    ADest_v1e[`BOOST_VALID_BIT] = ADestBoostValid_v1e & 
	~(Commit_s1e | Squash_s1e);
//
// Clear valid bit if: RD == 0, RD is not valid, or exception happens.
//
//    if(ADestIsZero_v1e == 1'b1 | ADestValid_s1e == 1'b0 | Except_s1w == 1'b1)
//	ADest_v1e[`VALID_BIT] = `NOT_VALID;
//    else
//	ADest_v1e[`VALID_BIT] = ADest_s1e[`VALID_BIT];
//
// If commit happens do a pong, and if squqsh clear boost and boost valid bit.
//
//    if (Commit_s1e == 1'b1 && ADestBoostValid_v1e == `VALID) begin
//	ADest_v1e[`BOOST_BIT] = ADest_s1e[`BOOST_BIT] ^ 1'b1;
//	ADest_v1e[`BOOST_VALID_BIT] = `NOT_VALID;  // Dont pong again
//    end
//    else if(Squash_s1e) begin
//	ADest_v1e[`BOOST_BIT] = ADest_s1e[`BOOST_BIT];
//	ADest_v1e[`BOOST_VALID_BIT] = `NOT_VALID;  // not valid
//    end
//    else begin
//	ADest_v1e[`BOOST_BIT] = ADest_s1e[`BOOST_BIT]; // keep values
//	ADest_v1e[`BOOST_VALID_BIT] = ADestBoostValid_v1e;
//    end
end


always @(ADest_s2e or AIgnore_s2e) begin
    ADest_v2e[`SPEC_BIT:0]  	= ADest_s2e[`SPEC_BIT:0];
    ADest_v2e[`BOOST_BIT]   	= ADest_s2e[`BOOST_BIT];
    ADest_v2e[`HARD_DEST_BIT]	= ADest_s2e[`HARD_DEST_BIT];
    ADest_v2e[`BOOST_VALID_BIT]	= ADest_s2e[`BOOST_VALID_BIT];
    ADest_v2e[`VALID_BIT]       = ADest_s2e[`VALID_BIT] & ~AIgnore_s2e;
end


always @(ADest_s1m or Except_s1w or Commit_s1e or Squash_s1e) begin
    ADest_v1m[`SPEC_BIT:0]  	= ADest_s1m[`SPEC_BIT:0];
    ADest_v1m[`HARD_DEST_BIT]	= ADest_s1m[`HARD_DEST_BIT];
    ADest_v1m[`VALID_BIT]	= ADest_s1m[`VALID_BIT] & ~Except_s1w;
    ADest_v1m[`BOOST_BIT] = ADest_s1m[`BOOST_BIT] ^
	    (Commit_s1e & ADest_s1m[`BOOST_BIT]);
    ADest_v1m[`BOOST_VALID_BIT] = ADest_s1m[`BOOST_VALID_BIT] & 
	    ~(Commit_s1e | Squash_s1e);
//
// If commit happens do a pong, and if squash clear boost and boost valid bit.
//
//    if (Commit_s1e == 1'b1 && ADest_s1m[`BOOST_VALID_BIT] == `VALID) begin
//	ADest_v1m[`BOOST_BIT] = ADest_s1m[`BOOST_BIT] ^ 1'b1;
//	ADest_v1m[`BOOST_VALID_BIT] = `NOT_VALID;  // Dont pong again
//    end
//    else if(Squash_s1e == 1'b1) begin
//	ADest_v1m[`BOOST_BIT] = ADest_s1m[`BOOST_BIT];
//	ADest_v1m[`BOOST_VALID_BIT] = `NOT_VALID;  // not valid
//    end
//    else begin
//	ADest_v1m[`BOOST_BIT] = ADest_s1m[`BOOST_BIT];
//	ADest_v1m[`BOOST_VALID_BIT] = ADest_s1m[`BOOST_VALID_BIT];
//    end
end


always @(BDest_s1e or BDestIsZero_v1e or BDestValid_s1e or BDestPtr_v1e or
	BDestBoostValid_v1e or Except_s1w or Commit_s1e or Squash_s1e or
	BIsLoad_s1e) begin
    BDest_v1e[`SPEC_BIT:0]  	= BDest_s1e[`SPEC_BIT:0];
    BDest_v1e[`HARD_DEST_BIT]	= BDestPtr_v1e;
    BDest_v1e[`LOAD_BIT]  	= BIsLoad_s1e;
    BDest_v1e[`VALID_BIT] = BDestValid_s1e & ~(BDestIsZero_v1e | Except_s1w);
    BDest_v1e[`BOOST_BIT] = BDest_s1e[`BOOST_BIT] & ~Commit_s1e;
    BDest_v1e[`BOOST_VALID_BIT] = BDestBoostValid_v1e &
	    ~(Commit_s1e | Squash_s1e);
//
// Clear valid bit if: RD == 0, RD is not valid, or exception happens.
//
//    if(BDestIsZero_v1e == 1'b1 | BDestValid_s1e == 1'b0 | Except_s1w == 1'b1)
//        BDest_v1e[`VALID_BIT] = `NOT_VALID;
//    else
//    	BDest_v1e[`VALID_BIT] = BDest_s1e[`VALID_BIT];
//
//
// If commit happens do a pong, and if squash clear boost and boost valid bit.
//
//    if(Commit_s1e == 1'b1 && BDestBoostValid_v1e == `VALID) begin
//	BDest_v1e[`BOOST_BIT] = BDest_s1e[`BOOST_BIT] ^ 1'b1;
//	BDest_v1e[`BOOST_VALID_BIT] = `NOT_VALID;  // Dont pong again
//    end
//    else if(Squash_s1e == 1'b1) begin
//	BDest_v1e[`BOOST_BIT] = BDest_s1e[`BOOST_BIT];
//	BDest_v1e[`BOOST_VALID_BIT] = `NOT_VALID;  // Not valid
//    end
//    else begin
//	BDest_v1e[`BOOST_BIT] = BDest_s1e[`BOOST_BIT];
//	BDest_v1e[`BOOST_VALID_BIT] = BDestBoostValid_v1e;
//    end
end


always @(BDest_s2e or BIgnore_s2e) begin
    BDest_v2e[`SPEC_BIT:0]  	= BDest_s2e[`SPEC_BIT:0];
    BDest_v2e[`BOOST_BIT]   	= BDest_s2e[`BOOST_BIT];
    BDest_v2e[`HARD_DEST_BIT]	= BDest_s2e[`HARD_DEST_BIT];
    BDest_v2e[`BOOST_VALID_BIT]	= BDest_s2e[`BOOST_VALID_BIT];
    BDest_v2e[`LOAD_BIT]    	= BDest_s2e[`LOAD_BIT];
    BDest_v2e[`VALID_BIT]	= BDest_s2e[`VALID_BIT] & ~BIgnore_s2e;
end


always @(BDest_s1m or Except_s1w or Commit_s1e or Squash_s1e) begin
    BDest_v1m[`SPEC_BIT:0]  	= BDest_s1m[`SPEC_BIT:0];
    BDest_v1m[`VALID_BIT]   	= BDest_s1m[`VALID_BIT];
    BDest_v1m[`HARD_DEST_BIT]	= BDest_s1m[`HARD_DEST_BIT];
    BDest_v1m[`LOAD_BIT]    	= BDest_s1m[`LOAD_BIT];
    BDest_v1m[`VALID_BIT]	= BDest_s1m[`VALID_BIT] & ~Except_s1w;
    BDest_v1m[`BOOST_BIT] = BDest_s1m[`BOOST_BIT] ^
	    (Commit_s1e & BDest_s1m[`BOOST_VALID_BIT]);
    BDest_v1m[`BOOST_VALID_BIT] = BDest_s1m[`BOOST_VALID_BIT] &
	    ~(Commit_s1e | Squash_s1e);
//
// If commit happens do a pong, and if squash clear boost and boost valid bit. 
//
//    if(Commit_s1e == 1'b1 && BDest_s1m[`BOOST_VALID_BIT] == `VALID) begin
//	BDest_v1m[`BOOST_BIT] = BDest_s1m[`BOOST_BIT] ^ 1'b1;
//	BDest_v1m[`BOOST_VALID_BIT] = `NOT_VALID;  // Dont pong again
//    end
//    else if(Squash_s1e == 1'b1) begin
//	BDest_v1m[`BOOST_BIT] = BDest_s1m[`BOOST_BIT];
//	BDest_v1m[`BOOST_VALID_BIT] = `NOT_VALID;  // Not valid
//    end
//    else begin
//	BDest_v1m[`BOOST_BIT] = BDest_s1m[`BOOST_BIT]; // keep values
//	BDest_v1m[`BOOST_VALID_BIT] = BDest_s1m[`BOOST_VALID_BIT];
//    end
end

//---------------------------------------------------------------------------
//			   --- Kill Chain ---
//---------------------------------------------------------------------------
//
// Don't toggle datapath latches if instruction was killed
//
assign Alpha2_s2e = ADest_s2e[`VALID_BIT] & ~Stall_s2;
assign Alpha1_s1m = ADest_s1m[`VALID_BIT] & ~Stall_s1;
assign Alpha2_s2m = ADest_s2m[`VALID_BIT] & ~Stall_s2;

assign Beta2_s2e = BDest_s2e[`VALID_BIT] & ~Stall_s2;
assign Beta1_s1m = BDest_s1m[`VALID_BIT] & ~Stall_s1;
assign Beta2_s2m = BDest_s2m[`VALID_BIT] & ~Stall_s2;

endmodule				 // bypassSpec

