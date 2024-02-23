/****************************************************************************************
*
*    File Name:  MT36LSDF12872.V
*        Model:  BUS Functional
*      Version:  1.0
*         Date:  September 25th, 2001
*    Simulator:  Model Technology
*
* Dependencies:  MT48LC64M4A2.V
*
*       Author:  Yong Phan
*        Email:  yjphan@micron.com
*        Phone:  (208) 363-2184
*      Company:  Micron Technology, Inc.
*        Model:  MT36LSDF12872 (1GB REGISTERED DIMM MODULE)
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
*                Copyright (c) 2001 Micron Semiconductor Products, Inc.
*                All rights researved
*
* Rev   Author                        Date        Changes
* ----  ----------------------------  ----------  ---------------------------------------
* 1.0   Yong Phan  208-363-2184       09/25/2001  First Release
*       Micron Technology, Inc.                   - Simple testbench included
****************************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 100ps

module mt36lsdf12872 (Dq, Addr, Ba, Clk, Cke, Cs_n, Ras_n, Cas_n, We_n, Dqm, Rege);

    inout             [71 : 0] Dq;                  // Data IO (CB[7:0] = Dq[71:64])
    input             [12 : 0] Addr;                // Address
    input              [1 : 0] Ba;                  // Bank
    input              [3 : 0] Clk;                 // Clock (Ck1, Ck2, and Ck3 not used)
    input              [1 : 0] Cke;                 // Clock Enable (Cke1 not used)
    input              [3 : 0] Cs_n;                // Chip Select
    input                      Cas_n;
    input                      Ras_n;
    input                      We_n;
    input              [7 : 0] Dqm;                 // Dq mask
    input                      Rege;                // Register Enable

    // Register
    reg               [12 : 0] rAddr;
    reg                [1 : 0] rBa;
    reg                [1 : 0] rCke;
    reg                [3 : 0] rCs_n;
    reg                        rRas_n;
    reg                        rCas_n;
    reg                        rWe_n;
    reg                [7 : 0] rDqm;

    parameter                  tPD = 2.5;           // Min = 1.4 ns, Max = 3.5 ns

    always @ (posedge Clk[0]) begin
        if (Rege == 1'b1) begin                     // Registered mode - synchronous propagation of signals
            rAddr  <= #tPD Addr;
            rBa    <= #tPD Ba;  
            rCke   <= #tPD Cke;
            rCs_n  <= #tPD Cs_n;
            rRas_n <= #tPD Ras_n;
            rCas_n <= #tPD Cas_n;
            rWe_n  <= #tPD We_n;
            rDqm   <= #tPD Dqm;
        end
    end
/*
    always @ (Addr or Ba or Cke or Cs_n or Ras_n or Cas_n or We_n or Dqm or Rege) begin
        if (Rege == 1'b0) begin                     // Buffered mode - asynchronous propagation of signals
            rAddr  <= #tPD Addr;
            rBa    <= #tPD Ba;  
            rCke   <= #tPD Cke;
            rCs_n  <= #tPD Cs_n;
            rRas_n <= #tPD Ras_n;
            rCas_n <= #tPD Cas_n;
            rWe_n  <= #tPD We_n;
            rDqm   <= #tPD Dqm;
        end                 
    end
*/
    mt48lc64m4a2 U11 (Dq[ 3 :  0], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[0]);
    mt48lc64m4a2 U29 (Dq[ 3 :  0], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[0]);

    mt48lc64m4a2 U12 (Dq[ 7 :  4], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[0]);
    mt48lc64m4a2 U30 (Dq[ 7 :  4], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[0]);

    mt48lc64m4a2 U13 (Dq[11 :  8], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[1]);
    mt48lc64m4a2 U31 (Dq[11 :  8], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[1]);

    mt48lc64m4a2 U14 (Dq[15 : 12], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[1]);
    mt48lc64m4a2 U32 (Dq[15 : 12], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[1]);

    mt48lc64m4a2 U05 (Dq[67 : 64], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[1]);
    mt48lc64m4a2 U23 (Dq[67 : 64], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[1]);


    mt48lc64m4a2 U15 (Dq[19 : 16], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[2]);
    mt48lc64m4a2 U33 (Dq[19 : 16], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[2]);

    mt48lc64m4a2 U16 (Dq[23 : 20], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[2]);
    mt48lc64m4a2 U34 (Dq[23 : 20], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[2]);

    mt48lc64m4a2 U17 (Dq[27 : 24], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[3]);
    mt48lc64m4a2 U35 (Dq[27 : 24], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[3]);

    mt48lc64m4a2 U18 (Dq[31 : 28], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[3]);
    mt48lc64m4a2 U36 (Dq[31 : 28], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[3]);


    mt48lc64m4a2 U01 (Dq[35 : 32], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[4]);
    mt48lc64m4a2 U19 (Dq[35 : 32], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[4]);

    mt48lc64m4a2 U02 (Dq[39 : 36], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[4]);
    mt48lc64m4a2 U20 (Dq[39 : 36], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[4]);

    mt48lc64m4a2 U03 (Dq[43 : 40], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[5]);
    mt48lc64m4a2 U21 (Dq[43 : 40], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[5]);

    mt48lc64m4a2 U04 (Dq[47 : 44], rAddr, rBa, Clk[0], rCke[0], rCs_n[1], rRas_n, rCas_n, rWe_n, rDqm[5]);
    mt48lc64m4a2 U22 (Dq[47 : 44], rAddr, rBa, Clk[0], rCke[0], rCs_n[0], rRas_n, rCas_n, rWe_n, rDqm[5]);

    mt48lc64m4a2 U06 (Dq[71 : 68], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[5]);
    mt48lc64m4a2 U24 (Dq[71 : 68], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[5]);


    mt48lc64m4a2 U07 (Dq[51 : 48], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[6]);
    mt48lc64m4a2 U25 (Dq[51 : 48], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[6]);

    mt48lc64m4a2 U08 (Dq[55 : 52], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[6]);
    mt48lc64m4a2 U26 (Dq[55 : 52], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[6]);

    mt48lc64m4a2 U09 (Dq[59 : 56], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[7]);
    mt48lc64m4a2 U27 (Dq[59 : 56], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[7]);

    mt48lc64m4a2 U10 (Dq[63 : 60], rAddr, rBa, Clk[0], rCke[0], rCs_n[3], rRas_n, rCas_n, rWe_n, rDqm[7]);
    mt48lc64m4a2 U28 (Dq[63 : 60], rAddr, rBa, Clk[0], rCke[0], rCs_n[2], rRas_n, rCas_n, rWe_n, rDqm[7]);

endmodule
