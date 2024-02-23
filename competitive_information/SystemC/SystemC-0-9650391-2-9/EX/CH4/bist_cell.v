// Copyright 2003 Star Galaxy Publishing
// File: bist_cell.v

module bist_cell (b0, b1, d0, d1, z);
  input b0, b1, d0, d1;

  output z;
  reg z;

  always @(b0 or b1 or d0 or d1) begin:L1
    reg s1, s2, s3;

    s1 = ! (b0 & d1);
    s2 = ! (d0 & b1);
    s3 = ! (s2 | s1);
    s2 = s2 & s1;
    z = ! (s2 | s3);
  end
endmodule
