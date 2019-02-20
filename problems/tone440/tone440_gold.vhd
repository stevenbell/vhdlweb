library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tone440 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  tone : out std_logic
  );
end tone440;

architecture synth of tone440 is
-- 54545 clock cycles at 24 MHz
--  = 27272 clock cycles low/high
signal mcount : unsigned(14 downto 0);
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset = '1' then
        mcount <= 15d"0";
        tone <= '0';
      elsif mcount = 27272 then
        mcount <= 15d"0";
        tone <= not tone;
      else
        mcount <= mcount + 1;
      end if;

    end if;
  end process;
end;

