//test type : specify_block_declaration
//author : Dramba Doru-Gabriel
module rspwn_specify_block0(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $removal( inoutPortIdentifier , inoutPortIdentifier , 10 ); endspecify
endmodule
module rspwn_specify_block1(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $removal( inoutPortIdentifier , inoutPortIdentifier , 10 , ); endspecify
endmodule
module rspwn_specify_block2(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $removal( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier ); endspecify
endmodule
module rspwn_specify_block3(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $skew( inoutPortIdentifier , inoutPortIdentifier , 10 ); endspecify
endmodule
module rspwn_specify_block4(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $skew( inoutPortIdentifier , inoutPortIdentifier , 10 , ); endspecify
endmodule
module rspwn_specify_block5(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $skew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier ); endspecify
endmodule
module rspwn_specify_block6(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $period( posedge inoutPortIdentifier , 10 ); endspecify
endmodule
module rspwn_specify_block7(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $period( posedge inoutPortIdentifier , 10 , ); endspecify
endmodule
module rspwn_specify_block8(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $period( posedge inoutPortIdentifier , 10 , outputPortIdentifier ); endspecify
endmodule
module rspwn_specify_block9(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $period( posedge inoutPortIdentifier &&&1 , 10 ); endspecify
endmodule
module rspwn_specify_block10(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $period( posedge inoutPortIdentifier &&&1 , 10 , ); endspecify
endmodule
module rspwn_specify_block11(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $period( posedge inoutPortIdentifier &&&1 , 10 , outputPortIdentifier ); endspecify
endmodule
module rspwn_specify_block12(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $width( posedge inoutPortIdentifier , 10 , 5 ); endspecify
endmodule
module rspwn_specify_block13(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $width( posedge inoutPortIdentifier , 10 , 5 , ); endspecify
endmodule
module rspwn_specify_block14(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $width( posedge inoutPortIdentifier , 10 , 5 , outputPortIdentifier ); endspecify
endmodule
module rspwn_specify_block15(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $width( posedge inoutPortIdentifier &&&1 , 10 , 5 ); endspecify
endmodule
module rspwn_specify_block16(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $width( posedge inoutPortIdentifier &&&1 , 10 , 5 , ); endspecify
endmodule
module rspwn_specify_block17(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $width( posedge inoutPortIdentifier &&&1 , 10 , 5 , outputPortIdentifier ); endspecify
endmodule
module rspwn_specify_block18(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $nochange( inoutPortIdentifier , inoutPortIdentifier , "expr" , "expr2" ); endspecify
endmodule
module rspwn_specify_block19(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $nochange( inoutPortIdentifier , inoutPortIdentifier , "expr" , "expr2" , ); endspecify
endmodule
module rspwn_specify_block20(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $nochange( inoutPortIdentifier , inoutPortIdentifier , "expr" , "expr2" , outputPortIdentifier ); endspecify
endmodule
