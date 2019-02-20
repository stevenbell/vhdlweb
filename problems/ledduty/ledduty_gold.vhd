library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ledduty is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  led : out std_logic
  );
end ledduty;

architecture synth of ledduty is
-- 24000 clock cycles at 24 MHz per cycle
--  = 6000 clock cycles high, 18000 low
signal mcount : unsigned(14 downto 0);
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset = '1' then
        mcount <= 15d"0";
      elsif mcount = 24000 then
        mcount <= 15d"0";
      else
        mcount <= mcount + 1;
      end if;

    end if;
  end process;

  led <= '1' when (mcount < 15d"6000") else '0';
end;

