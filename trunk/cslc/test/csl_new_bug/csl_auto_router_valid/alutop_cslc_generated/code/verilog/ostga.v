`include "defines.v"

module ostga(opifc0_a,
             opifc0_b,
             selifc0_s,
             outifc0_o,
             cin,
             cout);
// Location of source csl unit: file name = onestagealu2.csl line number = 40
  input [DATA_WIDTH - 1:0] opifc0_a;
  input [DATA_WIDTH - 1:0] opifc0_b;
  input selifc0_s;
  input cin;
  output [DATA_WIDTH - 1:0] outifc0_o;
  output cout;
  `include "ostga.logic.v"
endmodule

