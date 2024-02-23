//test type : function_call binary_operator_** function_call
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator112;
    function a_function(input one_bit);
    begin
        a_function = one_bit;
    end
    endfunction
    reg a;
    initial begin 
        a = a_function(1'b1) ** a_function(1'b1); 
    end
endmodule
