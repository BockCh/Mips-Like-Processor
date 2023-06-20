library ieee;
use ieee.std_logic_1164.all;

entity mux3x1 is
    generic (
        WIDTH : positive
        );    
    port(
        in0    : in  std_logic_vector(WIDTH-1 downto 0);
        in1    : in  std_logic_vector(WIDTH-1 downto 0);
        in2    : in  std_logic_vector(WIDTH-1 downto 0);
        sel    : in  std_logic_vector(1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end mux3x1;

architecture default_arch of mux3x1 is
 signal mux1_out : std_logic_vector(31 downto 0);
begin
     U_MUX1 : entity work.mux2x1
	generic map (WIDTH => mux1_out'length) 
	port map (
        in0    => in0,
        in1    => in1,
        sel    => sel(0),
        output => mux1_out
        );

    U_MUX2 : entity work.mux2x1 
	generic map (WIDTH => mux1_out'length) 
	port map (
        in0    => mux1_out,
        in1    => in2,
        sel    => sel(1),
        output => output
        );
end default_arch;