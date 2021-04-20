library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity decrementmem is
  port(
    clk : in std_logic;
    run : in std_logic; -- When this is asserted, begin one pass through the memory

    -- Signals below are connected to the RAM inside the testbench
    addr : out unsigned(3 downto 0);
    dataRead : out std_logic_vector(7 downto 0);
    dataWrite : out std_logic_vector(7 downto 0);
    writeEnable : out std_logic
  );
end;

architecture synth of decrementmem is

constant ADDR_WIDTH : natural := 4;
constant RAM_DEPTH : natural := 2**ADDR_WIDTH;

type State is (IDLE, READ, WRITE);
signal s : State := IDLE;
signal nextAddr : unsigned(ADDR_WIDTH-1 downto 0) := 4d"0";

begin

  process (clk) begin
    if rising_edge(clk) then

      if s = READ then
          s <= WRITE;

      elsif s = WRITE then
        if nextAddr = RAM_DEPTH-1 then
          s <= IDLE;
          nextAddr <= 4d"0";
        else 
          nextAddr <= nextAddr + 1;
          s <= READ;
        end if;

      else -- IDLE
        if run then
          s <= READ;
        else
          s <= IDLE;
        end if;
      end if;
    end if;
  end process;

  dataWrite <= std_logic_vector(unsigned(dataRead) - 1);
  addr <= nextAddr;
  writeEnable <= '1' when s = WRITE else '0';
end;

