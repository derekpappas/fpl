//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : fabric_drop.v
//FILE GENERATED ON : Wed Jul  9 20:26:20 2008

`include "defines.v"

module fabric_drop(db_dwdata,
                   db_dwwr,
                   dreg_dwdata,
                   dreg_dwwr,
                   maclu_adwaddr,
                   maclu_adwdata,
                   maclu_adwwr,
                   qm_adwaddr,
                   qm_adwdata,
                   qm_adwwr,
                   adwraddr,
                   adwrdata,
                   adwrwr,
                   adwrrd);
// Location of source csl unit: file name = generated/mitch.csl line number = 15
  input db_dwwr;
  input dreg_dwwr;
  input maclu_adwwr;
  input qm_adwwr;
  output [31:0] db_dwdata;
  output [31:0] dreg_dwdata;
  output [17:0] maclu_adwaddr;
  output [31:0] maclu_adwdata;
  output [17:0] qm_adwaddr;
  output [31:0] qm_adwdata;
  output [17:0] adwraddr;
  output [31:0] adwrdata;
  output adwrwr;
  output adwrrd;
  `include "fabric_drop.logic.v"
endmodule

