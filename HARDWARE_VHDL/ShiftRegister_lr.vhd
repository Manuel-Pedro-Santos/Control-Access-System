-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : DE10-Lite 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : ShiftRegister_lr.vhd
-- Author(s)   : Pedro Miguens Matutino
-- Date        : 2023/04/28
-------------------------------------------------------------------------------
-- Copyright (c) 2023 Pedro Miguens Matutino
-------------------------------------------------------------------------------
-- Description :
-- .
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ShiftRegister_lr is
generic( WIDTH : positive := 5);
port( clk, reset, sin_left, sin_right, en, shiftLeft : in STD_LOGIC;
			rst_value : in std_logic_vector(WIDTH-1 downto 0);
			Dout: out STD_LOGIC_VECTOR(WIDTH-1 downto 0));
end ShiftRegister_lr;

architecture Structural of ShiftRegister_lr is 
component register_D_E_R_value is
	generic (
		WIDTH : POSITIVE := 1
	);
	port (
		CLK   		: in  STD_LOGIC;
		RST   		: in  STD_LOGIC;
		EN				: in 	STD_LOGIC;
		RST_value	: in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		D     		: in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Q     		: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end component;

signal dataShift_right : std_logic_vector(WIDTH-1 downto 0);
signal dataShift_left : std_logic_vector(WIDTH-1 downto 0);
signal dataShift_in : std_logic_vector(WIDTH-1 downto 0);
signal dataShift_out : std_logic_vector(WIDTH-1 downto 0);
begin

dataShift_right	<= sin_right & dataShift_out(WIDTH-1 downto 1);
dataShift_left 	<= dataShift_out(WIDTH-2 downto 0) & sin_left;

dataShift_in <= dataShift_left when shiftLeft ='1' else dataShift_right;

U1 : register_D_E_R_value 	
			generic map(WIDTH => WIDTH)
			port map( CLK => CLK, RST => RESET, rst_value => rst_value, EN => en, D => dataShift_in, Q => dataShift_out);

DOut <= dataShift_out;

end architecture Structural;