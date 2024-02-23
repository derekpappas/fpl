//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block00(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block02(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block03(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block04(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block05(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block06(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block07(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block08(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block09(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block010(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block011(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block012(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block013(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block014(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block015(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block016(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block017(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block018(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block019(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block020(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block021(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block022(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block023(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block024(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block025(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block026(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block027(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block028(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block029(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block030(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block031(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block032(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block033(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block034(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block035(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block036(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block037(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block038(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block039(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block040(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block041(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block042(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block043(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block044(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block045(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block046(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block047(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block048(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block049(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block050(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block051(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block052(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block053(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block054(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block055(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block056(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block057(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block058(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block059(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block060(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block061(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block062(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block063(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block064(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block065(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block066(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block067(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block068(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block069(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block070(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block071(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block072(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block073(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block074(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block075(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block076(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block077(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block078(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block079(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block080(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block081(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block082(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block083(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block084(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block085(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block086(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block087(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block088(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block089(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block090(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block091(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block092(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block093(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block094(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block095(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block096(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block097(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block098(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block099(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0100(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0101(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0102(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0103(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0104(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0105(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0106(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0107(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0108(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0109(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0110(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0111(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0112(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0113(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0114(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0115(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0116(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0117(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0118(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0119(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0120(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0121(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0122(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0123(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0124(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0125(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0126(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0127(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0128(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0129(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0130(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0131(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0132(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0133(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0134(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0135(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0136(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0137(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0138(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0139(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0140(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0141(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0142(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0143(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0144(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0145(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0146(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0147(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0148(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0149(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0150(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0151(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0152(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0153(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0154(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0155(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0156(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0157(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0158(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0159(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0160(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0161(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0162(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0163(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0164(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0165(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0166(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0167(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0168(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0169(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0170(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0171(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0172(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0173(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0174(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0175(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0176(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0177(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0178(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0179(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0180(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0181(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0182(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0183(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0184(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0185(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0186(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0187(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0188(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0189(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0190(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0191(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0192(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0193(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0194(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0195(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0196(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0197(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0198(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0199(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0200(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0201(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0202(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0203(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0204(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0205(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0206(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0207(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0208(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0209(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0210(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0211(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0212(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0213(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0214(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0215(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0216(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0217(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0218(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0219(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0220(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0221(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0222(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0223(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0224(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0225(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0226(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0227(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0228(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0229(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0230(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0231(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0232(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0233(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0234(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0235(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0236(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0237(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0238(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0239(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0240(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0241(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0242(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0243(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0244(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0245(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0246(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0247(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0248(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0249(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0250(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0251(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0252(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0253(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0254(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0255(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0256(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0257(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0258(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0259(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0260(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0261(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0262(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0263(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0264(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0265(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0266(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0267(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0268(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0269(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0270(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0271(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0272(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0273(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0274(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0275(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0276(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0277(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0278(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0279(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0280(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0281(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0282(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0283(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0284(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0285(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0286(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0287(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0288(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0289(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0290(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0291(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0292(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0293(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0294(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0295(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0296(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0297(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0298(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0299(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0300(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0301(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0302(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0303(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0304(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0305(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0306(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0307(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0308(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0309(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0310(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0311(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0312(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0313(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0314(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0315(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0316(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0317(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0318(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0319(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0320(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0321(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0322(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0323(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0324(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0325(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0326(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0327(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0328(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0329(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0330(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0331(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0332(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0333(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0334(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0335(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0336(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0337(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0338(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0339(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0340(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0341(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0342(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0343(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0344(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0345(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0346(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0347(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0348(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0349(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0350(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0351(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0352(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0353(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0354(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0355(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0356(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0357(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0358(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0359(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0360(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0361(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0362(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0363(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0364(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0365(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0366(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0367(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0368(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0369(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0370(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0371(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0372(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0373(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0374(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0375(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0376(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0377(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0378(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0379(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0380(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0381(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0382(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0383(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0384(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0385(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0386(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0387(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0388(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0389(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0390(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0391(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0392(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0393(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0394(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0395(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0396(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0397(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0398(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0399(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0400(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0401(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0402(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0403(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0404(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0405(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0406(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0407(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0408(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0409(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0410(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0411(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0412(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0413(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0414(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0415(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0416(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0417(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0418(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0419(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0420(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0421(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0422(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0423(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0424(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0425(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0426(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0427(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0428(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0429(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0430(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0431(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0432(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0433(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0434(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0435(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0436(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0437(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0438(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0439(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0440(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0441(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0442(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0443(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0444(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0445(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0446(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0447(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0448(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0449(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0450(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0451(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0452(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0453(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0454(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0455(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0456(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0457(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0458(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0459(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0460(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0461(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0462(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0463(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0464(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0465(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0466(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0467(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0468(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0469(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0470(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0471(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0472(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0473(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0474(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0475(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0476(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0477(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0478(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0479(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0480(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0481(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0482(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0483(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0484(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0485(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0486(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0487(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0488(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0489(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0490(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0491(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0492(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0493(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0494(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0495(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0496(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0497(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0498(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0499(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0500(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0501(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0502(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0503(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0504(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0505(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0506(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0507(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0508(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0509(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0510(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0511(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0512(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0513(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0514(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0515(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0516(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0517(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0518(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0519(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0520(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0521(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0522(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0523(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0524(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0525(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0526(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0527(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0528(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0529(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0530(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0531(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0532(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0533(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0534(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0535(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0536(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0537(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0538(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0539(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0540(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0541(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0542(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0543(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0544(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0545(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0546(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0547(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0548(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0549(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0550(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0551(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0552(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0553(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0554(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0555(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0556(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0557(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0558(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0559(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0560(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0561(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0562(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0563(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0564(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0565(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0566(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0567(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0568(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0569(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0570(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0571(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0572(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0573(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0574(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0575(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0576(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0577(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0578(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0579(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0580(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0581(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0582(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0583(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0584(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0585(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0586(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0587(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0588(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0589(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0590(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0591(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0592(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0593(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0594(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0595(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0596(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0597(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0598(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0599(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0600(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0601(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0602(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0603(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0604(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0605(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0606(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0607(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0608(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0609(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0610(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0611(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0612(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0613(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0614(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0615(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0616(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0617(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0618(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0619(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0620(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0621(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0622(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0623(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0624(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0625(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0626(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0627(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0628(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0629(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0630(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0631(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0632(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0633(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0634(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0635(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0636(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0637(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0638(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0639(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0640(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0641(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0642(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0643(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0644(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0645(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0646(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0647(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0648(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0649(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0650(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0651(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0652(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0653(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0654(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0655(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0656(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0657(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0658(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0659(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0660(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0661(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0662(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0663(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0664(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0665(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0666(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0667(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0668(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0669(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0670(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0671(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0672(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0673(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0674(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0675(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0676(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0677(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0678(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0679(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0680(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0681(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0682(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0683(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0684(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0685(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0686(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0687(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0688(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0689(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0690(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0691(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0692(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0693(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0694(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0695(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0696(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0697(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0698(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0699(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0700(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0701(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0702(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0703(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0704(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0705(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0706(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0707(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0708(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0709(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0710(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0711(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0712(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0713(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0714(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0715(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0716(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0717(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0718(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0719(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0720(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0721(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0722(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0723(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0724(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0725(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0726(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0727(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0728(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0729(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0730(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0731(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0732(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0733(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0734(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0735(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0736(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0737(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0738(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0739(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0740(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0741(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0742(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0743(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0744(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0745(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0746(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0747(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0748(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0749(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0750(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0751(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0752(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0753(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0754(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0755(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0756(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0757(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0758(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0759(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0760(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0761(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0762(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0763(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0764(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0765(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0766(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0767(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0768(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0769(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0770(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0771(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0772(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0773(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0774(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0775(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0776(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0777(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0778(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0779(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0780(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0781(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0782(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0783(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0784(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0785(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0786(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0787(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0788(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0789(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0790(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0791(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0792(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0793(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0794(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0795(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0796(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0797(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0798(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0799(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0800(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0801(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0802(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0803(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0804(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0805(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0806(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0807(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0808(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0809(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0810(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0811(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0812(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0813(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0814(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0815(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0816(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0817(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0818(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0819(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0820(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0821(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0822(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0823(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0824(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0825(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0826(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0827(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0828(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0829(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0830(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0831(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0832(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0833(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0834(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0835(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0836(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0837(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0838(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0839(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0840(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0841(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0842(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0843(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0844(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0845(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0846(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0847(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0848(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0849(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0850(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0851(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0852(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0853(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0854(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0855(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0856(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0857(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0858(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0859(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0860(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0861(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0862(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0863(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0864(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0865(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0866(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0867(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0868(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0869(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0870(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0871(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0872(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0873(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0874(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0875(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0876(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0877(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0878(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0879(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0880(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0881(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0882(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0883(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0884(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0885(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0886(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0887(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0888(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0889(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0890(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0891(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0892(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0893(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0894(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0895(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0896(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0897(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0898(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0899(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0900(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0901(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0902(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0903(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0904(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0905(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0906(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0907(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0908(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0909(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0910(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0911(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0912(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0913(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0914(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0915(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0916(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0917(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0918(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0919(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0920(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0921(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0922(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0923(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0924(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0925(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0926(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0927(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0928(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0929(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0930(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0931(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0932(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0933(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0934(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0935(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0936(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0937(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0938(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0939(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0940(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0941(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0942(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0943(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0944(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0945(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0946(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0947(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0948(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0949(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0950(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0951(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0952(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0953(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0954(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0955(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0956(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0957(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0958(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0959(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0960(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0961(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0962(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0963(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0964(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0965(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0966(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0967(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0968(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0969(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0970(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0971(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0972(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0973(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0974(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0975(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0976(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0977(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0978(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0979(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0980(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0981(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0982(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0983(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0984(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0985(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0986(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0987(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0988(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0989(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0990(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0991(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0992(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0993(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0994(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0995(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0996(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0997(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0998(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block0999(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01000(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01001(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01002(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01003(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01004(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01005(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01006(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01007(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01008(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01009(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01010(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01011(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01012(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01013(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01014(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01015(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01016(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01017(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01018(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01019(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01020(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01021(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01022(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01023(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01024(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01025(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01026(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01027(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01028(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01029(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01030(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01031(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01032(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01033(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01034(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01035(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01036(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01037(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01038(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01039(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01040(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01041(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01042(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01043(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01044(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01045(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01046(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01047(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01048(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01049(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01050(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01051(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01052(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01053(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01054(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01055(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01056(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01057(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01058(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01059(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01060(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01061(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01062(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01063(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01064(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01065(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01066(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01067(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01068(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01069(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01070(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01071(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01072(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01073(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01074(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01075(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01076(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01077(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01078(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01079(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01080(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01081(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01082(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01083(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01084(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01085(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01086(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01087(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01088(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01089(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01090(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01091(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01092(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01093(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01094(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01095(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01096(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01097(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01098(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01099(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01100(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01101(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01102(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01103(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01104(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01105(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01106(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01107(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01108(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01109(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01110(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01111(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01112(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01113(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01114(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01115(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01116(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01117(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01118(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01119(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01120(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01121(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01122(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01123(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01124(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01125(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01126(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01127(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01128(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01129(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01130(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01131(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01132(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01133(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01134(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01135(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01136(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01137(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01138(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01139(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01140(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01141(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01142(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01143(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01144(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01145(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01146(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01147(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01148(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01149(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01150(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01151(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01152(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01153(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01154(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01155(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01156(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01157(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01158(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01159(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01160(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01161(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01162(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01163(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01164(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01165(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01166(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01167(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01168(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01169(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01170(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01171(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01172(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01173(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01174(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01175(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01176(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01177(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01178(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01179(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01180(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01181(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01182(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01183(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01184(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01185(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01186(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01187(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01188(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01189(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01190(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01191(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01192(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01193(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01194(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01195(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01196(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01197(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01198(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01199(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01200(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01201(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01202(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01203(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01204(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01205(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01206(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01207(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01208(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01209(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01210(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01211(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01212(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01213(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01214(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01215(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01216(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01217(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01218(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01219(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01220(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01221(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01222(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01223(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01224(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01225(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01226(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01227(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01228(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01229(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01230(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01231(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01232(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01233(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01234(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01235(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01236(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01237(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01238(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01239(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01240(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01241(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01242(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01243(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01244(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01245(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01246(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01247(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01248(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01249(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01250(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01251(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01252(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01253(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01254(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01255(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01256(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01257(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01258(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01259(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01260(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01261(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01262(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01263(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01264(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01265(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01266(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01267(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01268(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01269(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01270(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01271(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01272(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01273(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01274(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01275(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01276(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01277(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01278(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01279(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01280(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01281(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01282(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01283(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01284(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01285(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01286(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01287(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01288(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01289(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01290(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01291(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01292(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01293(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01294(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01295(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01296(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01297(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01298(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01299(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01300(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01301(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01302(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01303(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01304(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01305(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01306(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01307(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01308(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01309(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01310(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01311(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01312(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01313(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01314(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01315(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01316(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01317(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01318(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01319(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01320(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01321(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01322(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01323(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01324(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01325(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01326(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01327(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01328(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01329(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01330(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01331(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01332(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01333(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01334(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01335(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01336(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01337(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01338(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01339(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01340(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01341(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01342(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01343(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01344(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01345(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01346(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01347(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01348(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01349(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01350(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01351(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01352(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01353(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01354(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01355(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01356(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01357(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01358(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01359(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01360(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01361(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01362(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01363(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01364(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01365(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01366(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01367(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01368(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01369(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01370(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01371(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01372(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01373(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01374(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01375(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01376(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01377(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01378(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01379(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01380(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01381(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01382(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01383(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01384(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01385(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01386(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01387(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01388(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01389(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01390(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01391(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01392(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01393(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01394(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01395(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01396(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01397(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01398(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01399(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01400(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01401(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01402(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01403(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01404(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01405(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01406(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01407(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01408(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01409(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01410(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01411(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01412(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01413(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01414(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01415(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01416(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01417(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01418(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01419(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01420(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01421(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01422(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01423(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01424(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01425(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01426(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01427(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01428(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01429(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01430(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01431(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01432(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01433(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01434(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01435(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01436(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01437(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01438(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01439(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01440(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01441(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01442(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01443(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01444(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01445(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01446(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01447(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01448(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01449(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01450(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01451(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01452(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01453(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01454(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01455(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01456(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01457(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01458(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01459(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01460(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01461(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01462(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01463(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01464(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01465(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01466(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01467(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01468(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01469(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01470(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01471(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01472(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01473(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01474(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01475(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01476(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01477(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01478(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01479(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01480(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01481(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01482(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01483(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01484(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01485(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01486(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01487(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01488(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01489(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01490(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01491(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01492(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01493(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01494(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01495(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01496(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01497(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01498(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01499(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01500(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01501(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01502(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01503(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01504(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01505(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01506(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01507(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01508(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01509(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01510(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01511(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01512(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01513(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01514(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01515(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01516(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01517(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01518(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01519(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01520(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01521(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01522(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01523(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01524(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01525(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01526(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01527(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01528(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01529(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01530(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01531(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01532(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01533(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01534(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01535(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01536(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01537(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01538(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01539(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01540(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01541(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01542(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01543(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01544(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01545(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01546(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01547(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01548(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01549(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01550(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01551(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01552(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01553(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01554(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01555(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01556(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01557(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01558(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01559(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01560(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01561(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01562(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01563(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01564(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01565(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01566(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01567(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01568(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01569(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01570(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01571(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01572(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01573(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01574(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01575(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01576(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01577(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01578(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01579(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01580(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01581(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01582(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01583(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01584(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01585(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01586(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01587(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01588(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01589(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01590(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01591(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01592(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01593(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01594(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01595(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01596(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01597(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01598(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01599(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01600(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01601(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01602(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01603(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01604(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01605(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01606(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01607(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01608(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01609(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01610(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01611(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01612(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01613(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01614(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01615(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01616(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01617(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01618(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01619(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01620(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01621(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01622(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01623(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01624(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01625(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01626(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01627(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01628(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01629(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01630(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01631(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01632(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01633(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01634(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01635(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01636(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01637(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01638(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01639(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01640(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01641(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01642(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01643(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01644(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01645(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01646(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01647(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01648(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01649(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01650(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01651(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01652(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01653(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01654(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01655(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01656(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01657(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01658(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01659(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01660(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01661(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01662(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01663(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01664(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01665(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01666(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01667(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01668(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01669(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01670(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01671(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01672(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01673(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01674(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01675(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01676(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01677(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01678(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01679(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01680(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01681(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01682(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01683(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01684(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01685(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01686(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01687(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01688(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01689(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01690(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01691(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01692(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01693(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01694(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01695(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01696(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01697(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01698(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01699(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01700(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01701(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01702(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01703(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01704(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01705(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01706(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01707(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01708(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01709(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01710(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01711(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01712(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01713(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01714(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01715(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01716(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01717(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01718(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01719(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01720(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01721(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01722(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01723(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01724(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01725(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01726(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01727(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01728(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01729(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01730(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01731(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_onevent outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01732(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01733(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01734(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; pulsestyle_ondetect outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01735(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01736(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01737(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; showcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01738(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01739(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled inoutPortIdentifier ; endspecify
endmodule
//test type : specify_block_declaration ( specify { pulsestyle_declaration | showcancelled_declaration } endspecify )
//author : Dramba Doru-Gabriel 
module specify_block01740(inoutPortIdentifier,outputPortIdentifier,outputPortIdentifier2);
  inout inoutPortIdentifier;
  output outputPortIdentifier;
  output [14:0] outputPortIdentifier2;
  specify noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; noshowcancelled outputPortIdentifier2[ 15] ; endspecify
endmodule
