-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Project     : DE10-Lite 
-- Affiliations: DEETC, ISEL - IPL
-- Funding     : -
-------------------------------------------------------------------------------
-- File        : adder_rc.vhd
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

entity adder_rc is
	generic (
		WIDTH : POSITIVE := 4
	);
	port (
		A     : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		B     : in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Ci    : in  STD_LOGIC;
		S     : out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
		Co    : out STD_LOGIC
	);
end adder_rc;

architecture Structural of adder_rc is

	component full_adder
	port (
		A     : in  STD_LOGIC;
		B     : in  STD_LOGIC;
		Cin   : in  STD_LOGIC;
		S     : out STD_LOGIC;
		Cout  : out STD_LOGIC
	);
	end component;

	signal cy : STD_LOGIC_VECTOR(WIDTH downto 0);

begin

	cy(0) <= Ci;

	SC :  for i in 0 to WIDTH-1 generate

		U1 : full_adder port map (
		     	A     => A(i),
		     	B     => B(i),    
		     	Cin   => cy(i),
		     	S     => S(i),
		     	Cout  => cy(i+1)
		     );

	end generate SC;

	Co <= cy(WIDTH);

end Structural;
