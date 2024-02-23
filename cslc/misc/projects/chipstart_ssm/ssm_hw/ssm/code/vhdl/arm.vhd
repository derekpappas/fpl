--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : arm.vhd
--FILE GENERATED ON : Thu Mar 11 16:36:24 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity arm is 

 port ( -- Location of source csl unit: file name = ssm_demo.csl line number = 90

      mbc_out_ifc_address: in csl_bit_vector (32 - 1 downto 0);
      mbc_out_ifc_write_data: in csl_bit_vector (32 - 1 downto 0);
      mbc_out_ifc_write: in csl_bit_vector (1 - 1 downto 0);
      mbc_out_ifc_read: in csl_bit_vector (1 - 1 downto 0);
      mbc_out_ifc_read_data: out csl_bit_vector (32 - 1 downto 0);
      mbc_out_ifc_control: out csl_bit_vector (32 - 1 downto 0)
 );
end arm ; 

 architecture  arch_arm of arm is 

      a2rtap_master_ifc_read_data : in   csl_bit_vector(0 downto 0);
      a2rtap_master_ifc_ready : in   csl_bit_vector(0 downto 0);
      a2rtap_master_ifc_error : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_grant : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_request : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_in : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_aphi : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_write : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_read : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_ready : in   csl_bit_vector(0 downto 0);
      ring_out_ifc_error : in   csl_bit_vector(0 downto 0);
      a2rtap_slave_out_ifc_read_data : in   csl_bit_vector(31 downto 0);
      a2rtap_slave_out_ifc_ready : in   csl_bit_vector(0 downto 0);
      a2rtap_slave_out_ifc_error : in   csl_bit_vector(0 downto 0);
      a2rtap_slave_out_ifc_address : in   csl_bit_vector(19 downto 0);
      a2rtap_slave_out_ifc_data : in   csl_bit_vector(31 downto 0);
      a2rtap_slave_out_ifc_read : in   csl_bit_vector(0 downto 0);
      a2rtap_slave_out_ifc_write : in   csl_bit_vector(0 downto 0);
      a2rtap_master_ifc_address : out   csl_bit_vector(0 downto 0);
      a2rtap_master_ifc_write_data : out   csl_bit_vector(0 downto 0);
      a2rtap_master_ifc_read : out   csl_bit_vector(0 downto 0);
      a2rtap_master_ifc_write : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_grant : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_request : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_in : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_aphi : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_write : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_read : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_ready : out   csl_bit_vector(0 downto 0);
      ring_in_ifc_error : out   csl_bit_vector(0 downto 0);
      gbl_clock : out   csl_bit_vector(0 downto 0);
      gbl_reset : out   csl_bit_vector(0 downto 0);
      gbl_a2rtap_pipe_en : out   csl_bit_vector(0 downto 0) 
 begin 

 end  arch_arm ; 
