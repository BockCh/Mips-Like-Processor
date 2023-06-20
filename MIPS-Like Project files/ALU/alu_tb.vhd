library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity alu_tb is
end alu_tb;

architecture TB of alu_tb is

    constant WIDTH  : positive := 32;
    signal input1        : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal input2        : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal IR10_6        :  std_logic_vector(4 downto 0);
    signal OPSelect      : std_logic_vector(5 downto 0)       := (others => '0');
    signal result        : std_logic_vector(WIDTH-1 downto 0);
    signal result_Hi     : std_logic_vector(WIDTH-1 downto 0);
    signal branch_Taken  : std_logic_vector(WIDTH-1 downto 0);
    

begin  -- TB

    UUT : entity work.alu
        generic map (WIDTH => WIDTH)
        port map (
            input1       => input1,
            input2       => input2,
			IR10_6       => IR10_6,
            OPSelect     => OPSelect,
            result       => result,
            result_Hi    => result_Hi,
            branch_Taken => branch_Taken
			);

    process
    begin

        -- test 10+15 (no overflow)
        OPSelect    <= "100001";
        input1 <= std_logic_vector(to_unsigned(10, input1'length));
        input2 <= std_logic_vector(to_unsigned(15, input2'length));
        wait for 40 ns;
        assert(result = std_logic_vector(to_unsigned(25, result'length))) report "Error : 10+15 = " & integer'image(to_integer(unsigned(result))) & " instead of 25" severity warning;

        -- test 25-10 (with overflow)
        OPSelect    <= "100011";
        input1 <= std_logic_vector(to_unsigned(25, input1'length));
        input2 <= std_logic_vector(to_unsigned(10, input2'length));
        wait for 40 ns;
		-- Truncated result for 300 is 44.
		-- You can put 300 in the to_unsigned call, but you will receive a simulation warning about a truncated value.
        assert(result = std_logic_vector(to_unsigned(15, result'length))) report "Error : 25-10 = " & integer'image(to_integer(unsigned(result))) & " instead of 15" severity warning;

        -- test 10*-4
        OPSelect    <= "011000";
        input1 <= std_logic_vector(to_signed(10, input1'length));
        input2 <= std_logic_vector(to_signed(-4, input2'length));
        wait for 40 ns;
		assert(result = "11111111111111111111111111011000") report "Error : 10*-4 = " & integer'image(to_integer(signed(result))) & " instead of -40" severity warning;
        assert(result_Hi = "11111111111111111111111111111111") report "Error : 10*-4 = " & integer'image(to_integer(signed(result_Hi))) & " instead of 0" severity warning;

        -- test 65536 * 131072
        OPSelect    <= "011001";
        input1 <= std_logic_vector(to_unsigned(65536, input1'length));
        input2 <= std_logic_vector(to_unsigned(131072, input2'length));
        wait for 40 ns;
		-- Truncated result for 4096 is 0.
		-- You can put 4096 in the to_unsigned call, but you will receive a simulation warning about a truncated value.
		assert(result_Hi = "00000000000000000000000000000010") report "Error : 65536 * 131072 = " & integer'image(to_integer(unsigned(result_Hi))) & " instead of " severity warning;
		assert(result = "00000000000000000000000000000000") report "Error : 65536 * 131072 = " & integer'image(to_integer(unsigned(result))) & " instead of " severity warning;

        --and of 0x0000FFFF and 0xFFFF1234 
        OPSelect    <= "100100";
        input1 <= x"0000FFFF";
        input2 <= x"FFFF1234";
        wait for 40 ns;
        assert(result = x"00001234") report "Error : 0x0000FFFF and 0xFFFF1234 =  " & integer'image(to_integer(unsigned(result))) & " instead of 00001234" severity warning;
       
		  --shift right logical of 0x0000000F by 4 
		  
        OPSelect    <= "000010";
        input1 <= std_logic_vector(to_unsigned(0, input1'length));
        input2 <= x"0000000F";
		IR10_6 <= std_logic_vector(to_unsigned(4, IR10_6'length));
        wait for 40 ns;
        assert(result = std_logic_vector(to_unsigned(0, result'length))) report "Error : 0x000000F by 4 = " & integer'image(to_integer(unsigned(result))) & " instead of 0" severity warning;
   
			--shift right arithmetic of 0xF0000008 by 1
	    OPSelect    <= "000011";
        input1 <= std_logic_vector(to_signed(0, input1'length));
        input2 <= x"F0000008";
		IR10_6 <= std_logic_vector(to_unsigned(1, IR10_6'length));
        wait for 40 ns;
        assert(result = x"78000004") report "Error : 0xF0000008 by 1 = " & integer'image(to_integer(signed(result))) & " instead of 2,013,265,924" severity warning;
   
		--shift right arithmetic of 0x00000008 by 1 
        OPSelect    <= "000011";
        input1 <= std_logic_vector(to_signed(0, input1'length));
        input2 <= x"00000008";
		IR10_6 <= std_logic_vector(to_unsigned(1, IR10_6'length));
        wait for 40 ns;
        assert(result = x"00000004") report "Error : 0x00000008 by 1 = " & integer'image(to_integer(signed(result))) & " instead of 4" severity warning;
  
		-- set on less than using 10 and 15 
		OPSelect    <= "101011";
        input1 <= std_logic_vector(to_unsigned(10, input1'length));
        input2 <= std_logic_vector(to_unsigned(15, input2'length));
        wait for 40 ns;
        assert(result = std_logic_vector(to_unsigned(1, result'length))) report "Error : 10 < 15 = " & integer'image(to_integer(unsigned(result))) & " instead of 1" severity warning;

		
		-- set on less than using 15 and 10
		OPSelect    <= "101011";
        input1 <= std_logic_vector(to_unsigned(15, input1'length));
        input2 <= std_logic_vector(to_unsigned(10, input2'length));
        wait for 40 ns;
        assert(result = std_logic_vector(to_unsigned(0, result'length))) report "Error : 15 < 10 = " & integer'image(to_integer(unsigned(result))) & " instead of 0" severity warning;


			-- branch on 5>0
		OPSelect    <= "000111";
        input1 <= std_logic_vector(to_unsigned(5, input1'length));
        input2 <= std_logic_vector(to_unsigned(0, input2'length));
        wait for 40 ns;
        assert(branch_Taken = std_logic_vector(to_unsigned(1, branch_Taken'length))) report "Error : 5 > 0 = " & integer'image(to_integer(unsigned(branch_Taken))) & " instead of 1" severity warning;

			OPSelect    <= "000110";
        input1 <= std_logic_vector(to_unsigned(5, input1'length));
        input2 <= std_logic_vector(to_unsigned(0, input2'length));
        wait for 40 ns;
        assert(branch_Taken = std_logic_vector(to_unsigned(0, branch_Taken'length))) report "Error : 5 <= 0 = " & integer'image(to_integer(unsigned(branch_Taken))) & " instead of 0" severity warning;


		    			-- test swap even 
	--	  OPSelect    <= "1000";
   --     input1 <= std_logic_vector(to_unsigned(12, input1'length));
    --    wait for 40 ns;
    --    assert(result = std_logic_vector(to_unsigned(8, result'length))) report "Error : 1000 & 1101 = " & integer'image(to_integer(unsigned(result))) & " instead of 1101" severity warning;

		  
        wait;

    end process;



end TB;