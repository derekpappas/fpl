//test type : module_or_generate_item ::= event_declaration
//vparser rule name : 
//author : Codrin
module test_0540(x,y,z);
 input x, y;
 output z;
 wire x, y, sel;
 reg z;
 (* set = 1, reset = 0 *)
 always @(x or y, sel)
  z = x&y;
endmodule
