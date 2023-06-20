library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
--use ieee.std_logic_arith.ALL;

entity alu_control is
generic ( 
WIDTH : positive := 32 ); 
port (
ALUOp       : in std_logic_vector(5 downto 0);
IR5_0       : in std_logic_vector(5 downto 0);
OPSelect    : out std_logic_vector(5 downto 0);
ALU_LO_HI   : out std_logic_vector(1 downto 0); 
HI_en       : out std_logic; 
LO_en       : out std_logic
);
end alu_control;

architecture BHV of alu_control is
begin 
		process(ALUOp, IR5_0)
		begin
		if (ALUOp = "000000") then
		OPSelect <= IR5_0;
		ALU_LO_HI <= "00";
		HI_en <= '0';
		LO_en <= '0';
		
		if(IR5_0 = "011000" or IR5_0 = "011001") then --mult's
		HI_en <= '1';
		LO_en <= '1';
		ALU_LO_HI <= "00";
		elsif(IR5_0 = "010000") then --mfhi
		OPSelect <= "010011"; --change op because dupe with subi
		ALU_LO_HI <= "10";
		HI_en <= '1';
		LO_en <= '0';
		
		elsif(IR5_0 = "010010") then --mflo
		ALU_LO_HI <= "01";
		HI_en <= '0';
		LO_en <= '1';
		
		elsif(IR5_0 = "101011") then
		OPSelect <= "010100";
		ALU_LO_HI <= "00";
		HI_en <= '0';
		LO_en <= '0';
		
		end if;
		
		else
		HI_en <= '0';
		LO_en <= '0';
		ALU_LO_HI <= "00";
		OPSelect <= ALUOp;
		
		end if;
		
		end process;
				
end BHV;