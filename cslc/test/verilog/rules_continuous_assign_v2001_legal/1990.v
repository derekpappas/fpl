// Test type: Continuous assignment - wk0, sup1 - delay - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous199;
wire a;
assign (weak0, supply1) #10 a=1'b1;
endmodule
