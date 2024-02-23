// Test type: Continuous assignment - wk0, wk1 - delay - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous246;
wire a,b,c;
assign (weak0, weak1) #10 a=1'b1, b=1'b0, c=1'd2;
endmodule
