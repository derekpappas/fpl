`define tb = 10
`timescale 1s/1ms
module tb;
  reg clk;
  initial clk=0;
  always #10 clk=~clk;
endmodule