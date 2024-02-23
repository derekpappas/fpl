--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : ssm_master.vhd
--FILE GENERATED ON : Sat May  1 19:39:32 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity ssm_master is 

 port ( -- Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 98

Va2r_tap_master_ifc_address: in csl_bit_vector (1 - 1 downto 0);
Va2r_tap_master_ifc_write_data: in csl_bit_vector (1 - 1 downto 0);
Va2r_tap_master_ifc_read: in csl_bit_vector (1 - 1 downto 0);
Va2r_tap_master_ifc_write: in csl_bit_vector (1 - 1 downto 0);
gbl_clk: in csl_bit_vector (1 - 1 downto 0);
gbl_reset_: in csl_bit_vector (1 - 1 downto 0);
gbl_enable: in csl_bit_vector (1 - 1 downto 0);
Va2r_tap_master_ifc_read_data: out csl_bit_vector (1 - 1 downto 0);
Va2r_tap_master_ifc_ready: out csl_bit_vector (1 - 1 downto 0);
Va2r_tap_master_ifc_error: out csl_bit_vector (1 - 1 downto 0)
 );
end ssm_master ; 

 architecture  arch_ssm_master of ssm_master is 

 begin 

 end  arch_ssm_master ; 
