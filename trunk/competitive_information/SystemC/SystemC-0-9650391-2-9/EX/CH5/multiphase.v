// Copyright 2003 Star Galaxy Publishing
// File: multiphase.v

module multiphase (zclk, a, b, c, e);
  input zclk, a, b, c;

  output e;
  reg e;

  reg d;

  always @(posedge zclk)
    e = d & c;
  
  always @(negedge zclk)
    d = a & b;
endmodule
