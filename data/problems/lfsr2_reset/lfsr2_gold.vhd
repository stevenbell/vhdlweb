library IEEE;
use IEEE.std_logic_1164.all;

entity lfsr2 is
  port(
	  clk : in std_logic;
    reset : in std_logic;
	  b : out std_logic
  );
end lfsr2;

architecture synth of lfsr2 is

signal d0 : std_logic;
signal d1 : std_logic;

begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset then
        d1 <= '1';
        d0 <= '1';
      else
        d1 <= d0 xor d1;
        d0 <= d1;
      end if;
    end if;
  end process;

  b <= d0;
end;

