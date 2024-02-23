//macro loop need's to be detected
`define word(_) `_
`define x(_) `word(_)
`x(x)
