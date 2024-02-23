`include "defines.v"

module v1(ar_sa0_s10);
// Location of source csl unit: file name = temp.csl line number = 311
  output [1 - 1:0] ar_sa0_s10;
  u1 u10(.ar_sa0_s10(ar_sa0_s10),
         .su1(ar_sa0_s10));
  `include "v1.logic.vh"
endmodule

