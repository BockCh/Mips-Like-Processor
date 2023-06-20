library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftleft2 is
    generic(
        WIDTH : positive
        );
    port(
        input  : in  std_logic_vector(width-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end shiftleft2 ;

architecture default_arch of shiftleft2 is
begin
   output <= STD_LOGIC_VECTOR(SHIFT_LEFT(unsigned(input), 2));
   
end default_arch;