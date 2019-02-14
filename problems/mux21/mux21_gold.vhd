library IEEE;
use IEEE.std_logic_1164.all;

entity mux21 is
  port(
	  a : in std_logic_vector(7 downto 0);
	  b : in std_logic_vector(7 downto 0);
	  s : in std_logic;
	  y : out std_logic_vector(7 downto 0)
  );
end mux21;

architecture synth of mux21 is
begin
  y <= a when s = '0' else b;
  --y <= x"00";
end;

