library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder is
  port(
	  a : in unsigned(3 downto 0);
	  b : in unsigned(3 downto 0);
	  sum : out unsigned(3 downto 0)
  );
end adder;

architecture synth of adder is
begin
  -- One little bug
  sum <= "1111" when (a = "1111" and b = "1111") else  a + b;
end;

