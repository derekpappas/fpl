`timescale 1ns / 100ps

module mt8vddt1664a (Dq, Dqs, Addr, Ba, Clk, Clk_n, Cke, Cs_n, Ras_n, Cas_n, We_n, Dm);

    inout [63 : 0] Dq;
    inout  [7 : 0] Dqs;
    input [11 : 0] Addr;
    input  [1 : 0] Ba;
    input  [2 : 0] Clk;
    input  [2 : 0] Clk_n;
    input  [1 : 0] Cke;             // CKE#[1] reserved for future use
    input  [1 : 0] Cs_n;            // CS# [1] reserved for future use
    input          Cas_n;
    input          Ras_n;
    input          We_n;
    input  [7 : 0] Dm;

    mt46v16m8 U01 (Dq[ 7 :  0], Dqs[0], Addr, Ba, Clk[0], Clk_n[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[0]);
    mt46v16m8 U11 (Dq[15 :  8], Dqs[1], Addr, Ba, Clk[0], Clk_n[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[1]);
    mt46v16m8 U03 (Dq[23 : 16], Dqs[2], Addr, Ba, Clk[1], Clk_n[1], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[2]);
    mt46v16m8 U13 (Dq[31 : 24], Dqs[3], Addr, Ba, Clk[1], Clk_n[1], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[3]);
    mt46v16m8 U14 (Dq[39 : 32], Dqs[4], Addr, Ba, Clk[1], Clk_n[1], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[4]);
    mt46v16m8 U06 (Dq[47 : 40], Dqs[5], Addr, Ba, Clk[2], Clk_n[2], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[5]);
    mt46v16m8 U16 (Dq[55 : 48], Dqs[6], Addr, Ba, Clk[2], Clk_n[2], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[6]);
    mt46v16m8 U08 (Dq[63 : 56], Dqs[7], Addr, Ba, Clk[2], Clk_n[2], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[7]);

endmodule
