LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity shift_register_tb is 
end shift_register_tb;

architecture behavioral of shift_register_tb is

component shift_register is 
	PORT(	
		CLK	: in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		data : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		D : out std_logic_vector(4 downto 0)
		);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal SET_tb, data_tb, clk_tb, reset_tb, EN_tb: std_logic;
signal D_tb : std_logic_vector(4 downto 0);

begin

-- UNIT UNDER TEST
UUT: shift_register port map (RESET => reset_tb, SET => SET_tb, clk => clk_tb, data => data_tb, EN => EN_tb, D => D_tb);

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
reset_tb <= '1';
SET_tb <= '0';
data_tb <= '1';
EN_tb <= '0';

wait for MCLK_PERIOD;

reset_tb <= '0';

wait for MCLK_PERIOD;

EN_tb <= '1';

wait for MCLK_PERIOD;

data_tb <= '0';

wait for MCLK_PERIOD;

data_tb <= '1';

wait for MCLK_PERIOD;

data_tb <= '0';

wait for MCLK_PERIOD;

data_tb <= '1';
EN_tb <= '0';

wait;

end process;

end behavioral;