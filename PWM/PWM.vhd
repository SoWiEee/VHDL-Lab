LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY PWM IS
	PORT(
		CLK	: in std_logic;
		A		: std_logic_vector(6 downto 0);
		PWM	: out std_logic
	);
END PWM;


ARCHITECTURE b OF PWM IS
	SIGNAL B	: std_logic_vector(7 downto 0);
	BEGIN
	PROCESS(CLK)
		BEGIN
			IF rising_edge(CLK) then
				B <= 	B-1;
			END IF;
	END PROCESS;

	PWM <= '1' when A > B else '0';
END b;