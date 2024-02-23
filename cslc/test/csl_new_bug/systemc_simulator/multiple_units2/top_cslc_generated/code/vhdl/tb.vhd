        --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : tb.vhd
--FILE GENERATED ON : Thu Jun 10 02:45:25 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity tb is 

-- Location of source csl unit: file name = multiple_units2.csl line number = 60
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
                                                                                                                                                                                                                                                                                    
          process  wait until  or  wait until  begin 
            if ( ~( ) then begin 
               <=             end
             else  begin 
               <=             end
          end

          initial 
 begin 
            ()             :=              :=              :=              wait for :=              wait for :=              := )            if (  ) then begin 
              ()                          end
            (, )            ()            (, )                         :=              :=              :=           end

          process  wait for := ~(
          process  wait until  or  wait until  begin 
            if ( ~( ) then begin 
               :=                end
             else  begin 
              if (  ) then begin 
                 :=                  :=                 (, , , , )              end
              if (  ) then begin 
                (, )              end
            end
          end

          process  wait until  or  wait until  begin 
            if ( ~( ) then begin 
               :=                end
             else  begin 
              if (  ) then begin 
                 :=                  :=                 (, , , , )              end
            end
          end
end tb ; 

 architecture  arch_tb of tb is 
             component stim_expect_mem_template
             port ( 
                clock : in   csl_bit_vector(-1468745200 downto 54);
                reset_ : in   csl_bit_vector(0 downto 0);
                rd_en : in   csl_bit_vector(-1468745280 downto 54);
                vector_out : out   csl_bit_vector(1 downto 0);
                valid : out   csl_bit_vector(-1468745280 downto 54);
                version_err : out   csl_bit_vector(-1468745280 downto 54);
                id_err : out   csl_bit_vector(-1468745280 downto 54) 
 );
            end component; 


                signal expect_out_valid : csl_bit_vector(-1468745280 downto 54);
                signal rd_en : csl_bit_vector(0 downto 0);
                signal version_err : csl_bit_vector(-1468745280 downto 54);
                signal id_err : csl_bit_vector(-1468745280 downto 54);
                signal stop_sim : csl_bit_vector(0 downto 0);
                signal c0_in_in : csl_bit_vector(2 downto 0);
                signal c0_out_out : csl_bit_vector(2 downto 0);
                signal c0_out_out_expect : csl_bit_vector(2 downto 0);
                signal c0_out_out_mismatch_en : csl_bit_vector(0 downto 0);
                signal c0_out_out_match_en : csl_bit_vector(0 downto 0);

 begin
            rd_en <= rand_valid;
            
c0 : c generic map ( ADDR_WIDTH <= ) ADDR_WIDTH <= ) 
             port map ( 
                            clk =>(clk),
                            in =>(c0_in_in),
                            out =>(c0_out_out)

                        );
            
stim_c0 : stim_expect_mem_template generic map ( ADDR_WIDTH <= ) ADDR_WIDTH <= ) 
             port map ( 
                            clock =>(clk),
                            id_err =>(id_err),
                            rd_en =>(rd_en),
                            reset_ =>(testbench_reset),
                            valid =>(expect_out_valid),
                            vector_out =>(c0_in_in),
                            version_err =>(version_err)

                        );
            
exp_c0 : stim_expect_mem_template generic map ( ADDR_WIDTH <= ) ADDR_WIDTH <= ) 
             port map ( 
                            clock =>(clk),
                            id_err =>(id_err),
                            rd_en =>(rd_en),
                            reset_ =>(testbench_reset),
                            valid =>(expect_out_valid),
                            vector_out =>(c0_out_out_expect),
                            version_err =>(version_err)

                        );
        end process; 
 end  arch_tb ; 
