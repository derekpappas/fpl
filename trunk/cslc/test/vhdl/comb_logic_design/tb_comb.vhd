library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
  
end tb;

architecture tb_comb of tb is
  component comb_gate is
     port  ( in1 : in std_logic;
             in2 : in std_logic;
             in3 : in std_logic;
             in4 : in std_logic;
             out1 : out std_logic
             );
       
  end component;

  signal sig1,sig2,sig3,sig4 : std_logic := '0';
  signal sig_out : std_logic;

  begin

    dut : comb_gate port map (
      in1 => sig1,
      in2 => sig2,
      in3 => sig3,
      in4 => sig4,
      out1 => sig_out
      );

  process 
  begin 
   --case1
     sig1 <= '0';
     sig2 <= '0';
     sig3 <= '0';
     sig4 <= '0';

     wait for 10 ns;

   --case2
     sig1 <= '1';
     sig2 <= '0';
     sig3 <= '0';
     sig4 <= '0';

     wait for 10 ns;

    --case3
     sig1 <= '0';
     sig2 <= '1';
     sig3 <= '0';
     sig4 <= '0';

     wait for 10 ns;
     
    --case4
     sig1 <= '0';
     sig2 <= '0';
     sig3 <= '1';
     sig4 <= '0';

     wait for 10 ns;

    --case5
     sig1 <= '0';
     sig2 <= '0';
     sig3 <= '0';
     sig4 <= '1';

     wait for 10 ns;

    --case6
     sig1 <= '1';
     sig2 <= '1';
     sig3 <= '1';
     sig4 <= '1';

     wait for 10 ns;
     
  end process;
end tb_comb;

configuration cfg of tb is
  for tb_comb
    
  end for;
end cfg;
