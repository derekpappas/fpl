//this is a celldefine valid test
`timescale 1 ms/10 fs
module mod;
wire x;
`celldefine
`timescale 1 ms/100 us
module mymodule;
endmodule
`resetall
endmodule
