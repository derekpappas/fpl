--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : mcb.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity mcb is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 136

mbc_in_ifc_read_data: in csl_bit_vector (32 - 1 downto 0);
mbc_in_ifc_control: in csl_bit_vector (32 - 1 downto 0);
a2rtap_slave_in_ifc_read_data: out csl_bit_vector (32 - 1 downto 0);
a2rtap_slave_in_ifc_ready: out csl_bit_vector (1 - 1 downto 0);
a2rtap_slave_in_ifc_error: out csl_bit_vector (1 - 1 downto 0);
a2rtap_slave_in_ifc_address: out csl_bit_vector (20 - 1 downto 0);
a2rtap_slave_in_ifc_data: out csl_bit_vector (32 - 1 downto 0);
a2rtap_slave_in_ifc_read: out csl_bit_vector (1 - 1 downto 0);
a2rtap_slave_in_ifc_write: out csl_bit_vector (1 - 1 downto 0);
mbc_in_ifc_address: out csl_bit_vector (32 - 1 downto 0);
mbc_in_ifc_write_data: out csl_bit_vector (32 - 1 downto 0);
mbc_in_ifc_write: out csl_bit_vector (1 - 1 downto 0);
mbc_in_ifc_read: out csl_bit_vector (1 - 1 downto 0)
 );
end mcb ; 

 architecture  arch_mcb of mcb is 

me_cntl_in_v : in   csl_bit_vector(0 downto 0);
me_cntl_in_pc : in   csl_bit_vector(7 downto 0);
me_cntl_in_npc : in   csl_bit_vector(7 downto 0);
me_cntl_in_ir : in   csl_bit_vector(31 downto 0);
me_cntl_in_br_offset : in   csl_bit_vector(7 downto 0);
br_in_qual_br : in   csl_bit_vector(0 downto 0);
im_rf_out_rfi_wr_addr : out   csl_bit_vector(3 downto 0);
im_rf_out_rfi_wr_en : out   csl_bit_vector(0 downto 0);
im_rf_out_rfi_wr_data : out   csl_bit_vector(31 downto 0);
im_rf_out_rfi_rd_addr_a : out   csl_bit_vector(3 downto 0);
im_rf_out_rfi_rd_en_a : out   csl_bit_vector(0 downto 0);
im_rf_out_rfi_rd_addr_b : out   csl_bit_vector(3 downto 0);
im_rf_out_rfi_rd_en_b : out   csl_bit_vector(0 downto 0);
me_cntl_out_v : out   csl_bit_vector(0 downto 0);
me_cntl_out_pc : out   csl_bit_vector(7 downto 0);
me_cntl_out_npc : out   csl_bit_vector(7 downto 0);
me_cntl_out_ir : out   csl_bit_vector(31 downto 0);
me_cntl_out_br_offset : out   csl_bit_vector(7 downto 0) 
 begin 

 end  arch_mcb ; 
