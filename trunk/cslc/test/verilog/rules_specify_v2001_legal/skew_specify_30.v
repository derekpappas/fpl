//test type : specify_block_declaration
//author : Dramba Doru-Gabriel
module skew_specify0(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 ); endspecify
endmodule
module skew_specify1(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , ); endspecify
endmodule
module skew_specify2(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , , ); endspecify
endmodule
module skew_specify3(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , , , ); endspecify
endmodule
module skew_specify4(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , , , 2:2:2 ); endspecify
endmodule
module skew_specify5(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , , 1 ); endspecify
endmodule
module skew_specify6(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , , 1 , ); endspecify
endmodule
module skew_specify7(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , , 1 , 2:2:2 ); endspecify
endmodule
module skew_specify8(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier ); endspecify
endmodule
module skew_specify9(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier , ); endspecify
endmodule
module skew_specify10(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier , , ); endspecify
endmodule
module skew_specify11(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier , , 2:2:2 ); endspecify
endmodule
module skew_specify12(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier , 1 ); endspecify
endmodule
module skew_specify13(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier , 1 , ); endspecify
endmodule
module skew_specify14(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $timeskew( inoutPortIdentifier , inoutPortIdentifier , 10 , outputPortIdentifier , 1 , 2:2:2 ); endspecify
endmodule
module skew_specify15(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 ); endspecify
endmodule
module skew_specify16(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , ); endspecify
endmodule
module skew_specify17(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , , ); endspecify
endmodule
module skew_specify18(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , , , ); endspecify
endmodule
module skew_specify19(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , , , 2:2:2 ); endspecify
endmodule
module skew_specify20(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , , 1 ); endspecify
endmodule
module skew_specify21(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , , 1 , ); endspecify
endmodule
module skew_specify22(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , , 1 , 2:2:2 ); endspecify
endmodule
module skew_specify23(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , outputPortIdentifier ); endspecify
endmodule
module skew_specify24(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , outputPortIdentifier , ); endspecify
endmodule
module skew_specify25(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , outputPortIdentifier , , ); endspecify
endmodule
module skew_specify26(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , outputPortIdentifier , , 2:2:2 ); endspecify
endmodule
module skew_specify27(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , outputPortIdentifier , 1 ); endspecify
endmodule
module skew_specify28(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , outputPortIdentifier , 1 , ); endspecify
endmodule
module skew_specify29(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  reg ter;
  specify $fullskew( inoutPortIdentifier , inoutPortIdentifier , 10 , 10 , outputPortIdentifier , 1 , 2:2:2 ); endspecify
endmodule
