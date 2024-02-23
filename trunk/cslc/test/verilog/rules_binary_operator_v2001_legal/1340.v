//test type : system_function_call binary_operator_!== system_function_call
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator134;
    wire a;
    assign a = $random !== $random;
endmodule
