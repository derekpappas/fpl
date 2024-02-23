//test type : udp_declaration ::= primitive udp_identifier(udp_port_list) output reg
//vparser rule name : 
//author : Codrin
//modified by : GabrielD
primitive udp_initial_0620(a, b, c);
(* setout = 1, setregister *) output a;
 input  c,b;
  table
   0 1 : 0;
   0 0 : 1;
   1 1 : 0;
   1 0 : 1;
  endtable
endprimitive
