LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fulladder is 
	port
	(
		-- Input ports
		A : in std_logic;
		B : in std_logic;
		CI: in std_logic;
	
		-- Output ports
		R : out std_logic;
		CO: out std_logic
	);
end fulladder;

architecture structural of fulladder is

component halfadder is
	port
	(
		-- Input ports
		A : in std_logic;
		B : in std_logic;
	
		-- Output ports
		CO: out std_logic;
		R : out std_logic
	);
end component;

--Declarations (optional)
signal cv, xp, xm : std_logic;

begin

CO <= xp OR xm;
T1: halfadder port map (A => A, B => B, R => cv, CO =>  xp);
T2: halfadder port map (A => cv, B => CI, R => R, CO => xm);
end structural;