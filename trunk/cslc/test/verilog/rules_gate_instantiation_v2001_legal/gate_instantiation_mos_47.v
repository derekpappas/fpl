//Primitive Instantiation and Instances: gate_instantiation = mos_switchtype ...;
//tests by GabrielD
module gate_instantiation_mos0;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos1;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos2;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos3;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos4;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos5;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos6;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos #2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos7;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos #2 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos8;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos #2 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos9;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos10;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos11;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  nmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos12;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos13;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos14;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos15;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos16;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos17;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos18;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos #2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos19;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos #2 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos20;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos #2 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos21;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos22;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos23;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  pmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos24;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos25;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos26;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos27;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos28;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos29;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos30;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos #2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos31;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos #2 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos32;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos #2 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos33;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos34;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos35;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rnmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos36;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos37;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos38;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos39;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos40;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos41;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos42;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos #2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos43;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos #2 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos44;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos #2 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos45;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos46;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
module gate_instantiation_mos47;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rpmos #2 name1 (output_terminal,input_terminal,pcontrol_terminal) , name2 (output_terminal,input_terminal,pcontrol_terminal) ;
endmodule
