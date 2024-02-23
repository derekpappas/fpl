//test type : operator_| (mintypmax_expression)
//vparser rule name : 
//author : Bogdan Mereghea
module unary_operator73;
    reg a;
    initial begin
        a = |(1:2:3);
    end
endmodule
