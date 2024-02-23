// Copyright 2003 Star Galaxy Publishing
// File: driver_bank.v

module driver_bank (myclk, read_state, cpu_bus, main_bus);
  input myclk, read_state;
  input [3:0] cpu_bus;

  output [3:0] main_bus;
  reg [3:0] main_bus;

  always @(posedge myclk)
    if (read_state)
      main_bus = 4'bz;
    else
      main_bus = cpu_bus;
endmodule
