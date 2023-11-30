LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MAC is
	port(
		--Inputs ports
		putget : in std_logic;
		input : in std_logic;
		inget : in std_logic;
		clk   : in std_logic;
		reset : in std_logic;
		--Output ports
		A: out std_logic_vector(2 downto 0);
		full : out std_logic;
		empty : out std_logic
		);
end MAC;

architecture structural of MAC is

component contador_serial is 
	port
	(
		-- Input ports
		CLK : in std_logic;
		clr : in STD_LOGIC;
		EN : IN STD_LOGIC;
	
		-- Output ports
		Q : out std_logic_vector(2 downto 0)
	);
end component;

component mux_Ring is 
	port
	(
		-- Input ports
		R : in std_logic_vector(2 downto 0);
		A : in std_logic_vector(2 downto 0);
		PL : in std_logic;
	
		-- Output ports
		S : out std_logic_vector(2 downto 0)
	);
end component;

component Counter_Ring is
	port(
		--Inputs ports
		putget : in std_logic;
		en     :in std_logic;
		clk    :in std_logic;
		reset  :in std_logic;
		--Output ports
		D : out std_logic_vector(3 downto 0)
		);
end component;

signal enx , fullx, emptyx: std_logic;
signal Dx : std_logic_vector(3 downto 0);
signal inputx, ingetx : std_logic_vector(2 downto 0);
begin 

enx <= input or inget;

fullx <= Dx(3) and not (Dx(2)) and not (Dx(1)) and not (Dx(0));
emptyx <= not (Dx(3)) and not (Dx(2)) and not (Dx(1)) and not (Dx(0));

full <= fullx;
empty <= emptyx;

T1: contador_serial port map(CLK => clk, clr => reset, EN => input, Q => inputx );
T2: contador_serial port map(CLK => clk, clr => reset, EN => inget, Q => ingetx );
T3: mux_Ring port map(R =>ingetx, A => inputx, PL => putget, S => A);
T4: Counter_Ring port map(putget => putget, en => enx, clk => clk, reset => reset, D => Dx);

end structural; 