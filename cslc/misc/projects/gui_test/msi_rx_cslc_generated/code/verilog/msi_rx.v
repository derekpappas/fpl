//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : msi_rx.v
//FILE GENERATED ON : Thu Jun 19 15:32:42 2008

`include "defines.v"

module msi_rx();
// Location of source csl unit: file name = generated/msi_phase_1.csl line number = 13
  wire [79:0] msf_mtf_fab_bus80;
  wire [79:0] mdf_msf_fab_bus80;
  wire [79:0] ssf_mdf_fab_bus80;
  wire [79:0] sdf_ssf_fab_bus80;
  wire [79:0] scf_sdf_fab_bus80;
  wire [79:0] sff_scf_fab_bus80;
  wire [79:0] if_sff_fab_bus80;
  wire [79:0] af_if_fab_bus80;
  wire [79:0] df_af_fab_bus80;
  wire [79:0] ef_df_fab_bus80;
  wire [79:0] stf_ef_fab_bus80;
  wire [79:0] mtf_stf_fab_bus80;
  wire ab_nina_lb_dummy3;
  nina nina(.lb_dummy3(ab_nina_lb_dummy3));
  mfd_trans_cluster mfd_trans_cluster(.msf_mtf_fab_bus80(msf_mtf_fab_bus80),
                                      .mtf_stf_fab_bus80(mtf_stf_fab_bus80));
  sd_flash_cluster sd_flash_cluster(.if_sff_fab_bus80(if_sff_fab_bus80),
                                    .sff_scf_fab_bus80(sff_scf_fab_bus80));
  avalon_fab_cluster avalon_fab_cluster(.ab_nina_lb_dummy3(ab_nina_lb_dummy3),
                                        .af_if_fab_bus80(af_if_fab_bus80),
                                        .df_af_fab_bus80(df_af_fab_bus80));
  sfd_data_cluster sfd_data_cluster(.scf_sdf_fab_bus80(scf_sdf_fab_bus80),
                                    .sdf_ssf_fab_bus80(sdf_ssf_fab_bus80));
  sfd_trans_cluster sfd_trans_cluster(.mtf_stf_fab_bus80(mtf_stf_fab_bus80),
                                      .stf_ef_fab_bus80(stf_ef_fab_bus80));
  eth_fab_cluster eth_fab_cluster(.ef_df_fab_bus80(ef_df_fab_bus80),
                                  .stf_ef_fab_bus80(stf_ef_fab_bus80));
  spi_cntl_cluster spi_cntl_cluster(.scf_sdf_fab_bus80(scf_sdf_fab_bus80),
                                    .sff_scf_fab_bus80(sff_scf_fab_bus80));
  mfd_data_cluster mfd_data_cluster(.mdf_msf_fab_bus80(mdf_msf_fab_bus80),
                                    .ssf_mdf_fab_bus80(ssf_mdf_fab_bus80));
  mfd_sec_cluster mfd_sec_cluster(.mdf_msf_fab_bus80(mdf_msf_fab_bus80),
                                  .msf_mtf_fab_bus80(msf_mtf_fab_bus80));
  ddr_fab_cluster ddr_fab_cluster(.df_af_fab_bus80(df_af_fab_bus80),
                                  .ef_df_fab_bus80(ef_df_fab_bus80));
  i2c_cluster i2c_cluster(.af_if_fab_bus80(af_if_fab_bus80),
                          .if_sff_fab_bus80(if_sff_fab_bus80));
  sfd_stig_cluster sfd_stig_cluster(.sdf_ssf_fab_bus80(sdf_ssf_fab_bus80),
                                    .ssf_mdf_fab_bus80(ssf_mdf_fab_bus80));
  `include "msi_rx.logic.v"
endmodule

