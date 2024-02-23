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
/* Filename: Fifo.parameters.v                                             */
/* Author: Johnie Au                                                       */
/* Release: 2002.03                                                        */
/* SCCS Path: /models/verilog/cy7c4808v25/                                 */
/* @(#)Fifo.parameters.v	1.2 03/21/02 */
/***************************************************************************/

parameter tsetup = 1.0,
          thold  = 0.6;
parameter trsts  = 4.0;
parameter trsth  = 4.0;
parameter tfss   = 4;
parameter tfsh   = 4;

parameter sort    = 1'b1;
parameter class   = 1'b0;

parameter background      = 80'h00000000000000000000;
parameter pattern_alt     = 3'b000;
parameter pattern_altb    = 3'b001;
parameter pattern_topo    = 3'b010;
parameter pattern_topob   = 3'b011;
parameter pattern_solid0  = 3'b100;
parameter pattern_solid1  = 3'b101;

parameter gb     = 0.20;

parameter busBigEndian    = 1'b1;
parameter busLittleEndian = 1'b0;
parameter BigEndian       = 1'b1;
parameter LittleEndian    = 1'b0;

parameter tmgIDT      = 1'b1;
parameter tmgFWFT     = 1'b0;
parameter STD      = 1'b1;
parameter FWFT   = 1'b0;

parameter PARALLEL64   = 64;
parameter PARALLEL16   = 16;
parameter PARALLEL8    = 8;

parameter pgmPARALLEL     = 1;
parameter pgmSERIAL       = 4;
parameter pgmPRELOAD8     = 8;
parameter pgmPRELOAD16    = 16;
parameter pgmPRELOAD64    = 64;

parameter PARALLEL     = 1;
parameter SERIAL       = 4;
parameter PRELOAD8     = 8;
parameter PRELOAD16    = 16;
parameter PRELOAD64    = 64;

parameter FIFO1       = 2'b01;
parameter FIFO2       = 2'b10;
parameter FIFO3       = 2'b11;

parameter tSKEW1_int = 0.8;
parameter tSKEW2_int = 0.8;

parameter opMasterReset   = 1;
parameter opPartialReset  = 2;
parameter opPProgramming  = 3;
parameter opSProgramming  = 4;
parameter opIDLE      = 5;
parameter opNormal        = 0;

parameter siz10 = 10;
parameter siz20 = 20;
parameter siz40 = 40;
parameter siz80 = 80;

parameter tRSF = 3;
parameter tWFF_ffbir = 3;
parameter tSKEW1 = 3;
parameter tPMF = 3;
parameter tA_fall = 3;

parameter tA   = 6;
parameter tREF = 6;
parameter tPAE = 6;
parameter tPAF = 6;
parameter tWFF = 6;

// datagen

parameter [83:0] user = 0;
parameter [83:0] up   = {4'd1,80'b0};
parameter [83:0] down = {4'd2,80'b0};
parameter [83:0] zero = {4'd3,80'b0};
parameter [83:0] one  = {4'd4,80'b0};
parameter [83:0] chk  = {4'd5,80'b0};
parameter [83:0] chkb = {4'd6,80'b0};
parameter [83:0] alt  = {4'd8,80'b0};
parameter [83:0] altb = {4'd9,80'b0};

parameter [83:0] abc  = {4'd7,80'b0};

parameter bistCLK   = 10;
