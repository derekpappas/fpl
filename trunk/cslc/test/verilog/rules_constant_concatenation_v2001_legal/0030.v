//test type : {constant_expression, constant_expression, constant_expression}
//vparser rule name : 
//author : Bogdan Mereghea
module constant_concatenation3;
    wire a;
    assign a = {1'b1 ? 1'b1 : 1'b1, "string", 1'b1};
endmodule