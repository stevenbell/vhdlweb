library IEEE;
use IEEE.std_logic_1164.all;

entity lfsr4 is
  port(
	  clk : in std_logic;
	  reset : in std_logic;
	  count : out std_logic_vector(3 downto 0)
  );
end lfsr4;

architecture synth of lfsr4 is
signal mcount : std_logic_vector(3 downto 0);
begin
  process(clk) is
  begin
    if rising_edge(clk) then
      if reset = '1' then
        mcount <= "0001";
      else
        mcount(3) <= mcount(0);
        mcount(2) <= mcount(3) xor mcount(0);
        mcount(1 downto 0) <= mcount (2 downto 1);
      end if;

    end if;
  end process;

  count <= mcount;
end;

