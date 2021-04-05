library IEEE;
use IEEE.std_logic_1164.all;

entity detect001 is
  port(
    clk : in std_logic;
    input : in std_logic;
    result : out std_logic
  );
end detect001;

architecture synth of detect001 is

type State is (START, ONE, TWO, FOUND);
signal s : State;

begin
  process(clk) is
  begin
    if rising_edge(clk) then
      case s is
        when START =>
          if input = '0' then
            s <= ONE;
          else
            s <= START;
          end if;
        when ONE =>
          if input = '0' then
            s <= TWO;
          else
            s <= START;
          end if;
        when TWO =>
          if input = '1' then
            s <= FOUND;
          elsif input = '0' then
            s <= TWO;
          else
            s <= START;
          end if;
        when FOUND =>
          if input = '0' then
            s <= ONE;
          else
            s <= START;
          end if;
        when others => s <= START;
      end case;
    end if;
  end process;

  result <= '1' when s = FOUND else '0';

end;

