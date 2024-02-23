// Copyright 2003 Star Galaxy Publishing
// File: non_compute_left.v

module non_compute_left (store, addr, mem);
  input store;
  input [2:0] addr;

  output [7:0] mem;

  assign mem[addr] = store;
endmodule
