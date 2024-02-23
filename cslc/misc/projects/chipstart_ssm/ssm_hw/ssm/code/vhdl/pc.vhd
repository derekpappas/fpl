--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : pc.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity pc is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 138

me_cntl_out_v: out csl_bit_vector (1 - 1 downto 0);
me_cntl_out_pc: out csl_bit_vector (8 - 1 downto 0);
me_cntl_out_npc: out csl_bit_vector (8 - 1 downto 0);
me_cntl_out_ir: out csl_bit_vector (32 - 1 downto 0);
me_cntl_out_br_offset: out csl_bit_vector (8 - 1 downto 0)
 );
end pc ; 

 architecture  arch_pc of pc is 

me_cntl_out_v : out   csl_bit_vector(0 downto 0);
me_cntl_out_pc : out   csl_bit_vector(7 downto 0);
me_cntl_out_npc : out   csl_bit_vector(7 downto 0);
me_cntl_out_ir : out   csl_bit_vector(31 downto 0);
me_cntl_out_br_offset : out   csl_bit_vector(7 downto 0) 
 begin 

 end  arch_pc ; 
