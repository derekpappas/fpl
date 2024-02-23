-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/d.vhd
-- FILE GENERATED ON : Wed Mar 11 20:17:47 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \d\ is
  port(\ar_clk_ck\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \ar_rst_reset\ : in csl_bit_vector(10#1# - 10#1# downto 10#0#);
       \ar_p_out1_p_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ar_p_in1_p_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc_top_ifc_p1_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc_top_ifc_p2_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ifc_top_p_sg\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#));
begin
end entity;

architecture \d_logic\ of \d\ is
  signal aux_sig0 : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig1 : csl_bit_vector(10#8# - 10#1# downto 10#0#);

  component \c\ is
    port(\ck\ : in csl_bit;
         \reset\ : in csl_bit;
         \p_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \p_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc1_ifc_p1_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc1_ifc_p2_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \ifc1_p_sg\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;
begin
  \ar_p_out1_p_out\ <= aux_sig1;
  \ifc_top_ifc_p2_out\ <= aux_sig0;
  \c0\ : \c\ port map (\ck\ => \ar_clk_ck\,
                       \ifc1_ifc_p1_in\ => \ifc_top_ifc_p1_in\,
                       \ifc1_ifc_p2_out\ => aux_sig0,
                       \ifc1_p_sg\ => \ifc_top_p_sg\,
                       \p_in\ => \ar_p_in1_p_in\,
                       \p_out\ => aux_sig1,
                       \reset\ => \ar_rst_reset\);
end architecture;

