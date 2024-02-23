//test type : expression ::= expression binary_operator {attribute_instance} expression
//vparser rule name : 
//author : Bogdan Mereghea
module expression_b1;
    wire a;
    assign a = ~&1'b1 && "a";
endmodule
