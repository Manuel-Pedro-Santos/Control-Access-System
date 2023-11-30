library ieee;
use ieee.std_logic_1164.all;

entity KeyBoard_Reader is
port(
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);
		  Kack     : in std_logic;

        Q        : out std_logic_vector(3 downto 0);
		  Cbutton  : out std_logic_vector(3 downto 0);
		  Dval     : out std_logic
		  
);
end KeyBoard_Reader;

architecture structural of KeyBoard_Reader is

component KeyDecode is
port(
		  clr		  : in std_logic;
		  clk_in	  : in std_logic;
		  Lbutton  : in std_logic_vector(3 downto 0);
		  Kack     : in std_logic;

        K        : out std_logic_vector(3 downto 0);
		  Cbutton  : out std_logic_vector(3 downto 0);
		  Kval     : out std_logic
		  
);
end component;

component ring_buffer is 
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
end component;

component output_buffer is 
    port
    (
        -- Input ports
        load      : in std_logic;
        ack    : in std_logic;
		  clk       : in std_logic;
		  reset     : in std_logic;
		  d         :in std_logic_vector(3 downto 0);
        --reset    : in std_logic;

        -- Output ports
		  OBfree 	: out std_logic;
		  Dval    : out std_logic;
		  q         :out std_logic_vector(3 downto 0)
    );
end component;

signal cbx, Kx, Qx           : std_logic_vector(3 downto 0); 
signal kscanx, Kackx,Kvalx, ctsx, wregx : std_logic; 

begin 

CButton(0) <= cbx(0);
CButton(1) <= cbx(1);
CButton(2) <= cbx(2);
CButton(3) <= cbx(3);

T1: KeyDecode port map (Lbutton => Lbutton, Cbutton => cbx, clr => clr, Kack => Kackx, K => Kx, clk_in => clk_in, Kval => Kvalx);
T2: ring_buffer port map(DAV => Kvalx, CTS => ctsx, D => Kx, clk =>clk_in, reset => clr, Wreg => wregx, Q => Qx, DAC => Kackx);
T3: output_buffer port map(load => wregx, ack => Kack, clk => clk_in, reset => clr, d => Qx, OBfree => ctsx, Dval => Dval, q => Q);
end structural;              
