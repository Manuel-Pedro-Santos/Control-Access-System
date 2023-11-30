-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : DE10-Lite 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : counter_pl.vhd
-- Author(s)   : Pedro Miguens Matutino
-- Date        : 2022/04/06
-------------------------------------------------------------------------------
-- Copyright (c) 2022 Pedro Miguens Matutino
-------------------------------------------------------------------------------
-- Description :
-- .
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity counter_pl is
	generic (
		WIDTH : POSITIVE := 4
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
end counter_pl;

architecture Structural of counter_pl is

	component register_D_E_R_value
	generic (
		WIDTH : POSITIVE := 1
	);
	port (
		CLK   : in  STD_LOGIC;
		RST	: in	STD_LOGIC;
		EN    : in  STD_LOGIC;
        RST_value	: in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		D     : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Q     : out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
	end component;

	component adder_rc
	generic (
		WIDTH : POSITIVE := 1
	);
	port (
		A  : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		B  : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Ci : in  STD_LOGIC;
		S  : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Co : out STD_LOGIC
	);
	end component;

	signal zeros         : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal cnt_atual     : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal cnt_atual_inc : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal cnt_atual_pl 	: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
begin

	-- 
	zeros <= (others => '0');

	U1 : adder_rc generic map (
	     	WIDTH => WIDTH
	     ) port map (
	     	A     => cnt_atual,
	     	B     => zeros,
	     	Ci    => '1',
	     	S     => cnt_atual_inc,
	     	Co    => open
	     );
		  
	cnt_atual_pl <= din when pl ='1' else cnt_atual_inc;	  

	U2 : register_D_E_R_value generic map (
	     	WIDTH => WIDTH
	     ) port map (
	     	CLK   => CLK,
			RST	=>	RST,
	     	EN    => CE,
            RST_value => zeros,
	     	D     => cnt_atual_pl,
	     	Q     => cnt_atual
	     );

	Q <= cnt_atual;
end Structural;

