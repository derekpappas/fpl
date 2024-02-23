//test type : function_call binary_operator_| system_function_call
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator243;
    function a_function(input one_bit);
    begin
        a_function = one_bit;
    end
    endfunction
    wire a;
    assign a = a_function(1'b1) | $random;
endmodule
