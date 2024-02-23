            --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : tb.vhd
--FILE GENERATED ON : Sun Mar  7 15:39:23 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity tb is 

-- Location of source csl unit: file name = 2.csl line number = 35
            generic ( 
                  SIM_TIMEOUT_CNT;
            generic ( ;
                  STIM_MEM_WIDTH;
            generic ( ;
                  STIM_ADDR_WIDTH;
            generic ( ;
                  STIM_VECTOR_ID;
            generic ( ;
                  STIM_VECTOR_VERSION;
            generic ( ;
                  STIM_VECTOR_NAME"stim";
            generic ( ;
                  STIM_VECTOR_FILE"stim_output.vec";
            generic ( ;
                  STIM_VECTOR_RADIX;
            generic ( ;
                  STIM_VECTOR_MAX_ERR;
            generic ( ;
                  EXP_MEM_WIDTH;
            generic ( ;
                  EXP_ADDR_WIDTH;
            generic ( ;
                  EXP_VECTOR_ID;
            generic ( ;
                  EXP_VECTOR_VERSION;
            generic ( ;
                  EXP_VECTOR_NAME"exp";
            generic ( ;
                  EXP_VECTOR_FILE"exp_output.vec";
            generic ( ;
                  EXP_VECTOR_RADIX;
            generic ( ;
                  EXP_VECTOR_MAX_ERR;
;
                  clk             : csl_bit_vector ;
;
                  testbench_reset             : csl_bit_vector ;
;
                  rand_valid             : csl_bit_vector ;
;
                  file_mcd             : csl_integer ;
;
                  report_file_mcd             : csl_integer ;
;
                  cycle_cnt             : csl_integer ;
;
                  exp_b0_match_count             : csl_bit_vector ;
;
                  exp_b0_mismatch_count             : csl_bit_vector ;
;
                  exp_b0_transaction_count             : csl_bit_vector ;
;
                  exp_b0_mismatch             : csl_bit_vector ;
                                                                                                                                                                              generic map (              generic map (
              process  wait until  or  wait until  begin 
                if ( ~() ) then begin 
                   <= ;
                end
                 else  begin 
                   <= ;
                end
              end

              initial 
 begin 
                ("time stamp: +20%y %m %d");
                 := ;
                 := ;
                 := ;
                 wait for  := ;
                 wait for  := ;
                 := ("vectors.txt");
                if (  ) then begin 
                  ("Error opening vectors.txt file");
                  ;
                end
                (, "Dut outputs vs expected vectors:\n");
                ("wavesDefaultOutputFile_dump");
                (, );
                ;
                 := ;
                 := ;
                 := ;
              end

              process  wait for  := ~();

              process  wait until  or  wait until  begin 
                if ( ~() ) then begin 
                   :=     ;
                end
                 else  begin 
                  if (  ) then begin 
                     := ;
                     := ;
                    ("mismatch detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", , "exp_b0", );
                  end
                  if (  ) then begin 
                    ("Maximum number or errors allowed for vector %s has been reached", "exp_b0");
                  end
                end
              end

              process  wait until  or  wait until  begin 
                if ( ~() ) then begin 
                   :=     ;
                end
                 else  begin 
                  if (  ) then begin 
                     := ;
                     := ;
                    ("match detected: dut %s shows value %b; evepect vector %s shows value %b\n ", "b0", , "exp_b0", );
                  end
                end
              end
end tb ; 

 architecture  arch_tb of tb is 
                 component stim_expect_mem_template
                 port ( 
                    clock : in   csl_bit_vector
                    reset_ : in   csl_bit_vector
                    rd_en : in   csl_bit_vector
                    vector_out : out   csl_bit_vector
                    valid : out   csl_bit_vector
                    version_err : out   csl_bit_vector
                    id_err : out   csl_bit_vector
 );
                end component; 


                    signal expect_out_valid : csl_bit_vector(-1073741821 downto -1073741821);
                    signal rd_en : csl_bit_vector(0 downto 0);
                    signal version_err : csl_bit_vector(0 downto 0);
                    signal id_err : csl_bit_vector(-1073741821 downto -1066133141);
                    signal stop_sim : csl_bit_vector(1 downto 0);
                    signal b0_in_in : csl_bit_vector(-1073741821 downto -1066133141);
                    signal b0_out_out : csl_bit_vector(-1073741821 downto -1066133141);
                    signal b0_out_out_expect : csl_bit_vector(-1073741821 downto -1066133141);
                    signal b0_out_out_mismatch_en : csl_bit_vector(1 downto 0);
                    signal b0_out_out_match_en : csl_bit_vector(1 downto 0);

 begin

                            rd_en <= rand_valid;EXP_ADDR_WIDTHEXP_ADDR_WIDTHEXP_ADDR_WIDTHcycle_cnt >= SIM_TIMEOUT_CNTb0_out_out != b0_out_out_expectb0_out_out == b0_out_out_expecttestbench_resetcycle_cnt + file_mcd == clktestbench_resetexp_b0_transaction_count + exp_b0_mismatch_count + exp_b0_mismatch_count > EXP_VECTOR_MAX_ERRtestbench_resetexp_b0_transaction_count + exp_b0_match_count + ;
                
b0 : b port map ( 
                                clk =>(clk),
                                in =>(b0_in_in),
                                out =>(b0_out_out)

                            );

                            rd_en <= rand_valid;EXP_ADDR_WIDTHEXP_ADDR_WIDTHEXP_ADDR_WIDTHcycle_cnt >= SIM_TIMEOUT_CNTb0_out_out != b0_out_out_expectb0_out_out == b0_out_out_expecttestbench_resetcycle_cnt + file_mcd == clktestbench_resetexp_b0_transaction_count + exp_b0_mismatch_count + exp_b0_mismatch_count > EXP_VECTOR_MAX_ERRtestbench_resetexp_b0_transaction_count + exp_b0_match_count + ;
                
stim_b0 : stim_expect_mem_template port map ( 
                                clock =>(clk),
                                id_err =>(id_err),
                                rd_en =>(rd_en),
                                reset_ =>(testbench_reset),
                                valid =>(expect_out_valid),
                                vector_out =>(b0_in_in),
                                version_err =>(version_err)

                            );

                            rd_en <= rand_valid;EXP_ADDR_WIDTHEXP_ADDR_WIDTHEXP_ADDR_WIDTHcycle_cnt >= SIM_TIMEOUT_CNTb0_out_out != b0_out_out_expectb0_out_out == b0_out_out_expecttestbench_resetcycle_cnt + file_mcd == clktestbench_resetexp_b0_transaction_count + exp_b0_mismatch_count + exp_b0_mismatch_count > EXP_VECTOR_MAX_ERRtestbench_resetexp_b0_transaction_count + exp_b0_match_count + ;
                
exp_b0 : stim_expect_mem_template port map ( 
                                clock =>(clk),
                                id_err =>(id_err),
                                rd_en =>(rd_en),
                                reset_ =>(testbench_reset),
                                valid =>(expect_out_valid),
                                vector_out =>(b0_out_out_expect),
                                version_err =>(version_err)

                            );

 end  arch_tb ; 
