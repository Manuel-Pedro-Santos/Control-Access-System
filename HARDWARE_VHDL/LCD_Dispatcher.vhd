 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity LCD_Dispatcher is 
    port
    (
        -- Input ports
        Dval      : in std_logic;
        Din       : in std_logic_vector(4 downto 0);
        --eq15       : in std_logic;
		  clk       : in std_logic;
		  reset     : in std_logic;
		  --en        : in std_logic;
        --reset    : in std_logic;

        -- Output ports
        Wrl       : out std_logic;
        Dout      : out std_logic_vector(4 downto 0);
		  done     : out std_logic
    );
end LCD_Dispatcher;

architecture structural of LCD_Dispatcher is


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

component contador is 
	port
	(
		-- Input ports
		CLK : in std_logic;
		clr : in STD_LOGIC;
		--SET : in std_logic;
		EN : IN STD_LOGIC;
	
		-- Output ports
		Q : out std_logic_vector(3 downto 0)
	);
end component;

signal eq15x, clrx : std_logic;
signal Qx: std_logic_vector(3 downto 0);

begin

eq15x <= Qx(0) and Qx(1) and Qx(2) and Qx(3);
Dout <= Din;

T1: contador     port map(CLK => clk, clr => clrx, EN => '1', Q => Qx);
T2: LCD_Control  port map(CLK => clk, Dval => Dval, reset => reset, eq15 => eq15x, Wrl => Wrl, done => done, clr => clrx);

end structural;
