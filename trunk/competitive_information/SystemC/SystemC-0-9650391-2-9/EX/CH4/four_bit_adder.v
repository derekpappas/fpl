// Copyright 2003 Star Galaxy Publishing
// File: four_bit_adder.v

module four_bit_adder (sha, shb, shcarry_in, shsum, shcarry_out);
  input [3:0] sha, shb;
  input       shcarry_in;

  output [3:0] shsum;
  reg [3:0]    shsum;
  output       shcarry_out;
  reg          shcarry_out;

  integer      j;
  reg [4:0]    tcarry;

  task one_bit_adder;
    input  a, b, cin;
    output sum, cout;
  begin
    sum = a ^ b ^ cin;
    cout = (a & b) | (a & cin) | (b & cin); 
  end
  endtask

  always @(sha or shb or shcarry_in) begin
    tcarry[0] = shcarry_in;

    for (j=0; j <4; j=j+1) 
      one_bit_adder (sha[j], shb[j], tcarry[j], shsum[j], tcarry[j+1]);

    shcarry_out = tcarry[4];
  end
endmodule
