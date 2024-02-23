-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./agent_cluster2_cslc_generated/code/vhdl/fifo_port32_out.vhd
-- FILE GENERATED ON : Thu Aug 14 15:06:21 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \fifo_port32_out\ is
  port(\ofifo_acc_ifc_ff_fpo_data_from_agents\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ofifo_acc_ifc_ff_fpo_ptag_from_agents\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ofifo_acc_ifc_ff_fpo_empty_from_agents\ : inout csl_bit;
       \ofifo_acc_ifc_ff_acc_rd_from_agents\ : in csl_bit;
       \ag_ofifo_ifc_ff_fp_outfifo_full\ : in csl_bit;
       \ag_ofifo_ifc_ff_fp_outfifo_full_count\ : in csl_bit_vector(10#5# - 10#1# downto 10#0#);
       \ag_ofifo_ifc_ff_fp_outfifo_data\ : inout csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ag_ofifo_ifc_ff_fp_outfifo_pkt_tag\ : inout csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \ag_ofifo_ifc_ff_fp_outfifo_write\ : inout csl_bit);
begin
end entity;

architecture \fifo_port32_out_logic\ of \fifo_port32_out\ is
begin
end architecture;

