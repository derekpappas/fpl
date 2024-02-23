// Test type: Conditional Expression -  unary operator, binary operator expression, primary (number), 2 attribute instances on binary operator expression
// Vparser rule name:
// Author: andreib
module condexpr;
reg enable, a, b, c;
wire out, d,e;
assign out = (~a) ? (*d,e *)(b+c) : 1'b0;
endmodule
