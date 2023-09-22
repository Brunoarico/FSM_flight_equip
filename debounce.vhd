LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DeBounce IS
	PORT (
		Clk : IN STD_LOGIC;
		button_in : IN STD_LOGIC;
		pulse_out : OUT STD_LOGIC
	);
END DeBounce;

ARCHITECTURE Behavioral OF DeBounce IS
	CONSTANT COUNT_MAX : INTEGER := 10000;
	CONSTANT BTN_ACTIVE : STD_LOGIC := '0';
	SIGNAL count : INTEGER := 0;
	TYPE STATE_TYPE IS (idle, wait_time); --state machine
	SIGNAL state : state_type := idle;
BEGIN

	PROCESS (Clk)
	BEGIN

		IF (rising_edge(Clk)) THEN
			CASE (state) IS
				WHEN idle =>
					IF (button_in = BTN_ACTIVE) THEN
						state <= wait_time;
					ELSE
						state <= idle;
					END IF;
					pulse_out <= '0';
				WHEN wait_time =>
					IF (count = COUNT_MAX) THEN
						count <= 0;
						IF (button_in = BTN_ACTIVE) THEN
							pulse_out <= '1';
						END IF;
						state <= idle;
					ELSE
						count <= count + 1;
					END IF;
			END CASE;
		END IF;
	END PROCESS;

END ARCHITECTURE Behavioral;