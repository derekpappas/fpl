-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./chip_cslc_generated/code/vhdl/chip.vhd
-- FILE GENERATED ON : Wed Nov 18 19:49:18 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \chip\ is
  port(\p_clock\ : in csl_bit;
       \p_reset\ : in csl_bit;
       \p_enable\ : in csl_bit;
       \p_data_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \p_data_out\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \p_stall_chip\ : in csl_bit;
       \ifc_pclm_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ifc_pclm_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ifc_lmid_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ifc_lmid_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ifc_idrf_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ifc_idrf_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ifc_rfalu_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
       \ifc_rfalu_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
begin
end entity;

architecture \chip_logic\ of \chip\ is
  signal \sgn_clk\ : csl_bit;
  signal \sgn_reset\ : csl_bit;
  signal \sgn_stall\ : csl_bit;
  signal aux0 : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal aux1 : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal aux2 : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal aux3 : csl_bit_vector(10#32# - 10#1# downto 10#0#);
  signal aux4 : csl_bit_vector(10#32# - 10#1# downto 10#0#);

  component \u_pc\ is
    port(\ifc_pc_p_clk\ : in csl_bit;
         \ifc_pc_p_rst\ : in csl_bit;
         \ifc_pc_p_stall\ : in csl_bit;
         \ifc_unit_pc_r_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_pc_r_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \u_im\ is
    port(\ifc_im_p_clk\ : in csl_bit;
         \ifc_im_p_rst\ : in csl_bit;
         \ifc_im_p_stall\ : in csl_bit;
         \ifc_unit_im_l_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_im_l_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_im_r_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_im_r_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \u_id\ is
    port(\ifc_id_p_clk\ : in csl_bit;
         \ifc_id_p_rst\ : in csl_bit;
         \ifc_id_p_stall\ : in csl_bit;
         \ifc_unit_id_l_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_id_l_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_id_r_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_id_r_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \u_rf\ is
    port(\ifc_rf_p_clk\ : in csl_bit;
         \ifc_rf_p_rst\ : in csl_bit;
         \ifc_rf_p_stall\ : in csl_bit;
         \ifc_unit_rf_l_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_rf_l_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_rf_r_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_rf_r_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \u_alu\ is
    port(\ifc_alu_p_clk\ : in csl_bit;
         \ifc_alu_p_rst\ : in csl_bit;
         \ifc_alu_p_stall\ : in csl_bit;
         \ifc_unit_alu_l_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_alu_l_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_alu_r_p_unitOut\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \ifc_unit_alu_r_p_unitIn\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \pc_reg\ is
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \reg_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \rf_reg\ is
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \reg_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \alu_reg\ is
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \reg_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;

  component \r_shr\ is
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(10#32# - 10#1# downto 10#0#);
         \reg_in\ : in csl_bit_vector(10#32# - 10#1# downto 10#0#));
  end component;
begin
  \p_data_out\ <= aux1;
  \ifc_pclm_p_unitOut\ <= aux0;
  \ifc_lmid_p_unitOut\ <= aux2;
  \ifc_idrf_p_unitOut\ <= aux3;
  \ifc_rfalu_p_unitOut\ <= aux4;
  \pc\ : \u_pc\ port map (\ifc_pc_p_clk\ => \sgn_clk\,
                          \ifc_pc_p_rst\ => \sgn_reset\,
                          \ifc_pc_p_stall\ => \sgn_stall\,
                          \ifc_unit_pc_r_p_unitIn\ => \ifc_pclm_p_unitIn\,
                          \ifc_unit_pc_r_p_unitOut\ => aux0);
  \im\ : \u_im\ port map (\ifc_im_p_clk\ => \sgn_clk\,
                          \ifc_im_p_rst\ => \sgn_reset\,
                          \ifc_im_p_stall\ => \sgn_stall\,
                          \ifc_unit_im_l_p_unitIn\ => \p_data_in\,
                          \ifc_unit_im_l_p_unitOut\ => aux1,
                          \ifc_unit_im_r_p_unitIn\ => \ifc_lmid_p_unitIn\,
                          \ifc_unit_im_r_p_unitOut\ => aux2);
  \id\ : \u_id\ port map (\ifc_id_p_clk\ => \sgn_clk\,
                          \ifc_id_p_rst\ => \sgn_reset\,
                          \ifc_id_p_stall\ => \sgn_stall\,
                          \ifc_unit_id_l_p_unitIn\ => \p_data_in\,
                          \ifc_unit_id_l_p_unitOut\ => aux1,
                          \ifc_unit_id_r_p_unitIn\ => \ifc_idrf_p_unitIn\,
                          \ifc_unit_id_r_p_unitOut\ => aux3);
  \rf\ : \u_rf\ port map (\ifc_rf_p_clk\ => \sgn_clk\,
                          \ifc_rf_p_rst\ => \sgn_reset\,
                          \ifc_rf_p_stall\ => \sgn_stall\,
                          \ifc_unit_rf_l_p_unitIn\ => \p_data_in\,
                          \ifc_unit_rf_l_p_unitOut\ => aux1,
                          \ifc_unit_rf_r_p_unitIn\ => \ifc_rfalu_p_unitIn\,
                          \ifc_unit_rf_r_p_unitOut\ => aux4);
  \alu\ : \u_alu\ port map (\ifc_alu_p_clk\ => \sgn_clk\,
                            \ifc_alu_p_rst\ => \sgn_reset\,
                            \ifc_alu_p_stall\ => \sgn_stall\,
                            \ifc_unit_alu_l_p_unitIn\ => \p_data_in\,
                            \ifc_unit_alu_l_p_unitOut\ => aux1,
                            \ifc_unit_alu_r_p_unitIn\ => \p_data_in\,
                            \ifc_unit_alu_r_p_unitOut\ => aux1);
  -- In file 'TO BE IMPLEMENTED':557 instance name must difer from the instantiated obejct name.
  -- In file 'TO BE IMPLEMENTED':558 instance name must difer from the instantiated obejct name.
  -- In file 'TO BE IMPLEMENTED':559 instance name must difer from the instantiated obejct name.
  -- In file 'TO BE IMPLEMENTED':560 instance name must difer from the instantiated obejct name.

  process (\p_stall_chip\) is
  begin
    \sgn_stall\ <= \p_stall_chip\;
  end process;
end architecture;

