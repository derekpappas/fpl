// Test type: Continuous assignment - pl1, h0 - delay - list_of_net_assignments - 3 elements
// Vparser rule name:
// Author: andreib
module continuous591;
wire a,b,c;
assign (pull1, highz0) #10 a=1'b1, b=1'b0, c=1'd2;
endmodule