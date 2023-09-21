LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alarm IS
	PORT (
		alarm_A : IN STD_LOGIC;
		alarm_T : IN STD_LOGIC;
		alarm_P : IN STD_LOGIC;
		flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		buzzer : OUT STD_LOGIC
	);
END alarm;

ARCHITECTURE Behavioral OF alarm IS
	SIGNAL alarmFlags : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
	alarmFlags <= alarm_A & alarm_T & alarm_P;
	buzzer <= alarmFlags(0) OR alarmFlags(1) OR alarmFlags(2);
	flags <= alarmFlags;
END Behavioral;