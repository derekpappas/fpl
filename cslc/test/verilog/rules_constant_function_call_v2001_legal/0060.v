//test type : function_identifier {attribute_instance} (constant_expression {, constant_expression})
//vparser rule name : 
//author : Bogdan Mereghea
module constant_function_call6;
function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input constant_expression);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = constant_expression;
    end
    endfunction
    wire a, b;
    assign a = abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(*b*)(1'b1);
endmodule
