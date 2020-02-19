-- 4:1 multiplexer
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
  y <= d(0) when (s = "00") else
       d(1) when (s = "01") else
       d(2) when (s = "10") else d(3);
end;

