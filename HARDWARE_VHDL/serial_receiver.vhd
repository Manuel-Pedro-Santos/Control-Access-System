library ieee;
use ieee.std_logic_1164.all;

entity serial_receiver is
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
        --Kpress   : out std_logic;
--		  Q  : out std_logic_vector(2 downto 0);
		  busy : out std_logic;
		  D  : out std_logic_vector(4 downto 0)
		  
);
end serial_receiver;

architecture structural of serial_receiver is

component contador_serial is 
	port
	(
		-- Input ports
		CLK : in std_logic;
		clr : in STD_LOGIC;
		--SET : in std_logic;
		EN : IN STD_LOGIC;
	
		-- Output ports
		Q : out std_logic_vector(2 downto 0)
	);
end component;

component serial_control is 
    port
    (
        -- Input ports
        enRx      : in std_logic;
        accept    : in std_logic;
        eq5       : in std_logic;
		  clk       : in std_logic;
		  reset     : in std_logic;
        --reset    : in std_logic;

        -- Output ports
        clr       : out std_logic;
        wr        : out std_logic;
		  busy      : out std_logic;
		  DXval     : out std_logic
    );
end component;

component shift_register is 
	PORT(	
		CLK	: in std_logic;
		RESET : in STD_LOGIC;
		--SET : in std_logic;
		data : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		D : out std_logic_vector(4 downto 0)
		);
end component;
--
--component UsbPort IS 
--	PORT
--	(
--		inputPort:  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
--		outputPort :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
--	);
--END component;

--component CLKDIV is
--generic(div: natural := 5000000);
--port ( clk_in: in std_logic;
--		 clk_out: out std_logic);
--end component;

signal eq5x, clrx, enx, clkx, SSx, SCLKx, SDXx, default : std_logic;
signal Qx: std_logic_vector(2 downto 0);

begin

eq5x <= Qx(0) and not(Qx(1)) and Qx(2) and not(SCLK);

--Q <= Qx;

T1: contador_serial port map(	CLK => SCLK, clr => clrx, EN => '1', Q => Qx);
T2: serial_control port map(enRx => SS, accept => accept, eq5 => eq5x, clk => MCLK, reset => reset, clr => clrx, wr => enx, DXval => DXval, busy => busy);
T3: shift_register port map(CLK => SCLK, RESET => reset, data => SDX, EN => enx, D => D); --SET => '0'
--T4: UsbPort        port map(inputPort(0) => default,
--									outputPort(2) => SSx,
--									outputPort(3) => SCLKx, 
--									outputPort(4) => SDXx 
--									);
--T4: CLKDIV          generic map(500000) port map (clk_in => SCLK, clk_out => clkx);


end structural;
