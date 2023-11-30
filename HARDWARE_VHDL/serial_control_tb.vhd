LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity serial_control_tb is 
end serial_control_tb;

architecture behavioral of serial_control_tb is

component serial_control is 
    port
    (
        -- Input ports
        enRx      : in std_logic;
        accept    : in std_logic;
        eq5       : in std_logic;
		  clk       : in std_logic;
		  reset     : in std_logic;

        -- Output ports
        clr       : out std_logic;
        wr        : out std_logic;
		  busy      : out std_logic;
		  DXval     : out std_logic
    );
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal enRx_tb, accept_tb, clk_tb, reset_tb, eq5_tb, clr_tb, wr_tb, busy_tb, DXval_tb : std_logic;

begin

-- UNIT UNDER TEST
UUT: serial_control port map (reset => reset_tb, enRx => enRx_tb, clk => clk_tb, accept => accept_tb,
eq5 => eq5_tb, clr => clr_tb, wr => wr_tb, busy => busy_tb, DXval => DXval_tb);

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
enRx_tb <= '1';
accept_tb <= '0';
eq5_tb <= '0';
wait for MCLK_PERIOD;

reset_tb <= '0';

wait for MCLK_PERIOD;

enRx_tb <= '0';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

eq5_tb <= '1'; --Simulamos que ja contou ate 5

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

accept_tb <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;