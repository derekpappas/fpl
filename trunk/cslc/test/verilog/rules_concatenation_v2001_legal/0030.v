//test type : {expression, expression, expression}
//vparser rule name : 
//author : Bogdan Mereghea
module concatenation3;
    wire a, b, c, d;
    assign a = {b ? c : d, "string", 1'b1};
endmodule 
