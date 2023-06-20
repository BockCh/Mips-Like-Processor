library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concat is
    generic(
        WIDTH : positive
        );
    port(
        input1  : in  std_logic_vector(25 downto 0);
        input2  : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end concat; 

architecture default_arch of concat is
begin
   output <= input2 & "00" & input1;
   
end default_arch;