LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity contador_serial is 
	port
	(
		-- Input ports
		CLK : in std_logic;
		clr : in STD_LOGIC;
		EN : IN STD_LOGIC;
	
		-- Output ports
		Q : out std_logic_vector(2 downto 0)
	);
end contador_serial;

architecture structural of contador_serial is

component adder3bits is 
	port
	(
		-- Input ports
		A : in std_logic_vector (2 downto 0);
		B : in std_logic_vector (2 downto 0);
		CI: in std_logic;
	
		-- Output ports
		CO: out std_logic;
		R : out std_logic_vector (2 downto 0)
	);
end component;

component FFD3bits IS
PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC_vector(2 downto 0);
		EN : IN STD_LOGIC;
		Q : out std_logic_vector(2 downto 0)
		);
END component;

--component mux is 
--	port
--	(
--		-- Input ports
--		R : in std_logic_vector(3 downto 0);
--		A : in std_logic_vector(3 downto 0);
--		PL : in std_logic;
--	
--		-- Output ports
--		S : out std_logic_vector(3 downto 0)
--	);
--end component;

signal cv, xp, xm : std_logic_vector(2 downto 0);
signal cx, cy: std_logic;
begin
Q<=xm;
T1: adder3bits port map (A => xm , B => "000", R => cv, CI => '1', CO => open);
--T2: mux port map (R => cv, A => cv, PL => '1',S=>xp);
T3: FFD3bits port map (D =>cv , EN => EN, CLK => CLK, RESET => clr, SET => '0', Q => xm);
--TC <= not xm(3) and not xm(2) and not xm(1) and not xm(0);


end structural;