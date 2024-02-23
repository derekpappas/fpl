//test type : udp_declaration ::= primitive udp_identifier(udp_port_list) input
//vparser rule name : 
//author : Codrin
//modified by : GabrielD
primitive udp_initial_0630(a, b, c);
 output a;
 (* testinputs *) input  c,b;
  table
   0 0 : 0;
   0 1 : 1;
   1 0 : 0;
   1 1 : 1;
  endtable
endprimitive
