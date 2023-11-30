LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY MUX4 IS

 PORT(
  DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
  S: in STD_LOGIC_VECTOR(3 downto 0);
  PL : in STD_LOGIC;
  D : out STD_LOGIC_VECTOR(3 downto 0));
 
END MUX4;

ARCHITECTURE structural OF MUX4 IS
BEGIN

D(0) <= (NOT PL AND S(0)) OR (PL AND DATA_IN(0));
D(1) <= (NOT PL AND S(1)) OR (PL AND DATA_IN(1));
D(2) <= (NOT PL AND S(2)) OR (PL AND DATA_IN(2));
D(3) <= (NOT PL AND S(3)) OR (PL AND DATA_IN(3));




END structural;