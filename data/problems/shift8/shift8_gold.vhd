library IEEE;
use IEEE.std_logic_1164.all;

entity shift8 is
  port(
	  clk : in std_logic;
    input : in std_logic;
	  result : out std_logic_vector(7 downto 0)
  );
end shift8;

architecture synth of shift8 is


begin
  process(clk) is
  begin
    if rising_edge(clk) then
      result(0) <= input;
      result(7 downto 1) <= result(6 downto 0);
    end if;
  end process;
end;

