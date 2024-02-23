`ifndef U00
module should_be_true;
`else
module should_be_false;
`endif

`define D00
`define D01

`ifdef D00
reg t00;
`elsif D01
reg f00;
`endif

`ifdef U00
reg f01;
`elsif D01
reg t01;
`endif

`ifdef U00
reg f02;
`elsif U01
reg f02;
`endif

`ifdef U00
reg f03;
`elsif U01
reg f03;
`else
reg t03;
`endif


`ifdef U00
reg f04;
`elsif U01
reg f04;
`elsif U01
reg f04;
`elsif D01
	`ifdef D01
	reg t040;
	`elsif D00
	reg f040;
	`endif 
	`ifdef U01
	reg f041;
	`elsif D00
	reg t041;
	`elsif D00
	reg f041;
	`elsif D00
	reg f041;
	`else
	reg f041;
	`endif 
`elsif U01
reg f04;
`elsif D01
reg f04;
`endif


`ifdef D00
	`ifdef D01
	reg t050;
	`elsif D00
	reg f050;
	`endif 
	`ifdef U01
	reg f051;
	`elsif D00
	reg t051;
	`elsif D00
	reg f051;
	`elsif D00
	reg f051;
	`else
	reg f051;
	`endif 
`else
reg f05;
`endif

`ifdef U00
	`ifdef D01
	reg f060;
	`elsif D00
	reg f060;
	`endif 
	`ifdef U01
	reg f061;
	`elsif D00
	reg f061;
	`elsif D00
	reg f061;
	`elsif D00
	reg f061;
	`else
	reg f061;
	`endif 
`else
reg t06;
`endif

`define U07
`undef U07
`define D07 T

`ifndef U07
reg t07;
`elsif D07
reg f07;
`elsif D07
reg f07;
`elsif D07
reg f07;
`endif

endmodule
