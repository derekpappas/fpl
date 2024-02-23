//test
`timescale 1ns/1ps
`include "tbfile.vtb"
//add instence of unit_a to the testench and call it DUT
module tb;
  wire a_in, a_out;
  unit_a DUT(a_in, a_out);
endmodule
//create a module called unit_a
module unit_a(a_in, a_out);
  input a_in;
  output a_out;
  reg a_out; 
endmodule