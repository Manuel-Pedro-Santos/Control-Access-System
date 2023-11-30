-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : DE10-Lite 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : full_adder.vhd
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

entity full_adder is
	port (
		A     : in  STD_LOGIC;
		B     : in  STD_LOGIC;
		Cin   : in  STD_LOGIC;
		S     : out STD_LOGIC;
		Cout  : out STD_LOGIC
	);
end full_adder;

architecture Behavioral of full_adder is
    
begin
	S    <= (A xor B xor Cin);
	Cout <= (A and B) or (A and Cin) or (B and Cin);
end Behavioral;
