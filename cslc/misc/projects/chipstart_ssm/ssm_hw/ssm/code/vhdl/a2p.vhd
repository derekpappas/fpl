  --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : a2p.vhd
--FILE GENERATED ON : Thu Mar 11 16:33:56 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity a2p is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 89
  
        a2rtap_master_ifc_address  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_write_data  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_read  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_write  : in csl_bit_vector (1 - 1 downto 0)  ;
        gbl_clock  : in csl_bit_vector (1 - 1 downto 0)  ;
        gbl_reset  : in csl_bit_vector (1 - 1 downto 0)  ;
        gbl_a2rtap_pipe_en  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_read_data  : out csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_ready  : out csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_error  : out csl_bit_vector (1 - 1 downto 0)
 );
end a2p ; 

 architecture  arch_a2p of a2p is 

 begin 

 end  arch_a2p ; 
