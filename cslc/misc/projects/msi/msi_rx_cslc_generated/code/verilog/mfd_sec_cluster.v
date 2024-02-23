//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : mfd_sec_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module mfd_sec_cluster(msf_mtf_fabbus80,
                       mdf_msf_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 24
  input [79:0] mdf_msf_fabbus80;
  output [79:0] msf_mtf_fabbus80;
  wire msf_msl_lba_dummy2;
  wire msl_ms_lb_dummy3;
  msi_fabric_if mfd_sec_fab(.fab_add_bus80(msf_mtf_fab_bus80),
                            .fab_drop_bus80(mdf_msf_fab_bus80),
                            .lba_dummy2(msf_msl_lba_dummy2));
  mfd_sec_lba mfd_sec_lba(.lb_dummy3(msl_ms_lb_dummy3),
                          .lba_dummy2(msf_msl_lba_dummy2));
  mfd_sec mfd_sec(.lb_dummy3(msl_ms_lb_dummy3));
  `include "mfd_sec_cluster.logic.v"
endmodule

