LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY FULLADD IS

 PORT(
  Ay : in STD_LOGIC;
  By : in STD_LOGIC;
  CIy : in STD_LOGIC;
  Sy : out STD_LOGIC;
  COy : out STD_LOGIC);
 
END FULLADD;

ARCHITECTURE structural OF FULLADD IS
BEGIN

Sy <= (Ay xor By) xor CIy;
COy <= (Ay and By) or (CIy and (Ay xor By));



END structural;