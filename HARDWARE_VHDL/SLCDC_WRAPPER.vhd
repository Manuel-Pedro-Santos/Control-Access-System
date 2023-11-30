library ieee;
use ieee.std_logic_1164.all;

entity SLCDC_WRAPPER is
port(
        --Kscan    : in std_logic;
		  --SDX		  : in std_logic;
		  --SCLK	  : in std_logic;
		  --SS       : in std_logic;
		  --accept   : in std_logic;  -- mais tarde nao vai ter
		  reset    : in std_logic;
		  --enable   : in std_logic;
		  MCLK     : in std_logic;
--		  S_Mux	  : in std_Logic_vector(1 downto 0);
--		  S_Dec	  : in std_Logic_vector(1 downto 0);

        Wrl      : out std_logic;
		  WrlLCD   : out std_logic;
        --Kpress   : out std_logic;
		  DoutLCD     : out std_logic_vector(4 downto 0);
		  DoutLeds     : out std_logic_vector(4 downto 0)
		  
);
end SLCDC_WRAPPER;

architecture structural of SLCDC_WRAPPER is

component SLCDC is
port(
        --Kscan    : in std_logic;
		  SDX		  : in std_logic;
		  SCLK	  : in std_logic;
		  SS       : in std_logic;
		  --accept   : in std_logic;  -- mais tarde nao vai ter
		  reset    : in std_logic;
		  --enable   : in std_logic;
		  MCLK     : in std_logic;
--		  S_Mux	  : in std_Logic_vector(1 downto 0);
--		  S_Dec	  : in std_Logic_vector(1 downto 0);

        Wrl      : out std_logic;
        --Kpress   : out std_logic;
		  Dout     : out std_logic_vector(4 downto 0)
		  
);
end component;

component UsbPort IS 
	PORT
	(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END component;


signal eq5x, clrx, enx, clkx, SSx, SCLKx, SDXx, default, Wrlx : std_logic;
signal Qx: std_logic_vector(2 downto 0);
signal DX: std_logic_vector(4 downto 0);

begin

DoutLCD <= Dx;
DoutLeds <= Dx;

Wrl <= Wrlx;
WrlLCD <= Wrlx;

T1: SLCDC       port map(MCLK => MCLK, reset => reset, SS => SSx, SCLK => SCLKx, SDX => SDXx, Wrl => Wrlx, Dout => Dx );
T2: UsbPort     port map(inputPort(0) => default,
									outputPort(2) => SSx,
									outputPort(3) => SCLKx, 
									outputPort(4) => SDXx 
									);

end structural;
