module m;
  parameter P = 1;
  wire x;
  generate
    if (P == 1)
      assign x = 1'b0;
    else
      assign x = 1'b1;
  endgenerate
endmodule
