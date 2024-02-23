//module x;
//    x x0();
//endmodule

module mymod(a,b);
    parameter c = 0;
input a,b;
wire [1:0]a,b;
endmodule

module top;
  wire [1:0] x;
  mymod #5 m1(.a(x),.b(x));
endmodule
