// Copyright 2003 Star Galaxy Publishing
// File: upc.v

module fc_with_pc (din, clock, preclr, q, notq);
  input din, clock, preclr;
  output q, notq;
  reg q;

  always @(posedge preclr or negedge clock)
    if (preclr)
      q = 0;
    else
      q = din;

  assign notq = ! q;
endmodule

module upc (clk, up_down, pc, q0, q1, q2);
  input clk, up_down, pc;
  output q0, q1, q2;
  wire t01, bit11, t12, t13, bit21;

  fc_with_pc lq0 (.clock(clk), .din(qn0), .preclr(pc), .q(q0), .notq(qn0));
  fc_with_pc lq1 (.clock(clk), .din(bit11), .preclr(pc), .q(q1), .notq(qn1));
  fc_with_pc lq2 (bit21, clk, pc, q2, qn2);

  assign t01 = up_down ^ q0;
  assign bit11 = t01 ^ qn1;
  assign t12 = up_down ^ q1;
  assign t13 = t01 | t12;
  assign bit21 = t13 ^ qn2;
endmodule
