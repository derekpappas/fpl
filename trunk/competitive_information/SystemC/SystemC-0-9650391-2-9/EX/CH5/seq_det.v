// Copyright 2003 Star Galaxy Publishing
// File: seq_det.v

module seq_det (clk, data, seq_found);
  input clk, data;

  output seq_found;

  reg first, second, third;

  always @(posedge clk) begin
    first <= data;
    second <= first;
    third <= second;
  end

  assign seq_found = first & (!second) & third;
endmodule
