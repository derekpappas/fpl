// Test type: Conditional Expression -  unary operator, binary operator expression, primary (number)
// Vparser rule name:
// Author: andreib
module condexpr;
reg enable, a, b, c;
wire out;
assign out = (~a) ? (b+c) : 1'b0;
endmodule
