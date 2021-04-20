--  Testbench for 8-bit one hot counter
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity decrementmem_test is
-- No ports, since this is a testbench
end decrementmem_test;

architecture test of decrementmem_test is

component decrementmem is
  port(
	  clk : in std_logic;
    run : in std_logic; -- When this is asserted, begin one pass through the memory

    -- Signals below are connected to the RAM inside the testbench
    addr : out unsigned(3 downto 0);
    dataRead : out std_logic_vector(7 downto 0);
    dataWrite : out std_logic_vector(7 downto 0);
    writeEnable : out std_logic
  );
end component;

constant ADDR_WIDTH : natural := 4;
constant RAM_DEPTH : natural := 2**ADDR_WIDTH;
constant WORDSIZE : natural := 8;

signal clk : std_logic;
signal run : std_logic;

signal addr : unsigned(ADDR_WIDTH-1 downto 0);
signal dataRead : std_logic_vector(WORDSIZE-1 downto 0);
signal dataWrite : std_logic_vector(WORDSIZE-1 downto 0);
signal writeEnable : std_logic;

type ramtype is array(RAM_DEPTH-1 downto 0) of std_logic_vector(WORDSIZE-1 downto 0);

impure function init_ram return ramtype is
  file datafile : text open read_mode is "ram_init.txt";
  variable text_line : line;
  variable tmp_val : integer;
  variable ramblock : ramtype;
begin
  for i in 0 to RAM_DEPTH - 1 loop
    readline(datafile, text_line); -- Read one line of the file
    read(text_line, tmp_val); -- Read the data value into an integer to force decimal conversion
    ramblock(i) := std_logic_vector(to_unsigned(tmp_val, WORDSIZE)); 
  end loop;
  return ramblock;
end function;

signal ram : ramtype := init_ram;
signal ramgold : ramtype := init_ram;

begin

  dut : decrementmem port map(clk, run, addr, dataRead, dataWrite, writeEnable);

  -- Generate 100MHz clock
  process begin
    clk <= '1'; wait for 5 ns;
    clk <= '0'; wait for 5 ns;
  end process;

  process begin
    wait for 32 ns;
    run <= '1';
    wait for 10 ns;
    run <= '0';
    wait;
  end process;

  process
    variable errors : natural := 0;

    procedure check(condition : boolean; message : string) is
    begin
      if not condition then
        report message;
        errors := errors + 1;
      end if;
    end check;

    procedure print_ram(message : string) is
    begin
      write(output, message & LF);
      for i in 0 to RAM_DEPTH - 1 loop
        write(output, to_hstring(to_unsigned(i, ADDR_WIDTH)) & " : " & to_hstring(ram(i)) & LF);
      end loop;
    end print_ram;

  begin

    print_ram("--- RAM contents at start of test ---");

    for i in 0 to 50 loop

      wait until rising_edge(clk);
      wait for 1 ns;
      if writeEnable then
        write(output, "Write " & to_hstring(dataWrite) & " to addr " & to_hstring(addr) & LF);
        ram(to_integer(addr)) <= dataWrite;
      else
        write(output, "Read " & to_hstring(ram(to_integer(addr))) & " from addr " & to_hstring(addr) & LF);
        dataRead <= ram(to_integer(addr));
      end if;
 

    end loop;

    print_ram("--- RAM contents at end of test ---");

    for i in 0 to RAM_DEPTH - 1 loop
      check(unsigned(ram(i)) = unsigned(ramgold(i)) - 1, "Memory location " & to_hstring(to_unsigned(i, ADDR_WIDTH)) & " incorrect.");
    end loop;

    if errors = 0 then
      write (output, "TEST PASSED." & LF);
    else
      write (output, "Test failed with " & to_string(errors) &  " errors." & LF);
    end if;
 
    std.env.finish; -- All done, but clock is still going

    wait;
  end process;
end test;

