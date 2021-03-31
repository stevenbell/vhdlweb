library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
  port(
	  leds : out std_logic_vector(1 downto 0)
  );
end top;

architecture synth of top is

component HSOSC is
  generic (
    CLKHF_DIV : String := "0b00"
  );
  port (
    CLKHFPU : in std_logic;
    CLKHFEN : in std_logic;
    CLKHF : out std_logic
  );
end component;

signal clk : std_logic;
signal mcount : unsigned(25 downto 0) := 26d"0";

begin

  osc : HSOSC port map('1', '1', clk);

  process(clk) is
  begin
    if rising_edge(clk) then
        --report "clk edge, mcount: " & to_string(mcount);
        mcount <= mcount + 1;
    end if;
  end process;

  leds(0) <= mcount(12);
  leds(1) <= not mcount(12);
end;

