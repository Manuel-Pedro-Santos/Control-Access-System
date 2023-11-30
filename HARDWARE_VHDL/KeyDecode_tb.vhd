LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity KeyDecode_TB is 
end KeyDecode_TB;

architecture behavioral of KeyDecode_TB is

component KeyDecode is
port(
        --Kscan    : in std_logic;
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);
		  Kack     : in std_logic;

        K        : out std_logic_vector(3 downto 0);
        --Kpress   : out std_logic;
		  Cbutton  : out std_logic_vector(3 downto 0);
		  Kval     : out std_logic
		  
);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal Kack_tb , clr_tb, clk_in_tb, Kval_tb : std_logic;
signal Lbutton_tb, K_tb, Cbutton_tb : std_logic_vector (3 downto 0);

begin

UUT: KeyDecode port map (Kack => Kack_tb, clk_in => clk_in_tb, clr => clr_tb, Lbutton => Lbutton_tb, K => K_tb, 
Kval => Kval_tb, Cbutton => Cbutton_tb);

clk_gen : process 
begin
clk_in_tb <= '0';
wait for MCLK_HALF_PERIOD;
clk_in_tb <= '1';
wait for MCLK_HALF_PERIOD;
end process;

stimulus : process
begin
Kack_tb <= '0';
clr_tb <='1';
Lbutton_tb <= "1111";
wait for MCLK_PERIOD;

wait for MCLK_PERIOD;  --damos outro clock para o kpress estar msm a 0 e o Ksacn ativado 

clr_tb <='0';
Lbutton_tb <= "1110";

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;  -- aqui o Kval tem que estar ativado e o Ksacn a 0

Kack_tb <= '1';

wait for MCLK_PERIOD;

wait for MCLK_PERIOD;

Kack_tb <= '0';

wait for MCLK_PERIOD;  -- aqui supostamente o kpress esta a 1

Lbutton_tb <= "1111";

wait for MCLK_PERIOD;

clr_tb <= '1';

wait;
end process;

end behavioral;

