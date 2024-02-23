`include "defines.v"

module u_ff(d,
            q,
            reset,
            enable,
            clk);
// Location of source csl unit: file name = parameter_test2.csl line number = 2
  parameter width = 1;
  input [width - 1:0] d;
  input reset;
  input enable;
  input clk;
  output [width - 1:0] q;
  `include "u_ff.logic.v"
endmodule

