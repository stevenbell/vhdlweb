library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity countto is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out unsigned(3 downto 0)
  );
end countto;

architecture synth of countto is
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset then
        count <= 4d"0";
      elsif count = 4d"9" then
        count <= 4d"0";
      else
        count <= count + 1;
      end if;
    end if;
  end process;
end;

