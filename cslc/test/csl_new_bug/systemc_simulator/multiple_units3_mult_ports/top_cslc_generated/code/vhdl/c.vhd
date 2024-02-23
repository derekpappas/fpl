--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : c.vhd
--FILE GENERATED ON : Wed Jun  9 19:34:52 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity c is 

 port ( -- Location of source csl unit: file name = multiple_units3.csl line number = 28

    in1: in csl_bit_vector (3 - 1 downto 0);
    in2: in csl_bit_vector (0 downto 0);
    in3: in csl_bit_vector (6 - 1 downto 0);
    clk: in csl_bit_vector (0 downto 0);
    out: out csl_bit_vector (3 - 1 downto 0)
 );
end c ; 

 architecture  arch_c of c is 
 component b
 port ( 
    in1 : in   csl_bit_vector(2 downto 0);
    in2 : in   csl_bit_vector(0 downto 0);
    in3 : in   csl_bit_vector(5 downto 0);
    clk : in   csl_bit_vector(0 downto 0);
    out : out   csl_bit_vector(2 downto 0) 
 );
end component; 



 begin

b0 : b port map ( 
                clk =>(clk),
                in1 =>(in1),
                in2 =>(in2),
                in3 =>(in3),
                out =>(out)

            );

 end  arch_c ; 
