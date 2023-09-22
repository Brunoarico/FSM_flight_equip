LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY cronometer IS
	PORT (
		CLK : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		HOLD : IN STD_LOGIC;
		tim : OUT INTEGER
	);
END cronometer;

ARCHITECTURE Behavioral OF cronometer IS
	SIGNAL count : INTEGER := 0000;
	SIGNAL countOut : INTEGER := 0000;
	SIGNAL div : INTEGER := 0;
	SIGNAL h : STD_LOGIC := '1';
	SIGNAL reset : STD_LOGIC := '0';
	CONSTANT frequency : INTEGER := 50000000;
BEGIN
	PROCESS (CLK, RST)
	BEGIN
		IF RST = '0' THEN
			reset <= '1';
		ELSE
			reset <= '0';
		END IF;

		IF rising_edge(CLK) THEN
			div <= div + 1;

			IF reset = '1' THEN
				count <= 0;
				div <= 0;
			END IF;

			IF div = frequency THEN
				count <= count + 1;
				div <= 0;
			END IF;

		END IF;
	END PROCESS;

	PROCESS (HOLD)
	BEGIN
		IF rising_edge(HOLD) THEN
			h <= NOT h;
		END IF;

		IF h = '1' THEN
			countOut <= count;
		ELSE
			countOut <= countOut;
		END IF;

	END PROCESS;

	tim <= countOut;
END Behavioral;
