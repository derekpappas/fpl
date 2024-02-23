//test type : operator_~| concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module unary_operator30;
    wire a, b, c;
    assign a = ~|{b, c};
endmodule
