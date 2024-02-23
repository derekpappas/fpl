// Test type: Strings - ASCII \ and "
// Vparser rule name:
// Author: andreib
module stringtest;
reg [8*4096:1] stringvar;
initial begin
 stringvar = "special char \\";
end
endmodule
