//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : put_dma.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module put_dma(cdrvcmd,
               cdrvdata,
               cdrvready,
               cdrvvalid,
               sbstart,
               sbbusy);
// Location of source csl unit: file name = generated/mitch.csl line number = 24
  input cdrvcmd;
  input [31:0] cdrvdata;
  input cdrvready;
  input cdrvvalid;
  input sbstart;
  output sbbusy;
  `include "put_dma.logic.v"
endmodule

