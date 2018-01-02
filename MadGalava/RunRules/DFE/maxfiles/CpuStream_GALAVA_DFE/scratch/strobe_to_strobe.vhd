--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--   Strobe-to-Strobe Synchroniser
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Maxeler Technologies Inc
-- Copyright 2009. All rights reserved.
-- Author: C.E.D.
-- Library: Maxeleros IP
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Description:
--   Single clock-cycle wide pulse synchroniser. Accepts a pulse
-- input on the source clock domain and generates a pulse in the
-- output clock domain with the following latency: 
-- Tsrc_clk + 2*Tdst_clk.
--
-- Limitations: 
--   Input pulses must be a minimum of 2*Tdst_clk periods
-- apart to ensure a single cycle output pulse is generated and also
-- to ensure all input pulses are detected.
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--   Single primitive implemented at technology level
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library work;
use work.cross_clock_pkg.all;

entity strobe_to_strobe_prim is
--generic (
--  AREA_APPEND : string := ""
--);
port (
  clk_src : in std_logic;
  clk_dst : in std_logic;
  strobe_src : in std_logic;
  strobe_dst : out std_logic
); 
  --attribute use_rloc : string;
  --attribute use_rloc of strobe_to_strobe_prim : entity is "TRUE";
end strobe_to_strobe_prim;

architecture altera of strobe_to_strobe_prim is

  signal toggle_sync0, toggle_sync1, toggle_sync2 : std_logic;
  signal toggle_async, toggle_sel : std_logic;

  component dff_ce_asyncsr
  generic (
    INIT : bit := '0'
  );
  port (
        D   : in  std_logic;
        C   : in  std_logic;
        CLR : in  std_logic;
        PRE : in  std_logic;
        CE  : in  std_logic;
        Q   : out std_logic
  );
  end component dff_ce_asyncsr;

  --attribute bel : string;
  --attribute rloc : string;
  --attribute area_group : string;

  --attribute rloc of i_src : label is "X0Y0";
  --attribute rloc of i_src_pulse : label is "X0Y0";
  --attribute rloc of i_sync0 : label is "X1Y0";
  --attribute rloc of i_sync1 : label is "X1Y0";
  --attribute rloc of i_sync2 : label is "X1Y0";
  --attribute rloc of i_strobe_xor : label is "X1Y0";

  --attribute bel of i_sync0 : label is "FFA";
  --attribute bel of i_sync1 : label is "FFB";
  --attribute bel of i_sync2 : label is "FFC";
  --attribute bel of i_strobe_xor : label is "D6LUT";  

--  constant area_str : string := AREA_APPEND;
--  attribute area_group  of i_src  : label is area_str;
--  attribute area_group  of i_sync0  : label is area_str;
--  attribute area_group  of i_sync1  : label is area_str;
--  attribute area_group  of i_sync2  : label is area_str;
--  attribute area_group  of i_strobe_xor  : label is area_str;


begin

  toggle_sel <= toggle_async xor strobe_src;

  i_src : dff_ce_asyncsr
  generic map (
    INIT => '0') -- Initial value of register
  port map (
    Q => toggle_async, -- Data output
    C => clk_src, -- Clock input
    CE => '1', -- Clock enable input
    CLR => '0', -- Asynchronous clear input
    D => toggle_sel, -- Data input
    PRE => '0' -- Asynchronous set input
  );

  i_sync0 : dff_ce_asyncsr
  generic map (
    INIT => '0') -- Initial value of register
  port map (
    Q => toggle_sync0, -- Data output
    C => clk_dst, -- Clock input
    CE => '1', -- Clock enable input
    CLR => '0', -- Asynchronous clear input
    D => toggle_async, -- Data input
    PRE => '0' -- Asynchronous set input
  );

  i_sync1 : dff_ce_asyncsr
  generic map (
    INIT => '0') -- Initial value of register
  port map (
    Q => toggle_sync1, -- Data output
    C => clk_dst, -- Clock input
    CE => '1', -- Clock enable input
    CLR => '0', -- Asynchronous clear input
    D => toggle_sync0, -- Data input
    PRE => '0' -- Asynchronous set input
  );

  i_sync2 : dff_ce_asyncsr
  generic map (
    INIT => '0') -- Initial value of register
  port map (
    Q => toggle_sync2, -- Data output
    C => clk_dst, -- Clock input
    CE => '1', -- Clock enable input
    CLR => '0', -- Asynchronous clear input
    D => toggle_sync1, -- Data input
    PRE => '0' -- Asynchronous set input
  );

  strobe_dst <= toggle_sync1 xor toggle_sync2;

end altera;

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--   Top-level with generic configurable vector width
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library work;
use work.cross_clock_pkg.all;

entity strobe_to_strobe is
generic (
--  AREA_APPEND : string := ""; -- Enables multiple instances at same hierarchy.
  WIDTH : natural := 1
);
port (
  clk_src : in std_logic;
  clk_dst : in std_logic;
  strobe_src : in std_logic_vector(WIDTH-1 downto 0);
  strobe_dst : out std_logic_vector(WIDTH-1 downto 0)
);
end strobe_to_strobe;

architecture rtl of strobe_to_strobe is

  component strobe_to_strobe_prim
--  generic (
--    AREA_APPEND : string := ""
--  );
  port (
    clk_src : in std_logic;
    clk_dst : in std_logic;
    strobe_src : in std_logic;
    strobe_dst : out std_logic
  );
  end component strobe_to_strobe_prim;

begin

  g_sync_toggle_wide : for i in 0 to WIDTH-1 generate
  begin

    sync_toggle : strobe_to_strobe_prim
 --     generic map (
 --       AREA_APPEND => AREA_APPEND
 --     )
      port map (
        clk_src => clk_src,
        clk_dst => clk_dst,
        strobe_src => strobe_src(i),
        strobe_dst => strobe_dst(i)
      );

  end generate;


end rtl;