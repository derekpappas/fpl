//test type : named_port_connection ::= .port_identifier([expression])
//vparser rule name : 
//author : Codrin
module test_0580(in, out);
 input in;
 output out;
 (* flatten = 0, test = 1 *) a a0(.in(x), .out(y));
endmodule

module a(input x, output y);
endmodule
