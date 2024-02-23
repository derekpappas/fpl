-------------------------------------------------------------------------------
-- THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
-- COPYRIGHT (c) 2006-2008 FastpathLogic Inc
-- FILE NAME         : ./proc_ring_cslc_generated/code/vhdl/proc_ring.vhd
-- FILE GENERATED ON : Wed Jul  9 20:26:20 2008
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library csl_util;
use csl_util.csl_util_package.all;

entity \proc_ring\ is
begin
end entity;

architecture \proc_ring_logic\ of \proc_ring\ is
  signal \rn1_rn2_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn1_rn2_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn1_rn2_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn1_rn2_ready\ : csl_bit bus;
  signal \rn1_rn2_reject\ : csl_bit bus;
  signal \rn1_rn2_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn1_rn2_valid\ : csl_bit bus;
  signal \rn2_rn3_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn2_rn3_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn2_rn3_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn2_rn3_ready\ : csl_bit bus;
  signal \rn2_rn3_reject\ : csl_bit bus;
  signal \rn2_rn3_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn2_rn3_valid\ : csl_bit bus;
  signal \rn3_rn4_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn3_rn4_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn3_rn4_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn3_rn4_ready\ : csl_bit bus;
  signal \rn3_rn4_reject\ : csl_bit bus;
  signal \rn3_rn4_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn3_rn4_valid\ : csl_bit bus;
  signal \rn4_rn5_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn4_rn5_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn4_rn5_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn4_rn5_ready\ : csl_bit bus;
  signal \rn4_rn5_reject\ : csl_bit bus;
  signal \rn4_rn5_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn4_rn5_valid\ : csl_bit bus;
  signal \rn5_rn6_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn5_rn6_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn5_rn6_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn5_rn6_ready\ : csl_bit bus;
  signal \rn5_rn6_reject\ : csl_bit bus;
  signal \rn5_rn6_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn5_rn6_valid\ : csl_bit bus;
  signal \rn6_rn7_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn6_rn7_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn6_rn7_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn6_rn7_ready\ : csl_bit bus;
  signal \rn6_rn7_reject\ : csl_bit bus;
  signal \rn6_rn7_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn6_rn7_valid\ : csl_bit bus;
  signal \rn7_rn8_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn7_rn8_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn7_rn8_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn7_rn8_ready\ : csl_bit bus;
  signal \rn7_rn8_reject\ : csl_bit bus;
  signal \rn7_rn8_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn7_rn8_valid\ : csl_bit bus;
  signal \rn8_rn9_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn8_rn9_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn8_rn9_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn8_rn9_ready\ : csl_bit bus;
  signal \rn8_rn9_reject\ : csl_bit bus;
  signal \rn8_rn9_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn8_rn9_valid\ : csl_bit bus;
  signal \rn9_rn1_addr\ : csl_bit_vector(17 downto 0) bus;
  signal \rn9_rn1_data\ : csl_bit_vector(31 downto 0) bus;
  signal \rn9_rn1_nid\ : csl_bit_vector(3 downto 0) bus;
  signal \rn9_rn1_ready\ : csl_bit bus;
  signal \rn9_rn1_reject\ : csl_bit bus;
  signal \rn9_rn1_type\ : csl_bit_vector(3 downto 0) bus;
  signal \rn9_rn1_valid\ : csl_bit bus;

  component \pie_eth_nq11\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \pie_eth_nq01\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \pie_ex_nq1\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \pie_aud_dq1\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \ipc\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \pie_ex_dq1\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \sram0\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \pie_aud_nq1\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;

  component \pie_eth_dq1\ is
    port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
         \fab_adddata\ : out csl_bit_vector(31 downto 0);
         \fab_addnid\ : out csl_bit_vector(3 downto 0);
         \fab_addready\ : in csl_bit;
         \fab_addreject\ : out csl_bit;
         \fab_addtype\ : out csl_bit_vector(3 downto 0);
         \fab_addvalid\ : out csl_bit;
         \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
         \fab_dropdata\ : in csl_bit_vector(31 downto 0);
         \fab_dropnid\ : in csl_bit_vector(3 downto 0);
         \fab_dropready\ : out csl_bit;
         \fab_dropreject\ : in csl_bit;
         \fab_droptype\ : in csl_bit_vector(3 downto 0);
         \fab_dropvalid\ : in csl_bit);
  end component;
end component;

component \pie_eth_dq1\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \pie_eth_dq1\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \put_dma\ is
  port(\cdrvcmd\ : in csl_bit;
       \cdrvdata\ : in csl_bit_vector(31 downto 0);
       \cdrvready\ : in csl_bit;
       \cdrvvalid\ : in csl_bit;
       \sbstart\ : in csl_bit;
       \sbbusy\ : out csl_bit);
end component;

component \put_dma\ is
  port(\cdrvcmd\ : in csl_bit;
       \cdrvdata\ : in csl_bit_vector(31 downto 0);
       \cdrvready\ : in csl_bit;
       \cdrvvalid\ : in csl_bit;
       \sbstart\ : in csl_bit;
       \sbbusy\ : out csl_bit);
end component;

component \ipc\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \ipc\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \nios\ is
end component;

component \nios\ is
end component;

component \pie_ex_nq1\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \pie_ex_nq1\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \pie_eth_nq11\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \pie_eth_nq11\ is
  port(\fab_addaddr\ : out csl_bit_vector(17 downto 0);
       \fab_adddata\ : out csl_bit_vector(31 downto 0);
       \fab_addnid\ : out csl_bit_vector(3 downto 0);
       \fab_addready\ : in csl_bit;
       \fab_addreject\ : out csl_bit;
       \fab_addtype\ : out csl_bit_vector(3 downto 0);
       \fab_addvalid\ : out csl_bit;
       \fab_dropaddr\ : in csl_bit_vector(17 downto 0);
       \fab_dropdata\ : in csl_bit_vector(31 downto 0);
       \fab_dropnid\ : in csl_bit_vector(3 downto 0);
       \fab_dropready\ : out csl_bit;
       \fab_dropreject\ : in csl_bit;
       \fab_droptype\ : in csl_bit_vector(3 downto 0);
       \fab_dropvalid\ : in csl_bit);
end component;

component \cil\ is
  port(\sbstart\ : out csl_bit;
       \sbbusy\ : in csl_bit;
       \sbfdstart\ : out csl_bit;
       \sbfdbusy\ : in csl_bit;
       \maltbusy\ : in csl_bit;
       \malthit\ : in csl_bit;
       \maltport\ : in csl_bit;
       \maltstart\ : out csl_bit;
       \vrrvalid\ : in csl_bit;
       \vrrrd\ : out csl_bit;
       \vrrresult\ : in csl_bit_vector(31 downto 0);
       \cdrvcmd\ : out csl_bit;
       \cdrvdata\ : out csl_bit_vector(31 downto 0);
       \cdrvready\ : out csl_bit;
       \cdrvvalid\ : out csl_bit);
end component;

component \cil\ is
  port(\sbstart\ : out csl_bit;
       \sbbusy\ : in csl_bit;
       \sbfdstart\ : out csl_bit;
       \sbfdbusy\ : in csl_bit;
       \maltbusy\ : in csl_bit;
       \malthit\ : in csl_bit;
       \maltport\ : in csl_bit;
       \maltstart\ : out csl_bit;
       \vrrvalid\ : in csl_bit;
       \vrrrd\ : out csl_bit;
       \vrrresult\ : in csl_bit_vector(31 downto 0);
       \cdrvcmd\ : out csl_bit;
       \cdrvdata\ : out csl_bit_vector(31 downto 0);
       \cdrvready\ : out csl_bit;
       \cdrvvalid\ : out csl_bit);
end component;

component \reg\ is
  port(\dwdata\ : in csl_bit_vector(31 downto 0);
       \dwwr\ : out csl_bit);
end component;

component \reg\ is
  port(\dwdata\ : in csl_bit_vector(31 downto 0);
       \dwwr\ : out csl_bit);
end component;

component \arb\ is
  port(\adwraddr\ : in csl_bit_vector(17 downto 0);
       \adwrdata\ : in csl_bit_vector(31 downto 0);
       \adwrwr\ : in csl_bit;
       \adwrrd\ : in csl_bit);
end component;

component \arb\ is
  port(\adwraddr\ : in csl_bit_vector(17 downto 0);
       \adwrdata\ : in csl_bit_vector(31 downto 0);
       \adwrwr\ : in csl_bit;
       \adwrrd\ : in csl_bit);
end component;

component \maclu\ is
  port(\maltbusy\ : out csl_bit;
       \malthit\ : out csl_bit;
       \maltport\ : out csl_bit;
       \maltstart\ : in csl_bit;
       \adwaddr\ : in csl_bit_vector(17 downto 0);
       \adwdata\ : in csl_bit_vector(31 downto 0);
       \adwwr\ : out csl_bit);
end component;

component \maclu\ is
  port(\maltbusy\ : out csl_bit;
       \malthit\ : out csl_bit;
       \maltport\ : out csl_bit;
       \maltstart\ : in csl_bit;
       \adwaddr\ : in csl_bit_vector(17 downto 0);
       \adwdata\ : in csl_bit_vector(31 downto 0);
       \adwwr\ : out csl_bit);
end component;

component \data_tcm\ is
end component;

component \data_tcm\ is
end component;
