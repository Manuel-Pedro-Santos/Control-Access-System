-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : DE10-Lite 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : register_D_E_R_value.vhd
-- Author(s)   : Pedro Miguens Matutino
-- Date        : 2023/04/06
-------------------------------------------------------------------------------
-- Copyright (c) 2022 Pedro Miguens Matutino
-------------------------------------------------------------------------------
-- Description :
-- .
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity register_D_E_R_value is
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
end register_D_E_R_value;

architecture Behavioral of register_D_E_R_value is

begin
    
	process (RST,EN, CLK)
	begin
		if (RST = '1') then
			Q <= RST_value;
		elsif (rising_edge(CLK) and EN = '1') then
			Q <= D;
		end if;
	end process;

end Behavioral;
