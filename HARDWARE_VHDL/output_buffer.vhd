 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity output_buffer is 
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
end output_buffer;

architecture structural of output_buffer is

component output_buffer_control is 
    port
    (
        -- Input ports
        load      : in std_logic;
        ack    : in std_logic;
		  clk       : in std_logic;
		  reset     : in std_logic;
        --reset    : in std_logic;

        -- Output ports
		  OBfree 	: out std_logic;
		  Dval    : out std_logic;
		  Wreg      : out std_logic
    );
end component;

component output_register is
  port (
    wreg : in std_logic;
    D : in std_logic_vector(3 downTo 0);
    Q : out std_logic_vector(3 downTo 0)
  );
end component;

signal wregx: std_logic;

begin 

T1: output_buffer_control port map(load => load, ack => ack, clk => clk, reset => reset, OBfree => OBfree, Dval => Dval, Wreg => wregx);
T2: output_register port map(wreg => wregx, D => d, Q=> q);

end structural;