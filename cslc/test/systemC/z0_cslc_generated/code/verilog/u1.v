`include "defines.v"

module u1(su1,
          ar_sa0_s10);
// Location of source csl unit: file name = temp.csl line number = 304
  output su1;
  output [1 - 1:0] ar_sa0_s10;
  t1 t10(.ar_sa0_s10(ar_sa0_s10));
  `include "u1.logic.vh"
endmodule

