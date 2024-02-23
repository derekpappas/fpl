library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity alu  is
  port (op1 : in std_logic_vector(7 downto 0);
        op2 : in std_logic_vector(7 downto 0);
        sel_op: in std_logic_vector(2 downto 0);
        res : out std_logic_vector(8 downto 0)
        );
    
end alu ;

architecture arch_alu of alu is

begin
  process(op1,op2,sel_op)
    begin
      case sel_op is

     when   "000" => res <= op1 + op2;
     when   "001" => res <= op1 - op2;
     when   "010" => res <= op1 * op2;
     when   "011" => res <= op1(7 downto 4) & op2(3 downto 0);  --concatenation                                                               
     when   "100" => res <= op1 and op2;
     when   "101" => res <= op1 or op2;                
     when others  => res <= "ZZZZZZZZZ";               

    end case;
 end process;
    
end arch_alu;

