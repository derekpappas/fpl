// Test type: Conditional Expression -  unary operator, binary operator expression, primary (number), 1 attribute instance on unary operator expression
// Vparser rule name:
// Author: andreib
module condexpr;
reg enable, a, b, c;
wire out, d;
assign out = (b+c) ? (*d *)(~a) : 1'b0;
endmodule
