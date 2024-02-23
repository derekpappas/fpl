//test type : (mintypmax_expression) binary_operator_| number
//vparser rule name : 
//author : Bogdan Mereghea
module binary_operator268;
    reg a;
    initial begin
        a = (1:2:3) | 1'b1;
    end
endmodule
