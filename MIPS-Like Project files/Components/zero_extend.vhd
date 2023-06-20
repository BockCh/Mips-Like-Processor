library ieee;
use ieee.std_logic_1164.all;

entity zero_extend is
    generic(
        WIDTH : positive
        );
    port(
        input  : in  std_logic_vector(8 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end zero_extend;

architecture default_arch of zero_extend is
begin
   output <= "00000000000000000000000" & input;
   
end default_arch;