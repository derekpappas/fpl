//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sfd_stig_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module sfd_stig_cluster(ssf_mdf_fabbus80,
                        sdf_ssf_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 50
  input [79:0] sdf_ssf_fabbus80;
  output [79:0] ssf_mdf_fabbus80;
  wire ssf_ssl_lba_dummy2;
  wire ssl_ss_lb_dummy3;
  sfd_stig sfd_stig(.lb_dummy3(ssl_ss_lb_dummy3));
  sfd_stig_lba sfd_stig_lba(.lb_dummy3(ssl_ss_lb_dummy3),
                            .lba_dummy2(ssf_ssl_lba_dummy2));
  msi_fabric_if sfd_stig_fab(.fab_add_bus80(ssf_mdf_fab_bus80),
                             .fab_drop_bus80(sdf_ssf_fab_bus80),
                             .lba_dummy2(ssf_ssl_lba_dummy2));
  `include "sfd_stig_cluster.logic.v"
endmodule

