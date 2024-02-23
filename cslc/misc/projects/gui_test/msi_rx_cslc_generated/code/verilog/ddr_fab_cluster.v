//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : ddr_fab_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module ddr_fab_cluster(df_af_fabbus80,
                       ef_df_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 51
  input [79:0] ef_df_fabbus80;
  output [79:0] df_af_fabbus80;
  wire df_dbc_fab_dummy2;
  wire dbc_dc_lb_dummy3;
  ddr_ctrl ddr_ctrl(.lb_dummy3(dbc_dc_lb_dummy3));
  ddr_bridge_ctrl ddr_bridge_ctrl();
  ddr_buf_ctrl ddr_buf_ctrl(.lb_dummy3(dbc_dc_lb_dummy3),
                            .lba_dummy2(df_dbc_fab_dummy2));
  msi_fabric_if ddr_fab(.fab_add_bus80(df_af_fab_bus80),
                        .fab_drop_bus80(ef_df_fab_bus80),
                        .lba_dummy2(df_dbc_fab_dummy2));
  `include "ddr_fab_cluster.logic.v"
endmodule

