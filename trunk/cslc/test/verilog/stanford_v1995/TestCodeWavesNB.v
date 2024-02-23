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

    if (!$test$plusargs("noregs"))
	begin
	$gr_regs(" Seq. Reg        Boosted       Pointer",
	" r0 %h           r0 %h         %b ",
	processor.regFile.register.REGFILE.register[0],
	processor.regFile.register.REGFILE.register[32],
	processor.regFile.register.sequential_s1e[0],
	" r1 %h           r1 %h         %b ",
	processor.regFile.register.REGFILE.register[1],
	processor.regFile.register.REGFILE.register[33],
	processor.regFile.register.sequential_s1e[1],
	" r2 %h           r2 %h         %b",
	processor.regFile.register.REGFILE.register[2],
	processor.regFile.register.REGFILE.register[34],
	processor.regFile.register.sequential_s1e[2],
	" r3 %h           r3 %h         %b",
	processor.regFile.register.REGFILE.register[3],
	processor.regFile.register.REGFILE.register[35],
	processor.regFile.register.sequential_s1e[3],
	" r4 %h           r4 %h         %b",
	processor.regFile.register.REGFILE.register[4],
	processor.regFile.register.REGFILE.register[36],
	processor.regFile.register.sequential_s1e[4],
	" r5 %h           r5 %h         %b",
	processor.regFile.register.REGFILE.register[5],
	processor.regFile.register.REGFILE.register[37],
	processor.regFile.register.sequential_s1e[5],
	" r6 %h           r6 %h         %b",
	processor.regFile.register.REGFILE.register[6],
	processor.regFile.register.REGFILE.register[38],
	processor.regFile.register.sequential_s1e[6],
	" r7 %h           r7 %h         %b",
	processor.regFile.register.REGFILE.register[7],
	processor.regFile.register.REGFILE.register[39],
	processor.regFile.register.sequential_s1e[7],
	" r8 %h           r8 %h         %b",
	processor.regFile.register.REGFILE.register[8],
	processor.regFile.register.REGFILE.register[40],
	processor.regFile.register.sequential_s1e[8],
	" r9 %h           r9 %h         %b",
	processor.regFile.register.REGFILE.register[9],
	processor.regFile.register.REGFILE.register[41],
	processor.regFile.register.sequential_s1e[9],
	"r10 %h          r10 %h         %b",
	processor.regFile.register.REGFILE.register[10],
	processor.regFile.register.REGFILE.register[42],
	processor.regFile.register.sequential_s1e[10],
	"r11 %h          r11 %h         %b",
	processor.regFile.register.REGFILE.register[11],
	processor.regFile.register.REGFILE.register[43],
	processor.regFile.register.sequential_s1e[11],
	"r12 %h          r12 %h         %b",
	processor.regFile.register.REGFILE.register[12],
	processor.regFile.register.REGFILE.register[44],
	processor.regFile.register.sequential_s1e[12],
	"r13 %h          r13 %h         %b",
	processor.regFile.register.REGFILE.register[13],
	processor.regFile.register.REGFILE.register[45],
	processor.regFile.register.sequential_s1e[13],
	"r14 %h          r14 %h         %b",
	processor.regFile.register.REGFILE.register[14],
	processor.regFile.register.REGFILE.register[46],
	processor.regFile.register.sequential_s1e[14],
	"r15 %h          r15 %h         %b",
	processor.regFile.register.REGFILE.register[15],
	processor.regFile.register.REGFILE.register[47],
	processor.regFile.register.sequential_s1e[15],
	"r16 %h          r16 %h         %b",
	processor.regFile.register.REGFILE.register[16],
	processor.regFile.register.REGFILE.register[48],
	processor.regFile.register.sequential_s1e[16],
	"r17 %h          r17 %h         %b",
	processor.regFile.register.REGFILE.register[17],
	processor.regFile.register.REGFILE.register[49],
	processor.regFile.register.sequential_s1e[17],
	"r18 %h          r18 %h         %b",
	processor.regFile.register.REGFILE.register[18],
	processor.regFile.register.REGFILE.register[50],
	processor.regFile.register.sequential_s1e[18],
	"r19 %h          r19 %h         %b",
	processor.regFile.register.REGFILE.register[19],
	processor.regFile.register.REGFILE.register[51],
	processor.regFile.register.sequential_s1e[19],
	"r20 %h          r20 %h         %b",
	processor.regFile.register.REGFILE.register[20],
	processor.regFile.register.REGFILE.register[52],
	processor.regFile.register.sequential_s1e[20],
//	"r21 %h          r21 %h",
//	processor.regFile.register.REGFILE.register[21],
//	processor.regFile.register.REGFILE.register[53],
//	"r22 %h          r22 %h",
//	processor.regFile.register.REGFILE.register[22],
//	processor.regFile.register.REGFILE.register[54],
//	"r23 %h          r23 %h",
//	processor.regFile.register.REGFILE.register[23],
//	processor.regFile.register.REGFILE.register[55],
	" Results: ",
	"r24 %h          r24 %h         %b",
	processor.regFile.register.REGFILE.register[24],
	processor.regFile.register.REGFILE.register[56],
	processor.regFile.register.sequential_s1e[24],
	"r25 %h          r25 %h         %b",
	processor.regFile.register.REGFILE.register[25],
	processor.regFile.register.REGFILE.register[57],
	processor.regFile.register.sequential_s1e[25],
//	"r26 %h          r26 %h		%b",
//	processor.regFile.register.REGFILE.register[26],
//	processor.regFile.register.REGFILE.register[58],
//	processor.regFile.register.sequential_s1e[26],
//	"r27 %h          r27 %h		%b",
//	processor.regFile.register.REGFILE.register[27],
//	processor.regFile.register.REGFILE.register[59],
//	processor.regFile.register.sequential_s1e[27],
//	"r28 %h          r28 %h		%b",
//	processor.regFile.register.REGFILE.register[28],
//	processor.regFile.register.REGFILE.register[60],
	"                      ",
	"SP  %h          SP  %h         %b",
	processor.regFile.register.REGFILE.register[29],
	processor.regFile.register.REGFILE.register[61],
	processor.regFile.register.sequential_s1e[29],
	"r30 %h          r30 %h         %b",
	processor.regFile.register.REGFILE.register[30],
	processor.regFile.register.REGFILE.register[62],
	processor.regFile.register.sequential_s1e[30],
	"r31 %h          r31 %h         %b",
	processor.regFile.register.REGFILE.register[31],
	processor.regFile.register.REGFILE.register[63],
	processor.regFile.register.sequential_s1e[31],
	"                          ",
//	"hi  %h          lo  %h",
//	processor.decodeExec.DataPath.AExecuteUnit.AALU.Hi_s1w,
//	processor.decodeExec.DataPath.AExecuteUnit.AALU.Lo_s1w
//	"index   %h       context %h",
//	processor.coproc0.tlb.Index,
//	processor.coproc0.cp0regdpath.Context,
//	"entrylo %h       entryhi %h",
//	processor.coproc0.tlb.EntryHi,
//	processor.coproc0.tlb.EntryLo,
//	"status  %h       cause   %h",
//	processor.coproc0.cp0regdpath.Status,
//	processor.coproc0.cp0regdpath.Cause
        "",
        "",
        "   Dave, Kevin, and Seye's Most Excellent LoadStore Unit",
        ,"","               ---------------",
        "               * Store Buffer *",
        "               ----------------",
        "NextStore    Data %h        %b   Addr %h         %b",
	loadStore.loadStoreUnit.storeBuffer.storeBufData.NextStoreData_s1m,
	loadStore.loadStoreUnit.storeBuffer.storeBufCont.NextStoreValid_s1m,
	loadStore.tagBuffer.tagBufData.NextStoreAddr_s1m,
	loadStore.tagBuffer.tagBufCont.NextStoreValid_s1m,
        "Store        Data %h        %b   Addr %h         %b",
        loadStore.DCACHE.storeData_s1store[31:0],
        loadStore.tagBuffer.tagBufCont.storeAddrValid_s1m,
        loadStore.storeAddr_s1m,
        loadStore.tagBuffer.tagBufCont.storeAddrValid_s1m,
	);
        end


// Signals for the 
    $gr_addwaves(
	"Phi1",Phi1,
	"Phi2",Phi2,
	"InAddr",InstrAddr_s2i,
	"IcMiss",ICacheMiss_v2r, 
	"MemExc",MemExcept_s1w,
	"InsIsSt",InstrIsStore_s1m,
	"InsIsLd",InstrIsLoad_s1m,
	"Commit",Commit_s1e,
	"Squash",Squash_s1e,
	"Reset",Reset,
	"Mv2Cp0",MvToCop0_s1m,
	"MvFCp0",MvFromCop0_s1m,
	"CopReg",CopRegNum_s1m,
	"Syscall",Syscall_s2m, 
	"Break",Break_s2m, 
	"RFE",RetFromExcept_s1e,
	"AIsBoost",AIsBoosted_s2e,
	"BIsBoost",BIsBoosted_s2e,
	"PhyAddr",PhysAddr_v2m,
	"ExcVect",ExceptVector_s1i,
	"Except",Except_s1w,
	"PCPID",PCPID_v2r, 
	"SysBit",SystemBit_s2e
        );

// Define the Load store group button

    $define_group_waves
	(7,"TestC",
	"Phi1",
	"Phi2",
	"InAddr",
	"IcMiss",
	"MemExc",
	"InsIsSt",
	"InsIsLd",
	"Commit",
	"Squash",
	"Reset",
	"Mv2Cp0",
	"MvFCp0",
	"CopReg",
	"Syscall",
	"Break",
	"RFE",
	"AIsBoost",
	"BIsBoost",
	"PhyAddr",
	"ExcVect",
	"Except",
	"PCPID",
	"SysBit"
        );

