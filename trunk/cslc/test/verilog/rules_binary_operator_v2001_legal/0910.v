//test type : multiple_concatenation binary_operator_>= multiple_concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator91;
    wire a, b, c;
    assign a = {2{b, c}} >= {2{b, c}};
endmodule
