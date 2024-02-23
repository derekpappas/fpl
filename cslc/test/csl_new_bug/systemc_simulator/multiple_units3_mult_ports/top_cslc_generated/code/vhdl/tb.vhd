        --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : tb.vhd
--FILE GENERATED ON : Wed Jun  9 19:34:52 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity tb is 

-- Location of source csl unit: file name = multiple_units3.csl line number = 68
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
         
                                                                                                                                                                                                                                                                                                                                      
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
              if (  ) then begin 
                 :=                  :=                 (, , , , )              end
            end
          end
end tb ; 

 architecture  arch_tb of tb is 
             component stim_expect_mem_template
             port ( 
                clock : in   csl_bit_vector(0 downto 0);
                reset_ : in   csl_bit_vector(0 downto 0);
                rd_en : in   csl_bit_vector(0 downto 0);
                vector_out : out   csl_bit_vector(1 downto 0);
                valid : out   csl_bit_vector(0 downto 0);
                version_err : out   csl_bit_vector(0 downto 0);
                id_err : out   csl_bit_vector(0 downto 0) 
 );
            end component; 


                signal expect_out_valid : csl_bit_vector(0 downto 0);
                signal rd_en : csl_bit_vector(0 downto 0);
                signal version_err : csl_bit_vector(0 downto 0);
                signal id_err : csl_bit_vector(0 downto 0);
                signal stop_sim : csl_bit_vector(0 downto 0);
                signal top0_in_in1 : csl_bit_vector(2 downto 0);
                signal top0_in_in2 : csl_bit_vector(0 downto 0);
                signal top0_in_in3 : csl_bit_vector(5 downto 0);
                signal top0_out_out1 : csl_bit_vector(2 downto 0);
                signal top0_out_out1_expect : csl_bit_vector(2 downto 0);
                signal top0_out_out2 : csl_bit_vector(2 downto 0);
                signal top0_out_out2_expect : csl_bit_vector(2 downto 0);
                signal top0_out_out1_mismatch_en : csl_bit_vector(0 downto 0);
                signal top0_out_out2_mismatch_en : csl_bit_vector(0 downto 0);
                signal top0_out_out1_match_en : csl_bit_vector(0 downto 0);
                signal top0_out_out2_match_en : csl_bit_vector(0 downto 0);

 begin
            rd_en <= rand_valid;
            
top0 : top generic map ( ADDR_WIDTH <= ) ADDR_WIDTH <= ) 
             port map ( 
                            clk =>(clk),
                            in1 =>(top0_in_in1),
                            in2 =>(top0_in_in2),
                            in3 =>(top0_in_in3),
                            out1 =>(top0_out_out1),
                            out2 =>(top0_out_out2)

                        );
            
stim_top0 : stim_expect_mem_template generic map ( ADDR_WIDTH <= ) ADDR_WIDTH <= ) 
             port map ( 
                            clock =>(clk),
                            id_err =>(id_err),
                            rd_en =>(rd_en),
                            reset_ =>(testbench_reset),
                            valid =>(expect_out_valid),
                            vector_out =>(),
                            version_err =>(version_err)

                        );
            
exp_top0 : stim_expect_mem_template generic map ( ADDR_WIDTH <= ) ADDR_WIDTH <= ) 
             port map ( 
                            clock =>(clk),
                            id_err =>(id_err),
                            rd_en =>(rd_en),
                            reset_ =>(testbench_reset),
                            valid =>(expect_out_valid),
                            vector_out =>(),
                            version_err =>(version_err)

                        );
        end process; 
 end  arch_tb ; 
