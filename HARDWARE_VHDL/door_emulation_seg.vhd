-------------------------------------------------------------------------------
-- Project     : DE10-Lite 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : door_emulation_seg.vhd
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

ENTITY door_emulation_seg IS
PORT(	d : IN STD_LOGIC_vector(3 downto 0);
		dOut: out std_logic_vector(7 downto 0)
		);
END door_emulation_seg;

ARCHITECTURE behavioral OF door_emulation_seg IS

BEGIN

dOut <= 	"11111111" when d = "0000" else
			"11111001" when d = "0001" else
			"10111001" when d = "0011" else
			"10001001" when d = "0111" else
			"11111111" when d = "1000" else
			"11001111" when d = "1001" else
			"10001111" when d = "1011" else
			"10001001" when d = "1111" else
			"11111111";

END behavioral;