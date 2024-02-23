library ieee;
use ieee.std_logic_1164.all;

entity and_gate is
  port (
    i1 : in std_logic;
    i2 : in std_logic;
    out1 : out std_logic
    );
end and_gate;

architecture behv of and_gate is
  begin
    process(i1,i2)
      begin
        out1<=i1 and i2;
      end process;
  end behv;     
  
