--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : me.vhd
--FILE GENERATED ON : Sat May  1 19:39:32 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity me is 

 port ( -- Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 94

gbl_clk: in csl_bit_vector (1 - 1 downto 0);
gbl_reset_: in csl_bit_vector (1 - 1 downto 0);
gbl_enable: in csl_bit_vector (1 - 1 downto 0);
slave_Va2r_tap_arm_read_data: out csl_bit_vector (32 - 1 downto 0);
slave_Va2r_tap_arm_ready: out csl_bit_vector (1 - 1 downto 0);
slave_Va2r_tap_arm_error: out csl_bit_vector (1 - 1 downto 0);
slave_Va2r_tap_arm_address: out csl_bit_vector (20 - 1 downto 0);
slave_Va2r_tap_arm_data: out csl_bit_vector (32 - 1 downto 0);
slave_Va2r_tap_arm_read: out csl_bit_vector (1 - 1 downto 0);
slave_Va2r_tap_arm_write: out csl_bit_vector (1 - 1 downto 0)
 );
end me ; 

 architecture  arch_me of me is 
 component im
 port ( 
 );
end component; 



 begin

rf : rf port map ( 
    Va2r_tap_slave_in_ifc_address =>(),
    Va2r_tap_slave_in_ifc_data =>(),
    Va2r_tap_slave_in_ifc_error =>(),
    Va2r_tap_slave_in_ifc_read =>(),
    Va2r_tap_slave_in_ifc_read_data =>(),
    Va2r_tap_slave_in_ifc_ready =>(),
    Va2r_tap_slave_in_ifc_write =>()

);

pc : pc port map ( 

);

wb : wb port map ( 

);

eu : eu port map ( 

);

im : im port map ( 

);

 end  arch_me ; 
