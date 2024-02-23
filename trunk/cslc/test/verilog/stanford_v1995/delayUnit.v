//
//  Title: 	Delay Unit
//  Created:	Fri Apr  8 17:11:59 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  delayUnit.v,v 7.6 1995/01/28 00:43:20 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1994.
//
//	Description: 
//	    This module delays signals from the time the decoder
//	    generates them until they are wanted by the other parts of
//	    the processor.  It has two main parts, one for latching on
//	    Phi1, and one for latching on Phi2.  This module also uses
//	    the MemStall signal to delay some latching, and kills the
//	    load/stores on BKill or Except if required.
//
//	Hierarchy: 
//
//  Revision History:
//	Modified:	Sun May 22 16:26:14 1994	<ricardog@chroma>
//	* Changed MemStall_s2/IStall_s1 to Stall_s1.
//	Modified:	Fri Apr  8 17:12:34 1994	<ricardog@chroma>
//	* Fixed verilint errors.
//
`include "torch.h"

module delayUnit(Phi1, Phi2, Stall_s1, BKill_s1e, AKill_s1e, Except_s1w,
		PCDrvResult_s1e, PCDrvResult_s2e,
		Syscall_s1e, Syscall_s2m,
		Break_s1e, Break_s2m,
		AIsBoosted_s1e, AIsBoosted_s2e,
		BIsBoosted_s1e, BIsBoosted_s2e,
		BoostedInstr_s1e, BoostedInstr_s1m,
		TLBRead_s1e, TLBRead_s1m,
		TLBWriteI_s1e, TLBWriteI_s1m,
		TLBWriteR_s1e, TLBWriteR_s1m,
		TLBProbe_s1e, TLBProbe_s1m,
		MemOp_s1e, MemOp_s1m,
		MvToCop0_s1e, MvToCop0_s1m,
		MvFromCop0_s1e, MvFromCop0_s1m,
		CopRegNum_v2r, CopRegNum_s1m,
		BIsLoad_s1e, InstrIsLoad_s1m,
		InstrIsStore_s1e, InstrIsStore_s1m);

input Phi1, Phi2, Stall_s1, BKill_s1e, AKill_s1e, Except_s1w;
input	PCDrvResult_s1e;
output	PCDrvResult_s2e;
reg	PCDrvResult_s2e;
input	Syscall_s1e;
output	Syscall_s2m;
reg	Syscall_s2m;
input	Break_s1e;
output	Break_s2m;
reg	Break_s2m;
input	AIsBoosted_s1e;
output	AIsBoosted_s2e;
reg	AIsBoosted_s2e;
input	BIsBoosted_s1e;
output	BIsBoosted_s2e;
reg	BIsBoosted_s2e;
input	BoostedInstr_s1e;
output	BoostedInstr_s1m;
reg	BoostedInstr_s1m;
input	TLBRead_s1e;
output	TLBRead_s1m;
reg	TLBRead_s1m;
input	TLBWriteI_s1e;
output	TLBWriteI_s1m;
reg	TLBWriteI_s1m;
input	TLBWriteR_s1e;
output	TLBWriteR_s1m;
reg	TLBWriteR_s1m;
input	TLBProbe_s1e;
output	TLBProbe_s1m;
reg	TLBProbe_s1m;
input [2:0] MemOp_s1e;
output [2:0] MemOp_s1m;
reg [2:0] MemOp_s1m;
input 	MvToCop0_s1e;
output	MvToCop0_s1m;
reg	MvToCop0_s1m;
input 	MvFromCop0_s1e;
output	MvFromCop0_s1m;
reg	MvFromCop0_s1m;
input   [3:0] CopRegNum_v2r;
output	[3:0] CopRegNum_s1m;
reg	[3:0] CopRegNum_s1m;
input 	BIsLoad_s1e;
output	InstrIsLoad_s1m;
reg	InstrIsLoad_s1m;
input 	InstrIsStore_s1e;
output	InstrIsStore_s1m;
reg	InstrIsStore_s1m;

wire	ACancel_s1e;
wire	BCancel_s1e;
reg	InstrIsLoad_s2e;
reg	InstrIsStore_s2e;
reg [2:0] MemOp_s2e;
reg Syscall_s2e, Syscall_s1m;
reg Break_s2e, Break_s1m;
reg	BoostedInstr_s2e;
reg	TLBRead_s2e;
reg	TLBWriteI_s2e;
reg	TLBWriteR_s2e;
reg	TLBProbe_s2e;
reg	MvToCop0_s2e;
reg	MvFromCop0_s2e;
reg	[3:0] CopRegNum_s1e;
reg	[3:0] CopRegNum_s2e;

// Used for killing load/stores
assign ACancel_s1e = ~(AKill_s1e || Except_s1w);
assign BCancel_s1e = ~(BKill_s1e || Except_s1w);

// Latch on Phi2 to generate s1 signals.
always @(Phi2 or Syscall_s2e or Break_s2e or BoostedInstr_s2e or
	TLBRead_s2e or TLBWriteI_s2e or TLBWriteR_s2e or TLBProbe_s2e or
	MvToCop0_s2e or MvFromCop0_s2e or
	CopRegNum_v2r or CopRegNum_s2e or
	MemOp_s2e or InstrIsLoad_s2e or InstrIsStore_s2e) begin
    if (Phi2) begin
	`TICK
	Syscall_s1m = Syscall_s2e;
	Break_s1m = Break_s2e;
	BoostedInstr_s1m = BoostedInstr_s2e;
	TLBRead_s1m = TLBRead_s2e;
	TLBWriteI_s1m = TLBWriteI_s2e;
	TLBWriteR_s1m = TLBWriteR_s2e;
	TLBProbe_s1m = TLBProbe_s2e;
	MemOp_s1m = MemOp_s2e;
	MvToCop0_s1m = MvToCop0_s2e;
	MvFromCop0_s1m = MvFromCop0_s2e;
	CopRegNum_s1m = CopRegNum_s2e;
	CopRegNum_s1e = CopRegNum_v2r;
	InstrIsLoad_s1m = InstrIsLoad_s2e;
	InstrIsStore_s1m = InstrIsStore_s2e;
    end
end


// Latch on Phi2 to generate s1 signals.
always @(Phi1 or BCancel_s1e or ACancel_s1e or PCDrvResult_s1e or
	Syscall_s1e or Syscall_s1m or
	Break_s1e or Break_s1m or AIsBoosted_s1e or BIsBoosted_s1e or
	TLBRead_s1e or TLBWriteI_s1e or TLBWriteR_s1e or TLBProbe_s1e or
	BoostedInstr_s1e or MemOp_s1e or BIsLoad_s1e or InstrIsStore_s1e or
	CopRegNum_s1e or MvToCop0_s1e or MvFromCop0_s1e or 
	Stall_s1) begin
    if (Phi1 & ~Stall_s1) begin
	`TICK
	PCDrvResult_s2e = PCDrvResult_s1e;
	Syscall_s2e = Syscall_s1e && BCancel_s1e;
	Syscall_s2m = Syscall_s1m;
	Break_s2e = Break_s1e && BCancel_s1e;
	Break_s2m = Break_s1m;
	AIsBoosted_s2e = AIsBoosted_s1e & ACancel_s1e;
	BIsBoosted_s2e = BIsBoosted_s1e & BCancel_s1e;
	BoostedInstr_s2e = BoostedInstr_s1e & BCancel_s1e;
	TLBRead_s2e = TLBRead_s1e && BCancel_s1e;
	TLBWriteI_s2e = TLBWriteI_s1e && BCancel_s1e;
	TLBWriteR_s2e = TLBWriteR_s1e && BCancel_s1e;
	TLBProbe_s2e = TLBProbe_s1e && BCancel_s1e;
	MemOp_s2e = MemOp_s1e;
	MvToCop0_s2e = MvToCop0_s1e && BCancel_s1e;
	MvFromCop0_s2e = MvFromCop0_s1e && BCancel_s1e;
	CopRegNum_s2e = CopRegNum_s1e;
	InstrIsLoad_s2e = BIsLoad_s1e && BCancel_s1e;
	InstrIsStore_s2e = InstrIsStore_s1e && BCancel_s1e;
    end
end

endmodule				  // delayUnit
	
