library ieee;
use ieee.std_logic_1164.all;

entity or_gate is
  port ( i1 : in std_logic;
         i2 : in std_logic;
         out1: out std_logic
         );
end or_gate;

architecture behv of or_gate is

  begin
    process(i1,i2)
      begin
        out1<=i1 or i2;
      end process;  

  end behv;  
