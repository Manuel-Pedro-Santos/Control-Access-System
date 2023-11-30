library ieee;
use ieee.std_logic_1164.all;

entity SLCDC is
port(
		  SDX		  : in std_logic;
		  SCLK	  : in std_logic;
		  SS       : in std_logic;
		  --accept   : in std_logic;  -- mais tarde nao vai ter
		  reset    : in std_logic;
		  --enable   : in std_logic;
		  MCLK     : in std_logic;


        Wrl      : out std_logic;

		  Dout     : out std_logic_vector(4 downto 0)
		  
);
end SLCDC;

architecture structural of SLCDC is

component serial_receiver is
port(
        --Kscan    : in std_logic;
		  SDX		  : in std_logic;
		  SCLK	  : in std_logic;
		  SS       : in std_logic;
		  accept   : in std_logic;
		  reset    : in std_logic;
		  --enable   : in std_logic;
		  MCLK     : in std_logic;
--		  S_Mux	  : in std_Logic_vector(1 downto 0);
--		  S_Dec	  : in std_Logic_vector(1 downto 0);

        DXval        : out std_logic;
		  busy : out std_logic;
        --Kpress   : out std_logic;
		  D  : out std_logic_vector(4 downto 0)
		  
);
end component;

component LCD_Dispatcher is 
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
end component;

signal Dxvalx, acceptx: std_logic;
signal Dinx: std_logic_vector(4 downto 0);

begin


F1: serial_receiver port map(SDX => SDX, SCLK => SCLK, SS => SS, accept => acceptx, reset => reset, MCLK => MCLK, DXval => Dxvalx, D => Dinx);
F2: LCD_Dispatcher  port map(Dval => Dxvalx, Din => Dinx, clk => MCLK, reset => reset,  Dout => Dout, Wrl => Wrl, done => acceptx);

end structural;
