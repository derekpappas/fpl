//tests made by: GabrielD
`include "../legal/macro_ifs_2.v"
/**/`ifdef x
`define y
`else
`define z
`endif
/**/`ifdef /**/y//
  we have y/*i*/from x
  and we are proud
`elsif z
  we have z
`else
  we do not have anything
`endif
end of test
