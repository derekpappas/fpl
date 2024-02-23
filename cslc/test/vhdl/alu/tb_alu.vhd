library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.all;

entity tb_alu is
end tb_alu;

architecture arch_tb of tb_alu is

  component alu is 
       port ( op1 : in std_logic_vector(7 downto 0);
              op2 : in std_logic_vector(7 downto 0);
              sel_op : in std_logic_vector(2 downto 0);
              res : out std_logic_vector(8 downto 0)
              );
                
  end component;

  signal s_op1 : std_logic_vector(7 downto 0) := "00000000";
  signal s_op2 : std_logic_vector(7 downto 0) := "00000000";
  signal s_sel : std_logic_vector(2 downto 0);
  signal s_res : std_logic_vector(8 downto 0);

  begin
    ALU1 : alu port map (
      op1 => s_op1,
      op2 => s_op2,
      sel_op => s_sel,
      res => s_res
     );

     process
     begin 
      
         --case1
         s_op1 <= "10000000";
         s_op2 <= "11111111";
         wait for 10 ns;
         s_sel <= "000";
         wait for 10 ns;

          --case2
         s_op1 <= "10011111";
         s_op2 <= "11100000";
         wait for 10 ns;
         s_sel <= "001";
         wait for 10 ns;

          --case3
         s_op1 <= "11111111";
         s_op2 <= "11100000";
         wait for 10 ns;
         s_sel <= "010";
         wait for 10 ns;

          --case4
         s_op1 <= "00001111";
         s_op2 <= "11110000";
         wait for 10 ns;
         s_sel <= "011";
         wait for 10 ns;

          --case5
         s_op1 <= "01001111";
         s_op2 <= "10110000";
         wait for 10 ns;
         s_sel <= "100";
         wait for 10 ns;

          --case6
         s_op1 <= "01001111";
         s_op2 <= "10110000";
         wait for 10 ns;
         s_sel <= "101";
         wait for 10 ns;

     end process;      
end arch_tb;

configuration cfg_sel of tb_alu is
  for arch_tb
    
  end for;
end cfg_sel;
