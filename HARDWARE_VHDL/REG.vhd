LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY REG IS

 PORT(
  D : in STD_LOGIC_VECTOR(3 downto 0);
  CLK : in STD_LOGIC;
  EN : in STD_LOGIC;
  RESET: IN STD_LOGIC;
  Q : out STD_LOGIC_VECTOR(3 downto 0));
 
END REG;

ARCHITECTURE structural OF REG IS

component FFD 


PORT(
        CLK : in std_logic;
        RESET : in STD_LOGIC;
        SET : in std_logic;
        D : IN STD_LOGIC;
        EN : IN STD_LOGIC;
        Q : out std_logic );

END component ;



BEGIN

    AFFD : FFD port map(
        D => D(0), 
        Q => Q(0),
        CLK => CLK,
        SET => '0',
        RESET => RESET,
        EN => EN );

    BFFD : FFD port map(
        D => D(1), 
        Q => Q(1),
        CLK => CLK,
        SET => '0',
        RESET => RESET,
        EN => EN );
        
    CFFD : FFD port map(
        D => D(2), 
        Q => Q(2),
        CLK => CLK,
        SET => '0',
        RESET => RESET,
        EN => EN );
        
    DFFD : FFD port map(
        D => D(3), 
        Q => Q(3),
        CLK => CLK,
        SET => '0',
        RESET => RESET,
        EN => EN );
    


END structural;