LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KEY_CONTROL_TB is 
end KEY_CONTROL_TB;

architecture behavioral of KEY_CONTROL_TB is

component key_control is 
port(
         -- Input ports
        Kpress     : in std_logic;
        Kack         : in std_logic;
        clk       : in std_logic;
        reset    : in std_logic;

        -- Output ports
        Kscan        : out std_logic;
        Kval        : out std_logic

);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal Kpress_tb, Kack_tb, clk_tb, reset_tb, Ksacn_tb, Kval_tb: std_logic;

begin

-- UNIT UNDER TEST
UUT: key_control port map (reset => reset_tb, Kpress => Kpress_tb, clk => clk_tb, Kack => Kack_tb,
Kscan => Ksacn_tb, Kval => Kval_tb);

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
Kpress_tb <= '0';
Kack_tb <= '0';
wait for MCLK_PERIOD;

reset_tb <= '0';

wait for MCLK_PERIOD;

Kpress_tb <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kack_tb <= '0';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kack_tb <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

-- ver se estamos no estado IDLE que esta vazio
wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kack_tb <= '0';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kpress_tb <= '0';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

wait;

end process;

end behavioral;