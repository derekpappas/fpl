`include "defines.v"

module u_dep();
// Location of source csl unit: file name = parameter_test2.csl line number = 12
  wire reset;
  wire enable;
  wire clk;
  wire [4 - 1:0] d1;
  wire [8 - 1:0] d2;
  wire [16 - 1:0] d3;
  wire [4 - 1:0] q1;
  wire [8 - 1:0] q2;
  wire [16 - 1:0] q3;
  u_ff #(.width(4))
       ff1(.clk(clk),
           .d(d1),
           .enable(enable),
           .q(q1),
           .reset(reset));
  u_ff #(.width(8))
       ff2(.clk(clk),
           .d(d2),
           .enable(enable),
           .q(q2),
           .reset(reset));
  u_ff #(.width(16))
       ff3(.clk(clk),
           .d(d3),
           .enable(enable),
           .q(q3),
           .reset(reset));
  `include "u_dep.logic.v"
endmodule

