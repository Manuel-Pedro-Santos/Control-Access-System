library ieee;
use ieee.std_logic_1164.all;

entity KeyScan is
port(
        Kscan    : in std_logic;
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);

        K        : out std_logic_vector(3 downto 0);
        Kpress   : out std_logic;
		  Cbutton  : out std_logic_vector(3 downto 0)
		  
);
end KeyScan;

architecture structural of KeyScan is

component contador is 
	port
	(
		CLK : in std_logic;
		clr : in STD_LOGIC;
		EN : IN STD_LOGIC;
	
		Q : out std_logic_vector(3 downto 0)
	);
end component;

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

component DEC_KeyScan is 
	port
	(
		-- Input ports
		S : in std_logic_vector(1 downto 0);
	
		-- Output ports
		Q : out std_logic_vector(3 downto 0)
	);
end component;

--component CLKDIV is 
--	generic (div: natural := 50000);
--
--	port 
--	( 
--		clk_in	: in std_logic;
--	
--		clk_out	: out std_logic
--	);
--
--end component;

signal qx, cbx, lbx   : std_logic_vector(3 downto 0);
signal clkx, yx : std_logic;

begin

K(3) <= qx(3);
K(2) <= qx(2);
K(1) <= qx(1);
K(0) <= qx(0);

Kpress <= not yx;

CButton(0) <= not cbx(0);
CButton(1) <= not cbx(1);
CButton(2) <= not cbx(2);
CButton(3) <= not cbx(3);

lbx(0) <= LButton(0);
lbx(1) <= LButton(1);
lbx(2) <= LButton(2);
lbx(3) <= LButton(3);

T1: contador 	 port map (CLK => clk_in , clr => clr, EN => Kscan, Q(3) => qx(3), Q(2) => qx(2), Q(1) => qx(1), 
									Q(0) => qx(0));
T2: MUX_KeyScan port map (S1 => qx(1), S0 => qx(0) , A4 => lbx(3), A3 => lbx(2),
									A2 => lbx(1), A1 => lbx(0), Y => yx );
T3: Dec_KeyScan port map (S(1) => qx(3) , S(0) => qx(2), Q(3) => cbx(3), Q(2) => cbx(2),
									Q(1) => cbx(1), Q(0) => cbx(0));
--T4: CLKDIV 		 port map (clk_in => clk_in, clk_out => clkx);     --este clk é usado para a placa, ter la em cima em vez de clk_in estar clkx

end structural;
