-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./top_cslc_generated/code/vhdl/u_bc.vhd
-- FILE GENERATED ON : Wed Mar 11 20:22:38 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_bc\ is
  port(\ck\ : in csl_bit;
       \reset\ : in csl_bit;
       \p_bc_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \p_bc_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ar_p_a_out_p_b_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
       \ar_p_c_out_p_d_in\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
begin
end entity;

architecture \u_bc_logic\ of \u_bc\ is
  signal \ar_p_b_out_p_c_in\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal aux_sig0 : csl_bit_vector(10#8# - 10#1# downto 10#0#);

  component \u_b\ is
    port(\ck\ : in csl_bit;
         \reset\ : in csl_bit;
         \p_b_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \p_b_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;

  component \u_c\ is
    port(\ck\ : in csl_bit;
         \reset\ : in csl_bit;
         \p_c_in\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \p_c_out\ : out csl_bit_vector(10#8# - 10#1# downto 10#0#));
  end component;
begin
  \ar_p_c_out_p_d_in\ <= aux_sig0;
  \b\ : \u_b\ port map (\ck\ => \ck\,
                        \p_b_in\ => \ar_p_a_out_p_b_in\,
                        \p_b_out\ => \ar_p_b_out_p_c_in\,
                        \reset\ => \reset\);
  \c\ : \u_c\ port map (\ck\ => \ck\,
                        \p_c_in\ => \ar_p_b_out_p_c_in\,
                        \p_c_out\ => aux_sig0,
                        \reset\ => \reset\);
end architecture;

