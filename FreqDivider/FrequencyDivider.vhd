Library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity FrequencyDivider is
    --generic (divisor : integer := 2);
    port (
        clk_in    : in  std_logic;
        clk_out8Hz : out std_logic;
        clk_out4Hz : out std_logic;
        clk_out2Hz : out std_logic;
        clk_out1Hz : out std_logic
    );
end FrequencyDivider;

architecture arch of FrequencyDivider is
    signal cnt : integer range 0 to 16 := 0;

    signal clk_divided : std_logic_vector(3 downto 0) := "0000";	--array

	begin
	 -- 8Hz
		process(clk_in)
		begin
			if falling_edge(clk_in) then
				clk_divided(0) <= not clk_divided(0);	-- 8 Hz
				cnt <= cnt + 1;
				
				if ((cnt+1) rem 2 = 0) then
					clk_divided(1) <= not clk_divided(1);	-- 4 Hz
				end if;
				
				if ((cnt+1) rem 4 = 0) then
					clk_divided(2) <= not clk_divided(2);	-- 2 Hz
				end if;
				
				if ((cnt+1) rem 8 = 0) then
					clk_divided(3) <= not clk_divided(3);	-- 1 Hz
				end if;
			end if;
		end process;

	clk_out8Hz <= clk_divided(0);
	clk_out4Hz <= clk_divided(1);
	clk_out2Hz <= clk_divided(2);
	clk_out1Hz <= clk_divided(3);

end arch;

