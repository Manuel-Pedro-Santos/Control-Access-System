LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_KeyScan is 
    port
    (
        -- Input ports
        A1 : in std_logic;
        A2 : in std_logic;
        A3 : in std_logic;
        A4 : in std_logic;
        S0 : in std_logic;
        S1 : in std_logic;

        -- Output ports
        Y : out std_logic
    );
end MUX_KeyScan;

architecture structural of MUX_KeyScan is
begin

Y <= ((NOT S0 AND NOT S1 AND A1) OR (S0 AND NOT S1 AND A2) OR 
        (NOT S0 AND S1 AND A3) OR (S0 AND S1 AND A4));

end structural;