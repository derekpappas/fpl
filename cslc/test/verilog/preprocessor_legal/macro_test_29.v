`include "../legal/macro_test_30.v"
`ifdef x
  `define x /
  20 `x 10;
  `include "../legal/macro_test_28.v"
  `undef x
//  writing undefined x :`x
  `ifdef x
  `else 
    `define x *
  `ifdef x
    20 `x 10;
    `include "../legal/macro_test_28.v"
    `define x ***
  `endif
  my girlfriend is sexy
  `endif
  she likes me!
`endif
yes, she realy likes me
x= `x
