//test type :  concatenation binary_operator_% multiple_concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator205;
    wire a, b, c;
    assign a = {b, c} % {2{b, c}};
endmodule
