//test type : {constant_expression constant_concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module constant_multiple_concatenation4;
    wire a;
    assign a = {+1'b1{"string"}};
endmodule