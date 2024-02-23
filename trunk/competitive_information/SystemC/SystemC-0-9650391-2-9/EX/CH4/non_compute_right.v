// Copyright 2003 Star Galaxy Publishing
// File: non_compute_right.v

module non_compute_right (data, index, dout);
  input [3:0] data;
  input [1:0] index;
  output dout;

  assign dout = data[index];
endmodule
