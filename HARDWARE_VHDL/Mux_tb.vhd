LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity Mux_tb is
End Mux_tb;

architecture behavioral of Mux_tb is

component MUX_KeyScan is 
    port
    (
        -- Input ports
        A1 : in std_logic;
        A2 : in std_logic;
        A3 : in std_logic;
        A4 : in std_logic;
        S0 : in std_logic;
        S1 : in std_logic;

        -- Output ports
        Y : out std_logic
    );
end component;

--UUT signals 
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;


signal A1_tb , A2_tb, A3_tb, A4_tb, S0_tb, S1_tb, Y_tb:std_logic;

begin 
UUT: MUX_KeyScan port map(A1 => A1_tb, A2 => A2_tb, A3 => A3_tb, A4 => A4_tb, S0 => S0_tb, S1 => S1_tb, Y => Y_tb);

--clk_gen : process 
--begin
--clk_tb <= '0';
--wait for MCLK_HALF_PERIOD;
--clk_tb <= '1';
--wait for MCLK_HALF_PERIOD; 
--end process;


stimulus : process
	begin  
	S0_tb <= '0';
	S1_tb <= '0';
	A1_tb <= '1';
	A2_tb <= '0';	
	A3_tb <= '1';	
	A4_tb <= '0';		
		
	wait for MCLK_PERIOD;
	
	S0_tb <= '1';
	S1_tb <= '0';
	
	wait for MCLK_PERIOD;
	
	S0_tb <= '0';
	S1_tb <= '1';
	
	wait for MCLK_PERIOD;
	
	S0_tb <= '1';
	S1_tb <= '1';
	
	wait for MCLK_PERIOD;
	

wait;
end process;

end architecture; 