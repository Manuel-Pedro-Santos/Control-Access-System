LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity COUNTER_SERIAL_TB is 
end COUNTER_SERIAL_TB;

architecture behavioral of COUNTER_SERIAL_TB is

component contador_serial is 
	port
	(
		-- Input ports
		CLK : in std_logic;
		clr : in STD_LOGIC;
		EN : IN STD_LOGIC;
	
		-- Output ports
		Q : out std_logic_vector(2 downto 0)
	);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal clk_tb, clr_tb,enable_tb: std_logic;
signal Q_tb: std_logic_vector (2 downto 0);

begin

-- UNIT UNDER TEST
UUT: contador_serial port map (CLK => clk_tb, clr => clr_tb, EN => enable_tb, Q => Q_tb);

clk_gen : process 
begin
clk_tb <= '0';
wait for MCLK_HALF_PERIOD;
clk_tb <= '1';
wait for MCLK_HALF_PERIOD; 
end process;

stimulus : process
begin
-- reset
clr_tb <= '1';
enable_tb <= '0';
wait for MCLK_PERIOD;

clr_tb <= '0';

wait for MCLK_PERIOD;

enable_tb <= '1';

wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;
wait for MCLK_PERIOD;

enable_tb <= '0';

wait;

end process;
end behavioral;
