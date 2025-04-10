LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY BCD2SegDisplay IS
    PORT(
        clk, rst	: in std_logic;
        seg			: out std_logic_vector(7 downto 0);
        Sel_seg	: out std_logic_vector(2 downto 0)
    );
END BCD2SegDisplay;

ARCHITECTURE Behavior OF BCD2SegDisplay IS
	-- 24MHz /10000 = 2.4 kHz
	constant divisor : integer := 10000;
	
	BEGIN
	PROCESS(clk, rst)
		variable cnt : integer := 0;
		variable cntShow : integer := 0;
		variable NumCnt : integer := 0;
		variable SelShow : integer := 0;
		
		BEGIN
		if rst = '1' then
			cnt := 0;
			NumCnt := 0;
			SelShow := 0;
			cntShow := 0;
			seg <= (others => '0');
		elsif rising_edge(clk) then
			cnt := cnt + 1;
			-- divider frequency: 2400 Hz
			if cnt = divisor then
				cnt := 0;
				cntShow := cntShow + 1;

				-- count part
				if cntShow = 240 then
					cntShow := 0;
					NumCnt := NumCnt + 1;
					
					-- reach 100 => reset NumCnt
					if NumCnt = 100 then
						NumCnt := 0;
					END if;
				END if;
                
				-- display part
				SelShow := 1 - SelShow;
				if SelShow = 1 then
					Sel_seg <= "001";
					CASE (NumCnt mod 10) is
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
						when others => seg <= (others => '0');
					END CASE;
				else
					Sel_seg <= "000";
					CASE (NumCnt/10) is
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
						when others => seg <= (others => '0');
					END CASE;
				END if;
			END if;
		END if;
	END PROCESS;
END Behavior;