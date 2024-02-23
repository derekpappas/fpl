//-----------------------------------------------------------------------------
// Title         : 8-bit Ripple Adder
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : ripple_adder.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Simple structural model of an 8-bit ripple adder.
//
//-----------------------------------------------------------------------------
module fulladder(a, b, cin, sum, cout);
  input a, b, cin;
  output sum, cout;

  assign sum = a ^ b ^ cin;
  assign cout = a & b | a & cin | b & cin;
endmodule

module ripple_adder(a, b, sum, cout);
  input [7:0] a, b;
  output [7:0] sum;
  output cout;

  wire [7:0] c;  // used for carry connections

  assign c[0]=0;  // no carry input in this example

  fulladder f0(a[0], b[0], c[0], sum[0], c[1]);
  fulladder f1(a[1], b[1], c[1], sum[1], c[2]);
  fulladder f2(a[2], b[2], c[2], sum[2], c[3]);
  fulladder f3(a[3], b[3], c[3], sum[3], c[4]);
  fulladder f4(a[4], b[4], c[4], sum[4], c[5]);
  fulladder f5(a[5], b[5], c[5], sum[5], c[6]);
  fulladder f6(a[6], b[6], c[6], sum[6], c[7]);
  fulladder f7(a[7], b[7], c[7], sum[7], cout);
endmodule
