LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity LCD_Control is 
	port
	(
		-- Input ports
		CLK 		 : in std_logic;
		Dval 		 : in STD_LOGIC;
		reset     : in std_logic;
		eq15      : in std_logic;
		--SET : in std_logic;
		--EN : IN STD_LOGIC;
	
		-- Output ports
		  clr       : out std_logic;
		  Wrl       : out std_logic;
		  done     : out std_logic
	);
end LCD_Control;

architecture behavioral of LCD_Control is

type STATE_TYPE is (STATE_IDLE, STATE_WRITING_LOW, STATE_DONE);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_IDLE when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, Dval, eq15)

begin

    case CurrentState is
        when STATE_IDLE              => if (Dval = '1') then
                                                        NextState <= STATE_WRITING_LOW;
                                                      else
                                                      NextState <= STATE_IDLE;
                                                    end if;

        when STATE_WRITING_LOW    => if (eq15 = '1') then
																NextState <= STATE_DONE;
																	else 
																		NextState <= STATE_WRITING_LOW;
																end if;
																
		 when STATE_DONE    => NextState <= STATE_IDLE;													

    end case;

end process;

-- GENERATE OUTPUTS
clr <= '1' when (CurrentState = STATE_IDLE) else '0';
Wrl  <= '1' when (CurrentState = STATE_WRITING_LOW) else '0';
done  <= '1' when (CurrentState = STATE_DONE) else '0';

end behavioral;
