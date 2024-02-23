`timescale 1ns / 100ps

module mt9vddt1672ag (Dq, Dqs, Addr, Ba, Clk, Clk_n, Cke, Cs_n, Ras_n, Cas_n, We_n, Dm);

    inout [71 : 0] Dq;
    inout  [8 : 0] Dqs;
    input [11 : 0] Addr;
    input  [1 : 0] Ba;
    input  [2 : 0] Clk;
    input  [2 : 0] Clk_n;
    input  [1 : 0] Cke;             // CKE#[1] reserved for future use
    input  [1 : 0] Cs_n;            // CS# [1] reserved for future use
    input          Cas_n;
    input          Ras_n;
    input          We_n;
    input  [8 : 0] Dm;

    mt46v16m8 U1 (Dq[ 7 :  0], Dqs[0], Addr, Ba, Clk[0], Clk_n[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[0]);
    mt46v16m8 U2 (Dq[15 :  8], Dqs[1], Addr, Ba, Clk[0], Clk_n[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[1]);
    mt46v16m8 U3 (Dq[23 : 16], Dqs[2], Addr, Ba, Clk[0], Clk_n[0], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[2]);
    mt46v16m8 U4 (Dq[31 : 24], Dqs[3], Addr, Ba, Clk[1], Clk_n[1], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[3]);
    mt46v16m8 U5 (Dq[71 : 64], Dqs[8], Addr, Ba, Clk[1], Clk_n[1], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[8]);  // CB[7:0]
    mt46v16m8 U6 (Dq[39 : 32], Dqs[4], Addr, Ba, Clk[1], Clk_n[1], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[4]);
    mt46v16m8 U7 (Dq[47 : 40], Dqs[5], Addr, Ba, Clk[2], Clk_n[2], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[5]);
    mt46v16m8 U8 (Dq[55 : 48], Dqs[6], Addr, Ba, Clk[2], Clk_n[2], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[6]);
    mt46v16m8 U9 (Dq[63 : 56], Dqs[7], Addr, Ba, Clk[2], Clk_n[2], Cke[0], Cs_n[0], Ras_n, Cas_n, We_n, Dm[7]);

endmodule
