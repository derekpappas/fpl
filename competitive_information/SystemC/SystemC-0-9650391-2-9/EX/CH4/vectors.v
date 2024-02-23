// Copyright 2003 Star Galaxy Publishing
// File: vectors.v

module vectors (a, b, c, d, zcat, membit_x);
  input [3:0] a, b, c, d;

  output [3:0] zcat;
  reg [3:0] zcat;
  output membit_x;
  reg membit_x;

  reg [3:0] reg_bank [1:0];

  always @(a or b or c) begin
    zcat[3:1] = {a[2], c[3:2]};
    zcat[0] = b[0];

    reg_bank[1] = c & d;
    reg_bank[0] = a | b;
    membit_x = (reg_bank[1][3] & reg_bank[0][3]) | (reg_bank[1][2] &reg_bank[0][2]);
    //     membit_y = (reg_bank[1][1] & reg_bank[0][1]) | (reg_bank[1][0] & reg_bank[0][0]);
  end
endmodule
