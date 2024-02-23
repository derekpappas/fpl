`include "defines.v"

module x1(sx1,
          ar_sa0_s10);
// Location of source csl unit: file name = temp.csl line number = 325
  output sx1;
  output [1 - 1:0] ar_sa0_s10;
  w1 w10(.ar_sa0_s10(ar_sa0_s10));
  `include "x1.logic.vh"
endmodule

