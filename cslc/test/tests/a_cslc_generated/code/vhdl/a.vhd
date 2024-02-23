  --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : a.vhd
--FILE GENERATED ON : Wed Jul 28 21:41:03 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity a is 
-- Location of source csl unit: file name = tb_test.csl line number = 1
  
        in  : in csl_bit_vector (3 - 1 downto 0)  ;
        clk  : in csl_bit_vector (0 downto 0)  ;
        out  : out csl_bit_vector (2 - 1 downto 0)  ;
        out2  : out csl_bit_vector (4 - 1 downto 0)                                                                                                        
 );
end a ; 

 architecture  arch_a of a is 

                    signal s_in : csl_bit_vector(2 downto 0);
                    signal s_out : csl_bit_vector(1 downto 0);
                    signal s_out2 : csl_bit_vector(3 downto 0);
                    signal s_clk : csl_bit_vector(0 downto 0);
 begin 
                s_in <= in;
                s_clk <= clk;
                out2 <= s_out2;
                s_out <= s_out2;
                out <= s_out;
                s_out2 <= "0111";
                s_out <= "11";

 end  arch_a ; 
