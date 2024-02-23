//test type : hierrchical_function_identifier {attribute_instance} (expression {, expression})
//vparser rule name : 
//author : Bogdan Mereghea
module function_call11;
    wire a, b, c;
    modul11 instm11();
    assign a = instm11.abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(*b, c*)(1'b1);
endmodule
module modul11;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input expression);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = expression;
    end
    endfunction
endmodule
