library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

use work.all;

entity tb_mux is
  
end tb_mux;

architecture arch_tb of tb_mux is
  component mux is 
      port ( i0 : in std_logic_vector(3 downto 0);
             i1 : in std_logic_vector(3 downto 0);
             i2 : in std_logic_vector(3 downto 0);
             i3 : in std_logic_vector(3 downto 0);
             sel : in std_logic_vector(1 downto 0);
             o1 : out std_logic_vector(3 downto 0)
             );
                 
  end component;

  signal s1 : std_logic_vector(3 downto 0):= "0000";
  signal s2 : std_logic_vector(3 downto 0):= "0000";
  signal s3 : std_logic_vector(3 downto 0):= "0000";
  signal s4 : std_logic_vector(3 downto 0):= "0000";
  signal s5 : std_logic_vector(1 downto 0);
  signal s6 : std_logic_vector(3 downto 0);
  
begin 

  MUX1 : mux port map (
    i0 => s1,
    i1 => s2,
    i2 => s3,
    i3 => s4,
    sel => s5,
    o1 => s6
   );

  process 
   

  begin 

    --case1
    s1 <= "0000";
    s2 <= "0011";
    s3 <= "1100";
    s4 <= "1111";
    wait for 10 ns;
    s5 <= "00";
    wait for 10 ns;

    --case2
    s1 <= "0000";
    s2 <= "0011";
    s3 <= "1100";
    s4 <= "1111";
    wait for 10 ns;
    s5 <= "01";
    wait for 10 ns;
    
     --case3
    s1 <= "0000";
    s2 <= "0011";
    s3 <= "1100";
    s4 <= "1111";
    wait for 10 ns;
    s5 <= "10";
    wait for 10 ns;

     --case4
    s1 <= "0000";
    s2 <= "0011";
    s3 <= "1100";
    s4 <= "1111";
    wait for 10 ns;
    s5 <= "11";

  end process;
end arch_tb;

configuration cfg_mux of tb_mux is
  for arch_tb
  end for;
end cfg_mux;
  
