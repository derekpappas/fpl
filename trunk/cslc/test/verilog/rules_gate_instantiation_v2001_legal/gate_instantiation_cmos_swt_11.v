//Primitive Instantiation and Instances: gate_instantiation = cmos_switchtype ...
//tests by Gabrield
module gate_instantiation_cmos_swt0;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  cmos ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt1;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  cmos name_of_gate_instance ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt2;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  cmos #2 ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt3;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  cmos #2 name_of_gate_instance ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt4;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  cmos #(1,1,1) ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt5;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  cmos #(1,1,1) name_of_gate_instance ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt6;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rcmos ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt7;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rcmos name_of_gate_instance ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt8;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rcmos #2 ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt9;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rcmos #2 name_of_gate_instance ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt10;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rcmos #(1,1,1) ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
module gate_instantiation_cmos_swt11;
  wire output_terminal, ncontrol_terminal;
  reg input_terminal, pcontrol_terminal;
  rcmos #(1,1,1) name_of_gate_instance ( output_terminal , input_terminal, ncontrol_terminal, pcontrol_terminal) ;
endmodule
