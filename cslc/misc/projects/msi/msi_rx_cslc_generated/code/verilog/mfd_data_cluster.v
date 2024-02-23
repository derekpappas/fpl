//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : mfd_data_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module mfd_data_cluster(mdf_msf_fabbus80,
                        ssf_mdf_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 44
  input [79:0] ssf_mdf_fabbus80;
  output [79:0] mdf_msf_fabbus80;
  wire mdf_mdl_lba_dummy2;
  wire mdl_md_lb_dummy3;
  msi_fabric_if mfd_data_fab(.fab_add_bus80(mdf_msf_fab_bus80),
                             .fab_drop_bus80(ssf_mdf_fab_bus80),
                             .lb_dummy3(mdl_md_lb_dummy3),
                             .lba_dummy2(mdf_mdl_lba_dummy2));
  mfd_data_lba mfd_data_lba(.lb_dummy3(mdl_md_lb_dummy3),
                            .lba_dummy2(mdf_mdl_lba_dummy2));
  mfd_data mfd_data();
  `include "mfd_data_cluster.logic.v"
endmodule

