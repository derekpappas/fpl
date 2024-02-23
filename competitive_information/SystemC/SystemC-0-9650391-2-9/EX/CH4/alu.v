// Copyright 2003 Star Galaxy Publishing
// File: alu.v

module alu (a, b, op, z);
  input [1:0] a, b, op;

  output[1:0] z;
  reg[1:0] z;

  always @(a or b or op)
    case (op) 
      0 : z = a + b; 
      1 : z = a -b;
      2 : z = a * b;
      3 : z = a / b;
    endcase
endmodule
