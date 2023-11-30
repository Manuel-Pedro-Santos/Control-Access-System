LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DEC_KeyScan_TB is 
end DEC_KeyScan_TB;

architecture behavioral of DEC_KeyScan_TB is

component DEC_KeyScan is 
	port
	(
		-- Input ports
		S : in std_logic_vector(1 downto 0);
	
		-- Output ports
		Q : out std_logic_vector(3 downto 0)
	);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal S_TB: std_logic_vector (1 downto 0);
signal Q_tb: std_logic_vector (3 downto 0);

begin

-- UNIT UNDER TEST
UUT: DEC_KeyScan port map (S => S_tb, Q => Q_tb);

stimulus : process
begin

S_tb <= "00";

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

S_tb <= "01";

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

S_tb <= "10";

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

S_tb <= "11";

wait for MCLK_PERIOD;

wait;

end process;
end behavioral;
