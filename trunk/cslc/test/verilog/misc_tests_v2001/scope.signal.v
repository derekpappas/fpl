module a(o);
    wire x;
    output o;
    assign o = b.y;
endmodule
module b(i);
    wire y;
    input i;
    assign a.x = i;
endmodule
