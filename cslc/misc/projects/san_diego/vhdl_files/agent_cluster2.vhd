

-- ----------------------------------------------------------------------------
-- $File: //hw/main/agents/agent_sets_sal/build_500/src/agent_cluster2.vhd $
-- $Revision: #1 $
-- $DateTime: 2008/03/13 17:35:08 $
-- $Author: msapper $
--
-- TARARI CONFIDENTIAL
--
-- COPYRIGHT (c) 2002 TO 2007 BY TARARI, INC. ALL RIGHTS RESERVED.
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

-- IEEE Library
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

-- Work Library
use work.cpc_pkg.all;
use work.agent_cluster2_pkg.all;
use work.cpx_cfg_pkg.all;

entity agent_cluster2 is
  port (
    -- Cluster Clock & Reset
    cluster_clk                : in  std_logic;
    cluster_rst_n              : in  std_logic;

    -- Agent Clock & Reset
    agent_clk                  : in  std_logic;
    agent_rst_n                : in  std_logic;

    -- Interface from CSW to Agents
    cluster_data0_to_agents    : in  csw_data;
    cluster_ptag0_to_agents    : in  csw_pkt_tag_type;
    cluster_data1_to_agents    : in  csw_data;
    cluster_ptag1_to_agents    : in  csw_pkt_tag_type;
    cluster_data2_to_agents    : in  csw_data;
    cluster_ptag2_to_agents    : in  csw_pkt_tag_type;
    cluster_data3_to_agents    : in  csw_data;
    cluster_ptag3_to_agents    : in  csw_pkt_tag_type;
    cluster_dev_id_to_agents   : in  csw_dev_id;
    cluster_wr_to_agents       : in  std_logic;

    -- Interface from Agents to CSW
    cluster_data0_from_agents  : out csw_data;
    cluster_ptag0_from_agents  : out csw_pkt_tag_type;
    cluster_data1_from_agents  : out csw_data;
    cluster_ptag1_from_agents  : out csw_pkt_tag_type;
    cluster_data2_from_agents  : out csw_data;
    cluster_ptag2_from_agents  : out csw_pkt_tag_type;
    cluster_data3_from_agents  : out csw_data;
    cluster_ptag3_from_agents  : out csw_pkt_tag_type;
    cluster_dest_from_agents   : out csw_dest;
    cluster_wr_from_agents     : out std_logic;
    cluster_ready_to_agents    : in  std_logic;

    -- Debug LEDs
    debug_led                  : out std_logic_vector(15 downto 0)
  );
end agent_cluster2;


architecture structure of agent_cluster2 is

  ----------------------------------------
  -- Component Declarations
  ----------------------------------------
  component acc
    generic (
      number_of_agents_c         : integer;
      acc_agent_addr_bits_c      : integer;
      number_of_fifo_in_ports_c  : integer;
      fifo_in_ports_bits_c       : integer;
      number_of_fifo_out_ports_c : integer;
      fifo_out_ports_bits_c      : integer;
      max_fifo_out_addr_bits_c   : integer;
      max_fifo_ports_per_agt_c   : integer;
      max_credit_ctr_bits_c      : integer;
      include_reg_initiator_c    : boolean
    );
    port (
      -- Cluster Clock & Reset
      cluster_clk                : in  std_logic;
      cluster_rst_n              : in  std_logic;

      -- CPC configuration information
      mem_agt_present_reg        : in  std_logic;
      cpc_num_of_ac_reg          : in  std_logic_vector( 3 downto 0);

      -- Agent Configuration Ports
      agt_qty_of_fifo_in_ports   : in  std_logic_vector((max_ports_per_agt_bits_c * number_of_agents_c) - 1 downto 0);
      agt_qty_of_fifo_out_ports  : in  std_logic_vector((max_ports_per_agt_bits_c * number_of_agents_c) - 1 downto 0);
      agt_fifo_in_ports_base     : in  std_logic_vector((max_fifo_port_id_bits_c * number_of_agents_c) - 1 downto 0);
      agt_fifo_out_ports_base    : in  std_logic_vector((max_fifo_port_id_bits_c * number_of_agents_c) - 1 downto 0);
      agt_fifo_in_type           : in  std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);
      agt_fifo_out_type          : in  std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);
      agt_fifo_in_width          : in  std_logic_vector((2 * number_of_fifo_in_ports_c ) - 1 downto 0);
      agt_fifo_out_width         : in  std_logic_vector((2 * number_of_fifo_out_ports_c ) - 1 downto 0);
      agt_fifo_in_depth          : in  std_logic_vector((4 * number_of_fifo_in_ports_c ) - 1 downto 0);
      agt_fifo_out_depth         : in  std_logic_vector((4 * number_of_fifo_out_ports_c ) - 1 downto 0);

      -- FIFO Port Control Ports
      acc_credit_enable          : out std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);

      -- Agent Control Ports
      -- agent_enable               : out std_logic_vector(number_of_agents_c - 1 downto 0);
      -- agent_sw_rst_n             : out std_logic_vector(number_of_agents_c - 1 downto 0);

      -- Interface from CSW to Agents
      cluster_data0_to_agents    : in  csw_data;
      cluster_ptag0_to_agents    : in  csw_pkt_tag_type;
      cluster_data1_to_agents    : in  csw_data;
      cluster_ptag1_to_agents    : in  csw_pkt_tag_type;
      cluster_data2_to_agents    : in  csw_data;
      cluster_ptag2_to_agents    : in  csw_pkt_tag_type;
      cluster_data3_to_agents    : in  csw_data;
      cluster_ptag3_to_agents    : in  csw_pkt_tag_type;
      cluster_dev_id_to_agents   : in  csw_dev_id;
      cluster_wr_to_agents       : in  std_logic;

      -- Interface from Agents to CSW
      cluster_data0_from_agents  : out csw_data;
      cluster_ptag0_from_agents  : out csw_pkt_tag_type;
      cluster_data1_from_agents  : out csw_data;
      cluster_ptag1_from_agents  : out csw_pkt_tag_type;
      cluster_data2_from_agents  : out csw_data;
      cluster_ptag2_from_agents  : out csw_pkt_tag_type;
      cluster_data3_from_agents  : out csw_data;
      cluster_ptag3_from_agents  : out csw_pkt_tag_type;
      cluster_dest_from_agents   : out csw_dest;
      cluster_wr_from_agents     : out std_logic;
      cluster_ready_to_agents    : in  std_logic;

      -- Agent Side Input FIFO Port Interface
      acc_data0_to_agents        : out csw_data;
      acc_ptag0_to_agents        : out csw_pkt_tag_type;
      acc_data1_to_agents        : out csw_data;
      acc_ptag1_to_agents        : out csw_pkt_tag_type;
      acc_data2_to_agents        : out csw_data;
      acc_ptag2_to_agents        : out csw_pkt_tag_type;
      acc_data3_to_agents        : out csw_data;
      acc_ptag3_to_agents        : out csw_pkt_tag_type;
      acc_wr_to_agents           : out std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);
      fp_full_to_agents          : in  std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);

      -- Data and Packet Tag Signals from the Output FIFO Ports
      fpo_data0_from_agents      : in  std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_ptag0_from_agents      : in  std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_data1_from_agents      : in  std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_ptag1_from_agents      : in  std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_data2_from_agents      : in  std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_ptag2_from_agents      : in  std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_data3_from_agents      : in  std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_ptag3_from_agents      : in  std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
      fpo_empty_from_agents      : in  std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);
      acc_rd_from_agents         : out std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);

      -- Credit Signals from the Input FIFO Ports
      fpi_credit_req             : in  std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);
      fpi_credit_data            : in  std_logic_vector((csw_data_bits_c * number_of_fifo_in_ports_c) - 1 downto 0);
      acc_credit_ack             : out std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);

      -- FIFO Port Status Signals
      fpo_persistent_error       : in  std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);

      -- Agent Read/Write Register Port
      agent_rd_req               : out std_logic_vector(number_of_agents_c - 1 downto 0);
      agent_address              : out std_logic_vector(31 downto 0);
      agent_wr_req               : out std_logic_vector(number_of_agents_c - 1 downto 0);
      agent_wr_data              : out std_logic_vector(31 downto 0);
      agent_ack                  : in  std_logic_vector(number_of_agents_c - 1 downto 0);
      agent_rd_data              : in  std_logic_vector((32 * number_of_agents_c) - 1 downto 0);

      -- Common Register Write Data Busses
      reg_write_data             : in  std_logic_vector(31 downto 0);
      reg_write_dw_addr          : in  std_logic_vector(reg_if_dw_addr_bits_c - 1 downto 0);

      -- Initiator Register I/F
      core_clk                   : in  std_logic;
      core_rst_n                 : in  std_logic;
      ireg_rd                    : in  std_logic;
      ireg_wr                    : in  std_logic;
      ireg_ack                   : out std_logic;
      ireg_read_data             : out std_logic_vector(31 downto 0)
    );
  end component acc;


  component fifo_port32_in
    generic (
      first_fifo_in_addr_bits_c  : integer;
      max_credit_ctr_bits_c      : integer;
      use_bypass_buf_c           : boolean;
      first_n_metas_to_agents    : integer;
      send_all_metac_c           : boolean;
      send_all_status_c          : boolean;
      use_register_file_c        : boolean;
      common_clock               : boolean;
      num_rd_resync_regs         : integer;
      num_wr_resync_regs         : integer
    );
    port (
      -- Cluster Clock & Reset
      cluster_clk                : in  std_logic;
      cluster_rst_n              : in  std_logic;

      -- Agent Clock & Reset
      agent_clk                  : in  std_logic;
      agent_rst_n                : in  std_logic;

      -- ACC Side Interface
      acc_data0_to_agents        : in  csw_data;
      acc_ptag0_to_agents        : in  csw_pkt_tag_type;
      acc_data1_to_agents        : in  csw_data;
      acc_ptag1_to_agents        : in  csw_pkt_tag_type;
      acc_data2_to_agents        : in  csw_data;
      acc_ptag2_to_agents        : in  csw_pkt_tag_type;
      acc_data3_to_agents        : in  csw_data;
      acc_ptag3_to_agents        : in  csw_pkt_tag_type;
      acc_wr_to_agents           : in  std_logic;
      fp_full_to_agents          : out std_logic;

      -- Agent Side Interface
      fp_infifo_pkt_tag          : out csw_pkt_tag_type;
      fp_infifo_data             : out std_logic_vector(31 downto 0);
      fp_infifo_empty            : out std_logic;
      fp_infifo_empty_count      : out std_logic_vector(4 downto 0);
      fp_infifo_rd               : in  std_logic;

      -- Bypass Interface Signals (optional)
      bypass_buf_full            : in  std_logic;
      bypass_buf_wr              : out std_logic;
      bypass_buf_data            : out csw_data;
      bypass_buf_ptag            : out csw_pkt_tag_type;

      -- Credit Signals Between the Output FIFO Port and acc_out
      fpi_credit_frame_data      : out csw_data;
      fpi_credit_frame_req       : out std_logic;
      fpi_credit_frame_ack       : in  std_logic;
      acc_credit_enable          : in  std_logic
    );
  end component fifo_port32_in;



  component fifo_port32_out
    generic (
      second_fifo_in_addr_bits_c : integer;
      use_bypass_buf_c           : boolean;
      bypass_buf_addr_bits_c     : integer;
      use_register_file_c        : boolean;
      common_clock               : boolean;
      num_rd_resync_regs         : integer;
      num_wr_resync_regs         : integer
    );
    port (
      -- Cluster Clock & Reset
      cluster_clk                : in  std_logic;
      cluster_rst_n              : in  std_logic;

      -- Agent Clock & Reset
      agent_clk                  : in  std_logic;
      agent_rst_n                : in  std_logic;

      -- ACC Side Interface
      fpo_data0_from_agents      : out csw_data;
      fpo_ptag0_from_agents      : out csw_pkt_tag_type;
      fpo_data1_from_agents      : out csw_data;
      fpo_ptag1_from_agents      : out csw_pkt_tag_type;
      fpo_data2_from_agents      : out csw_data;
      fpo_ptag2_from_agents      : out csw_pkt_tag_type;
      fpo_data3_from_agents      : out csw_data;
      fpo_ptag3_from_agents      : out csw_pkt_tag_type;
      fpo_empty_from_agents      : out std_logic;
      acc_rd_from_agents         : in  std_logic;

      -- Agent Side Interface
      fp_outfifo_full            : out std_logic;
      fp_outfifo_full_count      : out std_logic_vector(4 downto 0);
      fp_outfifo_data            : in  std_logic_vector(31 downto 0);
      fp_outfifo_pkt_tag         : in  csw_pkt_tag_type;
      fp_outfifo_write           : in  std_logic;

      -- Bypass Interface Signals (optional)
      bypass_buf_full            : out std_logic;
      bypass_buf_wr              : in  std_logic;
      bypass_buf_data            : in  csw_data;
      bypass_buf_ptag            : in  csw_pkt_tag_type;

      -- Error Monitoring Signals
      persistent_error           : out std_logic
    );
  end component fifo_port32_out;


  component dp_fp32_gasket
    port (
      clk                             : in  std_logic;
      rst_n                           : in  std_logic;
      ----------------------------------------------------------
      -- Direct Port
      ----------------------------------------------------------
      -- Direct Port Memory Request Interface
      mem_request                     : in  std_logic;
      mem_request_64                  : in  std_logic;
      mem_read_notwrite               : in  std_logic;
      mem_fid                         : in  std_logic_vector(31 downto 0);
      mem_dword_offset                : in  std_logic_vector(31 downto 2);
      mem_read_dword_length           : in  std_logic_vector(11 downto 0);
      mem_write_data                  : in  std_logic_vector(63 downto 0);
      mem_write_byte_en               : in  std_logic_vector( 7 downto 0);
      mem_read_request_sent           : out std_logic;
      mem_write_accept                : out std_logic;
      mem_disconnect_req              : out std_logic;

      -- Direct Port Memory Return Data Interface
      mem_return_avail                : out std_logic;
      mem_return_avail_64             : out std_logic;
      mem_return_data                 : out std_logic_vector(63 downto 0);
      mem_return_byte_en              : out std_logic_vector(7 downto 0);
      mem_return_data_complete        : out std_logic;

      -- Direct Port OOB Interface
      oob_to_agent_write              : out std_logic;
      oob_to_agent_data               : out std_logic_vector(31 downto 0);
      oob_to_agent_source             : out std_logic_vector( 7 downto 0);
      oob_to_agent_transaction_type   : out std_logic_vector( 3 downto 0);
      oob_from_agent_write            : in  std_logic;
      oob_from_agent_data             : in  std_logic_vector(31 downto 0);
      oob_from_agent_destination      : in  std_logic_vector( 7 downto 0);
      oob_from_agent_transaction_type : in  std_logic_vector( 3 downto 0);
      oob_from_agent_sent             : out std_logic;
      oob_disconnect_req              : out std_logic;

      -- Direct Port Flow Control
      agent_almost_full               : in  std_logic;

      ----------------------------------------------------------
      -- OUTPUT FIFO PORT
      ----------------------------------------------------------
      fpo_full                        : in  std_logic;
      fpo_data                        : out std_logic_vector(31 downto 0);
      fpo_pkt_tag                     : out csw_pkt_tag_type;
      fpo_write                       : out std_logic;

      ----------------------------------------------------------
      -- INPUT FIFO PORT
      ----------------------------------------------------------
      fpi_pkt_tag                     : in  csw_pkt_tag_type;
      fpi_data                        : in  std_logic_vector(31 downto 0);
      fpi_empty                       : in  std_logic;
      fpi_rd                          : out std_logic
    );
  end component dp_fp32_gasket;


  component agent_long_reach
    port (
      -- Clocks and Resets
      cluster_clk               : in  std_logic;
      cluster_rst_n             : in  std_logic;
      agent_clk                 : in  std_logic;
      agent_rst_n               : in  std_logic;

      -- Input FIFO Port 0 to Agent
      fp0_infifo_pkt_tag        : in  csw_pkt_tag_type;
      fp0_infifo_data           : in  std_logic_vector(31 downto 0);
      fp0_infifo_empty          : in  std_logic;
      fp0_infifo_empty_count    : in  std_logic_vector(4 downto 0);
      fp0_infifo_rd             : out std_logic;

      -- Output FIFO Port 0 from Agent
      fp0_outfifo_full          : in  std_logic;
      fp0_outfifo_full_count    : in  std_logic_vector(4 downto 0);
      fp0_outfifo_pkt_tag       : out csw_pkt_tag_type;
      fp0_outfifo_data          : out std_logic_vector(31 downto 0);
      fp0_outfifo_write         : out std_logic;

      -- Input FIFO Port 1 to Agent
      fp1_infifo_pkt_tag        : in  csw_pkt_tag_type;
      fp1_infifo_data           : in  std_logic_vector(31 downto 0);
      fp1_infifo_empty          : in  std_logic;
      fp1_infifo_empty_count    : in  std_logic_vector(4 downto 0);
      fp1_infifo_rd             : out std_logic;

      -- Output FIFO Port 1 from Agent
      fp1_outfifo_full          : in  std_logic;
      fp1_outfifo_full_count    : in  std_logic_vector(4 downto 0);
      fp1_outfifo_pkt_tag       : out csw_pkt_tag_type;
      fp1_outfifo_data          : out std_logic_vector(31 downto 0);
      fp1_outfifo_write         : out std_logic;

      -- Input FIFO Port 2 to Agent
      fp2_infifo_pkt_tag        : in  csw_pkt_tag_type;
      fp2_infifo_data           : in  std_logic_vector(31 downto 0);
      fp2_infifo_empty          : in  std_logic;
      fp2_infifo_empty_count    : in  std_logic_vector(4 downto 0);
      fp2_infifo_rd             : out std_logic;

      -- Output FIFO Port 2 from Agent
      fp2_outfifo_full          : in  std_logic;
      fp2_outfifo_full_count    : in  std_logic_vector(4 downto 0);
      fp2_outfifo_pkt_tag       : out csw_pkt_tag_type;
      fp2_outfifo_data          : out std_logic_vector(31 downto 0);
      fp2_outfifo_write         : out std_logic;

      ---- Direct Port ----
      -- Direct Port Memory Request Interface
      mem_request               : out std_logic;
      mem_request_64            : out std_logic;
      mem_read_notwrite         : out std_logic;
      mem_fid                   : out std_logic_vector(31 downto 0);
      mem_dword_offset          : out std_logic_vector(31 downto 2);
      mem_read_dword_length     : out std_logic_vector(11 downto 0);
      mem_write_data            : out std_logic_vector(63 downto 0);
      mem_write_byte_en         : out std_logic_vector( 7 downto 0);
      mem_read_request_sent     : in  std_logic;
      mem_write_accept          : in  std_logic;
      mem_disconnect_req        : in  std_logic;

      -- Direct Port Memory Return Data Interface
      mem_return_avail          : in  std_logic;
      mem_return_avail_64       : in  std_logic;
      mem_return_data           : in  std_logic_vector(63 downto 0);
      mem_return_byte_en        : in  std_logic_vector(7 downto 0);
      mem_return_data_complete  : in  std_logic;

      -- Agent Read/Write Register Port
      agent_rd_req              : in  std_logic;
      agent_address             : in  std_logic_vector(31 downto 0);
      agent_rd_data             : out std_logic_vector(31 downto 0);
      agent_wr_req              : in  std_logic;
      agent_wr_data             : in  std_logic_vector(31 downto 0);
      agent_ack                 : out std_logic;

      -- Debug LEDs
      debug_led                 : out std_logic_vector(7 downto 0)
    );
  end component agent_long_reach;

  component loopback32_agent
    port (
      -- Clocks and Resets
      cluster_clk               : in  std_logic;
      cluster_rst_n             : in  std_logic;
      agent_clk                 : in  std_logic;
      agent_rst_n               : in  std_logic;

      -- Input FIFO Port 0 to Agent
      fp0_infifo_pkt_tag        : in  csw_pkt_tag_type;
      fp0_infifo_data           : in  std_logic_vector(31 downto 0);
      fp0_infifo_empty          : in  std_logic;
      fp0_infifo_empty_count    : in  std_logic_vector(4 downto 0);
      fp0_infifo_rd             : out std_logic;

      -- Output FIFO Port 0 from Agent
      fp0_outfifo_full          : in  std_logic;
      fp0_outfifo_full_count    : in  std_logic_vector(4 downto 0);
      fp0_outfifo_pkt_tag       : out csw_pkt_tag_type;
      fp0_outfifo_data          : out std_logic_vector(31 downto 0);
      fp0_outfifo_write         : out std_logic;

      -- Agent Read/Write Register Port
      agent_rd_req              : in  std_logic;
      agent_address             : in  std_logic_vector(31 downto 0);
      agent_rd_data             : out std_logic_vector(31 downto 0);
      agent_wr_req              : in  std_logic;
      agent_wr_data             : in  std_logic_vector(31 downto 0);
      agent_ack                 : out std_logic;

      -- Debug LEDs
      debug_led                 : out std_logic_vector(7 downto 0)
    );
  end component loopback32_agent;


  ----------------------------------------
  -- ACC Signals
  ----------------------------------------
  -- Common Agent Side Input FIFO Port Interface Signals
  signal acc_data0_to_agents        : csw_data;
  signal acc_ptag0_to_agents        : csw_pkt_tag_type;
  signal acc_data1_to_agents        : csw_data;
  signal acc_ptag1_to_agents        : csw_pkt_tag_type;
  signal acc_data2_to_agents        : csw_data;
  signal acc_ptag2_to_agents        : csw_pkt_tag_type;
  signal acc_data3_to_agents        : csw_data;
  signal acc_ptag3_to_agents        : csw_pkt_tag_type;

  -- Aggregated Agent Side Input FIFO Port Interface Signals
  signal acc_wr_to_agents           : std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);
  signal fp_full_to_agents          : std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);

  -- Aggregated Agent Configuration Ports
  signal agt_qty_of_fifo_in_ports   : std_logic_vector((max_ports_per_agt_bits_c * number_of_agents_c) - 1 downto 0);
  signal agt_qty_of_fifo_out_ports  : std_logic_vector((max_ports_per_agt_bits_c * number_of_agents_c) - 1 downto 0);
  signal agt_fifo_in_ports_base     : std_logic_vector((max_fifo_port_id_bits_c * number_of_agents_c) - 1 downto 0);
  signal agt_fifo_out_ports_base    : std_logic_vector((max_fifo_port_id_bits_c * number_of_agents_c) - 1 downto 0);
  signal agt_fifo_in_type           : std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);
  signal agt_fifo_out_type          : std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);
  signal agt_fifo_in_width          : std_logic_vector((2 * number_of_fifo_in_ports_c ) - 1 downto 0);
  signal agt_fifo_out_width         : std_logic_vector((2 * number_of_fifo_out_ports_c ) - 1 downto 0);
  signal agt_fifo_in_depth          : std_logic_vector((4 * number_of_fifo_in_ports_c ) - 1 downto 0);
  signal agt_fifo_out_depth         : std_logic_vector((4 * number_of_fifo_out_ports_c ) - 1 downto 0);
  signal agt_fpo_persistent_error   : std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);

  -- FIFO Port Control Ports
  signal acc_credit_enable          : std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);

  -- Aggregated Data and Packet Tag Signals from the Output FIFO Ports
  signal fpo_data0_from_agents      : std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_ptag0_from_agents      : std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_data1_from_agents      : std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_ptag1_from_agents      : std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_data2_from_agents      : std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_ptag2_from_agents      : std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_data3_from_agents      : std_logic_vector((csw_data_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_ptag3_from_agents      : std_logic_vector((csw_ptag_bits_c * number_of_fifo_out_ports_c) - 1 downto 0);
  signal fpo_empty_from_agents      : std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);
  signal acc_rd_from_agents         : std_logic_vector(number_of_fifo_out_ports_c - 1 downto 0);

  -- Aggregated Credit Signals from the Input FIFO Ports
  signal fpi_credit_req             : std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);
  signal fpi_credit_data            : std_logic_vector((csw_data_bits_c * number_of_fifo_in_ports_c) - 1 downto 0);
  signal acc_credit_ack             : std_logic_vector(number_of_fifo_in_ports_c - 1 downto 0);

  -- Common Agent Register Interface Signals
  signal agent_address              : std_logic_vector(31 downto 0);
  signal agent_wr_data              : std_logic_vector(31 downto 0);

  -- Aggregated Agent Register Interface Signals
  signal agent_rd_req               : std_logic_vector(number_of_agents_c - 1 downto 0);
  signal agent_wr_req               : std_logic_vector(number_of_agents_c - 1 downto 0);
  signal agent_ack                  : std_logic_vector(number_of_agents_c - 1 downto 0);
  signal agent_rd_data              : std_logic_vector((32 * number_of_agents_c) - 1 downto 0);

  ----------------------------------------
  -- Agent 0 Signals
  ----------------------------------------
  -- Agent 0 ACC Register Configuration Signals
  constant agt0_qty_of_fifo_in_ports  : integer := 1;
  constant agt0_qty_of_fifo_out_ports : integer := 1;
  constant agt0_fifo_in_ports_base    : integer := 0;
  constant agt0_fifo_out_ports_base   : integer := 0;

  -- Agent 0 Register Interface
  signal agent0_rd_req                : std_logic;
  signal agent0_rd_data               : std_logic_vector(31 downto 0);
  signal agent0_wr_req                : std_logic;
  signal agent0_ack                   : std_logic;

  -- Agent 0 Debug LEDs
  signal agt0_debug_led               : std_logic_vector(7 downto 0);

  ----------------------------------------
  -- Agent 0 Input FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 0 Input FIFO Port 0 ACC Register Configuration Signals
  constant agt0_fifo_in0_type         : std_logic := '0';
  constant agt0_fifo_in0_width        : std_logic_vector(1 downto 0) := "00";

  -- Agent 0 Input FIFO Port 0 Interface Signals
  signal agt0_acc0_wr_to_agents       : std_logic;
  signal agt0_fp0_full_to_agents      : std_logic;

  -- Agent 0 Input FIFO Port 0 Credit Interface
  signal agt0_fpi0_credit_data        : csw_data;
  signal agt0_fpi0_credit_req         : std_logic;
  signal agt0_acc0_credit_ack         : std_logic;
  signal agt0_fp0_credit_enable       : std_logic;

  -- Agent 0 Input FIFO 0 to Agent
  signal agt0_fp0_infifo_pkt_tag      : csw_pkt_tag_type;
  signal agt0_fp0_infifo_data         : std_logic_vector(31 downto 0);
  signal agt0_fp0_infifo_empty        : std_logic;
  signal agt0_fp0_infifo_empty_count  : std_logic_vector(4 downto 0);
  signal agt0_fp0_infifo_rd           : std_logic;

  ----------------------------------------
  -- Agent 0 Output FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 0 Output FIFO Port 0 ACC Register Configuration Signals
  constant agt0_fifo_out0_type        : std_logic := '0';
  constant agt0_fifo_out0_width       : std_logic_vector(1 downto 0) := "00";

  -- Agent 0 Output FIFO Port 0 Interface
  signal agt0_fpo0_data0_from_agents  : csw_data;
  signal agt0_fpo0_ptag0_from_agents  : csw_pkt_tag_type;
  signal agt0_fpo0_data1_from_agents  : csw_data;
  signal agt0_fpo0_ptag1_from_agents  : csw_pkt_tag_type;
  signal agt0_fpo0_data2_from_agents  : csw_data;
  signal agt0_fpo0_ptag2_from_agents  : csw_pkt_tag_type;
  signal agt0_fpo0_data3_from_agents  : csw_data;
  signal agt0_fpo0_ptag3_from_agents  : csw_pkt_tag_type;
  signal agt0_fpo0_empty_from_agents  : std_logic;
  signal agt0_acc0_rd_from_agents     : std_logic;

  -- Agent 0 Output FIFO 0 from Agent
  signal agt0_fp0_outfifo_full        : std_logic;
  signal agt0_fp0_outfifo_full_count  : std_logic_vector(4 downto 0);
  signal agt0_fp0_outfifo_data        : std_logic_vector(31 downto 0);
  signal agt0_fp0_outfifo_pkt_tag     : csw_pkt_tag_type;
  signal agt0_fp0_outfifo_write       : std_logic;

  ----------------------------------------
  -- Agent 0 FIFO Port 0 Bypass Signals
  ----------------------------------------
  -- Agent 0 Input FIFO Port 0 to Output FIFO Port 0 Bypass Interface
  signal agt0_fp0_bypass_buf_full     : std_logic;
  signal agt0_fp0_bypass_buf_wr       : std_logic;
  signal agt0_fp0_bypass_buf_data     : csw_data;
  signal agt0_fp0_bypass_buf_ptag     : csw_pkt_tag_type;

  signal agt0_fpo0_persistent_error   : std_logic;

  ----------------------------------------
  -- Agent 1 Signals
  ----------------------------------------
  -- Agent 1 ACC Register Configuration Signals
  constant agt1_qty_of_fifo_in_ports  : integer := 1;
  constant agt1_qty_of_fifo_out_ports : integer := 1;
  constant agt1_fifo_in_ports_base    : integer := 1;
  constant agt1_fifo_out_ports_base   : integer := 1;

  -- Agent 1 Register Interface
  signal agent1_rd_req                : std_logic;
  signal agent1_rd_data               : std_logic_vector(31 downto 0);
  signal agent1_wr_req                : std_logic;
  signal agent1_ack                   : std_logic;

  -- Agent 1 Debug LEDs
  signal agt1_debug_led               : std_logic_vector(7 downto 0);

  ----------------------------------------
  -- Agent 1 Input FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 1 Input FIFO Port 0 ACC Register Configuration Signals
  constant agt1_fifo_in0_type         : std_logic := '0';
  constant agt1_fifo_in0_width        : std_logic_vector(1 downto 0) := "00";

  -- Agent 1 Input FIFO Port 0 Interface Signals
  signal agt1_acc0_wr_to_agents       : std_logic;
  signal agt1_fp0_full_to_agents      : std_logic;

  -- Agent 1 Input FIFO Port 0 Credit Interface
  signal agt1_fpi0_credit_data        : csw_data;
  signal agt1_fpi0_credit_req         : std_logic;
  signal agt1_acc0_credit_ack         : std_logic;
  signal agt1_fp0_credit_enable       : std_logic;

  -- Agent 1 Input FIFO 0 to Agent
  signal agt1_fp0_infifo_pkt_tag      : csw_pkt_tag_type;
  signal agt1_fp0_infifo_data         : std_logic_vector(31 downto 0);
  signal agt1_fp0_infifo_empty        : std_logic;
  signal agt1_fp0_infifo_empty_count  : std_logic_vector(4 downto 0);
  signal agt1_fp0_infifo_rd           : std_logic;

  ----------------------------------------
  -- Agent 1 Output FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 1 Output FIFO Port 0 ACC Register Configuration Signals
  constant agt1_fifo_out0_type        : std_logic := '0';
  constant agt1_fifo_out0_width       : std_logic_vector(1 downto 0) := "00";

  -- Agent 1 Output FIFO Port 0 Interface
  signal agt1_fpo0_data0_from_agents  : csw_data;
  signal agt1_fpo0_ptag0_from_agents  : csw_pkt_tag_type;
  signal agt1_fpo0_data1_from_agents  : csw_data;
  signal agt1_fpo0_ptag1_from_agents  : csw_pkt_tag_type;
  signal agt1_fpo0_data2_from_agents  : csw_data;
  signal agt1_fpo0_ptag2_from_agents  : csw_pkt_tag_type;
  signal agt1_fpo0_data3_from_agents  : csw_data;
  signal agt1_fpo0_ptag3_from_agents  : csw_pkt_tag_type;
  signal agt1_fpo0_empty_from_agents  : std_logic;
  signal agt1_acc0_rd_from_agents     : std_logic;

  -- Agent 1 Output FIFO 0 from Agent
  signal agt1_fp0_outfifo_full        : std_logic;
  signal agt1_fp0_outfifo_full_count  : std_logic_vector(4 downto 0);
  signal agt1_fp0_outfifo_data        : std_logic_vector(31 downto 0);
  signal agt1_fp0_outfifo_pkt_tag     : csw_pkt_tag_type;
  signal agt1_fp0_outfifo_write       : std_logic;

  ----------------------------------------
  -- Agent 1 FIFO Port 0 Bypass Signals
  ----------------------------------------
  -- Agent 1 Input FIFO Port 0 to Output FIFO Port 0 Bypass Interface
  signal agt1_fp0_bypass_buf_full     : std_logic;
  signal agt1_fp0_bypass_buf_wr       : std_logic;
  signal agt1_fp0_bypass_buf_data     : csw_data;
  signal agt1_fp0_bypass_buf_ptag     : csw_pkt_tag_type;

  signal agt1_fpo0_persistent_error   : std_logic;

  ----------------------------------------
  -- Agent 2 Signals
  ----------------------------------------
  -- Agent 2 ACC Register Configuration Signals
  constant agt2_qty_of_fifo_in_ports  : integer := 1;
  constant agt2_qty_of_fifo_out_ports : integer := 1;
  constant agt2_fifo_in_ports_base    : integer := 2;
  constant agt2_fifo_out_ports_base   : integer := 2;

  -- Agent 2 Register Interface
  signal agent2_rd_req                : std_logic;
  signal agent2_rd_data               : std_logic_vector(31 downto 0);
  signal agent2_wr_req                : std_logic;
  signal agent2_ack                   : std_logic;

  -- Agent 2 Debug LEDs
  signal agt2_debug_led               : std_logic_vector(7 downto 0);

  ----------------------------------------
  -- Agent 2 Input FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 2 Input FIFO Port 0 ACC Register Configuration Signals
  constant agt2_fifo_in0_type         : std_logic := '0';
  constant agt2_fifo_in0_width        : std_logic_vector(1 downto 0) := "00";

  -- Agent 2 Input FIFO Port 0 Interface Signals
  signal agt2_acc0_wr_to_agents       : std_logic;
  signal agt2_fp0_full_to_agents      : std_logic;

  -- Agent 2 Input FIFO Port 0 Credit Interface
  signal agt2_fpi0_credit_data        : csw_data;
  signal agt2_fpi0_credit_req         : std_logic;
  signal agt2_acc0_credit_ack         : std_logic;
  signal agt2_fp0_credit_enable       : std_logic;

  -- Agent 2 Input FIFO 0 to Agent
  signal agt2_fp0_infifo_pkt_tag      : csw_pkt_tag_type;
  signal agt2_fp0_infifo_data         : std_logic_vector(31 downto 0);
  signal agt2_fp0_infifo_empty        : std_logic;
  signal agt2_fp0_infifo_empty_count  : std_logic_vector(4 downto 0);
  signal agt2_fp0_infifo_rd           : std_logic;

  ----------------------------------------
  -- Agent 2 Output FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 2 Output FIFO Port 0 ACC Register Configuration Signals
  constant agt2_fifo_out0_type        : std_logic := '0';
  constant agt2_fifo_out0_width       : std_logic_vector(1 downto 0) := "00";

  -- Agent 2 Output FIFO Port 0 Interface
  signal agt2_fpo0_data0_from_agents  : csw_data;
  signal agt2_fpo0_ptag0_from_agents  : csw_pkt_tag_type;
  signal agt2_fpo0_data1_from_agents  : csw_data;
  signal agt2_fpo0_ptag1_from_agents  : csw_pkt_tag_type;
  signal agt2_fpo0_data2_from_agents  : csw_data;
  signal agt2_fpo0_ptag2_from_agents  : csw_pkt_tag_type;
  signal agt2_fpo0_data3_from_agents  : csw_data;
  signal agt2_fpo0_ptag3_from_agents  : csw_pkt_tag_type;
  signal agt2_fpo0_empty_from_agents  : std_logic;
  signal agt2_acc0_rd_from_agents     : std_logic;

  -- Agent 2 Output FIFO 0 from Agent
  signal agt2_fp0_outfifo_full        : std_logic;
  signal agt2_fp0_outfifo_full_count  : std_logic_vector(4 downto 0);
  signal agt2_fp0_outfifo_data        : std_logic_vector(31 downto 0);
  signal agt2_fp0_outfifo_pkt_tag     : csw_pkt_tag_type;
  signal agt2_fp0_outfifo_write       : std_logic;

  ----------------------------------------
  -- Agent 2 FIFO Port 0 Bypass Signals
  ----------------------------------------
  -- Agent 2 Input FIFO Port 0 to Output FIFO Port 0 Bypass Interface
  signal agt2_fp0_bypass_buf_full     : std_logic;
  signal agt2_fp0_bypass_buf_wr       : std_logic;
  signal agt2_fp0_bypass_buf_data     : csw_data;
  signal agt2_fp0_bypass_buf_ptag     : csw_pkt_tag_type;

  signal agt2_fpo0_persistent_error   : std_logic;

  ----------------------------------------
  -- Agent 3 Signals
  ----------------------------------------
  -- Agent 3 ACC Register Configuration Signals
  constant agt3_qty_of_fifo_in_ports  : integer := 1;
  constant agt3_qty_of_fifo_out_ports : integer := 1;
  constant agt3_fifo_in_ports_base    : integer := 3;
  constant agt3_fifo_out_ports_base   : integer := 3;

  -- Agent 3 Register Interface
  signal agent3_rd_req                : std_logic;
  signal agent3_rd_data               : std_logic_vector(31 downto 0);
  signal agent3_wr_req                : std_logic;
  signal agent3_ack                   : std_logic;

  -- Agent 3 Debug LEDs
  signal agt3_debug_led               : std_logic_vector(7 downto 0);

  ----------------------------------------
  -- Agent 3 Input FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 3 Input FIFO Port 0 ACC Register Configuration Signals
  constant agt3_fifo_in0_type         : std_logic := '0';
  constant agt3_fifo_in0_width        : std_logic_vector(1 downto 0) := "00";

  -- Agent 3 Input FIFO Port 0 Interface Signals
  signal agt3_acc0_wr_to_agents       : std_logic;
  signal agt3_fp0_full_to_agents      : std_logic;

  -- Agent 3 Input FIFO Port 0 Credit Interface
  signal agt3_fpi0_credit_data        : csw_data;
  signal agt3_fpi0_credit_req         : std_logic;
  signal agt3_acc0_credit_ack         : std_logic;
  signal agt3_fp0_credit_enable       : std_logic;

  -- Agent 3 Input FIFO 0 to Agent
  signal agt3_fp0_infifo_pkt_tag      : csw_pkt_tag_type;
  signal agt3_fp0_infifo_data         : std_logic_vector(31 downto 0);
  signal agt3_fp0_infifo_empty        : std_logic;
  signal agt3_fp0_infifo_empty_count  : std_logic_vector(4 downto 0);
  signal agt3_fp0_infifo_rd           : std_logic;

  ----------------------------------------
  -- Agent 3 Output FIFO Port 0 Signals
  ----------------------------------------
  -- Agent 3 Output FIFO Port 0 ACC Register Configuration Signals
  constant agt3_fifo_out0_type        : std_logic := '0';
  constant agt3_fifo_out0_width       : std_logic_vector(1 downto 0) := "00";

  -- Agent 3 Output FIFO Port 0 Interface
  signal agt3_fpo0_data0_from_agents  : csw_data;
  signal agt3_fpo0_ptag0_from_agents  : csw_pkt_tag_type;
  signal agt3_fpo0_data1_from_agents  : csw_data;
  signal agt3_fpo0_ptag1_from_agents  : csw_pkt_tag_type;
  signal agt3_fpo0_data2_from_agents  : csw_data;
  signal agt3_fpo0_ptag2_from_agents  : csw_pkt_tag_type;
  signal agt3_fpo0_data3_from_agents  : csw_data;
  signal agt3_fpo0_ptag3_from_agents  : csw_pkt_tag_type;
  signal agt3_fpo0_empty_from_agents  : std_logic;
  signal agt3_acc0_rd_from_agents     : std_logic;

  -- Agent 3 Output FIFO 0 from Agent
  signal agt3_fp0_outfifo_full        : std_logic;
  signal agt3_fp0_outfifo_full_count  : std_logic_vector(4 downto 0);
  signal agt3_fp0_outfifo_data        : std_logic_vector(31 downto 0);
  signal agt3_fp0_outfifo_pkt_tag     : csw_pkt_tag_type;
  signal agt3_fp0_outfifo_write       : std_logic;

  ----------------------------------------
  -- Agent 3 FIFO Port 0 Bypass Signals
  ----------------------------------------
  -- Agent 3 Input FIFO Port 0 to Output FIFO Port 0 Bypass Interface
  signal agt3_fp0_bypass_buf_full     : std_logic;
  signal agt3_fp0_bypass_buf_wr       : std_logic;
  signal agt3_fp0_bypass_buf_data     : csw_data;
  signal agt3_fp0_bypass_buf_ptag     : csw_pkt_tag_type;

  signal agt3_fpo0_persistent_error   : std_logic;


begin

  ----------------------------------------
  -- Agent 0 Connections
  ----------------------------------------
  -- Map Agent Registers ports to concatenated busses for the acc_reg
  agent0_wr_req      <= agent_wr_req(0);
  agent0_rd_req      <= agent_rd_req(0);
  agent_ack(0)       <= agent0_ack;
  agent_rd_data((0 * 32) + 31 downto (0 * 32))  <= agent0_rd_data;

  -- Map the ACC Configuration Register Ports to concatenated busses.
  agt_qty_of_fifo_in_ports((0 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                           (0 * max_ports_per_agt_bits_c)) <=
                           conv_std_logic_vector(agt0_qty_of_fifo_in_ports, max_ports_per_agt_bits_c);

  agt_qty_of_fifo_out_ports((0 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                            (0 * max_ports_per_agt_bits_c)) <=
                            conv_std_logic_vector(agt0_qty_of_fifo_out_ports, max_ports_per_agt_bits_c);

  agt_fifo_in_ports_base((0 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                         (0 * max_fifo_port_id_bits_c)) <=
                         conv_std_logic_vector(agt0_fifo_in_ports_base, max_fifo_port_id_bits_c);

  agt_fifo_out_ports_base((0 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                          (0 * max_fifo_port_id_bits_c)) <=
                          conv_std_logic_vector(agt0_fifo_out_ports_base, max_fifo_port_id_bits_c);

  agt_fpo_persistent_error(0) <= agt0_fpo0_persistent_error;

  ----------------------------------------------
  -- Agent 0, Input FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 0, Input FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_in_type(0)                             <= agt0_fifo_in0_type;
  agt_fifo_in_width((0 * 2) + 1 downto (0 * 2))   <= agt0_fifo_in0_width;
  agt_fifo_in_depth((0 * 4) + 3 downto (0 * 4))   <= conv_std_logic_vector(agt0_fifo_in0_depth, 4);

  -- Agent 0, Input FIFO Port 0 Credit Interface Connections with the ACC.
  agt0_fp0_credit_enable <= acc_credit_enable(0);

  fpi_credit_req(0)  <= agt0_fpi0_credit_req;

  fpi_credit_data((0 * csw_data_bits_c) + (csw_data_bits_c - 1) downto (0 * csw_data_bits_c)) <=
    agt0_fpi0_credit_data;

  agt0_acc0_credit_ack    <= acc_credit_ack(0);

  -- Map Input FIFO Port Control Signals from acc top level to concatenated busses for the acc_in.
  -- The data and packet tag connections are common to all Input FIFO ports.
  agt0_acc0_wr_to_agents <= acc_wr_to_agents(0);
  fp_full_to_agents(0)   <= agt0_fp0_full_to_agents;

  ----------------------------------------------
  -- Agent 0, Output FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 0, Output FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_out_type(0)                            <= agt0_fifo_out0_type;
  agt_fifo_out_width((0 * 2) + 1 downto (0 * 2))  <= agt0_fifo_out0_width;
  agt_fifo_out_depth((0 * 4) + 3 downto (0 * 4))  <= conv_std_logic_vector(agt0_fifo_out0_depth, 4);

  -- Map Output FIFO Port Signals from acc top level to concatenated busses for the acc_out
  fpo_data0_from_agents((0 * 32) + 31 downto (0 * 32))  <= agt0_fpo0_data0_from_agents;
  fpo_ptag0_from_agents((0 *  4) +  3 downto (0 *  4))  <= conv_csw_pkt_tag(agt0_fpo0_ptag0_from_agents);
  fpo_data1_from_agents((0 * 32) + 31 downto (0 * 32))  <= agt0_fpo0_data1_from_agents;
  fpo_ptag1_from_agents((0 *  4) +  3 downto (0 *  4))  <= conv_csw_pkt_tag(agt0_fpo0_ptag1_from_agents);
  fpo_data2_from_agents((0 * 32) + 31 downto (0 * 32))  <= agt0_fpo0_data2_from_agents;
  fpo_ptag2_from_agents((0 *  4) +  3 downto (0 *  4))  <= conv_csw_pkt_tag(agt0_fpo0_ptag2_from_agents);
  fpo_data3_from_agents((0 * 32) + 31 downto (0 * 32))  <= agt0_fpo0_data3_from_agents;
  fpo_ptag3_from_agents((0 *  4) +  3 downto (0 *  4))  <= conv_csw_pkt_tag(agt0_fpo0_ptag3_from_agents);
  fpo_empty_from_agents(0)                              <= agt0_fpo0_empty_from_agents;
  agt0_acc0_rd_from_agents                              <= acc_rd_from_agents(0);

  ----------------------------------------
  -- Agent 1 Connections
  ----------------------------------------
  -- Map Agent Registers ports to concatenated busses for the acc_reg
  agent1_wr_req      <= agent_wr_req(1);
  agent1_rd_req      <= agent_rd_req(1);
  agent_ack(1)       <= agent1_ack;
  agent_rd_data((1 * 32) + 31 downto (1 * 32))  <= agent1_rd_data;

  -- Map the ACC Configuration Register Ports to concatenated busses.
  agt_qty_of_fifo_in_ports((1 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                           (1 * max_ports_per_agt_bits_c)) <=
                           conv_std_logic_vector(agt1_qty_of_fifo_in_ports, max_ports_per_agt_bits_c);

  agt_qty_of_fifo_out_ports((1 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                            (1 * max_ports_per_agt_bits_c)) <=
                            conv_std_logic_vector(agt1_qty_of_fifo_out_ports, max_ports_per_agt_bits_c);

  agt_fifo_in_ports_base((1 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                         (1 * max_fifo_port_id_bits_c)) <=
                         conv_std_logic_vector(agt1_fifo_in_ports_base, max_fifo_port_id_bits_c);

  agt_fifo_out_ports_base((1 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                          (1 * max_fifo_port_id_bits_c)) <=
                          conv_std_logic_vector(agt1_fifo_out_ports_base, max_fifo_port_id_bits_c);

  agt_fpo_persistent_error(1) <= agt1_fpo0_persistent_error;

  ----------------------------------------------
  -- Agent 1, Input FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 1, Input FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_in_type(1)                             <= agt1_fifo_in0_type;
  agt_fifo_in_width((1 * 2) + 1 downto (1 * 2))   <= agt1_fifo_in0_width;
  agt_fifo_in_depth((1 * 4) + 3 downto (1 * 4))   <= conv_std_logic_vector(agt1_fifo_in0_depth, 4);

  -- Agent 1, Input FIFO Port 0 Credit Interface Connections with the ACC.
  agt1_fp0_credit_enable <= acc_credit_enable(1);

  fpi_credit_req(1)  <= agt1_fpi0_credit_req;

  fpi_credit_data((1 * csw_data_bits_c) + (csw_data_bits_c - 1) downto (1 * csw_data_bits_c)) <=
    agt1_fpi0_credit_data;

  agt1_acc0_credit_ack    <= acc_credit_ack(1);

  -- Map Input FIFO Port Control Signals from acc top level to concatenated busses for the acc_in.
  -- The data and packet tag connections are common to all Input FIFO ports.
  agt1_acc0_wr_to_agents <= acc_wr_to_agents(1);
  fp_full_to_agents(1)   <= agt1_fp0_full_to_agents;

  ----------------------------------------------
  -- Agent 1, Output FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 1, Output FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_out_type(1)                            <= agt1_fifo_out0_type;
  agt_fifo_out_width((1 * 2) + 1 downto (1 * 2))  <= agt1_fifo_out0_width;
  agt_fifo_out_depth((1 * 4) + 3 downto (1 * 4))  <= conv_std_logic_vector(agt1_fifo_out0_depth, 4);

  -- Map Output FIFO Port Signals from acc top level to concatenated busses for the acc_out
  fpo_data0_from_agents((1 * 32) + 31 downto (1 * 32))  <= agt1_fpo0_data0_from_agents;
  fpo_ptag0_from_agents((1 *  4) +  3 downto (1 *  4))  <= conv_csw_pkt_tag(agt1_fpo0_ptag0_from_agents);
  fpo_data1_from_agents((1 * 32) + 31 downto (1 * 32))  <= agt1_fpo0_data1_from_agents;
  fpo_ptag1_from_agents((1 *  4) +  3 downto (1 *  4))  <= conv_csw_pkt_tag(agt1_fpo0_ptag1_from_agents);
  fpo_data2_from_agents((1 * 32) + 31 downto (1 * 32))  <= agt1_fpo0_data2_from_agents;
  fpo_ptag2_from_agents((1 *  4) +  3 downto (1 *  4))  <= conv_csw_pkt_tag(agt1_fpo0_ptag2_from_agents);
  fpo_data3_from_agents((1 * 32) + 31 downto (1 * 32))  <= agt1_fpo0_data3_from_agents;
  fpo_ptag3_from_agents((1 *  4) +  3 downto (1 *  4))  <= conv_csw_pkt_tag(agt1_fpo0_ptag3_from_agents);
  fpo_empty_from_agents(1)                              <= agt1_fpo0_empty_from_agents;
  agt1_acc0_rd_from_agents                              <= acc_rd_from_agents(1);

  ----------------------------------------
  -- Agent 2 Connections
  ----------------------------------------
  -- Map Agent Registers ports to concatenated busses for the acc_reg
  agent2_wr_req      <= agent_wr_req(2);
  agent2_rd_req      <= agent_rd_req(2);
  agent_ack(2)       <= agent2_ack;
  agent_rd_data((2 * 32) + 31 downto (2 * 32))  <= agent2_rd_data;

  -- Map the ACC Configuration Register Ports to concatenated busses.
  agt_qty_of_fifo_in_ports((2 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                           (2 * max_ports_per_agt_bits_c)) <=
                           conv_std_logic_vector(agt2_qty_of_fifo_in_ports, max_ports_per_agt_bits_c);

  agt_qty_of_fifo_out_ports((2 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                            (2 * max_ports_per_agt_bits_c)) <=
                            conv_std_logic_vector(agt2_qty_of_fifo_out_ports, max_ports_per_agt_bits_c);

  agt_fifo_in_ports_base((2 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                         (2 * max_fifo_port_id_bits_c)) <=
                         conv_std_logic_vector(agt2_fifo_in_ports_base, max_fifo_port_id_bits_c);

  agt_fifo_out_ports_base((2 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                          (2 * max_fifo_port_id_bits_c)) <=
                          conv_std_logic_vector(agt2_fifo_out_ports_base, max_fifo_port_id_bits_c);

  agt_fpo_persistent_error(2) <= agt2_fpo0_persistent_error;

  ----------------------------------------------
  -- Agent 2, Input FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 2, Input FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_in_type(2)                             <= agt2_fifo_in0_type;
  agt_fifo_in_width((2 * 2) + 1 downto (2 * 2))   <= agt2_fifo_in0_width;
  agt_fifo_in_depth((2 * 4) + 3 downto (2 * 4))   <= conv_std_logic_vector(agt2_fifo_in0_depth, 4);

  -- Agent 2, Input FIFO Port 0 Credit Interface Connections with the ACC.
  agt2_fp0_credit_enable <= acc_credit_enable(2);

  fpi_credit_req(2)  <= agt2_fpi0_credit_req;

  fpi_credit_data((2 * csw_data_bits_c) + (csw_data_bits_c - 1) downto (2 * csw_data_bits_c)) <=
    agt2_fpi0_credit_data;

  agt2_acc0_credit_ack    <= acc_credit_ack(2);

  -- Map Input FIFO Port Control Signals from acc top level to concatenated busses for the acc_in.
  -- The data and packet tag connections are common to all Input FIFO ports.
  agt2_acc0_wr_to_agents <= acc_wr_to_agents(2);
  fp_full_to_agents(2)   <= agt2_fp0_full_to_agents;

  ----------------------------------------------
  -- Agent 2, Output FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 2, Output FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_out_type(2)                            <= agt2_fifo_out0_type;
  agt_fifo_out_width((2 * 2) + 1 downto (2 * 2))  <= agt2_fifo_out0_width;
  agt_fifo_out_depth((2 * 4) + 3 downto (2 * 4))  <= conv_std_logic_vector(agt2_fifo_out0_depth, 4);

  -- Map Output FIFO Port Signals from acc top level to concatenated busses for the acc_out
  fpo_data0_from_agents((2 * 32) + 31 downto (2 * 32))  <= agt2_fpo0_data0_from_agents;
  fpo_ptag0_from_agents((2 *  4) +  3 downto (2 *  4))  <= conv_csw_pkt_tag(agt2_fpo0_ptag0_from_agents);
  fpo_data1_from_agents((2 * 32) + 31 downto (2 * 32))  <= agt2_fpo0_data1_from_agents;
  fpo_ptag1_from_agents((2 *  4) +  3 downto (2 *  4))  <= conv_csw_pkt_tag(agt2_fpo0_ptag1_from_agents);
  fpo_data2_from_agents((2 * 32) + 31 downto (2 * 32))  <= agt2_fpo0_data2_from_agents;
  fpo_ptag2_from_agents((2 *  4) +  3 downto (2 *  4))  <= conv_csw_pkt_tag(agt2_fpo0_ptag2_from_agents);
  fpo_data3_from_agents((2 * 32) + 31 downto (2 * 32))  <= agt2_fpo0_data3_from_agents;
  fpo_ptag3_from_agents((2 *  4) +  3 downto (2 *  4))  <= conv_csw_pkt_tag(agt2_fpo0_ptag3_from_agents);
  fpo_empty_from_agents(2)                              <= agt2_fpo0_empty_from_agents;
  agt2_acc0_rd_from_agents                              <= acc_rd_from_agents(2);

  ----------------------------------------
  -- Agent 3 Connections
  ----------------------------------------
  -- Map Agent Registers ports to concatenated busses for the acc_reg
  agent3_wr_req      <= agent_wr_req(3);
  agent3_rd_req      <= agent_rd_req(3);
  agent_ack(3)       <= agent3_ack;
  agent_rd_data((3 * 32) + 31 downto (3 * 32))  <= agent3_rd_data;

  -- Map the ACC Configuration Register Ports to concatenated busses.
  agt_qty_of_fifo_in_ports((3 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                           (3 * max_ports_per_agt_bits_c)) <=
                           conv_std_logic_vector(agt3_qty_of_fifo_in_ports, max_ports_per_agt_bits_c);

  agt_qty_of_fifo_out_ports((3 * max_ports_per_agt_bits_c) + (max_ports_per_agt_bits_c - 1) downto
                            (3 * max_ports_per_agt_bits_c)) <=
                            conv_std_logic_vector(agt3_qty_of_fifo_out_ports, max_ports_per_agt_bits_c);

  agt_fifo_in_ports_base((3 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                         (3 * max_fifo_port_id_bits_c)) <=
                         conv_std_logic_vector(agt3_fifo_in_ports_base, max_fifo_port_id_bits_c);

  agt_fifo_out_ports_base((3 * max_fifo_port_id_bits_c) + (max_fifo_port_id_bits_c - 1) downto
                          (3 * max_fifo_port_id_bits_c)) <=
                          conv_std_logic_vector(agt3_fifo_out_ports_base, max_fifo_port_id_bits_c);

  agt_fpo_persistent_error(3) <= agt3_fpo0_persistent_error;

  ----------------------------------------------
  -- Agent 3, Input FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 3, Input FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_in_type(3)                             <= agt3_fifo_in0_type;
  agt_fifo_in_width((3 * 2) + 1 downto (3 * 2))   <= agt3_fifo_in0_width;
  agt_fifo_in_depth((3 * 4) + 3 downto (3 * 4))   <= conv_std_logic_vector(agt3_fifo_in0_depth, 4);

  -- Agent 3, Input FIFO Port 0 Credit Interface Connections with the ACC.
  agt3_fp0_credit_enable <= acc_credit_enable(3);

  fpi_credit_req(3)  <= agt3_fpi0_credit_req;

  fpi_credit_data((3 * csw_data_bits_c) + (csw_data_bits_c - 1) downto (3 * csw_data_bits_c)) <=
    agt3_fpi0_credit_data;

  agt3_acc0_credit_ack    <= acc_credit_ack(3);

  -- Map Input FIFO Port Control Signals from acc top level to concatenated busses for the acc_in.
  -- The data and packet tag connections are common to all Input FIFO ports.
  agt3_acc0_wr_to_agents <= acc_wr_to_agents(3);
  fp_full_to_agents(3)   <= agt3_fp0_full_to_agents;

  ----------------------------------------------
  -- Agent 3, Output FIFO Port 0 Connections
  ----------------------------------------------
  -- Agent 3, Output FIFO Port 0 Configuration Constant Inputs to the ACC
  agt_fifo_out_type(3)                            <= agt3_fifo_out0_type;
  agt_fifo_out_width((3 * 2) + 1 downto (3 * 2))  <= agt3_fifo_out0_width;
  agt_fifo_out_depth((3 * 4) + 3 downto (3 * 4))  <= conv_std_logic_vector(agt3_fifo_out0_depth, 4);

  -- Map Output FIFO Port Signals from acc top level to concatenated busses for the acc_out
  fpo_data0_from_agents((3 * 32) + 31 downto (3 * 32))  <= agt3_fpo0_data0_from_agents;
  fpo_ptag0_from_agents((3 *  4) +  3 downto (3 *  4))  <= conv_csw_pkt_tag(agt3_fpo0_ptag0_from_agents);
  fpo_data1_from_agents((3 * 32) + 31 downto (3 * 32))  <= agt3_fpo0_data1_from_agents;
  fpo_ptag1_from_agents((3 *  4) +  3 downto (3 *  4))  <= conv_csw_pkt_tag(agt3_fpo0_ptag1_from_agents);
  fpo_data2_from_agents((3 * 32) + 31 downto (3 * 32))  <= agt3_fpo0_data2_from_agents;
  fpo_ptag2_from_agents((3 *  4) +  3 downto (3 *  4))  <= conv_csw_pkt_tag(agt3_fpo0_ptag2_from_agents);
  fpo_data3_from_agents((3 * 32) + 31 downto (3 * 32))  <= agt3_fpo0_data3_from_agents;
  fpo_ptag3_from_agents((3 *  4) +  3 downto (3 *  4))  <= conv_csw_pkt_tag(agt3_fpo0_ptag3_from_agents);
  fpo_empty_from_agents(3)                              <= agt3_fpo0_empty_from_agents;
  agt3_acc0_rd_from_agents                              <= acc_rd_from_agents(3);


  I_ACC : acc
    generic map (
      number_of_agents_c         => number_of_agents_c,
      acc_agent_addr_bits_c      => acc_agent_addr_bits_c,
      number_of_fifo_in_ports_c  => number_of_fifo_in_ports_c,
      fifo_in_ports_bits_c       => fifo_in_ports_bits_c,
      number_of_fifo_out_ports_c => number_of_fifo_out_ports_c,
      fifo_out_ports_bits_c      => fifo_out_ports_bits_c,
      max_fifo_out_addr_bits_c   => max_fifo_out_addr_bits_c,
      max_fifo_ports_per_agt_c   => max_fifo_ports_per_agt_c,
      max_credit_ctr_bits_c      => max_credit_ctr_bits_c,
      include_reg_initiator_c    => include_reg_initiator_c
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- CPC configuration information
      mem_agt_present_reg        => cpx_memory_agt_present_c,
      cpc_num_of_ac_reg          => (conv_std_logic_vector(cpx_num_of_agt_clusters_c, 4)),

      -- Agent Configuration Ports
      agt_qty_of_fifo_in_ports   => agt_qty_of_fifo_in_ports,
      agt_qty_of_fifo_out_ports  => agt_qty_of_fifo_out_ports,
      agt_fifo_in_ports_base     => agt_fifo_in_ports_base,
      agt_fifo_out_ports_base    => agt_fifo_out_ports_base,
      agt_fifo_in_type           => agt_fifo_in_type,
      agt_fifo_out_type          => agt_fifo_out_type,
      agt_fifo_in_width          => agt_fifo_in_width,
      agt_fifo_out_width         => agt_fifo_out_width,
      agt_fifo_in_depth          => agt_fifo_in_depth,
      agt_fifo_out_depth         => agt_fifo_out_depth,

      -- FIFO Port Control Ports
      acc_credit_enable          => acc_credit_enable,

      -- Agent Control Ports
      -- agent_enable               => agent_enable,
      -- agent_sw_rst_n             => agent_sw_rst_n,

      -- Interface from CSW to Agents
      cluster_data0_to_agents    => cluster_data0_to_agents,
      cluster_ptag0_to_agents    => cluster_ptag0_to_agents,
      cluster_data1_to_agents    => cluster_data1_to_agents,
      cluster_ptag1_to_agents    => cluster_ptag1_to_agents,
      cluster_data2_to_agents    => cluster_data2_to_agents,
      cluster_ptag2_to_agents    => cluster_ptag2_to_agents,
      cluster_data3_to_agents    => cluster_data3_to_agents,
      cluster_ptag3_to_agents    => cluster_ptag3_to_agents,
      cluster_dev_id_to_agents   => cluster_dev_id_to_agents,
      cluster_wr_to_agents       => cluster_wr_to_agents,

      -- Interface from Agents to CSW
      cluster_data0_from_agents  => cluster_data0_from_agents,
      cluster_ptag0_from_agents  => cluster_ptag0_from_agents,
      cluster_data1_from_agents  => cluster_data1_from_agents,
      cluster_ptag1_from_agents  => cluster_ptag1_from_agents,
      cluster_data2_from_agents  => cluster_data2_from_agents,
      cluster_ptag2_from_agents  => cluster_ptag2_from_agents,
      cluster_data3_from_agents  => cluster_data3_from_agents,
      cluster_ptag3_from_agents  => cluster_ptag3_from_agents,
      cluster_dest_from_agents   => cluster_dest_from_agents,
      --cluster_dest_from_agents   => open,
      cluster_wr_from_agents     => cluster_wr_from_agents,
      cluster_ready_to_agents    => cluster_ready_to_agents,

      -- Agent Side Input FIFO Port Interface
      acc_data0_to_agents        => acc_data0_to_agents,
      acc_ptag0_to_agents        => acc_ptag0_to_agents,
      acc_data1_to_agents        => acc_data1_to_agents,
      acc_ptag1_to_agents        => acc_ptag1_to_agents,
      acc_data2_to_agents        => acc_data2_to_agents,
      acc_ptag2_to_agents        => acc_ptag2_to_agents,
      acc_data3_to_agents        => acc_data3_to_agents,
      acc_ptag3_to_agents        => acc_ptag3_to_agents,
      acc_wr_to_agents           => acc_wr_to_agents,
      fp_full_to_agents          => fp_full_to_agents,

      -- Data and Packet Tag Signals from the Output FIFO Ports
      fpo_data0_from_agents      => fpo_data0_from_agents,
      fpo_ptag0_from_agents      => fpo_ptag0_from_agents,
      fpo_data1_from_agents      => fpo_data1_from_agents,
      fpo_ptag1_from_agents      => fpo_ptag1_from_agents,
      fpo_data2_from_agents      => fpo_data2_from_agents,
      fpo_ptag2_from_agents      => fpo_ptag2_from_agents,
      fpo_data3_from_agents      => fpo_data3_from_agents,
      fpo_ptag3_from_agents      => fpo_ptag3_from_agents,
      fpo_empty_from_agents      => fpo_empty_from_agents,
      acc_rd_from_agents         => acc_rd_from_agents,

      -- Credit Signals from the Input FIFO Ports
      fpi_credit_req             => fpi_credit_req,
      fpi_credit_data            => fpi_credit_data,
      acc_credit_ack             => acc_credit_ack,

      -- FIFO Port Status Signals
      fpo_persistent_error       => agt_fpo_persistent_error,

      -- Agent Read/Write Register Port
      agent_rd_req               => agent_rd_req,
      agent_address              => agent_address,
      agent_wr_req               => agent_wr_req,
      agent_wr_data              => agent_wr_data,
      agent_ack                  => agent_ack,
      agent_rd_data              => agent_rd_data,

      -- Common Register Write Data Busses
      reg_write_data             => (others => '0'),
      reg_write_dw_addr          => (others => '0'),

      -- Initiator Register I/F
      core_clk                   => '0',
      core_rst_n                 => '0',
      ireg_rd                    => '0',
      ireg_wr                    => '0',
      ireg_ack                   => open,
      ireg_read_data             => open
    );


  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  --
  -- Agent 0 Instantiations
  --
  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  ----------------------------------------
  -- Agent 0, Input FIFO Port 0
  ----------------------------------------
  I_AGT0_FP0_IN : fifo_port32_in
    generic map (
      first_fifo_in_addr_bits_c  => agt0_fifo_in0_depth,
      max_credit_ctr_bits_c      => max_credit_ctr_bits_c,
      use_bypass_buf_c           => agt0_fp0_use_bypass_buf,
      first_n_metas_to_agents    => agt0_fpi0_first_n_metas,
      send_all_metac_c           => agt0_fpi0_send_all_metac,
      send_all_status_c          => agt0_fpi0_send_all_status,
      use_register_file_c        => agt0_fpi0_use_reg_file,
      common_clock               => agt0_fpi0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Agent Side Input FIFO Port Interface
      acc_data0_to_agents        => acc_data0_to_agents,
      acc_ptag0_to_agents        => acc_ptag0_to_agents,
      acc_data1_to_agents        => acc_data1_to_agents,
      acc_ptag1_to_agents        => acc_ptag1_to_agents,
      acc_data2_to_agents        => acc_data2_to_agents,
      acc_ptag2_to_agents        => acc_ptag2_to_agents,
      acc_data3_to_agents        => acc_data3_to_agents,
      acc_ptag3_to_agents        => acc_ptag3_to_agents,
      acc_wr_to_agents           => agt0_acc0_wr_to_agents,
      fp_full_to_agents          => agt0_fp0_full_to_agents,

      -- Input FIFO to Agent
      fp_infifo_pkt_tag          => agt0_fp0_infifo_pkt_tag,
      fp_infifo_data             => agt0_fp0_infifo_data,
      fp_infifo_empty            => agt0_fp0_infifo_empty,
      fp_infifo_empty_count      => agt0_fp0_infifo_empty_count,
      fp_infifo_rd               => agt0_fp0_infifo_rd,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt0_fp0_bypass_buf_full,
      bypass_buf_wr              => agt0_fp0_bypass_buf_wr,
      bypass_buf_data            => agt0_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt0_fp0_bypass_buf_ptag,

      -- Credit Signals Between the Output FIFO Port and acc_out.
      fpi_credit_frame_data      => agt0_fpi0_credit_data,
      fpi_credit_frame_req       => agt0_fpi0_credit_req,
      fpi_credit_frame_ack       => agt0_acc0_credit_ack,
      acc_credit_enable          => agt0_fp0_credit_enable
    );


  ----------------------------------------
  -- Agent 0, Output FIFO Port 0
  ----------------------------------------
  I_AGT0_FP0_OUT : fifo_port32_out
    generic map (
      second_fifo_in_addr_bits_c => agt0_fifo_out0_depth,
      use_bypass_buf_c           => agt0_fp0_use_bypass_buf,
      bypass_buf_addr_bits_c     => agt0_fp0_bypass_buf_addr_bits,
      use_register_file_c        => agt0_fpo0_use_reg_file,
      common_clock               => agt0_fpo0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- ACC Side Interface
      fpo_data0_from_agents      => agt0_fpo0_data0_from_agents,
      fpo_ptag0_from_agents      => agt0_fpo0_ptag0_from_agents,
      fpo_data1_from_agents      => agt0_fpo0_data1_from_agents,
      fpo_ptag1_from_agents      => agt0_fpo0_ptag1_from_agents,
      fpo_data2_from_agents      => agt0_fpo0_data2_from_agents,
      fpo_ptag2_from_agents      => agt0_fpo0_ptag2_from_agents,
      fpo_data3_from_agents      => agt0_fpo0_data3_from_agents,
      fpo_ptag3_from_agents      => agt0_fpo0_ptag3_from_agents,
      fpo_empty_from_agents      => agt0_fpo0_empty_from_agents,
      acc_rd_from_agents         => agt0_acc0_rd_from_agents,

      -- Agent Side Interface
      fp_outfifo_full            => agt0_fp0_outfifo_full,
      fp_outfifo_full_count      => agt0_fp0_outfifo_full_count,
      fp_outfifo_data            => agt0_fp0_outfifo_data,
      fp_outfifo_pkt_tag         => agt0_fp0_outfifo_pkt_tag,
      fp_outfifo_write           => agt0_fp0_outfifo_write,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt0_fp0_bypass_buf_full,
      bypass_buf_wr              => agt0_fp0_bypass_buf_wr,
      bypass_buf_data            => agt0_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt0_fp0_bypass_buf_ptag,

      -- Error Monitoring Signals
      persistent_error           => agt0_fpo0_persistent_error
    );


  ----------------------------------------
  -- Agent 0 Instance
  ----------------------------------------
  I_AGENT_0 : loopback32_agent
    port map (
      -- Clocks and Resets
      cluster_clk               => cluster_clk,
      cluster_rst_n             => cluster_rst_n,
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Input FIFO Port 0 to Agent
      fp0_infifo_pkt_tag        => agt0_fp0_infifo_pkt_tag,
      fp0_infifo_data           => agt0_fp0_infifo_data,
      fp0_infifo_empty          => agt0_fp0_infifo_empty,
      fp0_infifo_empty_count    => agt0_fp0_infifo_empty_count,
      fp0_infifo_rd             => agt0_fp0_infifo_rd,

      -- Output FIFO Port 0 from Agent
      fp0_outfifo_full          => agt0_fp0_outfifo_full,
      fp0_outfifo_full_count    => agt0_fp0_outfifo_full_count,
      fp0_outfifo_pkt_tag       => agt0_fp0_outfifo_pkt_tag,
      fp0_outfifo_data          => agt0_fp0_outfifo_data,
      fp0_outfifo_write         => agt0_fp0_outfifo_write,

      -- Agent Read/Write Register Port
      agent_rd_req              => agent0_rd_req,
      agent_address             => agent_address,
      agent_rd_data             => agent0_rd_data,
      agent_wr_req              => agent0_wr_req,
      agent_wr_data             => agent_wr_data,
      agent_ack                 => agent0_ack,

      -- Debug LEDs
      debug_led                 => agt0_debug_led
    );

  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  --
  -- Agent 1 Instantiations
  --
  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  ----------------------------------------
  -- Agent 1, Input FIFO Port 0
  ----------------------------------------
  I_AGT1_FP0_IN : fifo_port32_in
    generic map (
      first_fifo_in_addr_bits_c  => agt1_fifo_in0_depth,
      max_credit_ctr_bits_c      => max_credit_ctr_bits_c,
      use_bypass_buf_c           => agt1_fp0_use_bypass_buf,
      first_n_metas_to_agents    => agt1_fpi0_first_n_metas,
      send_all_metac_c           => agt1_fpi0_send_all_metac,
      send_all_status_c          => agt1_fpi0_send_all_status,
      use_register_file_c        => agt1_fpi0_use_reg_file,
      common_clock               => agt2_fpi0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Agent Side Input FIFO Port Interface
      acc_data0_to_agents        => acc_data0_to_agents,
      acc_ptag0_to_agents        => acc_ptag0_to_agents,
      acc_data1_to_agents        => acc_data1_to_agents,
      acc_ptag1_to_agents        => acc_ptag1_to_agents,
      acc_data2_to_agents        => acc_data2_to_agents,
      acc_ptag2_to_agents        => acc_ptag2_to_agents,
      acc_data3_to_agents        => acc_data3_to_agents,
      acc_ptag3_to_agents        => acc_ptag3_to_agents,
      acc_wr_to_agents           => agt1_acc0_wr_to_agents,
      fp_full_to_agents          => agt1_fp0_full_to_agents,

      -- Input FIFO to Agent
      fp_infifo_pkt_tag          => agt1_fp0_infifo_pkt_tag,
      fp_infifo_data             => agt1_fp0_infifo_data,
      fp_infifo_empty            => agt1_fp0_infifo_empty,
      fp_infifo_empty_count      => agt1_fp0_infifo_empty_count,
      fp_infifo_rd               => agt1_fp0_infifo_rd,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt1_fp0_bypass_buf_full,
      bypass_buf_wr              => agt1_fp0_bypass_buf_wr,
      bypass_buf_data            => agt1_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt1_fp0_bypass_buf_ptag,

      -- Credit Signals Between the Output FIFO Port and acc_out.
      fpi_credit_frame_data      => agt1_fpi0_credit_data,
      fpi_credit_frame_req       => agt1_fpi0_credit_req,
      fpi_credit_frame_ack       => agt1_acc0_credit_ack,
      acc_credit_enable          => agt1_fp0_credit_enable
    );


  ----------------------------------------
  -- Agent 1, Output FIFO Port 0
  ----------------------------------------
  I_AGT1_FP0_OUT : fifo_port32_out
    generic map (
      second_fifo_in_addr_bits_c => agt1_fifo_out0_depth,
      use_bypass_buf_c           => agt1_fp0_use_bypass_buf,
      bypass_buf_addr_bits_c     => agt1_fp0_bypass_buf_addr_bits,
      use_register_file_c        => agt1_fpo0_use_reg_file,
      common_clock               => agt1_fpo0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- ACC Side Interface
      fpo_data0_from_agents      => agt1_fpo0_data0_from_agents,
      fpo_ptag0_from_agents      => agt1_fpo0_ptag0_from_agents,
      fpo_data1_from_agents      => agt1_fpo0_data1_from_agents,
      fpo_ptag1_from_agents      => agt1_fpo0_ptag1_from_agents,
      fpo_data2_from_agents      => agt1_fpo0_data2_from_agents,
      fpo_ptag2_from_agents      => agt1_fpo0_ptag2_from_agents,
      fpo_data3_from_agents      => agt1_fpo0_data3_from_agents,
      fpo_ptag3_from_agents      => agt1_fpo0_ptag3_from_agents,
      fpo_empty_from_agents      => agt1_fpo0_empty_from_agents,
      acc_rd_from_agents         => agt1_acc0_rd_from_agents,

      -- Agent Side Interface
      fp_outfifo_full            => agt1_fp0_outfifo_full,
      fp_outfifo_full_count      => agt1_fp0_outfifo_full_count,
      fp_outfifo_data            => agt1_fp0_outfifo_data,
      fp_outfifo_pkt_tag         => agt1_fp0_outfifo_pkt_tag,
      fp_outfifo_write           => agt1_fp0_outfifo_write,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt1_fp0_bypass_buf_full,
      bypass_buf_wr              => agt1_fp0_bypass_buf_wr,
      bypass_buf_data            => agt1_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt1_fp0_bypass_buf_ptag,

      -- Error Monitoring Signals
      persistent_error           => agt1_fpo0_persistent_error
    );


  ----------------------------------------
  -- Agent 1 Instance
  ----------------------------------------
  I_AGENT_1 : loopback32_agent
    port map (
      -- Clocks and Resets
      cluster_clk               => cluster_clk,
      cluster_rst_n             => cluster_rst_n,
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Input FIFO Port 0 to Agent
      fp0_infifo_pkt_tag        => agt1_fp0_infifo_pkt_tag,
      fp0_infifo_data           => agt1_fp0_infifo_data,
      fp0_infifo_empty          => agt1_fp0_infifo_empty,
      fp0_infifo_empty_count    => agt1_fp0_infifo_empty_count,
      fp0_infifo_rd             => agt1_fp0_infifo_rd,

      -- Output FIFO Port 0 from Agent
      fp0_outfifo_full          => agt1_fp0_outfifo_full,
      fp0_outfifo_full_count    => agt1_fp0_outfifo_full_count,
      fp0_outfifo_pkt_tag       => agt1_fp0_outfifo_pkt_tag,
      fp0_outfifo_data          => agt1_fp0_outfifo_data,
      fp0_outfifo_write         => agt1_fp0_outfifo_write,

      -- Agent Read/Write Register Port
      agent_rd_req              => agent1_rd_req,
      agent_address             => agent_address,
      agent_rd_data             => agent1_rd_data,
      agent_wr_req              => agent1_wr_req,
      agent_wr_data             => agent_wr_data,
      agent_ack                 => agent1_ack,

      -- Debug LEDs
      debug_led                 => agt1_debug_led
    );

  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  --
  -- Agent 2 Instantiations
  --
  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  ----------------------------------------
  -- Agent 2, Input FIFO Port 0
  ----------------------------------------
  I_AGT2_FP0_IN : fifo_port32_in
    generic map (
      first_fifo_in_addr_bits_c  => agt2_fifo_in0_depth,
      max_credit_ctr_bits_c      => max_credit_ctr_bits_c,
      use_bypass_buf_c           => agt2_fp0_use_bypass_buf,
      first_n_metas_to_agents    => agt2_fpi0_first_n_metas,
      send_all_metac_c           => agt2_fpi0_send_all_metac,
      send_all_status_c          => agt2_fpi0_send_all_status,
      use_register_file_c        => agt2_fpi0_use_reg_file,
      common_clock               => agt2_fpi0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Agent Side Input FIFO Port Interface
      acc_data0_to_agents        => acc_data0_to_agents,
      acc_ptag0_to_agents        => acc_ptag0_to_agents,
      acc_data1_to_agents        => acc_data1_to_agents,
      acc_ptag1_to_agents        => acc_ptag1_to_agents,
      acc_data2_to_agents        => acc_data2_to_agents,
      acc_ptag2_to_agents        => acc_ptag2_to_agents,
      acc_data3_to_agents        => acc_data3_to_agents,
      acc_ptag3_to_agents        => acc_ptag3_to_agents,
      acc_wr_to_agents           => agt2_acc0_wr_to_agents,
      fp_full_to_agents          => agt2_fp0_full_to_agents,

      -- Input FIFO to Agent
      fp_infifo_pkt_tag          => agt2_fp0_infifo_pkt_tag,
      fp_infifo_data             => agt2_fp0_infifo_data,
      fp_infifo_empty            => agt2_fp0_infifo_empty,
      fp_infifo_empty_count      => agt2_fp0_infifo_empty_count,
      fp_infifo_rd               => agt2_fp0_infifo_rd,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt2_fp0_bypass_buf_full,
      bypass_buf_wr              => agt2_fp0_bypass_buf_wr,
      bypass_buf_data            => agt2_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt2_fp0_bypass_buf_ptag,

      -- Credit Signals Between the Output FIFO Port and acc_out.
      fpi_credit_frame_data      => agt2_fpi0_credit_data,
      fpi_credit_frame_req       => agt2_fpi0_credit_req,
      fpi_credit_frame_ack       => agt2_acc0_credit_ack,
      acc_credit_enable          => agt2_fp0_credit_enable
    );


  ----------------------------------------
  -- Agent 2, Output FIFO Port 0
  ----------------------------------------
  I_AGT2_FP0_OUT : fifo_port32_out
    generic map (
      second_fifo_in_addr_bits_c => agt2_fifo_out0_depth,
      use_bypass_buf_c           => agt2_fp0_use_bypass_buf,
      bypass_buf_addr_bits_c     => agt2_fp0_bypass_buf_addr_bits,
      use_register_file_c        => agt2_fpo0_use_reg_file,
      common_clock               => agt2_fpo0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- ACC Side Interface
      fpo_data0_from_agents      => agt2_fpo0_data0_from_agents,
      fpo_ptag0_from_agents      => agt2_fpo0_ptag0_from_agents,
      fpo_data1_from_agents      => agt2_fpo0_data1_from_agents,
      fpo_ptag1_from_agents      => agt2_fpo0_ptag1_from_agents,
      fpo_data2_from_agents      => agt2_fpo0_data2_from_agents,
      fpo_ptag2_from_agents      => agt2_fpo0_ptag2_from_agents,
      fpo_data3_from_agents      => agt2_fpo0_data3_from_agents,
      fpo_ptag3_from_agents      => agt2_fpo0_ptag3_from_agents,
      fpo_empty_from_agents      => agt2_fpo0_empty_from_agents,
      acc_rd_from_agents         => agt2_acc0_rd_from_agents,

      -- Agent Side Interface
      fp_outfifo_full            => agt2_fp0_outfifo_full,
      fp_outfifo_full_count      => agt2_fp0_outfifo_full_count,
      fp_outfifo_data            => agt2_fp0_outfifo_data,
      fp_outfifo_pkt_tag         => agt2_fp0_outfifo_pkt_tag,
      fp_outfifo_write           => agt2_fp0_outfifo_write,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt2_fp0_bypass_buf_full,
      bypass_buf_wr              => agt2_fp0_bypass_buf_wr,
      bypass_buf_data            => agt2_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt2_fp0_bypass_buf_ptag,

      -- Error Monitoring Signals
      persistent_error           => agt2_fpo0_persistent_error
    );


  ----------------------------------------
  -- Agent 2 Instance
  ----------------------------------------
  I_AGENT_2 : loopback32_agent
    port map (
      -- Clocks and Resets
      cluster_clk               => cluster_clk,
      cluster_rst_n             => cluster_rst_n,
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Input FIFO Port 0 to Agent
      fp0_infifo_pkt_tag        => agt2_fp0_infifo_pkt_tag,
      fp0_infifo_data           => agt2_fp0_infifo_data,
      fp0_infifo_empty          => agt2_fp0_infifo_empty,
      fp0_infifo_empty_count    => agt2_fp0_infifo_empty_count,
      fp0_infifo_rd             => agt2_fp0_infifo_rd,

      -- Output FIFO Port 0 from Agent
      fp0_outfifo_full          => agt2_fp0_outfifo_full,
      fp0_outfifo_full_count    => agt2_fp0_outfifo_full_count,
      fp0_outfifo_pkt_tag       => agt2_fp0_outfifo_pkt_tag,
      fp0_outfifo_data          => agt2_fp0_outfifo_data,
      fp0_outfifo_write         => agt2_fp0_outfifo_write,

      -- Agent Read/Write Register Port
      agent_rd_req              => agent2_rd_req,
      agent_address             => agent_address,
      agent_rd_data             => agent2_rd_data,
      agent_wr_req              => agent2_wr_req,
      agent_wr_data             => agent_wr_data,
      agent_ack                 => agent2_ack,

      -- Debug LEDs
      debug_led                 => agt2_debug_led
    );

  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  --
  -- Agent 3 Instantiations
  --
  -- $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

  ----------------------------------------
  -- Agent 3, Input FIFO Port 0
  ----------------------------------------
  I_AGT3_FP0_IN : fifo_port32_in
    generic map (
      first_fifo_in_addr_bits_c  => agt3_fifo_in0_depth,
      max_credit_ctr_bits_c      => max_credit_ctr_bits_c,
      use_bypass_buf_c           => agt3_fp0_use_bypass_buf,
      first_n_metas_to_agents    => agt3_fpi0_first_n_metas,
      send_all_metac_c           => agt3_fpi0_send_all_metac,
      send_all_status_c          => agt3_fpi0_send_all_status,
      use_register_file_c        => agt3_fpi0_use_reg_file,
      common_clock               => agt3_fpi0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Agent Side Input FIFO Port Interface
      acc_data0_to_agents        => acc_data0_to_agents,
      acc_ptag0_to_agents        => acc_ptag0_to_agents,
      acc_data1_to_agents        => acc_data1_to_agents,
      acc_ptag1_to_agents        => acc_ptag1_to_agents,
      acc_data2_to_agents        => acc_data2_to_agents,
      acc_ptag2_to_agents        => acc_ptag2_to_agents,
      acc_data3_to_agents        => acc_data3_to_agents,
      acc_ptag3_to_agents        => acc_ptag3_to_agents,
      acc_wr_to_agents           => agt3_acc0_wr_to_agents,
      fp_full_to_agents          => agt3_fp0_full_to_agents,

      -- Input FIFO to Agent
      fp_infifo_pkt_tag          => agt3_fp0_infifo_pkt_tag,
      fp_infifo_data             => agt3_fp0_infifo_data,
      fp_infifo_empty            => agt3_fp0_infifo_empty,
      fp_infifo_empty_count      => agt3_fp0_infifo_empty_count,
      fp_infifo_rd               => agt3_fp0_infifo_rd,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt3_fp0_bypass_buf_full,
      bypass_buf_wr              => agt3_fp0_bypass_buf_wr,
      bypass_buf_data            => agt3_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt3_fp0_bypass_buf_ptag,

      -- Credit Signals Between the Output FIFO Port and acc_out.
      fpi_credit_frame_data      => agt3_fpi0_credit_data,
      fpi_credit_frame_req       => agt3_fpi0_credit_req,
      fpi_credit_frame_ack       => agt3_acc0_credit_ack,
      acc_credit_enable          => agt3_fp0_credit_enable
    );


  ----------------------------------------
  -- Agent 3, Output FIFO Port 0
  ----------------------------------------
  I_AGT3_FP0_OUT : fifo_port32_out
    generic map (
      second_fifo_in_addr_bits_c => agt3_fifo_out0_depth,
      use_bypass_buf_c           => agt3_fp0_use_bypass_buf,
      bypass_buf_addr_bits_c     => agt3_fp0_bypass_buf_addr_bits,
      use_register_file_c        => agt3_fpo0_use_reg_file,
      common_clock               => agt3_fpo0_common_clock,
      num_rd_resync_regs         => 1,
      num_wr_resync_regs         => 1
    )
    port map (
      -- Cluster Clock & Reset
      cluster_clk                => cluster_clk,
      cluster_rst_n              => cluster_rst_n,

      -- Agent Clock & Reset
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- ACC Side Interface
      fpo_data0_from_agents      => agt3_fpo0_data0_from_agents,
      fpo_ptag0_from_agents      => agt3_fpo0_ptag0_from_agents,
      fpo_data1_from_agents      => agt3_fpo0_data1_from_agents,
      fpo_ptag1_from_agents      => agt3_fpo0_ptag1_from_agents,
      fpo_data2_from_agents      => agt3_fpo0_data2_from_agents,
      fpo_ptag2_from_agents      => agt3_fpo0_ptag2_from_agents,
      fpo_data3_from_agents      => agt3_fpo0_data3_from_agents,
      fpo_ptag3_from_agents      => agt3_fpo0_ptag3_from_agents,
      fpo_empty_from_agents      => agt3_fpo0_empty_from_agents,
      acc_rd_from_agents         => agt3_acc0_rd_from_agents,

      -- Agent Side Interface
      fp_outfifo_full            => agt3_fp0_outfifo_full,
      fp_outfifo_full_count      => agt3_fp0_outfifo_full_count,
      fp_outfifo_data            => agt3_fp0_outfifo_data,
      fp_outfifo_pkt_tag         => agt3_fp0_outfifo_pkt_tag,
      fp_outfifo_write           => agt3_fp0_outfifo_write,

      -- Bypass Interface Signals (optional)
      bypass_buf_full            => agt3_fp0_bypass_buf_full,
      bypass_buf_wr              => agt3_fp0_bypass_buf_wr,
      bypass_buf_data            => agt3_fp0_bypass_buf_data,
      bypass_buf_ptag            => agt3_fp0_bypass_buf_ptag,

      -- Error Monitoring Signals
      persistent_error           => agt3_fpo0_persistent_error
    );


  ----------------------------------------
  -- Agent 3 Instance
  ----------------------------------------
  I_AGENT_3 : loopback32_agent
    port map (
      -- Clocks and Resets
      cluster_clk               => cluster_clk,
      cluster_rst_n             => cluster_rst_n,
      agent_clk                  => cluster_clk,
      agent_rst_n                => cluster_rst_n,

      -- Input FIFO Port 0 to Agent
      fp0_infifo_pkt_tag        => agt3_fp0_infifo_pkt_tag,
      fp0_infifo_data           => agt3_fp0_infifo_data,
      fp0_infifo_empty          => agt3_fp0_infifo_empty,
      fp0_infifo_empty_count    => agt3_fp0_infifo_empty_count,
      fp0_infifo_rd             => agt3_fp0_infifo_rd,

      -- Output FIFO Port 0 from Agent
      fp0_outfifo_full          => agt3_fp0_outfifo_full,
      fp0_outfifo_full_count    => agt3_fp0_outfifo_full_count,
      fp0_outfifo_pkt_tag       => agt3_fp0_outfifo_pkt_tag,
      fp0_outfifo_data          => agt3_fp0_outfifo_data,
      fp0_outfifo_write         => agt3_fp0_outfifo_write,

      -- Agent Read/Write Register Port
      agent_rd_req              => agent3_rd_req,
      agent_address             => agent_address,
      agent_rd_data             => agent3_rd_data,
      agent_wr_req              => agent3_wr_req,
      agent_wr_data             => agent_wr_data,
      agent_ack                 => agent3_ack,

      -- Debug LEDs
      debug_led                 => agt3_debug_led
    );

end structure;





