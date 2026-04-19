module m;
  wire x;
  genvar i;
  generate
    for (i = 0; i < 1; i = i + 1) begin : gfor
      assign x = 1'b0;
    end
  endgenerate
endmodule
