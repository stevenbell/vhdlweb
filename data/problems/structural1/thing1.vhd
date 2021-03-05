library IEEE;
use IEEE.std_logic_1164.all;

entity thing1 is
  port(
	  s : in std_logic;
	  t : in std_logic;
	  y : out std_logic_vector(3 downto 0)
  );
end thing1;

architecture synth of thing1 is
begin
  y(3) <= s;
  y(2) <= t;
  y(1 downto 0) <= "00";
end;

