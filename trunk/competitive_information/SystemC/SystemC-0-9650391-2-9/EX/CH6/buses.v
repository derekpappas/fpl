// Copyright 2003 Star GAlaxy Publishing
// File: buses.v

module buses (a_ready, b_ready, a_bus, b_bus, z_bus);
  input a_ready, b_ready;
  input [1:0] a_bus, b_bus;

  output [1:0] z_bus;

  assign z_bus = a_ready ? a_bus : 'bz;

  assign z_bus = b_ready ? b_bus : 'bz;
endmodule
