-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_mbist_cslc_generated/code/vhdl/u_mbist.vhd
-- FILE GENERATED ON : Mon Dec 22 15:48:15 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_mbist\ is
  port(\ifc_op0_op1\ : in csl_bit_vector(10#15# downto 10#0#);
       \ifc_op0_op2\ : in csl_bit_vector(10#15# downto 10#0#);
       \ifc_out0_o\ : out csl_bit_vector(10#15# downto 10#0#));
begin
end entity;

architecture \u_mbist_logic\ of \u_mbist\ is
  signal \sham\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \compres\ : csl_bit;
  signal \sel\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \status\ : csl_bit_vector(10#8# - 10#1# downto 10#0#);
  signal \op\ : csl_bit;
  signal \r\ : csl_bit;
  signal \wr\ : csl_bit;
  signal \rd\ : csl_bit;
  signal \no\ : csl_bit;
  signal \in\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \rst\ : csl_bit;
  signal \clk\ : csl_bit;
  signal \en\ : csl_bit;
  signal \data\ : csl_bit_vector(10#16# - 10#1# downto 10#0#);
  signal \clr\ : csl_bit;
  signal \addr\ : csl_bit_vector(10#4# - 10#1# downto 10#0#);
  signal \valid\ : csl_bit;
  signal aux_sig0 : csl_bit_vector(10#15# downto 10#0#);

  component \r_pc\ is
    generic(\MIN_VALUE\ : csl_integer);
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#));
  end component;

  component \m_im\ is
  end component;

  component \u_mux41\ is
    port(\in0\ : in csl_bit_vector(10#15# downto 10#0#);
         \in1\ : in csl_bit_vector(10#15# downto 10#0#);
         \in2\ : in csl_bit_vector(10#15# downto 10#0#);
         \in3\ : in csl_bit_vector(10#15# downto 10#0#);
         \sel\ : in csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \ifc_out0_o\ : out csl_bit_vector(10#15# downto 10#0#));
  end component;

  component \rf\ is
    port(\reset\ : in csl_bit;
         \clear\ : in csl_bit;
         \clock\ : in csl_bit;
         \wr_addr\ : in csl_bit_vector(log2(10#16#) - 10#1# downto 10#0#);
         \rd_addr0\ : in csl_bit_vector(log2(10#16#) - 10#1# downto 10#0#);
         \rd_addr1\ : in csl_bit_vector(log2(10#16#) - 10#1# downto 10#0#);
         \data_in\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \data_out0\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \data_out1\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \wr_en\ : in csl_bit;
         \rd_en0\ : in csl_bit;
         \rd_en1\ : in csl_bit;
         \valid\ : out csl_bit);
  end component;

  component \u_alu_sh_cmp\ is
    port(\ifc_op0_op1\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_op0_op2\ : in csl_bit_vector(10#15# downto 10#0#);
         \ifc_out0_o\ : out csl_bit_vector(10#15# downto 10#0#);
         \sel_op_p_sel\ : in csl_bit_vector(10#3# downto 10#0#);
         \sham\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \compres\ : out csl_bit);
  end component;

  component \u_control\ is
    port(\s_status\ : in csl_bit_vector(10#8# - 10#1# downto 10#0#);
         \op_instr\ : out csl_bit;
         \r_instr\ : out csl_bit;
         \wr_haddr\ : out csl_bit;
         \wr_crtaddr\ : out csl_bit;
         \wr_ram\ : out csl_bit;
         \rd_ram\ : out csl_bit;
         \rd_im\ : out csl_bit;
         \rd_rom\ : out csl_bit;
         \incr\ : out csl_bit;
         \decr\ : out csl_bit;
         \wr_dm\ : out csl_bit;
         \rd_dm\ : out csl_bit);
  end component;
begin
  \ifc_out0_o\ <= aux_sig0;
  -- In file 'TO BE IMPLEMENTED':225 instance name must difer from the instantiated obejct name.
  \im\ : \m_im\;
  \mux_mem\ : \u_mux41\ port map (\ifc_out0_o\ => aux_sig0,
                                  \in0\ => \in\,
                                  \in1\ => \in\,
                                  \in2\ => \in\,
                                  \in3\ => \in\,
                                  \sel\ => \sel\);
  -- In file 'TO BE IMPLEMENTED':243 instance name must difer from the instantiated obejct name.
  \alusc\ : \u_alu_sh_cmp\ port map (\compres\ => \compres\,
                                     \ifc_op0_op1\ => \ifc_op0_op1\,
                                     \ifc_op0_op2\ => \ifc_op0_op2\,
                                     \ifc_out0_o\ => aux_sig0,
                                     \sel_op_p_sel\ => \sel\,
                                     \sham\ => \sham\);
  \control\ : \u_control\ port map (\decr\ => \no\,
                                    \incr\ => \no\,
                                    \op_instr\ => \op\,
                                    \r_instr\ => \r\,
                                    \rd_dm\ => \rd\,
                                    \rd_im\ => \rd\,
                                    \rd_ram\ => \rd\,
                                    \rd_rom\ => \rd\,
                                    \s_status\ => \status\,
                                    \wr_crtaddr\ => \wr\,
                                    \wr_dm\ => \wr\,
                                    \wr_haddr\ => \wr\,
                                    \wr_ram\ => \wr\);
end architecture;

