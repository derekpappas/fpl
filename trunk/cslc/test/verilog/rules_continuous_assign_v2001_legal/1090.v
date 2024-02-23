// Test type: Continuous assignment - st0, pl1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous109;
wire a;
assign (strong0, pull1) #10 a=1'b1;
endmodule
