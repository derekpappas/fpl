--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : rf.vhd
--FILE GENERATED ON : Sat May  1 19:39:32 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity rf is 

 port ( -- Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 96

Va2r_tap_slave_in_ifc_read_data: out csl_bit_vector (32 - 1 downto 0);
Va2r_tap_slave_in_ifc_ready: out csl_bit_vector (1 - 1 downto 0);
Va2r_tap_slave_in_ifc_error: out csl_bit_vector (1 - 1 downto 0);
Va2r_tap_slave_in_ifc_address: out csl_bit_vector (20 - 1 downto 0);
Va2r_tap_slave_in_ifc_data: out csl_bit_vector (32 - 1 downto 0);
Va2r_tap_slave_in_ifc_read: out csl_bit_vector (1 - 1 downto 0);
Va2r_tap_slave_in_ifc_write: out csl_bit_vector (1 - 1 downto 0)
 );
end rf ; 

 architecture  arch_rf of rf is 

 begin 

 end  arch_rf ; 
