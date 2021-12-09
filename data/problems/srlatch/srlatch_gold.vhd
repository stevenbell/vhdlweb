library IEEE;
use IEEE.std_logic_1164.all;

entity srlatch is
  port(
	  s : in std_logic;
	  r : in std_logic;
	  q : out std_logic
  );
end srlatch;

architecture synth of srlatch is
signal qbar : std_logic;
begin
  --qbar <= s nor q;
  --q <= r nor qbar;
end;

