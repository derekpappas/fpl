// Test type: Strings - ASCII \
// Vparser rule name:
// Author: andreib
module stringtest;
reg [8*4096:1] stringvar;
initial begin
stringvar = "special char \\";
end
endmodule
