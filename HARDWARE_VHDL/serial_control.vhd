 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity serial_control is 
    port
    (
        -- Input ports
        enRx      : in std_logic;
        accept    : in std_logic;
        eq5       : in std_logic;
		  clk       : in std_logic;
		  reset     : in std_logic;
        --reset    : in std_logic;

        -- Output ports
        clr       : out std_logic;
        wr        : out std_logic;
		  busy      : out std_logic;
		  DXval     : out std_logic
    );
end serial_control;

architecture behavioral of serial_CONTROL is

type STATE_TYPE is (STATE_IDLE, STATE_WRITING, STATE_END,STATE_WAIT);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_IDLE when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, enRx, accept, eq5)

begin

    case CurrentState is
        when STATE_IDLE       => if (enRx = '0') then
                                                    NextState <= STATE_WRITING;
                                                    else
                                                      NextState <= STATE_IDLE;
                                                    end if;

        when STATE_WRITING    => if (enRx = '0') then
																	NextState <= STATE_WRITING;
											elsif(eq5 = '1') then
																	NextState <= STATE_END;
											else 
																	NextState <= STATE_IDLE;
																end if;
																
		 when STATE_END    => 		if (accept = '1') then
																NextState <= STATE_WAIT;
											else
                                                NextState <= STATE_END;
																
																end if;			
		when STATE_WAIT    =>      if (accept = '0') then 
																NextState <= STATE_IDLE;
											else 	
																NextState <= STATE_WAIT;
																end if;

    end case;

end process;

-- GENERATE OUTPUTS
clr <= '1' when (CurrentState = STATE_IDLE) else '0';
wr  <= '1' when (CurrentState = STATE_WRITING) else '0';
DXval  <= '1' when (CurrentState = STATE_END) else '0';
busy <= '1' when (CurrentState = STATE_END) else '0';

end behavioral;
