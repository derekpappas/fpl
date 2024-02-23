//test type : expression ::= expression binary_operator {attribute_instance} expression
//vparser rule name : 
//author : Bogdan Mereghea
module expression_b3;
    wire a, b, c;
    assign a = {b, c} || (*b, c*) $random;
endmodule
