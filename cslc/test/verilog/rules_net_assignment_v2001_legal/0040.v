// Test type: net_assignment - unary operator, 2 attribute instances
// Vparser rule name:
// Author: andreib
module netasign4;
wire a,b,c;
assign a=~(*b, c*)2;
endmodule
