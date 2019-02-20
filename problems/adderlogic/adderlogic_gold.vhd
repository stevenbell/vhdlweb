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
  sum(0) <= a(0) xor b(0);
  carry(0) <= a(0) and b(0);

  sum(1) <= a(1) xor b(1) xor carry(0);
  carry(1) <= (a(1) and b(1)) or (a(1) and carry(0)) or (b(1) and carry(0));

  sum(2) <= a(2) xor b(2) xor carry(1);
  carry(2) <= (a(2) and b(2)) or (a(2) and carry(1)) or (b(2) and carry(1));

  sum(3) <= carry(2);
end;

