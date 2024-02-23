// Copyright 2003 Star Galaxy Publishing
// File: full_adder.v

module full_adder (a, b, cin, sum, cout);
  input a, b, cin;
  output sum, cout;
  reg sum, cout;

  always @(a or b or cin) begin
    sum = (a ^ b) ^ cin;
    cout = (a & b) | (a & cin) | (b & cin);
  end
endmodule