//test type : concatenation binary_operator_** concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator62;
    reg a, b, c;
    initial begin 
        a = {b, c} ** {b, c}; 
    end
endmodule
