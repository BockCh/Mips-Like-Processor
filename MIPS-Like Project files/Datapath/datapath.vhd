library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity datapath is
    generic (
        WIDTH : positive :=32
        );    
    port (
		clk          : in  std_logic;
		rst          : in  std_logic;		
		JumpAndLink  : in  std_logic;
		IsSigned     : in  std_logic;
		PCSource     : in  std_logic_vector(1 downto 0);
		ALUOp        : in  std_logic_vector(5 downto 0);
		ALUSrcB      : in  std_logic_vector(1 downto 0);
		ALUSrcA      : in  std_logic;
		RegWrite     : in  std_logic;
		RegDst       : in  std_logic;
		PCWriteCond  : in  std_logic;
		PCWrite      : in  std_logic;
		IorD         : in  std_logic;
		MemWrite     : in  std_logic;
		MemToReg     : in  std_logic;
		IRWrite      : in  std_logic;
		alu_out_en  : in std_logic;
		s            :in std_logic_vector(8 downto 0);
		buttons      :in std_logic_vector(1 downto 0);
		IR31_0       :out std_logic_vector(WIDTH-1 downto 0);
		leds         :out std_logic_vector(23 downto 0)
        );
end datapath;

architecture str of datapath is
signal data_mux1, pc_reg_data, data_mux3, data_mux4, data_mux5, data_mux6, data_mux7 : std_logic_vector(WIDTH-1 downto 0);
signal pc_en,HI_en, LO_en, port0_en, port1_en : std_logic;
signal input1             : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
signal input2             : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
signal data_mux2             :  std_logic_vector(4 downto 0);
signal OPSelect           : std_logic_vector(5 downto 0)       := (others => '0');
signal result, result_Hi, branch_Taken, RdData, mem_data_reg, rd_data0, rd_data1, regA_data, regB_data, sign_ex     : std_logic_vector(WIDTH-1 downto 0);
signal SHL_bot   : std_logic_vector(WIDTH-1 downto 0);
signal SHL_top     : std_logic_vector(25 downto 0);
signal IR, IOPORT,concat_out,alu_out_reg_data, lo_out_reg_data, hi_out_reg_data, wr_data, outport   : std_logic_vector(WIDTH-1 downto 0);
signal ALU_LO_HI : std_logic_vector(1 downto 0);
begin
	
	port0_en <= buttons(0);
	port1_en <= buttons(1);
	--process(buttons, s)
	--begin
	--if(buttons(0) = '1' and s(9) = '1' ) then
	--port1_en <= '1';
	--else 
	--port1_en <= '0';
	--end if;
	
	--if(buttons(0) = '1' and s(9) = '0' ) then
	--port0_en <= '1';
	--else 
--	port0_en <= '0';
	--end if;
	
	--end process;
	
	leds <= outport(23 downto 0);
	pc_en <= (branch_Taken(0) and PCWriteCond) or PCWrite;
	IR31_0 <= IR;
	U_DATA_REG_PC : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => pc_en,
                  input  => data_mux6,
                  output => pc_reg_data);

	U_MUX1 : entity work.mux2x1
        generic map (WIDTH => data_mux1'length)
        port map (
            in0    => pc_reg_data,
            in1    => alu_out_reg_data,
            sel    => IorD,
            output => data_mux1
            );
	
	U_MEMORY : entity work.memory
	  generic map (WIDTH => WIDTH)
		port map(
	        clk    => clk,
			rst  => rst,
			port0_en => port0_en,
			port1_en => port1_en,
			MemWrite => MemWrite,
			addr     => data_mux1,
			wr_data  => regB_data,
			ex_Switch_Data  => IOPORT,
			outport  => outport,
			RdData => RdData
	
		);
	
	U_ZERO_EX : entity work.zero_extend
	generic map ( width => width)
	port map (
		input  => s(8 downto 0),
		output => IOPORT);
	
	U_DATA_REG_IR : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => IRWrite,
                  input  => RdData,
                  output => IR);

	
		
	U_DATA_REG_MDR : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => '1',
                  input  => RdData,
                  output => mem_data_reg);				  
	
	
	U_MUX2 : entity work.mux2x1
        generic map (WIDTH => 5) 
        port map (
            in0    => IR(20 downto 16),
            in1    => IR(15 downto 11),
            sel    => RegDst,
            output => data_mux2
            );


	U_MUX3 : entity work.mux2x1
        generic map (WIDTH => data_mux3'length) 
        port map (
            in0    => data_mux7,
            in1    => mem_data_reg,
            sel    => MemToReg,
            output => data_mux3
            );
			
			
	U_REGFILE : entity work.register_file		
        port map (
            clk      => clk,
            rst      => rst,
			rd_addr0 => IR(25 downto 21),
            rd_addr1 => IR(20 downto 16),
			JumpAndLink => JumpAndLink,
            wr_addr  => data_mux2,
            wr_en    => RegWrite,
            wr_data  => data_mux3,
            rd_data0 => rd_data0,
            rd_data1 => rd_data1
			);
			
	U_SIGN_EX : entity work.sign_extend
	generic map ( width => width)
	port map (
		input  => IR(15 downto 0),
		IsSigned => IsSigned,
		output => sign_ex	);	
		
		
			
	U_DATA_REGA : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => '1',
                  input  => rd_data0,
                  output => regA_data);		

	U_DATA_REGB : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => '1',
                  input  => rd_data1,
                  output => regB_data);
				  
	U_MUX4 : entity work.mux2x1
        generic map (WIDTH => data_mux4'length) 
        port map (
            in0    => pc_reg_data,
            in1    => rd_data0,
            sel    => ALUSrcA,
            output => data_mux4
            );
			
	U_SHL2_BOT : entity work.shiftleft2
	generic map ( width => width)
	port map (
		input  => sign_ex,
		output => SHL_bot);			
	
	U_MUX5 : entity work.mux4x1
        port map (
            input0    => rd_data1,
            input1    => "00000000000000000000000000000100",
            input2    => sign_ex,
            input3    => SHL_bot,
            sel    => ALUSrcB,
            output => data_mux5
            );

	
		
	UUT : entity work.alu
        generic map (WIDTH => WIDTH)
        port map (
            input1       => data_mux4,
            input2       => data_mux5,
			IR10_6       => IR(10 downto 6),
            OPSelect     => OPSelect,
            result       => result,
            result_Hi    => result_Hi,
            branch_Taken => branch_Taken
			);
			
	U_SHL2_TOP : entity work.shiftleft2
	generic map ( width => SHL_top'length)
	port map (
		input  => IR(25 downto 0),
		output => SHL_top);	

	U_CONCAT : entity work.concat
	generic map ( width => concat_out'length)
	port map (
		input1 => SHL_top,
		input2 => pc_reg_data(31 downto 28),
		output =>  concat_out);	
		
	U_DATA_ALU_OUT : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => alu_out_en,
                  input  => result,
                  output => alu_out_reg_data);		
	U_DATA_LO : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => LO_en,
                  input  => result,
                  output => lo_out_reg_data);
				  
	U_DATA_HI : entity work.reg
        generic map (WIDTH => WIDTH)
        port map (clk    => clk,
                  rst    => rst,
                  en     => HI_en,
                  input  => result_Hi,
                  output => hi_out_reg_data);	

	U_ALU_CONTROL : entity work.alu_control
	 generic map (WIDTH => width) 
	 port map (
		ALUOp       => ALUOp,
		OPSelect    => OPSelect,
		IR5_0       => IR(5 downto 0),
		ALU_LO_HI   => ALU_LO_HI,
		HI_en       => HI_en,
		LO_en       => LO_en
	 );

	U_MUX6 : entity work.mux3x1
        generic map (WIDTH => data_mux6'length) 
        port map (
            in0    => result,
            in1    => alu_out_reg_data,
            in2    => concat_out,
            sel    => PCSource,
            output => data_mux6
            );
				
	U_MUX7 : entity work.mux3x1
        generic map (WIDTH => data_mux7'length) 
        port map (
            in0    => alu_out_reg_data,
            in1    => lo_out_reg_data,
            in2    => hi_out_reg_data,
            sel    => ALU_LO_HI,
            output => data_mux7
            );
			
			
end str;