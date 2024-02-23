// Copyright 2003 Star Galaxy Publishing
// File: xor_gates.v

module xor_gates (bre, sty, tap);
  parameter SIZE= 4;

  input[SIZE-1:0] bre, sty;

  output[SIZE-1:0] tap;

  assign tap = bre ^ sty;
endmodule
