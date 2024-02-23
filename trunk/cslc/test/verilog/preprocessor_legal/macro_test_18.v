`define a(w) w
`define \a(w) w
`define \_
`define \000() \
000
`define/**/x  z
/**/`define y 3\

`\000()
`undef \000()
`x`y`x`y`x`y`x`y`x`y
`undef x //s
