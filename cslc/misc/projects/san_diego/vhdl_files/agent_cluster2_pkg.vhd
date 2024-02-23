

-- ----------------------------------------------------------------------------
-- $File: //hw/main/agents/agent_sets_sal/build_500/src/agent_cluster2_pkg.vhd $
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

-- Work Library
use work.cpc_pkg.all;


package agent_cluster2_pkg is

  ----------------------------------------------------------------------
  -- Agent Specific Constants
  ----------------------------------------------------------------------

  -- Agent 0, FIFO Port 0 Constants
  constant agt0_fp0_bypass_buf_addr_bits      : integer := 9;
  constant agt0_fp0_use_bypass_buf            : boolean := true;
  constant agt0_fpi0_first_n_metas            : integer := 1;
  constant agt0_fpi0_send_all_metac           : boolean := false;
  constant agt0_fpi0_send_all_status          : boolean := false;
  constant agt0_fpi0_use_reg_file             : boolean := false;
  constant agt0_fifo_in0_depth                : integer := 9;
  constant agt0_fpi0_common_clock             : boolean := true;
  constant agt0_fpo0_use_reg_file             : boolean := false;
  constant agt0_fifo_out0_depth               : integer := 9;
  constant agt0_fpo0_common_clock             : boolean := true;

  -- Agent 1, FIFO Port 0 Constants
  constant agt1_fp0_bypass_buf_addr_bits      : integer := 9;
  constant agt1_fp0_use_bypass_buf            : boolean := true;
  constant agt1_fpi0_first_n_metas            : integer := 1;
  constant agt1_fpi0_send_all_metac           : boolean := false;
  constant agt1_fpi0_send_all_status          : boolean := false;
  constant agt1_fpi0_use_reg_file             : boolean := false;
  constant agt1_fifo_in0_depth                : integer := 9;
  constant agt1_fpi0_common_clock             : boolean := true;
  constant agt1_fpo0_use_reg_file             : boolean := false;
  constant agt1_fifo_out0_depth               : integer := 9;
  constant agt1_fpo0_common_clock             : boolean := true;

  -- Agent 2, FIFO Port 0 Constants
  constant agt2_fp0_bypass_buf_addr_bits      : integer := 9;
  constant agt2_fp0_use_bypass_buf            : boolean := true;
  constant agt2_fpi0_first_n_metas            : integer := 1;
  constant agt2_fpi0_send_all_metac           : boolean := false;
  constant agt2_fpi0_send_all_status          : boolean := false;
  constant agt2_fpi0_use_reg_file             : boolean := false;
  constant agt2_fifo_in0_depth                : integer := 9;
  constant agt2_fpi0_common_clock             : boolean := true;
  constant agt2_fpo0_use_reg_file             : boolean := false;
  constant agt2_fifo_out0_depth               : integer := 9;
  constant agt2_fpo0_common_clock             : boolean := true;

  -- Agent 3, FIFO Port 0 Constants
  constant agt3_fp0_bypass_buf_addr_bits      : integer := 9;
  constant agt3_fp0_use_bypass_buf            : boolean := true;
  constant agt3_fpi0_first_n_metas            : integer := 1;
  constant agt3_fpi0_send_all_metac           : boolean := false;
  constant agt3_fpi0_send_all_status          : boolean := false;
  constant agt3_fpi0_use_reg_file             : boolean := false;
  constant agt3_fifo_in0_depth                : integer := 9;
  constant agt3_fpi0_common_clock             : boolean := true;
  constant agt3_fpo0_use_reg_file             : boolean := false;
  constant agt3_fifo_out0_depth               : integer := 9;
  constant agt3_fpo0_common_clock             : boolean := true;

  ----------------------------------------------------------------------
  -- Configuration Constants
  ----------------------------------------------------------------------
  -- Agent Configuration
  constant number_of_agents_c          : integer := 4;
  constant acc_agent_addr_bits_c       : integer := 2;

  -- Input FIFO Ports Configuration
  constant number_of_fifo_in_ports_c   : integer := 4;
  constant fifo_in_ports_bits_c        : integer := 2;
  constant max_fifo_in_addr_bits_c     : integer := 9;

  -- Output FIFO Ports Configuration
  constant number_of_fifo_out_ports_c  : integer := 4;
  constant fifo_out_ports_bits_c       : integer := 2;
  constant max_fifo_out_addr_bits_c    : integer := 9;

  -- The maximum number of FIFO ports any one agent has
  constant max_fifo_ports_per_agt_c    : integer := 1;

  -- Set to true if this agent cluster contains the DMAC.
  constant include_reg_initiator_c     : boolean := false;

end package agent_cluster2_pkg;


package body agent_cluster2_pkg is

end package body agent_cluster2_pkg;


