// Copyright 2003 Star Galaxy Publishing
// File: count4.v

module count4 (mclk, clear, updown, data_out);
  input mclk, clear, updown;

  output [3:0] data_out;
  reg [3:0] data_out;

  always @(posedge mclk or negedge clear)
    if (! clear)
      data_out = 0;
    else
      if (updown)
        data_out = data_out + 1;
      else
        data_out = data_out - 1;
endmodule
