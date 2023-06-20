library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memory is
generic(
        WIDTH : positive
        );
    port (
		  clk : in std_logic;
          rst : in std_logic;
		  port0_en            : in  std_logic;
		  port1_en            : in  std_logic;
		  MemWrite            : in  std_logic;
          addr, wr_data     : in  std_logic_vector(width-1 downto 0);
          ex_Switch_Data             : in  std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
          outport             : out std_logic_vector(31 downto 0);
          RdData         : out std_logic_vector(31 downto 0)
		  );
end memory;

architecture default_arch of memory is
signal data_ram, port0_data, port1_data   : std_logic_vector(31 downto 0);
signal mux_en, mux_en_reg   : std_logic_vector(1 downto 0);
signal WrEn, OutPOrtWrEn   : std_logic;

--when write en is true, write, if false then read

begin  -- STR
		
		
		U_INPORT0 : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => '0',
                  en     => port0_en,
                  input  => ex_Switch_Data,
                  output => port0_data);
				  
		U_INPORT1 : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => '0',
                  en     => port1_en,
                  input  => ex_Switch_Data,
                  output => port1_data);		  
				  
		U_OUTPORT : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => OutportWrEn,
                  input  => wr_data,
                  output => outport);
				  
		U_MEM_LOGIC : entity work.mem_logic
        generic map (WIDTH => WIDTH)
        port map (MemWrite    => MemWrite,
                  WrEn    => WrEn,
                  addr     => addr,
                  OutportWrEn  => OutportWrEn,
                  mux_en => mux_en);
				  
		U_RAM : entity work.ram_gcd
		port map( 
			address => addr(9 downto 2),
			clock   => clk,
			data    => wr_data,
			wren    => WrEn,
			q       => data_ram
		);
		
		U_MUX_EN : entity work.reg
        generic map (WIDTH => 2)
        port map (clk    => clk,
                  rst    => rst,
                  en     => '1',
                  input  => mux_en,
                  output => mux_en_reg);
		
		U_MUX0 : entity work.mux3x1
        generic map (WIDTH => RdData'length) 
        port map (
            in0    => port0_data,
            in1    => port1_data,
            in2    => data_ram,
            sel    => mux_en_reg,
            output => RdData
            );

	

end default_arch;
