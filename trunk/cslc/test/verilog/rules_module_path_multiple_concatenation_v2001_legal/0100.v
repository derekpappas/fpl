//test type : {constant_expression module_path_concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module module_path_multiple_concatenation10;
    wire a;
    assign a = {"a"{!{1'b1}, 1'b1 == $random}};
endmodule