// Copyright 2003 Star Galaxy Publishing
// File: odd_ones.v

module odd_ones (data_in, is_odd);
  input [5:0] data_in;

  output is_odd;

  assign is_odd = ^data_in;
endmodule
