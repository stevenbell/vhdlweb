-- This actually performs xor, so that we can tell if the student used the
-- module, or just implemented NAND themselves.

library IEEE;
use IEEE.std_logic_1164.all;

entity nand4 is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  c : in std_logic;
	  y : out std_logic
  );
end nand4;

architecture synth of nand4 is
begin
  y <= a xor b xor c;
end;

