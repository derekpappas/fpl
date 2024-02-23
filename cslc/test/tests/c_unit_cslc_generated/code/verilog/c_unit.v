`include "defines.v"

module c_unit(in1,
              in2,
              in3,
              in4,
              out1,
              out2,
              out3,
              out4,
              clk);
// Location of source csl unit: file name = tb_multi_instance.csl line number = 34
  input [4 - 1:0] in1;
  input [4 - 1:0] in2;
  input in3;
  input in4;
  input clk;
  output [4 - 1:0] out1;
  output [4 - 1:0] out2;
  output [4 - 1:0] out3;
  output [4 - 1:0] out4;
  wire [4 - 1:0] s_in1;
  wire s_in2;
  assign   s_in1 = in1 & in2;
  assign   s_in2 = in3 | in4;
  b_unit b0(.clk(clk),
            .in1(s_in1),
            .in2(s_in2),
            .out1(out1),
            .out2(out2),
            .out3(out3),
            .out4(out4));
  `include "c_unit.logic.vh"
endmodule

