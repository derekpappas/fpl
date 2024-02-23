--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : dummy_unit_synth_removes.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity dummy_unit_synth_removes is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 131

  dummy1_master_ifc_address: in csl_bit_vector (1 - 1 downto 0);
  dummy1_master_ifc_write_data: in csl_bit_vector (1 - 1 downto 0);
  dummy1_master_ifc_read: in csl_bit_vector (1 - 1 downto 0);
  dummy1_master_ifc_write: in csl_bit_vector (1 - 1 downto 0);
  dummy2_master_ifc_address: in csl_bit_vector (1 - 1 downto 0);
  dummy2_master_ifc_write_data: in csl_bit_vector (1 - 1 downto 0);
  dummy2_master_ifc_read: in csl_bit_vector (1 - 1 downto 0);
  dummy2_master_ifc_write: in csl_bit_vector (1 - 1 downto 0);
  dummy3_master_ifc_address: in csl_bit_vector (1 - 1 downto 0);
  dummy3_master_ifc_write_data: in csl_bit_vector (1 - 1 downto 0);
  dummy3_master_ifc_read: in csl_bit_vector (1 - 1 downto 0);
  dummy3_master_ifc_write: in csl_bit_vector (1 - 1 downto 0);
  dummy1_master_ifc_read_data: out csl_bit_vector (1 - 1 downto 0);
  dummy1_master_ifc_ready: out csl_bit_vector (1 - 1 downto 0);
  dummy1_master_ifc_error: out csl_bit_vector (1 - 1 downto 0);
  dummy2_master_ifc_read_data: out csl_bit_vector (1 - 1 downto 0);
  dummy2_master_ifc_ready: out csl_bit_vector (1 - 1 downto 0);
  dummy2_master_ifc_error: out csl_bit_vector (1 - 1 downto 0);
  dummy3_master_ifc_read_data: out csl_bit_vector (1 - 1 downto 0);
  dummy3_master_ifc_ready: out csl_bit_vector (1 - 1 downto 0);
  dummy3_master_ifc_error: out csl_bit_vector (1 - 1 downto 0)
 );
end dummy_unit_synth_removes ; 

 architecture  arch_dummy_unit_synth_removes of dummy_unit_synth_removes is 

  mbc_out_ifc_address : in   csl_bit_vector(31 downto 0);
  mbc_out_ifc_write_data : in   csl_bit_vector(31 downto 0);
  mbc_out_ifc_write : in   csl_bit_vector(0 downto 0);
  mbc_out_ifc_read : in   csl_bit_vector(0 downto 0);
  mbc_out_ifc_read_data : out   csl_bit_vector(31 downto 0);
  mbc_out_ifc_control : out   csl_bit_vector(31 downto 0) 
 begin 

 end  arch_dummy_unit_synth_removes ; 
