`define x timescale 10s/1s
`define y x
`ifdef x
`timescale 10s/1s
`else `timescale 1s/1s
`endif
`x
