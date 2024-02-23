//
// Module:	Torch
//
// Generated:	Thu Mar 24 17:55:07 1994
// From:	NewGlobalSignals
// Using:	/chroma/c1/ricardog/bin/interface
// Revision:	$Revision: 1.4 
//
//
module Torch (
// input   
    PadBusError_v2,
    PadClock,
    PadReset_ww,
    PadInterrupt_ww,
    PadL2Tag_v2,
    PadL2Valid_v2,
    PadReqICache_s1,
    PadReqDCache_s1,
    PadReqBus_s1,
    PadConfigIn,
// output  
    PadLength_s1,
    PadAddrValid_s1,
    PadWrite_s1,
    PadNonCacheable_s1,
    PadL1Hit_s1,
    PadGrant_s1,
    PadConfigOut,
// inout   
    PadAddress_s1,
    PadData_w
    );

// Pads
input   	PadBusError_v2;		// Outstanding cycle failed Outstanding cycle failed
input   	PadClock;		// System clock System clock
input   	PadReset_ww;		// Reset pin Reset pin
input   [5:0]	PadInterrupt_ww;	// Interrupt enables Interrupt enables
input   [15:0]	PadL2Tag_v2;		// Secondary cache tag Secondary cache tag
input   	PadL2Valid_v2;		// Secondary cache valid bit Secondary cache valid bit
input   	PadReqICache_s1;	// Outside req to diddle ICache Outside req to diddle ICache
input   	PadReqDCache_s1;	// Outside req to diddle DCache Outside req to diddle DCache
input   	PadReqBus_s1;		// Outside request to grab bus Outside request to grab bus
input   	PadConfigIn;		// For configuring the latency For configuring the latency

output  [5:0]	PadLength_s1;		// # of bytes to transfer # of bytes to transfer
output  	PadAddrValid_s1;	// Initiate bus transaction(s) Initiate bus transaction(s)
output  	PadWrite_s1;		// Write if 1, otherwise read Write if 1, otherwise read
output  	PadNonCacheable_s1;	// This request is non-cacheable This request is non-cacheable
output  	PadL1Hit_s1;		// Primary cache hit signal Primary cache hit signal
output  	PadGrant_s1;		// Bus grant Bus grant
output  	PadConfigOut;		// To read out the config. To read out the config.

inout   [31:0]	PadAddress_s1;		// Byte address Byte address
inout   [63:0]	PadData_w;		// Read/Write data Read/Write data

//
// Interface signals between top level modules
//
wire		Phi1;			// System Clock - Phase 1
wire		Phi2;			// System Clock - Phase 2
wire	[31:0]	ASBus_s1e;		// A side S Source Bus
wire	[31:0]	ATBus_s1e;		// A side T Source Bus
wire	[31:0]	BSBus_s1e;		// B side S Source Bus
wire	[31:0]	BTBus_s1e;		// B side T Source Bus
wire	[31:0]	AResultBus_v2e;		// A side Result Bus
wire	[31:0]	BResultBus_v2e;		// B side Result Bus
wire	[31:0]	MemAddr_s1m;		// Address out of Adder
wire	[31:0]	MemBus_v2m;		// Memory Data Bus
wire	[29:0]	InstrAddr_s2i;		// Instr Number from PC
wire	[39:0]	AInstr_s2r;		// Not all the instr. needed
wire	[39:0]	BInstr_s2r;		// Not all the instr needed
wire	[31:2]	PhysAddr_v2m;		// Translated addr from TLB
wire		IncPC_v1e;		// Incr -> PCBus
wire		RegPC_v1e;		// Reg -> PCBus
wire		AddPC_v1e;		// Branch Addr -> PCBus
wire		ImmPC_v1e;		// Jmp Immediate -> PCBus
wire		ICacheMiss_v2r;		// I cache missed
wire		PCDrvResult_s2e;	// & link instruction
wire		AKill_s1e;		// Kill from IFetch, not tristate
wire		BKill_s1e;		// Kill from IFetch, not tristate
wire		KillOne_s1e;		// Decode should assert (A|B)Ignore
wire		MipsMode_s2e;		// (of RFE) Mips Mode for fetcher
wire		IStall_s1;		// IFetcher stall for machine
wire		IAddrError_v2i;		// Seg. Violation in IFetch
wire		SEqualsT_v1e;		// Fast cmp Output
wire		SIsNegative_v1e;	// Other cmp information
wire		ADestIsRD_s1e;		// Dest Spec is in RD field
wire		ADestIsRT_s1e;		// Dest Spec is in RT field
wire		ADestIs31_s1e;		// Dest Spec is Reg31
wire		BDestIsRD_s1e;		// Dest Spec is in RD field
wire		BDestIsRT_s1e;		// Dest Spec is in RT field
wire		BIsLoad_s1e;		// B side instruction is load
wire		AIgnore_s2e;		// Kill from instr. decoder, later
wire		BIgnore_s2e;		// Kill from instr. decoder, later
wire		MemStall_s2;		// Memory stall for machine
wire		MemExcept_s2m;		// Exception in Mem
wire		InstrIsLoad_s1m;	// Don't assert if Instr is Killed
wire		InstrIsStore_s1m;	// Don't assert if Instr is Killed
wire	[2:0]	MemOp_s1m;		// Size/type of Mem op from Opcode
wire		BoostedInstr_s1m;	// Is load boosted
wire		NonCacheable_v2m;	// Referenced page is uncacheable
wire		Commit_s1e;		// (of slot) Branch prediction correct
wire		Squash_s1e;		// (of slot) Branch prediction wrong
wire		Reset;			// External Reset pin asserted
wire	[2:0]	ExceptVector_s1i;	// *** Which exception to use
wire		Except_s1w;		// Global exception signal
wire	[31:0]	Cp0Bus_s2m;		// Cop0 data on move from/to
wire	[5:0]	Interrupt_w;		// EXt World Interrupts
wire		MvToCop0_s1m;		// Cop0 decoded operation
wire		MvFromCop0_s1m;		// Cop0 decoded operation
wire		Syscall_s2m;		// Cop0 decoded operation
wire		Break_s2m;		// Cop0 decoded operation
wire		TLBProbe_s1m;		// Cop0 decoded operation
wire		TLBRead_s1m;		// Cop0 decoded operation
wire		TLBWriteI_s1m;		// Cop0 decoded operation
wire		TLBWriteR_s1m;		// Cop0 decoded operation
wire		RetFromExcept_s1e;	// Cop0 decoded operation
wire	[5:0]	PCPID_v2r;		// Current PID for Vaddr compare
wire		AALUOvfl_v2e;		// Alu overflow
wire		BALUOvfl_v2e;		// Alu overflow
wire	[3:0]	CopRegNum_s1m;		// B side RD spec. for Cop0
wire		AIsBoosted_s2e;		// A side instruction is boosted
wire		BIsBoosted_s2e;		// B side instruction is boosted
wire		SystemBit_s2e;		// (of RFE) System / (not) User bit
wire		EPCSel_s1m;		// Read EPC
wire		EPCNSel_s1m;		// Read EPCN
wire		ItlbMiss_v2e;		// TLB miss on ICache L2 access
wire		ExtRead_s1;		// To Ext Int
wire		ExtRequest_s1;		// To Ext Int
wire		NonCacheable_s1;	// To Ext Int
wire		HLNotReady_s2e;		// HI/LO not ready mfhi/lo stall
wire		LSExtRequest_s1;	// DCache needs Ext Int wires
wire		LSExtRead_s1;		// To Ext Int
wire		LSNonCacheable_s1;	// To Ext Int
wire	[31:0]	SharedMemAddr_s1;	// To Ext Int
wire	[5:0]	ReqLength_s1;		// To Ext Int
wire		L1Hit_s1;		// To Ext Int
wire		ReqNextBlock_s2;	// Put next block on SharedMemData
wire	[63:0]	SharedMemData_s2;	// To/from chip Data bus
wire		ExtDataValid_s2;	// Incoming SharedMemData ready
wire		L2Miss_s2;		// L2 missed so restart refill
wire		Clock;			// Ext system clock
wire		ReqICache_s1;		// Probe the I-cache for a line
wire		ReqDCache_s1;		// Probe the D-cache for a line
wire		ReqBus_s1;		// Ext-world wants the memory bus
wire		BusError_s2;		// Outstanding cycle failed
wire		L2Valid_s2;		// Secondary cache valid bit
wire		Reset_ww;		// Asynch. reset signal
wire		ConfigIn;		// For configuring the latency
wire	[15:0]	L2Tag_s2;		// Tag from L2 cache
wire		ExternRead_s1;		// If 1 op is a read
wire		NonCacheableOp_s1;	// If 1 trans. is non-cacheable
wire		Grant_s1;		// Grant memory bus to outside
wire		ConfigOut;		// To read out the config.
wire		DrivePadAddr_s1;	// Drive the addrs on the pads
wire		DrivePadData_s2;	// Drive the data on the pads
wire		DriveSharedMemAddr_s1;	// Drive probe addrs on shared bus
wire		DriveSharedMemData_s2;	// Drive outside data on proc. bus
wire	[31:0]	PadAddress_s1;		// Byte address Byte address
wire	[5:0]	PadLength_s1;		// # of bytes to transfer # of bytes to transfer
wire		PadAddrValid_s1;	// Initiate bus transaction(s) Initiate bus transaction(s)
wire		PadWrite_s1;		// Write if 1, otherwise read Write if 1, otherwise read
wire		PadNonCacheable_s1;	// This request is non-cacheable This request is non-cacheable
wire	[63:0]	PadData_w;		// Read/Write data Read/Write data
wire		PadBusError_v2;		// Outstanding cycle failed Outstanding cycle failed
wire		PadClock;		// System clock System clock
wire		PadReset_ww;		// Reset pin Reset pin
wire	[5:0]	PadInterrupt_ww;	// Interrupt enables Interrupt enables
wire	[15:0]	PadL2Tag_v2;		// Secondary cache tag Secondary cache tag
wire		PadL2Valid_v2;		// Secondary cache valid bit Secondary cache valid bit
wire		PadL1Hit_s1;		// Primary cache hit signal Primary cache hit signal
wire		PadReqICache_s1;	// Outside req to diddle ICache Outside req to diddle ICache
wire		PadReqDCache_s1;	// Outside req to diddle DCache Outside req to diddle DCache
wire		PadReqBus_s1;		// Outside request to grab bus Outside request to grab bus
wire		PadGrant_s1;		// Bus grant Bus grant
wire		PadConfigIn;		// For configuring the latency For configuring the latency
wire		PadConfigOut;		// To read out the config. To read out the config.
//
// Functional unit calls
// First inputs, then outputs, and finally, inouts
//

instrFetch instrFetch(
// input   
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.ASBus_s1e		(ASBus_s1e),
	.IncPC_v1e		(IncPC_v1e),
	.RegPC_v1e		(RegPC_v1e),
	.AddPC_v1e		(AddPC_v1e),
	.ImmPC_v1e		(ImmPC_v1e),
	.PCDrvResult_s2e	(PCDrvResult_s2e),
	.MipsMode_s2e		(MipsMode_s2e),
	.MemStall_s2		(MemStall_s2),
	.Reset			(Reset),
	.ExceptVector_s1i	(ExceptVector_s1i),
	.Except_s1w		(Except_s1w),
	.PCPID_v2r		(PCPID_v2r),
	.SystemBit_s2e		(SystemBit_s2e),
	.EPCSel_s1m		(EPCSel_s1m),
	.EPCNSel_s1m		(EPCNSel_s1m),
	.ItlbMiss_v2e		(ItlbMiss_v2e),
	.NonCacheable_s1	(NonCacheable_s1),
	.SharedMemAddr_s1	(SharedMemAddr_s1),
	.ReqNextBlock_s2	(ReqNextBlock_s2),
	.SharedMemData_s2	(SharedMemData_s2),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.L2Miss_s2		(L2Miss_s2),
// output  
	.AResultBus_v2e		(AResultBus_v2e),
	.MemBus_v2m		(MemBus_v2m),
	.InstrAddr_s2i		(InstrAddr_s2i),
	.AInstr_s2r		(AInstr_s2r),
	.BInstr_s2r		(BInstr_s2r),
	.ICacheMiss_v2r		(ICacheMiss_v2r),
	.AKill_s1e		(AKill_s1e),
	.BKill_s1e		(BKill_s1e),
	.KillOne_s1e		(KillOne_s1e),
	.IStall_s1		(IStall_s1),
	.IAddrError_v2i		(IAddrError_v2i),
	.L1Hit_s1		(L1Hit_s1)
	);
decodeExec decodeExec(
// input   
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.ASBus_s1e		(ASBus_s1e),
	.ATBus_s1e		(ATBus_s1e),
	.BSBus_s1e		(BSBus_s1e),
	.BTBus_s1e		(BTBus_s1e),
	.AInstr_s2r		(AInstr_s2r),
	.BInstr_s2r		(BInstr_s2r),
	.AKill_s1e		(AKill_s1e),
	.BKill_s1e		(BKill_s1e),
	.KillOne_s1e		(KillOne_s1e),
	.IStall_s1		(IStall_s1),
	.SEqualsT_v1e		(SEqualsT_v1e),
	.SIsNegative_v1e	(SIsNegative_v1e),
	.MemStall_s2		(MemStall_s2),
	.Except_s1w		(Except_s1w),
	.EPCSel_s1m		(EPCSel_s1m),
	.EPCNSel_s1m		(EPCNSel_s1m),
// output  
	.AResultBus_v2e		(AResultBus_v2e),
	.BResultBus_v2e		(BResultBus_v2e),
	.MemAddr_s1m		(MemAddr_s1m),
	.MemBus_v2m		(MemBus_v2m),
	.IncPC_v1e		(IncPC_v1e),
	.RegPC_v1e		(RegPC_v1e),
	.AddPC_v1e		(AddPC_v1e),
	.ImmPC_v1e		(ImmPC_v1e),
	.PCDrvResult_s2e	(PCDrvResult_s2e),
	.ADestIsRD_s1e		(ADestIsRD_s1e),
	.ADestIsRT_s1e		(ADestIsRT_s1e),
	.ADestIs31_s1e		(ADestIs31_s1e),
	.BDestIsRD_s1e		(BDestIsRD_s1e),
	.BDestIsRT_s1e		(BDestIsRT_s1e),
	.BIsLoad_s1e		(BIsLoad_s1e),
	.AIgnore_s2e		(AIgnore_s2e),
	.BIgnore_s2e		(BIgnore_s2e),
	.InstrIsLoad_s1m	(InstrIsLoad_s1m),
	.InstrIsStore_s1m	(InstrIsStore_s1m),
	.MemOp_s1m		(MemOp_s1m),
	.BoostedInstr_s1m	(BoostedInstr_s1m),
	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
	.MvToCop0_s1m		(MvToCop0_s1m),
	.MvFromCop0_s1m		(MvFromCop0_s1m),
	.Syscall_s2m		(Syscall_s2m),
	.Break_s2m		(Break_s2m),
	.TLBProbe_s1m		(TLBProbe_s1m),
	.TLBRead_s1m		(TLBRead_s1m),
	.TLBWriteI_s1m		(TLBWriteI_s1m),
	.TLBWriteR_s1m		(TLBWriteR_s1m),
	.RetFromExcept_s1e	(RetFromExcept_s1e),
	.AALUOvfl_v2e		(AALUOvfl_v2e),
	.BALUOvfl_v2e		(BALUOvfl_v2e),
	.CopRegNum_s1m		(CopRegNum_s1m),
	.AIsBoosted_s2e		(AIsBoosted_s2e),
	.BIsBoosted_s2e		(BIsBoosted_s2e),
	.HLNotReady_s2e		(HLNotReady_s2e),
// inout   
	.Cp0Bus_s2m		(Cp0Bus_s2m)
	);
regFile regFile(
// input   
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.AResultBus_v2e		(AResultBus_v2e),
	.BResultBus_v2e		(BResultBus_v2e),
	.MemBus_v2m		(MemBus_v2m),
	.AInstr_s2r		(AInstr_s2r),
	.BInstr_s2r		(BInstr_s2r),
	.AKill_s1e		(AKill_s1e),
	.BKill_s1e		(BKill_s1e),
	.IStall_s1		(IStall_s1),
	.ADestIsRD_s1e		(ADestIsRD_s1e),
	.ADestIsRT_s1e		(ADestIsRT_s1e),
	.ADestIs31_s1e		(ADestIs31_s1e),
	.BDestIsRD_s1e		(BDestIsRD_s1e),
	.BDestIsRT_s1e		(BDestIsRT_s1e),
	.BIsLoad_s1e		(BIsLoad_s1e),
	.AIgnore_s2e		(AIgnore_s2e),
	.BIgnore_s2e		(BIgnore_s2e),
	.MemStall_s2		(MemStall_s2),
	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
	.Except_s1w		(Except_s1w),
// output  
	.ASBus_s1e		(ASBus_s1e),
	.ATBus_s1e		(ATBus_s1e),
	.BSBus_s1e		(BSBus_s1e),
	.BTBus_s1e		(BTBus_s1e),
	.SEqualsT_v1e		(SEqualsT_v1e),
	.SIsNegative_v1e	(SIsNegative_v1e)
	);
loadStore loadStore(
// input   
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.BTBus_s1e		(BTBus_s1e),
	.BResultBus_v2e		(BResultBus_v2e),
	.MemAddr_s1m		(MemAddr_s1m),
	.PhysAddr_v2m		(PhysAddr_v2m),
	.ICacheMiss_v2r		(ICacheMiss_v2r),
	.IStall_s1		(IStall_s1),
	.InstrIsLoad_s1m	(InstrIsLoad_s1m),
	.InstrIsStore_s1m	(InstrIsStore_s1m),
	.MemOp_s1m		(MemOp_s1m),
	.BoostedInstr_s1m	(BoostedInstr_s1m),
	.NonCacheable_v2m	(NonCacheable_v2m),
	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
	.Reset			(Reset),
	.Except_s1w		(Except_s1w),
	.HLNotReady_s2e		(HLNotReady_s2e),
	.ReqNextBlock_s2	(ReqNextBlock_s2),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.L2Miss_s2		(L2Miss_s2),
// output  
	.MemStall_s2		(MemStall_s2),
	.MemExcept_s2m		(MemExcept_s2m),
	.LSExtRequest_s1	(LSExtRequest_s1),
	.LSExtRead_s1		(LSExtRead_s1),
	.LSNonCacheable_s1	(LSNonCacheable_s1),
	.ReqLength_s1		(ReqLength_s1),
	.L1Hit_s1		(L1Hit_s1),
// inout   
	.MemBus_v2m		(MemBus_v2m),
	.SharedMemAddr_s1	(SharedMemAddr_s1),
	.SharedMemData_s2	(SharedMemData_s2)
	);
coproc0 coproc0(
// input   
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.MemAddr_s1m		(MemAddr_s1m),
	.InstrAddr_s2i		(InstrAddr_s2i),
	.ICacheMiss_v2r		(ICacheMiss_v2r),
	.IStall_s1		(IStall_s1),
	.IAddrError_v2i		(IAddrError_v2i),
	.MemStall_s2		(MemStall_s2),
	.MemExcept_s2m		(MemExcept_s2m),
	.InstrIsLoad_s1m	(InstrIsLoad_s1m),
	.InstrIsStore_s1m	(InstrIsStore_s1m),
	.Commit_s1e		(Commit_s1e),
	.Squash_s1e		(Squash_s1e),
	.Reset			(Reset),
	.Interrupt_w		(Interrupt_w),
	.MvToCop0_s1m		(MvToCop0_s1m),
	.MvFromCop0_s1m		(MvFromCop0_s1m),
	.Syscall_s2m		(Syscall_s2m),
	.Break_s2m		(Break_s2m),
	.TLBProbe_s1m		(TLBProbe_s1m),
	.TLBRead_s1m		(TLBRead_s1m),
	.TLBWriteI_s1m		(TLBWriteI_s1m),
	.TLBWriteR_s1m		(TLBWriteR_s1m),
	.RetFromExcept_s1e	(RetFromExcept_s1e),
	.AALUOvfl_v2e		(AALUOvfl_v2e),
	.BALUOvfl_v2e		(BALUOvfl_v2e),
	.CopRegNum_s1m		(CopRegNum_s1m),
	.AIsBoosted_s2e		(AIsBoosted_s2e),
	.BIsBoosted_s2e		(BIsBoosted_s2e),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.L2Miss_s2		(L2Miss_s2),
// output  
	.PhysAddr_v2m		(PhysAddr_v2m),
	.MipsMode_s2e		(MipsMode_s2e),
	.NonCacheable_v2m	(NonCacheable_v2m),
	.ExceptVector_s1i	(ExceptVector_s1i),
	.Except_s1w		(Except_s1w),
	.PCPID_v2r		(PCPID_v2r),
	.SystemBit_s2e		(SystemBit_s2e),
	.EPCSel_s1m		(EPCSel_s1m),
	.EPCNSel_s1m		(EPCNSel_s1m),
	.ItlbMiss_v2e		(ItlbMiss_v2e),
	.ExtRead_s1		(ExtRead_s1),
	.ExtRequest_s1		(ExtRequest_s1),
	.NonCacheable_s1	(NonCacheable_s1),
	.SharedMemAddr_s1	(SharedMemAddr_s1),
	.ReqLength_s1		(ReqLength_s1),
// inout   
	.Cp0Bus_s2m		(Cp0Bus_s2m)
	);
externInt externInt(
// input   
	.Interrupt_w		(Interrupt_w),
	.ExtRead_s1		(ExtRead_s1),
	.ExtRequest_s1		(ExtRequest_s1),
	.NonCacheable_s1	(NonCacheable_s1),
	.LSExtRequest_s1	(LSExtRequest_s1),
	.LSExtRead_s1		(LSExtRead_s1),
	.LSNonCacheable_s1	(LSNonCacheable_s1),
	.SharedMemAddr_s1	(SharedMemAddr_s1),
	.ReqLength_s1		(ReqLength_s1),
	.L1Hit_s1		(L1Hit_s1),
	.ReqNextBlock_s2	(ReqNextBlock_s2),
	.Clock			(Clock),
	.ReqICache_s1		(ReqICache_s1),
	.ReqDCache_s1		(ReqDCache_s1),
	.ReqBus_s1		(ReqBus_s1),
	.BusError_s2		(BusError_s2),
	.L2Valid_s2		(L2Valid_s2),
	.Reset_ww		(Reset_ww),
	.ConfigIn		(ConfigIn),
	.L2Tag_s2		(L2Tag_s2),
// output  
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.Reset			(Reset),
	.ExtDataValid_s2	(ExtDataValid_s2),
	.L2Miss_s2		(L2Miss_s2),
	.ExternRead_s1		(ExternRead_s1),
	.NonCacheableOp_s1	(NonCacheableOp_s1),
	.Grant_s1		(Grant_s1),
	.ConfigOut		(ConfigOut),
	.DrivePadAddr_s1	(DrivePadAddr_s1),
	.DrivePadData_s2	(DrivePadData_s2),
	.DriveSharedMemAddr_s1	(DriveSharedMemAddr_s1),
	.DriveSharedMemData_s2	(DriveSharedMemData_s2)
	);
pads pads(
// input   
	.Phi1			(Phi1),
	.Phi2			(Phi2),
	.ReqLength_s1		(ReqLength_s1),
	.ExternRead_s1		(ExternRead_s1),
	.NonCacheableOp_s1	(NonCacheableOp_s1),
	.Grant_s1		(Grant_s1),
	.ConfigOut		(ConfigOut),
	.DrivePadAddr_s1	(DrivePadAddr_s1),
	.DrivePadData_s2	(DrivePadData_s2),
	.DriveSharedMemAddr_s1	(DriveSharedMemAddr_s1),
	.DriveSharedMemData_s2	(DriveSharedMemData_s2),
	.PadBusError_v2		(PadBusError_v2),
	.PadClock		(PadClock),
	.PadReset_ww		(PadReset_ww),
	.PadInterrupt_ww	(PadInterrupt_ww),
	.PadL2Tag_v2		(PadL2Tag_v2),
	.PadL2Valid_v2		(PadL2Valid_v2),
	.PadReqICache_s1	(PadReqICache_s1),
	.PadReqDCache_s1	(PadReqDCache_s1),
	.PadReqBus_s1		(PadReqBus_s1),
	.PadConfigIn		(PadConfigIn),
// output  
	.Interrupt_w		(Interrupt_w),
	.ReqNextBlock_s2	(ReqNextBlock_s2),
	.Clock			(Clock),
	.ReqICache_s1		(ReqICache_s1),
	.ReqDCache_s1		(ReqDCache_s1),
	.ReqBus_s1		(ReqBus_s1),
	.BusError_s2		(BusError_s2),
	.L2Valid_s2		(L2Valid_s2),
	.Reset_ww		(Reset_ww),
	.ConfigIn		(ConfigIn),
	.L2Tag_s2		(L2Tag_s2),
	.PadLength_s1		(PadLength_s1),
	.PadAddrValid_s1	(PadAddrValid_s1),
	.PadWrite_s1		(PadWrite_s1),
	.PadNonCacheable_s1	(PadNonCacheable_s1),
	.PadL1Hit_s1		(PadL1Hit_s1),
	.PadGrant_s1		(PadGrant_s1),
	.PadConfigOut		(PadConfigOut),
// inout   
	.SharedMemAddr_s1	(SharedMemAddr_s1),
	.SharedMemData_s2	(SharedMemData_s2),
	.PadAddress_s1		(PadAddress_s1),
	.PadData_w		(PadData_w)
	);
`include "waves.v"


endmodule

//
// module defs
/*******  Commented out - who sez Verilog doesn't like these

module instrFetch(
    Phi1,
    Phi2,
    ASBus_s1e,
    IncPC_v1e,
    RegPC_v1e,
    AddPC_v1e,
    ImmPC_v1e,
    PCDrvResult_s2e,
    MipsMode_s2e,
    MemStall_s2,
    Reset,
    ExceptVector_s1i,
    Except_s1w,
    PCPID_v2r,
    SystemBit_s2e,
    EPCSel_s1m,
    EPCNSel_s1m,
    ItlbMiss_v2e,
    NonCacheable_s1,
    SharedMemAddr_s1,
    ReqNextBlock_s2,
    SharedMemData_s2,
    ExtDataValid_s2,
    L2Miss_s2,
    AResultBus_v2e,
    MemBus_v2m,
    InstrAddr_s2i,
    AInstr_s2r,
    BInstr_s2r,
    ICacheMiss_v2r,
    AKill_s1e,
    BKill_s1e,
    KillOne_s1e,
    IStall_s1,
    IAddrError_v2i,
    L1Hit_s1
);

input   	Phi1;
input   	Phi2;
input   [31:0]	ASBus_s1e;
input   	IncPC_v1e;
input   	RegPC_v1e;
input   	AddPC_v1e;
input   	ImmPC_v1e;
input   	PCDrvResult_s2e;
input   	MipsMode_s2e;
input   	MemStall_s2;
input   	Reset;
input   [2:0]	ExceptVector_s1i;
input   	Except_s1w;
input   [5:0]	PCPID_v2r;
input   	SystemBit_s2e;
input   	EPCSel_s1m;
input   	EPCNSel_s1m;
input   	ItlbMiss_v2e;
input   	NonCacheable_s1;
input   [31:0]	SharedMemAddr_s1;
input   	ReqNextBlock_s2;
input   [63:0]	SharedMemData_s2;
input   	ExtDataValid_s2;
input   	L2Miss_s2;

output  [31:0]	AResultBus_v2e;
output  [31:0]	MemBus_v2m;
output  [29:0]	InstrAddr_s2i;
output  [39:0]	AInstr_s2r;
output  [39:0]	BInstr_s2r;
output  	ICacheMiss_v2r;
output  	AKill_s1e;
output  	BKill_s1e;
output  	KillOne_s1e;
output  	IStall_s1;
output  	IAddrError_v2i;
output  	L1Hit_s1;


endmodule

module decodeExec(
    Phi1,
    Phi2,
    ASBus_s1e,
    ATBus_s1e,
    BSBus_s1e,
    BTBus_s1e,
    AInstr_s2r,
    BInstr_s2r,
    AKill_s1e,
    BKill_s1e,
    KillOne_s1e,
    IStall_s1,
    SEqualsT_v1e,
    SIsNegative_v1e,
    MemStall_s2,
    Except_s1w,
    EPCSel_s1m,
    EPCNSel_s1m,
    AResultBus_v2e,
    BResultBus_v2e,
    MemAddr_s1m,
    MemBus_v2m,
    IncPC_v1e,
    RegPC_v1e,
    AddPC_v1e,
    ImmPC_v1e,
    PCDrvResult_s2e,
    ADestIsRD_s1e,
    ADestIsRT_s1e,
    ADestIs31_s1e,
    BDestIsRD_s1e,
    BDestIsRT_s1e,
    BIsLoad_s1e,
    AIgnore_s2e,
    BIgnore_s2e,
    InstrIsLoad_s1m,
    InstrIsStore_s1m,
    MemOp_s1m,
    BoostedInstr_s1m,
    Commit_s1e,
    Squash_s1e,
    MvToCop0_s1m,
    MvFromCop0_s1m,
    Syscall_s2m,
    Break_s2m,
    TLBProbe_s1m,
    TLBRead_s1m,
    TLBWriteI_s1m,
    TLBWriteR_s1m,
    RetFromExcept_s1e,
    AALUOvfl_v2e,
    BALUOvfl_v2e,
    CopRegNum_s1m,
    AIsBoosted_s2e,
    BIsBoosted_s2e,
    HLNotReady_s2e,
    Cp0Bus_s2m
);

input   	Phi1;
input   	Phi2;
input   [31:0]	ASBus_s1e;
input   [31:0]	ATBus_s1e;
input   [31:0]	BSBus_s1e;
input   [31:0]	BTBus_s1e;
input   [39:0]	AInstr_s2r;
input   [39:0]	BInstr_s2r;
input   	AKill_s1e;
input   	BKill_s1e;
input   	KillOne_s1e;
input   	IStall_s1;
input   	SEqualsT_v1e;
input   	SIsNegative_v1e;
input   	MemStall_s2;
input   	Except_s1w;
input   	EPCSel_s1m;
input   	EPCNSel_s1m;

output  [31:0]	AResultBus_v2e;
output  [31:0]	BResultBus_v2e;
output  [31:0]	MemAddr_s1m;
output  [31:0]	MemBus_v2m;
output  	IncPC_v1e;
output  	RegPC_v1e;
output  	AddPC_v1e;
output  	ImmPC_v1e;
output  	PCDrvResult_s2e;
output  	ADestIsRD_s1e;
output  	ADestIsRT_s1e;
output  	ADestIs31_s1e;
output  	BDestIsRD_s1e;
output  	BDestIsRT_s1e;
output  	BIsLoad_s1e;
output  	AIgnore_s2e;
output  	BIgnore_s2e;
output  	InstrIsLoad_s1m;
output  	InstrIsStore_s1m;
output  [2:0]	MemOp_s1m;
output  	BoostedInstr_s1m;
output  	Commit_s1e;
output  	Squash_s1e;
output  	MvToCop0_s1m;
output  	MvFromCop0_s1m;
output  	Syscall_s2m;
output  	Break_s2m;
output  	TLBProbe_s1m;
output  	TLBRead_s1m;
output  	TLBWriteI_s1m;
output  	TLBWriteR_s1m;
output  	RetFromExcept_s1e;
output  	AALUOvfl_v2e;
output  	BALUOvfl_v2e;
output  [3:0]	CopRegNum_s1m;
output  	AIsBoosted_s2e;
output  	BIsBoosted_s2e;
output  	HLNotReady_s2e;

inout   [31:0]	Cp0Bus_s2m;

endmodule

module regFile(
    Phi1,
    Phi2,
    AResultBus_v2e,
    BResultBus_v2e,
    MemBus_v2m,
    AInstr_s2r,
    BInstr_s2r,
    AKill_s1e,
    BKill_s1e,
    IStall_s1,
    ADestIsRD_s1e,
    ADestIsRT_s1e,
    ADestIs31_s1e,
    BDestIsRD_s1e,
    BDestIsRT_s1e,
    BIsLoad_s1e,
    AIgnore_s2e,
    BIgnore_s2e,
    MemStall_s2,
    Commit_s1e,
    Squash_s1e,
    Except_s1w,
    ASBus_s1e,
    ATBus_s1e,
    BSBus_s1e,
    BTBus_s1e,
    SEqualsT_v1e,
    SIsNegative_v1e
);

input   	Phi1;
input   	Phi2;
input   [31:0]	AResultBus_v2e;
input   [31:0]	BResultBus_v2e;
input   [31:0]	MemBus_v2m;
input   [39:0]	AInstr_s2r;
input   [39:0]	BInstr_s2r;
input   	AKill_s1e;
input   	BKill_s1e;
input   	IStall_s1;
input   	ADestIsRD_s1e;
input   	ADestIsRT_s1e;
input   	ADestIs31_s1e;
input   	BDestIsRD_s1e;
input   	BDestIsRT_s1e;
input   	BIsLoad_s1e;
input   	AIgnore_s2e;
input   	BIgnore_s2e;
input   	MemStall_s2;
input   	Commit_s1e;
input   	Squash_s1e;
input   	Except_s1w;

output  [31:0]	ASBus_s1e;
output  [31:0]	ATBus_s1e;
output  [31:0]	BSBus_s1e;
output  [31:0]	BTBus_s1e;
output  	SEqualsT_v1e;
output  	SIsNegative_v1e;


endmodule

module loadStore(
    Phi1,
    Phi2,
    BTBus_s1e,
    BResultBus_v2e,
    MemAddr_s1m,
    PhysAddr_v2m,
    ICacheMiss_v2r,
    IStall_s1,
    InstrIsLoad_s1m,
    InstrIsStore_s1m,
    MemOp_s1m,
    BoostedInstr_s1m,
    NonCacheable_v2m,
    Commit_s1e,
    Squash_s1e,
    Reset,
    Except_s1w,
    HLNotReady_s2e,
    ReqNextBlock_s2,
    ExtDataValid_s2,
    L2Miss_s2,
    MemStall_s2,
    MemExcept_s2m,
    LSExtRequest_s1,
    LSExtRead_s1,
    LSNonCacheable_s1,
    ReqLength_s1,
    L1Hit_s1,
    MemBus_v2m,
    SharedMemAddr_s1,
    SharedMemData_s2
);

input   	Phi1;
input   	Phi2;
input   [31:0]	BTBus_s1e;
input   [31:0]	BResultBus_v2e;
input   [31:0]	MemAddr_s1m;
input   [31:2]	PhysAddr_v2m;
input   	ICacheMiss_v2r;
input   	IStall_s1;
input   	InstrIsLoad_s1m;
input   	InstrIsStore_s1m;
input   [2:0]	MemOp_s1m;
input   	BoostedInstr_s1m;
input   	NonCacheable_v2m;
input   	Commit_s1e;
input   	Squash_s1e;
input   	Reset;
input   	Except_s1w;
input   	HLNotReady_s2e;
input   	ReqNextBlock_s2;
input   	ExtDataValid_s2;
input   	L2Miss_s2;

output  	MemStall_s2;
output  	MemExcept_s2m;
output  	LSExtRequest_s1;
output  	LSExtRead_s1;
output  	LSNonCacheable_s1;
output  [5:0]	ReqLength_s1;
output  	L1Hit_s1;

inout   [31:0]	MemBus_v2m;
inout   [31:0]	SharedMemAddr_s1;
inout   [63:0]	SharedMemData_s2;

endmodule

module coproc0(
    Phi1,
    Phi2,
    MemAddr_s1m,
    InstrAddr_s2i,
    ICacheMiss_v2r,
    IStall_s1,
    IAddrError_v2i,
    MemStall_s2,
    MemExcept_s2m,
    InstrIsLoad_s1m,
    InstrIsStore_s1m,
    Commit_s1e,
    Squash_s1e,
    Reset,
    Interrupt_w,
    MvToCop0_s1m,
    MvFromCop0_s1m,
    Syscall_s2m,
    Break_s2m,
    TLBProbe_s1m,
    TLBRead_s1m,
    TLBWriteI_s1m,
    TLBWriteR_s1m,
    RetFromExcept_s1e,
    AALUOvfl_v2e,
    BALUOvfl_v2e,
    CopRegNum_s1m,
    AIsBoosted_s2e,
    BIsBoosted_s2e,
    ExtDataValid_s2,
    L2Miss_s2,
    PhysAddr_v2m,
    MipsMode_s2e,
    NonCacheable_v2m,
    ExceptVector_s1i,
    Except_s1w,
    PCPID_v2r,
    SystemBit_s2e,
    EPCSel_s1m,
    EPCNSel_s1m,
    ItlbMiss_v2e,
    ExtRead_s1,
    ExtRequest_s1,
    NonCacheable_s1,
    SharedMemAddr_s1,
    ReqLength_s1,
    Cp0Bus_s2m
);

input   	Phi1;
input   	Phi2;
input   [31:0]	MemAddr_s1m;
input   [29:0]	InstrAddr_s2i;
input   	ICacheMiss_v2r;
input   	IStall_s1;
input   	IAddrError_v2i;
input   	MemStall_s2;
input   	MemExcept_s2m;
input   	InstrIsLoad_s1m;
input   	InstrIsStore_s1m;
input   	Commit_s1e;
input   	Squash_s1e;
input   	Reset;
input   [5:0]	Interrupt_w;
input   	MvToCop0_s1m;
input   	MvFromCop0_s1m;
input   	Syscall_s2m;
input   	Break_s2m;
input   	TLBProbe_s1m;
input   	TLBRead_s1m;
input   	TLBWriteI_s1m;
input   	TLBWriteR_s1m;
input   	RetFromExcept_s1e;
input   	AALUOvfl_v2e;
input   	BALUOvfl_v2e;
input   [3:0]	CopRegNum_s1m;
input   	AIsBoosted_s2e;
input   	BIsBoosted_s2e;
input   	ExtDataValid_s2;
input   	L2Miss_s2;

output  [31:2]	PhysAddr_v2m;
output  	MipsMode_s2e;
output  	NonCacheable_v2m;
output  [2:0]	ExceptVector_s1i;
output  	Except_s1w;
output  [5:0]	PCPID_v2r;
output  	SystemBit_s2e;
output  	EPCSel_s1m;
output  	EPCNSel_s1m;
output  	ItlbMiss_v2e;
output  	ExtRead_s1;
output  	ExtRequest_s1;
output  	NonCacheable_s1;
output  [31:0]	SharedMemAddr_s1;
output  [5:0]	ReqLength_s1;

inout   [31:0]	Cp0Bus_s2m;

endmodule

module externInt(
    Interrupt_w,
    ExtRead_s1,
    ExtRequest_s1,
    NonCacheable_s1,
    LSExtRequest_s1,
    LSExtRead_s1,
    LSNonCacheable_s1,
    SharedMemAddr_s1,
    ReqLength_s1,
    L1Hit_s1,
    ReqNextBlock_s2,
    Clock,
    ReqICache_s1,
    ReqDCache_s1,
    ReqBus_s1,
    BusError_s2,
    L2Valid_s2,
    Reset_ww,
    ConfigIn,
    L2Tag_s2,
    Phi1,
    Phi2,
    Reset,
    ExtDataValid_s2,
    L2Miss_s2,
    ExternRead_s1,
    NonCacheableOp_s1,
    Grant_s1,
    ConfigOut,
    DrivePadAddr_s1,
    DrivePadData_s2,
    DriveSharedMemAddr_s1,
    DriveSharedMemData_s2
);

input   [5:0]	Interrupt_w;
input   	ExtRead_s1;
input   	ExtRequest_s1;
input   	NonCacheable_s1;
input   	LSExtRequest_s1;
input   	LSExtRead_s1;
input   	LSNonCacheable_s1;
input   [31:0]	SharedMemAddr_s1;
input   [5:0]	ReqLength_s1;
input   	L1Hit_s1;
input   	ReqNextBlock_s2;
input   	Clock;
input   	ReqICache_s1;
input   	ReqDCache_s1;
input   	ReqBus_s1;
input   	BusError_s2;
input   	L2Valid_s2;
input   	Reset_ww;
input   	ConfigIn;
input   [15:0]	L2Tag_s2;

output  	Phi1;
output  	Phi2;
output  	Reset;
output  	ExtDataValid_s2;
output  	L2Miss_s2;
output  	ExternRead_s1;
output  	NonCacheableOp_s1;
output  	Grant_s1;
output  	ConfigOut;
output  	DrivePadAddr_s1;
output  	DrivePadData_s2;
output  	DriveSharedMemAddr_s1;
output  	DriveSharedMemData_s2;


endmodule

module pads(
    Phi1,
    Phi2,
    ReqLength_s1,
    ExternRead_s1,
    NonCacheableOp_s1,
    Grant_s1,
    ConfigOut,
    DrivePadAddr_s1,
    DrivePadData_s2,
    DriveSharedMemAddr_s1,
    DriveSharedMemData_s2,
    PadBusError_v2,
    PadClock,
    PadReset_ww,
    PadInterrupt_ww,
    PadL2Tag_v2,
    PadL2Valid_v2,
    PadReqICache_s1,
    PadReqDCache_s1,
    PadReqBus_s1,
    PadConfigIn,
    Interrupt_w,
    ReqNextBlock_s2,
    Clock,
    ReqICache_s1,
    ReqDCache_s1,
    ReqBus_s1,
    BusError_s2,
    L2Valid_s2,
    Reset_ww,
    ConfigIn,
    L2Tag_s2,
    PadLength_s1,
    PadAddrValid_s1,
    PadWrite_s1,
    PadNonCacheable_s1,
    PadL1Hit_s1,
    PadGrant_s1,
    PadConfigOut,
    SharedMemAddr_s1,
    SharedMemData_s2,
    PadAddress_s1,
    PadData_w
);

input   	Phi1;
input   	Phi2;
input   [5:0]	ReqLength_s1;
input   	ExternRead_s1;
input   	NonCacheableOp_s1;
input   	Grant_s1;
input   	ConfigOut;
input   	DrivePadAddr_s1;
input   	DrivePadData_s2;
input   	DriveSharedMemAddr_s1;
input   	DriveSharedMemData_s2;
input   	PadBusError_v2;
input   	PadClock;
input   	PadReset_ww;
input   [5:0]	PadInterrupt_ww;
input   [15:0]	PadL2Tag_v2;
input   	PadL2Valid_v2;
input   	PadReqICache_s1;
input   	PadReqDCache_s1;
input   	PadReqBus_s1;
input   	PadConfigIn;

output  [5:0]	Interrupt_w;
output  	ReqNextBlock_s2;
output  	Clock;
output  	ReqICache_s1;
output  	ReqDCache_s1;
output  	ReqBus_s1;
output  	BusError_s2;
output  	L2Valid_s2;
output  	Reset_ww;
output  	ConfigIn;
output  [15:0]	L2Tag_s2;
output  [5:0]	PadLength_s1;
output  	PadAddrValid_s1;
output  	PadWrite_s1;
output  	PadNonCacheable_s1;
output  	PadL1Hit_s1;
output  	PadGrant_s1;
output  	PadConfigOut;

inout   [31:0]	SharedMemAddr_s1;
inout   [63:0]	SharedMemData_s2;
inout   [31:0]	PadAddress_s1;
inout   [63:0]	PadData_w;

endmodule
end of comment *******/
