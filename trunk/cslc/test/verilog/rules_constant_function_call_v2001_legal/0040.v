//test type : function_identifier {attribute_instance} (constant_expression {, constant_expression})
//vparser rule name : 
//author : Bogdan Mereghea
module constant_function_call4;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input constant_expression);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = constant_expression;
    end
    endfunction
    wire a;
    assign a = abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$("string");
endmodule 
