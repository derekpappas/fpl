//test type : expression ::= unary_operator {attribute_instance} primary
//vparser rule name : 
//author : Bogdan Mereghea
module expression_u2;
    wire a, b;
    assign a = & (*b *) (1:2:3);
endmodule
