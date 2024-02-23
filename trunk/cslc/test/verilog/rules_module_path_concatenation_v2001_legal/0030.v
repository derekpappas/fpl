//test type : {module_path_expression, module_path_expression, module_path_expression}
//vparser rule name : 
//author : Bogdan Mereghea
module module_path_concatenation3;
    wire a, b;
    assign a = {1'b1 ? 1'b1 : 1'b1, 1'b1 ? (*b *)1'b1 : 1'b1, b};
endmodule
