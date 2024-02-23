--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : b.vhd
--FILE GENERATED ON : Tue May  4 11:18:03 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity b is 

 port ( -- Location of source csl unit: file name = multiple_units1.csl line number = 14

      in: in csl_bit_vector (5 - 1 downto 0);
      clk: in csl_bit_vector (0 downto 0);
      out: out csl_bit_vector (5 - 1 downto 0)
 );
end b ; 

 architecture  arch_b of b is 
   component a
     port ( 
      in : in   csl_bit_vector(4 downto 0);
      clk : in   csl_bit_vector(0 downto 0);
      out : out   csl_bit_vector(4 downto 0) 
 );
  end component; 



 begin
  
a0 : a port map ( 
                  clk =>(clk),
                  in =>(in),
                  out =>(out)

              );

 end  arch_b ; 
