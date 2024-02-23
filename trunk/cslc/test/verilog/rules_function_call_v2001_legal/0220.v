//test type : hierrchical_function_identifier {attribute_instance} (expression {, expression})
//vparser rule name : 
//author : Bogdan Mereghea
module function_call22;
    wire a, b;
    modul22 instm22();
    assign a = instm22.abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(*b*)(&1'b1, 1'b1);
endmodule
module modul22;
    function abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$(input expression, input expression1);
    begin
        abcdefghijklmnoprstuvxyzwABCDEFGHIJKLMNOPRSTUVXYZW0123456789_$ = expression + expression1;
    end
    endfunction
endmodule
