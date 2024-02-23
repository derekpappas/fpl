//test type : hierrchical_function_identifier {attribute_instance} (expression {, expression})
//vparser rule name : 
//author : Bogdan Mereghea
module function_call39;
    wire a, b;
    modul39 instm39();
    assign a = instm39.abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(*b*)("string", 1'b1, 1'b1 ? 1'b1 : 1'b1);
endmodule 
module modul39;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input expression, input expression1, input expression2);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = expression + expression1 + expression2;
    end
    endfunction
endmodule
