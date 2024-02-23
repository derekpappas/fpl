module top;
    wire y,z;
    ab a1(y);
    ab b1(y);
    c c1(z);
    d d1(z);
endmodule
module ab(y);
    inout y;
endmodule
module c(z);
    inout z;
endmodule
module d(z);
    inout z;
    wire t;
    assign t = z;
endmodule