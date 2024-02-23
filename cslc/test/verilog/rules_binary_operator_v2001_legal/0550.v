//test type : concatenation binary_operator_% concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator55;
    wire a, b, c;
    assign a = {b, c} % {b, c};
endmodule
