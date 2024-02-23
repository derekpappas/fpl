//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : maclu.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module maclu(maltbusy,
             malthit,
             maltport,
             maltstart,
             adwaddr,
             adwdata,
             adwwr);
// Location of source csl unit: file name = generated/mitch.csl line number = 32
  input maltstart;
  input [17:0] adwaddr;
  input [31:0] adwdata;
  output maltbusy;
  output malthit;
  output maltport;
  output adwwr;
  `include "maclu.logic.v"
endmodule

