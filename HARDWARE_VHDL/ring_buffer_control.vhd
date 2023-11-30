 LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ring_buffer_control is 
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
end ring_buffer_control;

architecture behavioral of ring_buffer_control is

type STATE_TYPE is (STATE_IDLE, STATE_WRITING, STATE_WAIT_SELPG, STATE_WAIT_WR, STATE_WAIT_WREG, STATE_READING,STATE_END);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_IDLE when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, DAV, full, empty,CTS)

begin

    case CurrentState is
        when STATE_IDLE       => if (DAV = '0' and empty = '1') 
																	then
                                                    NextState <= STATE_IDLE;
                                 elsif (DAV = '0' and empty= '0' and CTS = '0')
																	then
                                                      NextState <= STATE_IDLE;
											elsif(DAV = '1' and full = '1' and CTS = '0')
																	then 
																		NextState <= STATE_IDLE;
											elsif(DAV = '0' and empty= '0' and CTS = '1')
																	then 
																		NextState <= STATE_WAIT_WREG;
											elsif(DAV = '1' and full = '1' and CTS = '1')
																	then 
																		NextState <= STATE_WAIT_WREG;
											else 	
																		NextState <= STATE_WAIT_SELPG;
                                                    end if;
																	 
			when STATE_WAIT_SELPG =>   
												NextState <=  STATE_WAIT_WR;
												
			when STATE_WAIT_WR    =>
												NextState <= STATE_WRITING;
												
			when STATE_WRITING    => 
												NextState <= STATE_END;
												
			when STATE_WAIT_WREG  =>
												NextState <= STATE_READING;		
												
			when STATE_READING    => 
												NextState <= STATE_END;

																
		   when STATE_END    => if (DAV = '0') then
																NextState <= STATE_IDLE;
														 else
                                                NextState <= STATE_END;
															end if;													

    end case;

end process;

-- GENERATE OUTPUTS
DAC  <= '1' when (CurrentState = STATE_END) else '0';
SelPG  <= '1' when (CurrentState = STATE_WAIT_SELPG or CurrentState = STATE_WAIT_WR or CurrentState = STATE_WRITING) else '0';
wr  <= '1' when (CurrentState = STATE_WAIT_WR ) else '0';
Wreg <= '1' when (CurrentState = STATE_WAIT_WREG ) else '0';
incPut <= '1' when (CurrentState = STATE_WRITING) else '0';
incGet <= '1' when (CurrentState = STATE_READING) else '0';



end behavioral;