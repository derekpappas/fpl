--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : wb.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:03 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity wb is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 142

me_cntl_in_v: in csl_bit_vector (1 - 1 downto 0);
me_cntl_in_pc: in csl_bit_vector (8 - 1 downto 0);
me_cntl_in_npc: in csl_bit_vector (8 - 1 downto 0);
me_cntl_in_ir: in csl_bit_vector (32 - 1 downto 0);
me_cntl_in_br_offset: in csl_bit_vector (8 - 1 downto 0);
eu_wb_in_rd_data_a: in csl_bit_vector (32 - 1 downto 0);
eu_wb_in_rd_data_b: in csl_bit_vector (32 - 1 downto 0);
br_out_qual_br: out csl_bit_vector (1 - 1 downto 0)
 );
end wb ; 

 architecture  arch_wb of wb is 

 begin 

 end  arch_wb ; 
