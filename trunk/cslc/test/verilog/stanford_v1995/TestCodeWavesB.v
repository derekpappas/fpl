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
//  Title: 	Registers Window File
//  Created:	Thu Mar 24 15:34:17 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  TestCodeWavesB.v,v 7.4 1995/06/10 01:53:25 ricardog Exp
//
//  TORCH Research Group.
//  Stanford University.
//	1993.
//
//	Description: 
//
//	Hierarchy: 
//
`include "torch.h"

	$gr_regs(" Seq. Reg        Boosted       Pointer",
	" r0 %h           r0 %h         %b ",
	`REG.REGFILE.register[0],
	`REG.REGFILE.register[32],
	`REG.sequential_s1e[0],
	" r1 %h           r1 %h         %b ",
	`REG.REGFILE.register[1],
	`REG.REGFILE.register[33],
	`REG.sequential_s1e[1],
	" r2 %h           r2 %h         %b",
	`REG.REGFILE.register[2],
	`REG.REGFILE.register[34],
	`REG.sequential_s1e[2],
	" r3 %h           r3 %h         %b",
	`REG.REGFILE.register[3],
	`REG.REGFILE.register[35],
	`REG.sequential_s1e[3],
	" r4 %h           r4 %h         %b",
	`REG.REGFILE.register[4],
	`REG.REGFILE.register[36],
	`REG.sequential_s1e[4],
	" r5 %h           r5 %h         %b",
	`REG.REGFILE.register[5],
	`REG.REGFILE.register[37],
	`REG.sequential_s1e[5],
	" r6 %h           r6 %h         %b",
	`REG.REGFILE.register[6],
	`REG.REGFILE.register[38],
	`REG.sequential_s1e[6],
	" r7 %h           r7 %h         %b",
	`REG.REGFILE.register[7],
	`REG.REGFILE.register[39],
	`REG.sequential_s1e[7],
	" r8 %h           r8 %h         %b",
	`REG.REGFILE.register[8],
	`REG.REGFILE.register[40],
	`REG.sequential_s1e[8],
	" r9 %h           r9 %h         %b",
	`REG.REGFILE.register[9],
	`REG.REGFILE.register[41],
	`REG.sequential_s1e[9],
	"r10 %h          r10 %h         %b",
	`REG.REGFILE.register[10],
	`REG.REGFILE.register[42],
	`REG.sequential_s1e[10],
	"r11 %h          r11 %h         %b",
	`REG.REGFILE.register[11],
	`REG.REGFILE.register[43],
	`REG.sequential_s1e[11],
	"r12 %h          r12 %h         %b",
	`REG.REGFILE.register[12],
	`REG.REGFILE.register[44],
	`REG.sequential_s1e[12],
	"r13 %h          r13 %h         %b",
	`REG.REGFILE.register[13],
	`REG.REGFILE.register[45],
	`REG.sequential_s1e[13],
	"r14 %h          r14 %h         %b",
	`REG.REGFILE.register[14],
	`REG.REGFILE.register[46],
	`REG.sequential_s1e[14],
	"r15 %h          r15 %h         %b",
	`REG.REGFILE.register[15],
	`REG.REGFILE.register[47],
	`REG.sequential_s1e[15],
	"r16 %h          r16 %h         %b",
	`REG.REGFILE.register[16],
	`REG.REGFILE.register[48],
	`REG.sequential_s1e[16],
	"r17 %h          r17 %h         %b",
	`REG.REGFILE.register[17],
	`REG.REGFILE.register[49],
	`REG.sequential_s1e[17],
	"r18 %h          r18 %h         %b",
	`REG.REGFILE.register[18],
	`REG.REGFILE.register[50],
	`REG.sequential_s1e[18],
	"r19 %h          r19 %h         %b",
	`REG.REGFILE.register[19],
	`REG.REGFILE.register[51],
	`REG.sequential_s1e[19],
	"r20 %h          r20 %h         %b",
	`REG.REGFILE.register[20],
	`REG.REGFILE.register[52],
	`REG.sequential_s1e[20],
//	"r21 %h          r21 %h",
//	`REG.REGFILE.register[21],
//	`REG.REGFILE.register[53],
//	"r22 %h          r22 %h",
//	`REG.REGFILE.register[22],
//	`REG.REGFILE.register[54],
//	"r23 %h          r23 %h",
//	`REG.REGFILE.register[23],
//	`REG.REGFILE.register[55],
	" Results: ",
	"r24 %h          r24 %h         %b",
	`REG.REGFILE.register[24],
	`REG.REGFILE.register[56],
	`REG.sequential_s1e[24],
	"r25 %h          r25 %h         %b",
	`REG.REGFILE.register[25],
	`REG.REGFILE.register[57],
	`REG.sequential_s1e[25],
//	"r26 %h          r26 %h		%b",
//	`REG.REGFILE.register[26],
//	`REG.REGFILE.register[58],
//	`REG.sequential_s1e[26],
//	"r27 %h          r27 %h		%b",
//	`REG.REGFILE.register[27],
//	`REG.REGFILE.register[59],
//	`REG.sequential_s1e[27],
//	"r28 %h          r28 %h		%b",
//	`REG.REGFILE.register[28],
//	`REG.REGFILE.register[60],
	"                      ",
	"SP  %h          SP  %h         %b",
	`REG.REGFILE.register[29],
	`REG.REGFILE.register[61],
	`REG.sequential_s1e[29],
	"r30 %h          r30 %h         %b",
	`REG.REGFILE.register[30],
	`REG.REGFILE.register[62],
	`REG.sequential_s1e[30],
	"r31 %h          r31 %h         %b",
	`REG.REGFILE.register[31],
	`REG.REGFILE.register[63],
	`REG.sequential_s1e[31],
	"                          ",
//	"hi  %h          lo  %h",
//	`AALU.Hi_s1w,
//	`AALU.Lo_s1w
//	"index   %h       context %h",
//	`TLB.Index,
//	`COP0.cp0regdpath.Context,
//	"entrylo %h       entryhi %h",
//	COP0.tlb.EntryHi,
//	COP0.tlb.EntryLo,
//	"status  %h       cause   %h",
//	COP0.cp0regdpath.Status,
//	COP0.cp0regdpath.Cause
        "Commit_s1e %b  Commit_s2e %b Commit_s1m %b Commit_s2m %b",
        `SBUFF.storeBufCont.Commit_s1e,
        `SBUFF.storeBufCont.Commit_s2e,
        `SBUFF.storeBufCont.Commit_s1m,
        `SBUFF.storeBufCont.Commit_s2m,
        "",
        "",
        "   Dave, Kevin, and Seye's Most Excellent LoadStore Unit",
        "Asequential_s1m  %b      Asequential_s2m %b",
        `SBUFF.storeBufCont.Asequential_s1m,
        `SBUFF.storeBufCont.Asequential_s2m,
        ,"","               -----------------",
        "               * Store Buffer A *",
        "               ------------------",
        "BuffAHead_s1m  %b          BuffATail_s2m %b",
        `SBUFF.storeBufCont.BuffAHead_s1m,
        `SBUFF.storeBufCont.BuffATail_s2m,
        "BuffAEmpty_s2m %b          BuffAFull_s1m %b",
        `SBUFF.storeBufCont.BuffAEmpty_s2m,
        `SBUFF.storeBufCont.BuffAFull_s1m,
        "BuffAAddr_s1m[3]  %h     ",
        `SBUFF.storeBufData.BuffAAddr3_s1m,
        "BuffAData_s1m [3] %h       V %b ",
        `SBUFF.storeBufData.BuffAData3_s1m,
        `SBUFF.storeBufCont.BuffAValid_s1m[3],
        "BuffAAddr_s1m[2]  %h",
        `SBUFF.storeBufData.BuffAAddr2_s1m,
        "BuffAData_s1m [2] %h       V %b ",
        `SBUFF.storeBufData.BuffAData2_s1m,
        `SBUFF.storeBufCont.BuffAValid_s1m[2],
        "BuffAAddr_s1m[1]  %h",
        `SBUFF.storeBufData.BuffAAddr1_s1m,
        "BuffAData_s1m [1] %h       V %b ",
        `SBUFF.storeBufData.BuffAData1_s1m,
        `SBUFF.storeBufCont.BuffAValid_s1m[1],
        "BuffAAddr_s1m[0]  %h",
        `SBUFF.storeBufData.BuffAAddr0_s1m,
        "BuffAData_s1m [0] %h       V %b ",
        `SBUFF.storeBufData.BuffAData0_s1m,
        `SBUFF.storeBufCont.BuffAValid_s1m[0],
        ,"","               -----------------",
        "               * Store Buffer B *",
        "               ------------------",
        "BuffBHead_s1m  %b          BuffBTail_s2m %b",
        `SBUFF.storeBufCont.BuffBHead_s1m,
        `SBUFF.storeBufCont.BuffBTail_s2m,
        "BuffBEmpty_s2m %b          BuffBFull_s1m %b",
        `SBUFF.storeBufCont.BuffBEmpty_s2m,
        `SBUFF.storeBufCont.BuffBFull_s1m,
        "BuffBAddr_s1m[3]  %h",
        `SBUFF.storeBufData.BuffBAddr3_s1m,
        "BuffBData_s1m [3] %h         %b",
        `SBUFF.storeBufData.BuffBData3_s1m,
      `SBUFF.storeBufCont.BuffBValid_s1m[3],
        "BuffBAddr_s1m[2]  %h",
        `SBUFF.storeBufData.BuffBAddr2_s1m,
        "BuffBData_s1m [2] %h         %b",
        `SBUFF.storeBufData.BuffBData2_s1m,
      `SBUFF.storeBufCont.BuffBValid_s1m[2],
        "BuffBAddr_s1m[1]  %h",
        `SBUFF.storeBufData.BuffBAddr1_s1m,
        "BuffBData_s1m [1] %h         %b",
        `SBUFF.storeBufData.BuffBData1_s1m,
      `SBUFF.storeBufCont.BuffBValid_s1m[1],
        "BuffBAddr_s1m[0]  %h",
        `SBUFF.storeBufData.BuffBAddr0_s1m,
        "BuffBData_s1m [0] %h         %b",
        `SBUFF.storeBufData.BuffBData0_s1m,
	`SBUFF.storeBufCont.BuffBValid_s1m[0],
        "StoreData         %h         %b",
        loadStore.DCACHE.storeData_s1store[31:0],
        `TBUFF.tagBufCont.storeAddrValid_s1m,
        "StoreAddr         %h         %b",
        loadStore.storeAddr_s1m,
        `TBUFF.tagBufCont.storeAddrValid_s1m,
        "NextStore         %h         %b",
        `TBUFF.tagBufData.NextStoreAddr_s2m,
        `TBUFF.tagBufCont.NextStoreValid_s2m,
        "               -----------------",
        "               * Tag Buffer A *",
        "               ------------------",
        "BuffAHead_s1m  %b          BuffATail_s2m %b",
        `TBUFF.tagBufCont.BuffAHead_s1m,
        `TBUFF.tagBufCont.BuffATail_s2m,
        "BuffAEmpty_s2m %b          BuffAFull_s1m %b",
        `TBUFF.tagBufCont.BuffAEmpty_s2m,
        `TBUFF.tagBufCont.BuffAFull_s1m,
        "BuffAAddr_s1m[3]  %h          V %b",
        `TBUFF.tagBufData.BuffAAddr3_s1m,
        `TBUFF.tagBufCont.BuffAValid_s1m[3],
        "BuffAAddr_s1m[2]  %h          V %b",
        `TBUFF.tagBufData.BuffAAddr2_s1m,
        `TBUFF.tagBufCont.BuffAValid_s1m[2],
        "BuffAAddr_s1m[1]  %h          V %b",
        `TBUFF.tagBufData.BuffAAddr1_s1m,
        `TBUFF.tagBufCont.BuffAValid_s1m[1],
        "BuffAAddr_s1m[0]  %h          V %b",
        `TBUFF.tagBufData.BuffAAddr0_s1m,
        `TBUFF.tagBufCont.BuffAValid_s1m[0],
        "               -----------------",
        "               * Tag Buffer B *",
        "               ------------------",
        "BuffBAddrOut   %h              ",
        `TBUFF.tagBufData.BuffBAddrOut_s1m,
        "BuffBHead_s1m  %b          BuffBTail_s2m %b",
        `TBUFF.tagBufCont.BuffBHead_s1m,
        `TBUFF.tagBufCont.BuffBTail_s2m,
        "BuffBEmpty_s2m %b          BuffBFull_s1m %b",
        `TBUFF.tagBufCont.BuffBEmpty_s2m,
        `TBUFF.tagBufCont.BuffBFull_s1m,
        "BuffBAddr_s1m[3]  %h          V %b",
        `TBUFF.tagBufData.BuffBAddr3_s1m,
        `TBUFF.tagBufCont.BuffBValid_s1m[3],
        "BuffBAddr_s1m[2]  %h          V %b",
        `TBUFF.tagBufData.BuffBAddr2_s1m,
        `TBUFF.tagBufCont.BuffBValid_s1m[2],
        "BuffBAddr_s1m[1]  %h          V %b",
        `TBUFF.tagBufData.BuffBAddr1_s1m,
        `TBUFF.tagBufCont.BuffBValid_s1m[1],
        "BuffBAddr_s1m[0]  %h          V %b",
        `TBUFF.tagBufData.BuffBAddr0_s1m,
        `TBUFF.tagBufCont.BuffBValid_s1m[0]
	);

