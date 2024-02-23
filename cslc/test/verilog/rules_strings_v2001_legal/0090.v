// Test type: Strings - ASCII \ddd octal form "
// Vparser rule name:
// Author: andreib
module stringtest;
reg [8*4096:1] stringvar;
initial begin
 stringvar = "special chars \176 \040 ";
end
endmodule
