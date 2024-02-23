//test type : module_or_generate_item ::= conditional_operator
//vparser rule name : 
//author : Codrin
module test_0310;
 wire a, b, c, d;
 assign a = b ? (* no_glitch *) c : d;
endmodule
