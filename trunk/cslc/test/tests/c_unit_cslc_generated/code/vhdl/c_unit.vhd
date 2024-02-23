--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : c_unit.vhd
--FILE GENERATED ON : Thu Aug  5 13:37:45 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity c_unit is 

 port ( -- Location of source csl unit: file name = tb_multi_instance.csl line number = 34

      in1: in csl_bit_vector (4 - 1 downto 0);
      in2: in csl_bit_vector (4 - 1 downto 0);
      in3: in csl_bit_vector (0 downto 0);
      in4: in csl_bit_vector (0 downto 0);
      clk: in csl_bit_vector (0 downto 0);
      out1: out csl_bit_vector (4 - 1 downto 0);
      out2: out csl_bit_vector (4 - 1 downto 0);
      out3: out csl_bit_vector (4 - 1 downto 0);
      out4: out csl_bit_vector (4 - 1 downto 0)            
 );
end c_unit ; 

 architecture  arch_c_unit of c_unit is 
       component b_unit
       port ( 
          in1 : in   csl_bit_vector(3 downto 0);
          in2 : in   csl_bit_vector(0 downto 0);
          clk : in   csl_bit_vector(0 downto 0);
          out1 : out   csl_bit_vector(3 downto 0);
          out2 : out   csl_bit_vector(3 downto 0);
          out3 : out   csl_bit_vector(3 downto 0);
          out4 : out   csl_bit_vector(3 downto 0) 
 );
      end component; 


          signal s_in1 : csl_bit_vector(3 downto 0);
          signal s_in2 : csl_bit_vector(0 downto 0);

 begin
      s_in2 <= in3 or in4;
      s_in1 <= in1 and in2;
      
b0 : b_unit port map ( 
                      clk =>(clk),
                      in1 =>(s_in1),
                      in2 =>(s_in2),
                      out1 =>(out1),
                      out2 =>(out2),
                      out3 =>(out3),
                      out4 =>(out4)

                  );

 end  arch_c_unit ; 
