//comentariu
module mux_c(c, a, b, sel);
    output c;
    input a,b,sel;
        
    and g1(f1, a, nsel),
        g2(f2, b, sel);
    or g3(c, f1, f2);
    not g4(nsel, sel);
endmodule