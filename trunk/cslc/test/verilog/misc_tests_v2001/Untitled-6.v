`include "custom_code.v"
//create testbench
module tb;
  wire sgn0, sgn1;
//add instence of unit_a and unit_b to the testench
  unit_a DUT0();
  unit_b DUT1(sgn0, sgn1);
endmodule
//create csl unit called unit_a
module unit_a;
endmodule