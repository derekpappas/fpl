//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : mfd_trans_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module mfd_trans_cluster(msf_mtf_fabbus80,
                         mtf_stf_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 49
  input [79:0] msf_mtf_fabbus80;
  output [79:0] mtf_stf_fabbus80;
  wire mtf_mtl_fab_dummy2;
  wire mtl_mt_lb_dummy3;
  mfd_trans mfd_trans(.lb_dummy3(mtl_mt_lb_dummy3));
  mfd_trans_lba mfd_trans_lba(.lb_dummy3(mtl_mt_lb_dummy3),
                              .lba_dummy2(mtf_mtl_fab_dummy2));
  msi_fabric_if mfd_trans_fab(.fab_add_bus80(mtf_stf_fab_bus80),
                              .fab_drop_bus80(msf_mtf_fab_bus80),
                              .lba_dummy2(mtf_mtl_fab_dummy2));
  `include "mfd_trans_cluster.logic.v"
endmodule

