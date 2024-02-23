-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_mbist_cslc_generated/code/vhdl/u_alu_sh_cmp.vhd
-- FILE GENERATED ON : Mon Dec 22 15:48:15 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_alu_sh_cmp\ is
  port(\ifc_op0_op1\ : in csl_bit_vector(10#15# downto 10#0#);
       \ifc_op0_op2\ : in csl_bit_vector(10#15# downto 10#0#);
       \ifc_out0_o\ : out csl_bit_vector(10#15# downto 10#0#);
       \sel_op_p_sel\ : in csl_bit_vector(10#3# downto 10#0#);
       \sham\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
       \compres\ : out csl_bit);
begin
end entity;

architecture \u_alu_sh_cmp_logic\ of \u_alu_sh_cmp\ is
  signal \cin\ : csl_bit;
  signal \cout\ : csl_bit;
  signal \p_tomux40\ : csl_bit_vector(10#15# downto 10#0#);
  signal \p_tomux41\ : csl_bit_vector(10#15# downto 10#0#);
  signal \p_tomux42\ : csl_bit_vector(10#15# downto 10#0#);
  signal \p_tomux43\ : csl_bit_vector(10#15# downto 10#0#);
  signal \tomux40_p_op1\ : csl_bit_vector(10#15# downto 10#0#);
  signal \tomux40_p_op2\ : csl_bit_vector(10#15# downto 10#0#);
  signal \tomux41_p_op1\ : csl_bit_vector(10#15# downto 10#0#);
  signal \tomux41_p_op2\ : csl_bit_vector(10#15# downto 10#0#);
  signal \tomux42_p_o\ : csl_bit_vector(10#15# downto 10#0#);
  signal aux_sig0 : csl_bit;
  signal aux_sig1 : csl_bit_vector(10#15# downto 10#0#);

  component \u_arith\ is
    port(\ifc_op0_op1\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_op0_op2\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_sel0_sel\ : in csl_bit_vector(10#3# downto 10#0#);
         \ifc_out0_o\ : out csl_bit_vector(10#15# downto 10#0#);
         \cin\ : in csl_bit;
         \cout\ : out csl_bit);
  end component;

  component \u_logic\ is
    port(\ifc_op0_op1\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_op0_op2\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_sel0_sel\ : in csl_bit_vector(10#3# downto 10#0#);
         \ifc_out0_o\ : out csl_bit_vector(10#15# downto 10#0#));
  end component;

  component \u_cmp\ is
    port(\ifc_op_cmp_op1\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_op_cmp_op2\ : in csl_bit_vector(10#15# downto 10#0#);
         \res\ : out csl_bit);
  end component;

  component \u_sh\ is
    port(\ifc_din_o\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_dout_o\ : out csl_bit_vector(10#15# downto 10#0#);
         \p_sham\ : in csl_bit_vector(10#15# downto 10#0#));
  end component;

  component \u_mux41\ is
    port(\in0\ : in csl_bit_vector(10#15# downto 10#0#);
         \in1\ : in csl_bit_vector(10#15# downto 10#0#);
         \in2\ : in csl_bit_vector(10#15# downto 10#0#);
         \in3\ : in csl_bit_vector(10#15# downto 10#0#);
         \sel\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ifc_out0_o\ : out csl_bit_vector(10#15# downto 10#0#));
  end component;
begin
  \ifc_out0_o\ <= aux_sig1;
  \compres\ <= aux_sig0;
  \u_arith0\ : \u_arith\ port map (\cin\ => \cin\,
                                   \cout\ => \cout\,
                                   \ifc_op0_op1\ => \ifc_op0_op1\,
                                   \ifc_op0_op2\ => \ifc_op0_op2\);
  \u_logic0\ : \u_logic\ port map (\ifc_op0_op1\ => \ifc_op0_op1\,
                                   \ifc_op0_op2\ => \ifc_op0_op2\);
  \u_cmp0\ : \u_cmp\ port map (\ifc_op_cmp_op1\ => \ifc_op0_op1\,
                               \ifc_op_cmp_op2\ => \ifc_op0_op2\,
                               \res\ => aux_sig0);
  \u_sh0\ : \u_sh\ port map (\p_sham\ => \sham\);
  \u_mux410\ : \u_mux41\ port map (\ifc_out0_o\ => aux_sig1,
                                   \in0\ => \p_tomux40\,
                                   \in1\ => \p_tomux41\,
                                   \in2\ => \p_tomux42\,
                                   \in3\ => \p_tomux43\,
                                   \sel\ => \sel_op_p_sel\);
end architecture;

