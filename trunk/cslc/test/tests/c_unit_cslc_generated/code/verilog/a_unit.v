`include "defines.v"

module a_unit(in1,
              in2,
              out1,
              clk);
// Location of source csl unit: file name = tb_multi_instance.csl line number = 3
  input [4 - 1:0] in1;
  input in2;
  input clk;
  output [4 - 1:0] out1;
  assign   out1 = {in1[2:0], in2};
  `include "a_unit.logic.vh"
endmodule

