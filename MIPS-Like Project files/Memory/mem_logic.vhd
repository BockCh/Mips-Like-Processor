library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem_logic is
    generic(
        WIDTH : positive
        );
    port(
        MemWrite     : in  std_logic;
        addr  : in  std_logic_vector(WIDTH-1 downto 0);
        WrEn : out std_logic;
        OutportWrEn : out std_logic;
        mux_en : out std_logic_vector(1 downto 0)
        );
end mem_logic;

architecture default_arch of mem_logic is
begin
    process(addr, MemWrite)
    begin
	 WrEn <= '0';
	 OutportWrEn <= '0';
    mux_en <= "00";
       
	if(MemWrite = '1' and to_integer(unsigned(addr))  < 1023) then
	WrEn <= '1';
	OutportWrEn <= '0';
	mux_en <= "11";
	
	
	elsif(MemWrite = '1' and addr = x"0000FFFC") then
	WrEn <= '0';
	OutportWrEn <= '1';
    mux_en <= "11";
	
	elsif(MemWrite = '0' and addr = x"0000FFFC") then
	WrEn <= '0';
	OutportWrEn <= '0';
    mux_en <= "01";
	
	
	elsif(MemWrite = '0' and addr = x"0000FFF8") then
	WrEn <= '0';
	OutportWrEn <= '0';
    mux_en <= "00";
	
	
	elsif(MemWrite = '0' and to_integer(unsigned(addr)) < 1023) then
	WrEn <= '0';
	OutportWrEn <= '0';
    mux_en <= "10";
	end if;
	
	
    end process;
end default_arch;