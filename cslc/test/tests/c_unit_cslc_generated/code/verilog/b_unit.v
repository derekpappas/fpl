`include "defines.v"

module b_unit(in1,
              in2,
              out1,
              out2,
              out3,
              out4,
              clk);
// Location of source csl unit: file name = tb_multi_instance.csl line number = 15
  input [4 - 1:0] in1;
  input in2;
  input clk;
  output [4 - 1:0] out1;
  output [4 - 1:0] out2;
  output [4 - 1:0] out3;
  output [4 - 1:0] out4;
  a_unit a0(.clk(clk),
            .in1(in1),
            .in2(in2),
            .out1(out1));
  a_unit a1(.clk(clk),
            .in1(in1),
            .in2(in2),
            .out1(out2));
  a_unit a2(.clk(clk),
            .in1(in1),
            .in2(in2),
            .out1(out3));
  a_unit a3(.clk(clk),
            .in1(in1),
            .in2(in2),
            .out1(out4));
  `include "b_unit.logic.vh"
endmodule

