library IEEE;
use IEEE.std_logic_1164.all;

entity count5 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  flag : out std_logic
  );
end count5;

architecture synth of count5 is

signal onehots : std_logic_vector(4 downto 0);

begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset = '1' then
        onehots <= "00001";
      else
      onehots <= onehots(3 downto 0) & onehots(4);
      end if;
    end if;
  end process;

  flag <= onehots(4);
end;

