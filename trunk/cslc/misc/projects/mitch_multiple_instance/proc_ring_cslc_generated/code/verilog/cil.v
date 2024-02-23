//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : cil.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module cil(sbstart,
           sbbusy,
           sbfdstart,
           sbfdbusy,
           maltbusy,
           malthit,
           maltport,
           maltstart,
           vrrvalid,
           vrrrd,
           vrrresult,
           cdrvcmd,
           cdrvdata,
           cdrvready,
           cdrvvalid);
// Location of source csl unit: file name = generated/mitch.csl line number = 29
  input sbbusy;
  input sbfdbusy;
  input maltbusy;
  input malthit;
  input maltport;
  input vrrvalid;
  input [31:0] vrrresult;
  output sbstart;
  output sbfdstart;
  output maltstart;
  output vrrrd;
  output cdrvcmd;
  output [31:0] cdrvdata;
  output cdrvready;
  output cdrvvalid;
  `include "cil.logic.v"
endmodule

