//test type : module_or_generate_item ::= module_or_generate_item_declaration (event_declaration)
//vparser rule name : 
//author : Codrin
module test_0220(input in);
 reg nout;
 (* neg = 1, level *)
 always @(in or nout)
  nout = ~in;
endmodule
