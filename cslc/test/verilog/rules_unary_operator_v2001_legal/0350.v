//test type : operator_- multiple_concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module unary_operator35;
    wire[3:0] a;
    wire b, c;
    assign a = -{2{b, c}};
endmodule
