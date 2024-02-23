--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : ssm.vhd
--FILE GENERATED ON : Sat May  1 19:39:32 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity ssm is 

 port ( -- Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 97

gbl_clk: in csl_bit_vector (1 - 1 downto 0);
gbl_reset_: in csl_bit_vector (1 - 1 downto 0);
gbl_enable: in csl_bit_vector (1 - 1 downto 0)
 );
end ssm ; 

 architecture  arch_ssm of ssm is 
 component h264
 port ( 
 );
end component; 


signal master_a2p_arm_address : csl_bit_vector(0 downto 0);
signal master_a2p_arm_write_data : csl_bit_vector(0 downto 0);
signal master_a2p_arm_read : csl_bit_vector(0 downto 0);
signal master_a2p_arm_write : csl_bit_vector(0 downto 0);
signal master_a2p_arm_read_data : csl_bit_vector(0 downto 0);
signal master_a2p_arm_ready : csl_bit_vector(0 downto 0);
signal master_a2p_arm_error : csl_bit_vector(0 downto 0);
signal master_dummy1_address : csl_bit_vector(0 downto 0);
signal master_dummy1_write_data : csl_bit_vector(0 downto 0);
signal master_dummy1_read : csl_bit_vector(0 downto 0);
signal master_dummy1_write : csl_bit_vector(0 downto 0);
signal master_dummy1_read_data : csl_bit_vector(0 downto 0);
signal master_dummy1_ready : csl_bit_vector(0 downto 0);
signal master_dummy1_error : csl_bit_vector(0 downto 0);
signal master_dummy2_address : csl_bit_vector(0 downto 0);
signal master_dummy2_write_data : csl_bit_vector(0 downto 0);
signal master_dummy2_read : csl_bit_vector(0 downto 0);
signal master_dummy2_write : csl_bit_vector(0 downto 0);
signal master_dummy2_read_data : csl_bit_vector(0 downto 0);
signal master_dummy2_ready : csl_bit_vector(0 downto 0);
signal master_dummy2_error : csl_bit_vector(0 downto 0);
signal master_dummy3_address : csl_bit_vector(0 downto 0);
signal master_dummy3_write_data : csl_bit_vector(0 downto 0);
signal master_dummy3_read : csl_bit_vector(0 downto 0);
signal master_dummy3_write : csl_bit_vector(0 downto 0);
signal master_dummy3_read_data : csl_bit_vector(0 downto 0);
signal master_dummy3_ready : csl_bit_vector(0 downto 0);
signal master_dummy3_error : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_grant : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_request : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_in : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_aphi : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_write : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_read : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_ready : csl_bit_vector(0 downto 0);
signal ring_arm_dsp_error : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_grant : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_request : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_in : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_aphi : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_write : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_read : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_ready : csl_bit_vector(0 downto 0);
signal ring_dsp_h264_error : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_grant : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_request : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_in : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_aphi : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_write : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_read : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_ready : csl_bit_vector(0 downto 0);
signal ring_h264_cmpr_error : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_grant : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_request : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_in : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_aphi : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_write : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_read : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_ready : csl_bit_vector(0 downto 0);
signal ring_cmpr_arm_error : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_arm_read_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_arm_ready : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_arm_error : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_arm_address : csl_bit_vector(19 downto 0);
signal slave_Va2r_tap_arm_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_arm_read : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_arm_write : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_dsp_read_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_dsp_ready : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_dsp_error : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_dsp_address : csl_bit_vector(19 downto 0);
signal slave_Va2r_tap_dsp_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_dsp_read : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_dsp_write : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_h264_read_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_h264_ready : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_h264_error : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_h264_address : csl_bit_vector(19 downto 0);
signal slave_Va2r_tap_h264_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_h264_read : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_h264_write : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_cmpr_read_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_cmpr_ready : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_cmpr_error : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_cmpr_address : csl_bit_vector(19 downto 0);
signal slave_Va2r_tap_cmpr_data : csl_bit_vector(31 downto 0);
signal slave_Va2r_tap_cmpr_read : csl_bit_vector(0 downto 0);
signal slave_Va2r_tap_cmpr_write : csl_bit_vector(0 downto 0);

 begin

arm : arm port map ( 
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
slave_Va2r_tap_arm_address =>(slave_Va2r_tap_arm_address),
slave_Va2r_tap_arm_data =>(slave_Va2r_tap_arm_data),
slave_Va2r_tap_arm_error =>(slave_Va2r_tap_arm_error),
slave_Va2r_tap_arm_read =>(slave_Va2r_tap_arm_read),
slave_Va2r_tap_arm_read_data =>(slave_Va2r_tap_arm_read_data),
slave_Va2r_tap_arm_ready =>(slave_Va2r_tap_arm_ready),
slave_Va2r_tap_arm_write =>(slave_Va2r_tap_arm_write)

);

dumb : dummy_unit_synth_removes port map ( 
dummy1_master_ifc_address =>(master_dummy1_address),
dummy1_master_ifc_error =>(master_dummy1_error),
dummy1_master_ifc_read =>(master_dummy1_read),
dummy1_master_ifc_read_data =>(master_dummy1_read_data),
dummy1_master_ifc_ready =>(master_dummy1_ready),
dummy1_master_ifc_write =>(master_dummy1_write),
dummy1_master_ifc_write_data =>(master_dummy1_write_data),
dummy2_master_ifc_address =>(master_dummy2_address),
dummy2_master_ifc_error =>(master_dummy2_error),
dummy2_master_ifc_read =>(master_dummy2_read),
dummy2_master_ifc_read_data =>(master_dummy2_read_data),
dummy2_master_ifc_ready =>(master_dummy2_ready),
dummy2_master_ifc_write =>(master_dummy2_write),
dummy2_master_ifc_write_data =>(master_dummy2_write_data),
dummy3_master_ifc_address =>(master_dummy3_address),
dummy3_master_ifc_error =>(master_dummy3_error),
dummy3_master_ifc_read =>(master_dummy3_read),
dummy3_master_ifc_read_data =>(master_dummy3_read_data),
dummy3_master_ifc_ready =>(master_dummy3_ready),
dummy3_master_ifc_write =>(master_dummy3_write),
dummy3_master_ifc_write_data =>(master_dummy3_write_data)

);

Va2r_tap_arm : Va2r_tap port map ( 
Va2r_tap_master_ifc_address =>(master_a2p_arm_address),
Va2r_tap_master_ifc_error =>(master_a2p_arm_error),
Va2r_tap_master_ifc_read =>(master_a2p_arm_read),
Va2r_tap_master_ifc_read_data =>(master_a2p_arm_read_data),
Va2r_tap_master_ifc_ready =>(master_a2p_arm_ready),
Va2r_tap_master_ifc_write =>(master_a2p_arm_write),
Va2r_tap_master_ifc_write_data =>(master_a2p_arm_write_data),
Va2r_tap_slave_out_ifc_address =>(slave_Va2r_tap_arm_address),
Va2r_tap_slave_out_ifc_data =>(slave_Va2r_tap_arm_data),
Va2r_tap_slave_out_ifc_error =>(slave_Va2r_tap_arm_error),
Va2r_tap_slave_out_ifc_read =>(slave_Va2r_tap_arm_read),
Va2r_tap_slave_out_ifc_read_data =>(slave_Va2r_tap_arm_read_data),
Va2r_tap_slave_out_ifc_ready =>(slave_Va2r_tap_arm_ready),
Va2r_tap_slave_out_ifc_write =>(slave_Va2r_tap_arm_write),
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
ring_in_ifc_aphi =>(ring_cmpr_arm_aphi),
ring_in_ifc_error =>(ring_cmpr_arm_error),
ring_in_ifc_grant =>(ring_cmpr_arm_grant),
ring_in_ifc_in =>(ring_cmpr_arm_in),
ring_in_ifc_read =>(ring_cmpr_arm_read),
ring_in_ifc_ready =>(ring_cmpr_arm_ready),
ring_in_ifc_request =>(ring_cmpr_arm_request),
ring_in_ifc_write =>(ring_cmpr_arm_write),
ring_out_ifc_aphi =>(ring_arm_dsp_aphi),
ring_out_ifc_error =>(ring_arm_dsp_error),
ring_out_ifc_grant =>(ring_arm_dsp_grant),
ring_out_ifc_in =>(ring_arm_dsp_in),
ring_out_ifc_read =>(ring_arm_dsp_read),
ring_out_ifc_ready =>(ring_arm_dsp_ready),
ring_out_ifc_request =>(ring_arm_dsp_request),
ring_out_ifc_write =>(ring_arm_dsp_write)

);

dsp : dsp port map ( 
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
slave_Va2r_tap_dsp_address =>(slave_Va2r_tap_dsp_address),
slave_Va2r_tap_dsp_data =>(slave_Va2r_tap_dsp_data),
slave_Va2r_tap_dsp_error =>(slave_Va2r_tap_dsp_error),
slave_Va2r_tap_dsp_read =>(slave_Va2r_tap_dsp_read),
slave_Va2r_tap_dsp_read_data =>(slave_Va2r_tap_dsp_read_data),
slave_Va2r_tap_dsp_ready =>(slave_Va2r_tap_dsp_ready),
slave_Va2r_tap_dsp_write =>(slave_Va2r_tap_dsp_write)

);

Va2r_tap_cmpr : Va2r_tap port map ( 
Va2r_tap_master_ifc_address =>(master_dummy3_address),
Va2r_tap_master_ifc_error =>(master_dummy3_error),
Va2r_tap_master_ifc_read =>(master_dummy3_read),
Va2r_tap_master_ifc_read_data =>(master_dummy3_read_data),
Va2r_tap_master_ifc_ready =>(master_dummy3_ready),
Va2r_tap_master_ifc_write =>(master_dummy3_write),
Va2r_tap_master_ifc_write_data =>(master_dummy3_write_data),
Va2r_tap_slave_out_ifc_address =>(slave_Va2r_tap_cmpr_address),
Va2r_tap_slave_out_ifc_data =>(slave_Va2r_tap_cmpr_data),
Va2r_tap_slave_out_ifc_error =>(slave_Va2r_tap_cmpr_error),
Va2r_tap_slave_out_ifc_read =>(slave_Va2r_tap_cmpr_read),
Va2r_tap_slave_out_ifc_read_data =>(slave_Va2r_tap_cmpr_read_data),
Va2r_tap_slave_out_ifc_ready =>(slave_Va2r_tap_cmpr_ready),
Va2r_tap_slave_out_ifc_write =>(slave_Va2r_tap_cmpr_write),
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
ring_in_ifc_aphi =>(ring_h264_cmpr_aphi),
ring_in_ifc_error =>(ring_h264_cmpr_error),
ring_in_ifc_grant =>(ring_h264_cmpr_grant),
ring_in_ifc_in =>(ring_h264_cmpr_in),
ring_in_ifc_read =>(ring_h264_cmpr_read),
ring_in_ifc_ready =>(ring_h264_cmpr_ready),
ring_in_ifc_request =>(ring_h264_cmpr_request),
ring_in_ifc_write =>(ring_h264_cmpr_write),
ring_out_ifc_aphi =>(ring_cmpr_arm_aphi),
ring_out_ifc_error =>(ring_cmpr_arm_error),
ring_out_ifc_grant =>(ring_cmpr_arm_grant),
ring_out_ifc_in =>(ring_cmpr_arm_in),
ring_out_ifc_read =>(ring_cmpr_arm_read),
ring_out_ifc_ready =>(ring_cmpr_arm_ready),
ring_out_ifc_request =>(ring_cmpr_arm_request),
ring_out_ifc_write =>(ring_cmpr_arm_write)

);

cmpr : cmpr port map ( 
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
slave_Va2r_tap_cmpr_address =>(slave_Va2r_tap_cmpr_address),
slave_Va2r_tap_cmpr_data =>(slave_Va2r_tap_cmpr_data),
slave_Va2r_tap_cmpr_error =>(slave_Va2r_tap_cmpr_error),
slave_Va2r_tap_cmpr_read =>(slave_Va2r_tap_cmpr_read),
slave_Va2r_tap_cmpr_read_data =>(slave_Va2r_tap_cmpr_read_data),
slave_Va2r_tap_cmpr_ready =>(slave_Va2r_tap_cmpr_ready),
slave_Va2r_tap_cmpr_write =>(slave_Va2r_tap_cmpr_write)

);

Va2r_tap_dsp : Va2r_tap port map ( 
Va2r_tap_master_ifc_address =>(master_dummy1_address),
Va2r_tap_master_ifc_error =>(master_dummy1_error),
Va2r_tap_master_ifc_read =>(master_dummy1_read),
Va2r_tap_master_ifc_read_data =>(master_dummy1_read_data),
Va2r_tap_master_ifc_ready =>(master_dummy1_ready),
Va2r_tap_master_ifc_write =>(master_dummy1_write),
Va2r_tap_master_ifc_write_data =>(master_dummy1_write_data),
Va2r_tap_slave_out_ifc_address =>(slave_Va2r_tap_dsp_address),
Va2r_tap_slave_out_ifc_data =>(slave_Va2r_tap_dsp_data),
Va2r_tap_slave_out_ifc_error =>(slave_Va2r_tap_dsp_error),
Va2r_tap_slave_out_ifc_read =>(slave_Va2r_tap_dsp_read),
Va2r_tap_slave_out_ifc_read_data =>(slave_Va2r_tap_dsp_read_data),
Va2r_tap_slave_out_ifc_ready =>(slave_Va2r_tap_dsp_ready),
Va2r_tap_slave_out_ifc_write =>(slave_Va2r_tap_dsp_write),
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
ring_in_ifc_aphi =>(ring_arm_dsp_aphi),
ring_in_ifc_error =>(ring_arm_dsp_error),
ring_in_ifc_grant =>(ring_arm_dsp_grant),
ring_in_ifc_in =>(ring_arm_dsp_in),
ring_in_ifc_read =>(ring_arm_dsp_read),
ring_in_ifc_ready =>(ring_arm_dsp_ready),
ring_in_ifc_request =>(ring_arm_dsp_request),
ring_in_ifc_write =>(ring_arm_dsp_write),
ring_out_ifc_aphi =>(ring_dsp_h264_aphi),
ring_out_ifc_error =>(ring_dsp_h264_error),
ring_out_ifc_grant =>(ring_dsp_h264_grant),
ring_out_ifc_in =>(ring_dsp_h264_in),
ring_out_ifc_read =>(ring_dsp_h264_read),
ring_out_ifc_ready =>(ring_dsp_h264_ready),
ring_out_ifc_request =>(ring_dsp_h264_request),
ring_out_ifc_write =>(ring_dsp_h264_write)

);

Va2r_tap_h264 : Va2r_tap port map ( 
Va2r_tap_master_ifc_address =>(master_dummy2_address),
Va2r_tap_master_ifc_error =>(master_dummy2_error),
Va2r_tap_master_ifc_read =>(master_dummy2_read),
Va2r_tap_master_ifc_read_data =>(master_dummy2_read_data),
Va2r_tap_master_ifc_ready =>(master_dummy2_ready),
Va2r_tap_master_ifc_write =>(master_dummy2_write),
Va2r_tap_master_ifc_write_data =>(master_dummy2_write_data),
Va2r_tap_slave_out_ifc_address =>(slave_Va2r_tap_h264_address),
Va2r_tap_slave_out_ifc_data =>(slave_Va2r_tap_h264_data),
Va2r_tap_slave_out_ifc_error =>(slave_Va2r_tap_h264_error),
Va2r_tap_slave_out_ifc_read =>(slave_Va2r_tap_h264_read),
Va2r_tap_slave_out_ifc_read_data =>(slave_Va2r_tap_h264_read_data),
Va2r_tap_slave_out_ifc_ready =>(slave_Va2r_tap_h264_ready),
Va2r_tap_slave_out_ifc_write =>(slave_Va2r_tap_h264_write),
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
ring_in_ifc_aphi =>(ring_dsp_h264_aphi),
ring_in_ifc_error =>(ring_dsp_h264_error),
ring_in_ifc_grant =>(ring_dsp_h264_grant),
ring_in_ifc_in =>(ring_dsp_h264_in),
ring_in_ifc_read =>(ring_dsp_h264_read),
ring_in_ifc_ready =>(ring_dsp_h264_ready),
ring_in_ifc_request =>(ring_dsp_h264_request),
ring_in_ifc_write =>(ring_dsp_h264_write),
ring_out_ifc_aphi =>(ring_h264_cmpr_aphi),
ring_out_ifc_error =>(ring_h264_cmpr_error),
ring_out_ifc_grant =>(ring_h264_cmpr_grant),
ring_out_ifc_in =>(ring_h264_cmpr_in),
ring_out_ifc_read =>(ring_h264_cmpr_read),
ring_out_ifc_ready =>(ring_h264_cmpr_ready),
ring_out_ifc_request =>(ring_h264_cmpr_request),
ring_out_ifc_write =>(ring_h264_cmpr_write)

);

ssm_master : ssm_master port map ( 
Va2r_tap_master_ifc_address =>(master_a2p_arm_address),
Va2r_tap_master_ifc_error =>(master_a2p_arm_error),
Va2r_tap_master_ifc_read =>(master_a2p_arm_read),
Va2r_tap_master_ifc_read_data =>(master_a2p_arm_read_data),
Va2r_tap_master_ifc_ready =>(master_a2p_arm_ready),
Va2r_tap_master_ifc_write =>(master_a2p_arm_write),
Va2r_tap_master_ifc_write_data =>(master_a2p_arm_write_data),
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_)

);

h264 : h264 port map ( 
gbl_clk =>(gbl_clk),
gbl_enable =>(gbl_enable),
gbl_reset_ =>(gbl_reset_),
slave_Va2r_tap_h264_address =>(slave_Va2r_tap_h264_address),
slave_Va2r_tap_h264_data =>(slave_Va2r_tap_h264_data),
slave_Va2r_tap_h264_error =>(slave_Va2r_tap_h264_error),
slave_Va2r_tap_h264_read =>(slave_Va2r_tap_h264_read),
slave_Va2r_tap_h264_read_data =>(slave_Va2r_tap_h264_read_data),
slave_Va2r_tap_h264_ready =>(slave_Va2r_tap_h264_ready),
slave_Va2r_tap_h264_write =>(slave_Va2r_tap_h264_write)

);

 end  arch_ssm ; 
