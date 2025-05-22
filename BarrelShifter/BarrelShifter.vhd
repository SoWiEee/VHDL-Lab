LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY BarrelShifter IS
    PORT(
        mode : in std_logic;
        SEL  : in std_logic_vector(1 downto 0);
        BA   : in std_logic_vector(3 downto 0);
        BC   : out std_logic_vector(3 downto 0)
    );
END BarrelShifter;

ARCHITECTURE b OF BarrelShifter IS
    SIGNAL temp : std_logic_vector(3 downto 0);
BEGIN
    PROCESS(mode, SEL, BA)
    BEGIN
        CASE SEL IS
            when "00" => temp <= BA;
            when "01" =>
                IF mode = '0' then -- left rotate 1
                    temp <= BA(2 downto 0) & BA(3);
                ELSE              -- right rotate 1
                    temp <= BA(0) & BA(3 downto 1);
                END IF;
					 
            when "10" =>
                IF mode = '0' then -- left rotate 2
                    temp <= BA(1 downto 0) & BA(3 downto 2);
                ELSE               -- right rotate 2
                    temp <= BA(1) & BA(0) & BA(3 downto 2);
                END IF;
					 
            when "11" =>
                if mode = '0' then -- left rotate 3
                    temp <= BA(0) & BA(3 downto 1);
                ELSE               -- right rotate 3
                    temp <= BA(2 downto 0) & BA(3);
                END IF;
            when others =>
                temp <= (others => '0');
        END CASE;

        BC <= temp;
    END PROCESS;
END b;