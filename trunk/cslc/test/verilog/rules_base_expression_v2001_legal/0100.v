//test type : expression ::= unary_operator {attribute_instance} primary
//vparser rule name : 
//author : Bogdan Mereghea
module expression_u1;
    wire a;
    assign a = ~&1'b1;
endmodule
