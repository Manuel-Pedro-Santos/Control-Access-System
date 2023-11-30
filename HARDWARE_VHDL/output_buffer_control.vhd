 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity output_buffer_control is 
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
end output_buffer_control;

architecture behavioral of output_buffer_control is

type STATE_TYPE is (STATE_IDLE, STATE_WRITING, STATE_WAITING);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_IDLE when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, load, ack)

begin

    case CurrentState is
        when STATE_IDLE       => if (load = '1') 
																	then
																		NextState <= STATE_WRITING;
											else 	
																		NextState <= STATE_IDLE;
                                                    end if;
	     when STATE_WRITING    => if (ack = '1') 
																	then  
																		NextState <=  STATE_WAITING;
											else 	
																		NextState <= STATE_WRITING;
                                                    end if;
		  when STATE_WAITING    =>if (ack = '0') 
																	then  
																		NextState <=  STATE_IDLE;
											else 	
																		NextState <= STATE_WAITING;
                                                    end if;											

    end case;

end process;

-- GENERATE OUTPUTS
OBfree  <= '1' when (CurrentState = STATE_IDLE) else '0';
Dval  <= '1' when (CurrentState = STATE_WRITING) else '0';
Wreg  <= '1' when (CurrentState = STATE_WRITING) else '0';



end behavioral;