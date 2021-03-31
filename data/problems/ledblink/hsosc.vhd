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

  process
    variable delay : time;
  begin
    if CLKHF_DIV = "0b11" then
      delay := 4 sec/48e6; -- 6 MHz clock
    elsif CLKHF_DIV = "0b10" then
      delay := 2 sec/48e6; -- 12 MHz clock
    elsif CLKHF_DIV = "0b01" then
      delay := 1 sec/48e6; -- 24 MHz clock
    else
      delay := 0.5 sec/48e6; -- 48 MHz clock
    end if;

    CLKHF <= '0'; wait for delay;-- ns;
    CLKHF <= '1'; wait for delay;-- ns;
  end process;

end;

