 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ring_buffer is 
    port
    (
        -- Input ports
        DAV      : in std_logic;
		  CTS       : in std_logic;
		  D         : in std_logic_vector(3 downto 0);
		  clk       : in std_logic;
		  reset     : in std_logic;

        -- Output ports
		  Wreg      : out std_logic;
		  Q         : out std_logic_vector(3 downto 0);
		  DAC     : out std_logic
    );
end ring_buffer;

architecture structural of ring_buffer is

component ring_buffer_control is 
    port
    (
        -- Input ports
        DAV      : in std_logic;
        full    : in std_logic;
        empty       : in std_logic;
		  CTS       : in std_logic;
		  clk       : in std_logic;
		  reset     : in std_logic;
        --reset    : in std_logic;

        -- Output ports
		  incPut 	: out std_logic;
		  incGet    : out std_logic;
		  Wreg      : out std_logic;
        wr        : out std_logic;
		  DAC     : out std_logic;
		  SelPG     : out std_logic
    );
end component;

component MAC is
	port(
		--Inputs ports
		putget : in std_logic;
		input : in std_logic;
		inget : in std_logic;
		clk   : in std_logic;
		reset : in std_logic;
		--Output ports
		A: out std_logic_vector(2 downto 0);
		full : out std_logic;
		empty : out std_logic
		);
end component;

component RAM is
    generic(
        ADDRESS_WIDTH : natural := 3;
        DATA_WIDTH : natural := 4
    );
    port(
        address : in std_logic_vector(ADDRESS_WIDTH - 1 downto 0);
        wr: in std_logic;
        din: in std_logic_vector(DATA_WIDTH - 1 downto 0);
        dout: out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end component;

signal fullx, emptyx, incPutx, incGetx, wrx, SelPGx : std_logic;
signal Ax : std_logic_vector(2 downto 0);

begin

T1: ring_buffer_control port map(DAV => DAV, full => fullx, empty => emptyx, CTS => CTS, clk => clk, reset => reset, 
											incPut => incPutx, incGet => incGetx, Wreg => Wreg, wr => wrx, DAC => DAC, SelPG => SelPGx);
T2: MAC port map(putget => SelPGx, input => incPutx, inget => incGetx,  clk => clk, reset => reset, full => fullx, 
						empty => emptyx, A => Ax);
T3: RAM port map(address => Ax, wr => wrx, din => D, dout => Q);

end structural; 