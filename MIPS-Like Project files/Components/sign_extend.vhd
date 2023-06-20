library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
    generic(
        WIDTH : positive
        );
    port(
        input  : in  std_logic_vector(15 downto 0);
		IsSigned : in std_logic;
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end sign_extend;

architecture default_arch of sign_extend is
begin
	process(input, IsSigned)
	begin
	if (IsSigned = '1') then
   output <= std_logic_vector(resize(signed(input), output'length));
   else
   output <= std_logic_vector(resize(unsigned(input), output'length));
   
   end if;
   end process;
   
end default_arch;