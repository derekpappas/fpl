// Copyright 2003 Star Galaxy Publishing
// File: unsigned_adder.v

module unsigned_adder (arb, tbe, sum);
  input [3:0] arb, tbe;

  output [4:0] sum;

  assign sum = arb + tbe;
endmodule
