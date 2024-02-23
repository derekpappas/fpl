--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : z0.vhd
--FILE GENERATED ON : Fri Aug 27 02:46:56 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity z0 is 

-- Location of source csl unit: file name = temp.csl line number = 341
end z0 ; 

 architecture  arch_z0 of z0 is 
 component y1
 port ( 
ar_sa0_s10 : out   csl_bit_vector(0 downto 0) 
 );
end component; 


signal ar_sa0_s10 : csl_bit_vector(0 downto 0);

 begin

y0 : y0 port map ( 
ar_sa0_s10 =>(ar_sa0_s10)

);

y10 : y1 port map ( 
ar_sa0_s10 =>(ar_sa0_s10)

);

 end  arch_z0 ; 