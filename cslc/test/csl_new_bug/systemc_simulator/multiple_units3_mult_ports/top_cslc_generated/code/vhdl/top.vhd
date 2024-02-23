--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : top.vhd
--FILE GENERATED ON : Wed Jun  9 19:34:52 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity top is 

 port ( -- Location of source csl unit: file name = multiple_units3.csl line number = 40

  in1: in csl_bit_vector (3 - 1 downto 0);
  in2: in csl_bit_vector (0 downto 0);
  in3: in csl_bit_vector (6 - 1 downto 0);
  clk: in csl_bit_vector (0 downto 0);
  out1: out csl_bit_vector (3 - 1 downto 0);
  out2: out csl_bit_vector (3 - 1 downto 0)
 );
end top ; 

 architecture  arch_top of top is 
 component c
 port ( 
  in1 : in   csl_bit_vector(2 downto 0);
  in2 : in   csl_bit_vector(0 downto 0);
  in3 : in   csl_bit_vector(5 downto 0);
  clk : in   csl_bit_vector(0 downto 0);
  out : out   csl_bit_vector(2 downto 0) 
 );
end component; 



 begin

c0 : c port map ( 
              clk =>(clk),
              in1 =>(in1),
              in2 =>(in2),
              in3 =>(in3),
              out =>(out1)

          );

c1 : c port map ( 
              clk =>(clk),
              in1 =>(in1),
              in2 =>(in2),
              in3 =>(in3),
              out =>(out2)

          );

 end  arch_top ; 
