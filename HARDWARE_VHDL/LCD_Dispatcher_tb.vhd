LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity LCD_Dispatcher_tb is 
end LCD_Dispatcher_tb;

architecture behavioral of LCD_Dispatcher_tb is

component LCD_Dispatcher is 
    port
    (
        -- Input ports
        Dval      : in std_logic;
        Din       : in std_logic_vector(4 downto 0);
		  clk       : in std_logic;
		  reset     : in std_logic;

        -- Output ports
        Wrl       : out std_logic;
        Dout      : out std_logic_vector(4 downto 0);
		  done     : out std_logic
    );
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal Dval_tb, clk_tb, reset_tb, Wrl_tb, done_tb: std_logic;
signal Din_tb, Dout_tb: std_logic_vector(4 downto 0);

begin

-- UNIT UNDER TEST
UUT: LCD_Dispatcher port map (reset => reset_tb, Dval => Dval_tb, clk => clk_tb, Din => Din_tb,
Wrl => Wrl_tb, Dout => Dout_tb, done => done_tb);

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
Din_tb <= "10101";
wait for MCLK_PERIOD;

reset_tb <= '0';

wait for MCLK_PERIOD;

Dval_tb <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;