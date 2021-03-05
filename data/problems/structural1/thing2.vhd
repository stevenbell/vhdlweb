library IEEE;
use IEEE.std_logic_1164.all;

entity thing2 is
  port(
	  e : in std_logic_vector(3 downto 0);
	  f : in std_logic;
	  g : out std_logic_vector(3 downto 0)
  );
end thing2;

architecture synth of thing2 is
begin
  g <= e(3 downto 2) & f & '0';
end;

