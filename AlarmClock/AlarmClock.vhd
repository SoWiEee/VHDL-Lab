LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY AlarmClock IS
    PORT(
        CLK    : in std_logic;  -- 1Hz
        RST    : in std_logic;  -- SW4
        SW1    : in std_logic;  -- START
        SW2    : in std_logic;  -- SET_MODE
        SW3    : in std_logic;  -- PAUSE / INC
        seg_1  : out std_logic_vector(3 downto 0); -- ?_
        seg_10 : out std_logic_vector(3 downto 0); -- _?
        alarm  : out std_logic  -- set 1 when "00"
    );
END AlarmClock;

ARCHITECTURE b OF AlarmClock IS

    type state_type is (RESET, START, PAUSE, SET_TEN, SET_ONE);
    signal state, next_state : state_type;

    signal cnt1, cnt10 : std_logic_vector(3 downto 0) := "1001"; -- default 59
    signal setting_mode : std_logic := '0'; -- 0: SET_TEN, 1: SET_ONE

BEGIN

    -- State Transfer
    PROCESS(clk, rst)
    BEGIN
        IF rst = '1' then
            state <= RESET;
        ELSIF rising_edge(clk) then
            state <= next_state;
        END IF;
    END PROCESS;

    -- State Control
    PROCESS(state, sw1, sw2, sw3, rst)
    BEGIN
        next_state <= state;
        CASE state IS
            when RESET =>
                next_state <= START;

            when START =>
                if sw2 = '1' then
                    next_state <= SET_TEN;
                ELSIF sw3 = '1' then
                    next_state <= PAUSE;
                END IF;

            when PAUSE =>
                if sw3 = '1' then
                    next_state <= START;
                ELSIF sw2 = '1' then
                    next_state <= SET_TEN;
                END IF;

            when SET_TEN =>
                if sw2 = '1' then
                    next_state <= SET_ONE;
                ELSIF sw1 = '1' then
                    next_state <= START;
                END IF;

            when SET_ONE =>
                if sw2 = '1' then
                    next_state <= SET_TEN;
                ELSIF sw1 = '1' then
                    next_state <= START;
                END IF;
        END CASE;
    END PROCESS;

    -- count and set
    PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) then
            IF state = RESET then
                cnt10 <= "0101"; -- 5
                cnt1 <= "1001";  -- 9
            ELSIF state = START then
                if cnt1 > "0000" then
                    cnt1 <= cnt1 - 1;
                ELSIF cnt10 > "0000" then
                    cnt10 <= cnt10 - 1;
                    cnt1 <= "1001";
                else
                    cnt10 <= "0000";
                    cnt1 <= "0000";
                END IF;
            ELSIF state = SET_TEN and sw3 = '1' then
                if cnt10 < "0101" then
                    cnt10 <= cnt10 + 1;
                else
                    cnt10 <= "0000";
                END IF;
            ELSIF state = SET_ONE and sw3 = '1' then
                if cnt1 < "1001" then
                    cnt1 <= cnt1 + 1;
                else
                    cnt1 <= "0000";
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- output
    seg_10 <= (others => '1') when state = SET_ONE else cnt10;
    seg_1  <= (others => '1') when state = SET_TEN else cnt1;
    alarm <= '1' when (cnt10 = "0000" and cnt1 = "0000") else '0';

END b;