--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : x1.vhd
--FILE GENERATED ON : Fri Aug 27 02:46:56 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity x1 is 

 port ( -- Location of source csl unit: file name = temp.csl line number = 325

sx1: out csl_bit_vector (0 downto 0);
ar_sa0_s10: out csl_bit_vector (1 - 1 downto 0)
 );
end x1 ; 

 architecture  arch_x1 of x1 is 
 component w1
 port ( 
ar_sa0_s10 : out   csl_bit_vector(0 downto 0) 
 );
end component; 



 begin

w10 : w1 port map ( 
ar_sa0_s10 =>(ar_sa0_s10)

);

 end  arch_x1 ; 
