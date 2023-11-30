LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Door_Controller is 
	port
	(
		-- Input ports
		CLK 		 : in std_logic;
		Dval 		 : in STD_LOGIC;
		Din       : in std_logic_vector(4 downto 0);
		reset     : in std_logic;
		Sopen     : in std_logic;
		Sclose    : in std_logic;
		Psensor   : in std_logic;
		--eq15      : in std_logic;
		--SET : in std_logic;
		--EN : IN STD_LOGIC;
	
		-- Output ports
		  OnOff       : out std_logic;
        Dout      : out std_logic_vector(4 downto 0);
		  done      : out std_logic
	);
end Door_Controller;

architecture behavioral of Door_Controller is

type STATE_TYPE is (STATE_IDLE, STATE_CLOSING, STATE_OPENING, STATE_DONE, STATE_EMPTY);

signal CurrentState, NextState: STATE_TYPE;

begin

--FLIP-FLOP'S
CurrentState <= STATE_IDLE when reset = '1' else NextState when rising_edge(clk);

--GENERATE NEXT STATE
GenerateNextState:

process (CurrentState, Dval, Din,Sopen, Sclose, Psensor)

begin

    case CurrentState is
        when STATE_IDLE              => if (Dval = '0') then
                                                        NextState <= STATE_IDLE;
                                                      elsif(Din(0) = '0') then 
                                                      NextState <= STATE_CLOSING;
																		else NextState <= STATE_OPENING;
                                                    end if;

        when STATE_OPENING    => if (Sopen = '0') then
																NextState <= STATE_OPENING;
																	elsif(Din(0) = '0') then 
																		NextState <= STATE_EMPTY;
																		else NextState <= STATE_DONE;
																end if; 
																
		when STATE_EMPTY     => if(Psensor = '1') then 
																NextState <= STATE_EMPTY;
																		else NextState <= STATE_CLOSING;
																end if; 
																
																
		when STATE_CLOSING    => if (Psensor = '0' and Sclose = '1') then
																NextState <= STATE_DONE;
										elsif (Psensor = '0' and Sclose = '0') then
																NextState <= STATE_CLOSING;
																	else NextState <= STATE_OPENING;
																end if;													
																
		 when STATE_DONE    => NextState <= STATE_IDLE;													

    end case;

end process;

-- GENERATE OUTPUTS
OnOff <= '1' when (CurrentState = STATE_OPENING or CurrentState = STATE_CLOSING) else '0';
done  <= '1' when (CurrentState = STATE_DONE) else '0';
Dout(4 downto 1) <= Din(4 downto 1);
Dout(0) <= '1' when (CurrentState = STATE_OPENING) else '0';

end behavioral;
