//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : i2c_cluster.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module i2c_cluster(if_sff_fabbus80,
                   af_if_fabbus80);
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 40
  input [79:0] af_if_fabbus80;
  output [79:0] if_sff_fabbus80;
  wire if_il_lba_dummy2;
  wire il_i_lb_dummy3;
  msi_fabric_if i2c_fab(.fab_add_bus80(if_sff_fab_bus80),
                        .fab_drop_bus80(af_if_fab_bus80),
                        .lba_dummy2(if_il_lba_dummy2));
  i2c i2c(.lb_dummy3(il_i_lb_dummy3));
  i2c_lba i2c_lba(.lb_dummy3(il_i_lb_dummy3),
                  .lba_dummy2(if_il_lba_dummy2));
  `include "i2c_cluster.logic.v"
endmodule

