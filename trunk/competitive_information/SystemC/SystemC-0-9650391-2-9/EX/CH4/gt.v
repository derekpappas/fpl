// Copyright 2003 Star Galaxy Publishing
// File: gt.v

module gt (a, b, z);
  input [7:0] a, b;
  output z;

  assign z = a[3:0] > b[7:4];
endmodule
