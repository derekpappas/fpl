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
//  Title: 	Store Buffer -- Address Only
//  Created:	Mon Apr 25 19:14:00 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  storeBufferAddr.v,v 1.11 1995/01/28 00:49:09 ricardog Exp
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
//	Modified: Thu Dec  1 21:57:20 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//
`include "torch.h"

module storeBufferAddr (
    Alpha_q2,
    Beta_q2,
    BResultBus_s1m,
    PhysAddr_v2m,
    byteOffset_s2m,
    MemOp_s2m,
    AbufSel_s1w,
    BbufSel_s1w,
    selAstore_s1w,
    storeBufAddr_s1w,
    AMatch_v1m,
    BMatch_v1m
    );

//
// Clocks
//
input	[3:0]	Alpha_q2;		// qual clocks for A-buffer
input	[3:0]	Beta_q2;		// qual clocks for B-buffer

//
// Store Address
//
input	[31:2]	PhysAddr_v2m;		// After translation
input	[12:2]	BResultBus_s1m;		// Index to check for conclict 
input	[1:0]	byteOffset_s2m;	        // Byte offset of mem op

//
// Kind of store (word, hword, byte)
//
input	[2:0]	MemOp_s2m;

//
// Select one of the four entries from each buffer
//
input	[3:0]	AbufSel_s1w;
input	[3:0]	BbufSel_s1w;

//
// And select either the A or B buffers
//
input		selAstore_s1w;

//
// Next stores addres
//
output	[34:0]	storeBufAddr_s1w;

//
// Conflict between load/store and buffer
//
output	[3:0]	AMatch_v1m;		// conflict in A-buffer
output	[3:0]	BMatch_v1m;		// conflict in B-buffer

//
// Local wires
//
wire	[34:0]	physAddr_v2m;		// concatenated with memOp and byte off

wire	[34:0]	AbufAddr0_s1w;		// The actual store buffer entries
wire	[34:0]	AbufAddr1_s1w;		// (only the addr)
wire	[34:0]	AbufAddr2_s1w;
wire	[34:0]	AbufAddr3_s1w;
wire	[34:0]	AstoreAddr_s1w;		// Select one of the four entries

wire	[34:0]	BbufAddr0_s1w;		// One of the buffers is the boosted
wire	[34:0]	BbufAddr1_s1w;		// buffer, the other is the sequential
wire	[34:0]	BbufAddr2_s1w;		// buffer. Sequential stores only go 
wire	[34:0]	BbufAddr3_s1w;		// into the buffer until a free cycle 
wire	[34:0]	BstoreAddr_s1w;		// is available


assign physAddr_v2m = {MemOp_s2m, PhysAddr_v2m, byteOffset_s2m};
//---------------------------------------------------------------------------
//			    --- A-Buffer ---
//---------------------------------------------------------------------------
// Four latches, each with a comparator after to detect a conflict
//
PHI2_LATCH_35	AbufAddr0(AbufAddr0_s1w, physAddr_v2m, Alpha_q2[0]);
COMP_10		AbufAddr0Conf(AMatch_v1m[0], 
		    BResultBus_s1m[12:3], AbufAddr0_s1w[12:3]);
PHI2_LATCH_35	AbufAddr1(AbufAddr1_s1w, physAddr_v2m, Alpha_q2[1]);
COMP_10		AbufAddr1Conf(AMatch_v1m[1], 
		    BResultBus_s1m[12:3], AbufAddr1_s1w[12:3]);
PHI2_LATCH_35	AbufAddr2(AbufAddr2_s1w, physAddr_v2m, Alpha_q2[2]);
COMP_10		AbufAddr2Conf(AMatch_v1m[2], 
		    BResultBus_s1m[12:3], AbufAddr2_s1w[12:3]);
PHI2_LATCH_35	AbufAddr3(AbufAddr3_s1w, physAddr_v2m, Alpha_q2[3]);
COMP_10		AbufAddr3Conf(AMatch_v1m[3],
		    BResultBus_s1m[12:3], AbufAddr3_s1w[12:3]);
//
// Select one of the four entries
//
MUX4_35		AbufMux(AstoreAddr_s1w,
		    AbufAddr0_s1w, AbufAddr1_s1w,
		    AbufAddr2_s1w, AbufAddr3_s1w,
		    AbufSel_s1w[0], AbufSel_s1w[1],
		    AbufSel_s1w[2], AbufSel_s1w[3]);

//---------------------------------------------------------------------------
//			    --- B-Buffer ---
//---------------------------------------------------------------------------
// Four latches, each with a comparator after to detect a conflict
//
PHI2_LATCH_35	BbufAddr0(BbufAddr0_s1w, physAddr_v2m, Beta_q2[0]);
COMP_10		BbufAddr0Conf(BMatch_v1m[0], 
		    BResultBus_s1m[12:3], BbufAddr0_s1w[12:3]);
PHI2_LATCH_35	BbufAddr1(BbufAddr1_s1w, physAddr_v2m, Beta_q2[1]);
COMP_10		BbufAddr1Conf(BMatch_v1m[1], 
		    BResultBus_s1m[12:3], BbufAddr1_s1w[12:3]);
PHI2_LATCH_35	BbufAddr2(BbufAddr2_s1w, physAddr_v2m, Beta_q2[2]);
COMP_10		BbufAddr2Conf(BMatch_v1m[2],
		    BResultBus_s1m[12:3], BbufAddr2_s1w[12:3]);
PHI2_LATCH_35	BbufAddr3(BbufAddr3_s1w, physAddr_v2m, Beta_q2[3]);
COMP_10		BbufAddr3Conf(BMatch_v1m[3],
		    BResultBus_s1m[12:3], BbufAddr3_s1w[12:3]);
//
// Select one of the four entries
//
MUX4_35		BbufMux(BstoreAddr_s1w,
		    BbufAddr0_s1w, BbufAddr1_s1w,
		    BbufAddr2_s1w, BbufAddr3_s1w,
		    BbufSel_s1w[0], BbufSel_s1w[1],
		    BbufSel_s1w[2], BbufSel_s1w[3]);

//
// Select either the A or B next store address
//
MUX2_35		AorBMux(storeBufAddr_s1w,
		    AstoreAddr_s1w,
		    BstoreAddr_s1w,
		    selAstore_s1w);


endmodule				// stoAddrBuffer



