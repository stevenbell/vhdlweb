library IEEE;
use IEEE.std_logic_1164.all;

entity majority is
  port(
	  votes : in std_logic_vector(2 downto 0);
	  y : out std_logic
  );
end majority;

architecture synth of majority is
begin
  y <= (votes(2) and votes(1)) or (votes(2) and votes(0)) or (votes(1) and votes(0));
  --y <= '0';
end;

