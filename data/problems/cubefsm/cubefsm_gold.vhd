library IEEE;
use IEEE.std_logic_1164.all;

entity cubefsm is
  port(
	  clk : in std_logic;
	  valid_in : in std_logic;
	  valid_out : out std_logic;
	  b_select : out std_logic
  );
end cubefsm;

architecture synth of cubefsm is

type statetype is (IDLE, SQUARE, CUBE);
signal state : statetype := IDLE;

begin
  process(clk) is
  begin
    if rising_edge(clk) then
      case (state) is
        when IDLE =>
          if valid_in then
            state <= SQUARE;
          else
            state <= IDLE;
          end if;

        when SQUARE =>
          state <= CUBE;

        when CUBE =>
          if valid_in then
            state <= SQUARE;
          else
            state <= IDLE;
          end if;

        when others => state <= IDLE;
      end case;
    end if;
  end process;

  b_select <= '1' when state = SQUARE else '0';
  valid_out <= '1' when state = CUBE else '0';

  -- Here's a hack that almost works!
  --process(clk) is
  --begin
  --  if rising_edge(clk) then
  --    b_select <= valid_in;
  --    valid_out <= b_select;
  --  end if;
  --end process;

end;

