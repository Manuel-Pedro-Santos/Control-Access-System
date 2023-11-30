LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity shift_register is 
	PORT(	
		CLK	: in std_logic;
		RESET : in STD_LOGIC;
		--SET : in std_logic;
		data : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		D : out std_logic_vector(4 downto 0)
		);
end shift_register;

architecture structural of shift_register is

component FFD is 
	PORT(	CLK : in std_logic;
		RESET : in STD_LOGIC;
		SET : in std_logic;
		D : IN STD_LOGIC;
		EN : IN STD_LOGIC;
		Q : out std_logic
		);
END component;

signal Q0, Q1, Q2, Q3, Q4: std_logic;


begin

D <= Q0 & Q1 & Q2 & Q3 & Q4;
F0 : FFD port map(D => data, Q => Q0, RESET=>RESET, SET=>'0', CLK=>CLK,EN=>EN);
F1 : FFD port map(D => Q0, Q => Q1, RESET=>RESET, SET=>'0', CLK=>CLK,EN=>EN);
F2 : FFD port map(D => Q1, Q => Q2, RESET=>RESET, SET=>'0', CLK=>CLK,EN=>EN);
F3 : FFD port map(D => Q2, Q => Q3, RESET=>RESET, SET=>'0', CLK=>CLK,EN=>EN);
F4 : FFD port map(D => Q3, Q => Q4, RESET=>RESET, SET=>'0', CLK=>CLK,EN=>EN);
end structural;
