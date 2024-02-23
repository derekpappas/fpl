--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : ssm.vhd
--FILE GENERATED ON : Mon Mar  8 10:42:45 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity ssm is 

 port ( -- Location of source csl unit: file name = ssm_demo.csl line number = 96

a2rslave_out_ifc_grant: in csl_bit_vector (1 - 1 downto 0);
a2rslave_out_ifc_request: in csl_bit_vector (1 - 1 downto 0);
a2rslave_out_ifc_in: in csl_bit_vector (1 - 1 downto 0);
a2rslave_out_ifc_aphi: in csl_bit_vector (1 - 1 downto 0);
a2rslave_out_ifc_write: in csl_bit_vector (1 - 1 downto 0);
a2rslave_out_ifc_read: in csl_bit_vector (1 - 1 downto 0);
a2rslave_out_ifc_ready: in csl_bit_vector (1 - 1 downto 0);
a2rslave_out_ifc_error: in csl_bit_vector (1 - 1 downto 0);
a2r_global_ifc_clock: in csl_bit_vector (1 - 1 downto 0);
a2r_global_ifc_reset: in csl_bit_vector (1 - 1 downto 0);
a2r_global_ifc_a2r_pipe_en: in csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_grant: out csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_request: out csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_in: out csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_aphi: out csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_write: out csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_read: out csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_ready: out csl_bit_vector (1 - 1 downto 0);
a2rslave_in_ifc_error: out csl_bit_vector (1 - 1 downto 0)
 );
end ssm ; 

 architecture  arch_ssm of ssm is 

a2r_block_in_ifc_read_data : in   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_ready : in   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_error : in   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_address : out   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_write_data : out   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_read : out   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_write : out   csl_bit_vector(0 downto 0) 
 begin 

 end  arch_ssm ; 
