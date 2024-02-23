//test type : ordered_port_connection ::= [expression]
//vparser rule name : 
//author : Codrin
module test_0570(in, out);
 input in;
 output out;
 (* flatten = 0, test = 1, exit *) a a0(in, out);
endmodule

module a(x, y);
 input x;
 output y;
endmodule
