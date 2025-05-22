LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY AlarmClock IS
    PORT (
        clk    : in std_logic;  -- 1Hz
        rst    : in std_logic;  -- SW4, reset
        sw1    : in std_logic;  -- SW1, start
        sw2    : in std_logic;  -- SW2, setting digit
        sw3    : in std_logic;  -- SW3, pause/+1
		  SEG		: out std_logic_vector(6 downto 0);
        --seg_1  : out std_logic_vector(3 downto 0); -- ?_
        --seg_10 : out std_logic_vector(3 downto 0); -- _?
        alarm  : out std_logic;  -- set '1' when "00"
		  SEL		: out std_logic_vector(2 downto 0)
    );
END AlarmClock;

ARCHITECTURE b OF AlarmClock IS

	signal state      : std_logic_vector(2 downto 0);
	signal next_state : std_logic_vector(2 downto 0);
	 
	signal digit : std_logic_vector(3 downto 0);
	signal sel_counter : std_logic := '0';  -- flash
	signal one, ten : std_logic_vector(3 downto 0); -- time

    -- state define
	constant S_RESET    : std_logic_vector(2 downto 0) := "000";
	constant S_START    : std_logic_vector(2 downto 0) := "001";
	constant S_PAUSE    : std_logic_vector(2 downto 0) := "010";
	constant S_SET_TEN  : std_logic_vector(2 downto 0) := "011";
	constant S_SET_ONE  : std_logic_vector(2 downto 0) := "100";

	signal cnt10, cnt1 : std_logic_vector(3 downto 0) := "0000";	-- init

BEGIN
    -- State Update routine
    PROCESS(clk, rst)
    BEGIN
        if rst = '1' then
            state <= S_RESET;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    END PROCESS;

    -- State Tranfer routine
	PROCESS(state, sw1, sw2, sw3, rst)
	BEGIN
		next_state <= state; -- keep

			-- reset...
			if state = S_RESET then
				next_state <= S_START;

			-- start...
			elsif state = S_START then
				-- set time
				if sw2 = '1' then
                next_state <= S_SET_TEN;
				-- pause
            elsif sw3 = '1' then
                next_state <= S_PAUSE;
            end if;

			-- pause...
			elsif state = S_PAUSE then
				if sw3 = '1' then
					next_state <= S_START;
				elsif sw2 = '1' then
					next_state <= S_SET_TEN;
            end if;

			-- setting(_?)...
			elsif state = S_SET_TEN then
				-- switch
				if sw2 = '1' then
					next_state <= S_SET_ONE;
				-- continue
            elsif sw1 = '1' then
					next_state <= S_START;
            end if;
			
			-- setting(?_)...
			elsif state = S_SET_ONE then
				-- switch
				if sw2 = '1' then
					next_state <= S_SET_TEN;
				-- continue
            elsif sw1 = '1' then
					next_state <= S_START;
            end if;
        end if;
    END PROCESS;

    -- implement function logic
    PROCESS(clk)
    BEGIN
        if rising_edge(clk) then
            if state = S_RESET then
                cnt10 <= "0101"; -- 5
                cnt1  <= "1001"; -- 9

            elsif state = S_START then
					-- decrease
					if cnt1 > "0000" then
                    cnt1 <= cnt1 - 1;
					-- borrow
					elsif cnt10 > "0000" then
                    cnt10 <= cnt10 - 1;
                    cnt1 <= "1001";			-- 9
					else
                    cnt10 <= "0000";
                    cnt1 <= "0000";
					end if;

				elsif state = S_SET_TEN and sw3 = '1' then
					if cnt10 < "0101" then
						cnt10 <= cnt10 + 1;
					else
						cnt10 <= "0000";
					end if;

				-- increase time
				elsif state = S_SET_ONE and sw3 = '1' then
					if cnt1 < "1001" then
						cnt1 <= cnt1 + 1;
					else
						cnt1 <= "0000";
					end if;
				end if;
			end if;
	END PROCESS;
	
	-- 7-segment decoder
	FUNCTION to_7seg(b : std_logic_vector(3 downto 0)) RETURN std_logic_vector IS
		 VARIABLE SEG : std_logic_vector(6 downto 0);
	BEGIN
		 CASE b IS
			  WHEN "0000" => seg := "1000000"; -- 0
			  WHEN "0001" => seg := "1111001"; -- 1
			  WHEN "0010" => seg := "0100100"; -- 2
			  WHEN "0011" => seg := "0110000"; -- 3
			  WHEN "0100" => seg := "0011001"; -- 4
			  WHEN "0101" => seg := "0010010"; -- 5
			  WHEN "0110" => seg := "0000010"; -- 6
			  WHEN "0111" => seg := "1111000"; -- 7
			  WHEN "1000" => seg := "0000000"; -- 8
			  WHEN "1001" => seg := "0010000"; -- 9
			  WHEN others => seg := "0001110"; -- F
		 END CASE;
		 RETURN SEG;
	END;
	-- 7-segment display
	PROCESS(clk)
	BEGIN
		 IF rising_edge(clk) THEN
			  sel_counter <= NOT sel_counter;

			  IF sel_counter = '0' THEN
					SEG <= to_7seg(cnt1);
					SEL <= "001";
			  ELSE
					SEG <= to_7seg(cnt10);
					SEL <= "010";
			  END IF;
		 END IF;
	END PROCESS;

	-- output
	alarm <= '1' when (cnt10 = "0000" and cnt1 = "0000") else '0';
END b;