//test type : operator_! multiple_concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module unary_operator36;
    wire a, b, c;
    assign a = !{2{b, c}};
endmodule