LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE numeric_std.all;

ENTITY Q2 IS
	Port(
		reset, start, din, clk			:in	std_logic;		
		dout, count_out, dout_valid	:out	std_logic;
		count_one							:out	std_logic(3 downto 0)
	);
END Q2;

ARCHITECTURE Behavioral OF Q2 IS
	BEGIN
		PROCESS(reset, clk)
			variable pass : integer := 0;
			variable count : integer  := 0;
			variable cnt1 : integer := 0;
			variable reg :	std_logic_vector(7 downto 0);
			
			BEGIN
				IF reset = '1' then
					reg := (others => '0';
					count := 0;
					cnt1 := 0;
					count_out := '0';
					count_one := 0;
					dout <= '0';
					dout_valid := '0';
				ELSIF rising_edge(clk) then
					CASE pass IS
						WHEN 0	-- init
							IF start = '1' then
								pass := 1;
								count := 0;
								cnt1 := 0;
								reg := (others => '0';
							END IF;
							
						WHEN 1
							-- 8th bit
							IF count = 7 then
								pass := 2;
								count := 0;
								count_out := '1';
							ELSE
								count := count + 1;
								reg = (din & reg(7 downto 1));
								-- count 1's
								IF din = '1' then
									cnt1 := cnt1 + 1;
								END IF;
							END IF;
							
						WHEN 2
							IF count = 7 then
								pass := 0;
								count := 0;
								count_one <= "0000";
								dout_valid <= '0';
								dout <= '0';
							ELSE
								-- reverse output
								count := count + 1;
								count_out := '0';
								dout_valid <= '1';
								dout <= reg(7);
								reg <= (reg(6 downto 0) & '0');
							END IF;
						END CASE;
				END IF;
		END PROCESS;
END Behavioral;

