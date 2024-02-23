//this is a celldefine valid test
`timescale 1 ms/10 fs
module mod;
wire x;
`celldefine
`define xx
`ifndef xx
`timescale 1 ms/100 us
`else
`timescale 1 ms/1/**/us
`endif
module mymodule;
endmodule
`resetall
endmodule
