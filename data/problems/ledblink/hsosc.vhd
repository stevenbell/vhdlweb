library IEEE;
use IEEE.std_logic_1164.all;

entity HSOSC is
  generic (
    CLKHF_DIV : String := "0b00"
  );
  port (
    CLKHFPU : in std_logic;
    CLKHFEN : in std_logic;
    CLKHF : out std_logic
  );
end HSOSC;

architecture sim of HSOSC is
begin

  -- 48 MHz clock
  -- quick and dirty, just ignore all the inputs and give 48MHz out
  process begin
    CLKHF <= '0'; wait for 20.833 ns;
    CLKHF <= '1'; wait for 20.833 ns;
  end process;

end;

