--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : stim_expect_mem_template.vhd
--FILE GENERATED ON : Thu Jun 10 02:45:25 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity stim_expect_mem_template is 

generic ( MEM_WIDTH: csl_integer := 0; ADDR_WIDTH : csl_integer := 0; VECTOR_ID : csl_integer := 0; VECTOR_VERSION : csl_integer := 0; VECTOR_NAME: csl_string := ""; VECTOR_FILE: csl_string := ""; VECTOR_RADIX : csl_integer := 0; MEM_DEPTH: csl_integer :=  );

 port ( -- Location of source csl unit: file name = multiple_units2.csl line number = 46
 
 
 
 
 
 
 
 

clock: in csl_bit_vector (0 downto 0);
reset_: in csl_bit_vector (0 downto 0);
rd_en: in csl_bit_vector (0 downto 0);
vector_out: out csl_bit_vector (1 downto 0);
valid: out csl_bit_vector (0 downto 0);
version_err: out csl_bit_vector (0 downto 0);
id_err: out csl_bit_vector (0 downto 0)~( ?     :                                                   ~(
          process  wait until  or  wait until  begin 
            if ( ~( ) then begin 
               <=                end
             else if (  ) then begin 
                 <=                  <=                  <=               end
          end

          process  wait until  or  wait until  begin 
            if (  ) then begin 
               <= ]            end
          end

          initial 
 begin 
             <=             (, )            if (  ) then begin 
              (, )            end
             else  begin 
              (, )            end
             <=           end

          initial 
 begin 
                        ;
            if (  ) then begin 
              (, )
              for (                 ; ;                 )  begin 
                (, , ])              end
            end
          end

 );
end stim_expect_mem_template ; 

 architecture  arch_stim_expect_mem_template of stim_expect_mem_template is 

                in : in   csl_bit_vector(2 downto 0);
                clk : in   csl_bit_vector(0 downto 0);
                out1 : out   csl_bit_vector(2 downto 0);
                out2 : out   csl_bit_vector(2 downto 0) 
                signal mem_out_is_id_or_version : csl_bit_vector(-1468745280 downto 54);
                signal mux_select : csl_bit_vector(0 downto 0);
                signal vector_id_match : csl_bit_vector(-1468745280 downto 54);
                signal vector_version_match : csl_bit_vector(-1468745280 downto 54);
 begin 
          process 
             variable memory_out : csl_bit_vector (1 downto 0) ;
             variable stim_expect_memory : csl_bit_vector (1 downto 0) ;
             variable rd_addr : csl_bit_vector (1 downto 0) ;
             variable mem_out_is_id : csl_bit_vector (-1468745280 downto 54) ;
             variable mem_out_is_version : csl_bit_vector (-1468745280 downto 54) ;
             variable mem_addr : csl_integer  ;
             variable stim_expect_memory_loaded : csl_bit_vector (-1468745280 downto 54) ;
          begin 
            mem_out_is_id_or_version <= mem_out_is_id || mem_out_is_version;
            mux_select <= rd_en || mem_out_is_id_or_version;
            vector_out <= mux_selectmemory_out;
            vector_id_match <= memory_out == VECTOR_ID and mem_out_is_id;
            vector_version_match <= memory_out == VECTOR_VERSION and mem_out_is_version;
            version_err <= mem_out_is_version and memory_out != VECTOR_VERSION;
            id_err <= mem_out_is_id and memory_out != VECTOR_ID;
            valid <= rd_en && mem_out_is_id_or_versionreset_rd_addr + rd_addr == rd_addr == VECTOR_RADIX == ;
            mem_addr <= mem_addr < MEM_DEPTH;
            mem_addr <= mem_addr + ;
        end process; 
 end  arch_stim_expect_mem_template ; 
