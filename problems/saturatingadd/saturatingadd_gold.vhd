library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity saturatingadd is
  port(
	  a : in unsigned(7 downto 0);
	  b : in unsigned(7 downto 0);
	  result : out unsigned(7 downto 0)
  );
end saturatingadd;

architecture synth of saturatingadd is
signal temp : unsigned(8 downto 0);
begin
  temp <= ('0' & a) + ('0' & b);
  result <= temp(7 downto 0) when temp(8) = '0' else "11111111";
  --result <= 8x"cc";
end;

