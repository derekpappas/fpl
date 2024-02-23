//test type : {constant_expression concatenation}
//vparser rule name : 
//author : Bogdan Mereghea
module multiple_concatenation5;
    wire a;
    assign a = {1'b1 ? 1'b1 : 1'b1{1'b1}};
endmodule 
