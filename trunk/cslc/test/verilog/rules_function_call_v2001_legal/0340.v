//test type : hierrchical_function_identifier {attribute_instance} (expression {, expression})
//vparser rule name : 
//author : Bogdan Mereghea
module function_call34;
    wire a;
    modul34 instm34();
    assign a = instm34.abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$("string", 1'b1, 1'b1 ? 1'b1 : 1'b1);
endmodule 
module modul34;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input expression, input expression1, input expression2);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = expression + expression1 + expression2;
    end
    endfunction
endmodule
