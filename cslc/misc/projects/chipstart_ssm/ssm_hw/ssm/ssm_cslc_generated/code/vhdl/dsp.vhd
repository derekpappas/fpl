--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : dsp.vhd
--FILE GENERATED ON : Sat May  1 19:39:32 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity dsp is 

 port ( -- Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 89

  gbl_clk: in csl_bit_vector (1 - 1 downto 0);
  gbl_reset_: in csl_bit_vector (1 - 1 downto 0);
  gbl_enable: in csl_bit_vector (1 - 1 downto 0);
  slave_Va2r_tap_dsp_read_data: out csl_bit_vector (32 - 1 downto 0);
  slave_Va2r_tap_dsp_ready: out csl_bit_vector (1 - 1 downto 0);
  slave_Va2r_tap_dsp_error: out csl_bit_vector (1 - 1 downto 0);
  slave_Va2r_tap_dsp_address: out csl_bit_vector (20 - 1 downto 0);
  slave_Va2r_tap_dsp_data: out csl_bit_vector (32 - 1 downto 0);
  slave_Va2r_tap_dsp_read: out csl_bit_vector (1 - 1 downto 0);
  slave_Va2r_tap_dsp_write: out csl_bit_vector (1 - 1 downto 0)
 );
end dsp ; 

 architecture  arch_dsp of dsp is 
 component me
 port ( 
  gbl_clk : in   csl_bit_vector(0 downto 0);
  gbl_reset_ : in   csl_bit_vector(0 downto 0);
  gbl_enable : in   csl_bit_vector(0 downto 0);
  slave_Va2r_tap_cmpr_read_data : out   csl_bit_vector(31 downto 0);
  slave_Va2r_tap_cmpr_ready : out   csl_bit_vector(0 downto 0);
  slave_Va2r_tap_cmpr_error : out   csl_bit_vector(0 downto 0);
  slave_Va2r_tap_cmpr_address : out   csl_bit_vector(19 downto 0);
  slave_Va2r_tap_cmpr_data : out   csl_bit_vector(31 downto 0);
  slave_Va2r_tap_cmpr_read : out   csl_bit_vector(0 downto 0);
  slave_Va2r_tap_cmpr_write : out   csl_bit_vector(0 downto 0) 
 );
end component; 



 begin

me : me port map ( 
              gbl_clk =>(gbl_clk),
              gbl_enable =>(gbl_enable),
              gbl_reset_ =>(gbl_reset_),
              slave_Va2r_tap_arm_address =>(slave_Va2r_tap_dsp_address),
              slave_Va2r_tap_arm_data =>(slave_Va2r_tap_dsp_data),
              slave_Va2r_tap_arm_error =>(slave_Va2r_tap_dsp_error),
              slave_Va2r_tap_arm_read =>(slave_Va2r_tap_dsp_read),
              slave_Va2r_tap_arm_read_data =>(slave_Va2r_tap_dsp_read_data),
              slave_Va2r_tap_arm_ready =>(slave_Va2r_tap_dsp_ready),
              slave_Va2r_tap_arm_write =>(slave_Va2r_tap_dsp_write)

          );

 end  arch_dsp ; 
