library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DeBounce is
    port(   Clk : in STD_LOGIC;
            button_in : in STD_LOGIC;
            pulse_out : out STD_LOGIC
        );
end DeBounce;

architecture Behavioral of DeBounce is
	constant COUNT_MAX : INTEGER := 100; 
	constant BTN_ACTIVE : STD_LOGIC := '1';
	signal count : INTEGER := 0;
	type STATE_TYPE is (idle,wait_time); --state machine
	signal state : state_type := idle;
begin
  
	process(Clk)
	begin

		if(rising_edge(Clk)) then
			case (state) is
				when idle =>
					if(button_in = BTN_ACTIVE) then  
						state <= wait_time;
					else
						state <= idle; 
					end if;
					pulse_out <= '0';
				when wait_time =>
					if(count = COUNT_MAX) then
						count <= 0;
						if(button_in = BTN_ACTIVE) then
							pulse_out <= '1';
						end if;
						state <= idle;  
					else
						count <= count + 1;
					end if; 
			end case;       
		end if;        
	end process;                  
                                                                                
end architecture Behavioral;
