library ieee;
use ieee.std_logic_1164.all;

entity SDC is
port(
        --Kscan    : in std_logic;
		  SDX		  : in std_logic;
		  SCLK	  : in std_logic;
		  SS       : in std_logic;
		  --accept   : in std_logic;  -- mais tarde nao vai ter
		  reset    : in std_logic;
		  --enable   : in std_logic;
		  MCLK      : in std_logic;

		  Sopen     : in std_logic;
		  Sclose    : in std_logic;
		  Psensor   : in std_logic;
--		  S_Mux	  : in std_Logic_vector(1 downto 0);
--		  S_Dec	  : in std_Logic_vector(1 downto 0);

		  busy : out std_logic;
        --Kpress   : out std_logic;
		  Dout     : out std_logic_vector(4 downto 0);
		  OnOff       : out std_logic
		  
		  
);
end SDC;

architecture structural of SDC is

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

component Door_Controller is 
	port
	(
		-- Input ports
		CLK 		 : in std_logic;
		Dval 		 : in STD_LOGIC;
		Din       : in std_logic_vector(4 downto 0);
		reset     : in std_logic;
		Sopen     : in std_logic;
		Sclose    : in std_logic;
		Psensor   : in std_logic;
		--eq15      : in std_logic;
		--SET : in std_logic;
		--EN : IN STD_LOGIC;
	
		-- Output ports
		  OnOff       : out std_logic;
        Dout      : out std_logic_vector(4 downto 0);
		  done      : out std_logic
	);
end component;


signal Dxvalx, acceptx: std_logic;
signal Dinx: std_logic_vector(4 downto 0);

begin


F1: serial_receiver port map(SDX => SDX, SCLK => SCLK, SS => SS, accept => acceptx, reset => reset, MCLK => MCLK, DXval => Dxvalx, D => Dinx, busy => busy);

F2: Door_Controller port map(reset => reset, CLK => MCLK, Dval => Dxvalx, Din => Dinx, Sopen => Sopen, Sclose => Sclose, Psensor => Psensor, OnOff => OnOff, Dout => Dout, done => acceptx);
end structural;
