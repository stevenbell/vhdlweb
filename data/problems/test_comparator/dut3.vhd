-- Compute M > N, just like lab 2
library IEEE;
use IEEE.std_logic_1164.all;

entity lab2 is
  port(
	  m : in std_logic_vector(1 downto 0);
	  n : in std_logic_vector(1 downto 0);
	  y : out std_logic
  );
end lab2;

architecture synth of lab2 is
begin
  y <= (m(1) and not n(1)) or
       ((m(1) xnor n(1)) and m(0)); -- almost works, need !n0 term
end;

