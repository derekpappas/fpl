//test type : module_or_generate_item ::= gate_instantiation
//vparser rule name : 
//author : Codrin
module test_0280(clk, rst);
 input clk, rst;
 (* delay = 1 *) nand (clk, rst);
endmodule
