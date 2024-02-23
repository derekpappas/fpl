-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_top_cslc_generated/code/vhdl/u_top.vhd
-- FILE GENERATED ON : Wed Mar 11 20:42:30 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_top\ is
  port(\p_t_in\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \p_t_out0\ : out csl_bit;
       \p_t_out1\ : out csl_bit);
begin
end entity;

architecture \u_top_logic\ of \u_top\ is
  signal aux_sig0 : csl_bit;
  signal aux_sig1 : csl_bit;

  component \u_c\ is
    port(\ar_p_t_in_p_a_in\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \ar_p_t_out1_p_a_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#));
  end component;

  component \u_d\ is
    port(\p_d_in1\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p_d_out\ : out csl_bit);
  end component;
begin
  \p_t_out0\ <= aux_sig1;
  \p_t_out1\ <= aux_sig0;
  \c\ : \u_c\ port map (\ar_p_t_in_p_a_in\ => \p_t_in\,
                        \ar_p_t_out1_p_a_out\ => aux_sig0);
  \d\ : \u_d\ port map (\p_d_in1\ => \p_t_in\,
                        \p_d_out\ => aux_sig1);
end architecture;

