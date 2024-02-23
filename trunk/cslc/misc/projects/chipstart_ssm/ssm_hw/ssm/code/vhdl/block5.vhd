--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : block5.vhd
--FILE GENERATED ON : Mon Mar  8 10:42:45 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity block5 is 

 port ( -- Location of source csl unit: file name = ssm_demo.csl line number = 94

a2r_block_in_ifc_read_data: in csl_bit_vector (1 - 1 downto 0);
a2r_block_in_ifc_ready: in csl_bit_vector (1 - 1 downto 0);
a2r_block_in_ifc_error: in csl_bit_vector (1 - 1 downto 0);
a2r_block_in_ifc_address: out csl_bit_vector (1 - 1 downto 0);
a2r_block_in_ifc_write_data: out csl_bit_vector (1 - 1 downto 0);
a2r_block_in_ifc_read: out csl_bit_vector (1 - 1 downto 0);
a2r_block_in_ifc_write: out csl_bit_vector (1 - 1 downto 0)
 );
end block5 ; 

 architecture  arch_block5 of block5 is 

a2r_block_in_ifc_read_data : in   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_ready : in   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_error : in   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_address : out   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_write_data : out   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_read : out   csl_bit_vector(0 downto 0);
a2r_block_in_ifc_write : out   csl_bit_vector(0 downto 0) 
 begin 

 end  arch_block5 ; 
