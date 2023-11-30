LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity adder4bits is 
	port
	(
		-- Input ports
		A : in std_logic_vector (3 downto 0);
		B : in std_logic_vector (3 downto 0);
		CI: in std_logic;
	
		-- Output ports
		CO: out std_logic;
		R : out std_logic_vector (3 downto 0)
	);
end adder4bits;

architecture structural of adder4bits is

component fulladder is 
	port
	(
		-- Input ports
		A : in std_logic;
		B : in std_logic;
		CI: in std_logic;
	
		-- Output ports
		CO: out std_logic;
		R : out std_logic
	);
end component;


-- Declarations (optional)
signal CIint: std_logic_vector (2 downto 0);

begin

F0 : fulladder port map(A => A(0), B => B(0), CI => CI, CO => CIint(0), R => R(0));
F1 : fulladder port map(A => A(1), B => B(1), CI => CIint(0), CO => CIint(1), R => R(1));
F2 : fulladder port map(A => A(2), B => B(2), CI => CIint(1), CO => CIint(2), R => R(2));
F3 : fulladder port map(A => A(3), B => B(3), CI => CIint(2), CO => CO, R => R(3));
end structural;