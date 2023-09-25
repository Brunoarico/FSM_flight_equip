LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alarm IS
	PORT (
		CLK : IN STD_LOGIC;
		alarm_A : IN STD_LOGIC;
		alarm_T : IN STD_LOGIC;
		alarm_P : IN STD_LOGIC;
		SEL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		notify : OUT STD_LOGIC
	);
END alarm;

ARCHITECTURE Behavioral OF alarm IS
	CONSTANT COUNT_MAX : INTEGER := 100000000;
	SIGNAL count : INTEGER := 0;
	SIGNAL noti : STD_LOGIC := '0';
	SIGNAL S : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
BEGIN
	PROCESS (CLK)
	BEGIN
		IF rising_edge(CLK) THEN
			count <= count + 1;
			IF count = COUNT_MAX THEN
				count <= 0;
				IF (alarm_A = '1' AND alarm_T = '1' AND alarm_P = '1') THEN
					IF (S = "11") THEN
						S <= "00";
					ELSIF (S = "00") THEN
						S <= "10";
					ELSIF (S = "10") THEN
						S <= "11";
					END IF;
				ELSIF (alarm_T = '1' AND alarm_P = '1') THEN
					IF (S = "00") THEN
						S <= "11";
					ELSE
						S <= "00";
					END IF;
				ELSIF (alarm_P = '1' AND alarm_A = '1') THEN
					IF (S = "11") THEN
						S <= "10";
					ELSE
						S <= "11";
					END IF;
				ELSIF (alarm_A = '1' AND alarm_T = '1') THEN
					IF (S = "00") THEN
						S <= "10";
					ELSE
						S <= "00";
					END IF;
				ELSIF (alarm_A = '1') THEN
					S <= "10";
				ELSIF (alarm_T = '1') THEN
					S <= "00";
				ELSIF (alarm_P = '1') THEN
					S <= "11";
				ELSE
					S <= S;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	notify <= alarm_A OR alarm_T OR alarm_P;
	SEL <= S;
END Behavioral;