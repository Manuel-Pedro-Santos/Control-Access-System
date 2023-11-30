 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity key_control is 
    port
    (
        -- Input ports
        Kpress     : in std_logic;
        Kack         : in std_logic;
        clk       : in std_logic;
        reset    : in std_logic;

        -- Output ports
        Kscan        : out std_logic;
        Kval        : out std_logic
    );
end key_control;

architecture behavioral of KEY_CONTROL is

type STATE_TYPE is (STATE_STANDBY, STATE_PRESS, STATE_IDLE);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_STANDBY when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, Kpress, Kack)

begin

    case CurrentState is
        when STATE_STANDBY   => if (Kpress = '1') then
                                                      NextState <= STATE_PRESS;
                                else
                                                      NextState <= STATE_STANDBY;
                                                    end if;

        when STATE_PRESS    => if (Kpress = '1') then
																NextState <= STATE_PRESS;
										 elsif(Kack = '0')then
                                                NextState <= STATE_PRESS;
										 else
																NextState <= STATE_IDLE;
																end if;
																
		 when STATE_IDLE    => if (Kack = '1') then
																NextState <= STATE_IDLE;
									  else 					
																NextState <= STATE_STANDBY;
																end if;													

    end case;

end process;

-- GENERATE OUTPUTS
Kscan <= '1' when (CurrentState = STATE_STANDBY and Kpress = '0') else '0';
Kval  <= '1' when (CurrentState = STATE_PRESS) else '0';

end behavioral;
