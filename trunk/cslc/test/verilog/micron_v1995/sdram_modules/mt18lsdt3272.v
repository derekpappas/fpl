// This module will need 1.2G of swap memory for full simulation.
// You can reduce it by changing the "parameter mem_sizes = value"
// in MT48LC32M4A2.V.

/****************************************************************************************
*
*    File Name:  MT18LSDT3272.V
*        Model:  BUS Functional
*      Version:  1.0a
*         Date:  April 6th, 1998
*    Simulator:  Model Technology VLOG (PC version 4.7i)
*
* Dependencies:  MT48LC32M4A2.V
*
*       Author:  Son P. Huynh
*        Email:  sphuynh@micron.com
*        Phone:  (208) 368-3825
*      Company:  Micron Technology, Inc.
*        Model:  MT18LSDT3272 (256MB DIMM MODULE)
*
*   Limitation:
*
*         Note:  Please use "ps" accuracy for the model to work properly
*
*   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
*                WHATSOEVER AND MICRON SPECIFICALLY DISCLAIMS ANY 
*                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
*                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
*
*                Copyright (c) 1997 Micron Semiconductor Products, Inc.
*                All rights researved
*
* Rev   Author                        Date        Changes
* ----  ----------------------------  ----------  ---------------------------------------
* 1.0a  Son Huynh  208-368-3825       04/06/1999  First Release
*       Micron Technology, Inc.                   - Simple testbench included
****************************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 100ps

module mt18lsdt3272 (Dq, Addr, Ba, Ck0, Cke0, S0_n, S2_n, Ras_n, Cas_n, We_n, Dqmb, Rege);

    input                      Ck0;                 // Clock
    input                      Cke0;                // Clock Enable
    inout             [71 : 0] Dq;                  // Data IO (CB[7:0] = Dq[71:64])
    input             [11 : 0] Addr;                // Address
    input              [1 : 0] Ba;                  // Bank
    input                      Cas_n;
    input                      Ras_n;
    input                      We_n;
    input                      S0_n, S2_n;          // Chip Select
    input              [7 : 0] Dqmb;                // Dq mask
    input                      Rege;                // Register Enable

    // Register
    reg               [11 : 0] rAddr;
    reg                        rWe_n;
    reg                        rCas_n;
    reg                        rRas_n;
    reg                        rCke0;
    reg                        rS0_n, rS2_n;
    reg                [7 : 0] rDqmb;
    reg                [1 : 0] rBa;

    parameter                  tPD = 3;             // Min = 1.4 ns, Max = 4.5 ns

    initial begin
        rAddr  <= 0;
        rWe_n  <= 1;
        rCas_n <= 1;
        rRas_n <= 1;
        rCke0  <= 1;
        rS0_n  <= 0;
        rS2_n  <= 0;
        rDqmb  <= 0;
        rBa    <= 0;
    end

    always @ (posedge Ck0) begin
        if (Rege == 1'b1) begin                     // Registered mode - synchronous propagation of signals
            rAddr  <= #tPD Addr;
            rWe_n  <= #tPD We_n;
            rCas_n <= #tPD Cas_n;
            rRas_n <= #tPD Ras_n;
            rCke0  <= #tPD Cke0;
            rS0_n  <= #tPD S0_n;
            rS2_n  <= #tPD S2_n;
            rDqmb  <= #tPD Dqmb;
            rBa    <= #tPD Ba;  
        end
    end

    always @ (Addr or We_n or Cas_n or Ras_n or Cke0 or S0_n or S2_n or Dqmb or Ba or Rege) begin
        if (Rege == 1'b0) begin                     // Buffered mode - asynchronous propagation of signals
            rAddr  <= #tPD Addr;
            rWe_n  <= #tPD We_n;
            rCas_n <= #tPD Cas_n;
            rRas_n <= #tPD Ras_n;
            rCke0  <= #tPD Cke0;
            rS0_n  <= #tPD S0_n;
            rS2_n  <= #tPD S2_n;
            rDqmb  <= #tPD Dqmb;
            rBa    <= #tPD Ba;  
        end                 
    end

    mt48lc32m4a2 U00 (Dq[ 3 :  0], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[0]);
    mt48lc32m4a2 U01 (Dq[ 7 :  4], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[0]);
    mt48lc32m4a2 U02 (Dq[11 :  8], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[1]);
    mt48lc32m4a2 U03 (Dq[15 : 12], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[1]);
    mt48lc32m4a2 U04 (Dq[67 : 64], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[1]);

    mt48lc32m4a2 U05 (Dq[19 : 16], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[2]);
    mt48lc32m4a2 U06 (Dq[23 : 20], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[2]);
    mt48lc32m4a2 U07 (Dq[27 : 24], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[3]);
    mt48lc32m4a2 U08 (Dq[31 : 28], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[3]);

    mt48lc32m4a2 U09 (Dq[35 : 32], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[4]);
    mt48lc32m4a2 U10 (Dq[39 : 36], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[4]);
    mt48lc32m4a2 U11 (Dq[43 : 40], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[5]);
    mt48lc32m4a2 U12 (Dq[47 : 44], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[5]);
    mt48lc32m4a2 U13 (Dq[71 : 68], rAddr, rBa, Ck0, rCke0, rS0_n, rRas_n, rCas_n, rWe_n, rDqmb[5]);

    mt48lc32m4a2 U14 (Dq[51 : 48], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[6]);
    mt48lc32m4a2 U15 (Dq[55 : 52], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[6]);
    mt48lc32m4a2 U16 (Dq[59 : 56], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[7]);
    mt48lc32m4a2 U17 (Dq[63 : 60], rAddr, rBa, Ck0, rCke0, rS2_n, rRas_n, rCas_n, rWe_n, rDqmb[7]);

endmodule
