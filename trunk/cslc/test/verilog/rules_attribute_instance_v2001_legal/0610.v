//test type : udp_declaration ::= primitive udp_identifier(udp_port_list) output
//vparser rule name : 
//author : Codrin
//modified by : GabrielD
primitive udp_initial_0610(a, b, c);
 output a;
 (* testudp *)
 input  c,b;
  table
   0 1 : 0;
   0 0 : 1;
   1 1 : 0;
   1 0 : 1;
  endtable
endprimitive
