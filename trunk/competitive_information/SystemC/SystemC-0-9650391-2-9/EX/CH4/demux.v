// Copyright 2003 Star Galaxy Publishing
// File: demux.v

module demux (a, z); 
  input [1:0] a;

  output [3:0] z;
  reg [3:0] z;

  integer i;

  always @(a)
    for (i=0; i<4; i=i+1)
      if (a == i)
        z[i] = 1;
      else
        z[i] = 0;
endmodule
