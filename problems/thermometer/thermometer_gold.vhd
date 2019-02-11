library IEEE;
use IEEE.std_logic_1164.all;

entity thermometer is
  port(
	  value : in std_logic_vector(2 downto 0);
	  therm : out std_logic_vector(6 downto 0)
  );
end thermometer;

architecture synth of thermometer is
begin
  therm <= "0000000" when value = "000" else
           "0000001" when value = "001" else
           "0000011" when value = "010" else
           "0000111" when value = "011" else
           "0001111" when value = "100" else
           "0011111" when value = "101" else
           "0111111" when value = "110" else "1111111";
end;

