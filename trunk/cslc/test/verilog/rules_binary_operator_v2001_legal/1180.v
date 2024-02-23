//test type : function_call binary_operator_| function_call
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator118;
    function a_function(input one_bit);
    begin
        a_function = one_bit;
    end
    endfunction
    wire a;
    assign a = a_function(1'b1) | a_function(1'b1);
endmodule
