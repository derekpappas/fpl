// Test type: Continuous assignment - sup0, wk1 - delay - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous66;
wire a,b,c;
assign (supply0, weak1) #10 a=1'b1, b=1'b0, c=1'd2;
endmodule
