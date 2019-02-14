library IEEE;
use IEEE.std_logic_1164.all;

entity adderlogic is
  port(
	  a : in std_logic_vector(2 downto 0);
	  b : in std_logic_vector(2 downto 0);
	  sum : out std_logic_vector(3 downto 0)
  );
end adderlogic;

architecture synth of adderlogic is
  signal carry : std_logic_vector(2 downto 0);
begin
  sum <= "0000";
end;

