//test type : {expression, expression}
//vparser rule name : 
//author : Bogdan Mereghea
module concatenation2;
    wire a, b;
    assign a = {+b, 1'b1 - $random};
endmodule
