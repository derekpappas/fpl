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
//  Title: 	Store Buffer -- Data Only
//  Created:	Mon Apr 25 19:14:00 1994
//  Author: 	Ricardo E. Gonzalez
//		<ricardog@chroma>
//
//
//  storeBufferData.v,v 1.7 1995/01/28 00:49:15 ricardog Exp
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
//	Modified: Thu Dec  1 21:57:45 1994	<ricardog@chroma.Stanford.EDU>
//	* Changed MUX2 implementation.
//
`include "torch.h"

module storeBufferData (
    Alpha_q2,
    Beta_q2,
    AbufSel_s1w,
    BbufSel_s1w,
    selAstore_s1w,
    storeData_s2m,
    storeBufData_s1w
    );

//
// Clocks
//
input	[3:0]	Alpha_q2;		  // qual clocks for A-buffer
input	[3:0]	Beta_q2;		  // qual clocks for B-buffer

//
// Store Address
//
input	[31:0]	storeData_s2m;		  // Data to be put in buffer

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
output	[31:0]	storeBufData_s1w;

//
// Local wires
//
wire	[31:0]	AbufData0_s1w;		  // The actual store buffer entries
wire	[31:0]	AbufData1_s1w;		  // (only the Data)
wire	[31:0]	AbufData2_s1w;
wire	[31:0]	AbufData3_s1w;
wire	[31:0]	AstoreData_s1w;		  // Select one of the four entries

wire	[31:0]	BbufData0_s1w;		  // One of the buffers is the boosted
wire	[31:0]	BbufData1_s1w;		  // buffer, the other is the sequential
wire	[31:0]	BbufData2_s1w;		  // buffer. Sequential stores only go 
wire	[31:0]	BbufData3_s1w;		  // into the buffer until a free cycle 
wire	[31:0]	BstoreData_s1w;		  // is available
wire	[31:0]	storeBufData_s1w;	  // Out from mux is latched and driven

//---------------------------------------------------------------------------
//			    --- A-Buffer ---
//---------------------------------------------------------------------------
// Four latches, each with a comparator after to detect a conflict
//
PHI2_LATCH_32	AbufData0(AbufData0_s1w, storeData_s2m, Alpha_q2[0]);
PHI2_LATCH_32	AbufData1(AbufData1_s1w, storeData_s2m, Alpha_q2[1]);
PHI2_LATCH_32	AbufData2(AbufData2_s1w, storeData_s2m, Alpha_q2[2]);
PHI2_LATCH_32	AbufData3(AbufData3_s1w, storeData_s2m, Alpha_q2[3]);

//
// Select one of the four entries
//
MUX4_32		AbufMux(AstoreData_s1w,
		    AbufData0_s1w, AbufData1_s1w,
		    AbufData2_s1w, AbufData3_s1w,
		    AbufSel_s1w[0], AbufSel_s1w[1],
		    AbufSel_s1w[2], AbufSel_s1w[3]);

//---------------------------------------------------------------------------
//			    --- B-Buffer ---
//---------------------------------------------------------------------------
// Four latches, each with a comparator after to detect a conflict
//
PHI2_LATCH_32	BbufData0(BbufData0_s1w, storeData_s2m, Beta_q2[0]);
PHI2_LATCH_32	BbufData1(BbufData1_s1w, storeData_s2m, Beta_q2[1]);
PHI2_LATCH_32	BbufData2(BbufData2_s1w, storeData_s2m, Beta_q2[2]);
PHI2_LATCH_32	BbufData3(BbufData3_s1w, storeData_s2m, Beta_q2[3]);

//
// Select one of the four entries
//
MUX4_32		BbufMux(BstoreData_s1w,
		    BbufData0_s1w, BbufData1_s1w,
		    BbufData2_s1w, BbufData3_s1w,
		    BbufSel_s1w[0], BbufSel_s1w[1],
		    BbufSel_s1w[2], BbufSel_s1w[3]);

//
// Select either the A or B next store Dataess
//
MUX2_32		AorBMux(storeBufData_s1w,
		    AstoreData_s1w,
		    BstoreData_s1w,
		    selAstore_s1w);

endmodule				  // storeBuffer
