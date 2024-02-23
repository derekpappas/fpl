//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : avalon_fab_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module avalon_fab_cluster(af_if_fabbus80,
                          df_af_fabbus80,
                          ab_nina_lbdummy3);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 23
  input [79:0] df_af_fabbus80;
  output [79:0] af_if_fabbus80;
  output ab_nina_lbdummy3;
  wire af_ab_lba_dummy2;
  msi_fabric_if avalon_fab(.fab_add_bus80(af_if_fab_bus80),
                           .fab_drop_bus80(df_af_fab_bus80),
                           .lba_dummy2(af_ab_lba_dummy2));
  avalon_bridge avalon_bridge(.lb_dummy3(ab_nina_lb_dummy3),
                              .lba_dummy2(af_ab_lba_dummy2));
  `include "avalon_fab_cluster.logic.v"
endmodule

