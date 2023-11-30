LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KeyScan_TB is 
end KeyScan_TB;

architecture behavioral of KeyScan_TB is

component KeyScan is
port(
        Kscan    : in std_logic;
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);

        K        : out std_logic_vector(3 downto 0);
        Kpress   : out std_logic;
		  Cbutton  : out std_logic_vector(3 downto 0)
		  
);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal Kscan_tb , clr_tb, clk_in_tb, Kpress_tb : std_logic;
signal Lbutton_tb, K_tb, Cbutton_tb : std_logic_vector (3 downto 0);

begin

UUT: KeyScan port map (Kscan => Kscan_tb, clk_in => clk_in_tb, clr => clr_tb, Lbutton => Lbutton_tb, K => K_tb, 
Kpress => Kpress_tb, Cbutton => Cbutton_tb);

clk_gen : process 
begin
clk_in_tb <= '0';
wait for MCLK_HALF_PERIOD;
clk_in_tb <= '1';
wait for MCLK_HALF_PERIOD;
end process;

stimulus : process
begin
Kscan_tb <= '1';
clr_tb <='1';
Lbutton_tb <= "1111";
wait for MCLK_PERIOD;

clr_tb <= '0';
Lbutton_tb <= "1110";

wait for MCLK_PERIOD;

Lbutton_tb <= "1101";

wait for MCLK_PERIOD;

Lbutton_tb <= "1011";

wait for MCLK_PERIOD;

Lbutton_tb <= "0111";

wait for MCLK_PERIOD;

Lbutton_tb <= "1110";

wait for MCLK_PERIOD;

Lbutton_tb <= "1101";

wait for MCLK_PERIOD;

Lbutton_tb <= "1011";

wait for MCLK_PERIOD;

Lbutton_tb <= "0111";

wait for MCLK_PERIOD;

Lbutton_tb <= "1110";

wait for MCLK_PERIOD;

Lbutton_tb <= "1101";

wait for MCLK_PERIOD;

Lbutton_tb <= "1011";

wait for MCLK_PERIOD;

Lbutton_tb <= "0111";

wait for MCLK_PERIOD;

Lbutton_tb <= "1110";

wait for MCLK_PERIOD;

Lbutton_tb <= "1101";

wait for MCLK_PERIOD;

Lbutton_tb <= "1011";

wait for MCLK_PERIOD;

Lbutton_tb <= "0111";

wait for MCLK_PERIOD;

clr_tb <= '1';

wait;
end process;

end behavioral;

