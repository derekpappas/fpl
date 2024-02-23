`define x x
`define y y
`define z z
`define xx xx

`ifndef x
  `define xx xxx
  `define t t
  `define v v
  `include "../legal/macro_test_15.v"
`elsif y
  `ifdef z
    `define t xyzt
  `else
    `define t xyzt2
    `define v xyzv
  `endif
  `ifdef v
    `define vv vv
  `elsif t
    `define v xytv
    `define vv vvvv
  `endif
`endif

`xx
`x
`y
`z
`t
`v
`vv
