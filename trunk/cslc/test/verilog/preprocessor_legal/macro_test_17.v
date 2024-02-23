`define x 12
`define y(_) _`x
`define z(a) a `y(a)

`z(1)
`define x
`z(1)
`undef x
`define x 13
`z(1)
`undef x
