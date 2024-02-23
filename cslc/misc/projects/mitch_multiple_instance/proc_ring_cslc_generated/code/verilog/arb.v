//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : arb.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module arb(adwraddr,
           adwrdata,
           adwrwr,
           adwrrd);
// Location of source csl unit: file name = generated/mitch.csl line number = 31
  input [17:0] adwraddr;
  input [31:0] adwrdata;
  input adwrwr;
  input adwrrd;
  `include "arb.logic.v"
endmodule

