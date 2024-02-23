//gate_instantiation = pass_en_switchtype ...;
//tests by Gabrield
module gate_instantiation_pass_en0;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en1;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en2;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en3;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en4;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en5;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en6;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en7;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en8;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en9;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en10;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en11;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif0 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en12;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en13;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en14;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en15;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en16;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en17;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en18;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en19;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en20;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en21;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en22;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en23;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  tranif1 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en24;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en25;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en26;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en27;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en28;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en29;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en30;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en31;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en32;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en33;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en34;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en35;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif1 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en36;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en37;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en38;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en39;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en40;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en41;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en42;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en43;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en44;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 #2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en45;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en46;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
module gate_instantiation_pass_en47;
  wire inout_terminal;
  wire [7:0] multi_inout_terminal;
  reg enable_terminal;
  rtranif0 #2 name1 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) , name2 (inout_terminal ,multi_inout_terminal[7:0] ,enable_terminal ) ;
endmodule
