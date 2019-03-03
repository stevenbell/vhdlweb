library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity passcode is
  port(
    clk : in std_logic; -- Clock
	  black : in std_logic; -- Black button
	  yellow : in std_logic; -- Yellow button
	  red : out std_logic; -- Locked
	  green : out std_logic -- Unlocked
  );
end passcode;

architecture synth of passcode is

type State is (LOCKED, ONE, TWOPLUS, UNLOCKED);
signal s : State := LOCKED;

begin
  process(clk) begin
    if rising_edge(clk) then
    case s is
      when LOCKED =>
        if yellow = '1' then
          s <= ONE;
        else
          s <= LOCKED;
        end if;
        
      when ONE =>
        if yellow = '1' then
          s <= TWOPLUS;
        elsif black = '1' then
          s <= UNLOCKED;
        else
          s <= ONE;
        end if;
        
      when TWOPLUS =>
        if black = '1' then
          s <= LOCKED;
        else
          s <= TWOPLUS;
        end if;
        
      when UNLOCKED =>
        if (black = '1' or yellow = '1') then
          s <= LOCKED;
        else
          s <= UNLOCKED;
        end if;
    end case;
    end if;
  end process;
  
  green <= '1' when s = UNLOCKED else '0';
  red <= '1' when s = LOCKED else '0';

end;

