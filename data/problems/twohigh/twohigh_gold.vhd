library IEEE;
use IEEE.std_logic_1164.all;

entity twohigh is
  port(
	  clk : in std_logic;
    input : in std_logic;
	  two : out std_logic
  );
end twohigh;

architecture synth of twohigh is

signal delays : std_logic_vector(1 downto 0);

begin
  process(clk) is
  begin
    if rising_edge(clk) then
      delays(0) <= input;
      delays(1) <= delays(0);
    end if;
  end process;

  two <= delays(0) and delays(1);
end;

