

-- ----------------------------------------------------------------------------
-- $File: //hw/main/cpc/Abraxas/src/cpc_pkg/cpc_pkg.vhd $
-- $Revision: #11 $
-- $DateTime: 2008/01/09 18:00:17 $
-- $Author: vladimir $
--
-- TARARI CONFIDENTIAL
--
-- COPYRIGHT (c) 2002 TO 2006 BY TARARI, INC. ALL RIGHTS RESERVED.
-- NO PART OF THIS PROGRAM OR PUBLICATION MAY BE REPRODUCED, TRANSMITTED,
-- TRANSCRIBED, STORED IN A RETRIEVAL SYSTEM, OR TRANSLATED INTO ANY
-- LANGUAGE OR COMPUTER LANGUAGE IN ANY FORM OR BY ANY MEANS, ELECTRONIC,
-- MECHANICAL, MAGNETIC, OPTICAL, CHEMICAL, MANUAL, OR OTHERWISE,
-- OUTSIDE OF THE USES OUTLINED IN THE TARARI SOFTWARE LICENSE
-- AGREEMENT WITHOUT THE PRIOR WRITTEN PERMISSION OF AN OFFICER OF
--
--                    TARARI, INC.
--                    10908 TECHNOLOGY PLACE
--                    SAN DIEGO,  CALIFORNIA  92127
--
-- THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND AND
-- TARARI EXPRESSLY DISCLAIMS ALL OTHER  WARRANTIES FOR THE SOFTWARE,
-- EITHER EXPRESS OR IMPLIED, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR
-- NONINFRINGEMENT.  THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE
-- OF THE SOFTWARE REMAINS WITH YOU.
--
-- THE ENTIRE RISK AS TO THE RESULTS AND PERFORMANCE OF THE SOFTWARE IS
-- ASSUMED BY YOU.  TARARI SHALL NOT HAVE ANY LIABILITY TO YOU OR ANY
-- OTHER PERSON OR ENTITY FOR ANY INDIRECT, INCIDENTAL, SPECIAL, OR
-- CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, BUT NOT LIMITED TO,
-- LOSS OF REVENUE, PROFIT OR OPPORTUNITY, LOST OR DAMAGED DATA OR OTHER
-- COMMERCIAL OR ECONOMIC LOSS, EVEN IF TARARI HAS BEEN ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGES, OR THEY ARE FORESEEABLE.  OUR MAXIMUM
-- AGGREGATE LIABILITY TO YOU FOR DIRECT DAMAGES SHALL NOT EXCEED THE
-- AMOUNT PAID BY YOU FOR THE SOFTWARE.
--
-- ----------------------------------------------------------------------------
-- $Header: //hw/main/cpc/Abraxas/src/cpc_pkg/cpc_pkg.vhd#11 $
--
-- Company   : Tarari Inc.
--
-- Project   : Abraxas
--
-- Filename  : $File: //hw/main/cpc/Abraxas/src/cpc_pkg/cpc_pkg.vhd $
--
-- Author(s) : Jim Henson
--
-- Components instantiated:
--
-- Instantiated by:
--
-- Last Modified : $Author: vladimir $ $DateTime: 2008/01/09 18:00:17 $
--
-- ----------------------------------------------------------------------------
-- Purpose:
--   Global CPC package for Abraxas CPCs.
--
-- Detailed Description:
--
-- Notes:
--
-- ----------------------------------------------------------------------------
-- $Change: 56486 $
-- ----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.std_logic_arith.all;

use work.cpx_cfg_pkg.all;

package cpc_pkg is

  -- ###########################################################################
  --                          Configurable Constants
  --
  --                    !!! DO NOT MODIFY THIS SECTION !!!
  --
  -- > These constants are defined for each specific build in cpx_cfg_pkg and
  -- > then mapped to the appropriate constant below.
  --
  -- ###########################################################################

  -- Build ID Register Constants
  constant cpc_id_c                     : std_logic_vector(31 downto 0) := cpx_id_c;
  constant cpc_revision_c               : std_logic_vector(31 downto 0) := cpx_revision_c;
  constant cpc_rev_date_c               : std_logic_vector(31 downto 0) := cpx_rev_date_c;
  -- Build Resources
  constant cpc_num_of_agt_clusters_c    : integer   := cpx_num_of_agt_clusters_c;
  constant cpc_num_of_connected_sws_c   : integer   := cpx_num_of_connected_sws_c;
  constant memory_agt_present_c         : std_logic := cpx_memory_agt_present_c;
  constant memory_agt_cluster_c         : integer   := cpx_memory_agt_cluster_c;
  constant hda_agt_present_c            : std_logic := cpx_hda_agt_present_c;
  -- Bits Allocated to Agent/Device Identification
  constant cpc_num_of_sw_bits_c         : integer   := cpx_num_of_sw_bits_c;
  constant cpc_num_of_sw_port_bits_c    : integer   := cpx_num_of_sw_port_bits_c;
  constant cpc_num_of_dev_id_bits_c     : integer   := cpx_num_of_dev_id_bits_c;
  -- ACC Configuration Constants
  constant max_fifo_port_id_bits_c      : integer   := cpx_max_fifo_port_id_bits_c;
  constant max_ports_per_agt_bits_c     : integer   := cpx_max_ports_per_agt_bits_c;
  constant max_connecting_port_bits_c   : integer   := cpx_max_connecting_port_bits_c;
  constant max_credit_ctr_bits_c        : integer   := cpx_max_credit_ctr_bits_c;
  -- Agent Clock Enable Constants
  constant enable_usr0_clk_c            : boolean   := cpx_enable_usr0_clk_c;
  constant enable_usr1_clk_c            : boolean   := cpx_enable_usr1_clk_c;
  constant enable_usr2_clk_c            : boolean   := cpx_enable_usr2_clk_c;
  constant enable_usr3_clk_c            : boolean   := cpx_enable_usr3_clk_c;
  constant single_clock_system_c        : boolean   := cpx_single_clock_system_c;
  
  -- DMAC Configuration Parameters
  constant num_threads_bits_c           : integer   := cpx_num_threads_bits_c;
  -- Memory Agent Configuration Parameters
  constant mag_port_bits_c              : integer   := cpx_mag_port_bits_c;
  -- HDA Agent Configuration Parameters
  constant hda_port_bits_c              : integer   := cpx_hda_port_bits_c;
  --constant descr_in_num_threads_bits_c  : integer   := cpx_descr_in_num_threads_bits_c;
  constant dma_max_descriptor_queues    : integer   := 2**num_threads_bits_c;
  constant dma_output_fifo_sel_bits_c   : integer   := num_threads_bits_c;
  --constant dma_max_output_addr_bits_c   : integer   := cpx_dma_max_output_addr_bits_c;
  constant dma_input_fifo_sel_bits_c    : integer   := num_threads_bits_c;
  --constant dma_max_input_addr_bits_c    : integer   := cpx_dma_max_input_addr_bits_c;


  -- ###########################################################################
  --                          Fixed System Constants
  -- ###########################################################################

  ----------------------------------------------------------------------
  -- System Bus Interface Types
  --  00 = PCIe, 01 = HT, 10 = PCI/PCI-X, 11 = RESERVED
  ----------------------------------------------------------------------
  constant pcie_system_bus    : std_logic_vector(1 downto 0) := "00";
  constant ht_system_bus      : std_logic_vector(1 downto 0) := "01";
  constant pci_system_bus     : std_logic_vector(1 downto 0) := "10";
  constant pcix_system_bus    : std_logic_vector(1 downto 0) := "11";

  ----------------------------------------------------------------------
  -- BAR0 Register Interface Constants
  ----------------------------------------------------------------------
  constant bar0_addr_bits_c            : integer    := 20;
  constant reg_if_dw_addr_bits_c       : integer    := 10;

  ----------------------------------------------------------------------
  -- ACC Configuration Types
  ----------------------------------------------------------------------
  subtype fifo_ports_id_type   is std_logic_vector(max_fifo_port_id_bits_c - 1 downto 0);
  subtype ports_per_agt_type   is std_logic_vector(max_ports_per_agt_bits_c - 1 downto 0);
  subtype connecting_port_type is std_logic_vector(max_connecting_port_bits_c - 1 downto 0);
  subtype credit_ctr_type      is std_logic_vector(max_credit_ctr_bits_c - 1 downto 0);

  ----------------------------------------------------------------------
  -- Memory Controller Input FIFO Bus Map
  ----------------------------------------------------------------------
  -- WITH MEM AGENT
  -- note:  the lower bits also map to the transaction information fifo bus map
  subtype mem_infifo_source       is std_logic_vector(  7 downto   0);
  subtype mem_infifo_eob          is std_logic_vector(  8 downto   8);
  subtype mem_infifo_bytes_vld    is std_logic_vector( 13 downto   9);
  subtype mem_infifo_offset       is std_logic_vector( 17 downto  14);
  -- end transaction information fifo bus map
  subtype mem_infifo_data         is std_logic_vector(145 downto  18);
  subtype mem_infifo_byte_enb     is std_logic_vector(161 downto 146);
  subtype mem_infifo_col          is std_logic_vector(172 downto 162);
  subtype mem_infifo_ba           is std_logic_vector(176 downto 173);
  subtype mem_infifo_row          is std_logic_vector(192 downto 177);
  subtype mem_infifo_rw_n_bus     is std_logic_vector(193 downto 193);

  -- return fifo bus map
  subtype mem_rtn_fifo_dest       is std_logic_vector(  7 downto   0);
  subtype mem_rtn_fifo_eob        is std_logic_vector(  8 downto   8);
  subtype mem_rtn_fifo_data       is std_logic_vector(136 downto   9);

  -- set the fifo constants to the appropriate sizes
  constant mem_infifo_width_c               : integer := 194;
  constant mem_infifo_depth_bits_c          : integer := 4;
  constant mem_xact_info_fifo_width_c       : integer := 18;
  --constant mem_xact_info_fifo_depth_bits_c  : integer := 16;
  constant mem_return_fifo_width_c          : integer := 137;
  constant mem_return_fifo_depth_bits_c     : integer := 4;

  constant mem_infifo_afull_wm_c      : integer := 4;
  constant mem_rtn_fifo_afull_wm_c    : integer := 4;
  -- END WITH MEM AGENT


  --------------------------------------------------------------------------------
  -- Central Switch (CSW) definitions
  --------------------------------------------------------------------------------
  constant cpc_num_of_dest_bits_c      : integer    := cpc_num_of_sw_bits_c +
                                                       cpc_num_of_sw_port_bits_c +
                                                       cpc_num_of_dev_id_bits_c;
  constant csw_data_bits_c         : integer   := 32;
  constant csw_ptag_bits_c         : integer   := 4;
  constant csw_swb_bits_c          : integer   := cpc_num_of_sw_bits_c;
  constant csw_sw_port_bits_c      : integer   := cpc_num_of_sw_port_bits_c;
  constant csw_dev_id_bits_c       : integer   := cpc_num_of_dev_id_bits_c;
  constant csw_dest_bits_c         : integer   := cpc_num_of_dest_bits_c;
  constant csw_port_bits_c         : integer   := csw_sw_port_bits_c + csw_dev_id_bits_c;

  -- Packet Tag Enumeration
  type csw_pkt_tag_type is (
    pt_nop,
    pt_payload,
    pt_meta,
    pt_metac,
    pt_eoj,
    pt_status,
    pt_register,
    pt_credit,
    pt_soj,
    pt_error,
    pt_regcpl,
    pt_reserved,
    pt_eop0,
    pt_eop1,
    pt_eop2,
    pt_eop3
  );

  -- CSW Data Types
  subtype  csw_data                is std_logic_vector (csw_data_bits_c - 1 downto 0);
  subtype  csw_pkt_tag             is std_logic_vector (csw_ptag_bits_c - 1 downto 0);
  subtype  csw_dest                is std_logic_vector (csw_dest_bits_c - 1 downto 0);
  subtype  csw_swb                 is std_logic_vector (csw_swb_bits_c - 1 downto 0);
  subtype  csw_sw_port             is std_logic_vector (csw_sw_port_bits_c - 1 downto 0);
  subtype  csw_dev_id              is std_logic_vector (csw_dev_id_bits_c - 1 downto 0);
  subtype  csw_sw_dev_id           is std_logic_vector (csw_sw_port_bits_c + csw_dev_id_bits_c - 1 downto 0);

  -- CSW Range Slice Types
  subtype  csw_swb_slice           is std_logic_vector (csw_dest_bits_c - 1 downto csw_port_bits_c);
  subtype  csw_sw_port_slice       is std_logic_vector (csw_port_bits_c - 1 downto csw_dev_id_bits_c);
  subtype  csw_dev_id_slice        is std_logic_vector (csw_dev_id_bits_c - 1 downto 0);
  subtype  csw_sw_dev_id_slice     is std_logic_vector (csw_sw_port_bits_c + csw_dev_id_bits_c - 1 downto 0);

  -- CSW Packet Type Conversion Functions
  function conv_csw_pkt_tag(arg : csw_pkt_tag_type) return csw_pkt_tag;
  function conv_csw_pkt_tag_type(arg : csw_pkt_tag) return csw_pkt_tag_type;
  -- pragma translate_off
  function to_string(arg: csw_pkt_tag_type) return string;
  -- pragma translate_on
  function conv_std_logic_vector(arg: csw_pkt_tag_type) return std_logic_vector;


  -- CSW Aggregated Bus Types for RAMs
  constant csw_memory_bits_c       : integer   := (4 * csw_data_bits_c) + (4 * csw_ptag_bits_c);

  -- CSW Memory Range Slice Types
  subtype  csw_data0_slice         is std_logic_vector((1 * csw_data_bits_c) + (0 * csw_ptag_bits_c) - 1 downto
                                                       (0 * csw_data_bits_c) + (0 * csw_ptag_bits_c));

  subtype  csw_ptag0_slice         is std_logic_vector((1 * csw_data_bits_c) + (1 * csw_ptag_bits_c) - 1 downto
                                                       (1 * csw_data_bits_c) + (0 * csw_ptag_bits_c));

  subtype  csw_data1_slice         is std_logic_vector((2 * csw_data_bits_c) + (1 * csw_ptag_bits_c) - 1 downto
                                                       (1 * csw_data_bits_c) + (1 * csw_ptag_bits_c));

  subtype  csw_ptag1_slice         is std_logic_vector((2 * csw_data_bits_c) + (2 * csw_ptag_bits_c) - 1 downto
                                                       (2 * csw_data_bits_c) + (1 * csw_ptag_bits_c));

  subtype  csw_data2_slice         is std_logic_vector((3 * csw_data_bits_c) + (2 * csw_ptag_bits_c) - 1 downto
                                                       (2 * csw_data_bits_c) + (2 * csw_ptag_bits_c));

  subtype  csw_ptag2_slice         is std_logic_vector((3 * csw_data_bits_c) + (3 * csw_ptag_bits_c) - 1 downto
                                                       (3 * csw_data_bits_c) + (2 * csw_ptag_bits_c));

  subtype  csw_data3_slice         is std_logic_vector((4 * csw_data_bits_c) + (3 * csw_ptag_bits_c) - 1 downto
                                                       (3 * csw_data_bits_c) + (3 * csw_ptag_bits_c));

  subtype  csw_ptag3_slice         is std_logic_vector((4 * csw_data_bits_c) + (4 * csw_ptag_bits_c) - 1 downto
                                                       (4 * csw_data_bits_c) + (3 * csw_ptag_bits_c));


  --------------------------------------------------------------------------------
  -- LED Types for the LED Mux
  --------------------------------------------------------------------------------
  type led_mux_arr_type is array(0 to 15) of std_logic_vector(15 downto 0);


  --------------------------------------------------------------------------------
  -- Debug and Helper Functions
  --------------------------------------------------------------------------------
  -- pragma translate_off
  -- Converts a std_logic_vector to a string.
  function to_string(input_dat: std_logic_vector) return string;
  -- Converts a std_logic to a string.
  function to_string(arg: std_logic) return string;
  -- pragma translate_on

  -- Agent configuration register bit
  constant AGENT_CONFIG_BIG_ENDIAN_BIT_C : integer := 0;
  
end package cpc_pkg;


package body cpc_pkg is

  function conv_csw_pkt_tag(arg : csw_pkt_tag_type) return csw_pkt_tag is
    variable result: csw_pkt_tag;
  begin
    case arg is
      when pt_nop         => result := "0000";
      when pt_payload     => result := "0001";
      when pt_meta        => result := "0010";
      when pt_metac       => result := "0011";
      when pt_eoj         => result := "0100";
      when pt_status      => result := "0101";
      when pt_register    => result := "0110";
      when pt_credit      => result := "0111";
      when pt_soj         => result := "1000";
      when pt_error       => result := "1001";
      when pt_regcpl      => result := "1010";
      when pt_reserved    => result := "1011";
      when pt_eop0        => result := "1100";
      when pt_eop1        => result := "1101";
      when pt_eop2        => result := "1110";
      when pt_eop3        => result := "1111";
      -- Added to keep synplify from complaining.
      when others         => result := "0000";
    end case;
    return result;
  end;

  function conv_csw_pkt_tag_type(arg : csw_pkt_tag) return csw_pkt_tag_type is
    variable result: csw_pkt_tag_type;
  begin
    case arg is
      when "0000"  => result := pt_nop;
      when "0001"  => result := pt_payload;
      when "0010"  => result := pt_meta;
      when "0011"  => result := pt_metac;
      when "0100"  => result := pt_eoj;
      when "0101"  => result := pt_status;
      when "0110"  => result := pt_register;
      when "0111"  => result := pt_credit;
      when "1000"  => result := pt_soj;
      when "1001"  => result := pt_error;
      when "1010"  => result := pt_regcpl;
      when "1011"  => result := pt_reserved;
      when "1100"  => result := pt_eop0;
      when "1101"  => result := pt_eop1;
      when "1110"  => result := pt_eop2;
      when "1111"  => result := pt_eop3;
      when others  => result := pt_nop;
    end case;
    return result;
  end;


  -- pragma translate_off

  -- Converts a std_logic_vector to a string.
  function to_string(input_dat: std_logic_vector) return string is
    variable vec_size    : integer := (input_dat'high - input_dat'low) + 1;
    variable num_nibbles : integer := integer(ceil(real(vec_size) * 0.25));
    variable stmp        : string(num_nibbles downto 1);
    variable nibble      : std_logic_vector(3 downto 0);
  begin
    for i in num_nibbles downto 1 loop
      if ((i*4 - 1) > input_dat'high) then
        nibble := ext(input_dat(input_dat'high downto i*4-4), 4);
      else
        nibble := input_dat(i*4-1 downto i*4-4);
      end if;
      case nibble is
        when X"0" => stmp(i) := '0';
        when X"1" => stmp(i) := '1';
        when X"2" => stmp(i) := '2';
        when X"3" => stmp(i) := '3';
        when X"4" => stmp(i) := '4';
        when X"5" => stmp(i) := '5';
        when X"6" => stmp(i) := '6';
        when X"7" => stmp(i) := '7';
        when X"8" => stmp(i) := '8';
        when X"9" => stmp(i) := '9';
        when X"a" => stmp(i) := 'a';
        when X"b" => stmp(i) := 'b';
        when X"c" => stmp(i) := 'c';
        when X"d" => stmp(i) := 'd';
        when X"e" => stmp(i) := 'e';
        when X"f" => stmp(i) := 'f';
        when others => null;
      end case;
    end loop;
    return stmp;
  end to_string;


  -- Converts a std_logic to a string.
  function to_string(arg: std_logic) return string is
    variable result : string(1 downto 1);
  begin
    case arg is
      when 'U' => result := "U";
      when 'X' => result := "X";
      when '0' => result := "0";
      when '1' => result := "1";
      when 'Z' => result := "Z";
      when 'W' => result := "W";
      when 'L' => result := "L";
      when 'H' => result := "H";
      when '-' => result := "-";
      --when others => result := "-";
    end case;
    return result;
  end to_string;


  -- Converts a csw_pkt_tag_type to a string.
  function to_string(arg: csw_pkt_tag_type) return string is
    variable result : string(11 downto 1);
  begin
    case arg is
      when pt_nop         => result := "     pt_nop";
      when pt_payload     => result := " pt_payload";
      when pt_meta        => result := "    pt_meta";
      when pt_metac       => result := "   pt_metac";
      when pt_eoj         => result := "     pt_eoj";
      when pt_status      => result := "  pt_status";
      when pt_register    => result := "pt_register";
      when pt_credit      => result := "  pt_credit";
      when pt_soj         => result := "     pt_soj";
      when pt_error       => result := "   pt_error";
      when pt_regcpl      => result := "  pt_regcpl";
      when pt_reserved    => result := "pt_reserved";
      when pt_eop0        => result := "    pt_eop0";
      when pt_eop1        => result := "    pt_eop1";
      when pt_eop2        => result := "    pt_eop2";
      when pt_eop3        => result := "    pt_eop3";
      when others => null;
    end case;
    return result;
  end to_string;

  -- pragma translate_on

  -- Converts a csw_pkt_tag_type to a std_logic_vector.
  function conv_std_logic_vector(arg: csw_pkt_tag_type) return std_logic_vector is
    variable result : std_logic_vector(3 downto 0);
  begin
    case arg is
      when pt_nop         => result := "0000";
      when pt_payload     => result := "0001";
      when pt_meta        => result := "0010";
      when pt_metac       => result := "0011";
      when pt_eoj         => result := "0100";
      when pt_status      => result := "0101";
      when pt_register    => result := "0110";
      when pt_credit      => result := "0111";
      when pt_soj         => result := "1000";
      when pt_error       => result := "1001";
      when pt_regcpl      => result := "1010";
      when pt_reserved    => result := "1011";
      when pt_eop0        => result := "1100";
      when pt_eop1        => result := "1101";
      when pt_eop2        => result := "1110";
      when pt_eop3        => result := "1111";
      when others         => result := "0000";
    end case;
    return result;
  end conv_std_logic_vector;

end package body cpc_pkg;







