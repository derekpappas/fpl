//test type : (mintypmax_expression) binary_operator_- (mintypmax_expression)
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator152;
    reg a;
    initial begin
        a = (1:2:3) - (1:2:3);
    end
endmodule
