--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : rf.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity rf is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 139

im_rf_in_rfi_wr_addr: in csl_bit_vector (4 - 1 downto 0);
im_rf_in_rfi_wr_en: in csl_bit_vector (1 - 1 downto 0);
im_rf_in_rfi_wr_data: in csl_bit_vector (32 - 1 downto 0);
im_rf_in_rfi_rd_addr_a: in csl_bit_vector (4 - 1 downto 0);
im_rf_in_rfi_rd_en_a: in csl_bit_vector (1 - 1 downto 0);
im_rf_in_rfi_rd_addr_b: in csl_bit_vector (4 - 1 downto 0);
im_rf_in_rfi_rd_en_b: in csl_bit_vector (1 - 1 downto 0);
eu_rf_in_rd_data_a: in csl_bit_vector (32 - 1 downto 0);
eu_rf_in_rd_data_b: in csl_bit_vector (32 - 1 downto 0);
br_in_qual_br: in csl_bit_vector (1 - 1 downto 0);
rf_eu_rfi_rd_data_a: out csl_bit_vector (32 - 1 downto 0);
rf_eu_rfi_rd_data_b: out csl_bit_vector (32 - 1 downto 0)
 );
end rf ; 

 architecture  arch_rf of rf is 

im_rf_in_rfi_wr_addr : in   csl_bit_vector(3 downto 0);
im_rf_in_rfi_wr_en : in   csl_bit_vector(0 downto 0);
im_rf_in_rfi_wr_data : in   csl_bit_vector(31 downto 0);
im_rf_in_rfi_rd_addr_a : in   csl_bit_vector(3 downto 0);
im_rf_in_rfi_rd_en_a : in   csl_bit_vector(0 downto 0);
im_rf_in_rfi_rd_addr_b : in   csl_bit_vector(3 downto 0);
im_rf_in_rfi_rd_en_b : in   csl_bit_vector(0 downto 0);
eu_rf_in_rd_data_a : in   csl_bit_vector(31 downto 0);
eu_rf_in_rd_data_b : in   csl_bit_vector(31 downto 0);
br_in_qual_br : in   csl_bit_vector(0 downto 0);
rf_eu_rfi_rd_data_a : out   csl_bit_vector(31 downto 0);
rf_eu_rfi_rd_data_b : out   csl_bit_vector(31 downto 0) 
 begin 

 end  arch_rf ; 
