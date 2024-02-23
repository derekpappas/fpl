// Test type: Conditional Expression -  conditional expression, binary operator expression, string
// Vparser rule name:
// Author: andreib
module condexpr;
reg enable, a, b, c;
reg [8*15:0]stringvar;
reg [8*15:0]out;
initial begin
stringvar = "Test string";
out = (enable ? a:b) ? (b+c) : stringvar;
end
endmodule
