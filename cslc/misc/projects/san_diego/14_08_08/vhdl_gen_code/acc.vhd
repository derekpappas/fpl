-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./agent_cluster2_cslc_generated/code/vhdl/acc.vhd
-- FILE GENERATED ON : Thu Aug 14 15:06:21 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \acc\ is
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
begin
end entity;

architecture \acc_logic\ of \acc\ is
begin
end architecture;

