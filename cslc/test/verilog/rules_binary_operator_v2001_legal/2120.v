//test type :  concatenation binary_operator_** multiple_concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator212;
    reg a, b, c;
    initial begin 
        a = {b, c} ** {2{b, c}}; 
    end
endmodule
