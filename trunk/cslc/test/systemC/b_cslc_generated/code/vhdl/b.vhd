--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : b.vhd
--FILE GENERATED ON : Sun Mar  7 15:39:23 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity b is 

 port ( -- Location of source csl unit: file name = 2.csl line number = 11

      in: in csl_bit_vector (0 downto 0);
      clk: in csl_bit_vector (0 downto 0);
      out: out csl_bit_vector (0 downto 0)
 );
end b ; 

 architecture  arch_b of b is 
   component a
   port ( 
      in : in   csl_bit_vector(-1073741821 downto -1073741821);
      clk : in   csl_bit_vector(0 downto 0);
      out : out   csl_bit_vector(0 downto 0) 
 );
  end component; 



 begin
  
a0 : a port map ( 
                  clk =>(clkclk),
                  in =>(inin),
                  out =>(outout)

              );

 end  arch_b ; 
