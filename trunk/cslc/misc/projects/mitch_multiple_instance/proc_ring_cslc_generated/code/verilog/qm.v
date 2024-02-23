//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : qm.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module qm(dwaddr,
          dwdata,
          dwwr);
// Location of source csl unit: file name = generated/mitch.csl line number = 18
  input [17:0] dwaddr;
  input [31:0] dwdata;
  output dwwr;
  `include "qm.logic.v"
endmodule

