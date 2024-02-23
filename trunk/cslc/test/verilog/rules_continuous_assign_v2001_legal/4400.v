// Test type: Continuous assignment - wk1, sup0 - delay - list_of_net_assignments - 2 elements
// Vparser rule name:
// Author: andreib
module continuous440;
wire a,b;
assign (weak1, supply0) #10 a=1'b1, b=1'b0;
endmodule
