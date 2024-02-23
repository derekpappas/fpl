// Copyright 2003 Star Galaxy Publishing
// File: sync_count4.v

module sync_count4 (mclk, preset, updown, data_in, data_out);
  input mclk, preset, updown;
  input [3:0] data_in;

  output [3:0] data_out;
  reg [3:0] data_out;

  always @(posedge mclk)
    if (! preset)
      data_out = data_in;
    else
      if (updown)
        data_out = data_out + 1;
      else
        data_out = data_out - 1;
endmodule
