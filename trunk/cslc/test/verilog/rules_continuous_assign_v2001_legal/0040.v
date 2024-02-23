// Test type: Continuous assignment - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous4;
wire a;
assign #10 a=1'b1;
endmodule
