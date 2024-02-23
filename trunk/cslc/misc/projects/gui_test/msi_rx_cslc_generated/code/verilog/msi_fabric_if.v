//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : msi_fabric_if.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module msi_fabric_if(fab_addbus80,
                     lbadummy2,
                     fab_dropbus80,
                     lbdummy3);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 45
  input [79:0] fab_dropbus80;
  input lbdummy3;
  output [79:0] fab_addbus80;
  output lbadummy2;
  `include "msi_fabric_if.logic.v"
endmodule

