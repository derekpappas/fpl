//test type : hierrchical_function_identifier {attribute_instance} (expression {, expression})
//vparser rule name : 
//author : Bogdan Mereghea
module function_call45;
    wire a, b, c;
    modul45 instm45();
    assign a = instm45.abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(*b, c*)(1'b1 ? 1'b1 : 1'b1, 1'b1, 1'b1 ? 1'b1 : 1'b1);
endmodule 
module modul45;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input expression, input expression1, input expression2);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = expression + expression1 + expression2;
    end
    endfunction
endmodule
