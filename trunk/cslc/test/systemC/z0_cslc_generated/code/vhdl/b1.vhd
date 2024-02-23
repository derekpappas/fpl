--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : b1.vhd
--FILE GENERATED ON : Fri Aug 27 02:46:56 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity b1 is 

 port ( -- Location of source csl unit: file name = temp.csl line number = 189

ar_sa0_s10: out csl_bit_vector (1 - 1 downto 0)
 );
end b1 ; 

 architecture  arch_b1 of b1 is 
 component a1
 port ( 
s10 : out   csl_bit_vector(-1468745168 downto 54) 
 );
end component; 



 begin

a10 : a1 port map ( 
s10 =>(ar_sa0_s10)

);

 end  arch_b1 ; 
