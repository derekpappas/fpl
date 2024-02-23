// Test type: Continuous assignment - wk1, st0 - delay - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous456;
wire a,b,c;
assign (weak1, strong0) #10 a=1'b1, b=1'b0, c=1'd2;
endmodule
