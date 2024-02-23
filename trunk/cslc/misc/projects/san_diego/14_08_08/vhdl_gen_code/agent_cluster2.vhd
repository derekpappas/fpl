-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./agent_cluster2_cslc_generated/code/vhdl/agent_cluster2.vhd
-- FILE GENERATED ON : Thu Aug 14 15:06:21 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \agent_cluster2\ is
  port(\from_csw_ifc_ag_cluster_data_to_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \from_csw_ifc_ag_cluster_ptag_to_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \from_csw_ifc_ag_cluster_dev_id_to_agents\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \from_csw_ifc_ag_cluster_wr_to_agents\ : in csl_bit;
       \to_csw_ifc_ag_cluster_data_from_agents\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \to_csw_ifc_ag_cluster_ptag_from_agents\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \to_csw_ifc_ag_cluster_dest_from_agents\ : inout csl_bit_vector(10#9# - 10#1# downto 10#0#);
       \to_csw_ifc_ag_cluster_wr_from_agents\ : inout csl_bit;
       \to_csw_ifc_ag_cluster_ready_to_agents\ : in csl_bit);
begin
end entity;

architecture \agent_cluster2_logic\ of \agent_cluster2\ is
  signal \ififo_ag_ifc_ff_fp_infifo_pkt_tag\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \ififo_ag_ifc_ff_fp_infifo_data\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \ififo_ag_ifc_ff_fp_infifo_empty\ : csl_bit;
  signal \ififo_ag_ifc_ff_fp_infifo_empty_count\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \ififo_ag_ifc_ff_fp_infifo_rd\ : csl_bit;
  signal \ag_ofifo_ifc_ag_fp_outfifo_full\ : csl_bit;
  signal \ag_ofifo_ifc_ag_fp_outfifo_full_count\ : csl_bit_vector(10#5# - 10#1# downto 10#0#);
  signal \ag_ofifo_ifc_ag_fp_outfifo_data\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \ag_ofifo_ifc_ag_fp_outfifo_write\ : csl_bit;
  signal \ag_accreg_ifc_ag_agent_rd_req\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \ag_accreg_ifc_ag_agent_address\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \ag_accreg_ifc_ag_agent_wr_req\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \ag_accreg_ifc_ag_agent_wr_data\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \ag_accreg_ifc_ag_agent_ack\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \ag_accreg_ifc_ag_agent_rd_data\ : csl_bit_vector(10#128# - 10#1# downto 10#0#);
  signal \ofifo_acc_ifc_ff_fpo_data_from_agents\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \ofifo_acc_ifc_ff_fpo_ptag_from_agents\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \ofifo_acc_ifc_ff_fpo_empty_from_agents\ : csl_bit;
  signal \ofifo_acc_ifc_ff_acc_rd_from_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc0_acc_data_to_agents\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc0_acc_ptag_to_agents\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc0_acc_wr_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc0_fp_full_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc0_fpi_credit_req\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc0_fpi_credit_data\ : csl_bit_vector(10#128# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc0_acc_credit_ack\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc0_acc_credit_enable\ : csl_bit;
  signal \acc_ififo_ifc_acc1_acc_data_to_agents\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc1_acc_ptag_to_agents\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc1_acc_wr_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc1_fp_full_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc1_fpi_credit_req\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc1_fpi_credit_data\ : csl_bit_vector(10#128# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc1_acc_credit_ack\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc1_acc_credit_enable\ : csl_bit;
  signal \acc_ififo_ifc_acc2_acc_data_to_agents\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc2_acc_ptag_to_agents\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc2_acc_wr_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc2_fp_full_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc2_fpi_credit_req\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc2_fpi_credit_data\ : csl_bit_vector(10#128# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc2_acc_credit_ack\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc2_acc_credit_enable\ : csl_bit;
  signal \acc_ififo_ifc_acc3_acc_data_to_agents\ : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc3_acc_ptag_to_agents\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc3_acc_wr_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc3_fp_full_to_agents\ : csl_bit;
  signal \acc_ififo_ifc_acc3_fpi_credit_req\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc3_fpi_credit_data\ : csl_bit_vector(10#128# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc3_acc_credit_ack\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \acc_ififo_ifc_acc3_acc_credit_enable\ : csl_bit;

  component \fifo_port32_in\ is
    port(\ififo_ag_ifc_ff_fp_infifo_pkt_tag\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ififo_ag_ifc_ff_fp_infifo_data\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ififo_ag_ifc_ff_fp_infifo_empty\ : inout csl_bit;
         \ififo_ag_ifc_ff_fp_infifo_empty_count\ : inout csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \ififo_ag_ifc_ff_fp_infifo_rd\ : in csl_bit;
         \acc_ififo_ifc_ff_acc_data_to_agents\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \acc_ififo_ifc_ff_acc_ptag_to_agents\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \acc_ififo_ifc_ff_acc_wr_to_agents\ : inout csl_bit;
         \acc_ififo_ifc_ff_fp_full_to_agents\ : in csl_bit;
         \acc_ififo_ifc_ff_fpi_credit_req\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_ff_fpi_credit_data\ : inout csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \acc_ififo_ifc_ff_acc_credit_ack\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_ff_acc_credit_enable\ : inout csl_bit);
  end component;

  component \fifo_port32_out\ is
    port(\ofifo_acc_ifc_ff_fpo_data_from_agents\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_ff_fpo_ptag_from_agents\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_ff_fpo_empty_from_agents\ : inout csl_bit;
         \ofifo_acc_ifc_ff_acc_rd_from_agents\ : in csl_bit;
         \ag_ofifo_ifc_ff_fp_outfifo_full\ : in csl_bit;
         \ag_ofifo_ifc_ff_fp_outfifo_full_count\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \ag_ofifo_ifc_ff_fp_outfifo_data\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_ofifo_ifc_ff_fp_outfifo_pkt_tag\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ag_ofifo_ifc_ff_fp_outfifo_write\ : inout csl_bit);
  end component;

  component \loopback32_agent\ is
    port(\ag_ofifo_ifc_ag_fp_outfifo_full\ : inout csl_bit;
         \ag_ofifo_ifc_ag_fp_outfifo_full_count\ : inout csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \ag_ofifo_ifc_ag_fp_outfifo_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ag_ofifo_ifc_ag_fp_outfifo_write\ : in csl_bit;
         \ag_accreg_ifc_ag_agent_rd_req\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_ag_agent_address\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_ag_agent_wr_req\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_ag_agent_wr_data\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_ag_agent_ack\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_ag_agent_rd_data\ : in csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \ififo_ag_ifc_ag_fp_infifo_pkt_tag\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ififo_ag_ifc_ag_fp_infifo_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ififo_ag_ifc_ag_fp_infifo_empty\ : in csl_bit;
         \ififo_ag_ifc_ag_fp_infifo_empty_count\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \ififo_ag_ifc_ag_fp_infifo_rd\ : inout csl_bit);
  end component;

  component \agent_long_reach\ is
  end component;

  component \acc\ is
    port(\acc_ififo_ifc_acc0_acc_data_to_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc0_acc_ptag_to_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc0_acc_wr_to_agents\ : in csl_bit;
         \acc_ififo_ifc_acc0_fp_full_to_agents\ : inout csl_bit;
         \acc_ififo_ifc_acc0_fpi_credit_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc0_fpi_credit_data\ : in csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc0_acc_credit_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc0_acc_credit_enable\ : in csl_bit;
         \acc_ififo_ifc_acc1_acc_data_to_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc1_acc_ptag_to_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc1_acc_wr_to_agents\ : in csl_bit;
         \acc_ififo_ifc_acc1_fp_full_to_agents\ : inout csl_bit;
         \acc_ififo_ifc_acc1_fpi_credit_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc1_fpi_credit_data\ : in csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc1_acc_credit_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc1_acc_credit_enable\ : in csl_bit;
         \acc_ififo_ifc_acc2_acc_data_to_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc2_acc_ptag_to_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc2_acc_wr_to_agents\ : in csl_bit;
         \acc_ififo_ifc_acc2_fp_full_to_agents\ : inout csl_bit;
         \acc_ififo_ifc_acc2_fpi_credit_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc2_fpi_credit_data\ : in csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc2_acc_credit_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc2_acc_credit_enable\ : in csl_bit;
         \acc_ififo_ifc_acc3_acc_data_to_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc3_acc_ptag_to_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc3_acc_wr_to_agents\ : in csl_bit;
         \acc_ififo_ifc_acc3_fp_full_to_agents\ : inout csl_bit;
         \acc_ififo_ifc_acc3_fpi_credit_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc3_fpi_credit_data\ : in csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc3_acc_credit_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \acc_ififo_ifc_acc3_acc_credit_enable\ : in csl_bit;
         \to_csw_ifc_acc_cluster_data_from_agents\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \to_csw_ifc_acc_cluster_ptag_from_agents\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \to_csw_ifc_acc_cluster_dest_from_agents\ : inout csl_bit_vector(10#9# - 10#1# downto 10#0#);
         \to_csw_ifc_acc_cluster_wr_from_agents\ : inout csl_bit;
         \to_csw_ifc_acc_cluster_ready_to_agents\ : in csl_bit;
         \ag_accreg_ifc_acc0_agent_rd_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc0_agent_address\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc0_agent_wr_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc0_agent_wr_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc0_agent_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc0_agent_rd_data\ : inout csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc1_agent_rd_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc1_agent_address\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc1_agent_wr_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc1_agent_wr_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc1_agent_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc1_agent_rd_data\ : inout csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc2_agent_rd_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc2_agent_address\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc2_agent_wr_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc2_agent_wr_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc2_agent_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc2_agent_rd_data\ : inout csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc3_agent_rd_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc3_agent_address\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc3_agent_wr_req\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc3_agent_wr_data\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc3_agent_ack\ : inout csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ag_accreg_ifc_acc3_agent_rd_data\ : inout csl_bit_vector(10#128# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc0_fpo_data_from_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc0_fpo_ptag_from_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc0_fpo_empty_from_agents\ : in csl_bit;
         \ofifo_acc_ifc_acc0_acc_rd_from_agents\ : inout csl_bit;
         \ofifo_acc_ifc_acc1_fpo_data_from_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc1_fpo_ptag_from_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc1_fpo_empty_from_agents\ : in csl_bit;
         \ofifo_acc_ifc_acc1_acc_rd_from_agents\ : inout csl_bit;
         \ofifo_acc_ifc_acc2_fpo_data_from_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc2_fpo_ptag_from_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc2_fpo_empty_from_agents\ : in csl_bit;
         \ofifo_acc_ifc_acc2_acc_rd_from_agents\ : inout csl_bit;
         \ofifo_acc_ifc_acc3_fpo_data_from_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc3_fpo_ptag_from_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \ofifo_acc_ifc_acc3_fpo_empty_from_agents\ : in csl_bit;
         \ofifo_acc_ifc_acc3_acc_rd_from_agents\ : inout csl_bit;
         \from_csw_ifc_acc_cluster_data_to_agents\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \from_csw_ifc_acc_cluster_ptag_to_agents\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \from_csw_ifc_acc_cluster_dev_id_to_agents\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
         \from_csw_ifc_acc_cluster_wr_to_agents\ : in csl_bit);
  end component;

  component \dp_fp32_gasket\ is
  end component;
begin
  \I_AGT3_FP0_IN\ : \fifo_port32_in\ port map (\acc_ififo_ifc_ff_acc_credit_ack\ => \acc_ififo_ifc_acc3_acc_credit_ack\,
                                               \acc_ififo_ifc_ff_acc_credit_enable\ => \acc_ififo_ifc_acc3_acc_credit_enable\,
                                               \acc_ififo_ifc_ff_acc_data_to_agents\ => \acc_ififo_ifc_acc3_acc_data_to_agents\,
                                               \acc_ififo_ifc_ff_acc_ptag_to_agents\ => \acc_ififo_ifc_acc3_acc_ptag_to_agents\,
                                               \acc_ififo_ifc_ff_acc_wr_to_agents\ => \acc_ififo_ifc_acc3_acc_wr_to_agents\,
                                               \acc_ififo_ifc_ff_fp_full_to_agents\ => \acc_ififo_ifc_acc3_fp_full_to_agents\,
                                               \acc_ififo_ifc_ff_fpi_credit_data\ => \acc_ififo_ifc_acc3_fpi_credit_data\,
                                               \acc_ififo_ifc_ff_fpi_credit_req\ => \acc_ififo_ifc_acc3_fpi_credit_req\,
                                               \ififo_ag_ifc_ff_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                               \ififo_ag_ifc_ff_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                               \ififo_ag_ifc_ff_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
  \I_AGT2_FP0_IN\ : \fifo_port32_in\ port map (\acc_ififo_ifc_ff_acc_credit_ack\ => \acc_ififo_ifc_acc2_acc_credit_ack\,
                                               \acc_ififo_ifc_ff_acc_credit_enable\ => \acc_ififo_ifc_acc2_acc_credit_enable\,
                                               \acc_ififo_ifc_ff_acc_data_to_agents\ => \acc_ififo_ifc_acc2_acc_data_to_agents\,
                                               \acc_ififo_ifc_ff_acc_ptag_to_agents\ => \acc_ififo_ifc_acc2_acc_ptag_to_agents\,
                                               \acc_ififo_ifc_ff_acc_wr_to_agents\ => \acc_ififo_ifc_acc2_acc_wr_to_agents\,
                                               \acc_ififo_ifc_ff_fp_full_to_agents\ => \acc_ififo_ifc_acc2_fp_full_to_agents\,
                                               \acc_ififo_ifc_ff_fpi_credit_data\ => \acc_ififo_ifc_acc2_fpi_credit_data\,
                                               \acc_ififo_ifc_ff_fpi_credit_req\ => \acc_ififo_ifc_acc2_fpi_credit_req\,
                                               \ififo_ag_ifc_ff_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                               \ififo_ag_ifc_ff_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                               \ififo_ag_ifc_ff_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
  \I_AGT1_FP0_OUT\ : \fifo_port32_out\ port map (\ag_ofifo_ifc_ff_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                                 \ofifo_acc_ifc_ff_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\);
  \I_AGENT_0\ : \loopback32_agent\ port map (\ag_accreg_ifc_ag_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                                             \ag_accreg_ifc_ag_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                                             \ag_accreg_ifc_ag_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                                             \ag_accreg_ifc_ag_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                                             \ag_accreg_ifc_ag_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                                             \ag_accreg_ifc_ag_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                             \ififo_ag_ifc_ag_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                             \ififo_ag_ifc_ag_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                             \ififo_ag_ifc_ag_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
  \agent_long_reach_\ : \agent_long_reach\;
  \I_AGT0_FP0_OUT\ : \fifo_port32_out\ port map (\ag_ofifo_ifc_ff_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                                 \ofifo_acc_ifc_ff_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\);
  \I_AGT2_FP0_OUT\ : \fifo_port32_out\ port map (\ag_ofifo_ifc_ff_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                                 \ofifo_acc_ifc_ff_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\);
  \I_AGT3_FP0_OUT\ : \fifo_port32_out\ port map (\ag_ofifo_ifc_ff_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                                 \ag_ofifo_ifc_ff_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                                 \ofifo_acc_ifc_ff_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                                                 \ofifo_acc_ifc_ff_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\);
  \I_AGENT_2\ : \loopback32_agent\ port map (\ag_accreg_ifc_ag_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                                             \ag_accreg_ifc_ag_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                                             \ag_accreg_ifc_ag_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                                             \ag_accreg_ifc_ag_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                                             \ag_accreg_ifc_ag_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                                             \ag_accreg_ifc_ag_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                             \ififo_ag_ifc_ag_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                             \ififo_ag_ifc_ag_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                             \ififo_ag_ifc_ag_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
  \acc_\ : \acc\ port map (\acc_ififo_ifc_acc0_acc_credit_ack\ => \acc_ififo_ifc_acc0_acc_credit_ack\,
                           \acc_ififo_ifc_acc0_acc_credit_enable\ => \acc_ififo_ifc_acc0_acc_credit_enable\,
                           \acc_ififo_ifc_acc0_acc_data_to_agents\ => \acc_ififo_ifc_acc0_acc_data_to_agents\,
                           \acc_ififo_ifc_acc0_acc_ptag_to_agents\ => \acc_ififo_ifc_acc0_acc_ptag_to_agents\,
                           \acc_ififo_ifc_acc0_acc_wr_to_agents\ => \acc_ififo_ifc_acc0_acc_wr_to_agents\,
                           \acc_ififo_ifc_acc0_fp_full_to_agents\ => \acc_ififo_ifc_acc0_fp_full_to_agents\,
                           \acc_ififo_ifc_acc0_fpi_credit_data\ => \acc_ififo_ifc_acc0_fpi_credit_data\,
                           \acc_ififo_ifc_acc0_fpi_credit_req\ => \acc_ififo_ifc_acc0_fpi_credit_req\,
                           \acc_ififo_ifc_acc1_acc_credit_ack\ => \acc_ififo_ifc_acc1_acc_credit_ack\,
                           \acc_ififo_ifc_acc1_acc_credit_enable\ => \acc_ififo_ifc_acc1_acc_credit_enable\,
                           \acc_ififo_ifc_acc1_acc_data_to_agents\ => \acc_ififo_ifc_acc1_acc_data_to_agents\,
                           \acc_ififo_ifc_acc1_acc_ptag_to_agents\ => \acc_ififo_ifc_acc1_acc_ptag_to_agents\,
                           \acc_ififo_ifc_acc1_acc_wr_to_agents\ => \acc_ififo_ifc_acc1_acc_wr_to_agents\,
                           \acc_ififo_ifc_acc1_fp_full_to_agents\ => \acc_ififo_ifc_acc1_fp_full_to_agents\,
                           \acc_ififo_ifc_acc1_fpi_credit_data\ => \acc_ififo_ifc_acc1_fpi_credit_data\,
                           \acc_ififo_ifc_acc1_fpi_credit_req\ => \acc_ififo_ifc_acc1_fpi_credit_req\,
                           \acc_ififo_ifc_acc2_acc_credit_ack\ => \acc_ififo_ifc_acc2_acc_credit_ack\,
                           \acc_ififo_ifc_acc2_acc_credit_enable\ => \acc_ififo_ifc_acc2_acc_credit_enable\,
                           \acc_ififo_ifc_acc2_acc_data_to_agents\ => \acc_ififo_ifc_acc2_acc_data_to_agents\,
                           \acc_ififo_ifc_acc2_acc_ptag_to_agents\ => \acc_ififo_ifc_acc2_acc_ptag_to_agents\,
                           \acc_ififo_ifc_acc2_acc_wr_to_agents\ => \acc_ififo_ifc_acc2_acc_wr_to_agents\,
                           \acc_ififo_ifc_acc2_fp_full_to_agents\ => \acc_ififo_ifc_acc2_fp_full_to_agents\,
                           \acc_ififo_ifc_acc2_fpi_credit_data\ => \acc_ififo_ifc_acc2_fpi_credit_data\,
                           \acc_ififo_ifc_acc2_fpi_credit_req\ => \acc_ififo_ifc_acc2_fpi_credit_req\,
                           \acc_ififo_ifc_acc3_acc_credit_ack\ => \acc_ififo_ifc_acc3_acc_credit_ack\,
                           \acc_ififo_ifc_acc3_acc_credit_enable\ => \acc_ififo_ifc_acc3_acc_credit_enable\,
                           \acc_ififo_ifc_acc3_acc_data_to_agents\ => \acc_ififo_ifc_acc3_acc_data_to_agents\,
                           \acc_ififo_ifc_acc3_acc_ptag_to_agents\ => \acc_ififo_ifc_acc3_acc_ptag_to_agents\,
                           \acc_ififo_ifc_acc3_acc_wr_to_agents\ => \acc_ififo_ifc_acc3_acc_wr_to_agents\,
                           \acc_ififo_ifc_acc3_fp_full_to_agents\ => \acc_ififo_ifc_acc3_fp_full_to_agents\,
                           \acc_ififo_ifc_acc3_fpi_credit_data\ => \acc_ififo_ifc_acc3_fpi_credit_data\,
                           \acc_ififo_ifc_acc3_fpi_credit_req\ => \acc_ififo_ifc_acc3_fpi_credit_req\,
                           \ag_accreg_ifc_acc0_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                           \ag_accreg_ifc_acc0_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                           \ag_accreg_ifc_acc0_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                           \ag_accreg_ifc_acc0_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                           \ag_accreg_ifc_acc0_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                           \ag_accreg_ifc_acc0_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                           \ag_accreg_ifc_acc1_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                           \ag_accreg_ifc_acc1_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                           \ag_accreg_ifc_acc1_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                           \ag_accreg_ifc_acc1_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                           \ag_accreg_ifc_acc1_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                           \ag_accreg_ifc_acc1_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                           \ag_accreg_ifc_acc2_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                           \ag_accreg_ifc_acc2_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                           \ag_accreg_ifc_acc2_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                           \ag_accreg_ifc_acc2_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                           \ag_accreg_ifc_acc2_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                           \ag_accreg_ifc_acc2_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                           \ag_accreg_ifc_acc3_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                           \ag_accreg_ifc_acc3_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                           \ag_accreg_ifc_acc3_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                           \ag_accreg_ifc_acc3_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                           \ag_accreg_ifc_acc3_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                           \ag_accreg_ifc_acc3_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                           \from_csw_ifc_acc_cluster_data_to_agents\ => \from_csw_ifc_ag_cluster_data_to_agents\,
                           \from_csw_ifc_acc_cluster_dev_id_to_agents\ => \from_csw_ifc_ag_cluster_dev_id_to_agents\,
                           \from_csw_ifc_acc_cluster_ptag_to_agents\ => \from_csw_ifc_ag_cluster_ptag_to_agents\,
                           \from_csw_ifc_acc_cluster_wr_to_agents\ => \from_csw_ifc_ag_cluster_wr_to_agents\,
                           \ofifo_acc_ifc_acc0_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                           \ofifo_acc_ifc_acc0_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                           \ofifo_acc_ifc_acc0_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                           \ofifo_acc_ifc_acc0_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\,
                           \ofifo_acc_ifc_acc1_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                           \ofifo_acc_ifc_acc1_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                           \ofifo_acc_ifc_acc1_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                           \ofifo_acc_ifc_acc1_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\,
                           \ofifo_acc_ifc_acc2_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                           \ofifo_acc_ifc_acc2_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                           \ofifo_acc_ifc_acc2_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                           \ofifo_acc_ifc_acc2_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\,
                           \ofifo_acc_ifc_acc3_acc_rd_from_agents\ => \ofifo_acc_ifc_ff_acc_rd_from_agents\,
                           \ofifo_acc_ifc_acc3_fpo_data_from_agents\ => \ofifo_acc_ifc_ff_fpo_data_from_agents\,
                           \ofifo_acc_ifc_acc3_fpo_empty_from_agents\ => \ofifo_acc_ifc_ff_fpo_empty_from_agents\,
                           \ofifo_acc_ifc_acc3_fpo_ptag_from_agents\ => \ofifo_acc_ifc_ff_fpo_ptag_from_agents\,
                           \to_csw_ifc_acc_cluster_data_from_agents\ => \to_csw_ifc_ag_cluster_data_from_agents\,
                           \to_csw_ifc_acc_cluster_dest_from_agents\ => \to_csw_ifc_ag_cluster_dest_from_agents\,
                           \to_csw_ifc_acc_cluster_ptag_from_agents\ => \to_csw_ifc_ag_cluster_ptag_from_agents\,
                           \to_csw_ifc_acc_cluster_ready_to_agents\ => \to_csw_ifc_ag_cluster_ready_to_agents\,
                           \to_csw_ifc_acc_cluster_wr_from_agents\ => \to_csw_ifc_ag_cluster_wr_from_agents\);
  \dp_fp32_gasket_\ : \dp_fp32_gasket\;
  \I_AGENT_3\ : \loopback32_agent\ port map (\ag_accreg_ifc_ag_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                                             \ag_accreg_ifc_ag_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                                             \ag_accreg_ifc_ag_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                                             \ag_accreg_ifc_ag_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                                             \ag_accreg_ifc_ag_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                                             \ag_accreg_ifc_ag_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                             \ififo_ag_ifc_ag_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                             \ififo_ag_ifc_ag_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                             \ififo_ag_ifc_ag_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
  \I_AGT1_FP0_IN\ : \fifo_port32_in\ port map (\acc_ififo_ifc_ff_acc_credit_ack\ => \acc_ififo_ifc_acc1_acc_credit_ack\,
                                               \acc_ififo_ifc_ff_acc_credit_enable\ => \acc_ififo_ifc_acc1_acc_credit_enable\,
                                               \acc_ififo_ifc_ff_acc_data_to_agents\ => \acc_ififo_ifc_acc1_acc_data_to_agents\,
                                               \acc_ififo_ifc_ff_acc_ptag_to_agents\ => \acc_ififo_ifc_acc1_acc_ptag_to_agents\,
                                               \acc_ififo_ifc_ff_acc_wr_to_agents\ => \acc_ififo_ifc_acc1_acc_wr_to_agents\,
                                               \acc_ififo_ifc_ff_fp_full_to_agents\ => \acc_ififo_ifc_acc1_fp_full_to_agents\,
                                               \acc_ififo_ifc_ff_fpi_credit_data\ => \acc_ififo_ifc_acc1_fpi_credit_data\,
                                               \acc_ififo_ifc_ff_fpi_credit_req\ => \acc_ififo_ifc_acc1_fpi_credit_req\,
                                               \ififo_ag_ifc_ff_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                               \ififo_ag_ifc_ff_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                               \ififo_ag_ifc_ff_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
  \I_AGENT_1\ : \loopback32_agent\ port map (\ag_accreg_ifc_ag_agent_ack\ => \ag_accreg_ifc_ag_agent_ack\,
                                             \ag_accreg_ifc_ag_agent_address\ => \ag_accreg_ifc_ag_agent_address\,
                                             \ag_accreg_ifc_ag_agent_rd_data\ => \ag_accreg_ifc_ag_agent_rd_data\,
                                             \ag_accreg_ifc_ag_agent_rd_req\ => \ag_accreg_ifc_ag_agent_rd_req\,
                                             \ag_accreg_ifc_ag_agent_wr_data\ => \ag_accreg_ifc_ag_agent_wr_data\,
                                             \ag_accreg_ifc_ag_agent_wr_req\ => \ag_accreg_ifc_ag_agent_wr_req\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_data\ => \ag_ofifo_ifc_ag_fp_outfifo_data\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full\ => \ag_ofifo_ifc_ag_fp_outfifo_full\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_full_count\ => \ag_ofifo_ifc_ag_fp_outfifo_full_count\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\ => \ag_ofifo_ifc_ag_fp_outfifo_pkt_tag\,
                                             \ag_ofifo_ifc_ag_fp_outfifo_write\ => \ag_ofifo_ifc_ag_fp_outfifo_write\,
                                             \ififo_ag_ifc_ag_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                             \ififo_ag_ifc_ag_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                             \ififo_ag_ifc_ag_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                             \ififo_ag_ifc_ag_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
  \I_AGT0_FP0_IN\ : \fifo_port32_in\ port map (\acc_ififo_ifc_ff_acc_credit_ack\ => \acc_ififo_ifc_acc0_acc_credit_ack\,
                                               \acc_ififo_ifc_ff_acc_credit_enable\ => \acc_ififo_ifc_acc0_acc_credit_enable\,
                                               \acc_ififo_ifc_ff_acc_data_to_agents\ => \acc_ififo_ifc_acc0_acc_data_to_agents\,
                                               \acc_ififo_ifc_ff_acc_ptag_to_agents\ => \acc_ififo_ifc_acc0_acc_ptag_to_agents\,
                                               \acc_ififo_ifc_ff_acc_wr_to_agents\ => \acc_ififo_ifc_acc0_acc_wr_to_agents\,
                                               \acc_ififo_ifc_ff_fp_full_to_agents\ => \acc_ififo_ifc_acc0_fp_full_to_agents\,
                                               \acc_ififo_ifc_ff_fpi_credit_data\ => \acc_ififo_ifc_acc0_fpi_credit_data\,
                                               \acc_ififo_ifc_ff_fpi_credit_req\ => \acc_ififo_ifc_acc0_fpi_credit_req\,
                                               \ififo_ag_ifc_ff_fp_infifo_data\ => \ififo_ag_ifc_ff_fp_infifo_data\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty\ => \ififo_ag_ifc_ff_fp_infifo_empty\,
                                               \ififo_ag_ifc_ff_fp_infifo_empty_count\ => \ififo_ag_ifc_ff_fp_infifo_empty_count\,
                                               \ififo_ag_ifc_ff_fp_infifo_pkt_tag\ => \ififo_ag_ifc_ff_fp_infifo_pkt_tag\,
                                               \ififo_ag_ifc_ff_fp_infifo_rd\ => \ififo_ag_ifc_ff_fp_infifo_rd\);
end architecture;

