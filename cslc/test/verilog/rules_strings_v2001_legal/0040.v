// Test type: Strings - ASCII new line
// Vparser rule name: Strings
// Author: andreib
module stringtest;
reg [8*4096:1] stringvar;
initial begin
stringvar = "new line\n";
end
endmodule
