-------------------------------------------------------------------------------
-- Project     : DE10-Lite 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : door_mecanism.vhd
-- Author(s)   : Pedro Miguens Matutino
-- Date        : 2023/04/06
-------------------------------------------------------------------------------
-- Copyright (c) 2023 Pedro Miguens Matutino
-------------------------------------------------------------------------------
-- Description :
-- .
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY door_mecanism IS
PORT(	MCLK 			: in std_logic;
		RST			: in std_logic;
		onOff			: in std_logic;
		openClose	: in std_logic;
		v			: in std_logic_vector(3 downto 0);
		Pswitch		: in std_logic;
		Sopen			: out std_logic;
		Sclose		: out std_logic;
		Pdetector	: out std_logic;
		HEX0			: out std_logic_vector(7 downto 0);
		HEX1			: out std_logic_vector(7 downto 0);
		HEX2			: out std_logic_vector(7 downto 0);
		HEX3			: out std_logic_vector(7 downto 0);
		HEX4			: out std_logic_vector(7 downto 0);
		HEX5			: out std_logic_vector(7 downto 0)
		);
END door_mecanism;

ARCHITECTURE behavioral OF door_mecanism IS
component door_emulation_seg IS
PORT(	d : IN STD_LOGIC_vector(3 downto 0);
		dOut: out std_logic_vector(7 downto 0)
		);
END component;

component CLKDIV is
generic(div: natural := 50000000);
port ( clk_in: in std_logic;
		 clk_out: out std_logic);
end component;

component ShiftRegister_lr is
generic( WIDTH : positive := 5);
port( clk, reset, sin_left, sin_right, en, shiftLeft : in STD_LOGIC;
			rst_value : in std_logic_vector(WIDTH-1 downto 0);
			Dout: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end component;

component counter_pl is
	generic (
		WIDTH : POSITIVE := 1
	);
	port (
		-- Definicao da interface de entrada do modulo
		CLK : in  STD_LOGIC;
		RST : in	 STD_LOGIC;
		CE  : in  STD_LOGIC;
		pl	 : in  STD_LOGIC;
		din : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		-- Definicao da interface de saida do modulo
		Q   : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end component;


signal f20ms_clk, shift_clk : std_logic;
signal percentage : std_logic_vector(8 downto 0);
signal nopenClose : std_logic;
signal prescale : std_logic_vector(4 downto 0);
BEGIN

UCLK: CLKDIV generic map(2000000) port map (clk_in => MCLK, clk_out => f20ms_clk);

nopenClose 	<= not openClose;
shift_clk 	<= prescale(4) and prescale(3) and prescale(2) and prescale(1) and prescale(0);

U6 : counter_pl generic map (5) port map (CLK => f20ms_clk, RST => RST, CE => onOff, pl => shift_clk, din => v & '0',  Q => prescale);
	
U7: ShiftRegister_lr generic map(9) port map (	clk 	=> shift_clk, reset => RST, rst_value => "000000001", sin_left => '1', sin_right => '0', 
																en		=> onOff, shiftLeft => nopenClose,  dout => percentage);

Sopen 		<= '1' when (percentage = "000000001") else '0';
Sclose 		<= '1' when percentage = "111111111" else '0';
Pdetector 	<= Pswitch;
	
U0 : door_emulation_seg port map ( d => '0' & percentage(2 downto 0), dOut => HEX0);
U1 : door_emulation_seg port map ( d => '0' & percentage(5 downto 3), dOut => HEX1);
U2 : door_emulation_seg port map ( d => '0' & percentage(8 downto 6), dOut => HEX2);
U3 : door_emulation_seg port map ( d => '1' & percentage(8 downto 6), dOut => HEX3);
U4 : door_emulation_seg port map ( d => '1' & percentage(5 downto 3), dOut => HEX4);
U5 : door_emulation_seg port map ( d => '1' & percentage(2 downto 0), dOut => HEX5);

END behavioral;