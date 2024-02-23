// Copyright 2003 Star Galaxy Publishing
// File: tristate_reg.v

module tristate_reg (clock, reset, reg_enable, output_enable, data_in, data_out);
  input clock, reset, reg_enable, output_enable;
  input [1:0] data_in;

  output [1:0] data_out;
  reg [1:0] data_out;

  reg[1:0] reg_out;

  always @(negedge clock or posedge reset)
    if (reset)
      reg_out = 0;
    else
      if (reg_enable)
        reg_out = data_in;

  always @(reg_out)
    if (output_enable)
      data_out = reg_out;
    else
      data_out = 'bz;
endmodule
