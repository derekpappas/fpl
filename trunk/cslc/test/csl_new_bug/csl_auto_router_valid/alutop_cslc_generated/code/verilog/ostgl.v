`include "defines.v"

module ostgl(opifc0_a,
             opifc0_b,
             selifc0_s,
             outifc0_o);
// Location of source csl unit: file name = onestagealu2.csl line number = 54
  input [DATA_WIDTH - 1:0] opifc0_a;
  input [DATA_WIDTH - 1:0] opifc0_b;
  input selifc0_s;
  output [DATA_WIDTH - 1:0] outifc0_o;
  `include "ostgl.logic.v"
endmodule

