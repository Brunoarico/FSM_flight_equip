LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY conv_Temp IS
	PORT (
		temp8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- temperatura em binário
		temp : OUT INTEGER;
		ALARM : OUT STD_LOGIC
	);
END conv_Temp;

ARCHITECTURE Behavioral OF conv_Temp IS
	CONSTANT inf_lim : INTEGER := 0;
	CONSTANT max_lim : INTEGER := 30;
	SIGNAL t : INTEGER RANGE -40 TO 80;
	SIGNAL AL : STD_LOGIC;
BEGIN
	t <= ((to_integer(unsigned(temp8)) * 120) / 255) - 40;
	AL <= '0' WHEN (t >= inf_lim) AND (t <= max_lim) ELSE
		'1';
	temp <= t;
	ALARM <= AL;
END Behavioral;