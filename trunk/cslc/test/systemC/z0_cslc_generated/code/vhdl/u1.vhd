--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : u1.vhd
--FILE GENERATED ON : Fri Aug 27 02:46:56 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity u1 is 

 port ( -- Location of source csl unit: file name = temp.csl line number = 304

su1: out csl_bit_vector (0 downto 0);
ar_sa0_s10: out csl_bit_vector (1 - 1 downto 0)
 );
end u1 ; 

 architecture  arch_u1 of u1 is 
 component t1
 port ( 
ar_sa0_s10 : out   csl_bit_vector(0 downto 0) 
 );
end component; 



 begin

t10 : t1 port map ( 
ar_sa0_s10 =>(ar_sa0_s10)

);

 end  arch_u1 ; 
