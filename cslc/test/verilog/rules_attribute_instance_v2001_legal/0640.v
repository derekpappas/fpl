//test type : udp_declaration ::= primitive udp_identifier(udp_port_list) reg
//vparser rule name : 
//author : Codrin
//modified by: GabrielD
 primitive udp_initial_0640(a, b, c, d);
  input c, b, d;
  output a;
  (* testreg, testudp = "enable" *) reg a;
  initial a = 1'b1;
  table
   0 0 0 : 0 : 1;
   0 1 0 : 1 : X;
   1 0 0 : 0 : 0;
   1 1 0 : 1 : 1;
  endtable
 endprimitive
 
