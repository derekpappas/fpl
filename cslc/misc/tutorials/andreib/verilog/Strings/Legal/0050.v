// Test type: Strings - ASCII tab char
// Vparser rule name:
// Author: andreib
module stringtest;
reg [8*4096:1] stringvar;
initial begin
stringvar = "tabbed \t test";
end
endmodule
