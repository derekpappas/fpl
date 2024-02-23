// Test type: Conditional Expression -  unary operator, binary operator expression, primary (number), 1 attribute instance on binary operator expression
// Vparser rule name:
// Author: andreib
module condexpr;
reg enable, a, b, c;
wire out, d;
assign out = (~a) ? (*d *)(b+c) : 1'b0;
endmodule
