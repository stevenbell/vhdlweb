-- Broken 4:1 multiplexer
library IEEE;
use IEEE.std_logic_1164.all;

entity mux41 is
  port(
	  d : in std_logic_vector(3 downto 0); -- Data port
	  s : in std_logic_vector(1 downto 0); -- Select
	  y : out std_logic -- Result
  );
end mux41;

architecture synth of mux41 is
begin
  -- This ignores the top bit of the select
  -- This will go unnoticed if you only test 0001 and 0000
  y <= (d(0) or d(2)) when (s(0) = '0') else
       (d(1) or d(3));
end;

