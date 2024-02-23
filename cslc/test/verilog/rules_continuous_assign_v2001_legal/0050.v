// Test type: Continuous assignment - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous5;
wire a,b;
assign #10 a=1'b1, b=1'b0;
endmodule
