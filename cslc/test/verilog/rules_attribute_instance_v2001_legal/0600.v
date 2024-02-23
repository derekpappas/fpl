//test type : udp_declaration ::= primitive udp_identifier(udp_port_list)
//vparser rule name : 
//author : Codrin
//modified by : GabrielD
 (* testudp *)
primitive udp_initial_0600(a, b, c);
 output a;
 input  c,b;
  table
   0 1 : 0;
   0 0 : 1;
   1 1 : 0;
   1 0 : 1;
  endtable
 endprimitive
