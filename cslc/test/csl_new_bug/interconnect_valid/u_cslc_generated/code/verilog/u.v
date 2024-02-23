`include "defines.v"

module u();
// Location of source csl unit: file name = parameter_test9.csl line number = 11
  mem #(.addr_w(4),
      .data_w(8))
      mem1();
  mem #(.addr_w(16),
      .data_w(32))
      mem2();
  `include "u.logic.v"
endmodule

