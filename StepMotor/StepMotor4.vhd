LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY StepMotor IS
    PORT(
        clk  : in  std_logic;                      -- 24MHz
        dir  : in  std_logic;                      -- 1+ 0-
        step : out std_logic_vector(3 downto 0) 
    );
END StepMotor;

ARCHITECTURE arch OF StepMotor IS
    constant div_value : integer := 480000;
    signal clk_cnt     : integer := 0;
    signal step_cnt    : integer range 0 to 3 := 0;
BEGIN
    PROCESS(clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF clk_cnt = div_value - 1 THEN
                clk_cnt <= 0;

                -- DIR control
                IF dir = '1' THEN	-- up
                    IF step_cnt = 3 THEN
                        step_cnt <= 0;
                    ELSE
                        step_cnt <= step_cnt + 1;
                    END IF;
                ELSE						-- down
                    IF step_cnt = 0 THEN
                        step_cnt <= 3;
                    ELSE
                        step_cnt <= step_cnt - 1;
                    END IF;
                END IF;

            ELSE
                clk_cnt <= clk_cnt + 1;
            END IF;
        END IF;
    END PROCESS;

    WITH step_cnt SELECT
        step <= "1000" WHEN 0,  -- A active
                "0100" WHEN 1,  -- B active
                "0010" WHEN 2,  -- C active
                "0001" WHEN 3;  -- D active

END arch;