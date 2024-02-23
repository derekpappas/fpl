module test;
reg [2:2] test = 1'b1;
initial
$monitor("%b ", test[1]);
endmodule
