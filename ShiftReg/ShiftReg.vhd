LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ShiftReg IS
	PORT(
		rst, clk : in std_logic;
		s : in std_logic_vector (1 downto 0);
		ba: in std_logic_vector(3 downto 0);
		srsi, slsi : in std_logic;
		rc: inout std_logic_vector(3 downto 0)
	);

END ShiftReg;

ARCHITECTURE b OF ShiftReg IS
	BEGIN
	PROCESS(clk)
	BEGIN
		IF rising_edge(clk) then
			IF rst = '1' then rc <= "0000";
			ELSE
				CASE s IS
					WHEN "00" => rc <= rc;
					WHEN "01" => rc(3) <= srsi; rc(2) <= rc(3);
									 rc(1) <= rc(2); rc(0) <= rc(1);
				
					WHEN "10" => rc(3) <= rc(2); rc(2) <= rc(1);
									 rc(1) <= rc(0); rc(0) <= slsi;
					WHEN "11" => rc <= ba;
					WHEN others => null;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
END b;