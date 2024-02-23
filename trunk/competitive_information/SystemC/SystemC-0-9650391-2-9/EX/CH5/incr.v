// Copyright 2003 Star Galaxy Publishing
// File: incr.v

module incr (phy, one_count, z);
  input phy;
  input [1:0] one_count;

  output [1:0] z;
  reg [1:0] z;
  // reg [1:0] ones;

  always @(phy or one_count)
    if (phy)
      z = one_count + 1;

endmodule
