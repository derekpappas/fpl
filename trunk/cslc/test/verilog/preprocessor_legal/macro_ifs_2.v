`define x
ifdef
/********/`ifdef/*/*/x/****/ //
/*mmmmm*/  print something  //
/**/`else/***/ //
/**/`endif//
endif
`undef x
ifdef
`ifdef x
second print
`else
  else
`endif
endif
`define x
