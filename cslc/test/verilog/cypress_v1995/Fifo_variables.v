/***************************************************************************/
/* Cypress Semiconductor, Inc. Company Confidential                        */
/* Copyright 2002, Cypress Semiconductor Inc. All Rights reserved          */
/* Cypress Semiconductor proprietary source code                           */
/* Permission to use, modify or copy this code is prohibited               */
/* without the express written consent of Cypress Semiconductor Inc        */
/* 3901 North First Street,                                                */
/* San Jose, CA 95134                                                      */
/*                                                                         */
/* Description: CY7C4808V25-200                                            */
/* Filename: Fifo.variables.v                                              */
/* Author: Johnie Au                                                       */
/* Release: 2002.03                                                        */
/* SCCS Path: /models/verilog/cy7c4808v25/                                 */
/* @(#)Fifo.variables.v	1.2 03/21/02 */
/***************************************************************************/

integer count1,count2;
integer regbit;
integer i;

integer loop,xloop,bit_num;

integer e_count;

reg [7:0] ResetSM;
reg [7:0] SetSM;
wire p,q;
wire r_p,r_q;
reg [2:0] EWR;
reg lerror;
reg abslerror;
reg herror;
reg absherror;
integer lerror_count;
integer herror_count;
integer abslerror_count;
integer absherror_count;
integer depth;
integer os; // offset value for testbenches
integer pae_offset,paf_offset,serial_bits;

reg sysclk1, sysclk2;
reg vplclk1, vplclk2;

reg [50*8-1:0] testlabel;
reg [50*8-1:0] testlabel_prev;
reg [24*8-1:0] testname;
reg [24*8-1:0] testname_prev;
reg [10*8-1:0] tmode,pmode,bmode;
reg [6*8-1:0] pstate;
reg [20*8-1:0] Error_msg;

reg aeflag_1;

time inc1,inc2;

reg [2:0] Row;

wire  [79:0] A; 
wire  [79:0] T; // cascade
wire  [79:0] B; 
wire  [79:0] eB,eT; 

wire [79:70] A7;
wire [69:60] A6;
wire [59:50] A5;
wire [49:40] A4;
wire [39:30] A3;
wire [29:20] A2;
wire [19:10] A1;
wire [ 9: 0] A0;

reg  [79:70] A7_i;
reg  [69:60] A6_i;
reg  [59:50] A5_i;
reg  [49:40] A4_i;
reg  [39:30] A3_i;
reg  [29:20] A2_i;
reg  [19:10] A1_i;
reg  [ 9: 0] A0_i;

wire [79:70] T7;
wire [69:60] T6;
wire [59:50] T5;
wire [49:40] T4;
wire [39:30] T3;
wire [29:20] T2;
wire [19:10] T1;
wire [ 9: 0] T0;

wire [79:70] B7;
wire [69:60] B6;
wire [59:50] B5;
wire [49:40] B4;
wire [39:30] B3;
wire [29:20] B2;
wire [19:10] B1;
wire [ 9: 0] B0;

wire [79:70] eB7;
wire [69:60] eB6;
wire [59:50] eB5;
wire [49:40] eB4;
wire [39:30] eB3;
wire [29:20] eB2;
wire [19:10] eB1;
wire [ 9: 0] eB0;

reg [79:70] eB7_o;
reg [69:60] eB6_o;
reg [59:50] eB5_o;
reg [49:40] eB4_o;
reg [39:30] eB3_o;
reg [29:20] eB2_o;
reg [19:10] eB1_o;
reg [ 9: 0] eB0_o;

wire [79:70] eT7;
wire [69:60] eT6;
wire [59:50] eT5;
wire [49:40] eT4;
wire [39:30] eT3;
wire [29:20] eT2;
wire [19:10] eT1;
wire [ 9: 0] eT0;

assign A0 = A[ 9: 0];
assign A1 = A[19:10];
assign A2 = A[29:20];
assign A3 = A[39:30];
assign A4 = A[49:40];
assign A5 = A[59:50];
assign A6 = A[69:60];
assign A7 = A[79:70];

assign T0 = T[ 9: 0];
assign T1 = T[19:10];
assign T2 = T[29:20];
assign T3 = T[39:30];
assign T4 = T[49:40];
assign T5 = T[59:50];
assign T6 = T[69:60];
assign T7 = T[79:70];

assign B0 = B[ 9: 0];
assign B1 = B[19:10];
assign B2 = B[29:20];
assign B3 = B[39:30];
assign B4 = B[49:40];
assign B5 = B[59:50];
assign B6 = B[69:60];
assign B7 = B[79:70];

assign eB0 = eB[ 9: 0];
assign eB1 = eB[19:10];
assign eB2 = eB[29:20];
assign eB3 = eB[39:30];
assign eB4 = eB[49:40];
assign eB5 = eB[59:50];
assign eB6 = eB[69:60];
assign eB7 = eB[79:70];

assign eT0 = eT[ 9: 0];
assign eT1 = eT[19:10];
assign eT2 = eT[29:20];
assign eT3 = eT[39:30];
assign eT4 = eT[49:40];
assign eT5 = eT[59:50];
assign eT6 = eT[69:60];
assign eT7 = eT[79:70];

wire [15:0] X_offset;
wire [15:0] Y_offset;

supply1 vpwr,vddq;
supply0 vgnd;

///// fullchip pinnames /////

reg SYNC_i;
reg MRSb;
reg CLKA,CLKB;
reg PRSb,RTbSPMb,BEFWFTb,CSAb,CSBb;
reg ENA,ENB;
reg SIZE1A,SIZE1B;
reg SIZE2A,SIZE2B;
reg FS0SD,FS1SENb;
reg ZQ,S_H;
reg Vref;
reg TRST,TCK,TM,TDI;
reg OEb;
integer archA,archB;
integer sizeA,sizeB;

reg test_done;

reg strobe_q_sw;
reg strobe_efb_sw;
reg strobe_aeb_sw;
reg strobe_afb_sw;
reg strobe_ffb_sw;
reg strobe_tdo_sw;

reg strobe_q_sw_cache;

reg q1Error;
reg efb1Error;
reg aeb1Error;
reg afb1Error;
reg ffb1Error;

reg Error;

event tst_done;

integer next_ptr;

integer all_sizes;

reg MARK1 ;
reg MARK2 ;

reg STROBE_ON_OFF;


integer bistcycle;

reg IF;

reg CLOCKS;

integer payload;
integer ratio;

reg _underflow;
reg _overflow;

integer ts;

// test vector

`define lt1001

`define NUMOFPINS   256

`define MAXPINS         256
//`define TOTALPINS       256

`ifdef lt1001
 `ifdef short_form
   `define TOTALPINS        59
 `else
   `define TOTALPINS       200
 `endif

`endif

`ifdef hp83000j
 `ifdef short_form
   `define TOTALPINS       63
 `else
   `define TOTALPINS       205
 `endif
`endif

`ifdef versatest
 `define TOTALPINS       83
`endif

`define CYCLENAMECHARS   10

`define MAXVECTORS  256
`define ECRLOGCHARS 20

reg [8*`MAXPINS-1:8*(`MAXPINS-`TOTALPINS-`CYCLENAMECHARS)] vector                   ;
reg [8*`MAXPINS-1:8*(`MAXPINS-`TOTALPINS-`CYCLENAMECHARS)] vector_prev              ;
reg [8*`MAXPINS-1:8*(`MAXPINS-`TOTALPINS-`CYCLENAMECHARS)] vector_tmp               ;
reg [8*`MAXPINS-1:8*(`MAXPINS-`TOTALPINS                )] vector_vpl               ;
reg [8*`MAXPINS-1:8*(`MAXPINS-`TOTALPINS-`CYCLENAMECHARS)] Mvector [0:`MAXVECTORS-1];
reg [8*`MAXPINS-1:8*(`MAXPINS-`TOTALPINS-`CYCLENAMECHARS)] Svector [0:`MAXVECTORS-1];
reg [8*`CYCLENAMECHARS-1:0] cycleName;
reg [8*`CYCLENAMECHARS-1:0] cycle_vpl;
integer taskNum,ltcycle;

reg Free_Running_Clock;

reg
     MRSb_i,
     PRSb_i,
     BEFWFTb_i,
     RTbSPMb_i,
     SIZE1A_i,
     SIZE1B_i,
     SIZE2A_i,
     SIZE2B_i,
     FS0SD_i,
     FS1SENb_i,
     MARK1_i,
     MARK2_i,
     SH_i,
     CLKA_i,
     ENA_i,
     CSAb_i,
     eAFb_o,
     eFFbIR_o,
     CLKB_i,
     CSBb_i,
     ENB_i,
     eEFbOR_o,
     eAEb_o,
     OEb_i,
     TRST_i,
     TCK_i,
     TMS_i,
     TDI_i,
     TDO_o,
     Vref_i,
     ZQ_i,
     TM_i;

reg
	 SH;

reg 
     [79:0] A_i; 
reg 
     [79:0] eB_o; 
reg 
     [79:0] eBB; 

integer 
	mcount,guessloop,scount,icount,repeatcount;

reg
	mflushed,sflushed;

integer f_vec;
integer tm_vec;

integer vpl_count;

reg 
	marker_set;

reg
	debug;

integer
	xwords;

integer
	labelnum;

reg
	Sync_i;

reg
	pgm_cycle;

integer
	wpp,rpp;

wire [79:0] A_datagen;
