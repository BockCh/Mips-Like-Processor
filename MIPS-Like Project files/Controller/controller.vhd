library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity controller is
generic(
        WIDTH : positive
        );
    port (
		  clk         : in std_logic;
          rst         : in std_logic;
		  OpCode      : in std_logic_vector(31 downto 26);
		  IR20_16     : in std_logic_vector(20 downto 16);
		  IR5_0       : in std_logic_vector(5 downto 0);
		  PCWriteCond : out std_logic;
		  PCWrite     : out std_logic;
		  IorD        : out std_logic;
		  MemWrite    : out std_logic;
		  MemtoReg    : out std_logic;
		  IRWrite     : out std_logic;
		  JumpAndLink : out std_logic;
		  IsSigned    : out std_logic;
		  PCSource    : out std_logic_vector(1 downto 0);
		  ALUOp       : out std_logic_vector(5 downto 0);
		  ALUSrcB     : out std_logic_vector(1 downto 0);
		  ALUSrcA     : out std_logic;
		  RegWrite    : out std_logic;
		  RegDst      : out std_logic;
		  alu_out_en  : out std_logic
		 
		  );
end controller;

architecture default_arch of controller is

type state_type is (Start, IR_Fetch, Instruction_decode, OP_LW_SW, OP_Rtype_cycle1, OP_Rtype_cycle2, OP_Rbeq, OP_J, OP_Jal, 
SW_mem, LW_mem, Mem_read, IR_Write, OP_Itype_cycle1, OP_Itype_cycle2, OP_Rbeq_cycle2, Mem_read_2, stop);
signal state_r, next_state : state_type;

begin  

	process(clk, rst)
begin 
if (rst ='1') then
	state_r <= Start;

elsif (rising_edge(clk))then 
	state_r <= next_state;

end if;
end process;	

process(state_r, OpCode, IR5_0, IR20_16)
begin
	alu_out_en  <= '1';
	PCWriteCond <= '0';
	PCWrite     <= '0';
	IorD        <= '0';
	MemWrite    <= '0';
	MemtoReg    <= '0';
	IRWrite     <= '0';
	JumpAndLink <= '0';
	IsSigned    <= '0';
	PCSource    <= "00";
	ALUOp       <= "001111";
	ALUSrcB     <= "00";
	ALUSrcA     <= '0';
	RegWrite    <= '0';
	RegDst      <= '0';

next_state <= state_r;
case (state_r) is



	when Start =>
	next_state <= IR_Fetch;
	
	when IR_Fetch =>
	MemWrite  <= '0';
	ALUSrcA  <= '0';
	IorD     <= '0';
	next_state <= IR_WRITE;
	
	when IR_WRITE =>
	IRWrite  <= '1';
	ALUSrcB  <= "01";
	ALUOp    <= "100001";
	PCWrite  <= '1';
	PCSource <= "00";
	next_state <= Instruction_decode;
	
	when Instruction_decode =>
	ALUSrcA  <= '1';
	ALUSrcB  <= "10";
	--ALUOp    <= "001001";
	ALUOp    <= "100001";
	
	if(OpCode = "101011" or OpCode = "100011") then
	next_state <= OP_LW_SW;
	
	elsif(OpCode = "000000" and IR5_0 /= "001000") then
	next_state <= OP_Rtype_cycle1;
	
	elsif (OpCode = "000100" or OpCode = "000101" or OpCode = "000110" or OpCode = "000111" or 
	(IR20_16 = "00001" and OpCode = "000001") or (IR20_16 = "00000" and OpCode = "000001")) then
	next_state <= OP_Rbeq;
	
	elsif (OpCode = "001001" or OpCode = "010000" or OpCode = "001100" or OpCode = "001101" or
	OpCode = "001110" or OpCode = "001010" or OpCode = "001011") then
	next_state <= OP_Itype_cycle1;
	
	elsif (OpCode = "000010" or OpCode = "000011" or IR5_0 = "001000" ) then
	next_state <= OP_J;
	
	elsif (OpCode = "111111") then
	next_state <= stop;
	end if;
	
	--/////////       STOP PROGRAM     \\\\\\\\\\\\
	when stop =>
	next_state <= stop;
	
	
	--////////        LW/SW BEGIN       \\\\\\\\\\\\\
	when OP_LW_SW =>
	
	if(OpCode = "101011" ) then  --store word
	IsSigned <= '0';
	ALUSrcA <= '1';
	ALUSrcB <= "10";
	----IorD <= '1';
	ALUOp <= "100001";
	--MemWrite <= '1';

	next_state <= SW_mem;
	
	elsif(OpCode = "100011") then  --load word
	MemWrite <= '0';
	ALUSrcA <= '1';
	ALUSrcB <= "10";
	IorD <= '1';
	ALUOp <="100001";
	next_state <= LW_mem;
	end if;
	
	
	when SW_mem =>
	MemWrite <= '1';
	IorD <= '1';
	
	next_state <= IR_Fetch;
	
	when LW_mem =>
	IorD <= '1';
	next_state <= Mem_read;
	
	when Mem_read =>
	next_state <= Mem_read_2;
	
	
	when Mem_read_2 =>
	RegDst <= '0';
	RegWrite <= '1';
	MemtoReg <= '1';
	next_state <= IR_Fetch;
	
	--////////        LW/SW END       \\\\\\\\\\\\\

	
	--////////        R-TYPE  BEGIN       \\\\\\\\\\\\\
	when OP_Rtype_cycle1 =>
	ALUSrcA <= '1';
	ALUSrcB <= "00";
	ALUOp <= "000000";
	if(IR5_0 = "010000" ) then
	RegWrite <=  '1';
	RegDst <= '1';
	elsif(IR5_0 = "010010") then
	RegWrite <=  '1';
	RegDst <= '1';

	
	end if;
	next_state <= OP_Rtype_cycle2;
	
	when OP_Rtype_cycle2 =>
	MemtoReg <= '0';
	RegDst <= '1';
	
	if(IR5_0 = "011001" or IR5_0 = "011000" or IR5_0 = "010000" or IR5_0 = "010010") then
	RegWrite <=  '0';
	else
	RegWrite <=  '1';
	end if;

	
	next_state <= IR_Fetch;
	--end if;
	
	
	--////////        R-TYPE  END       \\\\\\\\\\\\\

	--////////        BRANCH  BEGIN       \\\\\\\\\\\\\
	when OP_Rbeq =>  
	IsSigned <= '1';
	ALUSrcB <= "11";
	ALUSrcA <= '0' ;
	ALUOp <= "100001";

	next_state <= OP_Rbeq_cycle2;
	
	
	when OP_Rbeq_cycle2 => 
	alu_out_en <= '0';
	if(OpCode = "000100") then --beq 
	ALUSrcA <= '1' ;
	ALUSrcB <= "00";
	ALUOp <= "000100";
	PCWriteCond <= '1';
	PCSource <= "01";
	elsif (OpCode = "000101") then --bne
	ALUSrcA <= '1' ;
	ALUSrcB <= "00";
	ALUOp <= "000101";
	PCWriteCond <= '1';
	PCSource <= "01";
	elsif (OpCode = "000110") then --blez
	ALUSrcA <= '1' ;
	ALUSrcB <= "00";
	ALUOp <= "000110";
	PCWriteCond <= '1';
	PCSource <= "01";
	elsif (OpCode = "000111") then --bgtz
	ALUSrcA <= '1' ;
	ALUSrcB <= "00";
	ALUOp <= "000111";
	PCWriteCond <= '1';
	PCSource <= "01";
	elsif (IR20_16 = "00001") then --bgez
	ALUSrcA <= '1' ;
	ALUSrcB <= "00";
	ALUOp <= "000001";
	PCWriteCond <= '1';
	PCSource <= "01";
	elsif (IR20_16 = "00000") then --bltz
	ALUSrcA <= '1' ;
	ALUSrcB <= "00";
	ALUOp <= "010101";
	PCWriteCond <= '1';
	PCSource <= "01";
	end if;
	next_state <= IR_Fetch;

	--////////        BRANCH  END       \\\\\\\\\\\\\

	--////////        JUMP  BEGIN       \\\\\\\\\\\\\
	when OP_J =>  
	if(OpCode = "000010") then --j
	PCSource <= "10";
    PCWrite <= '1';
	next_state <= IR_Fetch;
	elsif (OpCode = "000011")  then--jal
	ALUSrcA <= '0';
	PCSource <= "10";
	ALUOp <= "010110";
    PCWrite <= '1';
	next_state <= OP_Jal;
	elsif (IR5_0 = "001000") then
	ALUSrcA <= '1';
	PCSource <= "00";
	PCWrite <= '1';
	ALUOp <= "001000";
	next_state <= IR_Fetch;
	end if;
	
	
	
	when OP_Jal =>
	JumpAndLink <= '1';
	MemToReg <= '0';

	next_state <= IR_Fetch;

	--////////        JUMP  END       \\\\\\\\\\\\\

	
	--////////        I-TYPE  BEGIN       \\\\\\\\\\\\\
	when OP_Itype_cycle1 =>
	ALUSrcA  <= '1';
	ALUSrcB <= "10";
	

	
	if   (OpCode = "001001") then --addiu
	ALUOp <= "001001";
	IsSigned <= '1';
	
	elsif(OpCode = "010000") then --subiu
	ALUOp <= "010000";
	IsSigned <= '1';
	
	elsif(OpCode = "001100") then --andi
	ALUOp <= "001100";
	IsSigned <= '0';
	
	elsif(OpCode = "001101") then --ori
	ALUOp <= "001101";
	IsSigned <= '0';
	
	elsif(OpCode = "001110") then --xori
	ALUOp <= "001110";
	IsSigned <= '0';
	
	elsif(OpCode = "001010") then --slti
	ALUOp <= "001010";
	IsSigned <= '1';

	elsif(OpCode = "001011") then --sltiu
	ALUOp <= "001011";
	IsSigned <= '1';
	end if;
	next_state <= OP_Itype_cycle2;
	
	when OP_Itype_cycle2 =>
	MemToReg <= '0';
	RegDst <= '0';
	RegWrite <= '1';
	next_state <= IR_Fetch;
	--////////        I-TYPE  END       \\\\\\\\\\\\\
	
	when others => ALUOp <= "001111";

	end case;
	
end process; 


end default_arch;
