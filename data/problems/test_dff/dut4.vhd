-- Broken implementation of a D flip-flop
library IEEE;
use IEEE.std_logic_1164.all;

entity dff is
  port(
	  d : in std_logic;
	  clk : in std_logic;
	  q : out std_logic
  );
end dff;

architecture synth of dff is
begin
  -- D latch
  process(clk, d) begin
    if clk = '1' then
      q <= d;
    end if;
  end process;
end;

