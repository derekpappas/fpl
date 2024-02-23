`include "defines.v"

module u1();
// Location of source csl unit: file name = parameter_test6.csl line number = 11
  wire rst;
  wire clk;
  wire en;
  wire [16 - 1:0] data;
  reg1 #(.data_width(16))
       reg1(.clock(clk),
            .enable(en),
            .reg_out(data),
            .reset_(rst));
  `include "u1.logic.v"
endmodule

