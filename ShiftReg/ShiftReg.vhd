LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ShiftReg IS
	PORT(
		RST, CLK   : in std_logic;
		SEL	   : in std_logic_vector (1 downto 0);  -- select mode
		BA	   : in std_logic_vector(3 downto 0);	-- load mode input
		SRSI, SLSI : in std_logic;			-- right/left shift padding bit
		RC	   : out std_logic_vector(3 downto 0)	-- output
	);
END ShiftReg;

ARCHITECTURE b OF ShiftReg IS
	BEGIN
	PROCESS(CLK)
	BEGIN
		IF rising_edge(CLK) then
			IF RST = '1' then RC <= "0000";
			ELSE
				CASE s IS
					WHEN "00" => RC <= RC;
					WHEN "01" => RC(3) <= SRSI; RC(2) <= RC(3);
						     RC(1) <= RC(2); RC(0) <= RC(1);
				
					WHEN "10" => RC(3) <= RC(2); RC(2) <= RC(1);
						     RC(1) <= RC(0); RC(0) <= SLSI;
					WHEN "11" => RC <= BA;
					WHEN others => null;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
END b;
