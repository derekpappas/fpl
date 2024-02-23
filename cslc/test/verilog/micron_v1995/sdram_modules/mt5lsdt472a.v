/*
            Module : MT5LSDT472A

       Description : 4MEG x 72 SDRAM DIMM (Using 5 MT48LC4M16A2)

        Limitation : Serial Presence-Detect (SPD) not implemented

              Note : This module need approximate 200MB to simulate

    Datasheet Link : http://www.micron.com/mti/msp/html/datasheet.html

       Models Link : http://www.micron.com/mti/msp/models/index.html
*/

`timescale 1ns / 100ps

module mt5lsdt472a (Dq, Addr, Ba, Clk, Cke, Cs_n, Ras_n, Cas_n, We_n, Dqm);

    inout             [71 : 0] Dq;                  // Data IO      (Dq [71 : 64] = CB [7 : 0])
    input             [11 : 0] Addr;                // Address
    input              [1 : 0] Ba;                  // Bank
    input              [1 : 0] Clk;                 // Clock        (Clk  [0] = CK0,  Clk  [1] = CK2,   CK1  = CK3  = GND)
    input              [1 : 0] Cke;                 // Clock Enable (Cke  [0] = CKE0, Cke  [1] = CKE2,  CKE1 = CKE3 = NC)
    input              [1 : 0] Cs_n;                // Chip Select  (Cs_n [0] = S0#,  Cs_n [1] = S2#,   S1#  = S3#  = NC)
    input                      Cas_n;
    input                      Ras_n;
    input                      We_n;
    input              [7 : 0] Dqm;                 // Dq mask
    
    supply1                    VCC;

    wire               [7 : 0] NCU3 = 8'bz;         // U03 (No connect - for upper byte - use Hi-Z in model)

    mt48lc4m16a2 U00 (Dq[15 :  0], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[1 : 0]);
    mt48lc4m16a2 U01 (Dq[31 : 16], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[3 : 2]);
    mt48lc4m16a2 U02 (Dq[47 : 32], Addr, Ba, Clk[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dqm[5 : 4]);
    mt48lc4m16a2 U03 ({NCU3, Dq[71 : 64]}, Addr, Ba, Clk[1], Cke[1], Cs_n[1], Ras_n, Cas_n, We_n, {VCC, Dqm[1]});   // CB [7 : 0], VCC so upper byte Hi-Z
    mt48lc4m16a2 U04 (Dq[63 : 48], Addr, Ba, Clk[1], Cke[1], Cs_n[1], Ras_n, Cas_n, We_n, Dqm[7 : 6]);


endmodule
