//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : eth_fab_cluster.v
//FILE GENERATED ON : Tue Jun 17 01:23:46 2008

`include "defines.v"

module eth_fab_cluster();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 19
  eth_tx eth_tx();
  eth_mac eth_mac();
  eth_io eth_io();
  eth_bridge eth_bridge();
  msi_fabric_if eth_fab();
  eth_rx eth_rx();
  `include "eth_fab_cluster.logic.v"
endmodule

