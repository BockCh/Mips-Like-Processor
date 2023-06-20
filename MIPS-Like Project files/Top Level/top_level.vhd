-- I/O Explanation (assumes the switches are on side of the
--                  board that is closest to you)
-- switch(9) is the leftmost switch
-- button_n(1) is the top button
-- led5 is the leftmost 7-segment LED
-- ledx_dp is the decimal point on the 7-segment LED for LED x

library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    port (
        clk50MHz         : in  std_logic;
        switch           : in  std_logic_vector(9 downto 0);
        button_n         : in  std_logic_vector(1 downto 0);
        led0             : out std_logic_vector(6 downto 0);
        led0_dp          : out std_logic;
        led1             : out std_logic_vector(6 downto 0);
        led1_dp          : out std_logic;
        led2             : out std_logic_vector(6 downto 0);
        led2_dp          : out std_logic;
        led3             : out std_logic_vector(6 downto 0);
        led3_dp          : out std_logic;
        led4             : out std_logic_vector(6 downto 0);
        led4_dp          : out std_logic;
        led5             : out std_logic_vector(6 downto 0);
        led5_dp          : out std_logic
        );
end top_level;

architecture STR of top_level is

    constant C0    : std_logic_vector(3 downto 0) := (others => '0');
    signal rst     : std_logic;
		  constant WIDTH       : positive := 32;
          
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
		  signal alu_out_en: std_logic;
	signal	s            : std_logic_vector(8 downto 0) ;
	signal	buttons      : std_logic_vector(1 downto 0);
	signal	IR_TO_CTRL   : std_logic_vector(5 downto 0);
	signal	leds         : std_logic_vector(23 downto 0);

begin  -- STR

--process
--begin
	--wait until buttons = "11";
	--wait until buttons(1) = '1';
	--rst <='1';
	
	--wait for 40 ns;
	
	
	
--end process;





   buttons(0) <= not button_n(0);
	--buttons(1) <= not button_n(1);
   rst <= not button_n(1);
--	rst <= switch(9);
	
	s <= switch(8 downto 0);
   	U_CONTROLLER : entity work.controller
	 generic map (WIDTH => WIDTH)
		port map(
	      clk          => clk50MHz,
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
			alu_out_en   => alu_out_en,
			IsSigned     => IsSigned,
			PCSource     => PCSource,
			ALUOp        => ALUOp,
			ALUSrcB      => ALUSrcB,
			ALUSrcA      => ALUSrcA,
			RegWrite     => RegWrite,
			RegDst       => RegDst
		);
		
		U_DATAPATH : entity work.datapath
	 generic map (WIDTH => WIDTH)
		port map(
	        clk          => clk50MHz,
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
	


    U_LED5 : entity work.decoder7seg port map (
        input  => leds(23 downto 20),
        output => led5);

    U_LED4 : entity work.decoder7seg port map (
        input  => leds(19 downto 16),
        output => led4);

    U_LED3 : entity work.decoder7seg port map (
        input  => leds(15 downto 12),
        output => led3);

    U_LED2 : entity work.decoder7seg port map (
        input  => leds(11 downto 8),
        output => led2);

    U_LED1 : entity work.decoder7seg port map (
        input  => leds(7 downto 4),
        output => led1);

    U_LED0 : entity work.decoder7seg port map (
        input  => leds(3 downto 0),
        output => led0);

    led5_dp <= '1';
    led4_dp <= '1';
    led3_dp <= '1';
    led2_dp <= '1';
    led1_dp <= '1';
    led0_dp <= '1';

end STR;
