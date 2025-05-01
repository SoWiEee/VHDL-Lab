LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY StepMotor IS
	PORT(
		clk	: in std_logic;
		step	: out std_logic_vector(3 downto 0)
	);
END StepMotor;

ARCHITECTURE arch OF StepMotor IS
	signal clk_cnt : integer := 0;
	signal halfstep_cnt : integer range 0 to 7 := 0;
	constant div_value : integer := 480000;

BEGIN
	PROCESS(clk)
	BEGIN
		IF rising_edge(clk) THEN
			if clk_cnt = div_value - 1 then
				clk_cnt <= 0;
				if halfstep_cnt = 7 then
					halfstep_cnt <= 0;
				else
					halfstep_cnt <= halfstep_cnt + 1;
				end if;
			else
				clk_cnt <= clk_cnt + 1;
			end if;
		END IF;
	END PROCESS;

	-- half step control
	with halfstep_cnt select
		step <= "1000" when 0,
		        "1100" when 1,
		        "0100" when 2,
		        "0110" when 3,
		        "0010" when 4,
		        "0011" when 5,
		        "0001" when 6,
		        "1001" when others;
END arch;