// Test type: Strings - Many ASCII chars
// Vparser rule name: Strings
// Author: andreib
module stringtest;
reg [8*4096:1] stringvar;
initial begin
stringvar = "QqWwEeRrTtYyUuIiOoPpAaSsDdFfGgHhJjKkLlZzXxCcVvBbNnMm<>,./?;\"|+=_-~`1234567890!@#$%^&*()";
end
endmodule
