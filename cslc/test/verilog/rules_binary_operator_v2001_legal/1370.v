//test type : system_function_call binary_operator_** system_function_call
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator137;
    reg a;
    initial begin 
        a = $random ** $random; 
    end
endmodule
