--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Dual Aspect Mux Pipelined Counter: Base Entity 4:1 Mux
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Maxeler Technologies Inc
--   Copyright 2009. All rights reserved.
--   Author: C.E.D.
--   Date Originated: Nov 23, 2009
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Description:
--  Basic 4:1 MUX with pipeline register output. 
--  Elemental component for Pipelined Counter Dual Aspect 
--  Mux.
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;

entity dualaspectmuxpipe_mux4 is
  generic (
    OUTPUT_WIDTH : integer := 0
  );
  port (
    clk : in std_logic;
    rst : in std_logic;
    
    output_stall : in std_logic;
    sel : in std_logic_vector(1 downto 0);
    input_data  : in std_logic_vector(4*OUTPUT_WIDTH-1 downto 0);
    output_data  : out std_logic_vector(OUTPUT_WIDTH-1 downto 0)

  );

  attribute keep_hierarchy : string;
end dualaspectmuxpipe_mux4;

architecture rtl of dualaspectmuxpipe_mux4 is
  attribute keep_hierarchy of rtl : architecture is "false";

  attribute max_fanout : string;
  attribute max_fanout of sel : signal is "100";

  signal mux_out : std_logic_vector(OUTPUT_WIDTH-1 downto 0);
  signal reg_out : std_logic_vector(OUTPUT_WIDTH-1 downto 0);

begin

      i_mux : process(sel, input_data)
      begin
        case (sel) is
          when "00" =>
            mux_out <= input_data(OUTPUT_WIDTH-1 downto 0);
          when "01" => 
            mux_out <= input_data(2*OUTPUT_WIDTH-1 downto OUTPUT_WIDTH);
          when "10" =>
            mux_out <= input_data(3*OUTPUT_WIDTH-1 downto OUTPUT_WIDTH*2);
          when "11" =>
            mux_out <= input_data(4*OUTPUT_WIDTH-1 downto OUTPUT_WIDTH*3);
          when others =>
            mux_out <= input_data(OUTPUT_WIDTH-1 downto 0);
        end case;
      end process;

      pipelined_output : process(clk)
      begin
        if rising_edge(clk) then
          if output_stall = '0' then
            reg_out <= mux_out;
          end if;
        end if;
      end process;
      output_data <= reg_out;

end rtl;