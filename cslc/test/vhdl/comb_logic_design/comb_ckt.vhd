library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity comb is
  port ( in1 : in std_logic;
         in2 : in std_logic;
         in3 : in std_logic;
         in4 : in std_logic;
         out1 : out std_logic
         );
 
end comb;

architecture struct of comb is

  component and1 is 
      port ( i1 : in std_logic;
             i2 : in std_logic;
             out1 : out std_logic
             );
                  
  end component;
  component or1 is
    port ( i1 : in std_logic;
           i2 : in std_logic;
           out1 : out std_logic
           );
  end component;

  signal s1,s2 : std_logic;

  begin
    gate1 : and1 port map (
      i1 => in1,
      i2 => in2,
      out1 => s1
     );
    gate2 : and1 port map (
      i1 => in3,
      i2 => in4,
      out1 => s2
      );
    gate3 : or1 port map (
      i1 => s1,
      i2 => s2,
      out1 => out1
     );
    
end struct;
