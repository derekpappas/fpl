// Test type: Continuous assignment - sup0, wk1 - 2 mintypmax - list_of_net_assignments - 1 element
// Vparser rule name:
// Author: andreib
module continuous70;
wire a;
assign (supply0, weak1) #(1,2) a=1'b1;
endmodule
