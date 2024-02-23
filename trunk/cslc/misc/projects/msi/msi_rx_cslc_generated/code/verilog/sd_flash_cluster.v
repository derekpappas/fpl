//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : sd_flash_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module sd_flash_cluster(sff_scf_fabbus80,
                        if_sff_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 33
  input [79:0] if_sff_fabbus80;
  output [79:0] sff_scf_fabbus80;
  wire sff_sfl_lba_dummy2;
  wire sfl_sf_lb_dummy3;
  sd_flash sd_flash(.lb_dummy3(sfl_sf_lb_dummy3));
  msi_fabric_if sd_flash_fab(.fab_add_bus80(sff_scf_fab_bus80),
                             .fab_drop_bus80(if_sff_fab_bus80),
                             .lba_dummy2(sff_sfl_lba_dummy2));
  sd_flash_lba sd_flash_lba(.lb_dummy3(sfl_sf_lb_dummy3),
                            .lba_dummy2(sff_sfl_lba_dummy2));
  `include "sd_flash_cluster.logic.v"
endmodule

