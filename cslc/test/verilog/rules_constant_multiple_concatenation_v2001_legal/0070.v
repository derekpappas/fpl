//test type : {constant_expression constant_concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module constant_multiple_concatenation7;
    wire a;
    assign a = {"a"{"string"}};
endmodule
