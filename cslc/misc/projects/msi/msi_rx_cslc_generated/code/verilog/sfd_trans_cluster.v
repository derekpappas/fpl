//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sfd_trans_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module sfd_trans_cluster(stf_ef_fabbus80,
                         mtf_stf_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 36
  input [79:0] mtf_stf_fabbus80;
  output [79:0] stf_ef_fabbus80;
  wire stf_stl_fab_dummy2;
  wire stl_st_lb_dummy3;
  sfd_trans sfd_trans(.lb_dummy3(stl_st_lb_dummy3));
  msi_fabric_if sfd_trans_fab(.fab_add_bus80(stf_ef_fab_bus80),
                              .fab_drop_bus80(mtf_stf_fab_bus80),
                              .lba_dummy2(stf_stl_fab_dummy2));
  sfd_trans_lba sfd_trans_lba(.lb_dummy3(stl_st_lb_dummy3),
                              .lba_dummy2(stf_stl_fab_dummy2));
  `include "sfd_trans_cluster.logic.v"
endmodule

