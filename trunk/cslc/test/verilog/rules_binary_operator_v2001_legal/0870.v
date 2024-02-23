//test type : multiple_concatenation binary_operator_** multiple_concatenation
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator87;
    reg a, b, c;
    initial begin 
        a = {2{b, c}} ** {2{b, c}}; 
    end
endmodule
