LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity halfadder is 
	port
	(
		-- Input ports
		A : in std_logic;
		B : in std_logic;
	
		-- Output ports
		CO: out std_logic;
		R : out std_logic
	);
end halfadder;

architecture structural of halfadder is

begin

R <= A XOR B;
CO <= A AND B;

--HA: halfadderlab4 port map(A => A, B => B, R => R, CO => CO);

end structural;