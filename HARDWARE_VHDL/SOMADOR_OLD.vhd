LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY SOMADOR_OLD IS

PORT(
  
  Ax : in STD_LOGIC_VECTOR(3 downto 0);
  Bx : in STD_LOGIC_VECTOR(3 downto 0);
  CIx : in STD_LOGIC;
  Sx : out STD_LOGIC_VECTOR(3 downto 0);
  COx : out STD_LOGIC);

END SOMADOR_OLD;

ARCHITECTURE structural OF SOMADOR_OLD IS

component FULLADD 

PORT(
  Ay : in STD_LOGIC;
  By : in STD_LOGIC;
  CIy : in STD_LOGIC;
  Sy : out STD_LOGIC;
  COy : out STD_LOGIC);

END component ;

signal C1, C2, C3 : STD_LOGIC; 


BEGIN

    AFULLADD : FULLADD port map(
        Ay => Ax(0), 
        By => Bx(0),
        CIy => CIx,
        COy => C1,
        Sy => Sx(0) );

    BFULLADD : FULLADD port map(
        Ay => Ax(1), 
        By => Bx(1),
        CIy => C1,
        COy => C2,
        Sy => Sx(1) );
        
    CFULLADD : FULLADD port map(
        Ay => Ax(2), 
        By => Bx(2),
        CIy => C2,
        COy => C3,
        Sy => Sx(2) );
        
    DFULLADD : FULLADD port map(
        Ay => Ax(3), 
        By => Bx(3),
        CIy => C3,
        COy => COx,
        Sy => Sx(3) );
    


END structural; 