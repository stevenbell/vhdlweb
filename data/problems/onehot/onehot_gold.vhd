library IEEE;
use IEEE.std_logic_1164.all;

entity onehot is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(7 downto 0)
  );
end onehot;

architecture synth of onehot is
signal mcount : std_logic_vector(7 downto 0);
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset = '1' then
        mcount <= "00000001";
      else
        mcount(7 downto 1) <= mcount(6 downto 0);
        mcount(0) <= mcount(7);
      end if;

    end if;
  end process;

  count <= mcount;
end;

