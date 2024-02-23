-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./agent_cluster2_cslc_generated/code/vhdl/fifo_port32_in.vhd
-- FILE GENERATED ON : Thu Aug 14 15:06:21 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \fifo_port32_in\ is
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
begin
end entity;

architecture \fifo_port32_in_logic\ of \fifo_port32_in\ is
begin
end architecture;

