LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY CD IS

 PORT(
  DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
  CE: in STD_LOGIC;
  PL : in STD_LOGIC;
  CLK : in STD_LOGIC;
  RESET : in STD_LOGIC;
  TC : out STD_LOGIC);
  
 
END CD;

ARCHITECTURE structural OF CD IS

component MUX4

PORT(
  DATA_IN : in STD_LOGIC_VECTOR(3 downto 0);
  S: in STD_LOGIC_VECTOR(3 downto 0);
  PL : in STD_LOGIC;
  D : out STD_LOGIC_VECTOR(3 downto 0));

END component ; 


component REG 

PORT(
  D : in STD_LOGIC_VECTOR(3 downto 0);
  CLK : in STD_LOGIC;
  EN : in STD_LOGIC;
  RESET: IN STD_LOGIC;
  Q : out STD_LOGIC_VECTOR(3 downto 0));
   
END component ;


component SOMADOR_OLD

PORT(
  Ax : in STD_LOGIC_VECTOR(3 downto 0);
  Bx : in STD_LOGIC_VECTOR(3 downto 0);
  CIx : in STD_LOGIC;
  Sx : out STD_LOGIC_VECTOR(3 downto 0);
  COx : out STD_LOGIC);

END component ;

signal S, D, Q : STD_LOGIC_VECTOR(3 downto 0);

BEGIN

    MUX0 : MUX4 port map(
        DATA_IN => DATA_IN, 
        S => S,
        PL => PL,
        D => D );

    AREG : REG port map(
        D => D, 
        CLK => CLK,
        RESET => RESET,
        EN => CE,
        Q => Q );
        
    ASOMADOR : SOMADOR_OLD port map(
        Ax => Q, 
        Bx => "1111",
        CIx => '0',
        Sx => S ); 


TC <= not Q(0) and not Q(1) and not Q(2) and not Q(3);
    
    
END structural; 