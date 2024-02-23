// Copyright 2003 Star Galaxy Publishing
// File: not_equals.v

module not_equals (a, b, z);
  input [3:0] a, b;
  output z;

  integer ia, ib;

  always @(a)
   ia = a;

  always @(b)
   ib = b;

  assign z = ia != ib;
endmodule
