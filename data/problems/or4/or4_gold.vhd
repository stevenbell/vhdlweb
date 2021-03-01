library IEEE;
use IEEE.std_logic_1164.all;

entity or4 is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  c : in std_logic;
	  d : in std_logic;
	  y : out std_logic
  );
end or4;

architecture synth of or4 is
begin
  y <= a or b or c or d;
end;

