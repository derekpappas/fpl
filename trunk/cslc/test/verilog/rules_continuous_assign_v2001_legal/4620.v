// Test type: Continuous assignment - wk1, st0 - 2 mintypmax - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous462;
wire a,b,c;
assign (weak1, strong0) #(1,2) a=1'b1, b=1'b0, c=1'd2;
endmodule
