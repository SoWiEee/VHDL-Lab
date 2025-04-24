LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Random IS
    Port(
        clk, rst, stop : in STD_LOGIC;
        seg : out std_logic_vector(7 downto 0);
        Sel_seg : out STD_LOGIC_VECTOR(2 downto 0)
    );
END Random;

ARCHITECTURE Behavioral OF Random IS
	-- 24000000 / 100000 = 240 Hz (target time)
	constant divNum : integer := 100000; 
BEGIN
	PROCESS(clk, rst, stop)
		variable cnt : integer := 0; -- 0~100000 output 240Hz
		variable cntShow : integer := 0; -- 0~240 output 1Hz
		variable seed : integer := 1; -- Pseudo-random seed, simple integer for PRNG
		variable randomNUM : integer := 0; -- 0~9
	
	BEGIN
		if rst = '1' then
			cnt := 0; 
			cntShow := 0;
			seed := 1; -- Reset seed
			randomNUM := 0;
			seg <= (others => '0');
		elsif rising_edge(clk) then
			cnt := cnt + 1;
			-- divider frequency
			if (cnt = divNum) then 
				cnt := 0;
				ntShow := cntShow + 1;

				-- set random
				if cntShow = 24 then
					cntShow := 0;
					if  stop = '0'then
						-- Simple PRNG using integer arithmetic
						seed := (seed * 11035 + 12345) mod 2147; -- LCG parameters
						randomNUM := abs(seed) mod 10; -- Generate numbers between 0 and 9
					END if;
					END if;
                
					-- DISPLAY
					CASE randomNUM IS
						when 0 => seg <= "11111100";
						when 1 => seg <= "01100000";
						when 2 => seg <= "11011010";
						when 3 => seg <= "11110010";
						when 4 => seg <= "01100110";
						when 5 => seg <= "10110110";
						when 6 => seg <= "10111110";
						when 7 => seg <= "11100000";
						when 8 => seg <= "11111110";
						when 9 => seg <= "11110110";
						when others => seg <= "00000000";
					END case;
				END if;
			END if;
		END PROCESS;
END Behavioral;