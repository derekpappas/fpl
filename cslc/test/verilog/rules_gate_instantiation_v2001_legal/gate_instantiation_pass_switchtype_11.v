//gate_instantiation = pass_switchtype ...;
//tests by GabrielD
module gate_instantiation_pass_switchtype0;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  tran ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype1;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  tran ( inout_terminal ,multi_inout_terminal[7:0] ) , ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype2;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  tran ( inout_terminal ,multi_inout_terminal[7:0] ) , name2 ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype3;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  tran name1 ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype4;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  tran name1 ( inout_terminal ,multi_inout_terminal[7:0] ) , ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype5;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  tran name1 ( inout_terminal ,multi_inout_terminal[7:0] ) , name2 ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype6;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  rtran ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype7;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  rtran ( inout_terminal ,multi_inout_terminal[7:0] ) , ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype8;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  rtran ( inout_terminal ,multi_inout_terminal[7:0] ) , name2 ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype9;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  rtran name1 ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype10;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  rtran name1 ( inout_terminal ,multi_inout_terminal[7:0] ) , ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
module gate_instantiation_pass_switchtype11;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  rtran name1 ( inout_terminal ,multi_inout_terminal[7:0] ) , name2 ( inout_terminal ,multi_inout_terminal[7:0] ) ;
endmodule
