LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux is 
	port
	(
		-- Input ports
		R : in std_logic_vector(3 downto 0);
		A : in std_logic_vector(3 downto 0);
		PL : in std_logic;
	
		-- Output ports
		S : out std_logic_vector(3 downto 0)
	);
end mux;

architecture structural of mux is
begin

S(0) <= ((not PL and R(0)) or (PL and A(0)));
S(1) <= ((not PL and R(1)) or (PL and A(1)));
S(2) <= ((not PL and R(2)) or (PL and A(2)));
S(3) <= ((not PL and R(3)) or (PL and A(3)));

end structural;