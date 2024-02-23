library ieee;
use ieee.std_logic_1164.all;

entity mux is
  port ( i0 : in std_logic_vector(3 downto 0);
         i1 : in std_logic_vector(3 downto 0);
         i2 : in std_logic_vector(3 downto 0);
         i3 : in std_logic_vector(3 downto 0);
         sel : in std_logic_vector(1 downto 0);
         o1 : out std_logic_vector(3 downto 0)
         );
end mux;

architecture behv1 of mux is

begin
  process(i0,i1,i2,i3,sel)
    begin
      case sel is 
       
        when "00" => o1 <= i0;
        when "01" => o1 <= i1;
        when "10" => o1 <= i2;
        when "11" => o1 <= i3;             
        when others => o1 <="ZZZZ";
      
      end case;
    end process;
    
end behv1;

architecture behv2 of mux is

begin 
 
--when-else statement
  o1 <= i0 when sel="00" else 
        i1 when sel="01" else 
        i2 when sel="10" else 
        i3 when sel="11" else 
        "ZZZZ";

end behv2;
