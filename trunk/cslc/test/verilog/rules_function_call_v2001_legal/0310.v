//test type : hierrchical_function_identifier {attribute_instance} (expression {, expression})
//vparser rule name : 
//author : Bogdan Mereghea
module function_call31;
    wire a;
    modul31 instm31();
    assign a = instm31.abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(1'b1, "string", 1'b1 ? 1'b1 : 1'b1);
endmodule
module modul31;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input expression, input expression1, input expression2);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = expression;
    end
    endfunction
endmodule
