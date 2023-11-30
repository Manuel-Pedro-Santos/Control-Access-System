LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity FFD4bits is 
	PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC_vector(3 downto 0);
		EN : IN STD_LOGIC;
		Q : out std_logic_vector(3 downto 0)
		);
end FFD4bits;

architecture structural of FFD4bits is

component FFD is 
	PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
END component;

signal ka, kb, kc : std_logic;

begin

F0 : FFD port map(D => D(0), Q => Q(0), RESET=>RESET, SET=>SET, CLK=>CLK,EN=>EN);
F1 : FFD port map(D => D(1), Q => Q(1), RESET=>RESET, SET=>SET, CLK=>CLK,EN=>EN);
F2 : FFD port map(D => D(2), Q => Q(2), RESET=>RESET, SET=>SET, CLK=>CLK,EN=>EN);
F3 : FFD port map(D => D(3), Q => Q(3), RESET=>RESET, SET=>SET, CLK=>CLK,EN=>EN);
end structural;