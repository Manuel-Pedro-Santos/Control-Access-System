LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DEC_KeyScan is 
	port
	(
		-- Input ports
		S : in std_logic_vector(1 downto 0);
	
		-- Output ports
		Q : out std_logic_vector(3 downto 0)
	);
end DEC_KeyScan;

architecture structural of DEC_KeyScan is
begin

Q(0) <= not S(0) and not S(1);
Q(1) <= S(0) and not S(1);
Q(2) <= not S(0) and S(1);
Q(3) <= S(0) and S(1);

end structural;