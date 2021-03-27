library IEEE;
use IEEE.std_logic_1164.all;

entity johnson is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(3 downto 0)
  );
end johnson;

architecture synth of johnson is
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset = '1' then
        count <= "0000";
      else
        count(3 downto 1) <= count(2 downto 0);
        count(0) <= not count(3);
      end if;

    end if;
  end process;
end;

