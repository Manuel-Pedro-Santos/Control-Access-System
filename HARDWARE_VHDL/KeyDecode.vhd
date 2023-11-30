library ieee;
use ieee.std_logic_1164.all;

entity KeyDecode is
port(
        --Kscan    : in std_logic;
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);
		  Kack     : in std_logic;
--		  S_Mux	  : in std_Logic_vector(1 downto 0);
--		  S_Dec	  : in std_Logic_vector(1 downto 0);

        K        : out std_logic_vector(3 downto 0);
        --Kpress   : out std_logic;
		  Cbutton  : out std_logic_vector(3 downto 0);
		  Kval     : out std_logic
		  
);
end KeyDecode;

architecture structural of KeyDecode is

component KeyScan is
port(
        Kscan    : in std_logic;
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);
--		  S_Mux	  : in std_Logic_vector(1 downto 0);
--		  S_Dec	  : in std_Logic_vector(1 downto 0);

        K        : out std_logic_vector(3 downto 0);
        Kpress   : out std_logic;
		  Cbutton  : out std_logic_vector(3 downto 0)
		  
);
end component;

component key_control is 
    port
    (
        -- Input ports
        Kpress     : in std_logic;
        Kack         : in std_logic;
        clk       : in std_logic;
        reset    : in std_logic;

        -- Output ports
        Kscan        : out std_logic;
        Kval        : out std_logic
    );
end component;

component CLKDIV is 
	generic (div: natural := 5000000);

	port 
	( 
		clk_in	: in std_logic;
	
		clk_out	: out std_logic
	);

end component;

signal cbx             : std_logic_vector(3 downto 0); -- qx lbx
signal kscanx, kpressx , clkx: std_logic;                    -- clkx, yx


begin

CButton(0) <= cbx(0);
CButton(1) <= cbx(1);
CButton(2) <= cbx(2);
CButton(3) <= cbx(3);

--kscanx <= not kpressx;

--Kpress <= kpressx;

T1: KeyScan       port map (Lbutton => Lbutton, Cbutton => cbx, clr => clr, Kscan => kscanx, Kpress => kpressx, K => K, clk_in => clkx);
T2: key_control   port map (reset => clr, Kscan => kscanx, Kpress => kpressx, clk => clkx, Kack => Kack, Kval => Kval);
T4: CLKDIV 		  generic map(500000) port map (clk_in => clk_in, clk_out => clkx);     --este clk é usado para a placa, ter la em cima em vez de clk_in estar clkx


end structural;