--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : ssm_demo.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity ssm_demo is 

-- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 140
end ssm_demo ; 

 architecture  arch_ssm_demo of ssm_demo is 
 component mcb
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
signal slave_taparm_mbc_read_data : csl_bit_vector(31 downto 0);
signal slave_taparm_mbc_ready : csl_bit_vector(0 downto 0);
signal slave_taparm_mbc_error : csl_bit_vector(0 downto 0);
signal slave_taparm_mbc_address : csl_bit_vector(19 downto 0);
signal slave_taparm_mbc_data : csl_bit_vector(31 downto 0);
signal slave_taparm_mbc_read : csl_bit_vector(0 downto 0);
signal slave_taparm_mbc_write : csl_bit_vector(0 downto 0);
signal slave_tapdsp_mbc_read_data : csl_bit_vector(31 downto 0);
signal slave_tapdsp_mbc_ready : csl_bit_vector(0 downto 0);
signal slave_tapdsp_mbc_error : csl_bit_vector(0 downto 0);
signal slave_tapdsp_mbc_address : csl_bit_vector(19 downto 0);
signal slave_tapdsp_mbc_data : csl_bit_vector(31 downto 0);
signal slave_tapdsp_mbc_read : csl_bit_vector(0 downto 0);
signal slave_tapdsp_mbc_write : csl_bit_vector(0 downto 0);
signal slave_taph264_mbc_read_data : csl_bit_vector(31 downto 0);
signal slave_taph264_mbc_ready : csl_bit_vector(0 downto 0);
signal slave_taph264_mbc_error : csl_bit_vector(0 downto 0);
signal slave_taph264_mbc_address : csl_bit_vector(19 downto 0);
signal slave_taph264_mbc_data : csl_bit_vector(31 downto 0);
signal slave_taph264_mbc_read : csl_bit_vector(0 downto 0);
signal slave_taph264_mbc_write : csl_bit_vector(0 downto 0);
signal slave_tapcmpr_mbc_read_data : csl_bit_vector(31 downto 0);
signal slave_tapcmpr_mbc_ready : csl_bit_vector(0 downto 0);
signal slave_tapcmpr_mbc_error : csl_bit_vector(0 downto 0);
signal slave_tapcmpr_mbc_address : csl_bit_vector(19 downto 0);
signal slave_tapcmpr_mbc_data : csl_bit_vector(31 downto 0);
signal slave_tapcmpr_mbc_read : csl_bit_vector(0 downto 0);
signal slave_tapcmpr_mbc_write : csl_bit_vector(0 downto 0);
signal mbc_arm_mbc_address : csl_bit_vector(31 downto 0);
signal mbc_arm_mbc_write_data : csl_bit_vector(31 downto 0);
signal mbc_arm_mbc_write : csl_bit_vector(0 downto 0);
signal mbc_arm_mbc_read : csl_bit_vector(0 downto 0);
signal mbc_arm_mbc_read_data : csl_bit_vector(31 downto 0);
signal mbc_arm_mbc_control : csl_bit_vector(31 downto 0);
signal mbc_dsp_mbc_address : csl_bit_vector(31 downto 0);
signal mbc_dsp_mbc_write_data : csl_bit_vector(31 downto 0);
signal mbc_dsp_mbc_write : csl_bit_vector(0 downto 0);
signal mbc_dsp_mbc_read : csl_bit_vector(0 downto 0);
signal mbc_dsp_mbc_read_data : csl_bit_vector(31 downto 0);
signal mbc_dsp_mbc_control : csl_bit_vector(31 downto 0);
signal mbc_h264_mbc_address : csl_bit_vector(31 downto 0);
signal mbc_h264_mbc_write_data : csl_bit_vector(31 downto 0);
signal mbc_h264_mbc_write : csl_bit_vector(0 downto 0);
signal mbc_h264_mbc_read : csl_bit_vector(0 downto 0);
signal mbc_h264_mbc_read_data : csl_bit_vector(31 downto 0);
signal mbc_h264_mbc_control : csl_bit_vector(31 downto 0);
signal mbc_cmpr_mbc_address : csl_bit_vector(31 downto 0);
signal mbc_cmpr_mbc_write_data : csl_bit_vector(31 downto 0);
signal mbc_cmpr_mbc_write : csl_bit_vector(0 downto 0);
signal mbc_cmpr_mbc_read : csl_bit_vector(0 downto 0);
signal mbc_cmpr_mbc_read_data : csl_bit_vector(31 downto 0);
signal mbc_cmpr_mbc_control : csl_bit_vector(31 downto 0);

 begin

h264 : h264 port map ( 
mbc_out_ifc_address =>(mbc_h264_mbc_address),
mbc_out_ifc_control =>(mbc_h264_mbc_control),
mbc_out_ifc_read =>(mbc_h264_mbc_read),
mbc_out_ifc_read_data =>(mbc_h264_mbc_read_data),
mbc_out_ifc_write =>(mbc_h264_mbc_write),
mbc_out_ifc_write_data =>(mbc_h264_mbc_write_data)

);

a2rtap_arm : a2rtap port map ( 
a2rtap_master_ifc_address =>(master_a2p_arm_address),
a2rtap_master_ifc_error =>(master_a2p_arm_error),
a2rtap_master_ifc_read =>(master_a2p_arm_read),
a2rtap_master_ifc_read_data =>(master_a2p_arm_read_data),
a2rtap_master_ifc_ready =>(master_a2p_arm_ready),
a2rtap_master_ifc_write =>(master_a2p_arm_write),
a2rtap_master_ifc_write_data =>(master_a2p_arm_write_data),
a2rtap_slave_out_ifc_address =>(slave_taparm_mbc_address),
a2rtap_slave_out_ifc_data =>(slave_taparm_mbc_data),
a2rtap_slave_out_ifc_error =>(slave_taparm_mbc_error),
a2rtap_slave_out_ifc_read =>(slave_taparm_mbc_read),
a2rtap_slave_out_ifc_read_data =>(slave_taparm_mbc_read_data),
a2rtap_slave_out_ifc_ready =>(slave_taparm_mbc_ready),
a2rtap_slave_out_ifc_write =>(slave_taparm_mbc_write),
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

mcb_h264 : mcb port map ( 
a2rtap_slave_in_ifc_address =>(slave_taph264_mbc_address),
a2rtap_slave_in_ifc_data =>(slave_taph264_mbc_data),
a2rtap_slave_in_ifc_error =>(slave_taph264_mbc_error),
a2rtap_slave_in_ifc_read =>(slave_taph264_mbc_read),
a2rtap_slave_in_ifc_read_data =>(slave_taph264_mbc_read_data),
a2rtap_slave_in_ifc_ready =>(slave_taph264_mbc_ready),
a2rtap_slave_in_ifc_write =>(slave_taph264_mbc_write),
mbc_in_ifc_address =>(mbc_h264_mbc_address),
mbc_in_ifc_control =>(mbc_h264_mbc_control),
mbc_in_ifc_read =>(mbc_h264_mbc_read),
mbc_in_ifc_read_data =>(mbc_h264_mbc_read_data),
mbc_in_ifc_write =>(mbc_h264_mbc_write),
mbc_in_ifc_write_data =>(mbc_h264_mbc_write_data)

);

cmpr : cmpr port map ( 
mbc_out_ifc_address =>(mbc_cmpr_mbc_address),
mbc_out_ifc_control =>(mbc_cmpr_mbc_control),
mbc_out_ifc_read =>(mbc_cmpr_mbc_read),
mbc_out_ifc_read_data =>(mbc_cmpr_mbc_read_data),
mbc_out_ifc_write =>(mbc_cmpr_mbc_write),
mbc_out_ifc_write_data =>(mbc_cmpr_mbc_write_data)

);

host_processor : host_processor port map ( 
mbc_out_ifc_address =>(mbc_arm_mbc_address),
mbc_out_ifc_control =>(mbc_arm_mbc_control),
mbc_out_ifc_read =>(mbc_arm_mbc_read),
mbc_out_ifc_read_data =>(mbc_arm_mbc_read_data),
mbc_out_ifc_write =>(mbc_arm_mbc_write),
mbc_out_ifc_write_data =>(mbc_arm_mbc_write_data)

);

mcb_arm : mcb port map ( 
a2rtap_slave_in_ifc_address =>(slave_taparm_mbc_address),
a2rtap_slave_in_ifc_data =>(slave_taparm_mbc_data),
a2rtap_slave_in_ifc_error =>(slave_taparm_mbc_error),
a2rtap_slave_in_ifc_read =>(slave_taparm_mbc_read),
a2rtap_slave_in_ifc_read_data =>(slave_taparm_mbc_read_data),
a2rtap_slave_in_ifc_ready =>(slave_taparm_mbc_ready),
a2rtap_slave_in_ifc_write =>(slave_taparm_mbc_write),
mbc_in_ifc_address =>(mbc_arm_mbc_address),
mbc_in_ifc_control =>(mbc_arm_mbc_control),
mbc_in_ifc_read =>(mbc_arm_mbc_read),
mbc_in_ifc_read_data =>(mbc_arm_mbc_read_data),
mbc_in_ifc_write =>(mbc_arm_mbc_write),
mbc_in_ifc_write_data =>(mbc_arm_mbc_write_data)

);

a2rtap_dsp : a2rtap port map ( 
a2rtap_master_ifc_address =>(master_dummy1_address),
a2rtap_master_ifc_error =>(master_dummy1_error),
a2rtap_master_ifc_read =>(master_dummy1_read),
a2rtap_master_ifc_read_data =>(master_dummy1_read_data),
a2rtap_master_ifc_ready =>(master_dummy1_ready),
a2rtap_master_ifc_write =>(master_dummy1_write),
a2rtap_master_ifc_write_data =>(master_dummy1_write_data),
a2rtap_slave_out_ifc_address =>(slave_tapdsp_mbc_address),
a2rtap_slave_out_ifc_data =>(slave_tapdsp_mbc_data),
a2rtap_slave_out_ifc_error =>(slave_tapdsp_mbc_error),
a2rtap_slave_out_ifc_read =>(slave_tapdsp_mbc_read),
a2rtap_slave_out_ifc_read_data =>(slave_tapdsp_mbc_read_data),
a2rtap_slave_out_ifc_ready =>(slave_tapdsp_mbc_ready),
a2rtap_slave_out_ifc_write =>(slave_tapdsp_mbc_write),
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

mcb_dsp : mcb port map ( 
a2rtap_slave_in_ifc_address =>(slave_tapdsp_mbc_address),
a2rtap_slave_in_ifc_data =>(slave_tapdsp_mbc_data),
a2rtap_slave_in_ifc_error =>(slave_tapdsp_mbc_error),
a2rtap_slave_in_ifc_read =>(slave_tapdsp_mbc_read),
a2rtap_slave_in_ifc_read_data =>(slave_tapdsp_mbc_read_data),
a2rtap_slave_in_ifc_ready =>(slave_tapdsp_mbc_ready),
a2rtap_slave_in_ifc_write =>(slave_tapdsp_mbc_write),
mbc_in_ifc_address =>(mbc_dsp_mbc_address),
mbc_in_ifc_control =>(mbc_dsp_mbc_control),
mbc_in_ifc_read =>(mbc_dsp_mbc_read),
mbc_in_ifc_read_data =>(mbc_dsp_mbc_read_data),
mbc_in_ifc_write =>(mbc_dsp_mbc_write),
mbc_in_ifc_write_data =>(mbc_dsp_mbc_write_data)

);

dsp : dsp port map ( 
mbc_out_ifc_address =>(mbc_dsp_mbc_address),
mbc_out_ifc_control =>(mbc_dsp_mbc_control),
mbc_out_ifc_read =>(mbc_dsp_mbc_read),
mbc_out_ifc_read_data =>(mbc_dsp_mbc_read_data),
mbc_out_ifc_write =>(mbc_dsp_mbc_write),
mbc_out_ifc_write_data =>(mbc_dsp_mbc_write_data)

);

a2rtap_cmpr : a2rtap port map ( 
a2rtap_master_ifc_address =>(master_dummy3_address),
a2rtap_master_ifc_error =>(master_dummy3_error),
a2rtap_master_ifc_read =>(master_dummy3_read),
a2rtap_master_ifc_read_data =>(master_dummy3_read_data),
a2rtap_master_ifc_ready =>(master_dummy3_ready),
a2rtap_master_ifc_write =>(master_dummy3_write),
a2rtap_master_ifc_write_data =>(master_dummy3_write_data),
a2rtap_slave_out_ifc_address =>(slave_tapcmpr_mbc_address),
a2rtap_slave_out_ifc_data =>(slave_tapcmpr_mbc_data),
a2rtap_slave_out_ifc_error =>(slave_tapcmpr_mbc_error),
a2rtap_slave_out_ifc_read =>(slave_tapcmpr_mbc_read),
a2rtap_slave_out_ifc_read_data =>(slave_tapcmpr_mbc_read_data),
a2rtap_slave_out_ifc_ready =>(slave_tapcmpr_mbc_ready),
a2rtap_slave_out_ifc_write =>(slave_tapcmpr_mbc_write),
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

a2rtap_h264 : a2rtap port map ( 
a2rtap_master_ifc_address =>(master_dummy2_address),
a2rtap_master_ifc_error =>(master_dummy2_error),
a2rtap_master_ifc_read =>(master_dummy2_read),
a2rtap_master_ifc_read_data =>(master_dummy2_read_data),
a2rtap_master_ifc_ready =>(master_dummy2_ready),
a2rtap_master_ifc_write =>(master_dummy2_write),
a2rtap_master_ifc_write_data =>(master_dummy2_write_data),
a2rtap_slave_out_ifc_address =>(slave_taph264_mbc_address),
a2rtap_slave_out_ifc_data =>(slave_taph264_mbc_data),
a2rtap_slave_out_ifc_error =>(slave_taph264_mbc_error),
a2rtap_slave_out_ifc_read =>(slave_taph264_mbc_read),
a2rtap_slave_out_ifc_read_data =>(slave_taph264_mbc_read_data),
a2rtap_slave_out_ifc_ready =>(slave_taph264_mbc_ready),
a2rtap_slave_out_ifc_write =>(slave_taph264_mbc_write),
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
a2rtap_master_ifc_address =>(master_a2p_arm_address),
a2rtap_master_ifc_error =>(master_a2p_arm_error),
a2rtap_master_ifc_read =>(master_a2p_arm_read),
a2rtap_master_ifc_read_data =>(master_a2p_arm_read_data),
a2rtap_master_ifc_ready =>(master_a2p_arm_ready),
a2rtap_master_ifc_write =>(master_a2p_arm_write),
a2rtap_master_ifc_write_data =>(master_a2p_arm_write_data)

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

mcb_cmpr : mcb port map ( 
a2rtap_slave_in_ifc_address =>(slave_tapcmpr_mbc_address),
a2rtap_slave_in_ifc_data =>(slave_tapcmpr_mbc_data),
a2rtap_slave_in_ifc_error =>(slave_tapcmpr_mbc_error),
a2rtap_slave_in_ifc_read =>(slave_tapcmpr_mbc_read),
a2rtap_slave_in_ifc_read_data =>(slave_tapcmpr_mbc_read_data),
a2rtap_slave_in_ifc_ready =>(slave_tapcmpr_mbc_ready),
a2rtap_slave_in_ifc_write =>(slave_tapcmpr_mbc_write),
mbc_in_ifc_address =>(mbc_cmpr_mbc_address),
mbc_in_ifc_control =>(mbc_cmpr_mbc_control),
mbc_in_ifc_read =>(mbc_cmpr_mbc_read),
mbc_in_ifc_read_data =>(mbc_cmpr_mbc_read_data),
mbc_in_ifc_write =>(mbc_cmpr_mbc_write),
mbc_in_ifc_write_data =>(mbc_cmpr_mbc_write_data)

);

 end  arch_ssm_demo ; 
