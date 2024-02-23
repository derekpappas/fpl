--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : h264.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity h264 is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 133

mbc_out_ifc_address: in csl_bit_vector (32 - 1 downto 0);
mbc_out_ifc_write_data: in csl_bit_vector (32 - 1 downto 0);
mbc_out_ifc_write: in csl_bit_vector (1 - 1 downto 0);
mbc_out_ifc_read: in csl_bit_vector (1 - 1 downto 0);
mbc_out_ifc_read_data: out csl_bit_vector (32 - 1 downto 0);
mbc_out_ifc_control: out csl_bit_vector (32 - 1 downto 0)
 );
end h264 ; 

 architecture  arch_h264 of h264 is 
 component me
 port ( 
rf_eu_rfi_rd_data_a : in   csl_bit_vector(31 downto 0);
rf_eu_rfi_rd_data_b : in   csl_bit_vector(31 downto 0);
br_in_qual_br : in   csl_bit_vector(0 downto 0);
eu_im_out_rd_data_a : out   csl_bit_vector(31 downto 0);
eu_im_out_rd_data_b : out   csl_bit_vector(31 downto 0);
eu_rf_out_rd_data_a : out   csl_bit_vector(31 downto 0);
eu_rf_out_rd_data_b : out   csl_bit_vector(31 downto 0) 
 );
end component; 



 begin

me : me port map ( 

      );

 end  arch_h264 ; 