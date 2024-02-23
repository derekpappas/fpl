//test type : {constant_expression module_path_concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module module_path_multiple_concatenation5;
    wire a;
    assign a = {"a"{1'b1}};
endmodule
