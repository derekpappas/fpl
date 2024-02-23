//test type : task_port_item ::= inout_declaration
//vparser rule name : 
//author : Codrin
//fixed by: Gabrield
module test_0470;
 (* carry, text = "error" *)
 task string;
  (* a,b *) inout a,b;
  ;
 endtask
endmodule
