//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : eth_fab_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module eth_fab_cluster(ef_df_fabbus80,
                       stf_ef_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 19
  input [79:0] stf_ef_fabbus80;
  output [79:0] ef_df_fabbus80;
  wire ef_eb_fab_dummy2;
  wire eb_em_lb_dummy3;
  eth_tx eth_tx();
  eth_mac eth_mac(.lb_dummy3(eb_em_lb_dummy3));
  eth_io eth_io();
  eth_bridge eth_bridge(.lb_dummy3(eb_em_lb_dummy3),
                        .lba_dummy2(ef_eb_fab_dummy2));
  msi_fabric_if eth_fab(.fab_add_bus80(ef_df_fab_bus80),
                        .fab_drop_bus80(stf_ef_fab_bus80),
                        .lba_dummy2(ef_eb_fab_dummy2));
  eth_rx eth_rx();
  `include "eth_fab_cluster.logic.v"
endmodule

