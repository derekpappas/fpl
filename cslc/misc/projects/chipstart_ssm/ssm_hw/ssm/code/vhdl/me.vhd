--THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
--COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
--OUTPUT FILE NAME  : me.vhd
--FILE GENERATED ON : Fri Mar 12 09:18:02 2010


library ieee ; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
use work.csl_util_package.all;

entity me is 

-- Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 137
end me ; 

 architecture  arch_me of me is 
 component wb
 port ( 
mbc_in_ifc_read_data : in   csl_bit_vector(31 downto 0);
mbc_in_ifc_control : in   csl_bit_vector(31 downto 0);
a2rtap_slave_in_ifc_read_data : out   csl_bit_vector(31 downto 0);
a2rtap_slave_in_ifc_ready : out   csl_bit_vector(0 downto 0);
a2rtap_slave_in_ifc_error : out   csl_bit_vector(0 downto 0);
a2rtap_slave_in_ifc_address : out   csl_bit_vector(19 downto 0);
a2rtap_slave_in_ifc_data : out   csl_bit_vector(31 downto 0);
a2rtap_slave_in_ifc_read : out   csl_bit_vector(0 downto 0);
a2rtap_slave_in_ifc_write : out   csl_bit_vector(0 downto 0);
mbc_in_ifc_address : out   csl_bit_vector(31 downto 0);
mbc_in_ifc_write_data : out   csl_bit_vector(31 downto 0);
mbc_in_ifc_write : out   csl_bit_vector(0 downto 0);
mbc_in_ifc_read : out   csl_bit_vector(0 downto 0) 
 );
end component; 


signal im_rf_wr_addr : csl_bit_vector(3 downto 0);
signal im_rf_wr_en : csl_bit_vector(0 downto 0);
signal im_rf_wr_data : csl_bit_vector(31 downto 0);
signal im_rf_rd_addr_a : csl_bit_vector(3 downto 0);
signal im_rf_rd_en_a : csl_bit_vector(0 downto 0);
signal im_rf_rd_addr_b : csl_bit_vector(3 downto 0);
signal im_rf_rd_en_b : csl_bit_vector(0 downto 0);
signal pc_im_me_cntl_v : csl_bit_vector(0 downto 0);
signal pc_im_me_cntl_pc : csl_bit_vector(7 downto 0);
signal pc_im_me_cntl_npc : csl_bit_vector(7 downto 0);
signal pc_im_me_cntl_ir : csl_bit_vector(31 downto 0);
signal pc_im_me_cntl_br_offset : csl_bit_vector(7 downto 0);
signal im_rf_me_cntl_v : csl_bit_vector(0 downto 0);
signal im_rf_me_cntl_pc : csl_bit_vector(7 downto 0);
signal im_rf_me_cntl_npc : csl_bit_vector(7 downto 0);
signal im_rf_me_cntl_ir : csl_bit_vector(31 downto 0);
signal im_rf_me_cntl_br_offset : csl_bit_vector(7 downto 0);
signal rf_eu_rfi_rd_data_a : csl_bit_vector(31 downto 0);
signal rf_eu_rfi_rd_data_b : csl_bit_vector(31 downto 0);
signal eu_wb_rfi_rd_data_a : csl_bit_vector(31 downto 0);
signal eu_wb_rfi_rd_data_b : csl_bit_vector(31 downto 0);
signal eu_rf_rfi_rd_data_a : csl_bit_vector(31 downto 0);
signal eu_rf_rfi_rd_data_b : csl_bit_vector(31 downto 0);
signal me_br_qual_br : csl_bit_vector(0 downto 0);

 begin

rf : rf port map ( 
  br_in_qual_br =>(me_br_qual_br),
  eu_rf_in_rd_data_a =>(),
  eu_rf_in_rd_data_b =>(),
  im_rf_in_rfi_rd_addr_a =>(),
  im_rf_in_rfi_rd_addr_b =>(),
  im_rf_in_rfi_rd_en_a =>(),
  im_rf_in_rfi_rd_en_b =>(),
  im_rf_in_rfi_wr_addr =>(),
  im_rf_in_rfi_wr_data =>(),
  im_rf_in_rfi_wr_en =>(),
  rf_eu_rfi_rd_data_a =>(rf_eu_rfi_rd_data_a),
  rf_eu_rfi_rd_data_b =>(rf_eu_rfi_rd_data_b)

);

im : im port map ( 
  br_in_qual_br =>(me_br_qual_br),
  im_rf_out_rfi_rd_addr_a =>(im_rf_rd_addr_a),
  im_rf_out_rfi_rd_addr_b =>(im_rf_rd_addr_b),
  im_rf_out_rfi_rd_en_a =>(im_rf_rd_en_a),
  im_rf_out_rfi_rd_en_b =>(im_rf_rd_en_b),
  im_rf_out_rfi_wr_addr =>(im_rf_wr_addr),
  im_rf_out_rfi_wr_data =>(im_rf_wr_data),
  im_rf_out_rfi_wr_en =>(im_rf_wr_en),
  me_cntl_in_br_offset =>(pc_im_me_cntl_br_offset),
  me_cntl_in_ir =>(pc_im_me_cntl_ir),
  me_cntl_in_npc =>(pc_im_me_cntl_npc),
  me_cntl_in_pc =>(pc_im_me_cntl_pc),
  me_cntl_in_v =>(pc_im_me_cntl_v),
  me_cntl_out_br_offset =>(im_rf_me_cntl_br_offset),
  me_cntl_out_ir =>(im_rf_me_cntl_ir),
  me_cntl_out_npc =>(im_rf_me_cntl_npc),
  me_cntl_out_pc =>(im_rf_me_cntl_pc),
  me_cntl_out_v =>(im_rf_me_cntl_v)

);

eu : eu port map ( 
  br_in_qual_br =>(me_br_qual_br),
  eu_im_out_rd_data_a =>(eu_wb_rfi_rd_data_a),
  eu_im_out_rd_data_b =>(eu_wb_rfi_rd_data_b),
  eu_rf_out_rd_data_a =>(eu_rf_rfi_rd_data_a),
  eu_rf_out_rd_data_b =>(eu_rf_rfi_rd_data_b),
  rf_eu_rfi_rd_data_a =>(rf_eu_rfi_rd_data_a),
  rf_eu_rfi_rd_data_b =>(rf_eu_rfi_rd_data_b)

);

pc : pc port map ( 
  me_cntl_out_br_offset =>(pc_im_me_cntl_br_offset),
  me_cntl_out_ir =>(pc_im_me_cntl_ir),
  me_cntl_out_npc =>(pc_im_me_cntl_npc),
  me_cntl_out_pc =>(pc_im_me_cntl_pc),
  me_cntl_out_v =>(pc_im_me_cntl_v)

);

wb : wb port map ( 
  br_out_qual_br =>(),
  eu_wb_in_rd_data_a =>(),
  eu_wb_in_rd_data_b =>(),
  me_cntl_in_br_offset =>(im_rf_me_cntl_br_offset),
  me_cntl_in_ir =>(im_rf_me_cntl_ir),
  me_cntl_in_npc =>(im_rf_me_cntl_npc),
  me_cntl_in_pc =>(im_rf_me_cntl_pc),
  me_cntl_in_v =>(im_rf_me_cntl_v)

);

 end  arch_me ; 
