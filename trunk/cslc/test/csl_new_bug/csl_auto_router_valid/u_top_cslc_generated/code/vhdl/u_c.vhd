-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_top_cslc_generated/code/vhdl/u_c.vhd
-- FILE GENERATED ON : Wed Mar 11 20:42:30 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_c\ is
  port(\ar_p_t_in_p_a_in\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
       \ar_p_t_out1_p_a_out\ : out csl_bit_vector(10#1# - 10#1# downto 10#0#));
begin
end entity;

architecture \u_c_logic\ of \u_c\ is
  signal aux_sig0 : csl_bit_vector(10#1# - 10#1# downto 10#0#);

  component \u_a\ is
    port(\p_a_in\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#);
         \p_a_out\ : out csl_bit);
  end component;

  component \u_b\ is
    port(\p_b_in\ : in csl_bit_vector(10#2# - 10#1# downto 10#0#));
  end component;
begin
  \ar_p_t_out1_p_a_out\ <= aux_sig0;
  \a\ : \u_a\ port map (\p_a_in\ => \ar_p_t_in_p_a_in\,
                        \p_a_out\ => aux_sig0);
  \b\ : \u_b\ port map (\p_b_in\ => \ar_p_t_in_p_a_in\);
end architecture;

