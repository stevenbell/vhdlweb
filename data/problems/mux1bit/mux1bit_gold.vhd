library IEEE;
use IEEE.std_logic_1164.all;

entity mux1bit is
  port(
	  a : in std_logic;
	  b : in std_logic;
	  s : in std_logic;
	  y : out std_logic
  );
end mux1bit;

architecture synth of mux1bit is
begin
  y <= a when s = '0' else b;
end;

