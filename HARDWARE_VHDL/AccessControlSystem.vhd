library ieee;
use ieee.std_logic_1164.all;

entity AccessControlSystem is
port(
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);
		  --Kack     : in std_logic;

        Q        : out std_logic_vector(3 downto 0);
		  Cbutton  : out std_logic_vector(3 downto 0);
		  --Sopen     : in std_logic;
		  --Sclose    : in std_logic;
		  --Psensor   : in std_logic;
		  Dval     : out std_logic;
		  --LCD_RS   : out std_logic;
		  --LCD_EN   : out std_logic;
		  --LCD_DATA : out std_logic_vector(3 downto 0);
		  Wrl      : out std_logic;
		  Dout     : out std_logic_vector(4 downto 0);
		  Dout1    : out std_logic_vector(4 downto 0);
		  Pswitch		: in std_logic;
		  maintnance	: in std_logic;
		HEX0			: out std_logic_vector(7 downto 0);
		HEX1			: out std_logic_vector(7 downto 0);
		HEX2			: out std_logic_vector(7 downto 0);
		HEX3			: out std_logic_vector(7 downto 0);
		HEX4			: out std_logic_vector(7 downto 0);
		HEX5			: out std_logic_vector(7 downto 0);
		  --busy : out std_logic;
		  OnOff       : out std_logic
		  
);
end AccessControlSystem;

architecture structural of AccessControlSystem is

component KeyBoard_Reader is
port(
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);
		  Kack     : in std_logic;

        Q        : out std_logic_vector(3 downto 0);
		  Cbutton  : out std_logic_vector(3 downto 0);
		  Dval     : out std_logic
		  
);
end component;

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

component SDC is
port(
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

		  busy : out std_logic;
		  Dout     : out std_logic_vector(4 downto 0);
		  OnOff       : out std_logic
		  
		  
);
end component;

component door_mecanism IS
PORT(	MCLK 			: in std_logic;
		RST			: in std_logic;
		onOff			: in std_logic;
		openClose	: in std_logic;
		v			   : in std_logic_vector(3 downto 0);
		Pswitch		: in std_logic;
		Sopen			: out std_logic;
		Sclose		: out std_logic;
		Pdetector	: out std_logic;
		HEX0			: out std_logic_vector(7 downto 0);
		HEX1			: out std_logic_vector(7 downto 0);
		HEX2			: out std_logic_vector(7 downto 0);
		HEX3			: out std_logic_vector(7 downto 0);
		HEX4			: out std_logic_vector(7 downto 0);
		HEX5			: out std_logic_vector(7 downto 0)
		);
END component;

component UsbPort IS 
	PORT
	(
		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END component;

signal cbx, Qx, lcd_datax         : std_logic_vector(3 downto 0); 
signal Doutx , Doutx1                     : std_logic_vector(4 downto 0); 
signal kackx, Dvalx, SDXx, SCLKx, SSx, Wrlx, OnOffx, busyx, SSDoorx, Psensorx, Sclosex, Sopenx: std_logic; 
--lcd_enx, lcd_rsx

begin

CButton(0) <= cbx(0);
CButton(1) <= cbx(1);
CButton(2) <= cbx(2);
CButton(3) <= cbx(3);

Q <= Qx;
Dval <= Dvalx;
--LCD_DATA(0) <= lcd_datax(0);
--LCD_DATA(1) <= lcd_datax(1);
--LCD_DATA(2) <= lcd_datax(2);
--LCD_DATA(3) <= lcd_datax(3);
--LCD_RS <= lcd_rsx;
--LCD_EN <= lcd_enx;
Wrl <= Wrlx;    
Dout <= Doutx;
Dout1 <= Doutx1;   
OnOff<= OnOffx;

T1: KeyBoard_Reader port map (Lbutton => Lbutton, Cbutton => cbx, clr => clr, Kack => kackx, Q => Qx, clk_in => clk_in, Dval => Dvalx);

T2: SLCDC port map(SDX => SDXx, SCLK => SCLKx, SS => SSx, reset => clr, MCLK => clk_in, Wrl => Wrlx, Dout => Doutx);

T3: SDC port map(SDX => SDXx, SCLK => SCLKx, SS => SSDoorx, reset => clr, MCLK => clk_in, Sopen => Sopenx, Sclose => Sclosex, Psensor => Psensorx, Dout => Doutx1, OnOff => OnOffx, busy => busyx);

T4: UsbPort port map(inputPort(0) => Qx(0), inputPort(1) => Qx(1), inputPort(2) => Qx(2), inputPort(3) => Qx(3), inputPort(4) => Dvalx, inputport(5) => busyx ,inputport(6) => maintnance, outputPort(0) => kackx,
		 outputPort(1) => SSDoorx,outputPort(2) => SSx, outputPort(3) => SCLKx, outputPort(4) => SDXx);
		 
T5: door_mecanism port map(MCLK => clk_in, RST => clr, onOff => OnOffx, openClose => Doutx1(0), V(0) => Doutx1(1), 
									V(1) => Doutx1(2), V(2) => Doutx1(3), V(3) => Doutx1(4), Pswitch => Pswitch, Sopen => Sopenx, 
									Sclose => Sclosex, Pdetector => Psensorx, HEX0 => HEX0, HEX1 => HEX1, HEX2 => HEX2, HEX3 => HEX3,
									HEX4 => HEX4, HEX5 => HEX5);
--AQUI ACHO QUE É DEACORDO COMO PUSEMOS NO INTELLIJ
end structural;
