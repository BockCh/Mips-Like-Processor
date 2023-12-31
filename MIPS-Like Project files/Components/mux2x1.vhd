library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    generic (
        WIDTH : positive
        );    
    port(
        in0    : in  std_logic_vector(WIDTH-1 downto 0);
        in1    : in  std_logic_vector(WIDTH-1 downto 0);
        sel    : in  std_logic;
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end mux2x1;

architecture default_arch of mux2x1 is
begin
    output <= in0 when sel = '0' else in1;
end default_arch;