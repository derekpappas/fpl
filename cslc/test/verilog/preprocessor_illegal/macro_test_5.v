`define x 12
`define y(_) _`x
`define z(a) a `y(a)
`undef x

`z(1)

