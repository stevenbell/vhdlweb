library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity rom is
  port(
	  clk : in std_logic;
    addr : in std_logic_vector(5 downto 0); -- 64 words total
    data : out std_logic_vector(7 downto 0) -- 8-bit words
  );
end;

architecture sim of rom is

constant ROM_DEPTH : integer := 64;

type romtype is array(ROM_DEPTH-1 downto 0) of std_logic_vector(7 downto 0);

impure function init_rom_from_listing return romtype is
  file listingfile : text open read_mode is "rom.bin";
  variable text_line : line;
  variable romblock : romtype;
begin
  for i in 0 to ROM_DEPTH - 1 loop
    readline(listingfile, text_line); -- Read one line of the file
    read(text_line, romblock(i)); -- Read the data value into the ROM
  end loop;
  return romblock;
end function;

signal romblock : romtype := init_rom_from_listing;

begin
  process (clk) begin
    if rising_edge(clk) then
      data <= romblock(to_integer(unsigned(addr)));
    end if;
  end process;
end;

