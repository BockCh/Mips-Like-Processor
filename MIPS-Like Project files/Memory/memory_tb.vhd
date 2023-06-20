library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memory_tb is
end memory_tb;

architecture TB of memory_tb is

    constant WIDTH       : positive := 32;
	signal clk           : std_logic := '0';
	signal rst           : std_logic := '1';
	signal clk_en        : std_logic := '1';
	signal port0_en      : std_logic;
	signal port1_en      : std_logic;
	signal MemWrite      : std_logic;
    signal addr          : std_logic_vector(WIDTH-1 downto 0) ;
    signal wr_data        : std_logic_vector(WIDTH-1 downto 0) ;
    signal ex_Switch_Data        : std_logic_vector(WIDTH-1 downto 0);
    signal RdData     : std_logic_vector(WIDTH-1 downto 0);
    signal outport  : std_logic_vector(WIDTH-1 downto 0);
	
    

begin  -- TB

  U_MEMORY : entity work.memory
	  generic map (WIDTH => WIDTH)
		port map(
	        clk    => clk,
			rst  => rst,
			port0_en => port0_en,
			port1_en => port1_en,
			MemWrite => MemWrite,
			addr     => addr,
			wr_data  => wr_data,
			ex_Switch_Data  => ex_Switch_Data,
			outport  => outport,
			RdData => RdData
		);
		
		clk <= not clk and clk_en after 20 ns;

    process
    begin

	port0_en <= '0';
	port1_en <= '0';
	ex_Switch_Data <= x"00000000";
	wait for 40 ns;
	
	rst <= '0';
	MemWrite <= '1';
	wr_data <= x"0A0A0A0A";
	addr <= x"00000000";
	wait for 40 ns;
	
	
	MemWrite <= '1';
	wr_data <= x"F0F0F0F0";
	addr <= x"00000004";
	wait for 40 ns;
	
	MemWrite <= '0';
	wr_data <= x"F0F0F0F0";
	addr <= x"00000000";
	wait for 40 ns;
	
	MemWrite <= '0';
	wr_data <= x"F0F0F0F0";
	addr <= x"00000001";
	wait for 40 ns;
	
	MemWrite <= '0';
	wr_data <= x"F0F0F0F0";
	addr <= x"00000004";
	wait for 40 ns;
	
	MemWrite <= '0';
	wr_data <= x"F0F0F0F0";
	addr <= x"00000005";
	wait for 40 ns;
	
	MemWrite <= '1';
	wr_data <= x"00001111";
	addr <= x"0000FFFC";
	wait for 40 ns;
	
	MemWrite <= '0';
	addr <= x"0000FFF8";
	ex_Switch_Data <= x"00010000";
	port0_en <= '1';
	port1_en <= '0';
	wait for 40 ns;
	
	MemWrite <= '0';
	ex_Switch_Data <= x"00000001";
	addr <= x"0000FFFC";
	port0_en <= '0';
	port1_en <= '1';
	wait for 40 ns;
	

	
	

     clk_en <= '0';
		  
        wait;

    end process;



end TB;