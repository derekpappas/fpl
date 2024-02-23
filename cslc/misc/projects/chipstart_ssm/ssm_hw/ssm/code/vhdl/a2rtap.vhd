  --THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : a2rtap.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity a2rtap is 

 port ( -- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 128
  
        a2rtap_master_ifc_read_data  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_ready  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_error  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_grant  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_request  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_in  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_aphi  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_write  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_read  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_ready  : in csl_bit_vector (1 - 1 downto 0)  ;
        ring_out_ifc_error  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_slave_out_ifc_read_data  : in csl_bit_vector (32 - 1 downto 0)  ;
        a2rtap_slave_out_ifc_ready  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_slave_out_ifc_error  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_slave_out_ifc_address  : in csl_bit_vector (20 - 1 downto 0)  ;
        a2rtap_slave_out_ifc_data  : in csl_bit_vector (32 - 1 downto 0)  ;
        a2rtap_slave_out_ifc_read  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_slave_out_ifc_write  : in csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_address  : out csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_write_data  : out csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_read  : out csl_bit_vector (1 - 1 downto 0)  ;
        a2rtap_master_ifc_write  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_grant  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_request  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_in  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_aphi  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_write  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_read  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_ready  : out csl_bit_vector (1 - 1 downto 0)  ;
        ring_in_ifc_error  : out csl_bit_vector (1 - 1 downto 0)
 );
end a2rtap ; 

 architecture  arch_a2rtap of a2rtap is 

 begin 

 end  arch_a2rtap ; 
