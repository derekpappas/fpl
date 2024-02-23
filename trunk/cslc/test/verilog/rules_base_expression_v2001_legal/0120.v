//test type : expression ::= unary_operator {attribute_instance} primary
//vparser rule name : 
//author : Bogdan Mereghea
module expression_u3;
    wire a, b,c;
    assign a = | (*b, c*) $random;
endmodule
