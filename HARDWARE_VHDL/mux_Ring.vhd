LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux_Ring is 
	port
	(
		-- Input ports
		R : in std_logic_vector(2 downto 0);
		A : in std_logic_vector(2 downto 0);
		PL : in std_logic;
	
		-- Output ports
		S : out std_logic_vector(2 downto 0)
	);
end mux_Ring;

architecture structural of mux_Ring is
begin

S(0) <= ((not PL and R(0)) or (PL and A(0)));
S(1) <= ((not PL and R(1)) or (PL and A(1)));
S(2) <= ((not PL and R(2)) or (PL and A(2)));

end structural;