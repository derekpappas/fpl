-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./u_mbist_cslc_generated/code/vhdl/u_mbist.vhd
-- FILE GENERATED ON : Tue Feb 17 20:24:21 2009
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \u_mbist\ is
  port(\p_clock\ : in csl_bit;
       \p_reset\ : in csl_bit;
       \p_enable\ : in csl_bit;
       \p_sram_addr\ : out csl_bit_vector(10#15# downto 10#0#));
begin
end entity;

architecture \u_mbist_logic\ of \u_mbist\ is
  signal \s_pc_im\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_opcode\ : csl_bit_vector(10#4# downto 10#0#);
  signal \s_reg_dest\ : csl_bit_vector(10#3# downto 10#0#);
  signal \s_op1\ : csl_bit_vector(10#3# downto 10#0#);
  signal \s_op2\ : csl_bit_vector(10#3# downto 10#0#);
  signal \s_cond\ : csl_bit;
  signal \s_branch_addr\ : csl_bit_vector(10#10# downto 10#0#);
  signal \s_branch_addr_e\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_br_sel\ : csl_bit;
  signal \s_shift_ammount\ : csl_bit_vector(10#3# downto 10#0#);
  signal \s_const_val\ : csl_bit_vector(10#7# downto 10#0#);
  signal \s_rom_addr\ : csl_bit_vector(10#7# downto 10#0#);
  signal \s_direction\ : csl_bit;
  signal \s_mux_shift\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_mem_mux\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_status\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_status_in\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_rf_mux\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_es_mux\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_alu_mux\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_haddr_cmp\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_c_f\ : csl_bit;
  signal \s_ir_im\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_rf_alu\ : csl_bit_vector(10#15# downto 10#0#);
  signal \s_controls\ : csl_bit_vector(10#14# - 10#1# downto 10#0#);
  signal \s_ld_caddr_sel\ : csl_bit;
  signal \s_caddr_en\ : csl_bit;
  signal \s_caddr_direction\ : csl_bit;
  signal aux_sig0 : csl_bit_vector(10#15# downto 10#0#);

  component \m_im\ is
  end component;

  component \r_pc\ is
    port(\p_clock\ : in csl_bit;
         \p_reset\ : in csl_bit;
         \p_enable\ : in csl_bit;
         \p_br_addr\ : in csl_bit_vector(10#15# downto 10#0#);
         \p_sel\ : in csl_bit;
         \p_addr_out\ : out csl_bit_vector(10#15# downto 10#0#));
  end component;

  component \u_ir\ is
    port(\p_clock\ : in csl_bit;
         \p_i\ : in csl_bit_vector(10#15# downto 10#0#);
         \p_opcode\ : out csl_bit_vector(10#4# downto 10#0#);
         \p_rdst\ : out csl_bit_vector(10#3# downto 10#0#);
         \p_op1\ : out csl_bit_vector(10#3# downto 10#0#);
         \p_op2\ : out csl_bit_vector(10#3# downto 10#0#);
         \p_c\ : out csl_bit;
         \p_braddr\ : out csl_bit_vector(10#11# - 10#1# downto 10#0#);
         \p_sha\ : out csl_bit_vector(10#4# - 10#1# downto 10#0#);
         \p_const8\ : out csl_bit_vector(10#7# downto 10#0#);
         \p_romaddr\ : out csl_bit_vector(10#7# downto 10#0#);
         \p_d\ : out csl_bit);
  end component;

  component \u_alu\ is
    port(\p_op1\ : in csl_bit_vector(10#15# downto 10#0#);
         \p_op2\ : in csl_bit_vector(10#15# downto 10#0#);
         \p_opsel\ : in csl_bit_vector(10#2# downto 10#0#);
         \p_cin\ : in csl_bit;
         \p_res\ : out csl_bit_vector(10#15# downto 10#0#);
         \p_cout\ : out csl_bit);
  end component;

  component \rf\ is
    port(\clock\ : in csl_bit;
         \reset\ : in csl_bit;
         \data_in\ : in csl_bit_vector(10#15# downto 10#0#);
         \data_out1\ : out csl_bit_vector(10#15# downto 10#0#);
         \data_out2\ : out csl_bit_vector(10#15# downto 10#0#);
         \wr_addr\ : in csl_bit_vector(10#3# downto 10#0#);
         \rd_addr1\ : in csl_bit_vector(10#3# downto 10#0#);
         \rd_addr2\ : in csl_bit_vector(10#3# downto 10#0#);
         \wr_en\ : in csl_bit;
         \rd_en1\ : in csl_bit;
         \rd_en2\ : in csl_bit);
  end component;

  component \m_rom\ is
  end component;

  component \u_es\ is
    port(\p_c\ : in csl_bit_vector(10#7# downto 10#0#);
         \p_ec\ : out csl_bit_vector(10#15# downto 10#0#));
  end component;

  component \r_caddr\ is
    port(\p_clock\ : in csl_bit;
         \p_reset\ : in csl_bit;
         \p_enable\ : in csl_bit;
         \p_direction\ : in csl_bit;
         \p_br_addr\ : in csl_bit_vector(10#15# downto 10#0#);
         \p_sel\ : in csl_bit;
         \p_addr_out\ : out csl_bit_vector(10#15# downto 10#0#));
  end component;

  component \r_ha\ is
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \reg_in\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#));
  end component;

  component \r_status\ is
    port(\reset_\ : in csl_bit;
         \enable\ : in csl_bit;
         \clock\ : in csl_bit;
         \reg_out\ : out csl_bit_vector(10#16# - 10#1# downto 10#0#);
         \reg_in\ : in csl_bit_vector(10#16# - 10#1# downto 10#0#));
  end component;

  component \u_control\ is
  end component;
begin
  \p_sram_addr\ <= aux_sig0;
  \im0\ : \m_im\;
  \r_pc0\ : \r_pc\ port map (\p_addr_out\ => \s_pc_im\,
                             \p_br_addr\ => \s_branch_addr_e\,
                             \p_clock\ => \p_clock\,
                             \p_enable\ => \p_enable\,
                             \p_reset\ => \p_reset\,
                             \p_sel\ => \s_br_sel\);
  \ir0\ : \u_ir\ port map (\p_braddr\ => \s_branch_addr\,
                           \p_c\ => \s_cond\,
                           \p_clock\ => \p_clock\,
                           \p_const8\ => \s_const_val\,
                           \p_d\ => \s_direction\,
                           \p_i\ => \s_ir_im\,
                           \p_op1\ => \s_op1\,
                           \p_op2\ => \s_op2\,
                           \p_opcode\ => \s_opcode\,
                           \p_rdst\ => \s_reg_dest\,
                           \p_romaddr\ => \s_rom_addr\,
                           \p_sha\ => \s_shift_ammount\);
  \alu0\ : \u_alu\ port map (\p_cin\ => \s_status\(10#1# to 10#1#),
                             \p_cout\ => \s_c_f\,
                             \p_op1\ => \s_mux_shift\,
                             \p_op2\ => \s_rf_alu\,
                             \p_opsel\ => \s_opcode\(10#2# downto 10#0#),
                             \p_res\ => \s_alu_mux\);
  \rf0\ : \rf\ port map (\clock\ => \p_clock\,
                         \data_in\ => \s_mem_mux\,
                         \data_out1\ => \s_rf_mux\,
                         \data_out2\ => \s_rf_alu\,
                         \rd_addr1\ => \s_op1\,
                         \rd_addr2\ => \s_op2\,
                         \rd_en1\ => \s_controls\(10#11# to 10#11#),
                         \rd_en2\ => \s_controls\(10#10# to 10#10#),
                         \reset\ => \p_reset\,
                         \wr_addr\ => \s_reg_dest\,
                         \wr_en\ => \s_controls\(10#12# to 10#12#));
  \pattern_rom\ : \m_rom\;
  \es0\ : \u_es\ port map (\p_c\ => \s_const_val\,
                           \p_ec\ => \s_es_mux\);
  \caddr\ : \r_caddr\ port map (\p_addr_out\ => aux_sig0,
                                \p_br_addr\ => \s_rf_alu\,
                                \p_clock\ => \p_clock\,
                                \p_direction\ => \s_caddr_direction\,
                                \p_enable\ => \s_caddr_en\,
                                \p_reset\ => \p_reset\,
                                \p_sel\ => \s_ld_caddr_sel\);
  \haddr\ : \r_ha\ port map (\clock\ => \p_clock\,
                             \enable\ => \p_enable\,
                             \reg_in\ => \s_rf_alu\,
                             \reg_out\ => \s_haddr_cmp\,
                             \reset_\ => \p_reset\);
  \status\ : \r_status\ port map (\clock\ => \p_clock\,
                                  \enable\ => \p_enable\,
                                  \reg_in\ => \s_status_in\,
                                  \reg_out\ => \s_status\,
                                  \reset_\ => \p_reset\);
  \control\ : \u_control\;
end architecture;

