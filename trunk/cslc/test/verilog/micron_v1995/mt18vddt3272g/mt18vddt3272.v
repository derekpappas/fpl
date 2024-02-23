/****************************************************************************************
*
*    File Name:  MT18VDDT3272.V
*        Model:  BUS Functional
*      Version:  1.0a
*         Date:  September 21st, 2000
*    Simulator:  Model Technology
*
* Dependencies:  MT46V32M4.V
*
*       Author:  Son P. Huynh
*        Email:  sphuynh@micron.com
*        Phone:  (208) 368-3825
*      Company:  Micron Technology, Inc.
*        Model:  MT18VDDT3272 (256MB DDR DIMM MODULE)
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
* 1.0a  Son Huynh  208-368-3825       05/04/1999  First Release
*       Micron Technology, Inc.                   - Simple testbench included
****************************************************************************************/

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 1ps

module mt18vddt3272 (Dq, Dqs, Addr, Ba, Ck, Ck_n, Cke, Cs_n, Ras_n, Cas_n, We_n, Reset_n);

    inout             [71 : 0] Dq;                  // Data IO (CB[7:0] = Dq[71:64])
    inout             [17 : 0] Dqs;                 // Dqs
    input             [11 : 0] Addr;                // Address
    input              [1 : 0] Ba;                  // Bank
    input                      Ck;                  // Clock
    input                      Ck_n;                // Clock (differential)
    input                      Cke;                 // Clock Enable
    input                      Cs_n;                // Chip Select
    input                      Ras_n;
    input                      Cas_n;
    input                      We_n;
    input                      Reset_n;             // Reset

    // Register
    reg               [11 : 0] rAddr;
    reg                [1 : 0] rBa;
    reg                        rCke;
    reg                        rCs_n;
    reg                        rRas_n;
    reg                        rCas_n;
    reg                        rWe_n;

    parameter                  tPD = 3;             // Min = 2 ns, Max = 5 ns

    initial begin
        rAddr   <= 12'b0;
        rBa     <=  2'b0;
        rCke    <=  1'b1;
        rCs_n   <=  1'b0;
        rRas_n  <=  1'b1;
        rCas_n  <=  1'b1;
        rWe_n   <=  1'b1;
    end

    always @ (posedge Ck or Reset_n) begin
        if (Reset_n == 1'b0) begin                          // Reset - asynchronously force all register outputs LOW
            rAddr  <= #tPD 12'b0;
            rBa    <= #tPD  2'b0;  
            rCke   <= #tPD  1'b0;
            rCs_n  <= #tPD  1'b0;
            rRas_n <= #tPD  1'b0;
            rCas_n <= #tPD  1'b0;
            rWe_n  <= #tPD  1'b0;
        end else if (Ck == 1'b1 && Reset_n == 1'b1) begin   // Registered mode - synchronous propagation of signals
            rAddr  <= #tPD Addr;
            rBa    <= #tPD Ba;  
            rCke   <= #tPD Cke;
            rCs_n  <= #tPD Cs_n;
            rRas_n <= #tPD Ras_n;
            rCas_n <= #tPD Cas_n;
            rWe_n  <= #tPD We_n;
        end
    end

    mt46v32m4 U00 (Dq[ 3 :  0], Dqs[ 0], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U01 (Dq[ 7 :  4], Dqs[ 1], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U02 (Dq[11 :  8], Dqs[ 2], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U03 (Dq[15 : 12], Dqs[ 3], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U04 (Dq[67 : 64], Dqs[ 4], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);    // CB [3 : 0]
    mt46v32m4 U05 (Dq[19 : 16], Dqs[ 5], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U06 (Dq[23 : 20], Dqs[ 6], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U07 (Dq[27 : 24], Dqs[ 7], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U08 (Dq[31 : 28], Dqs[ 8], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);

    mt46v32m4 U09 (Dq[35 : 32], Dqs[ 9], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U10 (Dq[39 : 36], Dqs[10], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U11 (Dq[43 : 40], Dqs[11], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U12 (Dq[47 : 44], Dqs[12], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U13 (Dq[71 : 68], Dqs[13], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);    // CB [7 : 4]
    mt46v32m4 U14 (Dq[51 : 48], Dqs[14], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U15 (Dq[55 : 52], Dqs[15], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U16 (Dq[59 : 56], Dqs[16], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);
    mt46v32m4 U17 (Dq[63 : 60], Dqs[17], rAddr, rBa, Ck, Ck_n, rCke, rCs_n, rRas_n, rCas_n, rWe_n, 1'b0);

endmodule