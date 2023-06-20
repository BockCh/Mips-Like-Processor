library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity controller_tb is
end controller_tb;

architecture TB of controller_tb is
		  constant WIDTH       : positive := 32;
		  signal clk         :  std_logic := '0';
		  signal clk_en        : std_logic := '1';
          signal rst         :  std_logic;
		  signal OpCode      :  std_logic_vector(31 downto 26);
		  signal IR     :  std_logic_vector(31 downto 0);
		  signal IR5_0       :  std_logic_vector(5 downto 0);
		  signal PCWriteCond :  std_logic;
		  signal PCWrite     :  std_logic;
		  signal IorD        :  std_logic;
		  signal MemWrite    :  std_logic;
		  signal MemtoReg    :  std_logic;
		  signal IRWrite     :  std_logic;
		  signal JumpAndLink :  std_logic;
		  signal IsSigned    :  std_logic;
		  signal PCSource    :  std_logic_vector(1 downto 0);
		  signal ALUOp       :  std_logic_vector(5 downto 0);
		  signal ALUSrcB     :  std_logic_vector(1 downto 0);
		  signal ALUSrcA     :  std_logic;
		  signal RegWrite    :  std_logic;
		  signal RegDst      :  std_logic;
		  signal alu_out_en      :  std_logic;
	signal	s            : std_logic_vector(8 downto 0);
	signal	buttons      : std_logic_vector(1 downto 0);
	signal	IR_TO_CTRL   : std_logic_vector(5 downto 0);
	signal	leds         : std_logic_vector(23 downto 0);
begin  
	
	U_CONTROLLER : entity work.controller
	 generic map (WIDTH => WIDTH)
		port map(
	        clk          => clk,
			rst          => rst,
			OpCode       => IR(31 downto 26),
			IR20_16      => IR(20 downto 16),
			IR5_0        => IR(5 downto 0),
			PCWriteCond  => PCWriteCond,
			PCWrite      => PCWrite,
			IorD         => IorD,
			MemWrite     => MemWrite,
			MemToReg     => MemToReg,
			IRWrite      => IRWrite,
			JumpAndLink  => JumpAndLink,
			IsSigned     => IsSigned,
			PCSource     => PCSource,
			ALUOp        => ALUOp,
			ALUSrcB      => ALUSrcB,
			ALUSrcA      => ALUSrcA,
			RegWrite     => RegWrite,
			RegDst       => RegDst,
			alu_out_en  => alu_out_en
		);
		
		U_DATAPATH : entity work.datapath
	 generic map (WIDTH => WIDTH)
		port map(
	        clk          => clk,
			rst          => rst,
			JumpAndLink  => JumpAndLink,
			IsSigned      => IsSigned,
			PCSource     => PCSource,
			ALUOp        => ALUOp,
			ALUSrcB      => ALUSrcB,
			ALUSrcA      => ALUSrcA,
			RegWrite     => RegWrite,
			RegDst       => RegDst,
			PCWriteCond  => PCWriteCond,
			PCWrite      => PCWrite,
			IorD         => IorD,
			MemWrite     => MemWrite,
			MemToReg     => MemToReg,
			IRWrite      => IRWrite,
			alu_out_en   => alu_out_en,
			s            => s,
			buttons      => buttons,
			IR31_0       => IR,
			leds         => leds
			
		);
	
	clk <= not clk and clk_en after 20 ns;
	process
	begin
	rst <='1';
	--s<= "000000001";
	--buttons <= "11";
	--buttons <= "11";
	--s <="111111111";
	wait for 40 ns;
	
	
	rst <='0';
	wait for 40 ns;
	s <= "000001100";
	buttons <= "01";
	wait for 40 ns;
	s <= "000001001";
	buttons <= "10";
	
	
	-- clk_en <= '0';
	 wait;
	 
	end process;
end TB;
