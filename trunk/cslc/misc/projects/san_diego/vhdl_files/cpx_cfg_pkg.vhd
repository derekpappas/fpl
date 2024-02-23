

-- ----------------------------------------------------------------------------
-- $File: //hw/main/agents/agent_sets_sal/build_500/src/cpx_cfg_pkg.vhd $
-- $Revision: #10 $
-- $DateTime: 2008/05/10 11:37:23 $
-- $Author: msapper $
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
-- $Header: //hw/main/agents/agent_sets_sal/build_500/src/cpx_cfg_pkg.vhd#10 $
--
-- Company   : Tarari Inc.
--
-- Project   : Abraxas
--
-- Filename  : $File: //hw/main/agents/agent_sets_sal/build_500/src/cpx_cfg_pkg.vhd $
--
-- Author(s) : Jim Henson
--
-- Components instantiated:
--
-- Instantiated by:
--
-- Last Modified : $Author: msapper $ $DateTime: 2008/05/10 11:37:23 $
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
-- $Change: 60905 $
-- ----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.std_logic_arith.all;

package cpx_cfg_pkg is

  --------------------------------------------------------------------------------
  -- CPC Configuration Parameters
  --------------------------------------------------------------------------------
  -- CPC Status Register Configuration Parameters
  -- These values are read from BAR0 status registers.
  -- CPC ID Register Constants
  constant cpx_id_c                       : std_logic_vector(31 downto 0) := X"0000_0001";
  constant cpx_revision_c                 : std_logic_vector(31 downto 0) := X"0500_0018";
  constant cpx_rev_date_c                 : std_logic_vector(31 downto 0) := X"2008_0509";

  -- CPC Configuration Register Constants --
  -- Resources
  constant cpx_num_of_agt_clusters_c      : integer   := 4;
  constant cpx_num_of_connected_sws_c     : integer   := 1;
  constant cpx_memory_agt_present_c       : std_logic := '1';
  constant cpx_memory_agt_cluster_c       : integer   := 1;  -- range 1 to (# ac -1)
  constant cpx_hda_agt_present_c          : std_logic := '0';

  -- Bits Allocated to Agent/Device Identification
  constant cpx_num_of_sw_bits_c           : integer   := 2;
  constant cpx_num_of_sw_port_bits_c      : integer   := 2;
  constant cpx_num_of_dev_id_bits_c       : integer   := 5;

  -- ACC Configuration Constants
  constant cpx_max_fifo_port_id_bits_c    : integer   := 12;
  constant cpx_max_ports_per_agt_bits_c   : integer   := 6;
  constant cpx_max_connecting_port_bits_c : integer   := 16;
  constant cpx_max_credit_ctr_bits_c      : integer   := 16;

  -- Agent Clock Enable Constants
  constant cpx_enable_usr0_clk_c          : boolean   := false;
  constant cpx_enable_usr1_clk_c          : boolean   := false;
  constant cpx_enable_usr2_clk_c          : boolean   := false;
  constant cpx_enable_usr3_clk_c          : boolean   := false;

  constant cpx_single_clock_system_c      : boolean   := false;

  --------------------------------------------------------------------------------
  -- DMAC Configuration Parameters
  --------------------------------------------------------------------------------
  constant cpx_num_threads_bits_c         : integer   := 2;

  --------------------------------------------------------------------------------
  -- Memory Agent Configuration Parameters
  --------------------------------------------------------------------------------
  constant cpx_mag_port_bits_c            : integer   := 2;

  --------------------------------------------------------------------------------
  -- HDA Agent Configuration Parameters
  --------------------------------------------------------------------------------
  constant cpx_hda_port_bits_c            : integer   := 2;

end package cpx_cfg_pkg;
