//test type : hierrchical_function_identifier {attribute_instance} (expression {, expression})
//vparser rule name : 
//author : Bogdan Mereghea
module function_call42;
    wire a, b, c;
    modul42 instm42();
    assign a = instm42.abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(*b, c*)(&1'b1, 1'b1, 1'b1 ? 1'b1 : 1'b1);
endmodule
module modul42;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input expression, input expression1, input expression2);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = expression + expression1 + expression2;
    end
    endfunction
endmodule
