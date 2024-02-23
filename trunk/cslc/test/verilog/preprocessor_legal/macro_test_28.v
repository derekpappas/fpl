`define a simple
`define \y zzz
`define x(a,b,c) a b c `y(\y,\y)
`define y(a,b) `a\
`b
module `a;
`ifndef x
  reg x = 1;
  reg y = 0;
`else 
  reg x = 0;
  reg y = 1;
  `ifdef a
    reg z = 1;
    reg s = 1;
    `x(aaa
, bbb
, `y(a,a)
`y(a,a)
)
  `endif
`endif
endmodule
