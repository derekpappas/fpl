-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./agent_cluster2_cslc_generated/code/vhdl/loopback32_agent.vhd
-- FILE GENERATED ON : Thu Aug 14 15:06:21 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \loopback32_agent\ is
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
begin
end entity;

architecture \loopback32_agent_logic\ of \loopback32_agent\ is
begin
end architecture;

