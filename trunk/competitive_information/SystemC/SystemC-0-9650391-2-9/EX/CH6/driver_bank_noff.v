// Copyright 2003 Star Galaxy Publishing
// File: driver_bank_noff.v

module driver_bank_noff (myclk, read_state, cpu_bus, main_bus);
  input myclk, read_state;
  input [3:0] cpu_bus;

  output [3:0] main_bus;
  reg [3:0] main_bus;

  reg [3:0] saved_value;

  always @(posedge myclk)
    saved_value = cpu_bus;

  always @(saved_value or read_state)
    if (read_state)
      main_bus = 4'bz;
    else
      main_bus = saved_value;
endmodule
