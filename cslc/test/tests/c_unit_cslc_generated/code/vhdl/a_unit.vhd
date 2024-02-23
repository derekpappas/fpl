  --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : a_unit.vhd
--FILE GENERATED ON : Thu Aug  5 13:37:45 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity a_unit is 
-- Location of source csl unit: file name = tb_multi_instance.csl line number = 3
  
        in1  : in csl_bit_vector (4 - 1 downto 0)  ;
        in2  : in csl_bit_vector (0 downto 0)  ;
        clk  : in csl_bit_vector (0 downto 0)  ;
        out1  : out csl_bit_vector (4 - 1 downto 0)         
 );
end a_unit ; 

 architecture  arch_a_unit of a_unit is 

 begin 
      out1 <= in1 & in2;

 end  arch_a_unit ; 
