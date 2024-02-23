            --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : x.vhd
--FILE GENERATED ON : Fri Jul 30 07:13:06 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity x is 

 port ( -- Location of source csl unit: file name = tb_multilevel.csl line number = 17
            
                  in1            : in csl_bit_vector (3 - 1 downto 0)            ;
                  in2            : in csl_bit_vector (8 - 1 downto 0)            ;
                  clk            : in csl_bit_vector (0 downto 0)            ;
                  out1            : out csl_bit_vector (3 - 1 downto 0)            ;
                  out2            : out csl_bit_vector (8 - 1 downto 0)                                                    
 );
end x ; 

 architecture  arch_x of x is 
                 component y
                                 port ( 
                    in1 : in   csl_bit_vector(2 downto 0);
                    in2 : in   csl_bit_vector(7 downto 0);
                    out1 : out   csl_bit_vector(2 downto 0);
                    out2 : out   csl_bit_vector(7 downto 0) 
 );
                end component; 


                    signal s_clk : csl_bit_vector(0 downto 0);

 begin
                s_clk <= clk;
                
y0 : y port map ( 
                                in1 =>(in1),
                                in2 =>(in2),
                                out1 =>(out1),
                                out2 =>(out2)

                            );

 end  arch_x ; 
