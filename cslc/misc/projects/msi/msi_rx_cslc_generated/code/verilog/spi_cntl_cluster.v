//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : spi_cntl_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module spi_cntl_cluster(scf_sdf_fabbus80,
                        sff_scf_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 16
  input [79:0] sff_scf_fabbus80;
  output [79:0] scf_sdf_fabbus80;
  wire scf_scl_lba_dummy2;
  wire scl_sc_lb_dummy3;
  spi_cntl spi_cntl(.lb_dummy3(scl_sc_lb_dummy3));
  spi_cntl_lba spi_cntl_lba(.lb_dummy3(scl_sc_lb_dummy3),
                            .lba_dummy2(scf_scl_lba_dummy2));
  msi_fabric_if spi_cntl_fab(.fab_add_bus80(scf_sdf_fab_bus80),
                             .fab_drop_bus80(sff_scf_fab_bus80),
                             .lba_dummy2(scf_scl_lba_dummy2));
  `include "spi_cntl_cluster.logic.v"
endmodule

