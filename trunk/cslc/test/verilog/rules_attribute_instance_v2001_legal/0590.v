//test type : udp_declaration ::= primitive udp_identifier(udp_port_list)
//vparser rule name : 
//author : Codrin
//modified by : GabrielD
(* testudp, setprimitives = 1 *)
primitive Adder(Sum, Ina, Inb);
output Sum; input Ina, Inb;
table 
// inputs : output
0 0 : 0;
0 1 : 1;
1 0 : 1;
1 1 : 0;
endtable 
endprimitive
