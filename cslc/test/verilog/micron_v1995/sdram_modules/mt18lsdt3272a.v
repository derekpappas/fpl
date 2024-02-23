/*
            Module : MT18LSDT3272A

       Description : 32MEG x 72 SDRAM DIMM (Using 18 MT48LC16M8A2)

        Limitation : Serial Presence-Detect (SPD) not implemented

              Note : This module need approximate 600MB to simulate

    Datasheet Link : http://www.micron.com/mti/msp/html/datasheet.html

       Models Link : http://www.micron.com/mti/msp/models/index.html
*/

`timescale 1ns / 100ps

module MT18LSDT3272A (Dq, Addr, Ba, Clk, Cke, Cs_n, Ras_n, Cas_n, We_n, Dqm);

    inout             [71 : 0] Dq;                  // Data IO (CB[7:0] = Dq[71:64])
    input             [11 : 0] Addr;                // Address
    input              [1 : 0] Ba;                  // Bank
    input              [3 : 0] Clk;                 // Clock
    input              [1 : 0] Cke;                 // Clock Enable
    input              [3 : 0] Cs_n;                // Chip Select
    input                      Cas_n;
    input                      Ras_n;
    input                      We_n;
    input              [7 : 0] Dqm;                 // Dq mask

    mt48lc16m8a2 U00 (Dq[ 7 :  0], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[0]);
    mt48lc16m8a2 U09 (Dq[ 7 :  0], Addr, Ba, Clk[1], Cke[1], Cs_n[1], Ras_n, Cas_n, We_n, Dqm[0]);

    mt48lc16m8a2 U01 (Dq[15 :  8], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[1]);
    mt48lc16m8a2 U10 (Dq[15 :  8], Addr, Ba, Clk[1], Cke[1], Cs_n[1], Ras_n, Cas_n, We_n, Dqm[1]);

    mt48lc16m8a2 U02 (Dq[71 : 64], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[1]);    // CB[7:0]
    mt48lc16m8a2 U11 (Dq[71 : 64], Addr, Ba, Clk[1], Cke[1], Cs_n[1], Ras_n, Cas_n, We_n, Dqm[5]);    // CB[7:0]

    mt48lc16m8a2 U03 (Dq[23 : 16], Addr, Ba, Clk[2], Cke[0], Cs_n[2], Ras_n, Cas_n, We_n, Dqm[2]);
    mt48lc16m8a2 U12 (Dq[23 : 16], Addr, Ba, Clk[3], Cke[1], Cs_n[3], Ras_n, Cas_n, We_n, Dqm[2]);

    mt48lc16m8a2 U04 (Dq[31 : 24], Addr, Ba, Clk[2], Cke[0], Cs_n[2], Ras_n, Cas_n, We_n, Dqm[3]);
    mt48lc16m8a2 U13 (Dq[31 : 24], Addr, Ba, Clk[3], Cke[1], Cs_n[3], Ras_n, Cas_n, We_n, Dqm[3]);

    mt48lc16m8a2 U05 (Dq[39 : 32], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[4]);
    mt48lc16m8a2 U14 (Dq[39 : 32], Addr, Ba, Clk[1], Cke[1], Cs_n[1], Ras_n, Cas_n, We_n, Dqm[4]);

    mt48lc16m8a2 U06 (Dq[47 : 40], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[5]);
    mt48lc16m8a2 U15 (Dq[47 : 40], Addr, Ba, Clk[1], Cke[1], Cs_n[1], Ras_n, Cas_n, We_n, Dqm[5]);

    mt48lc16m8a2 U07 (Dq[55 : 48], Addr, Ba, Clk[2], Cke[0], Cs_n[2], Ras_n, Cas_n, We_n, Dqm[6]);
    mt48lc16m8a2 U16 (Dq[55 : 48], Addr, Ba, Clk[3], Cke[1], Cs_n[3], Ras_n, Cas_n, We_n, Dqm[6]);

    mt48lc16m8a2 U08 (Dq[63 : 56], Addr, Ba, Clk[2], Cke[0], Cs_n[2], Ras_n, Cas_n, We_n, Dqm[7]);
    mt48lc16m8a2 U17 (Dq[63 : 56], Addr, Ba, Clk[3], Cke[1], Cs_n[3], Ras_n, Cas_n, We_n, Dqm[7]);

endmodule
