//test type : module_or_generate_item ::= udp_instantiation
//vparser rule name : 
//author : Codrin
(* reset = 0, set = 1 *)
primitive dff_0330 (q,d,clk,rst); //SEQUENTIAL UDP
  output q;
  input clk, rst, d;
  reg q;
  initial q = 0; //powers up in reset state
  table
     ?   ?   0 :  ?  :0; //low true reset
     0   R   1 :  ?  :0; //clock in a 0
     1   R   1 :  ?  :1; //clock in a 1
     ?   N   1 :  ?  :-; //ignore negedge of clk
     *   ?   1 :  ?  :-; //ignore all edges on d
     ?   ?   P :  ?  :-; //ignore posedge of rst
    endtable
 endprimitive

