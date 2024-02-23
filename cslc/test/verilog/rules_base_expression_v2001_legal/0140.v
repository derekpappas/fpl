//test type : expression ::= expression binary_operator {attribute_instance} expression
//vparser rule name : 
//author : Bogdan Mereghea
module expression_b2;
    wire a, b;
    assign a = 1'b1 ? 1'b1 : 1'b1 ^~ (*b *) (1:2:3);
endmodule
