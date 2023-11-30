LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity serial_receiver_tb is 
end serial_receiver_tb;

architecture behavioral of serial_receiver_tb is

component serial_receiver is
port(
		  SDX		  : in std_logic;
		  SCLK	  : in std_logic;
		  SS       : in std_logic;
		  accept   : in std_logic;
		  reset    : in std_logic;
		  MCLK     : in std_logic;


        DXval        : out std_logic;
		  busy : out std_logic;
		  D  : out std_logic_vector(4 downto 0)
		  
);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD/2;

signal SDX_tb , SCLK_tb, MCLK_tb, SS_tb, accept_tb, reset_tb, DXval_tb, busy_tb: std_logic;
signal D_tb : std_logic_vector (4 downto 0);

begin

UUT: serial_receiver port map (SDX => SDX_tb, MCLK => MCLK_tb, SCLK => SCLK_tb, SS => SS_tb, accept => accept_tb, 
reset => reset_tb, DXval => DXval_tb, busy => busy_tb, D => D_tb);

clk_gen : process 
begin
MCLK_tb <= '0';
wait for MCLK_HALF_PERIOD;
MCLK_tb <= '1';
wait for MCLK_HALF_PERIOD;
end process;

stimulus : process
begin
reset_tb <= '1';
SDX_tb <='1';
SCLK_tb <= '0';
SS_tb <= '1';
accept_tb <='0';
wait for MCLK_PERIOD;

reset_tb <= '0';

wait for MCLK_PERIOD; 

SS_tb <= '0';

wait for MCLK_PERIOD;

SCLK_tb <= '1';

wait for MCLK_PERIOD;  

SDX_tb <='0';
SCLK_tb <= '0';

wait for MCLK_PERIOD;

SCLK_tb <= '1';

wait for MCLK_PERIOD;

SDX_tb <='1';
SCLK_tb <= '0';

wait for MCLK_PERIOD;  

SCLK_tb <= '1';

wait for MCLK_PERIOD;

SDX_tb <='0';
SCLK_tb <= '0';

wait for MCLK_PERIOD;  

SCLK_tb <= '1';

wait for MCLK_PERIOD;

SDX_tb <='1';
SCLK_tb <= '0';

wait for MCLK_PERIOD;  

SCLK_tb <= '1';             -- aqui supostamente esta tudo e o eq5 = 1

wait for MCLK_PERIOD;

SCLK_tb <= '0';             -- aqui supostamente esta tudo e o eq5 = 1

wait for MCLK_PERIOD;

accept_tb <='1';

wait for MCLK_PERIOD;

wait;
end process;

end behavioral;

