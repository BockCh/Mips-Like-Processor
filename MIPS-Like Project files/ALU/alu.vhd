library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
--use ieee.std_logic_arith.ALL;

entity alu is
generic ( 
WIDTH : positive := 32 ); 
port (
input1       : in std_logic_vector(WIDTH-1 downto 0);
input2       : in std_logic_vector(WIDTH-1 downto 0);
IR10_6       : in std_logic_vector(4 downto 0);
OPSelect     : in std_logic_vector(5 downto 0);
result       : out std_logic_vector(WIDTH-1 downto 0); 
result_Hi    : out std_logic_vector(WIDTH-1 downto 0); 
branch_Taken : out std_logic_vector(WIDTH-1 downto 0)
);
end alu;

architecture BHV of alu is
--signal temp         :std_logic_vector(WIDTH-1 downto 0);
begin 
		process(input1, input2, OPSelect, IR10_6)
				variable temp_mult    :unsigned(2*WIDTH-1 downto 0);
				variable temp_mult_s  :signed(2*WIDTH-1 downto 0);
				variable temp_over    :unsigned(WIDTH-1 downto 0);
				

		begin
		
		result <= std_logic_vector(to_unsigned(0, width));
		result_Hi <= std_logic_vector(to_unsigned(0, width));
		branch_Taken <= std_logic_vector(to_unsigned(0, width));
		--temp <= temp;
			case(OPSelect) is
				--addu - add unsigned word
				when "100001"=>
				result  <= std_logic_vector(unsigned(input1) + unsigned(input2));
			--	temp <= std_logic_vector(unsigned(input1) + unsigned(input2));
				--addiu add immediate unsigned
				when "001001" =>
				result  <= std_logic_vector(unsigned(input1) + unsigned(input2));

				
				--subu - subtract unsigned word
				when "100011"=>
				result <= std_logic_vector(unsigned(input1) - unsigned(input2));
			
				--subiu sub immediate unsigned (not mips)
				when "010000" =>
				result <= std_logic_vector(unsigned(input1) - unsigned(input2));
				
				--mult - multiply word				
				when "011000"=>
				temp_mult_s := signed(input1) * signed(input2);
				result_Hi   <= std_logic_vector(temp_mult_s(2*WIDTH-1 downto width));
				result      <= std_logic_vector(temp_mult_s(WIDTH-1 downto 0));
				
				--Multiply Unsigned Word MULTU
				when "011001"=>
				temp_mult := unsigned(input1) * unsigned(input2);
				result_Hi   <= std_logic_vector(temp_mult(2*WIDTH-1 downto width));
				result      <= std_logic_vector(temp_mult(WIDTH-1 downto 0));

				--And AND
				when "100100"=>
				result <= input1 and input2;	
				
				--andi 
				when "001100" => 
				result <= input1 and input2;
				
				--or
				when "100101" =>
				result <= input1 or input2;
				
				--ori 
				when "001101" =>
				result <= input1 or input2;
				--xor 
				when "100110" =>
				result <= input1 xor input2;
				
				--xori
				when "001110" =>
				result <= input1 xor input2;
				
				--Shift Word Right Logical SRL
				when "000010"=>
				result <= std_logic_vector(SHIFT_RIGHT(unsigned(input2), to_integer(unsigned(IR10_6))));
				
				--SLL
				when "000000" =>
				result <= std_logic_vector(SHIFT_LEFT(unsigned(input2), to_integer(unsigned(IR10_6))));
				
				--Shift Word Right Arithmetic SRA
				when "000011"=>
				result <= std_logic_vector(shift_right(signed(input2), to_integer(unsigned(IR10_6))));
				
				--slt set on less than signed
				when "101010" =>
				if (signed(input1) < signed(input2)) then
					result <= std_logic_vector(to_unsigned(1, width));
				else 
				result <= std_logic_vector(to_unsigned(0, width));
				end if;				
				
				--slti set on less than immediate signed
				when "001010" =>
				if (signed(input1) < signed(input2)) then
					result <= std_logic_vector(to_unsigned(1, width));
				else 
				result <= std_logic_vector(to_unsigned(0, width));
				end if;						
				
				--sltiu set on less than immediate unsigned
				when "001011" =>
				if (unsigned(input1) < unsigned(input2)) then
					result <= std_logic_vector(to_unsigned(1, width));
				else 
				result <= std_logic_vector(to_unsigned(0, width));
				end if;
				
				--Set on Less Than Unsigned SLTU
				when "010100"=>  --dupe with sw changed op 0x14
				if (unsigned(input1) < unsigned(input2)) then
					result <= std_logic_vector(to_unsigned(1, width));
				else 
				result <= std_logic_vector(to_unsigned(0, width));
				end if;
				
				--mfhi move from hi
				when "010011" =>   --same as subi change to 010011
				--result <= std_logic_vector(to_unsigned(0, width));

				--mflo move from lo
				when "010010" =>
			--	result <= std_logic_vector(to_unsigned(0, width));
				
				--lw
				when "100111" =>
				result <= input2;
				--sw
				when "101011" =>
				result <= input2;
				--beq
				when "000100" =>
				if(unsigned(input1) = unsigned(input2)) then
				branch_Taken <= std_logic_vector(to_unsigned(1, width));
				--result <= temp;
				else
				branch_Taken <= std_logic_vector(to_unsigned(0, width));
				end if;
				--bne
				when "000101" =>
				if(unsigned(input1) /= unsigned(input2)) then
			--	result <= temp;
				branch_Taken <= std_logic_vector(to_unsigned(1, width));
				else
				branch_Taken <= std_logic_vector(to_unsigned(0, width));
				end if;
				
				--bltz custom opcode
				when "010101" =>
				if (unsigned(input1) < 0) then
			--	result <= temp;
				branch_Taken <= std_logic_vector(to_unsigned(1, width));
				else 
				branch_Taken <= std_logic_vector(to_unsigned(0, width));
				end if;
				
				--bgez 
				when "000001" =>
				if (unsigned(input1) >= 0) then
			--	result <= temp;
				branch_Taken <= std_logic_vector(to_unsigned(1, width));
				else 
				branch_Taken <= std_logic_vector(to_unsigned(0, width));
				end if;
				
				--Branch on Greater Than ZeroBGTZ
				when "000111"=>
				if (unsigned(input1) > 0) then
			--	result <= temp;
				branch_Taken <= std_logic_vector(to_unsigned(1, width));
				else 
				branch_Taken <= std_logic_vector(to_unsigned(0, width));
				end if;
				
				--Branch on Less Than or Equal to Zero BLEZ
				when "000110"=>
				if (unsigned(input1) <= 0) then
				--result <= temp;
				branch_Taken <= std_logic_vector(to_unsigned(1, width));
				else 
				branch_Taken <= std_logic_vector(to_unsigned(0, width));
				end if;
				
								--j 
				--when "02" =>
				
				--jal 
				when "010110" =>
				result <= input1;
				
				--jr
				when "001000" =>
				result <= input1;
				
				when others => result <= (others => '0');
				result_Hi <= (others => '0');
				branch_Taken <= (others => '0');
				--temp <= (others => '0');

			end case;
		end process;
				
end BHV;