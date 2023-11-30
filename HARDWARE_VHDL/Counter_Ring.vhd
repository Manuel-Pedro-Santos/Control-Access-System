LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Counter_Ring is
	port(
		--Inputs ports
		putget : in std_logic;
		en     :in std_logic;
		clk    :in std_logic;
		reset  :in std_logic;
		--Output ports
		D : out std_logic_vector(3 downto 0)
		);
end Counter_Ring;

architecture structural of Counter_Ring is

component REG 

PORT(
  D : in STD_LOGIC_VECTOR(3 downto 0);
  CLK : in STD_LOGIC;
  EN : in STD_LOGIC;
  RESET: IN STD_LOGIC;
  Q : out STD_LOGIC_VECTOR(3 downto 0));
   
END component ;

component SOMADOR_OLD

PORT(
  Ax : in STD_LOGIC_VECTOR(3 downto 0);
  Bx : in STD_LOGIC_VECTOR(3 downto 0);
  CIx : in STD_LOGIC;
  Sx : out STD_LOGIC_VECTOR(3 downto 0);
  COx : out STD_LOGIC);

END component ;

component mux is 
	port
	(
		-- Input ports
		R : in std_logic_vector(3 downto 0);
		A : in std_logic_vector(3 downto 0);
		PL : in std_logic;
	
		-- Output ports
		S : out std_logic_vector(3 downto 0)
	);
end component;

--signal : std_logic;
signal cv, dx, xp: std_logic_vector(3 downto 0);

begin 

D <= dx;

T1: SOMADOR_OLD port map (Ax => dx , Bx => xp, CIx => '0', Sx => cv);
T2: mux port map (R => "1111", A => "0001", PL => putget ,S=>xp);
T3: REG port map (D =>cv , EN => en, CLK => clk, RESET => reset, Q => dx);

end structural;