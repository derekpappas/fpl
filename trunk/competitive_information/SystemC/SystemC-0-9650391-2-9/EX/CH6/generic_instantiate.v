// Copyright 2003 Star Galaxy Publishing
// File: generic_instantiate.v

module generic_instantiate (tsq, rsq);
  input [5:0] tsq;

  output rsq;
  wire and2out, and4out;

  assign and2out = & tsq[1:0];
  assign and4out = & tsq[5:2];
  assign rsq = and4out ^ and2out;
endmodule
