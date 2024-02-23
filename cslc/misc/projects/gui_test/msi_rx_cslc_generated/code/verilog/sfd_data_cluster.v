//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sfd_data_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module sfd_data_cluster(sdf_ssf_fabbus80,
                        scf_sdf_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 22
  input [79:0] scf_sdf_fabbus80;
  output [79:0] sdf_ssf_fabbus80;
  wire sdf_sdl_lba_dummy2;
  wire sd_sd_lb_dummy3;
  sfd_data sfd_data(.lb_dummy3(sd_sd_lb_dummy3));
  msi_fabric_if sfd_data_fab(.fab_add_bus80(sdf_ssf_fab_bus80),
                             .fab_drop_bus80(scf_sdf_fab_bus80),
                             .lba_dummy2(sdf_sdl_lba_dummy2));
  sfd_data_lba sfd_data_lba(.lb_dummy3(sd_sd_lb_dummy3),
                            .lba_dummy2(sdf_sdl_lba_dummy2));
  `include "sfd_data_cluster.logic.v"
endmodule

