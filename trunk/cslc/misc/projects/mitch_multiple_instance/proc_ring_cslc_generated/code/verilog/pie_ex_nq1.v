//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : pie_ex_nq1.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module pie_ex_nq1(fab_addaddr,
                  fab_adddata,
                  fab_addnid,
                  fab_addready,
                  fab_addreject,
                  fab_addtype,
                  fab_addvalid,
                  fab_dropaddr,
                  fab_dropdata,
                  fab_dropnid,
                  fab_dropready,
                  fab_dropreject,
                  fab_droptype,
                  fab_dropvalid);
// Location of source csl unit: file name = generated/mitch.csl line number = 27
  input fab_addready;
  input [17:0] fab_dropaddr;
  input [31:0] fab_dropdata;
  input [3:0] fab_dropnid;
  input fab_dropreject;
  input [3:0] fab_droptype;
  input fab_dropvalid;
  output [17:0] fab_addaddr;
  output [31:0] fab_adddata;
  output [3:0] fab_addnid;
  output fab_addreject;
  output [3:0] fab_addtype;
  output fab_addvalid;
  output fab_dropready;
  `include "pie_ex_nq1.logic.v"
endmodule

