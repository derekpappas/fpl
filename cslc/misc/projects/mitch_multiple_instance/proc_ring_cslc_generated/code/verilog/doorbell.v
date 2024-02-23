//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : doorbell.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module doorbell(vrrvalid,
                vrrrd,
                vrrresult,
                dwdata,
                dwwr);
// Location of source csl unit: file name = generated/mitch.csl line number = 14
  input vrrrd;
  input [31:0] dwdata;
  output vrrvalid;
  output [31:0] vrrresult;
  output dwwr;
  `include "doorbell.logic.v"
endmodule

