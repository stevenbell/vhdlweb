library IEEE;
use IEEE.std_logic_1164.all;

entity risingedge is
  port(
	  clk : in std_logic;
	  D : in std_logic;
	  flag : out std_logic
  );
end risingedge;

architecture synth of risingedge is
signal lastD : std_logic;
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      lastD <= D;
      flag <= D and not lastD;
    end if;
  end process;
end;

