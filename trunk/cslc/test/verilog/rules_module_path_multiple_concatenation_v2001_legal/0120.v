//test type : {constant_expression module_path_concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module module_path_multiple_concatenation12;
    wire a;
    assign a = {~1'b1{1'b1 ? 1'b1 : 1'b1, 1'b1 ? (*b *)1'b1 : 1'b1, b}};
endmodule
