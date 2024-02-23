--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : stim_expect_mem_template.vhd
--FILE GENERATED ON : Sun Mar  7 15:39:23 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity stim_expect_mem_template is 

 port ( -- Location of source csl unit: file name = 2.csl line number = 21
generic ( 
    MEM_WIDTH;
generic ( ;
    ADDR_WIDTH;
generic ( ;
    VECTOR_ID;
generic ( ;
    VECTOR_VERSION;
generic ( ;
    VECTOR_NAME"";
generic ( ;
    VECTOR_FILE"";
generic ( ;
    VECTOR_RADIX;
generic ( ;
    MEM_DEPTH(()"1");
;
    clock: in csl_bit_vector (0 downto 0);
    reset_: in csl_bit_vector (0 downto 0);
    rd_en: in csl_bit_vector (0 downto 0);
    vector_out: out csl_bit_vector (0 downto 0);
    valid: out csl_bit_vector (0 downto 0);
    version_err: out csl_bit_vector (0 downto 0);
    id_err: out csl_bit_vector (0 downto 0);
    memory_out : csl_bit_vector ;
;
    stim_expect_memory : csl_bit_vector ;
;
    rd_addr : csl_bit_vector ;
;
    mem_out_is_id : csl_bit_vector ;
;
    mem_out_is_version : csl_bit_vector ;
;
    mem_addr : csl_integer ;
;
    stim_expect_memory_loaded : csl_bit_vector ;
  ~()       ?      :           ()              ()                                                                  ~()
              process  wait until  or  wait until  begin 
                if ( ~() ) then begin 
                   <=     ;
                end
                 else if (  ) then begin 
                     <= ;
                     <= ;
                     <= ;
                  end
              end

              process  wait until  or  wait until  begin 
                if (  ) then begin 
                   <= [];
                end
              end

              initial 
 begin 
                 <= ;
                ("VECTOR_FILE= %s", );
                if (  ) then begin 
                  (, );
                end
                 else  begin 
                  (, );
                end
                 <= ;
              end

              initial 
 begin 
                                ;
                if (  ) then begin 
                  ("Initial state of vector file %s ", );

                  for (                     ; ;                     )  begin 
                    ("mem[%d] = %x", , []);
                  end
                end
              end

 );
end stim_expect_mem_template ; 

 architecture  arch_stim_expect_mem_template of stim_expect_mem_template is 

                    in : in   csl_bit_vector
                    clk : in   csl_bit_vector
                    out : out   csl_bit_vector
                    signal mem_out_is_id_or_version : csl_bit_vector(0 downto 0);
                    signal mux_select : csl_bit_vector(0 downto 0);
                    signal vector_id_match : csl_bit_vector(0 downto 0);
                    signal vector_version_match : csl_bit_vector(0 downto 0);
 begin 

            process( mux_select,vector_id_match,version_err,valid,mem_addr)
 +     begin
                mem_out_is_id_or_version <= mux_select;
                vector_out <=                 vector_version_match <=                 id_err <=                 mem_addr <=  << mem_out_is_id || mem_out_is_versionrd_en || mem_out_is_id_or_versionmux_selectmemory_outmemory_out == VECTOR_ID and mem_out_is_idmemory_out == VECTOR_VERSION and mem_out_is_versionmem_out_is_version and memory_out != VECTOR_VERSIONmem_out_is_id and memory_out != VECTOR_IDrd_en && mem_out_is_id_or_versionreset_rd_addr + rd_addr == rd_addr == VECTOR_RADIX == mem_addr < MEM_DEPTHmem_addr + 
    end process;

 end  arch_stim_expect_mem_template ; 
