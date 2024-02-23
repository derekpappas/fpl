//test type : {constant_expression constant_concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module constant_multiple_concatenation3;
    wire a;
    assign a = {2{"string"}};
endmodule
