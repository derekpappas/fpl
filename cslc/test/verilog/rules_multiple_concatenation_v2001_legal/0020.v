//test type : {constant_expression concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module multiple_concatenation2;
    wire a, b;
    assign a = {"a"{+b, 1'b1 - $random}};
endmodule
