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
//  Title: 	Register Window File
//  Created:	Sun May 29 16:29:22 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma.Stanford.EDU>
//
//
//  TestCodeWaves.v,v 7.4 1995/06/10 01:53:22 ricardog Exp
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
//
`include "torch.h"

	$gr_regs(" Seq. Reg        Boosted       Pointer",
	" r0 %h           r0 %h         %b ",
	`REG.register[0],
	`REG.register[32],
	`REG.sequential_s1e[0],
	" r1 %h           r1 %h         %b ",
	`REG.register[1],
	`REG.register[33],
	`REG.sequential_s1e[1],
	" r2 %h           r2 %h         %b",
	`REG.register[2],
	`REG.register[34],
	`REG.sequential_s1e[2],
	" r3 %h           r3 %h         %b",
	`REG.register[3],
	`REG.register[35],
	`REG.sequential_s1e[3],
	" r4 %h           r4 %h         %b",
	`REG.register[4],
	`REG.register[36],
	`REG.sequential_s1e[4],
	" r5 %h           r5 %h         %b",
	`REG.register[5],
	`REG.register[37],
	`REG.sequential_s1e[5],
	" r6 %h           r6 %h         %b",
	`REG.register[6],
	`REG.register[38],
	`REG.sequential_s1e[6],
	" r7 %h           r7 %h         %b",
	`REG.register[7],
	`REG.register[39],
	`REG.sequential_s1e[7],
	" r8 %h           r8 %h         %b",
	`REG.register[8],
	`REG.register[40],
	`REG.sequential_s1e[8],
	" r9 %h           r9 %h         %b",
	`REG.register[9],
	`REG.register[41],
	`REG.sequential_s1e[9],
	"r10 %h          r10 %h         %b",
	`REG.register[10],
	`REG.register[42],
	`REG.sequential_s1e[10],
	"r11 %h          r11 %h         %b",
	`REG.register[11],
	`REG.register[43],
	`REG.sequential_s1e[11],
	"r12 %h          r12 %h         %b",
	`REG.register[12],
	`REG.register[44],
	`REG.sequential_s1e[12],
	"r13 %h          r13 %h         %b",
	`REG.register[13],
	`REG.register[45],
	`REG.sequential_s1e[13],
	"r14 %h          r14 %h         %b",
	`REG.register[14],
	`REG.register[46],
	`REG.sequential_s1e[14],
	"r15 %h          r15 %h         %b",
	`REG.register[15],
	`REG.register[47],
	`REG.sequential_s1e[15],
	"r16 %h          r16 %h         %b",
	`REG.register[16],
	`REG.register[48],
	`REG.sequential_s1e[16],
	"r17 %h          r17 %h         %b",
	`REG.register[17],
	`REG.register[49],
	`REG.sequential_s1e[17],
	"r18 %h          r18 %h         %b",
	`REG.register[18],
	`REG.register[50],
	`REG.sequential_s1e[18],
	"r19 %h          r19 %h         %b",
	`REG.register[19],
	`REG.register[51],
	`REG.sequential_s1e[19],
	"r20 %h          r20 %h         %b",
	`REG.register[20],
	`REG.register[52],
	`REG.sequential_s1e[20],
//	"r21 %h          r21 %h",
//	`REG.register[21],
//	`REG.register[53],
//	"r22 %h          r22 %h",
//	`REG.register[22],
//	`REG.register[54],
//	"r23 %h          r23 %h",
//	`REG.register[23],
//	`REG.register[55],
	" Results: ",
	"r24 %h          r24 %h         %b",
	`REG.register[24],
	`REG.register[56],
	`REG.sequential_s1e[24],
	"r25 %h          r25 %h         %b",
	`REG.register[25],
	`REG.register[57],
	`REG.sequential_s1e[25],
//	"r26 %h          r26 %h		%b",
//	`REG.register[26],
//	`REG.register[58],
//	`REG.sequential_s1e[26],
//	"r27 %h          r27 %h		%b",
//	`REG.register[27],
//	`REG.register[59],
//	`REG.sequential_s1e[27],
//	"r28 %h          r28 %h		%b",
//	`REG.register[28],
//	`REG.register[60],
	"                      ",
	"SP  %h          SP  %h         %b",
	`REG.register[29],
	`REG.register[61],
	`REG.sequential_s1e[29],
	"r30 %h          r30 %h         %b",
	`REG.register[30],
	`REG.register[62],
	`REG.sequential_s1e[30],
	"r31 %h          r31 %h         %b",
	`REG.register[31],
	`REG.register[63],
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
	""
	);


