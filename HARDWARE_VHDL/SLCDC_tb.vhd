LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity SLCDC_tb is 
end SLCDC_tb;

architecture behavioral of SLCDC_tb is

component SLCDC is
port(
		  SDX		  : in std_logic;
		  SCLK	  : in std_logic;
		  SS       : in std_logic;
		  reset    : in std_logic;
		  MCLK     : in std_logic;


        Wrl      : out std_logic;
		  Dout     : out std_logic_vector(4 downto 0)
		  
);
end component;

--UUT signals
constant MCLK_PERIOD : time := 20 ns;
constant MCLK_HALF_PERIOD : time := MCLK_PERIOD /2 ;

signal SDX_tb , SCLK_tb, MCLK_tb, SS_tb, Wrl_tb, reset_tb: std_logic;
signal Dout_tb : std_logic_vector (4 downto 0);

begin

-- UNIT UNDER TEST
UUT: SLCDC port map (SDX => SDX_tb, MCLK => MCLK_tb, SCLK => SCLK_tb, SS => SS_tb, Wrl => Wrl_tb, 
reset => reset_tb, Dout => Dout_tb);


clk_gen : process 
begin
MCLK_tb <= '0';
wait for MCLK_HALF_PERIOD;
MCLK_tb <= '1';
wait for MCLK_HALF_PERIOD;
end process;

stimulus : process
begin
-- reset
reset_tb <= '1';
SDX_tb <='1';
SCLK_tb <= '0';
SS_tb <= '1';
wait for MCLK_PERIOD;

reset_tb <= '0';

wait for MCLK_PERIOD; --ate aqui o clr esta ativado, nao estamos a contar

SS_tb <= '0';       --aqui supostamente ativamos o shift register

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

SCLK_tb <= '1';             

wait for MCLK_PERIOD;

SCLK_tb <= '0'; -- aqui supostamente esta tudo e o eq5 = 1

--wait for MCLK_PERIOD; 

wait for MCLK_PERIOD; --aqui o DXval esta ativo logo o Dval esta aivo no dispacther

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

wait for MCLK_PERIOD; --accept ativou 



wait;

end process;

end behavioral;