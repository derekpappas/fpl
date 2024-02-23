  --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : b_unit.vhd
--FILE GENERATED ON : Thu Aug  5 13:37:45 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity b_unit is 

 port ( -- Location of source csl unit: file name = tb_multi_instance.csl line number = 15
  
        in1  : in csl_bit_vector (4 - 1 downto 0)  ;
        in2  : in csl_bit_vector (0 downto 0)  ;
        clk  : in csl_bit_vector (0 downto 0)  ;
        out1  : out csl_bit_vector (4 - 1 downto 0)  ;
        out2  : out csl_bit_vector (4 - 1 downto 0)  ;
        out3  : out csl_bit_vector (4 - 1 downto 0)  ;
        out4  : out csl_bit_vector (4 - 1 downto 0)        
 );
end b_unit ; 

 architecture  arch_b_unit of b_unit is 
     component a_unit
         port ( 
        in1 : in   csl_bit_vector(3 downto 0);
        in2 : in   csl_bit_vector(0 downto 0);
        clk : in   csl_bit_vector(0 downto 0);
        out1 : out   csl_bit_vector(3 downto 0) 
 );
    end component; 



 begin
    
a0 : a_unit port map ( 
                    clk =>(clk),
                    in1 =>(in1),
                    in2 =>(in2),
                    out1 =>(out1)

                );
    
a1 : a_unit port map ( 
                    clk =>(clk),
                    in1 =>(in1),
                    in2 =>(in2),
                    out1 =>(out2)

                );
    
a2 : a_unit port map ( 
                    clk =>(clk),
                    in1 =>(in1),
                    in2 =>(in2),
                    out1 =>(out3)

                );
    
a3 : a_unit port map ( 
                    clk =>(clk),
                    in1 =>(in1),
                    in2 =>(in2),
                    out1 =>(out4)

                );

 end  arch_b_unit ; 
