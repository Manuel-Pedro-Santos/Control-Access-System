LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity LCD_control_tb is 
end LCD_control_tb;

architecture behavioral of LCD_control_tb is

component LCD_Control is 
	port
	(
		-- Input ports
		CLK 		 : in std_logic;
		Dval 		 : in STD_LOGIC;
		reset     : in std_logic;
		eq15      : in std_logic;
		--SET : in std_logic;
		--EN : IN STD_LOGIC;
	
		-- Output ports
		  clr       : out std_logic;
		  Wrl       : out std_logic;
		  done     : out std_logic
	);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal Dval_tb, eq15_tb, clk_tb, reset_tb, clr_tb, Wrl_tb, done_tb: std_logic;

begin

-- UNIT UNDER TEST
UUT: LCD_Control port map (reset => reset_tb, Dval => Dval_tb, CLK => clk_tb, eq15 => eq15_tb,
clr => clr_tb, Wrl => Wrl_tb, done => done_tb);

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
Dval_tb <= '0';
eq15_tb <= '0';
wait for MCLK_PERIOD;

reset_tb <= '0';

wait for MCLK_PERIOD;

Dval_tb <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

--Simulamos que ja contou 15 segundos
eq15_tb <= '1';

wait for MCLK_PERIOD;


wait;

end process;

end behavioral;