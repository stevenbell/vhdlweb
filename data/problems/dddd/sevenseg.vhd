library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sevenseg is
  port(
	  S : in unsigned(3 downto 0);
	  segments : out std_logic_vector(6 downto 0)
  );
end sevenseg;

architecture synth of sevenseg is
begin
  segments <= "1111110" when S = 4x"0" else
              "0110000" when S = 4x"1" else
              "1101101" when S = 4x"2" else
              "1111001" when S = 4x"3" else
              "0110011" when S = 4x"4" else
              "1011011" when S = 4x"5" else
              "1011111" when S = 4x"6" else
              "1110000" when S = 4x"7" else
              "1111111" when S = 4x"8" else
              "1110011" when S = 4x"9" else
              "1110111" when S = 4x"a" else
              "0011111" when S = 4x"b" else
              "1001110" when S = 4x"c" else
              "0111101" when S = 4x"d" else
              "1001111" when S = 4x"e" else
              "1000111";
end;

