`define zz(b) ___ b
`define z(a) __ a `zz(a + 1) 
`define x(_) _ `z(_ + 1)

`x(1)
