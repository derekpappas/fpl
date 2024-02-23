`include "defines.v"

module y1(ar_sa0_s10);
// Location of source csl unit: file name = temp.csl line number = 333
  output [1 - 1:0] ar_sa0_s10;
  x1 x10(.ar_sa0_s10(ar_sa0_s10),
         .sx1(ar_sa0_s10));
  `include "y1.logic.vh"
endmodule

